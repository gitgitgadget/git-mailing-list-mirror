Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE49AC43217
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 21:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384576AbiDEVrh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573052AbiDERuN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 13:50:13 -0400
Received: from st43p00im-ztdg10073201.me.com (st43p00im-ztdg10073201.me.com [17.58.63.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A25D1111
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 10:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1649180893;
        bh=Rexh88WOZDsqnD9rW7/nR0OKHe2W/XEFsMtvF6Bry3E=;
        h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
        b=IDgOD2YAoFJ0WMQWoX80x8UfnsSGJFodc+42w8Z0ff9ofgxXSa4d15DS8yODL6yXb
         dP0T84VhXvrlDGvSyr7Qgn7H64sPmqw+vWJlYIQzZF+tOUWRMzTafC8AMmWwewMVxC
         sgm2D2S2WZGej/cpp3HUw2cRDD3A423R5Oi7msPMoqfLtY8uPcGE1xLHJFumJ8WI7V
         fb6M/8O95t/PNPFHOAQz+iE+ZsqQNGYgBKGAecRQZ+1po2c27LApKhwp1N7vVuNt1R
         rpvr8adOZgGHrRvqILKiNzWysQ+spWO9PyJYYBCdLTPWt8w8jbOb2+UPWv4Lr7C7Uw
         ehFTL1uoFx5/g==
Received: from max-mbp-1449.fritz.box (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
        by st43p00im-ztdg10073201.me.com (Postfix) with ESMTPS id 1D9A89A07E1
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 17:48:12 +0000 (UTC)
From:   Maximilian Reichel <reichemn@icloud.com>
Content-Type: multipart/mixed;
        boundary="Apple-Mail=_F5BF5684-111C-48EE-836F-F90A1AE71F19"
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: file loss by git stash push --staged --keep-index
Message-Id: <111D7753-AE53-4906-A7AF-F39EA7455CA3@icloud.com>
Date:   Tue, 5 Apr 2022 19:48:11 +0200
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.21)
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 clxscore=1015
 spamscore=0 mlxscore=0 bulkscore=0 mlxlogscore=925 phishscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2204050100
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_F5BF5684-111C-48EE-836F-F90A1AE71F19
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
Running the following script:
```
#!/bin/bash
git init workDir
cd workDir
git commit -m first --allow-empty
echo b > b
git add b
GIT_TRACE=TRUE git stash push --staged --keep-index
git stash pop
cat b
```

What did you expect to happen? (Expected behavior)
I expect file `b` to be present after running the script.
If I run the script with only `git stash push --staged` or 
`git stash push --keep-index`, the file is present afterward.

What happened instead? (Actual behavior)
The file is not present after running the script.
`cat b` will report that the file does not exist.
--Apple-Mail=_F5BF5684-111C-48EE-836F-F90A1AE71F19
Content-Disposition: attachment;
	filename=output--staged.txt
Content-Type: text/plain;
	x-unix-mode=0644;
	name="output--staged.txt"
Content-Transfer-Encoding: quoted-printable

Initialized empty Git repository in /test/workDir/.git/
[master (root-commit) 5ebd5d0] first
17:28:10.379881 git.c:459               trace: built-in: git stash push =
--staged
17:28:10.381318 run-command.c:654       trace: run_command: git =
diff-tree -p -U1 HEAD 6be660545b31f61a82a87d2b1915f0b88bb9f16f --
17:28:10.382374 git.c:459               trace: built-in: git diff-tree =
-p -U1 HEAD 6be660545b31f61a82a87d2b1915f0b88bb9f16f --
17:28:10.383488 run-command.c:654       trace: run_command: git apply -R
Saved working directory and index state WIP on master: 5ebd5d0 first
17:28:10.384517 git.c:459               trace: built-in: git apply -R
17:28:10.384942 run-command.c:654       trace: run_command: git reset -q =
--refresh --
17:28:10.386018 git.c:459               trace: built-in: git reset -q =
--refresh --
On branch master
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
	new file:   b

Dropped refs/stash@{0} (546ccd88cdcd416cd0bfa5b0c63600b64011da53)
b

--Apple-Mail=_F5BF5684-111C-48EE-836F-F90A1AE71F19
Content-Disposition: attachment;
	filename=output--keep-index.txt
Content-Type: text/plain;
	x-unix-mode=0644;
	name="output--keep-index.txt"
Content-Transfer-Encoding: quoted-printable

Initialized empty Git repository in /test/workDir/.git/
[master (root-commit) e972d48] first
17:26:07.021096 git.c:459               trace: built-in: git stash push =
--keep-index
17:26:07.022721 run-command.c:654       trace: run_command: =
GIT_INDEX_FILE=3D.git/index.stash.101 git update-index =
--ignore-skip-worktree-entries -z --add --remove --stdin
17:26:07.023845 git.c:459               trace: built-in: git =
update-index --ignore-skip-worktree-entries -z --add --remove --stdin
17:26:07.024747 run-command.c:654       trace: run_command: git reset =
--hard -q --no-recurse-submodules
Saved working directory and index state WIP on master: e972d48 first
17:26:07.025846 git.c:459               trace: built-in: git reset =
--hard -q --no-recurse-submodules
17:26:07.026947 run-command.c:654       trace: run_command: git checkout =
--no-overlay 6be660545b31f61a82a87d2b1915f0b88bb9f16f -- :/
17:26:07.028043 git.c:459               trace: built-in: git checkout =
--no-overlay 6be660545b31f61a82a87d2b1915f0b88bb9f16f -- :/
On branch master
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
	new file:   b

Dropped refs/stash@{0} (3ed20e369087861f1dd3089342a656217e537d34)
b

--Apple-Mail=_F5BF5684-111C-48EE-836F-F90A1AE71F19
Content-Disposition: attachment;
	filename=output--keep-index--staged.txt
Content-Type: text/plain;
	x-unix-mode=0644;
	name="output--keep-index--staged.txt"
Content-Transfer-Encoding: quoted-printable

Initialized empty Git repository in /test/workDir/.git/
[master (root-commit) b3f6a1b] first
17:26:28.802913 git.c:459               trace: built-in: git stash push =
--keep-index --staged
17:26:28.804521 run-command.c:654       trace: run_command: git =
diff-tree -p -U1 HEAD 6be660545b31f61a82a87d2b1915f0b88bb9f16f --
17:26:28.805602 git.c:459               trace: built-in: git diff-tree =
-p -U1 HEAD 6be660545b31f61a82a87d2b1915f0b88bb9f16f --
17:26:28.806705 run-command.c:654       trace: run_command: git apply -R
Saved working directory and index state WIP on master: b3f6a1b first
17:26:28.807796 git.c:459               trace: built-in: git apply -R
On branch master
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
	new file:   b

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	deleted:    b

Dropped refs/stash@{0} (0314f565bf7ae2738cece5d41045fd4dcf32aac2)
cat: b: No such file or directory

--Apple-Mail=_F5BF5684-111C-48EE-836F-F90A1AE71F19
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii


`git status` reports a staged change with the created file and 
an unstaged change that the file is deleted.

What's different between what you expected and what actually happened?
git stash pop does not recreate the file when stashing with
`--staged` and `--keep-index`.

Anything else you want to add:
I got the same behavior on git 2.35.1 and the latest master.
I attached to output of the script for all three variants:
stash push with `--staged --keep-index`, `--staged` and `--keep-index`.

[System Info]
git version:
git version 2.36.0.rc0
cpu: x86_64
built from commit: faa21c10d44184f616d391c158dcbb13b9c72ef3
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.10.25-linuxkit #1 SMP Tue Mar 23 09:27:39 UTC 2021 x86_64
compiler info: gnuc: 10.2
libc info: glibc: 2.31
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]
not run from a git repository - no hooks to show


--Apple-Mail=_F5BF5684-111C-48EE-836F-F90A1AE71F19--
