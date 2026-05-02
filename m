Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAA92E093A
	for <git@vger.kernel.org>; Sat,  2 May 2026 05:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777699729; cv=none; b=TwywN0DSQS/DRS2HR3YNRBDG8PWjm2FGaQk2jQAHIsNlMoOS3QuBClwtZJGw6sU9CurGg2TnbIZq9VbWKWc545fOEbjWZ4fqCEJN7YXxfg9v5+LHWOep648VjLT9z4WedYBYrGzgYqIBg41+631smM3jmIB3EF33QDts7JOHXns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777699729; c=relaxed/simple;
	bh=nShCIvBAt1eRu17tFMFFYomrEUCY0xnxIKrzBUjh7bs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gtICWL3QuTT3PtEacef3NPvqzHAsw6g7gOoFt7r7l9KONMlyZLavnJPO550TQRih02X696jwSRA5s3YOnZC8mjaS/vxdiga1rgvbPcc6I1n/KwWUe7wLeN29e+WewcPpX/SLb5B6dahGUwRQWu6YNMd5l08jgWNPAh/GVJbRk0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qd9um66E; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qd9um66E"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8a016799d2cso27166036d6.1
        for <git@vger.kernel.org>; Fri, 01 May 2026 22:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777699726; x=1778304526; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07wf0fBTrwWfYP4HCv72cSPwqeyvsNOwYA1JM3tZx7g=;
        b=qd9um66EYNGPALDgRnaFQDbu0IacR48IG5eSItShhJWdborzblvYN8r2rak1zuX19m
         WszvIDarXx14F3LSK7z31fBFb9kkOSrOzLs0A9Ji1qUTNfw9OW/Cq/OnOdl/TUW8RQEv
         keCs+yY37jhJrIm+KnjlkQNOrbukKPL4bJx1ck1pfzeSc8ZH2W61+vtWTGbz3nWhTpxI
         L+ncKRsFbMePSXWb+zAGO3lkvhdSrnbBscyflNSKNArgDd2BMwcGDckpijPiV7w4LJYo
         gJnLS+UMHGfK/AVBbasFuulEFQRKFLmTpTkaTmo9CzIxq6+5agFSQ47Pw4WgUg38qYH3
         vgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777699726; x=1778304526;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=07wf0fBTrwWfYP4HCv72cSPwqeyvsNOwYA1JM3tZx7g=;
        b=KjJknVTSFw54XafJAl5WBs2QVccee0V3Km6IH3XbhWwZHjqc9AtqT1x9hGQPZTqixL
         XcgpLOr1/2b9PABVfLI2WGnmVRD9SSn6LPn43XwhJP0AXIrXsroiuRKWGcYx4ZU1MrF6
         Tw6umY9xkQxq4myDth++PI86wSjihuSUzCn+LYXtPMjxoMiBNcSUYCeAczfXLKnIB6V+
         Q8k2+Tgy+WXy/PATt9DOa3Xrlv6Vinwnix4qcjfjcZiN+RdZR87em5KQxv/5FPhwnfA0
         fFsrDsIoItFeo/aKVCe+n5xOWCpR7v5Wo0wd6jF11jrzHVA+4ilHkqMjdaLqZtxHzKB+
         X82Q==
X-Gm-Message-State: AOJu0YwCeBSD3QW2q6rjHZe8uSqGD06TXGnxQG7m7sb4DluKtKKnNFrR
	rwGun23WZ1XELoa2VDHoMwr7gL93YHFITxmQH7MUt+55CTC0xb/OPBY4wUSApw==
X-Gm-Gg: AeBDietFYVpl1iO9cGRVrBYgtC/tBBTMc6P9QhFLap7gIpU+W/1KDhmxglNsoZERNDF
	ktrWppNFuf6i6a9yKCCCwSSVxr31+5pv7YEWd4of3yt540z2UiOMgD5tBUxuNLj3MvNa8GmII5Z
	47tFWxxvJRZi9B5+Vgpu5DglGryHcHx1XlCrCKnhSzolcuL1/Kc/XDfUJ4PPS4dLjwtuJt3oxAH
	aps8gpqy8E1nn71gIgMuTG9hL4eNAmKnyFI88eHPU++3neADMBTrFJEXmKTL5lqR8vwVAsi8epJ
	i7/e2+rYIO5FJNPPO0kkxRjuiwH2oGVOXbXLtFnht7FVx9Wh4ltb+P9fJuYZSjPIalCrmpXV835
	PJaRyBAIC+pOp47ojIXSrblBnZ/9n3mKIxy92/BNZYlXjapHUQnKCyBrx3Kx8gieCz5AW19IPhY
	uteotHFDh//boyLKJlwLwVlmH4ChK6Ni5X6i16bMg=
X-Received: by 2002:ad4:5ecc:0:b0:8ae:6587:3d54 with SMTP id 6a1803df08f44-8b667e6ed4bmr44570196d6.26.1777699726493;
        Fri, 01 May 2026 22:28:46 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.224.103])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b538b1d953sm54863206d6.3.2026.05.01.22.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 22:28:46 -0700 (PDT)
Message-Id: <a4153e1d2470d42d17758df727fc267a7debbc3d.1777699722.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1715.v3.git.git.1777699722.gitgitgadget@gmail.com>
References: <pull.1715.v2.git.git.1777677310.gitgitgadget@gmail.com>
	<pull.1715.v3.git.git.1777699722.gitgitgadget@gmail.com>
From: "Matheus Afonso Martins Moreira via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 02 May 2026 05:28:36 +0000
Subject: [PATCH v3 2/8] url: move url_is_local_not_ssh to url.h
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

Move url_is_local_not_ssh from connect.c/connect.h
to url.c/url.h so that the new url_parse function
in urlmatch.c, and any future code that needs to
distinguish a local path from an scp style SSH URL,
can reuse the heuristic without depending on connect.c.

No behavior change.

Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
---
 connect.c | 8 --------
 connect.h | 1 -
 remote.c  | 1 +
 url.c     | 8 ++++++++
 url.h     | 2 ++
 5 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/connect.c b/connect.c
index 46da89905e..cb145de30e 100644
--- a/connect.c
+++ b/connect.c
@@ -707,14 +707,6 @@ enum url_scheme {
 	URL_SCHEME_GIT
 };
 
-int url_is_local_not_ssh(const char *url)
-{
-	const char *colon = strchr(url, ':');
-	const char *slash = strchr(url, '/');
-	return !colon || (slash && slash < colon) ||
-		(has_dos_drive_prefix(url) && is_valid_path(url));
-}
-
 static const char *url_scheme_name(enum url_scheme scheme)
 {
 	switch (scheme) {
diff --git a/connect.h b/connect.h
index 1645126c17..8d84f6656b 100644
--- a/connect.h
+++ b/connect.h
@@ -13,7 +13,6 @@ int git_connection_is_socket(struct child_process *conn);
 int server_supports(const char *feature);
 int parse_feature_request(const char *features, const char *feature);
 const char *server_feature_value(const char *feature, size_t *len_ret);
-int url_is_local_not_ssh(const char *url);
 
 struct packet_reader;
 enum protocol_version discover_version(struct packet_reader *reader);
diff --git a/remote.c b/remote.c
index a664cd166a..24a8118d25 100644
--- a/remote.c
+++ b/remote.c
@@ -8,6 +8,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "remote.h"
+#include "url.h"
 #include "urlmatch.h"
 #include "refs.h"
 #include "refspec.h"
diff --git a/url.c b/url.c
index 3ca5987e90..057576042a 100644
--- a/url.c
+++ b/url.c
@@ -132,3 +132,11 @@ void str_end_url_with_slash(const char *url, char **dest)
 	free(*dest);
 	*dest = strbuf_detach(&buf, NULL);
 }
+
+int url_is_local_not_ssh(const char *url)
+{
+	const char *colon = strchr(url, ':');
+	const char *slash = strchr(url, '/');
+	return !colon || (slash && slash < colon) ||
+		(has_dos_drive_prefix(url) && is_valid_path(url));
+}
diff --git a/url.h b/url.h
index cd9140e994..39d621312f 100644
--- a/url.h
+++ b/url.h
@@ -21,6 +21,8 @@ char *url_decode_parameter_value(const char **query);
 void end_url_with_slash(struct strbuf *buf, const char *url);
 void str_end_url_with_slash(const char *url, char **dest);
 
+int url_is_local_not_ssh(const char *url);
+
 /*
  * The set of unreserved characters as per STD66 (RFC3986) is
  * '[A-Za-z0-9-._~]'. These characters are safe to appear in URI
-- 
gitgitgadget

