From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Cygwin: problem with renaming and case
Date: Sat, 22 Mar 2008 14:45:52 +0100 (CET)
Message-ID: <alpine.OSX.1.00.0803221429390.7656@cougar>
References: <47E3DD28.4030302@tiscali.it> <alpine.LFD.1.00.0803211037160.3020@woody.linux-foundation.org> <32541b130803211057h22310557ne605e39e6b894e11@mail.gmail.com> <alpine.LFD.1.00.0803211105190.3020@woody.linux-foundation.org>
 <7vtzizmwd4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Frank <streamlake@tiscali.it>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 22 14:46:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd436-0006MN-AL
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 14:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753807AbYCVNpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 09:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753782AbYCVNpf
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 09:45:35 -0400
Received: from mailer.zib.de ([130.73.108.11]:50675 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753560AbYCVNpe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 09:45:34 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.14.2/8.14.2) with ESMTP id m2MDj3ur010172;
	Sat, 22 Mar 2008 14:45:03 +0100 (CET)
Received: from cougar (brln-4db95e62.pool.einsundeins.de [77.185.94.98])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m2MDixbr018150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 22 Mar 2008 14:45:02 +0100 (MET)
In-Reply-To: <7vtzizmwd4.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (OSX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77805>

On Fri, 21 Mar 2008, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > My personal guess is that it's probably better to start teaching git about 
> > case-broken filesystem, even if we start it with some common special case 
> > rather than getting every case right from the beginning.
> 
> Hmm.  I have to say I am not very enthused by the prospect, as I agree
> with your reasoning in your earlier message why this has been lower
> priority ("sane people when forced to use case corrupting systems avoid
> problematic paths to make this a non-issue anyway").  My feeling is that
> this falls into the "when we are bored to death and have absolutely
> nothing better to do" category.

Sane people might be forced to modify paths in a problematic way more
often than you think.  A common error I see in practice is that
a developer introduces a typo when adding a new header file on
a "case-broken" filesystem.  A typo that only introduces a different
case in the filename and the matching #include statement is
unrecognizable on a "case-broken" filesystem.  The compiler will find
the file regardless of the different case in the include statement.
Only when the source is checked out on a case-sensitive filesystem the
error is recognized and needs to be fixed.  The lucky case is if the
typo is in the #include statement.  The problematic case is if the case
of the filename wrong (violates the coding style of the project).  In
the latter case the file needs to be renamed to a path that only differs
in case, which triggers the problem.

            Steffen
