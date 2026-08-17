Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163BE390C94
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 05:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786945201; cv=none; b=Yc4JeGv3VZdL3oU0wc8IgANy5EQTkTEM4vo5ZeXHeQJpKNYctJ1nepLIBlXailXAuiuOBKvYQKAaalNW0k9FFtlRN3RvRXgEcG9bFAhZGspUJSOVbGYh38s+KY+bWXMEYN1IHfZhtXiq5qpGYhEGuGbbgI5TGLsUxrU/kMD9tXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786945201; c=relaxed/simple;
	bh=GD62TlUTWUm+AZgi27uN3X02rRNdClgg1hpBOK5iRNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qbr1wmQzcbnWiKgOCkBptWS/egfzAcuid1W5QFuxHBU2oeluY1toQIh2IP1jbSbViivtrh9tkHoMXhCsDUqm5D28CMcurbNmYh9af9T4E4Ji3VVfjurbnfZOzLScu5NmbS/ofYQ+DYcTtVVkZh+lNd1OEjUnAdV4ijSk1G48hRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EYYCE3qx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MLTboTA4; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EYYCE3qx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MLTboTA4"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 5E1171D0011C;
	Mon, 17 Aug 2026 01:39:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 17 Aug 2026 01:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786945199;
	 x=1787031599; bh=+/cpgBcPZ2mAaKOL6SlDscC19Jd+HNHR8MNhz4GTcTU=; b=
	EYYCE3qxjKOpsca9dIA0KBZF0hKNdmqCLUwJNcZMlp77G+QoHCe4fNdas0+6aIsb
	Fz5GlOEh/Moc7Q7HciONSsPczRWUP32ajvwbxuu6TBERfFpB5MgmcIzKWuboEtEZ
	qzCSB8ZdYYREFUqDhLPnfiqeryPjJb2BMOokyjXFbVrEe772KjMwnHm5XdIjmApB
	VFhddktp75H+C+M8gTojMx3LPQbypSGTspIKXFqHadpST8c8Hko+epPtKVAfO/13
	jrBGdivrUhzTpicMNiCEuVgJpBfUiDaOK/3JTUkpDyus/8NadaWjv6XVehI5NQjt
	WMqa4Av/99KQ1v5nv/PUxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786945199; x=
	1787031599; bh=+/cpgBcPZ2mAaKOL6SlDscC19Jd+HNHR8MNhz4GTcTU=; b=M
	LTboTA4fVK+c02lRo+JEmsXOfU8oneyqX+NxQYiHaiBWZ9DnQVzIIpOGINLdAO80
	JIpIvdEe5O8PtVAyS4CIyzs1tCeShBiMk+2QIWplm7AgXsQsAkBMIHfbMEeuefJc
	hiNXDuoX9aexSdOUYYDVdY2/FjvBRWfxzsy7CXhaqN+1f5CFMIM6+CS0GLXOT+O7
	GqyFurYFgmg+wC64UPl+noZgk9bvq+Lhs2IY5dqIqErdJ6dDsGcN76ZzSiM0XMH/
	W9y1J3S4vb3Ntc8q57oCZ5UZ3JS/3+x/W0PufJnIzWbuaoQdymVVaxj2D6iYoDUT
	lrMiwHEu63EA5hLiwI8sA==
X-ME-Sender: <xms:r56CaiILjQRwlekc27Ep1Vr__0I54TqrRSsTfutl0c3oNsWRyonDDg>
    <xme:r56CagLp-T-7wy9n8INibrAIyMpqwwXJctsuJSEyFWQuZSFx1LBg94OzIIjdBV6Mp
    UgfmfxtPRmcTtlBI5UGlPmUzxaAtw0sZ3SrcMyL9ryx9diFKZhlVg>
X-ME-Received: <xmr:r56CagX44IJhar35qhnsnncOJK2tDmHXFQ6VGBIA7_UJqgGnmO2WmEx2w91zE9UDODyqD51_5RfMg3-WyluxBeUOm8HS8Afu4x6oi7QjxA>
X-ME-Proxy-Cause: dmFkZTEI/ntatRUg4uSJOdtsVQxV3BwgHyQQhvn3IH0rE+kDrN1Evc7BD9mUecWN2oSRl7
    SxXYAW8/K6E4ruoxvs4iahCoMy/aDavd9wiuvjmv1pA+C2KyS+Vl37sb6eFuRj2zzKm6Hx
    fGgsAC3XEZMEKqXWSpQsYY+1VD8d2OYndD9n/aaEVidluL3W724Y3X9bdmJwBXgCWS6biD
    VAsYYB5qCHPBG6LeMIN/rn8Ed8AMmJ3m9W1NK/q1pMm0eeuKMSLrFJDQE1ePlX6Ikla35G
    iofsr4HtzJ5VYDuZKrCM+3UJ1itFhY49pSO0rt22zqUbVcdaOWDeh4X2AL8EOZ4DCxnKLm
    lkC1LZhUUvRO/PG0lJmBZeII74n2PvdB7pWjPXS5//qrm43FzmH1PXYaabQFJY9ys8jFH1
    Zs5KPNukVUYaoksNGyiq/e9LUYyCcnyye3/AUxY3lZNi+IJNm1l2i6FjsC0Qt539rQxp9Q
    7cAyDrysDHDrLhCQoGjeMOXuy3Vim9S7BcfQTCVIDhDS/Nl3AfAVoQwzC/FkGjXpdIJTZu
    JfAr5dOrmFq4bvvBsuKaBahe3rFwBMDrPL7sGkuXXsdJKGU1EN2raVuPa+HhR56ReByYYI
    TH6wsQp84PT/sUmWVT9ahZKKUTeysa/W8a7c8BWfi9mm67ThrCcVHwHb3rrQ
X-ME-Proxy: <xmx:r56CaihhFPvALzSjWPDhnphkHf9m-BbkQBmucasucjv389KD2p-Stg>
    <xmx:r56Car_LnWELKVPjEo92mDsaYLYDzzNKENfUY0LgY9gaGv-U44UPww>
    <xmx:r56CasBF6Wg28ZTSdOYxj7innCT2MLcEmvoV0UeCAzRE9BE7_BlZSQ>
    <xmx:r56CaoLlkehuDlKxq_jNicSgnsKQWDfWrSUntkJ89RWL9BpYTYj0hQ>
    <xmx:r56CalhSwBjuRqwen0sDbiW6TQARAhGeU1cd2zZdxYTg05CrjpmQdU5F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 01:39:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 92185ecf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Aug 2026 05:39:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 17 Aug 2026 07:39:45 +0200
Subject: [PATCH v2 4/6] builtin/bundle: refactor option handling for
 progress meter
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-b4-pks-odb-generate-pack-v2-4-4c8a96ccfdb3@pks.im>
References: <20260817-b4-pks-odb-generate-pack-v2-0-4c8a96ccfdb3@pks.im>
In-Reply-To: <20260817-b4-pks-odb-generate-pack-v2-0-4c8a96ccfdb3@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

The git-bundle(1) command has a couple of command line options that
relate to whether or not progress should be reported. These options
match the options that git-pack-objects(1) expects, and consequently
they mostly get passed through to it directly.

This results in somewhat of a confusing interface: there are four
different options that relate to whether or not progress should be
displayed and how verbose it should be. But in reality, there's really
only two modes:

  - "--progress" and "--all-progress" result in the same outcome, which
    is also documented as such.

  - "--all-progress-implied" does nothing as we pass that argument to
    git-pack-objects(1) unconditionally anyway.

So in the end, the options only control whether or not progress should
be displayed at all, nothing else.

Refactor the interface to instead use a simple `progress` boolean. This
makes argument handling a lot more straight-forward and it prepares us
for the next commit, where we're migrating git-bundle(1) to the generic
interface for generating a packfile.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/bundle.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 1e170e9278..bfafadc984 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -70,35 +70,34 @@ static int parse_options_cmd_bundle(int argc,
 static int cmd_bundle_create(int argc, const char **argv, const char *prefix,
 			     struct repository *repo UNUSED) {
 	struct strvec pack_opts = STRVEC_INIT;
+	int progress = isatty(STDERR_FILENO);
 	int version = -1;
-	int ret;
 	struct option options[] = {
-		OPT_PASSTHRU_ARGV('q', "quiet", &pack_opts, NULL,
-				  N_("do not show progress meter"),
-				  PARSE_OPT_NOARG),
-		OPT_PASSTHRU_ARGV(0, "progress", &pack_opts, NULL,
-				  N_("show progress meter"),
-				  PARSE_OPT_NOARG),
-		OPT_PASSTHRU_ARGV(0, "all-progress", &pack_opts, NULL,
-				  N_("historical; same as --progress"),
-				  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN),
-		OPT_PASSTHRU_ARGV(0, "all-progress-implied", &pack_opts, NULL,
-				  N_("historical; does nothing"),
-				  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN),
+		OPT_NEGBIT('q', "quiet", &progress,
+			   N_("do not show progress meter"), 1),
+		OPT_BIT(0, "progress", &progress,
+			N_("show progress meter"), 1),
+		OPT_BIT_F(0, "all-progress", &progress,
+			  N_("historical; same as --progress"), 1,
+			  PARSE_OPT_HIDDEN),
+		OPT_NOOP_NOARG(0, "all-progress-implied"),
 		OPT_INTEGER(0, "version", &version,
 			    N_("specify bundle format version")),
 		OPT_END()
 	};
 	char *bundle_file;
-
-	if (isatty(STDERR_FILENO))
-		strvec_push(&pack_opts, "--progress");
-	strvec_push(&pack_opts, "--all-progress-implied");
+	int ret;
 
 	argc = parse_options_cmd_bundle(argc, argv, prefix,
 			builtin_bundle_create_usage, options, &bundle_file);
 	/* bundle internals use argv[1] as further parameters */
 
+	if (progress)
+		strvec_push(&pack_opts, "--progress");
+	else
+		strvec_push(&pack_opts, "--quiet");
+	strvec_push(&pack_opts, "--all-progress-implied");
+
 	if (!startup_info->have_repository)
 		die(_("Need a repository to create a bundle."));
 	ret = !!create_bundle(the_repository, bundle_file, argc, argv, &pack_opts, version);

-- 
2.55.0.739.g4f2b995119.dirty

