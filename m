Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4311DBE5E
	for <git@vger.kernel.org>; Fri, 30 May 2025 19:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748631644; cv=none; b=KUu4/XJBZpknlU1z+suVZX7I2GEAdY+0EjmdhkXgBeh0mr5SqZXSiHGwrrbY3p0IDtVaobGihaxD/WAcic1HuDT0tilqOv04RVDU/VxJO9VtfEGZyeSvqmieKWkTEd0sjjFj6pYXEAlOGUR6EucPv+bf/c1q4ea7sRKuJeikmck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748631644; c=relaxed/simple;
	bh=g5wylkF6cUATMGE8hBaLFt0sOhIslh8l5ZH7tIdxdFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LhYuRtUkKL9b+fTjmTEVveCBKiimey6YxzgjJrwa6/TuKMS++euyWwDEfmJ953vauNK3t0R45T6DDTVvQkeKiD52e0mtKnt06eiBrzCq0yxOjNQfacFWbIvDL/7EL4l4koSY7HHKqmOlQZCkirTI5PFX9fy6Kqk5jKg1QwnPy18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=izJDGa2O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZTOH3j3h; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="izJDGa2O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZTOH3j3h"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3CDB625400F6;
	Fri, 30 May 2025 15:00:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 30 May 2025 15:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1748631640; x=1748718040; bh=m9
	/PcJcu/cPSJfFS9QxWPOkLymeDpMYG5WKABfdyluo=; b=izJDGa2OhwCjuBN/op
	5l5KlckzfRJ6ZQOzynDlAJJuExjmnkcyJt0M1LKO/xoek7yVqR18m691GI3g4Ysv
	2R8Fs2XgiusW0cRaWQ1ZFB9NaXT2C5r/bCLvgT3Z5dniAfvevSls++3kJPXqnQQX
	ZnK6en1MSD7piRi/BTa8t/qA7NzuZSV+IGFSQ1aW7sK/wFCanaWEu2cwe3T/YtG9
	AUefxwyAVyMpb92yzAMbWEUKg3Qxq6zQXH5X8tWGQTQcYuE9STJ/q2y/JkwMm4C4
	GaBnkSeP44gH34vCr2O7Lna6VyidGGWHTLY1nGaLBPU5uvBM8bH7jko/O3ceXYJ1
	HwXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1748631640; x=1748718040; bh=m9/PcJcu/cPSJfFS9QxWPOkLymeD
	pMYG5WKABfdyluo=; b=ZTOH3j3hyZo7IMn74zylS/4a7TNlvfDrAoBoF4RTiupj
	8JYTYPUyp1PxLf/XkmHKOaWsEwMoVjwJGABkJy068FvxAa7WOMUu7KVT0rUgdNIk
	TuT/MDCVq+8uKbAh7C3LSQyw0Mo6Na8D1L9fnSoWPv5KtDnJhvZuT2lgvo/Lgpny
	6g+rCQ/5vZ6cENPaWyb69g84MqFrRJUaIKSelFnvwGnPplfiFNf/9T+AuTcs/IJO
	M6i1z/XO+JnziQOWdV7KCUAnzstnPleoc2jDlt9tuQWWzD521ibjC3l4u3EwkXht
	nNFky0cgKp/WUki38OHGOKW++dqM4f8cnv+kFFmfVg==
X-ME-Sender: <xms:VwA6aB_z0RGPoxSk6t_X5sXsO6Z-BaOf0LpVpW8y3yhkTloEsgwEwAw>
    <xme:VwA6aFt6XIHigvD0o0CGVkdAc9BmcyGzXEtsuUox0kQy4YvoAMQE1EIO3f23sv6m1
    ctPy-D93GBnYq0l3A>
X-ME-Received: <xmr:VwA6aPAyktdHPf9yKp-Zke_LSBpsn9gz85UumICan4sKa0KgiG6b5RalDw8j3NQDmisYZzShzDWtXuM_1l8SwJEXFUL-0azLYw6-VaM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvleejleculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffo
    gggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepfeejhefgveejueei
    tddtheduleefhfdvffehheegteduvdekiefhgeeiffeuleelnecuffhomhgrihhnpehgih
    hthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtg
    homhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrg
    hughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehshhgvjh
    hirghluhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:VwA6aFe8Jn19nUg_9DvqAwU1AFMEZjOJeVC2V5gKJK9Ea6f0yJ7ISw>
    <xmx:VwA6aGMfLGWadl0hswnBGcT9h0k9q9En6XGaSr6wJQ4YtgMMeE9_CQ>
    <xmx:VwA6aHnrJgK6NdOAl-ZOefF9j_IpnFmZtlcMwaPfxfoeIzmcI5gSHQ>
    <xmx:VwA6aAuKSlZ25RJRCAs0aWao9Vw4gi9gkdpMWbD-r-5nDCTnVKLbHA>
    <xmx:WAA6aN9brNt1jp5ueJbXFgrWNO2Yw2qSaYRAbwq3G5rfiPBF5ndYT3dw>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 15:00:37 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	shejialuo <shejialuo@gmail.com>
Subject: [BUG] refs: verify does not work if there are v2.43.0 or older worktrees w/o wt. refs
Date: Fri, 30 May 2025 21:00:06 +0200
Message-ID: <1d8f471b6dcb7e952afea834490be195189492a7.1748629208.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.50.0.rc0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

(regular git-bugreport(1) follows after this, then a demo patch)

git-refs-verify(1) checks worktree refs since v2.47.0-111-g7c78d819e6a
(ref: support multiple worktrees check for refs, 2024-11-20).  This
causes the command to always exit with code `255` and stderr output
lines for each worktree created on v2.43.0 or older that does not have
worktree refs:

    error: cannot open directory .git/worktrees/<worktree name>/refs: No such file or directory

This is apparently caused by worktrees created on Git v2.43.0 or older.
Apparently these worktrees don’t have this directory unless there exist
worktree refs:

    .git/worktrees/<worktree name>/refs

Again: any such worktrees work fine if you for example have bisect refs.
But the command will always fail if you have one or more v2.43.0 or
older worktrees with no worktree refs.

git-fsck(1) also now prints the same warnings because of the default
`--reference`.  But the operation of the command seems unaffected.

So to reproduce (also see patch at the end)

1. Make a worktree on v2.43.0 or just make a worktree and delete the
   `refs/` directory for the worktree
2. Run `git refs verify`
   • On your regular git(1): not on v2.43.0
3. Expected: succeeds without output
4. Actual: exit code `255`, `cannot open directory` on stderr

Or reproduce with this script (replace with clone with worktree if
you prefer):

    git config set --global safe.directory /tmp &&
    cd /tmp &&
    dir=$(mktemp -d)
    cd $dir
    git clone https://github.com/git/git git-older &&
    cd git-older &&
    git checkout v2.43.0 &&
    make &&
    # use Git v2.43.0
    ./git worktree add --detach worktree1234 &&
    # will fail
    git refs verify
    # Cleanup
    git config unset --global safe.directory

§ Testing on `seen` and `next`

• seen: bfa90786bc5 (Merge branch 'jk/diff-no-index-with-pathspec' into
  seen, 2025-05-29)
• next: d4ff7b7c865 (Sync with 'master', 2025-05-29)

§ Regular report

> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)

Using a repository with worktrees that were apparently made on v2.43.0
or older, based on testing.  Some of them have no worktree refs which is
what triggers this behavior.

> What did you expect to happen? (Expected behavior)

`git refs verify` with exit code `0` and no output.

> What happened instead? (Actual behavior)

The same command exits with exit code `255` and output like

    error: cannot open directory .git/worktrees/<worktree name>/refs: No such file or directory

What's different between what you expected and what actually happened?

See above.

> Anything else you want to add:
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.

[System Info]
git version:
git version 2.50.0.rc0
cpu: x86_64
built from commit: b32feae0f1b21faaf8e191e8d3314a32470a536b
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 7.81.0
OpenSSL: OpenSSL 3.0.2 15 Mar 2022
zlib: 1.2.11
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
uname: Linux 6.8.0-59-generic #61~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Tue Apr 15 17:03:15 UTC 2 x86_64
compiler info: gnuc: 11.4
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash

[Enabled Hooks]
post-rewrite
sendemail-validate

-- 8< --
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH] t0602: demo v2.43.0 worktree problem

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 t/t0602-reffiles-fsck.sh | 43 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index f671ac4d3ab..90b68f6561e 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -886,4 +886,47 @@ test_expect_success '--[no-]references option should apply to fsck' '
 	)
 '
 
+# These worktrees will not have a refs/ directory unless there
+# actually exist worktree refs
+test_expect_failure 'works with worktrees from v2.43.0 or older without worktree refs' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		git checkout -b default-branch &&
+		git worktree add --detach ./worktree &&
+		# Simulate old directory layout
+		rmdir .git/worktrees/worktree/refs &&
+		git refs verify 2>err &&
+		test_must_be_empty err
+	)
+'
+
+test_expect_success 'works with worktrees from v2.43.0 or older with worktree refs' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		test_commit second &&
+		git checkout -b default-branch &&
+		git worktree add --detach ./worktree &&
+		(
+			cd worktree &&
+			git bisect start &&
+			git bisect bad HEAD &&
+			git bisect good initial &&
+			# Simulate old directory layout: delete if empty
+			# But there should exist a refs/bisect/ directory now
+			if [ ! -e ../.git/worktrees/worktree/refs/bisect ]
+			then
+				rmdir ../.git/worktrees/worktree/refs
+			fi &&
+			git refs verify 2>err &&
+			test_must_be_empty err
+		)
+	)
+'
+
 test_done
-- 
Don’t cry because the bug is fixed. Smile because it happened.
