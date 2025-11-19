Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE6A36E561
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567934; cv=none; b=HCsSGZ3hBF78++4QWYSCR/4kGS3I+fr/XvplPoZ5NwxYJzw7+3+lFrTdaDtQ26JXeu6LwjKxD2y330DdyhJgYvHIRg0o+Jz/rOZQjs+R08sDcIUTp8F7PvbDcLMxtHScbQOVDUG82xlbEN3zGxpUZaxmwzzgCJihgFnG7K9NDqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567934; c=relaxed/simple;
	bh=DTbTFwsIqqeOBjkw66ut83Z6XsuAKY5CqlSxw/S39sU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WVX4r/XFBy8CLvUwib6sQOxtrg6PPLcrV9WDxESQ0QHEe0J8KEP7CTk26VUDvhxVeHvB7hujTLCCE5uS5ukb6k2JyAGJ4seb0y3PBoS6Drtu58BoB0z5TDqcem09/58uUfnnbcsdlWxSApgkR6+9oIFxSMPo3iannto5fQ4EXk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 5AJFoco61821036
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 15:50:39 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <git@vger.kernel.org>
Subject: [BUG] Test Failure 2.52.0, t8020.16,19
Date: Wed, 19 Nov 2025 10:50:33 -0500
Organization: Nexbridge Inc.
Message-ID: <003901dc596c$40bfbd80$c23f3880$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AdxZa79aSNmRsmecRrO9TMkXRK2Bhw==
X-Antivirus: Norton (VPS 251119-2, 11/19/2025), Outbound message
X-Antivirus-Status: Clean

The following two failures appeared on NonStop for the actual release. I did
not see them in -rc0 or after (doesn't mean they didn't happen after rc0).
To my eyes, this looks like a real issue not just on NonStop. It is 100%
reproducible and is not transient. The build is with OpenSSL 3.4, but that
should not matter.

expecting success of 8020.16 'cross merge boundaries in blaming':
        git checkout HEAD^0 &&
        git rm -rf . &&
        test_commit m1 &&
        git checkout HEAD^ &&
        git rm -rf . &&
        test_commit m2 &&
        git merge m1 &&
        check_last_modified <<-\EOF
        m2 m2.t
        m1 m1.t
        EOF

++ git checkout 'HEAD^0'
Note: switching to 'HEAD^0'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by switching back to a branch.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -c with the switch command. Example:

  git switch -c <new-branch-name>

Or undo this operation with:

  git switch -

Turn off this advice by setting config variable advice.detachedHead to false

HEAD is now at 08525b6 remove a
++ git rm -rf .
rm 'file'
++ test_commit m1
++ local notick=
++ local echo=echo
++ local append=
++ local author=
++ local signoff=
++ local indir=
++ local tag=light
++ test 1 '!=' 0
++ case "$1" in
++ break
++ indir=
++ local file=m1.t
++ test -n ''
++ echo m1
++ git add -- m1.t
++ test -z ''
++ test_tick
++ test -z set
++ test_tick=1112912173
++ GIT_COMMITTER_DATE='1112912173 -0700'
++ GIT_AUTHOR_DATE='1112912173 -0700'
++ export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
++ git commit -m m1
[detached HEAD 53e7187] m1
 Author: A U Thor <author@example.com>
 2 files changed, 1 insertion(+), 1 deletion(-)
 delete mode 100644 file
 create mode 100644 m1.t
++ case "$tag" in
++ git tag m1
++ git checkout 'HEAD^'
Previous HEAD position was 53e7187 m1
HEAD is now at 08525b6 remove a
++ git rm -rf .
rm 'file'
++ test_commit m2
++ local notick=
++ local echo=echo
++ local append=
++ local author=
++ local signoff=
++ local indir=
++ local tag=light
++ test 1 '!=' 0
++ case "$1" in
++ break
++ indir=
++ local file=m2.t
++ test -n ''
++ echo m2
++ git add -- m2.t
++ test -z ''
++ test_tick
++ test -z set
++ test_tick=1112912233
++ GIT_COMMITTER_DATE='1112912233 -0700'
++ GIT_AUTHOR_DATE='1112912233 -0700'
++ export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
++ git commit -m m2
[detached HEAD 9b81a41] m2
 Author: A U Thor <author@example.com>
 2 files changed, 1 insertion(+), 1 deletion(-)
 delete mode 100644 file
 create mode 100644 m2.t
++ case "$tag" in
++ git tag m2
++ git merge m1
Merge made by the 'ort' strategy.
 m1.t | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 m1.t
++ check_last_modified
++ local indir=
++ test 0 '!=' 0
++ cat
++ git last-modified
++ git name-rev --annotate-stdin --name-only --tags
++ tr '\t' ' '
++ test_cmp expect actual
++ test 2 -ne 2
++ eval 'diff -u' '"$@"'
+++ diff -u expect actual
--- expect      2025-11-19 15:43:34 +0000
+++ actual      2025-11-19 15:43:34 +0000
@@ -1,2 +1,2 @@
+ac29b6e974b49803f1c6ec5a705d1bf7dbfa7d2f m1.t
 m2 m2.t
-m1 m1.t
error: last command exited with $?=1
not ok 16 - cross merge boundaries in blaming



expecting success of 8020.19 'last-modified merge undoes changes':
        git checkout HEAD^0 &&
        git rm -rf . &&
        test_commit b1 file A &&
        test_commit b2 file B &&
        test_commit b3 file C &&
        test_commit b4 file D &&
        git checkout b2 &&
        test_commit b5 file2 2 &&
        git checkout b4 &&
        git merge --no-commit --no-ff b5 &&
        git checkout b2 -- file &&
        git merge --continue &&
        check_last_modified <<-\EOF
        b5 file2
        b2 file
        EOF

++ git checkout 'HEAD^0'
HEAD is now at 7b0602a Merge tag 'a4' into HEAD
++ git rm -rf .
rm 'file'
++ test_commit b1 file A
++ local notick=
++ local echo=echo
++ local append=
++ local author=
++ local signoff=
++ local indir=
++ local tag=light
++ test 3 '!=' 0
++ case "$1" in
++ break
++ indir=
++ local file=file
++ test -n ''
++ echo A
++ git add -- file
++ test -z ''
++ test_tick
++ test -z set
++ test_tick=1112912713
++ GIT_COMMITTER_DATE='1112912713 -0700'
++ GIT_AUTHOR_DATE='1112912713 -0700'
++ export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
++ git commit -m b1
[detached HEAD c48d0f6] b1
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
++ case "$tag" in
++ git tag b1
++ test_commit b2 file B
++ local notick=
++ local echo=echo
++ local append=
++ local author=
++ local signoff=
++ local indir=
++ local tag=light
++ test 3 '!=' 0
++ case "$1" in
++ break
++ indir=
++ local file=file
++ test -n ''
++ echo B
++ git add -- file
++ test -z ''
++ test_tick
++ test -z set
++ test_tick=1112912773
++ GIT_COMMITTER_DATE='1112912773 -0700'
++ GIT_AUTHOR_DATE='1112912773 -0700'
++ export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
++ git commit -m b2
[detached HEAD ee27b37] b2
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
++ case "$tag" in
++ git tag b2
++ test_commit b3 file C
++ local notick=
++ local echo=echo
++ local append=
++ local author=
++ local signoff=
++ local indir=
++ local tag=light
++ test 3 '!=' 0
++ case "$1" in
++ break
++ indir=
++ local file=file
++ test -n ''
++ echo C
++ git add -- file
++ test -z ''
++ test_tick
++ test -z set
++ test_tick=1112912833
++ GIT_COMMITTER_DATE='1112912833 -0700'
++ GIT_AUTHOR_DATE='1112912833 -0700'
++ export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
++ git commit -m b3
[detached HEAD c90ce7d] b3
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
++ case "$tag" in
++ git tag b3
++ test_commit b4 file D
++ local notick=
++ local echo=echo
++ local append=
++ local author=
++ local signoff=
++ local indir=
++ local tag=light
++ test 3 '!=' 0
++ case "$1" in
++ break
++ indir=
++ local file=file
++ test -n ''
++ echo D
++ git add -- file
++ test -z ''
++ test_tick
++ test -z set
++ test_tick=1112912893
++ GIT_COMMITTER_DATE='1112912893 -0700'
++ GIT_AUTHOR_DATE='1112912893 -0700'
++ export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
++ git commit -m b4
[detached HEAD 317a439] b4
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
++ case "$tag" in
++ git tag b4
++ git checkout b2
Previous HEAD position was 317a439 b4
HEAD is now at ee27b37 b2
++ test_commit b5 file2 2
++ local notick=
++ local echo=echo
++ local append=
++ local author=
++ local signoff=
++ local indir=
++ local tag=light
++ test 3 '!=' 0
++ case "$1" in
++ break
++ indir=
++ local file=file2
++ test -n ''
++ echo 2
++ git add -- file2
++ test -z ''
++ test_tick
++ test -z set
++ test_tick=1112912953
++ GIT_COMMITTER_DATE='1112912953 -0700'
++ GIT_AUTHOR_DATE='1112912953 -0700'
++ export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
++ git commit -m b5
[detached HEAD 5526d49] b5
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 file2
++ case "$tag" in
++ git tag b5
++ git checkout b4
Previous HEAD position was 5526d49 b5
HEAD is now at 317a439 b4
++ git merge --no-commit --no-ff b5
Automatic merge went well; stopped before committing as requested
++ git checkout b2 -- file
++ git merge --continue
[detached HEAD da1857e] Merge tag 'b5' into HEAD
 Author: A U Thor <author@example.com>
++ check_last_modified
++ local indir=
++ test 0 '!=' 0
++ cat
++ git last-modified
++ git name-rev --annotate-stdin --name-only --tags
++ tr '\t' ' '
++ test_cmp expect actual
++ test 2 -ne 2
++ eval 'diff -u' '"$@"'
+++ diff -u expect actual
--- expect      2025-11-19 15:43:57 +0000
+++ actual      2025-11-19 15:43:57 +0000
@@ -1,2 +1,2 @@
-b5 file2
-b2 file
+da1857e0652b6f264c0038d684ddecddc273e506 file2
+da1857e0652b6f264c0038d684ddecddc273e506 file
error: last command exited with $?=1
not ok 19 - last-modified merge undoes changes


--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.



