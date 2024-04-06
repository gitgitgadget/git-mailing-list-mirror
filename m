Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0B61CFB9
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712413954; cv=none; b=E7T3C1xHAbs9Qo5H26bTMrY0po7hUnFR8wVUmhMS7XOfsR5KoW8YgBufZi7afyjVJZG2hAG0QWT6yh440rWYZSHGZNBk//D1jiVGg3cOj6vjJxuMZ0VNKfVCDoNrkWr8ARQCQBz87oFrAb9GRe3wNTyacjtJHU5IrYTn2S48slc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712413954; c=relaxed/simple;
	bh=Og23LSkc0Mr94v7KfXLW2IIuIM2RqejPy/yHfmJZqyA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=q6mWzCr0dL1YWHEThRjLcqSaf16xUs/8Gd7mEacS05OEEJgAXLj7Cs8mhrq9BLbWP9iWk3ikSoYIT2IsSQqXODi2xfRgsZivX/EMpoWHepKvqUxLcMFdpTfpuvAHCbCPWiWS3sDkuGpITJoKhCuRg29XUIY/3IfuqD5tc1CJN88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIVQU+CF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIVQU+CF"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4164a19aaf5so417675e9.1
        for <git@vger.kernel.org>; Sat, 06 Apr 2024 07:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712413951; x=1713018751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3U+U7nw5R6vsgRPJruyEZSyzrtmViEZeQRRexO5wiKc=;
        b=GIVQU+CFRvJ6rfvNfhoH78vuMdwGCYXHBtXP8oHhjGROWX3mC5R7wB2hCI0gIiVHcC
         12VFXLZ5te3/1yVe2+xF70tLFoJ2trgkt1M+MGuG4AEBtm82hHJPxrF2WoVK+N23/nST
         2QQs1us/oDG0ruII4wfVQxc8iDT+6qetizhJ3BujVK3xzWbpSfwkYMKySCixmEGwarvV
         +NsUSMB6KmNUKB4/HaDDbCzHEx6mrGXgv0Zl17vpZbKoP2vRJ49o6TgWXe7+kMJVZ06q
         gxwKH0O2aaUT3TOOIOR4g20D3TdZM6z6SO3tuZlf9v5erEcNlPkxpX6FGfaSVbsejqCP
         FpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712413951; x=1713018751;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3U+U7nw5R6vsgRPJruyEZSyzrtmViEZeQRRexO5wiKc=;
        b=Ot7LNlkR73WxC72pGLL0JIuIpv/cM7FUY+3cZPEKyPqSOS3LS9tFgVfaRM4aQxiV1x
         fEfwZOppT4Hj3271e/KEwuStQireSjzCjRAleknhYBQ7AWHZ6EeF9vmW5iqixmt45Z1V
         OtFm283nrCC+wsQU2uTqIlgNEKNpaO6FVNSDYfrHN0QUr88E4qCollhICUVBYEEeAMO9
         A0axzrRsDpt+Sy4D9UJo6SX3yfzVI4tuEAZHL1jnMPsGIs1hvc8peuvRvYTGYTK4L7cT
         GQ7KONL/Z9XQcKDpTZ2AHVxS8dri/SOOx0e2F5KG3Cd6b6mBLGsXPdpc56SKegqev+oc
         TVIQ==
X-Gm-Message-State: AOJu0Yz30IMxRG9JTQiFkTSX5+IA3qs+rFJZ79BwhFr+U0+qi66Ir4Oi
	2wSfk5OHjV+l8DDGgc+wqUq2ZsGZWrf7wM7JaW++S61NsIGyjEXFKEGx9Hij
X-Google-Smtp-Source: AGHT+IGNk6Aa5G8WPCkdslptH0fL1hZ5Qmkvq+RlICVh1pKxQCTLXf9gcUAppUCVG0QAIf5k14M5cA==
X-Received: by 2002:a05:600c:3ba7:b0:416:2abe:b886 with SMTP id n39-20020a05600c3ba700b004162abeb886mr4237215wms.0.1712413951579;
        Sat, 06 Apr 2024 07:32:31 -0700 (PDT)
Received: from gmail.com (4.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.4])
        by smtp.gmail.com with ESMTPSA id fc9-20020a05600c524900b004162d0676cdsm6671002wmb.29.2024.04.06.07.32.30
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Apr 2024 07:32:31 -0700 (PDT)
Message-ID: <f58d8114-f6fe-4b4e-85be-3b57609a3687@gmail.com>
Date: Sat, 6 Apr 2024 16:32:17 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/4] config.c: introduce git_config_strbuf_pathname
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <f4af1e88-5bd9-4b3c-8691-84dbf0ca3ee2@gmail.com>
Content-Language: en-US
In-Reply-To: <f4af1e88-5bd9-4b3c-8691-84dbf0ca3ee2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a new git_config_strbuf_pathname function, similar to
git_config_pathname, that works with a strbuf relying on the recently
introduced strbuf_interpolate_path.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 config.c | 10 ++++++++++
 config.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/config.c b/config.c
index eebce8c7e0..9beeb63b50 100644
--- a/config.c
+++ b/config.c
@@ -1355,6 +1355,16 @@ int git_config_pathname(const char **dest, const char *var, const char *value)
 	return 0;
 }
 
+int git_config_strbuf_pathname(struct strbuf *dest, const char *var, const char *value)
+{
+	if (!value)
+		return config_error_nonbool(var);
+	strbuf_interpolate_path(value, 0, dest);
+	if (!dest->len)
+		die(_("failed to expand user dir in: '%s'"), value);
+	return 0;
+}
+
 int git_config_expiry_date(timestamp_t *timestamp, const char *var, const char *value)
 {
 	if (!value)
diff --git a/config.h b/config.h
index f4966e3749..e405f1c140 100644
--- a/config.h
+++ b/config.h
@@ -22,6 +22,7 @@
  */
 
 struct object_id;
+struct strbuf;
 
 /* git_config_parse_key() returns these negated: */
 #define CONFIG_INVALID_KEY 1
@@ -287,6 +288,7 @@ int git_config_string(const char **, const char *, const char *);
  * user's home directory when found at the beginning of the path.
  */
 int git_config_pathname(const char **, const char *, const char *);
+int git_config_strbuf_pathname(struct strbuf *, const char *, const char *);
 
 int git_config_expiry_date(timestamp_t *, const char *, const char *);
 int git_config_color(char *, const char *, const char *);
-- 
2.44.0.697.g9b33b46f29
