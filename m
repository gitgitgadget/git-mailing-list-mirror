Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498693F58FC
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781531817; cv=none; b=IiMMNXOxcO8mK+XEpxr4BVpm4HJZ5kmLIrHjoJ8SDaj8HAmks2SlAnYbTz/pLGfFYrP4oXAERcSs33E1H5uCGo1LDKZ4vmgj+/1p+C5Wg8u2lry7l5QSaX6Ot+QbGrVD/t7QmNm1EpkdI1B2vu715zHsl8/WxLlaKAe09ZEydCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781531817; c=relaxed/simple;
	bh=ajnwhHZntpdY3abGSfd8Rl/1bgDsTwNV/Fnf8snslyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FXo0fsGOGDRU+6hZy689GoQpJ1CG0qvEziEtn9QrMLiAcAfTnebtaqOvFx9e9UfiHA7XkP2nJ6uQoD6ENOz7cVt+aBM1fS5IjgY086t/1VI/wp3b+yux128jwvOp6FAjI0IfWu4G+HW50yMgGze3GO9Gj1isy0u3p/7/L2O4KkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IfqWZR3w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kCHLHjMc; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IfqWZR3w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kCHLHjMc"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8D2EB140008D;
	Mon, 15 Jun 2026 09:56:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 15 Jun 2026 09:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781531815;
	 x=1781618215; bh=lVj1PiKtvmpUMpWYmvIlpYQ3WQ0pw6Wp/PmuHl3Evxo=; b=
	IfqWZR3wn2IkQvrITJIDFtJwz6jSeu9m2HcTu7TLWbuz1NyWJsCZlaIVWgXtKkvu
	0RtGt+aFv/TeEmVl88rTTZ12u0QSKXGayE0kfx8I+rgMdAmwKkpPNRdtaG/g08UU
	p68T+wJ8SywUNiHWwevMnN+CGq4SeU1Sxuo0Yyj52CaANKiBdbWC8ubiGsunkUQG
	du1jyo/cCNkEQGlmUPBCExv2+74mN6RX8o0Xg9Ozfs37w10Zoz5Udc/V/t4taAau
	j9uMS9fTxgyYhIXsApe9WUkDt/E1YYm0OLDUv2WzHacc02n5E6ePeEW7XdhrwNYk
	w/JDMoRRXELFMcJ1f2Bjzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781531815; x=
	1781618215; bh=lVj1PiKtvmpUMpWYmvIlpYQ3WQ0pw6Wp/PmuHl3Evxo=; b=k
	CHLHjMcP+aSPg1zoeNFDBksL/gH2IBzXmaXKLD/b5VLKde4qerOvImiIHobUZkRv
	XgUJRrnebaXDtMDvYeafbWyGU8WF6/yIVuygByG3xgnNe6hVMCWvMq27ToMhUAGV
	CsBQOkvzy7b0MuycJnWrQdXurYxv0p6UBhaffLN1oQEz5MxJaY6uOBKfZstpL5HL
	b7NOM8gCfvDbZcQJ7cbzUNtIs36tnxlePvV1o78mWGXMJKAhywhgEi3KaLrXSTKH
	p6nnLtGi4tzsTr1+QGW9oGK/iBrzaoqGreWcFhFvA7C2NZgUhI9dzROPa/QBKA5e
	dnVo9si3eoyfoxPpX48lg==
X-ME-Sender: <xms:pwQwamA1BHlTkJGIPnObbmowYVCv5UngZRj4ce24J8kpVFcRxWonZQ>
    <xme:pwQwan_xEHW3dFXw705fJFFj6FN6jUWNGZZcJkOQgQuHuF8dMeaaoN40m3bbGxL51
    bxaHBiggvx25RUXZ4nEX5OGQmpuJSti30Ts1QHS08oMgbIDOl9kYOo>
X-ME-Received: <xmr:pwQwam_1wAifQ48_qo7c8YAT-qQQND2M6YwTOxeiLxPzUJrsDR3isNm-C-IyhAMezL1ISS5NxTiJKtY3SCbCEddWTiqB-e0mljOnR3082A>
X-ME-Proxy-Cause: dmFkZTF1FG+X5HxMGxOgCAZMy4A7SvmaeSo8nWVIUYom5oj1dQYaH7atcMinwTjrhcUyUb
    LZan+BOoi5ge9vWfhtLLsEJ6nozXuvgxf5Kre19hZamhgwR0kDzFxjz443r3LfEN0HSBzC
    eukzV1YjVJAegImryJKbJrBYtZbul/kuDL7+1mQnTd4ql7YGqXAGhhukI9FiiNwgCHqy+l
    BLSdjQUYerE20wsVpJRKZc4+wrOvLcOxsuKNhg33c7tdC3ovyr2Y8bNMARXZwwqqWISsz+
    zZJEPANDT/QdTsAiGkRM58RqOqc4pCnkclD6WNSyNVkuatZTyKu4DM5S4sdA8JUB43kSEJ
    SlUy2XKFf1oqxivzmhkO82+dcqHovlIek1EvunW56jOJSZyY8fwSjron2dbAJmGS5XcHUz
    plRYFozjupZVOQ6ciF3zVD7IeuZ5/bMLChqHk1G4XYkEtM+jYDoGk6bnAU2h1OFwzrr7Kh
    Ud8ZNTOAlKQMYvzuV5YZuznwmbMTuDoQOuNdNqpQetIrhWgUz//S+ozMSuUmMci7lE2Bgo
    wTpR83V0PzpRWo6O9i+M37W+45dsjahx1aw189SxeKD22Q91+/v3wPbq+K7+4MqOtB/66B
    U8NsQBPdSfC3Whh0QL4AHIRlalrfuUimJBR+Tp5Rr0xqjI7Tn8x7aJ32n3NA
X-ME-Proxy: <xmx:pwQwaue9yIMZtnpw_QIdDMJqLkTrH66_ZSxFkiVKYtTcwW-LZyDTMQ>
    <xmx:pwQwavHga0Q6fQWsPZux-XSHUK_YByMh8ivw31LF2lv_KHyA8g_o1A>
    <xmx:pwQwasfNxHStItACr3Nr3Gco--3T_hZiPv4FBgSOpyLMpdZdbMlsKQ>
    <xmx:pwQwapFx8ztumnO9Tm2co6zwz_ruq1pqPdJvHtNyk_Me_PFqFuPsFg>
    <xmx:pwQwamoZuAvi4uh-HPOrrxoEVV5VeSxYP9pFxW_nwgSEsEtQeQ9DuCjQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 09:56:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5619d558 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 13:56:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Jun 2026 15:56:47 +0200
Subject: [PATCH v2 1/8] setup: inline `check_and_apply_repository_format()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-1-f4854aa99859@pks.im>
References: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im>
In-Reply-To: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2

We have two callsites of `check_and_apply_repository_format()`. In a
subsequent commit we'll want to adapt one of those callsites to change
the order in which we read and apply the repository format, at which
point the helper function will not really be a good fit for us anymore.

Inline the function to both of the callsites.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 47 ++++++++++++++++-------------------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/setup.c b/setup.c
index b4652651df..a9db1f2c23 100644
--- a/setup.c
+++ b/setup.c
@@ -1788,32 +1788,6 @@ int apply_repository_format(struct repository *repo,
 	return 0;
 }
 
-/*
- * Check the repository format version in the path found in repo_get_git_dir(repo),
- * and die if it is a version we don't understand. Generally one would
- * set_git_dir() before calling this, and use it only for "are we in a valid
- * repo?".
- *
- * If successful and fmt is not NULL, fill fmt with data.
- */
-static void check_and_apply_repository_format(struct repository *repo,
-					      struct repository_format *fmt,
-					      enum apply_repository_format_flags flags)
-{
-	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
-	struct strbuf err = STRBUF_INIT;
-
-	if (!fmt)
-		fmt = &repo_fmt;
-
-	check_repository_format_gently(repo_get_git_dir(repo), fmt, NULL);
-	if (apply_repository_format(repo, fmt, flags, &err) < 0)
-		die("%s", err.buf);
-	startup_info->have_repository = 1;
-
-	clear_repository_format(&repo_fmt);
-}
-
 const char *enter_repo(struct repository *repo, const char *path, unsigned flags)
 {
 	static struct strbuf validated_path = STRBUF_INIT;
@@ -1887,9 +1861,17 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
 	}
 
 	if (is_git_directory(".")) {
+		struct repository_format fmt = REPOSITORY_FORMAT_INIT;
+		struct strbuf err = STRBUF_INIT;
+
 		set_git_dir(repo, ".", 0);
-		check_and_apply_repository_format(repo, NULL,
-						  APPLY_REPOSITORY_FORMAT_HONOR_ENV);
+		check_repository_format_gently(".", &fmt, NULL);
+		if (apply_repository_format(repo, &fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
+			die("%s", err.buf);
+		startup_info->have_repository = 1;
+
+		clear_repository_format(&fmt);
+		strbuf_release(&err);
 		return path;
 	}
 
@@ -2820,6 +2802,7 @@ int init_db(struct repository *repo,
 	int exist_ok = flags & INIT_DB_EXIST_OK;
 	char *original_git_dir = real_pathdup(git_dir, 1);
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
+	struct strbuf err = STRBUF_INIT;
 
 	if (real_git_dir) {
 		struct stat st;
@@ -2846,9 +2829,10 @@ int init_db(struct repository *repo,
 	 * config file, so this will not fail.  What we are catching
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
-	check_and_apply_repository_format(repo, &repo_fmt,
-					  APPLY_REPOSITORY_FORMAT_HONOR_ENV);
-
+	check_repository_format_gently(repo_get_git_dir(repo), &repo_fmt, NULL);
+	if (apply_repository_format(repo, &repo_fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
+		die("%s", err.buf);
+	startup_info->have_repository = 1;
 	repository_format_configure(repo, &repo_fmt, hash, ref_storage_format);
 
 	/*
@@ -2904,6 +2888,7 @@ int init_db(struct repository *repo,
 	}
 
 	clear_repository_format(&repo_fmt);
+	strbuf_release(&err);
 	free(original_git_dir);
 	return 0;
 }

-- 
2.55.0.rc0.738.g0c8ab3ebcc.dirty

