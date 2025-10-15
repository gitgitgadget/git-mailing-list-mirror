Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925C32FD7BC
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 06:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509578; cv=none; b=nhWEqJhcLp1K7P/nM8jloQsHaZVUPijdXCjsjyNxlMNfQgCfRDhcyxBkcTTR6zyjmo93tm4oZ7A93OmuU2EWVg2EUTBX7LarLqSRmwbbaZRfIxaQZEfXsM/oIiwSQlaiwU+PBk4r/+e/iT+QWGRBDKHDgBkG7kAy6earDkWltVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509578; c=relaxed/simple;
	bh=iL9QltyRkBpnYtKNK96PGYaL4b5rZIwlyP5rfrIMMZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=ZFjdeLgkoGn9S0tfLqPdznW8R78hWlVoQHh/f5Y0gIjKJbt84/1fQWtqEnNZsl/cHOFt4hYP61jQlYoCuW03Oidvj8WjxO9f8UqX5SS1sZbR38jObJ4EmTnR9I1ecxKjYvuwuzeVdm4AsWSy7wfnSCPTD7nLklFy6i0H8rXPTUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fJBsIEpd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LYXYyUkt; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fJBsIEpd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LYXYyUkt"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B502D1D000D8;
	Wed, 15 Oct 2025 02:26:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 15 Oct 2025 02:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760509575;
	 x=1760595975; bh=AA715d5rRC6lOx2Ufa7aEn+T1AYved9ONxBLVmeWu38=; b=
	fJBsIEpdnIVofDwuRjCAYDABGLYPg7l9zeKTsvnLHIGB9yK94QzEk4DWctJgi1nA
	NMSFWN/hTtpPT6Zour5b++mCQ3GK7AyPzmPzqMlwUF6hSlsMvseBwmUjTBPlecYU
	f48zH1bRDpKeavlJOCISOutC3Wwo0TUS5VSo0S4pzFg4mjRX+XF9jJPujc93uq6n
	nxXL5lGamldZE++4vYygWWS1vxryyWIK9u6BZ2jL1jQD4fyoDMtBUrpou7q6Et1O
	tLl/OdjDWaxz4eCra2bkTxdduVpa4SF3WHhXjHbta1tDCDrR+1UiMHsGoFdyZfzK
	llfSVWI5+shCRk0j4vo56g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760509575; x=
	1760595975; bh=AA715d5rRC6lOx2Ufa7aEn+T1AYved9ONxBLVmeWu38=; b=L
	YXYyUktFhtCTxIO4/tWbarzKijavpld/IRimGu2ji0vVrZ515F3qKxicHFLrRmYx
	Xj8nAUk4HJ6IX9yP0pwauK0pxVjlwyrtd9smCgqdKUw87CVNBeCUpkkGTz4pTB/L
	SwuNu4q3QyFCNlxaI3HepzsUp/qSdIANdwFPT7FeUp1n1M5RftKGLQorKOmhYPwr
	e/qkR7hPcItBKJAzXesfFuILVvmlVxgJdDA7pT6wRfdVaBBukb651jwMHQzlNesy
	hvQS6SHmIsZtZak8ZwZ0uE80Qo3YFINry69CF+2kAuiiPMqJT50TwbJS4yKhMwvb
	YipF+ITHIJeqI3Va8Emcw==
X-ME-Sender: <xms:hz7vaGBafCm0rdtBaKHdT7OaGVJXcezrXTW1-fZA47jdBodpeD-ndQ>
    <xme:hz7vaH-ydqWwYgqtrF3xt4Iv-FprUobKKoZOCjAtrKyasV_huibrPcF2vOeSsEY1D
    x1I7sDIsCsIjDqqAig2j_r8kWLou2Z9M_Egb4KGgLUE2WLqZO1boro>
X-ME-Received: <xmr:hz7vaG8ievuLwfOxTIQeusYhsS_m9n5aAVPRjKbBIe10PWqbtcc6uaqj3bW31PxlFVxDrmZrRmomfxUOGld1_Dc9-WOGIHfRp_1x3d-cu8AN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeiuddvvdefgeduhfetgeeuffejlefhkeehfeekteeuteelhedutdeifeektedtieen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:hz7vaOfmDrd0L1HQJ25ZaB760RJwvEPo6Cb6q2DC9ccVoCmzT1rs3A>
    <xmx:hz7vaPFVIe4FF7pq8MvH0km1NgYbnPw-E8Cdq7tIW1W9uD6-KTzVUw>
    <xmx:hz7vaMeeJZqdJ6isjtbcVE0A8vJio4LVFYGrLYqX2B3hl3w8ggtn5w>
    <xmx:hz7vaJFu8s2AtzdC7-vyUGINtGYcbf-NMMDAfUMLT4enXSTQ2Y2zVw>
    <xmx:hz7vaGiD6abPJEIBNXy_8IarTyCuLgKKpUlfjPhngpPcdjY_l_sqkaLR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 02:26:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b2b8344b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 15 Oct 2025 06:26:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 15 Oct 2025 08:26:08 +0200
Subject: [PATCH v2] refs/files: deprecate writing symrefs as symbolic links
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-pks-ref-files-deprecate-symbolic-links-v2-1-0529ba48db41@pks.im>
X-B4-Tracking: v=1; b=H4sIAIA+72gC/5WNQQ6CMBBFr0K6dgwlHURX3sOwKGUqExFIhxAJ4
 e6O3MDl+/n/v80IJSYxt2wziRYWHgeF4pSZ0PnhScCtsinyAm1uHUwvgUQRIvck0NKUKPiZQNZ
 3M/YcoOdBK1g5vF48YtWg0TOtRf4coket3LHMY1oP72J/6d+KxYIF14S29I5iGfGuwzO/Tb3v+
 xe6vfdG2QAAAA==
X-Change-ID: 20251014-pks-ref-files-deprecate-symbolic-links-584597a558b5
In-Reply-To: <20251014-pks-ref-files-deprecate-symbolic-links-v1-1-4bcd6a4ef6f5@pks.im>
References: <20251014-pks-ref-files-deprecate-symbolic-links-v1-1-4bcd6a4ef6f5@pks.im>
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

Changes in v2:
  - Tweaks for the deprecation announcement.
  - Use "textual symref format" instead of "symref format".
  - Warn after having created the symlink so that we don't drown out
    messages from `die()` that may have happened in
    `get_locked_file_path()`.
  - Link to v1: https://lore.kernel.org/r/20251014-pks-ref-files-deprecate-symbolic-links-v1-1-4bcd6a4ef6f5@pks.im

Patrick

[1]: <xmqqzf9zddia.fsf@gitster.g>
---
 Documentation/BreakingChanges.adoc | 20 ++++++++++++++++++++
 Documentation/config/core.adoc     |  3 +++
 refs/files-backend.c               | 19 +++++++++++++++++--
 t/t0600-reffiles-backend.sh        | 26 +++++++++++++++++++++++---
 4 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index 90b53abcea2..f814450d2f6 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -295,6 +295,26 @@ The command will be removed.
 +
 cf. <xmqqa59i45wc.fsf@gitster.g>
 
+* Support for `core.preferSymlinkRefs=true` has been deprecated and will be
+  removed in Git 3.0. Writing symbolic refs as symbolic links will be phased
+  out in favor of using plain files using the textual representation of
+  symbolic refs.
++
+Symbolic references were initially always stored as a symbolic link. This was
+changed in 9b143c6e15 (Teach update-ref about a symbolic ref stored in a
+textfile., 2005-09-25), where a new textual symref format was introduced to
+store those symbolic refs in a plain file. In 9f0bb90d16
+(core.prefersymlinkrefs: use symlinks for .git/HEAD, 2006-05-02), the Git
+project switched the default to use the textual symrefs in favor of symbolic
+links.
++
+The migration away from symbolic links has happened almost 20 years ago by now,
+and there is no known reason why one should prefer them nowadays. Furthermore,
+symbolic links are not supported on some platforms.
++
+Note that only the writing side for such symbolic links is deprecated. Reading
+such symbolic links is still supported for now.
+
 == Superseded features that will not be deprecated
 
 Some features have gained newer replacements that aim to improve the design in
diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
index 08739bb9d42..406d7029d9d 100644
--- a/Documentation/config/core.adoc
+++ b/Documentation/config/core.adoc
@@ -290,6 +290,9 @@ core.preferSymlinkRefs::
 	and other symbolic reference files, use symbolic links.
 	This is sometimes needed to work with old scripts that
 	expect HEAD to be a symbolic link.
++
+This configuration is deprecated and will be removed in Git 3.0. Symbolic refs
+will always be written as textual symrefs.
 
 core.alternateRefsCommand::
 	When advertising tips of available history from an alternate, use the shell to
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 3e46386531d..6b65e601920 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2114,20 +2114,35 @@ static int commit_ref_update(struct files_ref_store *refs,
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
+	ref_path = get_locked_file_path(&lock->lk);
 	unlink(ref_path);
 	ret = symlink(target, ref_path);
 	free(ref_path);
 
 	if (ret)
 		fprintf(stderr, "no symlink - falling back to symbolic ref\n");
+
+	if (warn_once)
+		warning(_("'core.preferSymlinkRefs=true' is nominated for removal.\n"
+			  "hint: The use of symbolic links for symbolic refs is deprecated\n"
+			  "hint: and will be removed in Git 3.0. The configuration that\n"
+			  "hint: tells Git to use them is thus going away. You can unset\n"
+			  "hint: it with:\n"
+			  "hint:\n"
+			  "hint:\tgit config unset core.preferSymlinkRefs\n"
+			  "hint:\n"
+			  "hint: Git will then use the textual symref format instead."));
+	warn_once = 0;
+
 	return ret;
 }
 #endif
diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index 1e62c791d97..b11126ed478 100755
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
+		hint: Git will then use the textual symref format instead.
+		EOF
+		test_cmp expect err
+	fi
 '
 
 test_expect_success 'symref transaction supports false symlink config' '

---
base-commit: 5f9d2e334da76ac55790ce4d4ea971a31bcd57fd
change-id: 20251014-pks-ref-files-deprecate-symbolic-links-584597a558b5

