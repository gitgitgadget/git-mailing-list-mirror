From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: suggested feature: someone mails me a blob, git please tell me what it is
Date: Fri, 16 Feb 2007 18:14:51 +0100
Message-ID: <vpqr6sq58j8.fsf@olympe.imag.fr>
References: <3c6c07c20702160823j316c52f4pe4cf5ca8a882e194@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 16 18:15:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI6gG-0000yw-5z
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 18:15:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946013AbXBPRPY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 12:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946014AbXBPRPY
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 12:15:24 -0500
Received: from imag.imag.fr ([129.88.30.1]:37569 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946013AbXBPRPV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 12:15:21 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l1GHEp9G021286
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 16 Feb 2007 18:14:51 +0100 (CET)
Received: from olympe.imag.fr ([129.88.43.60])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HI6fb-00053z-Gz
	for git@vger.kernel.org; Fri, 16 Feb 2007 18:14:51 +0100
Received: from moy by olympe.imag.fr with local (Exim 4.50)
	id 1HI6fb-0001Qe-ER
	for git@vger.kernel.org; Fri, 16 Feb 2007 18:14:51 +0100
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <3c6c07c20702160823j316c52f4pe4cf5ca8a882e194@mail.gmail.com> (Mike Coleman's message of "Fri\, 16 Feb 2007 10\:23\:40 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 16 Feb 2007 18:14:51 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39932>

"Mike Coleman" <tutufan@gmail.com> writes:

> It seems like it should be fairly easy, given a blob (the file), for
> git to describe what it knows about it.  For example, it could provide
> a list of commits that it's a part of, etc.  It'd be *really* nice if
> only the output of the sha1sum command on the blob were needed. 

"git cat-file -p" does almost this : given the sha1sum for a blob, it
will give the header and the content of the blob ...

> (I can't recall exactly how git's blob SHA1's are computed--maybe
> this isn't feasible.)

... but this is where it doesn't work :
http://www.kernel.org/pub/software/scm/git/docs/v1.5.0/git.html#Discussion
explains that the sha1sum used by git is the one of the blob _plus_
its header, so it's not the one you get with "sha1sum file".

But it should be possible to recompute the git sha1sum by recomputing
the magic formula sha1sum(<ascii type without space> + <space> +
<ascii decimal size> + <byte\0> + <binary object data>).

-- 
Matthieu
