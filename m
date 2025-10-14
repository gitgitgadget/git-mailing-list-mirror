Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA531DF987
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 08:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429850; cv=none; b=MdL5DCht5HiliZLP4TQTzYtnfXTbzM9D/aZv5CMSaZHaaDBqYUu9Oe28AIMmYmvpZGqmj49iZN1TC0fPFmjLmMSVMujALMJeQM3r1FrNs3PlKtYRvaQ1bZN05MjvqLMV+yT//2RgLS65hUnPX5uh0UTJ7zCn3iqF/qFdgZXkOcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429850; c=relaxed/simple;
	bh=fl5+HOdTZ4TCdtnkSmPWvxCFIXODAibEZ2kkL8a9uI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dcMtcks23bsLqtQFpDVF6i6NOlmYUycZimCA0h68S9LQqKuRVx5isedd7JjSiTr/hwrrPWL3X5kV2wLz6K8P1tnqOXyUUl8tzT1AyHa4L4IQICJDhu0Z1SytUPY91ZoovZparQ766sRMTwR2Y88Mp7lrXRP7Gq9kJV79S9I3JDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VSFh2ofP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C3NtOlIx; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VSFh2ofP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C3NtOlIx"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3C5477A0109;
	Tue, 14 Oct 2025 04:17:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 14 Oct 2025 04:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1760429846; x=1760516246; bh=KHlOztik2H
	Oa94gE/SWnvoHxZG1BITkD5844nCrRCdw=; b=VSFh2ofPzoKlu9CxZ4PzoOplqB
	J4q8KLXrBszEWVyqlDyR/SxoYTqIa53D319AHEMWsS4lyGAoUSAo30zHJUy5bmMz
	RZqNkoInOUWcLjdpjhTIOxjKT2II3bmsXJVKTMR5Josp/R1Jqoh1ckwz1/roSMbi
	+qfWoB/WNjxkHrqKU+QX60kNiEPNiXirYzWnxvcF1A+pBax+9th8QYg4c7Tq+SON
	yMK/aLaJJEIzvWmiuvrGirufRa5v8k6hbZrR6fBv4NsWXWWEWACGIrPxzbMUwqsc
	9pyDITzBhVSfiFZcFLvI9ywEFma3zGud06eMrJlyHffaAwY3ge+Bje+7jhqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1760429846; x=1760516246; bh=KHlOztik2HOa94gE/SWnvoHxZG1B
	ITkD5844nCrRCdw=; b=C3NtOlIx3MafYTU5el/IZGeMxkNnzrIFahmOFZeSyZ/3
	nj77710QAjXWs2NBVlls4LQXZINkYNwwuyqrAIKZsQhPVdoEHV6iPK7Nt54Dptc7
	NG/lgEVt+hS9luuK6o/r9/5F3KlotrjnBYgJoRBRrBRCceK0IiA3vYhM2bu5Qfo8
	QPcYlKevbIh6hmgX6FMP1jdH3rNrYP+Coi7dH0iDTLu0rT0bobNSsehNMToSZcWr
	HDEPkz5lo4VD0Kh9ljkGO2t9m8j0QN/05SiZdb1AWB6WPlRAqEB6wtvv0zbOXEIu
	2Uda4ZCVWYV7oQzwI83XHmITZY/uQREhxVUN2qv1Lg==
X-ME-Sender: <xms:FQfuaETndwIBsnanmBVrO4cUgVE-4_T3fiWRn5AcQ2VXkLBZID0OJg>
    <xme:FQfuaJOHVqNLfb8DcLMpGV52bxV5ST1PPbJW1XtkuqVNz1QQyUpwXRYOdhpnGh4DE
    6FLDmeUUyRCNhEkQsVihy7Lf2azWaYbzJxpw2ZmVYASPpJqi0VI>
X-ME-Received: <xmr:FQfuaPPTp_O06cjkVkcSim2v-2QDlhNFNK2dkLirJqXdbn7T_EYsxD-D2Tex7vJyFCen-VaRJHnp9r7bTOLZroOoza3IeGhBJ1xagxLCRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddttdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    eigfeitdffffdvvdeuheehjeehheeludduhfehkeekgeeggfeuffehveegteejfeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghl
    ihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:FQfuaBsUsI3xee1AdVjPL2n2yglWrdtatkv5JkHK4IpA7pawEpn4eQ>
    <xmx:FQfuaBVNTuMYPbiCZGeMT0FfXd1olI-ErykHw6XKCIpJiZTCtJu0pw>
    <xmx:FQfuaBsxhXHqsynrQpnipM8R_fUa7a7oGjNdNkDLW6odoWuTtOxxJA>
    <xmx:FQfuaFU0ixz4DngACrVam6oT5RHYYcNTUqVXjvSEZCWehOUgGauRFg>
    <xmx:FgfuaHxfx1bb_UcxIjPWSCuD6OJk56DAvwyN_RASTn7luL707Xi-f67B>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 04:17:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f9a9f15c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 14 Oct 2025 08:17:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 14 Oct 2025 10:17:14 +0200
Subject: [PATCH] refs/files: deprecate writing symrefs as symbolic links
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-pks-ref-files-deprecate-symbolic-links-v1-1-4bcd6a4ef6f5@pks.im>
X-B4-Tracking: v=1; b=H4sIAAkH7mgC/x2N0QqDMAwAf0XyvIAVw5y/InuoNZ3Brkozxob47
 wYfD467HZSLsEJf7VD4KyprNnC3CsLs84tRJmNo6oZc7VrcFsXCEaMkVpx4Kxz8h1H/73FNEjB
 JNoW6lh53T9SNBBYzLcrvGg3P4zgBs++fwngAAAA=
X-Change-ID: 20251014-pks-ref-files-deprecate-symbolic-links-584597a558b5
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.3

The "files" backend has the ability to store symbolic refs as symbolic
links, which can be configured via "core.preferSymlinkRefs". This
feature stems back from the early days: the initial implementation of
symbolic refs used symlinks exclusively. The symref format was only
introduced in 9b143c6e15 (Teach update-ref about a symbolic ref stored
in a textfile., 2005-09-25) and made the default in 9f0bb90d16
(core.prefersymlinkrefs: use symlinks for .git/HEAD, 2006-05-02).

This is all about 20 years ago, and there are no known reasons nowadays
why one would want to use symlinks instead of symrefs. Mark the feature
for deprecation in Git 3.0.

Note that this only deprecates _writing_ symrefs as symbolic links.
Reading such symrefs is still supported for now.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

as discussed in [1], this small patch deprecates
"core.preferSymlinkRefs". Thanks!

Patrick

[1]: <xmqqzf9zddia.fsf@gitster.g>
---
 Documentation/BreakingChanges.adoc | 18 ++++++++++++++++++
 Documentation/config/core.adoc     |  3 +++
 refs/files-backend.c               | 18 ++++++++++++++++--
 t/t0600-reffiles-backend.sh        | 26 +++++++++++++++++++++++---
 4 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index 90b53abcea2..8178d06417b 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -295,6 +295,24 @@ The command will be removed.
 +
 cf. <xmqqa59i45wc.fsf@gitster.g>
 
+* Support for `core.preferSymlinkRefs=true` has been deprecated and will be
+  removed in Git 3.0. If set, symbolic refs like "HEAD" would be written as
+  symbolic links instead of as a plain file using the symref format.
++
+Symbolic references were initially always stored as a symbolic link. This was
+changed in 9b143c6e15 (Teach update-ref about a symbolic ref stored in a
+textfile., 2005-09-25), where a new symref format was introduced to store those
+symbolic refs in a plain file. In 9f0bb90d16 (core.prefersymlinkrefs: use
+symlinks for .git/HEAD, 2006-05-02), the Git project switched the default to use
+the symref format in favor of symbolic links.
++
+The migration away from symbolic links has happened almost 20 years ago by now,
+and there is no known reason why one should prefer them nowadays. Furthermore,
+symbolic links are not supported on some platforms.
++
+Note that for now, only the writing side for such symbolic links is deprecated.
+Reading such symbolic links is still supported for now.
+
 == Superseded features that will not be deprecated
 
 Some features have gained newer replacements that aim to improve the design in
diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
index 08739bb9d42..e9272bbc0bd 100644
--- a/Documentation/config/core.adoc
+++ b/Documentation/config/core.adoc
@@ -290,6 +290,9 @@ core.preferSymlinkRefs::
 	and other symbolic reference files, use symbolic links.
 	This is sometimes needed to work with old scripts that
 	expect HEAD to be a symbolic link.
++
+This configuration is deprecated and will be removed in Git 3.0. Writing
+symbolic links for symrefs will not be supported anymore.
 
 core.alternateRefsCommand::
 	When advertising tips of available history from an alternate, use the shell to
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 3e46386531d..b14e0af219e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2114,14 +2114,28 @@ static int commit_ref_update(struct files_ref_store *refs,
 	return 0;
 }
 
-#ifdef NO_SYMLINK_HEAD
+#if defined(NO_SYMLINK_HEAD) || defined(WITH_BREAKING_CHANGES)
 #define create_ref_symlink(a, b) (-1)
 #else
 static int create_ref_symlink(struct ref_lock *lock, const char *target)
 {
+	static int warn_once = 1;
+	char *ref_path;
 	int ret = -1;
 
-	char *ref_path = get_locked_file_path(&lock->lk);
+	if (warn_once)
+		warning(_("'core.preferSymlinkRefs=true' is nominated for removal.\n"
+			  "hint: The use of symbolic links for symbolic refs is deprecated\n"
+			  "hint: and will be removed in Git 3.0. The configuration that\n"
+			  "hint: tells Git to use them is thus going away. You can unset\n"
+			  "hint: it with:\n"
+			  "hint:\n"
+			  "hint:\tgit config unset core.preferSymlinkRefs\n"
+			  "hint:\n"
+			  "hint: Git will then use the symref format instead."));
+	warn_once = 0;
+
+	ref_path = get_locked_file_path(&lock->lk);
 	unlink(ref_path);
 	ret = symlink(target, ref_path);
 	free(ref_path);
diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index 1e62c791d97..560cdfe1d66 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -477,9 +477,29 @@ test_expect_success SYMLINKS 'symref transaction supports symlinks' '
 	prepare
 	commit
 	EOF
-	git update-ref --no-deref --stdin <stdin &&
-	test_path_is_symlink .git/TEST_SYMREF_HEAD &&
-	test "$(test_readlink .git/TEST_SYMREF_HEAD)" = refs/heads/new
+	git update-ref --no-deref --stdin <stdin 2>err &&
+	if test_have_prereq WITH_BREAKING_CHANGES
+	then
+		test_path_is_file .git/TEST_SYMREF_HEAD &&
+		echo "ref: refs/heads/new" >expect &&
+		test_cmp expect .git/TEST_SYMREF_HEAD &&
+		test_must_be_empty err
+	else
+		test_path_is_symlink .git/TEST_SYMREF_HEAD &&
+		test "$(test_readlink .git/TEST_SYMREF_HEAD)" = refs/heads/new &&
+		cat >expect <<-EOF &&
+		warning: ${SQ}core.preferSymlinkRefs=true${SQ} is nominated for removal.
+		hint: The use of symbolic links for symbolic refs is deprecated
+		hint: and will be removed in Git 3.0. The configuration that
+		hint: tells Git to use them is thus going away. You can unset
+		hint: it with:
+		hint:
+		hint:	git config unset core.preferSymlinkRefs
+		hint:
+		hint: Git will then use the symref format instead.
+		EOF
+		test_cmp expect err
+	fi
 '
 
 test_expect_success 'symref transaction supports false symlink config' '

---
base-commit: 5f9d2e334da76ac55790ce4d4ea971a31bcd57fd
change-id: 20251014-pks-ref-files-deprecate-symbolic-links-584597a558b5

