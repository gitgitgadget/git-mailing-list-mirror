From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: More Beginning Git Questions
Date: Fri, 23 Sep 2011 18:11:51 +0200
Message-ID: <vpq62kjw854.fsf@bauges.imag.fr>
References: <4E7C9AAD.7060209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Jon Forrest <nobozo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 18:12:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R78M8-0003qK-1N
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 18:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959Ab1IWQL7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Sep 2011 12:11:59 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58126 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750930Ab1IWQL6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2011 12:11:58 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p8NG9srR002532
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 23 Sep 2011 18:09:54 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1R78Lv-0000ra-9p; Fri, 23 Sep 2011 18:11:51 +0200
In-Reply-To: <4E7C9AAD.7060209@gmail.com> (Jon Forrest's message of "Fri, 23
	Sep 2011 07:41:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 23 Sep 2011 18:09:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p8NG9srR002532
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1317398999.36015@bXER8pFEeQnJYFRlEynVUA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181974>

Jon Forrest <nobozo@gmail.com> writes:

> "If Bob=E2=80=99s work conflicts with what Alice did since their hist=
ories forked,"
>
> Does this include both changes that Alice has checked in to
> her repository and uncommitted changes in her working tree?

Git will not allow you to do a "git pull" if your uncommited changes
touch the same files as the pull. So, you basically can't have conflict=
s
about uncommited changes with "git pull".

That's by design: solving conflicts can be hard, and you want the "last
commit" safety net while doing it. If you mess up your conflict
resolution, you can still "git reset --merge" and try again.

> "Alice will use her working tree and the index to resolve conflicts,"
>
> How does Alice use her working tree and index? Does this mean
> she makes changes to her working tree so that the conflicts
> no longer exist?

Yes.

> How does the index play a part in this?

Once the conflict is fixed in the working tree, you run "git add" to
mark the conflict as resolved.

And before this, the index contains half-merged versions of your file,
and "git diff" can show you the difference between them and your
worktree. See the user manual :

http://schacon.github.com/git/user-manual.html#resolving-a-merge

(BTW, that's not the official place for Git documentation, but since
kernel.org is down now ...)

> "and existing local changes will interfere with the conflict
> resolution process"

Probably this should have been "would have interfered" (and therefore
are forbidden by Git, as the following sentence says):

> "(git will still perform the fetch but will refuse to merge
> --- Alice will have to get rid of her local changes in
> some way and pull again when this happens)."

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
