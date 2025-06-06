Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF282857EE
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749202172; cv=none; b=VVeQOmXki4jccBk0MrhRsmgBsGJp3Qma+OVCOPRQnpShJOatm2C7fuoexaWPZ1OTsp1VgDWd82ZweyPwHf2heWG1rpLIlMrTUAcbEM+UsayPGx3UMPxl7jeJBL4W09E0aVP5Mqe2yY0LLKOW34hbNSisdNBeh5eUiDfaMu+AxUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749202172; c=relaxed/simple;
	bh=GNZKnnFetVhOPJf6n6rX3MkZ8Cn1KH6Blc+0d0gaFac=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=acMGBiW3z2UzS/cnTH7TJ0+mxhauEkyld8EUT9frS0zUwgfv+mLrrxAoUGtZcjXEqsNx1nnH+SrBoKBYSV8TDlB7A0vyWpEIRgmMuCciGvf9Ed8iUXxXq+hr+TEn7WNTtYO4Df9pQctWdPkSBRNoxApwHEJ4ORfOfghi0LakXm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMmxEgRS; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMmxEgRS"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-451d6ade159so16479675e9.1
        for <git@vger.kernel.org>; Fri, 06 Jun 2025 02:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749202169; x=1749806969; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jcjm9P/qM6lysS9m2iO9fESiptg2qVWvssFZfJTlhc=;
        b=AMmxEgRSXt0Sbwcv4mZSqP3viyTr6qt7vDxC7p8dmAmXZbAwFUb1Lk33YL9/V9owUE
         iSyYPWSEGptli1B4JAGwV3/MCPTYF4KCot4Urm0FX+0OTon1HoDSjtR76hgR075dZskw
         c/ZtXScibldnK6M4CNh0WNdsRE22foWKj8QwD3jeEFsKynvegP/SYO7vnuTGubkpYJ4n
         vU8g0pgseXVI16Fu4Db/jXYBGZrO37vwQWNgZpK3s2oi0OLNzjE1xSLUGYq2EU9ACam2
         L6ng9fejzvY9rPgYjbBxqIXdRACPs4OUPFiv7HJAkH6XD0M23DAJYutJc3X/V03oUUVi
         nweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749202169; x=1749806969;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jcjm9P/qM6lysS9m2iO9fESiptg2qVWvssFZfJTlhc=;
        b=PhYT+/aFk2vxB4PVDIpYgK9Uieiz/gEnRyN59YgRAPdbxq+QZmKZHK5Le9AjxJyJ92
         k4j565i1fBG9g3QFpVZD8lnOx52j0ToOJ7huFNjexzioLJ3n0QXKbUiKNQbCm2yOz90V
         5UiERZlLlvDBnNRDhTKg8XYVcnDbIHuytvCcrwNFFLIlrrJoegvCiS+oCP6cm8qoloGs
         NEPVy848D/kz1aynVV2GtW+CajdMSvL3dRFZJbp0Nv8agqTdGrsxA6VHj6bnMaNlaStS
         NtBRm4g8XKO6Nx0Y7PDYefAZyts0NfH6WRAopRncrGKtRj98ZPK6ED26Db2lX4xCp10I
         Bf5w==
X-Gm-Message-State: AOJu0YyUvN/f9Q5rctRczK9pUXlpnynJcx0NuGLelWYINr+eyj0qgrp3
	jOAHxLoIIS3LfzY2ioaSHyWLvIRdavK4BA39iEJbhIS+uBBHXefuzxAUutJWLA==
X-Gm-Gg: ASbGncth4f4p8Dr1+1/k0EYVmNSr1Sx4KyzReNutvogN1x4AvZvmPvGd5HRFwYGMh/k
	fElRhgfQ/dS6mLsN/KFBa5QfTY/FgXXZDbIh/mtMblT7bo1BlV5UH1auGF1+XcEJlygMZqWuMuN
	NL/gDGKc2APcjdrJILyNAkE/f4pIItdiyXs+tA1OzDg+zrwLyWLdILm1c2ajWgQbF0s8Tmm9dKb
	5eXDk6kp3xi0barE+gmy++MvlinxEmNLjsUWHpnzgLt1zl5Ca29ymHG2Yuvm1roCJ/Eh7QJ2Xu2
	iMRr20ypUeeBa7TNNZ4/xpuFxrOXDDfpUvN1GzATEPHSsJYQTkBfaaEwjZqNa+I=
X-Google-Smtp-Source: AGHT+IF/4WZZSxbUG/KGVUXzWmx8fjyHBAbNx54DyRC81QGon8PTiwFoRpPM0BVvfdFAprMthb7f8g==
X-Received: by 2002:a05:600c:4eca:b0:450:d586:25ad with SMTP id 5b1f17b1804b1-452013b9471mr31750105e9.15.1749202168617;
        Fri, 06 Jun 2025 02:29:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45209ce1afasm17919625e9.10.2025.06.06.02.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 02:29:28 -0700 (PDT)
Message-Id: <4558c8f84b2f8d3ba1483727bcb49935ae8ff595.1749202164.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1931.v2.git.1749202164.gitgitgadget@gmail.com>
References: <pull.1931.git.1749112304079.gitgitgadget@gmail.com>
	<pull.1931.v2.git.1749202164.gitgitgadget@gmail.com>
From: "Jeff King via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Jun 2025 09:29:23 +0000
Subject: [PATCH v2 3/4] curl: fix symbolic constant typechecks with
 curl_easy_setopt()
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Jeff King <peff@peff.net>

From: Jeff King <peff@peff.net>

As with the previous two commits, we should be passing long integers,
not regular ones, to curl_easy_setopt(), and compiling against curl 8.14
loudly complains if we don't.

This patch catches the remaining cases, which are ones where we pass
curl's own symbolic constants. We'll cast them to long manually in each
call.

It seems kind of weird to me that curl doesn't define these constants as
longs, since the point of them is to pass to curl_easy_setopt(). But in
the curl documentation and examples, they clearly show casting them as
part of the setopt calls. It may be that there is some reason not to
push the type into the macro, like backwards compatibility. I didn't
dig, as it doesn't really matter: we have to follow what existing curl
versions ask for anyway.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 http.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/http.c b/http.c
index cce2ea728736..ecbc47ea4b3f 100644
--- a/http.c
+++ b/http.c
@@ -1057,7 +1057,7 @@ static CURL *get_curl_handle(void)
 
 	if (http_ssl_backend && !strcmp("schannel", http_ssl_backend) &&
 	    !http_schannel_check_revoke) {
-		curl_easy_setopt(result, CURLOPT_SSL_OPTIONS, CURLSSLOPT_NO_REVOKE);
+		curl_easy_setopt(result, CURLOPT_SSL_OPTIONS, (long)CURLSSLOPT_NO_REVOKE);
 	}
 
 	if (http_proactive_auth != PROACTIVE_AUTH_NONE)
@@ -1118,7 +1118,7 @@ static CURL *get_curl_handle(void)
 	}
 
 	curl_easy_setopt(result, CURLOPT_MAXREDIRS, 20L);
-	curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
+	curl_easy_setopt(result, CURLOPT_POSTREDIR, (long)CURL_REDIR_POST_ALL);
 
 #ifdef GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR
 	{
@@ -1193,18 +1193,18 @@ static CURL *get_curl_handle(void)
 
 		if (starts_with(curl_http_proxy, "socks5h"))
 			curl_easy_setopt(result,
-				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS5_HOSTNAME);
+				CURLOPT_PROXYTYPE, (long)CURLPROXY_SOCKS5_HOSTNAME);
 		else if (starts_with(curl_http_proxy, "socks5"))
 			curl_easy_setopt(result,
-				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS5);
+				CURLOPT_PROXYTYPE, (long)CURLPROXY_SOCKS5);
 		else if (starts_with(curl_http_proxy, "socks4a"))
 			curl_easy_setopt(result,
-				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4A);
+				CURLOPT_PROXYTYPE, (long)CURLPROXY_SOCKS4A);
 		else if (starts_with(curl_http_proxy, "socks"))
 			curl_easy_setopt(result,
-				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4);
+				CURLOPT_PROXYTYPE, (long)CURLPROXY_SOCKS4);
 		else if (starts_with(curl_http_proxy, "https")) {
-			curl_easy_setopt(result, CURLOPT_PROXYTYPE, CURLPROXY_HTTPS);
+			curl_easy_setopt(result, CURLOPT_PROXYTYPE, (long)CURLPROXY_HTTPS);
 
 			if (http_proxy_ssl_cert)
 				curl_easy_setopt(result, CURLOPT_PROXY_SSLCERT, http_proxy_ssl_cert);
-- 
gitgitgadget

