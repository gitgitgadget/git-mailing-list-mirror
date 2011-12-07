From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] userdiff: allow * between cpp funcname words
Date: Wed, 7 Dec 2011 09:04:27 +0100
Message-ID: <201112070904.28212.trast@student.ethz.ch>
References: <a639d328e15bce3057de9238ee31097d15850de1.1323189110.git.trast@student.ethz.ch> <201112062117.57690.trast@student.ethz.ch> <7vfwgxflkv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 09:04:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYCUX-0005Gw-Cg
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 09:04:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003Ab1LGIEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 03:04:32 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:3983 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751464Ab1LGIEb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 03:04:31 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 7 Dec
 2011 09:04:28 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 7 Dec
 2011 09:04:29 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.3-1-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <7vfwgxflkv.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186439>

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> 
> > Actually (sadly) I'll have to revise it.  It doesn't match much of C++
> > either, and I haven't yet come up with a reasonable regex that
> > matches, say,
> >
> >   foo::Bar<int>::t& Baz::operator<<(
> >
> > which I would call ludicrous, but it's valid C++.
> 
> Heh, I'd rather not see us go that route, which would either end up
> implementing a C++ parser or reverting the heuristics back to "non-blank
> at the beginning of the line" that was already reasonably useful.

Well, there are many things that we deliberately do not match right
now and for which that's a good thing:

  label:
  public:
  void declaration_only(...);
  int global_variable;

At some point I was wondering whether it would be better to just
declare a non-match for '.*;' and '^[A-Za-z_][A-Za-z_0-9]+:', and
otherwise match all '^[A-Za-z].*\(' but I may be missing something.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
