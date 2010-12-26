From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Add support for -p/--patch to git-commit
Date: Sun, 26 Dec 2010 17:30:21 +0100
Message-ID: <vpqr5d4cx9e.fsf@bauges.imag.fr>
References: <E1PWsuV-0000FH-90@scarlatti.dunvegan.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Conrad Irwin <conrad.irwin@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 26 17:30:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWtUV-0004RL-6H
	for gcvg-git-2@lo.gmane.org; Sun, 26 Dec 2010 17:30:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332Ab0LZQa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Dec 2010 11:30:27 -0500
Received: from mx2.imag.fr ([129.88.30.17]:37730 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752323Ab0LZQa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Dec 2010 11:30:26 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id oBQGUKLG029291
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 26 Dec 2010 17:30:20 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PWtUD-0004hx-HU; Sun, 26 Dec 2010 17:30:21 +0100
In-Reply-To: <E1PWsuV-0000FH-90@scarlatti.dunvegan.biz> (Conrad Irwin's message of "Sun\, 26 Dec 2010 15\:36\:34 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 26 Dec 2010 17:30:20 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: oBQGUKLG029291
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1293985822.24451@KMonvhw831/zkdPkPZB25A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164194>

Conrad Irwin <conrad.irwin@gmail.com> writes:

> Hello Git,
>
> Please let me know of any mistakes I've made, this is a first for
> me.

At least one mistake:

To: unlisted-recipients:; (no To-header on input)

(I guess you've Bcc-ed the Git list, please don't do that)

> While this patch works as advertised, I wonder if it would be nicer to
> change the behaviour of git commit --interactive and git commit -p to
> act on a temporary copy of the index rather than mutating the existing
> index. I've no idea how to go about that yet, but is it something that
> should be changed?

I don't think so. After a commit, I usually expect the index to be
clean, ready to start preparing the next commit (except if I
explicitely asked the opposite), which implies that the index used for
commit (-i|-p) is the same as the usual one.

> +5. by using the --interactive or --patch switches with the 'commit' command
> +   to decide one by one which files or hunks should be part of the commit,
> +   before finalizing the operation.  Currently, this is done by invoking
> +   'git add --interactive'.

... or git add --patch.

> -	if (!!also + !!only + !!all + !!interactive > 1)
> -		die("Only one of --include/--only/--all/--interactive can be used.");
> +	if (!!also + !!only + !!all + !!interactive + !!patch_interactive > 1)
> +		die("Only one of --include/--only/--all/--interactive/--patch can be used.");

If I read correctly, this forbids "git commit --interactive --patch",
while "git add --interactive --patch" is allowed, and equivalent to
"--patch" alone.

Other than that, the patch looks good.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
