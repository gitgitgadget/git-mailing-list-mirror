From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] userdiff: allow * between cpp funcname words
Date: Tue, 6 Dec 2011 21:17:56 +0100
Message-ID: <201112062117.57690.trast@student.ethz.ch>
References: <a639d328e15bce3057de9238ee31097d15850de1.1323189110.git.trast@student.ethz.ch> <20111206190217.GD9492@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 06 21:18:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY1Sp-00074T-I8
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 21:18:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753846Ab1LFUSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 15:18:01 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:44215 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753729Ab1LFUSA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 15:18:00 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Dec
 2011 21:17:56 +0100
Received: from thomas.inf.ethz.ch (82.130.78.224) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Dec
 2011 21:17:57 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.3-1-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <20111206190217.GD9492@sigill.intra.peff.net>
X-Originating-IP: [82.130.78.224]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186377>

Jeff King wrote:
> On Tue, Dec 06, 2011 at 05:35:08PM +0100, Thomas Rast wrote:
> 
> > The cpp pattern, used for C and C++, would not match the start of a
> > declaration such as
> > 
> >   static char *prepare_index(int argc,
> > 
> > because it did not allow for * anywhere between the various words that
> > constitute the modifiers, type and function name.  Fix it.
> > 
> > Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> > ---
> > 
> > This is a really sneaky one-character bug that I cannot believe went
> > unnoticed for so long, seeing as there are plenty of instances within
> > git itself where it matters.
> 
> Looks reasonable to me. You can see the difference, for instance, with:
> 
>   git show -U1 3c73a1d
> 
> (The -U1 is because of the annoying "we will start looking for the
> header at the top of context, not the top of changes" behavior I
> mentioned last week).

Actually (sadly) I'll have to revise it.  It doesn't match much of C++
either, and I haven't yet come up with a reasonable regex that
matches, say,

  foo::Bar<int>::t& Baz::operator<<(

which I would call ludicrous, but it's valid C++.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
