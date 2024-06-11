Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5217762C9
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130299; cv=none; b=Fqh7OnQIM+ovlf8WGDAE9nslDuRyMlHn15gwuWVXxzx2fSn3crEK5RU6rJ2C1fvfJEAvbRGoSfIjCcqoOkGyaXb+jKi8GA1AV64X415iHbXCxBqlBkfiXRZJXFru8MGz+uPSeB9oc5zGWpTnss3mGucJGWPKI3nBT2gC/61nT2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130299; c=relaxed/simple;
	bh=6iVA7TIhgsaPJnq/fBFOf0AgwGY4pBN8PPR8dYwuQg4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rdUvxa2Ji7jcNLVsBLWm5WWI6tYm0mQ6PZJWU7SFPN29kK+ZmlNlXcSprHPMLcMWGNbrlCSLUHHnBgYe+ecpWtrIW/s+mmMRk2lFkW7u0byC6CJt1nWer719O+q4SuW/QQItGUWMKhRdTxOl7/VTVGUiAVWGCjdzFp3MqendU8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxZNH8Oh; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxZNH8Oh"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52c8973ff29so1640732e87.0
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718130294; x=1718735094; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baomfKBJJHmpTlw3XLQPe4j8XX179oT0HRdiBQrudqg=;
        b=IxZNH8Oh2WrzoPXfYMXPKqYqLgaOkBofMGY0yT+2ZkvpBdfseaN5lzDShGT/n9YGpD
         vc1/ovfP3Q3q6QbqAOU/2WEpiPfDc9FrSa1sI8qOh4mNCbLVZUrO+AO3ZIwQbY+MvPJA
         YqfrsibodtxWc6L2HxQFijseS5K22lMkQCYnuDEFYw02oGWipalLsJONzA1NiJkBbs2e
         sDhpFPWO99PpmrSt0a1vGuwAqlZD9dDEnyICVYcwvjFZmfHabUmPfjtrrf40wO2xm1dg
         1u33es9touQJdIloxnxdoY+NL5xJHUkZOQk/8Okqv3DIqV6ZMIbVqYTMrxYBOeovsdqr
         lj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718130294; x=1718735094;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=baomfKBJJHmpTlw3XLQPe4j8XX179oT0HRdiBQrudqg=;
        b=gS4s719h6werprBk20GX+HO50l/pJDBvQeapguh5DS42cCupcPrX9k6QvEoXebDTaL
         YXgeEAobKYuBfeePctJRsO+ogUF/D5I7KMJ+Mprw8I2oF7hi5WS9H0nSN0651aOQ0H2M
         1/ZzKKwj26JXQSU3n7YhcFeC1NEIwE+AWIoOXzz6h1fQYeE7xgk5NCH1JmDVqvMf7r+U
         GRsQbbmyuwEVXlMhCOtOAn9soWoSKVYxETTL9H/7VNHuppeyMgR+Myx1Y2NE8jn4MPLN
         LM7s2EfoC4TcI4S6DKg4YWdO6tcHomXSvVPqRv2Jh3TSwuE6j3N/KGdAX7LTVi7seKv5
         SIZw==
X-Gm-Message-State: AOJu0YwVZVy6lkOSA2/dZwYrHnPzpnsprh1asS10sGvE8HWQ/HA+sesW
	dMbN6y4nztlqnPiwwVvo8a/wfgKH+Wnq9gz+e8fwLEagx+PifbvfCQc1cw==
X-Google-Smtp-Source: AGHT+IHc4FThWcduIo8BH16pJkR5Ci9MVE+2gwvrWMtnMRGaXTxfRk9lDa+2vDDscfipmcBQc8dzzQ==
X-Received: by 2002:ac2:5dc8:0:b0:52b:c029:1bdf with SMTP id 2adb3069b0e04-52bc0291d9amr7340138e87.24.1718130293994;
        Tue, 11 Jun 2024 11:24:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4221defede0sm51625785e9.7.2024.06.11.11.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 11:24:53 -0700 (PDT)
Message-Id: <7e3bcc16e23c97d8a4efbb9e14b230ef9f44a1a7.1718130288.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 18:24:37 +0000
Subject: [PATCH 05/16] index-info.c: identify empty input lines in
 read_index_info
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
Cc: Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Update 'read_index_info()' to return INDEX_INFO_EMPTY_LINE (value 1), rather
than the default error code (value -1) when the function encounters an empty
line in stdin. This grants the caller the flexibility to handle such
scenarios differently than a typical error. In the case of 'update-index',
we'll still exit with a "malformed input line" error. However, when
'read_index_info()' is used to process the input to 'mktree' in a later
patch, the empty line return value will signal a new tree in --batch mode.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/update-index.c | 4 +++-
 index-info.c           | 5 +++++
 index-info.h           | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 77df380cb54..b1b334807f8 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -788,7 +788,9 @@ static enum parse_opt_result stdin_cacheinfo_callback(
 		return error("option '%s' must be the last argument", opt->long_name);
 	allow_add = allow_replace = allow_remove = 1;
 	ret = read_index_info(*nul_term_line, apply_index_info, NULL);
-	if (ret)
+	if (ret == INDEX_INFO_EMPTY_LINE)
+		return error("malformed input line ''");
+	else if (ret < 0)
 		return -1;
 
 	return 0;
diff --git a/index-info.c b/index-info.c
index 0b68e34c361..735cbf1f476 100644
--- a/index-info.c
+++ b/index-info.c
@@ -22,6 +22,11 @@ int read_index_info(int nul_term_line, each_index_info_fn fn, void *cbdata)
 		unsigned long ul;
 		int stage;
 
+		if (!buf.len) {
+			ret = INDEX_INFO_EMPTY_LINE;
+			break;
+		}
+
 		/* This reads lines formatted in one of three formats:
 		 *
 		 * (1) mode         SP sha1          TAB path
diff --git a/index-info.h b/index-info.h
index d650498325a..1884972021d 100644
--- a/index-info.h
+++ b/index-info.h
@@ -5,6 +5,8 @@
 
 typedef int (*each_index_info_fn)(unsigned int, struct object_id *, int, const char *, void *);
 
+#define INDEX_INFO_EMPTY_LINE 1
+
 /* Iterate over parsed index info from stdin */
 int read_index_info(int nul_term_line, each_index_info_fn fn, void *cbdata);
 
-- 
gitgitgadget

