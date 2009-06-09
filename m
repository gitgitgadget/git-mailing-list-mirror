From: Alexander Gladysh <agladysh@gmail.com>
Subject: Re: Troubles when directory is replaced by symlink
Date: Tue, 9 Jun 2009 12:18:16 +0400
Message-ID: <c6c947f60906090118n78d3c40fq11d1390f8776c2c0@mail.gmail.com>
References: <c6c947f60906042243v2e36251dn9a46343cf6b8a2f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 10:18:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDwXL-0000PN-Fm
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 10:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757606AbZFIISS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2009 04:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755065AbZFIISR
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 04:18:17 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:58182 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756807AbZFIISP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 04:18:15 -0400
Received: by bwz9 with SMTP id 9so3619546bwz.37
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 01:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=8D9PhZMhvov/wm1ASvMigmWLfu7CU25nkQp9VUloUrY=;
        b=mmsFI9mgT2Wv8MaLueCJnNRIwB5Ba0RhnGhgUs9sqR2NGtXsEEuHgexV2f7SWqNvFi
         15RcLECdqylfHfVO+4+4NICCr27BPTSa64S9l5njXfFRNl4fNRdGYEE/P1SwVB0tl2NV
         wXuB/UlBBthN/bgcy2kPOQe8++JUgPlVTuSDc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=FKdrQw8IdVAa0Dy79cW2xGoWluUi0ryHoCWx61Ak+6oN8DGxJHQJU0Dt7p731bvTBL
         M8Wy4z8IfwiShvRSVLmfoaSO5E+Ts9QMMtQ9Xe+r3Xn4/Ggn2ONAG2PVE/c2I4x8nkBB
         mwuXW2P+amPQrEzJ4mEX5X+svSHSy+nQx7cNE=
Received: by 10.223.126.1 with SMTP id a1mr4875807fas.52.1244535496422; Tue, 
	09 Jun 2009 01:18:16 -0700 (PDT)
In-Reply-To: <c6c947f60906042243v2e36251dn9a46343cf6b8a2f4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121152>

Any help here? This bug is pretty annoying (especially that it
requires double hard resets).

Should I provide any extra information?

Alexander.

On Fri, Jun 5, 2009 at 9:43 AM, Alexander Gladysh<agladysh@gmail.com> w=
rote:
> Hi, list!
>
> OS X 10.5.7
>
> $ git --version
> git version 1.6.3.2
>
> In my master branch I've had this structure:
>
> root /
> =A0 =A0directory1 /
> =A0 =A0 =A0 =A0some-files
> =A0 =A0directory2 /
> =A0 =A0 =A0 =A0copy-of-directory1 /
> =A0 =A0 =A0 =A0 =A0 =A0some-files
>
> In a separate branch I replaced copy-of-directory1 with a symlink to
> ../directory1. I did it in two commits: first remove
> copy-of-directory1, in second commit -- create the symlink.
>
> My master branch is then moved by couple commits ahead.
>
> Now I have nasty problems when I try to merge that separate branch
> back to master (see log below).
>
> If I split the branch history in two, and first merge up to commit
> with deletion, and then separately merge the rest of it with symlink
> creation -- all goes well.
>
> Below is the log on how to reproduce the problem:
>
> Alexander.
>
> $ mkdir test
> $ cd test
> $ git init
> Initialized empty Git repository in /users/agladysh/tmp/test/.git/
> $ mkdir alpha
> $ echo "file1" > alpha/file1
> $ git add .
> $ git commit -m "first commit"
> [master (root-commit) 1df90a8] first commit
> =A01 files changed, 1 insertions(+), 0 deletions(-)
> =A0create mode 100644 alpha/file1
>
> $ mkdir beta
> $ cp -R alpha beta/
> $ git add .
> $ git commit -m "second commit"
> [master 0eddb98] second commit
> =A01 files changed, 1 insertions(+), 0 deletions(-)
> =A0create mode 100644 beta/alpha/file1
>
> $ git checkout -b branch
> Switched to a new branch 'branch'
> $ rm -rf beta/alpha
> $ git add -u
> $ git commit -m "deleted"
> [branch 34134ea] deleted
> =A01 files changed, 0 insertions(+), 1 deletions(-)
> =A0delete mode 100644 beta/alpha/file1
>
> $ cd beta/
> $ ln -s ../alpha
> $ cd ..
> $ git add .
> $ git commit -m "symlink"
> [branch b8dfba0] symlink
> =A01 files changed, 1 insertions(+), 0 deletions(-)
> =A0create mode 120000 beta/alpha
>
> $ git checkout master
> Switched to branch 'master'
>
> ### All works if we're just fast-forwarding ###
>
> $ git branch backup
> $ git merge branch
> Updating 0eddb98..b8dfba0
> Fast forward
> =A0beta/alpha =A0 =A0 =A0 | =A0 =A01 +
> =A0beta/alpha/file1 | =A0 =A01 -
> =A02 files changed, 1 insertions(+), 1 deletions(-)
> =A0create mode 120000 beta/alpha
> =A0delete mode 100644 beta/alpha/file1
>
> ### Trying to restore to backup
> $ git reset --hard backup
> error: Invalid path ''
> HEAD is now at 0eddb98 second commit
> $ git status
> # On branch master
> # Changed but not updated:
> # =A0 (use "git add/rm <file>..." to update what will be committed)
> # =A0 (use "git checkout -- <file>..." to discard changes in working =
directory)
> #
> # =A0 =A0 =A0 deleted: =A0 =A0alpha/file1
> #
> no changes added to commit (use "git add" and/or "git commit -a")
>
> ### Needed second reset --hard.
>
> $ git reset --hard
> HEAD is now at 0eddb98 second commit
>
> $ git status
> # On branch master
> nothing to commit (working directory clean)
>
> ### We're back to original master now
>
> $ echo "change" >> alpha/file1
> $ git commit -a -m "third commit"
> [master 0f64b88] third commit
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> ### Here it goes
>
> $ git merge branch
> CONFLICT (directory/file): There is a directory with name beta/alpha
> in HEAD. Adding beta/alpha as beta/alpha~branch
> Removing beta/alpha/file1
> Automatic merge failed; fix conflicts and then commit the result.
> [4168][agladysh.agmac: test]$ git status
> beta/alpha: needs merge
> # On branch master
> # Changes to be committed:
> # =A0 (use "git reset HEAD <file>..." to unstage)
> #
> # =A0 =A0 =A0 deleted: =A0 =A0beta/alpha/file1
> #
> # Changed but not updated:
> # =A0 (use "git add <file>..." to update what will be committed)
> # =A0 (use "git checkout -- <file>..." to discard changes in working =
directory)
> #
> # =A0 =A0 =A0 unmerged: =A0 beta/alpha
> #
> # Untracked files:
> # =A0 (use "git add <file>..." to include in what will be committed)
> #
> # =A0 =A0 =A0 beta/alpha~branch
> $ git mergetool
> Merging the files: beta/alpha
>
> mv: rename beta/alpha to ./beta/alpha.BACKUP.55777: No such file or d=
irectory
> cp: ./beta/alpha.BACKUP.55777: No such file or directory
> Deleted merge conflict for 'beta/alpha':
> =A0{local}: deleted
> =A0{remote}: a symbolic link -> '../alpha'
> Use (c)reated or (d)eleted file, or (a)bort? c
> fatal: beta/alpha: unable to stat (No such file or directory)
> mv: rename ./beta/alpha.BACKUP.55777 to beta/alpha.orig: No such file
> or directory
>
