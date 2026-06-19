Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4094037D11F
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 11:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781868492; cv=none; b=Q9VoMM7PpB4bNdGbhlD1835mV2gpdQZqDAMnGeSf33g8CSueccTPG5BdujFtKlkSSGZ9fgR05u27qDR0Zx78XqrwILyLMAY/RwnsTY6dyKkt/RfOiHL2ohE41UrYpoNmxWqawWeRNAzbazA9R8blQlN3GRJFuvMZ00NMGr+IDho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781868492; c=relaxed/simple;
	bh=vkud9RetS+VYImZ1nyFuSyBqrRfOlsSOCrDuS4WB2Ew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C11vGjiNOutY7kz9RTBFQF7gdxEBdUF4wDw7edtUbaWIWr7JT2vBmCdMinA3aFrEZyiT/HgRJXFPfQWDS/wntqmHXjGYmRV1W/upjR7jOLHYf4N+zD6UKafzsUjaPBXIUQGy1/lmFl2CVXv+uHWtuHlV3SoXiyU5qZ0F8xtfP3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=t9uNROF4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jztg4AoF; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="t9uNROF4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jztg4AoF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8A4EE7A01A1;
	Fri, 19 Jun 2026 07:28:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 19 Jun 2026 07:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781868490;
	 x=1781954890; bh=WUZSY4N/IAz8DgJcLvUhqCu9ixWciTFyX74aIW51nq0=; b=
	t9uNROF4Jxm72A0DWC+WUFA5ii/wT9HUlQq3sZP9kDXLPls5BjKjjxDVJMP5qMmu
	y1WtLXPfVFJav7H8f/0vQAV+CLbj1o8q4/fc38Vayw3F4CwU4m6ALqjmK07bzF8C
	Ws5qQ3EHZG3LTFmWSRcqpJaA1wuwK5PIXsTjv46rYG4hDKqsZ2PQx3m0na4QbVrM
	Vea2sF3IZ3noAfeFk0Gvs3ChbQz4pBkOtH4Zk49pwS1m8Q/U7057gBcCPPzjiPtz
	ei4G0hPNO+h7m082ujCIKpv7klU4fg+xGK9yrbTF7IDt2kzOHYp7QA+wsPjHCpFj
	KXg9oNxyCy4RYfYw8tiupg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781868490; x=
	1781954890; bh=WUZSY4N/IAz8DgJcLvUhqCu9ixWciTFyX74aIW51nq0=; b=j
	ztg4AoF0xdfOYhqKQqMomdF660H3FoiKw3ViQPKLbQ3wiWtyqZuBSQ1GzkRj/o0H
	aHznogaEg8SHdjBSFC5S+VLerIKm0oX9Bn7wKEborlx1NAnG3HG35uZNVGmvdvuv
	vJNLLzL+rWu89jcaKJq4ARVXwRao8BJLthO1w9ffRMzlphM9OvklLclvThPquaWo
	yCsxPMzax5ZVChAXy7E1uLmk39cCcwBlekCl2w/oLzLRD3ELjoc6Ay/bpTmgcK04
	GsZ0TLNoll75Dp1bG/tagpvo/xE/fnOk0U8pu1Xgar1JeYPBnjkgQcNk/BSVPVKy
	ZmNdnEZsYi/mzZ1bWFNpg==
X-ME-Sender: <xms:yic1ao_9iPYA82oNAAPQZwFuAQa-wyHKpPlMfpTlw5_ix3hBAJpfLA>
    <xme:yic1answJTGGYqis5HCkNOz608kDRucdgm0eJhfBiU-dTyVN5wNzW5Uy63X6dyf89
    sNOfHALeNv6r1g94rOX7To_9TogBrLiKGpn23h1xBlPvRvEXDe9sg>
X-ME-Received: <xmr:yic1ajA0sh9URiz9ywqwUlW2xJU9UQBRRdwxRek1APBN_dCbeTXuSwh1KhiJ-HAdwYhMvdBsRxoM1YLQanRTN3NWdzAsKjciya9qjhmDWq4>
X-ME-Proxy-Cause: dmFkZTEde8rkG7Ow/YQajJOxpUKYHnTWdG0AUznTDLiHmSMbSqWzB/6nKIAIdk1nkTwS0K
    C8jTqdNp1V7h/KMFCwexCiiwcxkUoPM3XGMXsNXnEqixWMufecGwaAXNpfHOfwmwhgziKB
    gEME1JUhRUF4zEWjEcolbPL4SS80OZZVhDQXhaESCZsPSITOIFAzr9mdv/wwDKbMEUglz6
    Lrw5108LV8TWN60J1S3iQg3WXtzla3Zx7Q2iJ+qofdJhYzq3vyVO5Ie87s6Y7SykEWxrmz
    /vmzMKfUyKVDBOQcXezzDDbfTiNE3Vevxi8qzYGVvv3v5UE9OxNTzNX4wxQEWsT+cwQAXL
    MrMvNSReIcDwcrq+ZlWp1bZCZVNbkVVWq/blreFr9Qnm+r+wDd1Iz62LaNYKwxsjsyHn3y
    II1r2sWfFjPqvTpSyGsNUooqITGomC/Xlgfw56UrWFsLh0+g/DpqsrzDi+uNa+wMs5ULAQ
    cP0gFz9tD9pncb+JTWPDtBQZon9vxVcRQf6BpCEzVvZ+9wa+wQ4zR1F6Oq13WfiDtmSvdQ
    ZLGtJi+/ydpwcOUIKaaksnaBX3PX8t6Rv5iUcXE0Z20HZxpqRAl4NJr7uxy8UVS1Shc7uY
    d5aMbQEcrHH7PplL+T1oZ/w+18Ic7NJqXY/nB4BYLb8pb9uHJc1RQQNZNS1g
X-ME-Proxy: <xmx:yic1anVmIy9lG4s7k85aqwKjsAXm2SYMcIGmzv5ue-_2SkbQFxlJ2w>
    <xmx:yic1apDzPHdFVcw5n1-NEdt2qxlYKW6cvrI7WgvJJ6tNo6fRb5S3EQ>
    <xmx:yic1ai9iHT9UKNWqu1clIiY3ulRxhwNmILiRNZqC80rCVfJ6GChdog>
    <xmx:yic1aoEb-BLqwRptGj1BdQ0mD5YTtc8YSoBRUpFXIQ1155VrA9qv4w>
    <xmx:yic1aoElR_lHyi91nC3n0aPRSYvbRoaXTurFS-pG2iosYALwD5_WifQU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 07:28:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bd2b0ddb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jun 2026 11:28:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 19 Jun 2026 13:27:51 +0200
Subject: [PATCH v4 03/10] setup: don't apply "GIT_REFERENCE_BACKEND"
 without a repository
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-b4-pks-refs-avoid-chdir-notify-reparent-v4-3-a6472be7acc4@pks.im>
References: <20260619-b4-pks-refs-avoid-chdir-notify-reparent-v4-0-a6472be7acc4@pks.im>
In-Reply-To: <20260619-b4-pks-refs-avoid-chdir-notify-reparent-v4-0-a6472be7acc4@pks.im>
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
2.55.0.rc1.722.g2b3ac350e6.dirty

