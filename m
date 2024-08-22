Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F4117CA04
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 09:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318252; cv=none; b=AIE7igk65/EXM+K/qpb7MRRLMNDMZfrg3OTF7nydPvAkikmfu2D+vmGjm3kTS4HutlQtCgcgOREkerazPjiRgjKkAc2WqIbVGACMY8ovKl0D7RXSZseRyVYBlnXsOg+LLjrpKkLUV2zEPMWeBO2SoFmYItMMXNo7UD1GhdfdkW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318252; c=relaxed/simple;
	bh=RD/cK3mC4lUaj4UwE53PpF5kS6UriEKuPl2+kl278jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/iU8bccKZ8F5YLh2bDPsNLn93IPD8hgNgVW22DT3Y4mHi9QIv4XgVXdiXvz1wdYWa2MXtu8Ziqb5+77e3aGGuR2JJuHTwAy6700hLexg36M5DUEoHm6wPMFDE0dYDwikRPQ5xzvAkHe+Y6xvDqYlt7LW0i/CL2Q2KDu6EnHVGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LJOEEHN7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WGLcyxkH; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LJOEEHN7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WGLcyxkH"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3EA0F1151BBA;
	Thu, 22 Aug 2024 05:17:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 22 Aug 2024 05:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724318250; x=1724404650; bh=TkdvvUFQnX
	JW9DvvlXb0iAfv/ehBZynAZUdHVdUP3yA=; b=LJOEEHN7gNE+A4QEPJaQLCApwG
	iqcvKWYcYJ7KkGEtb3F6ElpUfICkYxL8zDV6xgl7DIIR2kPvrb3ASSpqpHuGvs0t
	pi2GHNJ7Df1hw9aPLMRdLc8iaCjIDyQgfrUivruwpmvtXNBAU+33q2qnvrLZ6GQm
	cHVuCtUNDO4ZBc7OctdWTN9UdxOfM4idB3R9Wz/f7ZbWPe4+LzSZDLfbBWjTGziO
	VvbQPMRDOKj9zTfYk6j83j1bIWINFroSnrgSj8fJjn+ujZNSFzy/X6yEY2ZR4rO4
	Ac/96GaL2SQxJkbp2MovxXstUCNw5v05HVICHd2m13g7MYpI4qtAYa8/sM9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724318250; x=1724404650; bh=TkdvvUFQnXJW9DvvlXb0iAfv/ehB
	ZynAZUdHVdUP3yA=; b=WGLcyxkHjN/k91m1w7MrEaFGpNDKdk2ioOogs+F9GiWF
	LLnEq+pnT4TTgrFJa6m5VzFXaYPv204frA3EO7D91Xlco6a48EUNS5ZpaVn8kiUi
	HQDO/YijAG+B5sgx0miXuSX2aP7BNXrdPCf/P9QPgN1uB/tSFWNi8oS5gss+B4uh
	usEki35DkNUxEphlSLBQobZhNvV+hxx/ISCTUgzJYM3X6V/k1ABxiamYvad4SDT4
	U9Spp1Uzi2mJGSu+dg1VPtvvjdMU/PrVct40LfuheFqxyLqMVft/OkspbzNtDYhE
	ThR0IXS58ifTzoeOzF8D2NVy+Dd+30pbXzSv/4Hn1g==
X-ME-Sender: <xms:KgLHZkzW0hxFgkrF740VtzzuP6Uw99eCHdTK6sU0Ow8hcmXB7MtPJQ>
    <xme:KgLHZoSiU3DgkEJgidWxWiaemeJl4sTzwo_uKgpRcoY8syyZykdynSO8cTcG5t_LY
    yy67dKwyWUGg3t0jA>
X-ME-Received: <xmr:KgLHZmUirzjHo6_iKONdIQaC0P1FtbS9C-dl8dt2VHTf9Sd1Nqw20r8echAY2EIcBB78v_7x0uwM1hA8YVklVfhoKxEY9HEyZbm_JfdIhCjmPSo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:KgLHZijPdwtjZZzpoP5se9XDQ2LHdHbf0ajnnNSA9UHOts4ROvLfiw>
    <xmx:KgLHZmDoRGvvV0ff91jbyitP-deniz39174xcXox_vRLqyfIuVsa8w>
    <xmx:KgLHZjLNg45hkCBd_E1GVtH5Td5YSRx7SQHlPic3s9D_PQrTfTVg3g>
    <xmx:KgLHZtDbLhGFn19V01wXVs2g35CzcWgi5fKZYoBI7rlONiJKMWfz3g>
    <xmx:KgLHZpOh4JJ_Bsp3r9-MxvQkS_XBClyWHoCMU66zv7s2TMI4c-4vKIAF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 05:17:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c699e63c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 09:16:54 +0000 (UTC)
Date: Thu, 22 Aug 2024 11:17:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/20] builtin/upload-archive: fix leaking args passed to
 `write_archive()`
Message-ID: <afdd7f90b13511b8e842026f8ad43c9783e19231.1724315484.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
 <cover.1724315484.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724315484.git.ps@pks.im>

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

