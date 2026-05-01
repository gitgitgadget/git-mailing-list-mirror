Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A97E37E307
	for <git@vger.kernel.org>; Fri,  1 May 2026 23:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777677322; cv=none; b=Ckj+0RCQeP862F/QKQsOBW5zyKbC7j/S2rVKE2nsLAuHXuziZScetR01i0sraUBRYdp+jk+NdGqOW4BIqQKnSCJ7sNG+YkOkOonbK29punQm2rJCG/A26ZbJOSJo5NTMZXV8Aa6UGTkqNBer6VgZN4k73Ul41Zf15VNsEnM07sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777677322; c=relaxed/simple;
	bh=M4RJ6jhK73iF4lBIzOOcMCmIbuNg1X+vUeKQ4E+5kX4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BYipGdlvfN5uEE4hZcTPd9oJE6Ln86GYh5A7kFPj5NoD2OLopR4TfhPkJo0NpJJx46pSC51kRgpWCuDMJtK/lN9BGm5yTiOaju4KTTzCGE8IPk8zIxmzSzmGaUKEZ5e9n2e+53e9EBL8oBG0cacZDd7+EuIyV+bnpvahoiXrMaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ih/LMFCL; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ih/LMFCL"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ef8d6ba48bso308152eec.1
        for <git@vger.kernel.org>; Fri, 01 May 2026 16:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777677320; x=1778282120; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0N99xeMTsFfNBPOJZ+NQOEPKlNV2Qvh+SMY5pe0SwE=;
        b=Ih/LMFCLrBAwFaovTbQrDdY+nsu4fIHEVGU1cnTs+Z5ksZ4oEa0okpCdAOMUirnexa
         iaJLjnmCLcr20Llx9s1e9BSCd+tc4JVyrNRHnXCoz+pCKYm1ppiKIJ4eH+OZmSfEnyW7
         AlLaDNon07Q8NtOHZLjzHbCTpjwtuAwqK71uYPbaYGlOwX8p1XAdFUg/8J+h0hwkUE6+
         uxXv2oYevZ3/9eTQCgqHAnaHGxTg7H5d6iAiG8fL6KaHoTlG5Jjbkq94x8j+c/dywvh6
         v4A5CsQ57xcKFE8wTdtxhAnrE1DQmOOHuDp8cy26i0/I2Hk8qB37GuE18w7YXk3dZOY5
         BscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777677320; x=1778282120;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l0N99xeMTsFfNBPOJZ+NQOEPKlNV2Qvh+SMY5pe0SwE=;
        b=Cc82TajQ7bFhS0uHJ+IXrWMMBgzMW3aUe25T60fenNwvRFp8Cfk8xO+PS3wJQfyx1a
         D2wO4KiF+WhPS+965RNEse2/l3zWTaJxOoy4oIbP1qViVtZm2VvuSCs/bCbd5XwDzX4u
         EtiC2qMUo0nMIshMawzGkzx9E55aD/qJvkE12pLnBN9KdtLaZ2DurXV3Pafh2w595pBB
         FGuZuduQyy91Bu2IGQ2l4PmU08rA+UI5fmDgdgllNFGOt+1YPxCvOqAoJg1yWx4Sx4Uo
         Z4W0cWGlkKma4JgXdtZHmSDyTq1Tkxx+sbqCb5phBtoBxYML1MTfP7I1o5TT/k8rYpuo
         6iRQ==
X-Gm-Message-State: AOJu0YzYUBCkFh1jJYi+NartQukXHGGdYn1qus3e3rvb9YnTgdMVKRcD
	+G8IeDAj8Yt7DowpEVIJLiUBc86Y8crVfLRzB21PlXeSoTgSbENPmaEeQqsoEFmQ
X-Gm-Gg: AeBDieuXn+XwDW2V2Ht45kvOJPmokOuJqcPEoqebH4aHoGJsRcac0wkEznIeYuCf6rq
	TClcLIvSI9FeWUXvA9M0VvZRA5wcLV1xOof53rnoDNI8/VMvsiQNo/b8Gt+CRTiy/932yGLALGw
	PVuDdR6Q6jEk+XOXF0i78KSLBdPMWchxqvLpE38jxFtWKj/WMST/wlHKgSurhQoPWFrOAchkSuE
	N8u/f3TQhQbU/aXvS8w80QIyoOp0QBvtoQjXgSvzCs1Zc2R6f8zs1faQHAuWaBHspx4uf3qH6NT
	k8yrrYQWQ0etE1667vcrbhKrs5LT9KZ5bf6PKsB6jrGeXtOeqHnNc9Oes79o3fi5EJ1T5/59Hyc
	XmJi1GJ3LKn44/ti7F0IhagIfOsgyyoLkSO092KEtMk9MTJJ8g0X7gLf7AfQA6PWQDF2maUzmjN
	7QDpPAgmiq97aBklyo64XnQv9jwbSN782e/MoaP64=
X-Received: by 2002:a05:7300:6c2b:b0:2d1:9b35:4edb with SMTP id 5a478bee46e88-2efaccf57f5mr623129eec.0.1777677319148;
        Fri, 01 May 2026 16:15:19 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.231.147])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38e71b61sm6069212eec.12.2026.05.01.16.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 16:15:18 -0700 (PDT)
Message-Id: <7381704c3809deec3adf1442a920f47840e0f104.1777677310.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1715.v2.git.git.1777677310.gitgitgadget@gmail.com>
References: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
	<pull.1715.v2.git.git.1777677310.gitgitgadget@gmail.com>
From: "Matheus Afonso Martins Moreira via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 01 May 2026 23:15:06 +0000
Subject: [PATCH v2 4/8] url: return URL_SCHEME_UNKNOWN instead of dying
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
    Matheus Moreira <matheus@matheusmoreira.com>,
    Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

From: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

Enumerate a URL_SCHEME_UNKNOWN result with value 0.
Have url_get_scheme() return it for unrecognized
schemes instead of calling die() itself.
Move the die() call to parse_connect_url()
where url_get_scheme() is used.

This lets url_get_scheme() be used from contexts
that need to identify a URL's scheme without aborting
the program. For example, a future plumbing command
that validates URLs.

No external behavior change. parse_connect_url() still dies
with the same translated message for unrecognized schemes.

Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
---
 connect.c | 2 ++
 url.c     | 3 +--
 url.h     | 7 ++++---
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/connect.c b/connect.c
index 1ac7acc6e8..73d7a6b8d0 100644
--- a/connect.c
+++ b/connect.c
@@ -1071,6 +1071,8 @@ static enum url_scheme parse_connect_url(const char *url_orig, char **ret_host,
 	if (host) {
 		*host = '\0';
 		scheme = url_get_scheme(url);
+		if (scheme == URL_SCHEME_UNKNOWN)
+			die(_("protocol '%s' is not supported"), url);
 		host += 3;
 	} else {
 		host = url;
diff --git a/url.c b/url.c
index 300acf98fe..a59818278f 100644
--- a/url.c
+++ b/url.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "gettext.h"
 #include "hex-ll.h"
 #include "strbuf.h"
 #include "url.h"
@@ -154,5 +153,5 @@ enum url_scheme url_get_scheme(const char *name)
 		return URL_SCHEME_SSH;
 	if (!strcmp(name, "file"))
 		return URL_SCHEME_FILE;
-	die(_("protocol '%s' is not supported"), name);
+	return URL_SCHEME_UNKNOWN;
 }
diff --git a/url.h b/url.h
index 24c8cd91d0..7289523605 100644
--- a/url.h
+++ b/url.h
@@ -24,15 +24,16 @@ void str_end_url_with_slash(const char *url, char **dest);
 int url_is_local_not_ssh(const char *url);
 
 enum url_scheme {
-	URL_SCHEME_LOCAL = 1,
+	URL_SCHEME_UNKNOWN = 0,
+	URL_SCHEME_LOCAL,
 	URL_SCHEME_FILE,
 	URL_SCHEME_SSH,
 	URL_SCHEME_GIT,
 };
 
 /*
- * Identify the URL scheme by name. Dies if the name does not match
- * any scheme that Git knows about.
+ * Identify the URL scheme by name. Returns URL_SCHEME_UNKNOWN
+ * if the name does not match any scheme that Git knows about.
  */
 enum url_scheme url_get_scheme(const char *name);
 
-- 
gitgitgadget

