Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEAB370D5C
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 08:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253158; cv=none; b=VJ3u/J4enwyRy/wfF5OPmyu7F0TJ/NZJgl5v+X9ANMeFyIk+OnpW0XErTAvPjzgwsXYASr8YfvFL4KALd1k85yxjAED2FbTUuAY5MI7mcYgC75utHUW4381p5Hbq7YUvK47o4xqb/kl+pSP/x7/qw+UUezzlTWaYE/tJNwbZ0Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253158; c=relaxed/simple;
	bh=fR6yUurkgLOOZxG1pYOyDOVYVNEN17LZX5PtycnwirU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hqHqGewc9gDrHdnStT9b0AtwjTk9OdFURCjVHlVqVkJG2nFOmCL2cHp+GigTWfDaH3B+wYLv0/m6qJVwHf0KgH/LvdvX7wa2KIPk0hEOpt8paMEgGxgSY2AbfYlQDTt5EAOI1T2PEa9KdxASGOsuo3mqxxclgCZDh0Iteo5xWW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWqAWVi0; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWqAWVi0"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439b94a19fdso2348368f8f.0
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 01:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774253153; x=1774857953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EueB1PiE8F7sE23N8bZfU29fyWz3bzcpMLbMjSv3Xd0=;
        b=cWqAWVi0jmVXI+umzRIV7dyGNLqe9Jo5+O0AY/X/HdDniGGG32P5sI6Ikxj/ol0ZIA
         c3yfbczRr2QCo9Hy5pytqiEHTOPHYyQwThm23gb6a+eAj4KKOMxf7iGWrWb1ly4ZD3tA
         j2ndEBh7m1PmoPbFeIKsTo6qNZ/gojOYzSzsSFpVkBCqYt6czPhpinLjCUwShyHyrSPt
         mqVD4WUduNudmYWyvT+i8jU826r0efY1b5Zt4jplrisGyLTX/gf/cJQi0j0PdOYTNkAy
         MKQVxFaSKVoh5Tv+vAdvJMfezLmN9fgRlCfpy+YjnYcWW5svyKDOvC8pphYJCQOhmyU9
         Fynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774253153; x=1774857953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EueB1PiE8F7sE23N8bZfU29fyWz3bzcpMLbMjSv3Xd0=;
        b=scgh083zCL1mMPKbHI8Qj+FgTlaEzVy193UiEGWl1tFYmm6Pd+L5RDeIzsEhUmY0DN
         wphIXSER0T7njWfLfVL/MoAGLN2dDUS6K4V2Gg9jp6YxcP07WsUO5/2yKetNaog0Dutt
         uASXIr1F9vwL+F6pIANk9iaxTskG9p/H6ps8I55VznMynWi1TJQDZnNNb4ohUD42uJ3t
         2K8r/VRpjekkSR4WiAb1QQL3TKRzPe0NlNlcRU6vJbgvBU3BeC4DWKxSvkg04GZPGOW0
         GZIInLT37PtK3Gp6te7qrU5Fhxa3B66g535COwUrX1qZclGQ5xdBI2P2+WJAVDHKvx+S
         956Q==
X-Gm-Message-State: AOJu0Yzh0WZDQ4D+neLv5pLVjbTYnG8d1RlwN6AiXOs1NAKgu2MLDOuf
	Esfy2G4Ispe7KZsKMuKcSj26yKTS0t3Wv8QRAF0yMiAoSP+hVxiKDRL29FIwxg==
X-Gm-Gg: ATEYQzwZf3o7qDfm2SNtLcOJBJ97InnTg+s6BtsuRAYpF06LeJCMuqhlPRWs31Pb8D8
	7sM8bpJgfPIC1WBw6NmQBUDS1uwx6w/cz45vso0z6ADwJ2qJNRXQQnI/4B3WTgI4ivShIXF8vD3
	Gl58fQdPEjo1h661BkKxFXfxgFe9MitoPlA7vvi31xXpTXbxQ1s5dxEPepMjtcc7DsRDKYrMhgG
	4dpxBhx3YZNmxYzw61APgOc7huIVlUfGjqi/j+JznCUrCSHibwrBYIbz1pAOTBk8gqtjPvZfE72
	Bk2rqkMplHFXvqL3aHWl2MxdsbNT9n65zzASSkyp+7i5pDsHhPNpzAvZ/ejT4JYaJ6AVyhnmDGF
	GAW64i3HXjZe46fTWqTmQvpmaK2pCIBIhktewYtFTIxaqnNHGuiPGDsbblQC6YDHtRNbCgiCgLr
	QrCgqnHWiN66ik8tPxUYPE/FmcftrvawjAefbkRlgdJtGHUk4VD7F7bKW832lMJu2xyNqhokPvx
	d91OGiIbVcKV0wTYVF5TfvYb3IYqUZBtUmrheI=
X-Received: by 2002:a05:6000:2005:b0:43b:4ae5:d7c8 with SMTP id ffacd0b85a97d-43b64233efamr17761150f8f.2.1774253152840;
        Mon, 23 Mar 2026 01:05:52 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703650sm27834067f8f.20.2026.03.23.01.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 01:05:52 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 11/16] promisor-remote: refactor should_accept_remote() control flow
Date: Mon, 23 Mar 2026 09:05:14 +0100
Message-ID: <20260323080520.887550-12-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.625.g20f70b52bb
In-Reply-To: <20260323080520.887550-1-christian.couder@gmail.com>
References: <20260323080520.887550-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In following commits, we are going to add URL-based acceptance logic
into should_accept_remote().

To prepare for the upcoming changes, let's restructure the control flow
in should_accept_remote().

Concretely, let's:

 - Move the empty-URL check to the very top of the function, so that
   every acceptance mode, instead of only ACCEPT_KNOWN_URL, rejects
   remotes with a missing or blank URL early.

 - Invert the URL comparison: instead of returning on match and
   warning on mismatch, return early on mismatch and let the match
   case fall through. This opens a single exit path at the bottom of
   the function for following commits to extend.

Anyway the server shouldn't send any empty URL in the first place, so
this shouldn't change any behavior in practice.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 8f2c1280c3..c2f0eb7223 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -665,6 +665,12 @@ static int should_accept_remote(enum accept_promisor accept,
 	const char *remote_name = advertised->name;
 	const char *remote_url = advertised->url;
 
+	if (!remote_url || !*remote_url) {
+		warning(_("no or empty URL advertised for remote '%s', "
+			  "ignoring this remote"), remote_name);
+		return 0;
+	}
+
 	if (accept == ACCEPT_ALL)
 		return all_fields_match(advertised, config_info, NULL);
 
@@ -683,19 +689,14 @@ static int should_accept_remote(enum accept_promisor accept,
 	if (accept != ACCEPT_KNOWN_URL)
 		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
 
-	if (!remote_url || !*remote_url) {
-		warning(_("no or empty URL advertised for remote '%s', "
-			  "ignoring this remote"), remote_name);
+	if (strcmp(p->url, remote_url)) {
+		warning(_("known remote named '%s' but with URL '%s' instead of '%s', "
+			  "ignoring this remote"),
+			remote_name, p->url, remote_url);
 		return 0;
 	}
 
-	if (!strcmp(p->url, remote_url))
-		return all_fields_match(advertised, config_info, p);
-
-	warning(_("known remote named '%s' but with URL '%s' instead of '%s', "
-		  "ignoring this remote"), remote_name, p->url, remote_url);
-
-	return 0;
+	return all_fields_match(advertised, config_info, p);
 }
 
 static int skip_field_name_prefix(const char *elem, const char *field_name, const char **value)
-- 
2.53.0.625.g20f70b52bb

