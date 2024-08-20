Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1615192B75
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162722; cv=none; b=mfVH0m79U1F339DsvljC1utQCeK+LSS65f2vo8pFdNhXHLbo6PH7dn68dBbiPhz0LoYNiJOW7PLM2Qm5P5jRuHXlHzudW17ifgZ502Uz2IUNk2U275S6kcxfBK7AZG66/vccOocGDtKO2oIEN1c67TqcsM1z2UYUqXn6/lNvhvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162722; c=relaxed/simple;
	bh=RD/cK3mC4lUaj4UwE53PpF5kS6UriEKuPl2+kl278jc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nna1qPtT3rPhIgbbkmqJ52eooajBhgDR8IzRLR3grghpaAL6T8Gg1C+tA1Brh1ScZZ7pxUEkrn46HbxXVWqNj65KYKAl+Sl3asTTtOzhsNLOXsFjXNhstCBjJ3Ub1Ttcjpuhr/9p5mPCDfWNNtC3+bYzJiSCzibcdYLXjaQrFjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VUfvsNyS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e9k7qs0E; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VUfvsNyS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e9k7qs0E"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id D4924138DE37
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 20 Aug 2024 10:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724162719; x=1724249119; bh=TkdvvUFQnX
	JW9DvvlXb0iAfv/ehBZynAZUdHVdUP3yA=; b=VUfvsNyShD29wlf5tlYYfYK7H2
	pdfILzXdxe+e5rP0Us0gaGdundqlJDHHt9attz95fVer2x6qL+Pdt8U9qFu6BLau
	CJskFqatv56iEY0q3aNJzG5Pg48n0DTc0pOdKrOicpdFtLFaNKqEsZ4LV9cX4FRI
	FKYfgV91eFc4RR30HpSm0bBXSGZNjeyZN+A8o6pHM/sEFBrcYJ4/aWGcq1qw0bWx
	FMTydPWoxtUaGGeX0Dt8ll1kPaZFVBmwgXvFo0gyl60NRnrVZi5fBcbOtjkfRU7g
	ZG18D8qywJr9IoCLe/iEokxIBB1xhraQW8SLcm7It9CMuwt34MA2lg56RDDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724162719; x=1724249119; bh=TkdvvUFQnXJW9DvvlXb0iAfv/ehB
	ZynAZUdHVdUP3yA=; b=e9k7qs0EdjOOrXpGGngAmgaTpahhUKNyJf7kSPhkfAb6
	REKzdHrXqCDJoVnBjDWRwGU6470Q9dmmyYZMtOuJ2pwuzvpNLRBNeVQ9ukF+9Ku1
	qTIu6N83xhFehM2VZrZeEwSvFswFEWdmAKd4IZmFu1ue5WzBtLNZ+bYa+wFbP7tL
	OGfkaiDRQJbEKDUQkZ4JrsecvXBD4LOpKmRCbLpBKkIw+yllujo8eWieHLXk85Ne
	0De3wfd/NmQMX+x9JRY6bxTEFidrBEmzLz6m48b7gejpUe5Y6gnLvQ8ABqZ0y71L
	DOvXUCnfGEefDAvx3kZGM7Gzzj89DwVm7BERspHcvQ==
X-ME-Sender: <xms:n6LEZgbAuR5eWFjwoor5z4ABpRTbl4I5_P_PMlHkLJ-rQSXl9eyqYA>
    <xme:n6LEZrZCGnk9E34N1hRZX_X7jj-XZmz4Rod_sPt2YC59G_sECMqMwEPMTIYSmynrA
    D0B5WKSgI8hOZJq5A>
X-ME-Received: <xmr:n6LEZq9DRnMyvKwe9_JKn_czozoAO8hSVO_sXPO8sXkvJ3XCCIL77eMEwxKiYwAhomYwxdIwgq22HFpkRHBksAti9nm8jxacNdNu43Rj-AZ0M-vrow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:n6LEZqp38aEjoIyG6P_cN7sWX9M5kf0NyQmQKNoyHXzteaHuNaIn8w>
    <xmx:n6LEZrpzTt5v8SkFvxIegmmaeuqlkkY3Lx7mX9JmI2B6imQlodqMKw>
    <xmx:n6LEZoT-vp8Jm8rsaRLp2zQdfcesiJJHIEdqvTqAH3jacn_YalhNAQ>
    <xmx:n6LEZrqHSimMSJ2iKiR1NuRPysX5r15pr2uE32iJPpo8YuLF90ILXQ>
    <xmx:n6LEZkAOXNaNm5TdTKadAWGnis51I4PxUQ-m8_FXCqjs2HhB6cfSo1gR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 643cc76b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 20 Aug 2024 14:04:48 +0000 (UTC)
Date: Tue, 20 Aug 2024 16:05:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 06/20] builtin/upload-archive: fix leaking args passed to
 `write_archive()`
Message-ID: <5b05a3252185d2cc817006ef587a44b423b8bea6.1724159575.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724159575.git.ps@pks.im>

In git-upload-archive(1), we pass an array of arguments to
`write_archive()` to tell it what exactly to do. We don't ever clear the
vector though, causing a memory leak. Furthermore though, the call to
`write_archive()` may cause contents of the array to be modified, which
would cause us to leak memory to allocated strings held by it.

Fix the issue by having `write_archive()` create a shallow copy of
`argv` before parsing the arguments. Like this, we won't modify the
caller's array and can easily `strvec_clear()` it to plug these memory
leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 archive.c                | 10 ++++++++++
 builtin/upload-archive.c |  8 ++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/archive.c b/archive.c
index 7bd60d0632a..9ba96aae4f7 100644
--- a/archive.c
+++ b/archive.c
@@ -736,6 +736,7 @@ int write_archive(int argc, const char **argv, const char *prefix,
 	struct pretty_print_describe_status describe_status = {0};
 	struct pretty_print_context ctx = {0};
 	struct archiver_args args;
+	const char **argv_copy;
 	int rc;
 
 	git_config_get_bool("uploadarchive.allowunreachable", &remote_allow_unreachable);
@@ -749,6 +750,14 @@ int write_archive(int argc, const char **argv, const char *prefix,
 	args.repo = repo;
 	args.prefix = prefix;
 	string_list_init_dup(&args.extra_files);
+
+	/*
+	 * `parse_archive_args()` modifies contents of `argv`, which is what we
+	 * want. Our callers may not want it though, so we create a copy here.
+	 */
+	DUP_ARRAY(argv_copy, argv, argc);
+	argv = argv_copy;
+
 	argc = parse_archive_args(argc, argv, &ar, &args, name_hint, remote);
 	if (!startup_info->have_repository) {
 		/*
@@ -767,6 +776,7 @@ int write_archive(int argc, const char **argv, const char *prefix,
 	string_list_clear_func(&args.extra_files, extra_file_info_clear);
 	free(args.refname);
 	clear_pathspec(&args.pathspec);
+	free(argv_copy);
 
 	return rc;
 }
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 1b09e5e1aa3..313a8dfa81c 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -22,6 +22,7 @@ int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
 {
 	struct strvec sent_argv = STRVEC_INIT;
 	const char *arg_cmd = "argument ";
+	int ret;
 
 	if (argc != 2 || !strcmp(argv[1], "-h"))
 		usage(upload_archive_usage);
@@ -46,8 +47,11 @@ int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
 	}
 
 	/* parse all options sent by the client */
-	return write_archive(sent_argv.nr, sent_argv.v, prefix,
-			     the_repository, NULL, 1);
+	ret = write_archive(sent_argv.nr, sent_argv.v, prefix,
+			    the_repository, NULL, 1);
+
+	strvec_clear(&sent_argv);
+	return ret;
 }
 
 __attribute__((format (printf, 1, 2)))
-- 
2.46.0.164.g477ce5ccd6.dirty

