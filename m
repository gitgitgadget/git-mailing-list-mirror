From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Puzzled by a t9500 test failure
Date: Mon, 13 Oct 2008 16:48:51 -0700
Message-ID: <20081013234851.GY4856@spearce.org>
References: <7vljws83nd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 01:50:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpXAp-000242-WC
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 01:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757809AbYJMXsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 19:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757810AbYJMXsw
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 19:48:52 -0400
Received: from george.spearce.org ([209.20.77.23]:54249 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757695AbYJMXsw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 19:48:52 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 5F18B3835F; Mon, 13 Oct 2008 23:48:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vljws83nd.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98165>

Junio C Hamano <gitster@pobox.com> wrote:
> With recent tip of 'master':
> 
>     $ make
>     $ mkdir t/trash
>     $ cd t && sh t9500-*.sh -i
> 
> fails at the very first test.  Can anybody figure out why?

Hmmph.  Near as I can tell its because gitweb.log has this in it:

$ cat gitweb.log
[Mon Oct 13 23:43:36 2008] gitweb.perl: Use of uninitialized value in scalar chomp at /home/sop/local/maint-git/t/../gitweb/gitweb.perl line 1811.
[Mon Oct 13 23:43:36 2008] gitweb.perl: Use of uninitialized value in addition (+) at /home/sop/local/maint-git/t/../gitweb/gitweb.perl line 3772.
HASH..

The test does a grep for '[[]' and if it matches, fails.  I'm not
sure why this started showing up now.  Obviously I merged something
that failed the test suite, but I was pretty sure I had run the full
set before publishing anything.

-- 
Shawn.
