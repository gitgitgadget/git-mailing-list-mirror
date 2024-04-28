Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D21D4411
	for <git@vger.kernel.org>; Sun, 28 Apr 2024 22:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714343467; cv=none; b=I08rwr+2DO1WRvGlxFp8HTST5NuWTxRFYY/h7FEfogdG2BFTYJASN+h7QI+i2arOqFHA74a0OYk6wvXG3v+tZx4/RCQg7liPQxobm7rWKJK86KK7rs+sthVdlGG0DQs9m8mc8FQMXBK7WuvxRqbxBwseu9ZCYhJcjuqT3cyiF64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714343467; c=relaxed/simple;
	bh=e1VdIs0x1zqylEX+ZJoRXEypXAHuc/PAxev/iCDL48M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rscWC357aVuXo2+AHzMI6vHe7qsmSI2V1KSAK1+xZufEo2yiArRc62Zwd61dVZtxJ8nGoblbRNU02QfVh/P7IK3Kwx39fbDT7DvACaLsQJJbhJozZERKBBHpFMIMQgl+eoRmROInE5TATBmT6SrXPoyB3Nk4lRheu6eKlQD8SFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNHkEEXG; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNHkEEXG"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-346406a5fb9so3291028f8f.1
        for <git@vger.kernel.org>; Sun, 28 Apr 2024 15:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714343464; x=1714948264; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqAWfie3RQGeBBg1kL6q7Vb50rUPGbPDDp8b3lM21Yc=;
        b=dNHkEEXGuJb0sMd8qjoTvBnAm9PRf07dopyXvaX+/jla86RstwZwP3/JGPV2YERp+p
         4frNUAauJfNe6YKBCECxU9veOj6jWHlr66FE7kkaZU/rpTpomylY4poOuW+wxCGnl00p
         bPQf8R31BZi44uH7oywv+UW2D8dZGJ1TJC7wOwbesOMwr/KvWw4bSt3ugkVbK89D3S0t
         jBX9mi+GTJbBVReNnvogRz81DU0fD1WzGHqiqGdhmDWMywHz711iNqPR3lJ5aIAs9VwI
         Heb/QTYPPhkOgLtu0v0ybsw/3UNSIdU/TJcDfhMOSIXVd/vQrBKMWTKYwXiNNUaVOu8q
         zxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714343464; x=1714948264;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqAWfie3RQGeBBg1kL6q7Vb50rUPGbPDDp8b3lM21Yc=;
        b=U0NCvr5Vjm5eGivnwobMEcKgoD58xMizZaFI52g/hhNKfVTFpZeOW0Jc1BiYdEBaEi
         T61qYjsyYEgpHccRzCJQ/z1w2HeKR8+awbJf4qOP2dgX42vc50AKWU828ZR3vjUnwRor
         zhfSguEbf/a+2MQphxksRHFOmDnSkkzsvyOfnywq8Yrqa+0QRLg2fqQrsH0ne9dZrIj7
         W09Zy6A8MFN1O7ZawE0CJnAaXPesl1kl0bDM1+I/uS4U1uqa77SVXP8DyWeBSqpFCLaV
         uXqJVWAz0jmaNjQN1Y5muTgf78fQVGOmtSaH9y/M4MtCzOl/XplJHRN09blwwca2synH
         +v4A==
X-Gm-Message-State: AOJu0Ywi4Z9v9B5U5UfSoNElIgpEDMhwPAug+Sn0h3FPCzwqc1UEzkGn
	+tSUZ+iHLHwBaMloexRue1yR8pM3HGxxeb3FauSVpm4ToD9PRpbpaD+HcA==
X-Google-Smtp-Source: AGHT+IG0G4fGqKw+58kwRdcIzTLgnAqhQ76mCTR6CYxKBvRT5iKoWmgOH3Ehk1gs3jlve8RWsVeONg==
X-Received: by 2002:adf:e90a:0:b0:34c:601b:1083 with SMTP id f10-20020adfe90a000000b0034c601b1083mr4367202wrm.65.1714343463937;
        Sun, 28 Apr 2024 15:31:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g4-20020adff3c4000000b00343c1cd5aedsm27873803wrp.52.2024.04.28.15.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 15:31:03 -0700 (PDT)
Message-Id: <42eb0cbf68a4f7ee46041687277d529fe981df6b.1714343461.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
References: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
From: "Matheus Afonso Martins Moreira via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Apr 2024 22:30:49 +0000
Subject: [PATCH 01/13] url: move helper function to URL header and source
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
Cc: Matheus Moreira <matheus.a.m.moreira@gmail.com>,
    Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

From: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

It will be used in more places so it should be placed in url.h.

Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
---
 connect.c | 8 --------
 connect.h | 1 -
 remote.c  | 1 +
 url.c     | 8 ++++++++
 url.h     | 2 ++
 5 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/connect.c b/connect.c
index 0d77737a536..0cd9439501b 100644
--- a/connect.c
+++ b/connect.c
@@ -693,14 +693,6 @@ enum protocol {
 	PROTO_GIT
 };
 
-int url_is_local_not_ssh(const char *url)
-{
-	const char *colon = strchr(url, ':');
-	const char *slash = strchr(url, '/');
-	return !colon || (slash && slash < colon) ||
-		(has_dos_drive_prefix(url) && is_valid_path(url));
-}
-
 static const char *prot_name(enum protocol protocol)
 {
 	switch (protocol) {
diff --git a/connect.h b/connect.h
index 1645126c17f..8d84f6656b1 100644
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
index 2b650b813b7..2425dbc4660 100644
--- a/remote.c
+++ b/remote.c
@@ -5,6 +5,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "remote.h"
+#include "url.h"
 #include "urlmatch.h"
 #include "refs.h"
 #include "refspec.h"
diff --git a/url.c b/url.c
index 282b12495ae..c36818c3037 100644
--- a/url.c
+++ b/url.c
@@ -119,3 +119,11 @@ void str_end_url_with_slash(const char *url, char **dest)
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
index 2a27c342776..867d3af6691 100644
--- a/url.h
+++ b/url.h
@@ -21,4 +21,6 @@ char *url_decode_parameter_value(const char **query);
 void end_url_with_slash(struct strbuf *buf, const char *url);
 void str_end_url_with_slash(const char *url, char **dest);
 
+int url_is_local_not_ssh(const char *url);
+
 #endif /* URL_H */
-- 
gitgitgadget

