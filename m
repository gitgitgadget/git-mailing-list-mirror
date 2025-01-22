Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0880211299
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 09:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737539294; cv=none; b=r4pqmBVi2klGOPn4ozNXQyqP//v4AQynp5TLWEwEfBC/nXyaEvEGKo0B1XTQRHZ08f0yQERNNE97dMlzZjpQrtclBUS/XbHo17h+CudF86X21PxA9K/jFxrKwtALEBskOuHPLDY+1P246gtya81LCVFln8hMWvnJCLdZuXkAR24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737539294; c=relaxed/simple;
	bh=0trjfko5S1xSgrjGyFWXw+IJym4XihLn0rMWSe5gk44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YOJlh+JebKLWftsHi8ZUENKwhB+NbjI/dqP+X/Ops0SPl3VFRnfEAhBOgmjDGRCVYzLQLzMxgG9F9R5zmMftp0m/u7SGjGQxoBWGBEQohdTeOk4pIskuS9Zsn7CckvIkhL408KT6te23APkIhmAdTfH2/CQmTkk9MKoWnY+Z47M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TFdHM1qo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TQ4rF1pz; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TFdHM1qo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TQ4rF1pz"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C22B625401FF;
	Wed, 22 Jan 2025 04:48:10 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 22 Jan 2025 04:48:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1737539290; x=1737625690; bh=8NDCREsLoO
	dqHfOQU7xqkClTwd1M52fRuRfnSvlxruE=; b=TFdHM1qoLOMRnkjJNy2cvWOQuP
	gM9ticIcnp37RXUFoxjYUvjdEUgC86KjBIOx0nf+D04hSj67kaf2477K1OP9idCQ
	aYJ7c+UPFkQaZBuYiXsTVJnFmkdDGUtgI+f02vYY9/4ijJuSpTk+SG9X+Zbn3aDJ
	tNtr+qp4BPS0Qfg1s63PJsX/nAgDEYY4yQsHFkNWPpqdUuVz2/9HFj8cCq3DpNBi
	/MSY+JIkQ0wy1Vgf9Dk1VosOfCLXEH6OVsOyw4lzb8RzPcmFCa23pswXOAYaUNMa
	loTwMBkEH9NSxPxRJjjMVel8pDKj0HFYhlG1SmrSuraytvO0kvqG+1utzbdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1737539290; x=1737625690; bh=8NDCREsLoOdqHfOQU7xqkClTwd1M
	52fRuRfnSvlxruE=; b=TQ4rF1pzPQOxvlvIyD82hMx4m4hmNf83lPLl/N3vwGLp
	/D1EC/02D1pLMmb4QNpkin8v0CDsIN1/8RAa1N0dvAsQ7wsVLEUCwboY6iBMSLnn
	gxLK9WKfvvbMyuKVk/DDF+saCl8xMc+8ToQbRYMkq20cC/D93uwM8cG2ZNbJJPSg
	0rF4h/JTDlV7Gw587q3BbgSz/2spYZPJwfpLywb8nSh0IQBG9CAFuiyccFtnlXM5
	JbpKqlZipIL0beG+PnOp7eCc7ngJPVIL3tRet5EYbFSzqssoHF7hJHsVJkc4yxKV
	SHxeS2mFVR/Il+JIsfeNjffY+YChSTbfwcyIeLPHkA==
X-ME-Sender: <xms:2r6QZ4QliO_71n8yqbJ07dZDtJY9SOiq7brOrXgECnk5rR0soRoAeA>
    <xme:2r6QZ1ytUqTpufEHuHX3-RS-y6pYn6kRpmJQigpaw3iBJXWofUyZM2C5w2SYAtptV
    c3G1gTTf70YJ_FnFA>
X-ME-Received: <xmr:2r6QZ13QJM9ss7t6GWBnp13qqjHMkGyv7_uwOqLzbVJ11s0oIR5Ai3498fm5pie9IEeE2DHktFSq1uyOBPSJZsaxBKAwavQSEmQIGneKWYIbUOo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepiefgiedtffffvddvueehheejheehleduudfhheekkeeg
    gefgueffheevgeetjeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    shgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:2r6QZ8Cxf0baKN5VT5ZEcrY5VWdTEFSdLaGtYo7hblgDZAix35WSvw>
    <xmx:2r6QZxjzVFes6YuLk-dKUyVKjHhA4wp9laNziocHHM8q3I7UAeBEpw>
    <xmx:2r6QZ4qtmewjKRyQHC14Lbmy4V9FiUzlaVbVur8j8azAl4dR3r2Dbw>
    <xmx:2r6QZ0hxLulJNwcwFZFNZUanzhebjdcPIY5AzwqZnykV5DEm4gPSEw>
    <xmx:2r6QZ2t6MqMbPqwFs4uO9iw7xRIHNCSihUfpjBAoxk7vviaWBhAWfdL9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 04:48:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dd0e4cd9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Jan 2025 09:48:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 22 Jan 2025 10:48:06 +0100
Subject: [PATCH] refs: fix migration of reflogs respecting
 "core.logAllRefUpdates"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-b4-pks-reflog-migration-fix-stash-v1-1-27dbae4602f7@pks.im>
X-B4-Tracking: v=1; b=H4sIANW+kGcC/x2NSwqEMBAFryK9tiGJDopXERdx7MTGL+kggnj3a
 WZZ8OrVA0KJSaArHkh0sfCxK9iygO/s90jIkzI44z7GOodjjecimCisR8SNY/JZHQx8o2QvM04
 2UFO1JrS1B/05dcv3v9EP7/sDFSy7xHMAAAA=
X-Change-ID: 20250122-b4-pks-reflog-migration-fix-stash-d1fe7380f84a
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

In 246cebe320 (refs: add support for migrating reflogs, 2024-12-16) we
have added support to git-refs(1) to migrate reflogs between reference
backends. It was reported [1] though that not we don't migrate reflogs
for a subset of references, most importantly "refs/stash".

This issue is caused by us still honoring "core.logAllRefUpdates" when
trying to migrate reflogs: we do queue the updates, but depending on the
value of that config we may decide to just skip writing the reflog entry
altogether. And given that:

  - The default for "core.logAllRefUpdates" is to only create reflogs
    for branches, remotes, note refs and "HEAD"

  - "refs/stash" is neither of these ref types.

We end up skipping the reflog creation for that particular reference.

Fix the bug by setting `REF_FORCE_CREATE_REFLOG`, which instructs the
ref backends to create the reflog entry regardless of the config or any
preexisting state.

[1]: <Z5BTQRlsOj1sygun@tapette.crustytoothpaste.net>

Reported-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

this patch addresses the issue reported by brian where "refs/stash"
isn't getting migrated correctly. The patch is based on top of "maint"
so that it can be easily backported.

Thanks for the report!

Patrick
---
 refs.c                  |  2 +-
 t/t1460-refs-migrate.sh | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 0f41b2fd4a..37b8cfb90c 100644
--- a/refs.c
+++ b/refs.c
@@ -1330,7 +1330,7 @@ int ref_transaction_update_reflog(struct ref_transaction *transaction,
 
 	assert(err);
 
-	flags |= REF_LOG_ONLY | REF_NO_DEREF;
+	flags |= REF_LOG_ONLY | REF_FORCE_CREATE_REFLOG | REF_NO_DEREF;
 
 	if (!transaction_refname_valid(refname, new_oid, flags, err))
 		return -1;
diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
index f59bc4860f..ceb0c4977d 100755
--- a/t/t1460-refs-migrate.sh
+++ b/t/t1460-refs-migrate.sh
@@ -224,6 +224,23 @@ do
 			test_commit --date "100003000 +0700" --no-tag -C repo second &&
 			test_migration repo "$to_format"
 		'
+
+		test_expect_success "$from_format -> $to_format: stash is retained" '
+			test_when_finished "rm -rf repo" &&
+			git init --ref-format=$from_format repo &&
+			(
+				cd repo &&
+				test_commit initial A &&
+				echo foo >A &&
+				git stash push &&
+				echo bar >A &&
+				git stash push &&
+				git stash list >expect.reflog &&
+				test_migration . "$to_format" &&
+				git stash list >actual.reflog &&
+				test_cmp expect.reflog actual.reflog
+			)
+		'
 	done
 done
 

---
base-commit: f93ff170b93a1782659637824b25923245ac9dd1
change-id: 20250122-b4-pks-reflog-migration-fix-stash-d1fe7380f84a

