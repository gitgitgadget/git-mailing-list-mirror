Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359B01FE118
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 06:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730787466; cv=none; b=IAGmi2yROVND/WPy3XfThza2ONIMxJk9Jmu2wOPQrO90t9Fi+j4e9TPits5C5vtQrQrT6f3loZJHIUcE07hLt5wPdqiJMEPMhPHIbTuzub+FrhzOuE+6u4oiNVz779QDQhkPOxVunYLXgNGXUhAHoIeXkrsk4zs2mHGuT0P+PLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730787466; c=relaxed/simple;
	bh=tER77zLkNHaVI4HSWc660FkHOZDjAHpmGyBsZHrshgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iqt1huDR1WOqBBIlsekHhTErFAnorYndjYP0gok+VHsvN1ROLWbiTO0h6tWRQUBlBOH0bGSShM/w2Kiy4+agyaLBJKdDQnx+QYldcboQ7yMFBZFZxWgTTR8mJ0rb2zf2eLbWmuyc5wW3VwDRHweWPnfS58Ba4WsPZ3gPPTRj5VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kkAcpzss; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fjKHJxdG; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kkAcpzss";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fjKHJxdG"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 3DBC7114017D;
	Tue,  5 Nov 2024 01:17:44 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 05 Nov 2024 01:17:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730787464; x=1730873864; bh=km8ATBXjjV
	OHbJUaz8htu9O26G7DlzbNp+s6KIB5i+Q=; b=kkAcpzssLtE7DRPQVbeHWw+jjL
	a6xXpfBvEk+wX5BrSz+ChDa9amd7XtfaoJGVdcm07Y8ZKyLxUQTNfov3+JK8iFrE
	8kFU7Nk+mbsv3oG2qzQIx8Z7tOaiv5PQT61pygjObYBGxVsPHDMFqNGcKSCwygTA
	98ovuFJ8D25AGcxb7Ox1cntw/R598l/Wbl9Be4ESHZXFVol1zAQr9hMrLCA3bYCr
	xxzVR9ITamIgjAiUcNf6rrKVnpBFyTkeD9/Ebs8mFvkcN3GF2Xtgwti6XiuIgKvS
	2TmTUfDQAj3un4kzXbVwOthZ9imm4ixZxj/FVX8nL6o7YVNlTXhQvG1WrQig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730787464; x=1730873864; bh=km8ATBXjjVOHbJUaz8htu9O26G7DlzbNp+s
	6KIB5i+Q=; b=fjKHJxdGNVqCPySWWgfu7WWUwj17Sltt1fdHH03QuG5q9aBmff/
	/iYtju13vQPtUQ+Z5WI8pIsN2jVCBz3ZxDKS4N1SMvTb5c0Ky0Rr+IgACIXtCBdn
	ivItv47JLEquflr7vyVKeAa8SJDE24uwUBBhqZ5XnVoB7N1kYMlPJVvSqpCstaMm
	ZBRbT1f7oKeLVQ/JGy1gA0htbtv9xBgJmtOr5OS0Vyzo0GkpAuc7FJ4gzkiGnqzU
	9H7A55Sqa4sUgtN2rs6YbOUq0+NTGSrxZPqlix7pC2Av9mDOite4T1COt7i4LW2f
	KF6sVhR9hq1chK4aIUEPFonsSRTrLWYp6Sg==
X-ME-Sender: <xms:h7gpZ-MzxDYFCseiNMrrVdlGcGWpkhG2WDikcvp-ahlrf1ormmJWNg>
    <xme:h7gpZ88lYo_W3Mo5VOu0UcfSXPt8HT1JT0NNObZGHLGR8uHH-Rzb6eRdeiVP4123R
    e8g58IH1yK7xNYDqQ>
X-ME-Received: <xmr:h7gpZ1Rr9o7FK_AdNnVQMUcV5Z-XppbK9v5qfv6L2kEYOVd83NeMmWrEihOVu6JLuBih9u_O4Xj6aSTW7k8kEzDYY9XGgR0vx-CN-4Hxy3zOiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhr
    tghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhr
    rdgtohhm
X-ME-Proxy: <xmx:iLgpZ-uWrFFBuJd8dJtvY12mq6C9rs8EytUr8vY4M_veX5JwlKXt4A>
    <xmx:iLgpZ2co-_w7dX21uFT3d1dfEhM93g1yG-p1jrB_2C5uKvULkz6sRA>
    <xmx:iLgpZy1aF280CgmBtNK1CdHkuGJl89xSp9K5Hqp0QorBsf31Lb82Pw>
    <xmx:iLgpZ69kD-J2xoIhfUfqfkcqmV0kItGR3ey2DhjMxBgFXFk2S6qyyQ>
    <xmx:iLgpZzFEp0FtScE61_8LfqtkK_wZpQ4eGkW2EBjC1TG3QHd3bewUzQ8x>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 01:17:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3a9b622f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 06:17:20 +0000 (UTC)
Date: Tue, 5 Nov 2024 07:17:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 16/22] dir: release untracked cache data
Message-ID: <b248f266a91480a84744b241496894309e5a51ca.1730786196.git.ps@pks.im>
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

There are several cases where we invalidate untracked cache directory
entries where we do not free the underlying data, but reset the number
of entries. This causes us to leak memory because `free_untracked()`
will not iterate over any potential entries which we still had in the
array.

Fix this issue by freeing old entries. The leak is exposed by t7519, but
plugging it alone does not make the whole test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 dir.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/dir.c b/dir.c
index e3ddd5b5296..cb9782fa11f 100644
--- a/dir.c
+++ b/dir.c
@@ -1056,6 +1056,8 @@ static void do_invalidate_gitignore(struct untracked_cache_dir *dir)
 {
 	int i;
 	dir->valid = 0;
+	for (size_t i = 0; i < dir->untracked_nr; i++)
+		free(dir->untracked[i]);
 	dir->untracked_nr = 0;
 	for (i = 0; i < dir->dirs_nr; i++)
 		do_invalidate_gitignore(dir->dirs[i]);
@@ -1083,6 +1085,8 @@ static void invalidate_directory(struct untracked_cache *uc,
 		uc->dir_invalidated++;
 
 	dir->valid = 0;
+	for (size_t i = 0; i < dir->untracked_nr; i++)
+		free(dir->untracked[i]);
 	dir->untracked_nr = 0;
 	for (i = 0; i < dir->dirs_nr; i++)
 		dir->dirs[i]->recurse = 0;
@@ -3573,6 +3577,8 @@ static void write_one_dir(struct untracked_cache_dir *untracked,
 	 * for safety..
 	 */
 	if (!untracked->valid) {
+		for (size_t i = 0; i < untracked->untracked_nr; i++)
+			free(untracked->untracked[i]);
 		untracked->untracked_nr = 0;
 		untracked->check_only = 0;
 	}
@@ -3905,6 +3911,8 @@ static void invalidate_one_directory(struct untracked_cache *uc,
 {
 	uc->dir_invalidated++;
 	ucd->valid = 0;
+	for (size_t i = 0; i < ucd->untracked_nr; i++)
+		free(ucd->untracked[i]);
 	ucd->untracked_nr = 0;
 }
 
-- 
2.47.0.229.g8f8d6eee53.dirty

