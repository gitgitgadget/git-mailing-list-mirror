From: =?ISO-8859-1?B?R+Fib3IgTGlwdOFr?= <gabor.liptak@gmail.com>
Subject: Re: Fwd: Git Directory Diff for submodule
Date: Mon, 10 Feb 2014 08:33:27 +0100
Message-ID: <CAN-m_UnSqTnLydyVF2TLxOia9vzmQr9e4+xWh8aVNBosfCq5nA@mail.gmail.com>
References: <CAN-m_UmNudmxJnA95h1nYqi7GGxtzKqqpgFHmJZ+MTnxRoEd6g@mail.gmail.com>
	<CAN-m_UnQ7Yzuq7n6mxmsd3XcfLSVxMdnLiGFDiN1Ph3ZiFqwew@mail.gmail.com>
	<CAN-m_U=eYSEXfVBcD1Rfx-YvGx5Wu+hB2uAc=6xX_HO7bS0FUg@mail.gmail.com>
	<52F54441.6090209@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 10 08:33:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WClMz-0002kH-N0
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 08:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429AbaBJHda convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Feb 2014 02:33:30 -0500
Received: from mail-vc0-f178.google.com ([209.85.220.178]:60083 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419AbaBJHd2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Feb 2014 02:33:28 -0500
Received: by mail-vc0-f178.google.com with SMTP id ik5so4466301vcb.37
        for <git@vger.kernel.org>; Sun, 09 Feb 2014 23:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=+itVpRgq0181bLCSDSgiE/fSyGd+DvGOX/4Twk2n70g=;
        b=DQPV9cXrIZkeg0gr8r/9dv4HPu51TmJHLpDT5nfOSXmX7cOuxZxLks8TuhHpkK4J+J
         6aat5SsmfBUCg17OWSoDMX9dwrreLlndbS7jSQgGDH7tM+eXpid+Xu1MOvdKAldr522L
         wD9s77d4ZeA9yGnw/cjej7tOCBeH7By9lYvCFO9Zvi/sU3rbpoRIUFuRcrVBrYT6d3Xf
         z/2/oP4ayzZedrqvVKKiFlumFblu41ftMYByNdefIv0mQCJ55XwdQScQz29QshxqN2VT
         Nxk2b/VjdXuXKxS/l/pvxOIszjRCK0bdUla78zW0Jf4hm5ZQ8SmahuYeWcGtzpu26zuG
         SRPA==
X-Received: by 10.52.164.39 with SMTP id yn7mr4392132vdb.25.1392017607812;
 Sun, 09 Feb 2014 23:33:27 -0800 (PST)
Received: by 10.58.186.232 with HTTP; Sun, 9 Feb 2014 23:33:27 -0800 (PST)
In-Reply-To: <52F54441.6090209@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241905>

Hi Jens,

So "git status" says:

liptak@liptak-kubuntu:~/Projects/MAIN_MODULE/platform/SUBMODULE
[master]$ git status
# On branch master
# Your branch is up-to-date with 'origin/master'.
#
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working
directory)
#
#       modified:   xxxxxx.java
#       modified:   xxxxxxx.java
# ...
# ...
# ...
# ...
# ...
#
no changes added to commit (use "git add" and/or "git commit -a")

git config core.worktree gives back: "../../../../platform/SUBMODULE"

The submodule was inited simply with "git submodule init" +
"git.submodule update"

MAINMODULE/.gitsubmodules file contains similar entry:
[submodule "platform/SUBMODULE"]
path =3D platform/SUBMODULE
url =3D ssh://git@somehost/foo/bar.git

MAINMODULE/.git/config:
[submodule "platform/SUBMODULE"]
url =3D ssh://git@somehost/foo/bar.git

MAINMODULE/platform/SUBMODULE/.git:
gitdir: ../../.git/modules/platform/SUBMODULE

MAINMODULE/.git/modules/platform/SUBMODULE/config:
[core]
repositoryformatversion =3D 0
filemode =3D true
bare =3D false
logallrefupdates =3D true
worktree =3D ../../../../platform/SUBMODULE
[remote "origin"]
url =3D ssh://git@somehost/foo/bar.git
fetch =3D +refs/heads/*:refs/remotes/origin/*

So for me it seems that somehow the relative path inside
MAINMODULE/.git/modules/platform/SUBMODULE/config gets configuread
wrong during submodule init+update.

I tried to update the
MAINMODULE/.git/modules/platform/SUBMODULE/config to contain
=2E./../platform/SUBMODULE as worktree path, then meld was correctly
started, but the compare tree was not usable. For file changes it
displayed always: XXXXX.java: Dangling symlink. So this is still not a
complete solution somehow.

Regards,

G=E1bor Lipt=E1k

2014-02-07 Jens Lehmann <Jens.Lehmann@web.de>:
> Am 07.02.2014 10:15, schrieb G=E1bor Lipt=E1k:
>> I think I have found a bug related to submodules and directory diff.
>> See the details at hXXp://stackoverflow.com/q/21623155/337621.
>
> Let's inline the recipe one finds after decrypting this link:
>
> ~/Projects/MAINMODULE/platform/SUBMODULE [master]$ git difftool -tool=
=3Dmeld --dir-diff --cached
>   fatal: Could not switch to '../../../../platform/': No such file or=
 directory
>   diff --raw --no-abbrev -z --cached: command returned error: 128
> ~/Projects/MAINMODULE/platform/SUBMODULE [master]$ cd ..
> ~/Projects/MAINMODULE/platform [master]$ cd ..
> ~/Projects/MAINMODULE [master]$ git difftool -tool=3Dmeld --dir-diff =
--cached
>   // NO PROBLEM, works.
> ~/Projects/MAINMODULE [master]$ git version
>   git version 1.8.4
>
>
>> If you need any further details, just ask.
>
> - Does this only happen when you use difftool? E.g. what does
>   "git status" inside the submodule say?
>
> - What does "git config core.worktree" print when run in the
>   submodule?
