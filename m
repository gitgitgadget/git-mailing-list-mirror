Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B040F3264D9
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 06:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781765688; cv=none; b=iah4S+phay15DOkHgvaZ0WhTjztkWKxAgeRTj3HLFx46X0z4BdAUQb2ahbbu9G8mfuq5btSBCv9ahtHq6NqIm/QBIZgMjx1RsD4wEUytvI/a/p76Zulpy24qVCZhtAPBxN4AkbkV+NPC9FlrLF2oAemKEaiVbhcWTE02ZOGrXX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781765688; c=relaxed/simple;
	bh=6iQytT+ma4XaD8Y8ihv8fAfjiFFF6cxfpT2Q8HzU4ck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GY0TNtB5fviC0bYDU20Uf9kVfLrlO4uGAUTEFcyxaSun6ZQdXwgQ4eu/X4EYw9n3kPXGsWCtDE+RB/xvv3snsPDnv0RkOlTt8/AZBm0Vq3qg1HsnD+Y+3bq2Ze7Ux0s7w/TQcyTafoXwcKpXTb6DdrwnmiGnigdc415uSwC7z94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q8eXHgcu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ai7Wjztf; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q8eXHgcu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ai7Wjztf"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 1306D1D0006E;
	Thu, 18 Jun 2026 02:54:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 18 Jun 2026 02:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781765686;
	 x=1781852086; bh=4L3SB/SqfizwvKscCCKZB0nRNP8+MgPF2OX3QiLKdZs=; b=
	Q8eXHgcuNIx7Ez9Zie/sX/clGJZj6sQd8i2QYrBlF4ejpErdbA+xFtXLGtT2gTVi
	zZPYu2WGzeIf1rfaTvohZGC+lg81TSsLXUxu7wlpEeIgGao+7Z1K1tXA5wpXh9ru
	3PABk27KJAmSq/eKaWMnw4LkuBdXPtLDkHt/69+8rz3QYzwETQi2xXDPkP3FrtIm
	rMQ4aSUBwOzXph947fDWQRC8gPI9WAgnGcKijs6bCcpb5/LhQfNKoun+05iV/8dX
	v6+ETnpsqmjTIlo8IH1c2xjyZtBRJyl/7C/YPWrL8AOzf9gI8ZLn+A+5yaGJviJf
	CCP0aMxezOSJ8DAzNo478g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781765686; x=
	1781852086; bh=4L3SB/SqfizwvKscCCKZB0nRNP8+MgPF2OX3QiLKdZs=; b=a
	i7WjztfUZT+KVZneQh6To86M2yjyjn3vAsko1SXuROK/YaqzjD/M9B9gvsy4tCjN
	7DTctMT8hpWo7THap4EkNXdtASRYCfFdlrtbCgSN7MBdg8cqPO2WbCvcncYJCyJQ
	dIB1w+4G5+HTeVPTUJAC5U9/9MI42Om1JtWEM2Qz7nCEuuB4Xog6mudFh63o8Lgd
	qCpk7iKMjVT0VLTYLrAV27xOxLsxZrd6HUQbs9AjJih95DoNvMhhrr2HYovYARsA
	G6lKmyl68tGEnybSPXSKtYuUZpwm4MOgtcsYT4ToOAtZn9aNfy6B0AuVML7ZHkqy
	6pw6+po66JDFFQEzT0ogA==
X-ME-Sender: <xms:NpYzaluPMFSxhfWNQevKbfhutla2Qm_q1UTyZKA8J9mirfoRK6H6yQ>
    <xme:NpYzaleMi-7bH1CvVrjX1jq5Hpys-EZJrYom6uDv533nXMZenoqbahqfVm3vIKzLh
    Sq1SlzwrCPkg5yg1W-PkGRDIPs_7SfnXqhBZzJDFoAv9V2LL7FBrA>
X-ME-Received: <xmr:NpYzatz4njGm-Oln12QdJeH2h1Ex58IxzrNERWFiWFuOJJkVQyhgzcYctVKG7kwbyjcqMKh1RmvPqW-V_IUYSGu23CaH9gaE_K1x8InuoA>
X-ME-Proxy-Cause: dmFkZTF16Vc6Fi1Shyw28T76WpwZkHTVN+Wgz1OywlP32cWG0esYkIUzg//AHXodpv0DlG
    u1rxNG2Tba1tiQ2E35sJwpObqQCxjhpgtPWrjmWmzcltiQ1xq9rJOKaiFotv8ZgCAHr434
    3495Cq1kMuEQUE7F8vP58Y2zjk3OGK2suizKtlnYnTc3icPVoq2O+qvWiKSgoFBrivxRdt
    h3pQI4mgWTqH37zjWDXdU8k0MS+Bhb5fpE1yDBumZqvgfhkGr+1EIYzYY0NUY5XuQVshV/
    U5UJdmjP0HeOOxxozXhJ2QXPFMR1xqQafK2jirx91x5Yz+9aDkfmzWEJ11IJ+ZReG6iTZo
    Mf+YE37MCm9/vc2k9TRuywH61BlbZXtSBuq6A3IoA7xPXf6cxqL+6UUi95QqF7oOwuF/Jy
    zxx5fF28fLHGgNX+UwR9WcU6lIEshH0Ev4cLq14iFlINJpMbTvYjlMMh4cWb92j7vVhjIU
    hxO+bnqeoNkYqjqxREGwjYzepA/UX2r5Of4xb4ef53oQf2T90YVuG6KyXYDEV59/vV2XnC
    KuMJRmYumhi1btJzyKCVW3zYiItAM3y3BJDboTK5wf4eJTmsz3Gw8bL87k0eUsPPaUF2kT
    RvQ2c68b6OxomekR+xXvSzN0TNBUmDc5m/OCpqXMwF7EqmGkQpy3X/zjipdg
X-ME-Proxy: <xmx:NpYzarGrNQDFIzYFQ0G5g7k6sacfLkrmk4Uqo3V_i1sLzFsiNxylbQ>
    <xmx:NpYzahxWiMGbrTpLdYbBvgNLxBAp31WUQZy3OYvcE87APn0X9S7pvg>
    <xmx:NpYzassf0NylRwAgHVtM-liMaBNi0ssbeoK5fQ8hg3gx9XWCC2sI8Q>
    <xmx:NpYzau3-POK1IAFTfhwGS8CfXA62E2-5uNKu_gUGwBQ0dOQckPn2vQ>
    <xmx:NpYzam1WkdcMuQ9CK_fk4M6U8we_DrWrE4BPbA06ynnj76KfElCHLioZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 02:54:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 25f7a74c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Jun 2026 06:54:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Jun 2026 08:54:32 +0200
Subject: [PATCH v3 3/8] setup: don't apply "GIT_REFERENCE_BACKEND" without
 a repository
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-b4-pks-refs-avoid-chdir-notify-reparent-v3-3-2a5669e8f486@pks.im>
References: <20260618-b4-pks-refs-avoid-chdir-notify-reparent-v3-0-2a5669e8f486@pks.im>
In-Reply-To: <20260618-b4-pks-refs-avoid-chdir-notify-reparent-v3-0-2a5669e8f486@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

When discovering a repository we eventually also apply the
"GIT_REFERENCE_BACKEND" environment variable to the repository. There's
two problems with that:

  - We do this unconditionally, which is rather pointless: we really
    only have to configure the repository when we have found one.

  - We have already applied the repository format at that point in time,
    so we need to manually reapply it.

Move the logic around so that we only apply the environment variable
when a repository was discovered. This also allows us to drop the
explcit call to `repo_set_ref_storage_format()` because we now adjust
the format before we apply it via `apply_repository_format()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/setup.c b/setup.c
index 2748155964..79125db565 100644
--- a/setup.c
+++ b/setup.c
@@ -1906,7 +1906,6 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 	static struct strbuf cwd = STRBUF_INIT;
 	struct strbuf dir = STRBUF_INIT, gitdir = STRBUF_INIT, report = STRBUF_INIT;
 	const char *prefix = NULL;
-	const char *ref_backend_uri;
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
 
 	/*
@@ -2032,6 +2031,25 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 
 		if (startup_info->have_repository) {
 			struct strbuf err = STRBUF_INIT;
+			const char *ref_backend_uri;
+
+			/*
+			 * The env variable should override the repository config
+			 * for 'extensions.refStorage'.
+			 */
+			ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
+			if (ref_backend_uri) {
+				char *format;
+
+				free(repo_fmt.ref_storage_payload);
+
+				parse_reference_uri(ref_backend_uri, &format, &repo_fmt.ref_storage_payload);
+				repo_fmt.ref_storage_format = ref_storage_format_by_name(format);
+				if (repo_fmt.ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
+					die(_("unknown ref storage format: '%s'"), format);
+
+				free(format);
+			}
 
 			if (apply_repository_format(repo, &repo_fmt,
 						    APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
@@ -2057,25 +2075,6 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 		setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
 	}
 
-	/*
-	 * The env variable should override the repository config
-	 * for 'extensions.refStorage'.
-	 */
-	ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
-	if (ref_backend_uri) {
-		char *backend, *payload;
-		enum ref_storage_format format;
-
-		parse_reference_uri(ref_backend_uri, &backend, &payload);
-		format = ref_storage_format_by_name(backend);
-		if (format == REF_STORAGE_FORMAT_UNKNOWN)
-			die(_("unknown ref storage format: '%s'"), backend);
-		repo_set_ref_storage_format(repo, format, payload);
-
-		free(backend);
-		free(payload);
-	}
-
 	setup_original_cwd(repo);
 
 	strbuf_release(&dir);

-- 
2.55.0.rc0.786.g65d90a0328.dirty

