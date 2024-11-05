Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01AC1D79A0
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 06:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730787435; cv=none; b=Z13Qh6Z6Detk9gZI3HL02oLaD6L5oSLikbTEE1rZcmTGmv6HVSJRgiCJKMWsM5HLcneQXR5qIsm0Ptt2Ynk8AKe7/YTl3kovN9Yxc2N2Y5+gnc0fNh6QcBp17Gra02rsQjfv1jSzXz+Wblxs+0RXpgbEKzHqS1TpYaQ2hePuldY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730787435; c=relaxed/simple;
	bh=2TMfsOTIh3JnTCD9b7qzzyJwvE245Yzp/a3IFACQGu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjfCemU8WSdSaijhDJD5wgBT4/P8iNUva6js1lG+UIwq6Cp4BuZo3XhnxGM8Mpw0J7ZfGUv/EAoCBkjDE3Oyl0wcEWWzqq+PQZH4M3P6J/t51fycXAJmfnxQNJJ0rmWGTZVJgeDi+HLWvMloqlTLpri5a9sFhkj+ZUYQ9hWeAa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YgFijdEJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QWfkl17C; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YgFijdEJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QWfkl17C"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D4E7D2540076;
	Tue,  5 Nov 2024 01:17:12 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 05 Nov 2024 01:17:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730787432; x=1730873832; bh=DtfNjyoyKH
	ah2GOxH1ObLOaR8hni855r4j0yqFHbY34=; b=YgFijdEJ7UaXP4z8jWOPIYkqFD
	czUJpYjr/3nSkRVxG8qjn14eHE5+3jaF3QzuUHJxVTRF5zwv05RlqYIAr2smK/0+
	Z0VtPiIVKCxrsc4I92uD8qIrLigG2clu4eVzMltycx6YWAxYgXSDyDS9muYGmxDK
	EeO67lPJCWeVTjiLZ9D+fmWQcJ+cg5Wi78FiyYLNJet6ryDmWVSu5foiEZ90J74y
	dUpnjnJPBgRFW2HF4WacjDnfjg6ikODeUQWbbcxdT5DCx+1PxWV/x9u6RHXrKUdG
	mJ0E1LKI65PgvNKcyenTv62UihDLn/KOdKCL5dguUt7gMH3PwtZNtbocS/pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730787432; x=1730873832; bh=DtfNjyoyKHah2GOxH1ObLOaR8hni855r4j0
	yqFHbY34=; b=QWfkl17CtSsRZ2hRKrO5ekmL0wGs2gQt1HyDxtBxSicKIVyEaV+
	gS7W82pJ+49TouaYm2EUpFUQVcR0HyyWzyA+vUSMNBVyia1iWWB83n29X5bW2GT3
	cB74fl/q3M3F7aLLlgWJFbp1ygMbVsD7QmnoPqLeMN+U7ntJqJpFX+3T5oDBigHV
	KJL2Hbwd6ZblAZ/eIc2Wzt0XkK0X7uyN8IjnjJaaMfBDM9WNvRJGx6GmFXSU/Um2
	m8QQkcVAn2GydzhrcnA/xxwDdn/vIqcgMOfvy2ciX6nZX+6j0MgV5f+r4VGO09wB
	u/UXR89dZCem6aJ9rQnJZDBgOo/k16pAVyw==
X-ME-Sender: <xms:aLgpZxzIA0eP705iU0j2FIEcNiMea1xKnzGDkhw7VU9eDiIDwUq0nQ>
    <xme:aLgpZxR4K6ytJp43c4DEnV5UvZi_opUjDQQNON-3TAn_eEoHytT7-PFHlBwdMyiX0
    LCBOteNSCji9YF4qw>
X-ME-Received: <xmr:aLgpZ7VwNF5Y5uVfYrdVg3yYELwENlIZtgYoX9KzYO6uTV11IevK32Tb511dUgJgc-0d2r-UPvAb1Czjz0iniSupz21-DDIeVva2vC7-uSIrdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhr
    tghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvse
    htthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:aLgpZzgHVluJWJOWDh-fCc01eStBgUsXZQ5AuQmsiQuaSTG6KmpY-w>
    <xmx:aLgpZzAnAaKQH6xEkFs9gF-AlvkCn3-UPoNsL1bPsTOvLVrLEBLKKg>
    <xmx:aLgpZ8Jr2UTLHNy-F8wg5_k0ML6n-QhtaHNTBM31pywz_TW7r6SEhA>
    <xmx:aLgpZyC_2Kwx7kuiK1SSC6t6zDq3Ynq6Bz84a4ENqZrb51q8ncuUtg>
    <xmx:aLgpZ-5SLC-XALgjTo5BIk59RN4y7B2pYL4ChzgCrCm_P6YUfUzQHurQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 01:17:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 96da6a67 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 06:16:49 +0000 (UTC)
Date: Tue, 5 Nov 2024 07:17:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 07/22] pretty: clear signature check
Message-ID: <58ebef7e757803bd7c2292f0494386464f2c581d.1730786196.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1730786195.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730786195.git.ps@pks.im>

The signature check in the formatting context is never getting released.
Fix this to plug the resulting memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pretty.c                         | 1 +
 t/t4202-log.sh                   | 1 +
 t/t7031-verify-tag-signed-ssh.sh | 1 +
 t/t7510-signed-commit.sh         | 1 +
 t/t7528-signed-commit-ssh.sh     | 1 +
 5 files changed, 5 insertions(+)

diff --git a/pretty.c b/pretty.c
index 6403e268900..098378720a4 100644
--- a/pretty.c
+++ b/pretty.c
@@ -2032,6 +2032,7 @@ void repo_format_commit_message(struct repository *r,
 
 	free(context.commit_encoding);
 	repo_unuse_commit_buffer(r, commit, context.message);
+	signature_check_clear(&context.signature_check);
 }
 
 static void pp_header(struct pretty_print_context *pp,
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 51f7beb59f8..35bec4089a3 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -5,6 +5,7 @@ test_description='git log'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 . "$TEST_DIRECTORY/lib-terminal.sh"
diff --git a/t/t7031-verify-tag-signed-ssh.sh b/t/t7031-verify-tag-signed-ssh.sh
index 20913b37134..2ee62c07293 100755
--- a/t/t7031-verify-tag-signed-ssh.sh
+++ b/t/t7031-verify-tag-signed-ssh.sh
@@ -4,6 +4,7 @@ test_description='signed tag tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 0d2dd29fe6a..eb229082e40 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -4,6 +4,7 @@ test_description='signed commit tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 GNUPGHOME_NOT_USED=$GNUPGHOME
 . "$TEST_DIRECTORY/lib-gpg.sh"
diff --git a/t/t7528-signed-commit-ssh.sh b/t/t7528-signed-commit-ssh.sh
index 065f7806362..68e18856b66 100755
--- a/t/t7528-signed-commit-ssh.sh
+++ b/t/t7528-signed-commit-ssh.sh
@@ -4,6 +4,7 @@ test_description='ssh signed commit tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 GNUPGHOME_NOT_USED=$GNUPGHOME
 . "$TEST_DIRECTORY/lib-gpg.sh"
-- 
2.47.0.229.g8f8d6eee53.dirty

