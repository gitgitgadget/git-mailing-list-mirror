From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: DWIM "git checkout frotz" to "git checkout -b frotz origin/frotz"
Date: Sun, 06 Jun 2010 18:18:56 +0200
Message-ID: <vpqljas5e33.fsf@bauges.imag.fr>
References: <20100605110930.GA10526@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Peter Rabbitson <ribasushi@cpan.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Jun 06 18:22:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLIc2-0002kd-JG
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 18:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757997Ab0FFQWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 12:22:08 -0400
Received: from imag.imag.fr ([129.88.30.1]:64869 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756055Ab0FFQWH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 12:22:07 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o56GIvWS015465
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 6 Jun 2010 18:18:57 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OLIYr-0001yc-44; Sun, 06 Jun 2010 18:18:57 +0200
In-Reply-To: <20100605110930.GA10526@localhost> (Clemens Buchacher's message of "Sat\, 5 Jun 2010 13\:09\:30 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 06 Jun 2010 18:18:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148524>

Clemens Buchacher <drizzd@aon.at> writes:

> Hi,
>
> Peter and I just stumbled on the following interpretations of the
> checkout command.
>
>  git checkout origin/frotz      -> detaches HEAD
>  git checkout -t origin/frotz   -> git checkout -b frotz origin/frotz
>  git checkout frotz             -> git checkout -b frotz origin/frotz
>  git checkout -t frotz          -> fatal: Missing branch name
>
> I was surprised by the third one, which I was expecting to fail.
> Apparently it's a DWIM feature introduced in commit 70c9ac2f. I
> doubt that is what the user was trying to do if they ran that
> command. If anything, this behavior will serve to confuse them.

As already mentionned, it's obviously a bit late to revert the commit
which itroduced this DWIM. I tend to agree that this is confusing, but
still, this is very often what the user actually wanted. The original
patch was to sugest the user the appropriate command, and I find the
motivating example rather convincing:

http://thread.gmane.org/gmane.comp.version-control.git/129587

$ git clone git://git.kernel.org/pub/scm/git/git.git
$ cd git
$ git checkout next
error: pathspec 'next' did not match any file(s) known to git.
To create a local branch from the same named remote branch, use
  git checkout -b next origin/next

The newbie does not immediately understand the difference between
local and remote branches, he's been told about the branch "next", and
wants to check it out.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
