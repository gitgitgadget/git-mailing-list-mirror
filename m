Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C666B20312
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720622800; cv=none; b=TMcsURgWmL6B/XxuZZ1JAVGfwKkCThNO3O8xmyxqLmcnUKa/jBgNDxwPZez7sfakUKjDlrSiwKH55w9Viz9RRCI9RgtKw01MtVDmm6xSyymBJ7Kr0HKUsGMahmfdtFCuexe9vVsmvb8BBBfZzteSM9jfjmBF4BUleeW4FliZyOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720622800; c=relaxed/simple;
	bh=4S/eeYa3WSAOASAvQOCp2KZZaz7om+5BeG3DmzjcW/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eq/I1sueAvnyfGQTTbksOShB5tNSxnMYA4oFoHrSorsmpY+iFA6kLu0PzbJ2kLW7Rw0EE7MApreGEz3Ih3v/F08t2l+evLBHBJsa/yn6m0jjQEfxI+4pEdL71IS5GN4iB0TV1cGJMMfWMSKqYiSilZybXBrk8EvqiSx6n8Ne2Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAMtWTe5; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAMtWTe5"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70b42250526so2045183b3a.1
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 07:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720622797; x=1721227597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9UDRGCnen2eMRIWeoclWfDlQnsmaMv5ILJOERPNxlb4=;
        b=VAMtWTe5DiSvfPQ2SgA9eIl8guTAWbLjTvmluXdyCBkoX7NN6rlhS+js+qwPNmUj22
         miy0mULUgcsH3LNQ/KPaed/lIch31gNgKOWLhzeJ/fH0f5/kYxZwcrd+iuEOj2izsnoy
         KT47NHJTKVsSCbRhB6SuSzKMG/hBxHg4UTSKJPznKlWVB9yF7zRal3vAfCpYCZd+WZD0
         VB2fN26GWnEQ4eWYkeBvgvR4bejLd2cQ6ivrXPhkoCWZjqdGnWj2cYh2aSwDZljq35YA
         5xDnsbRQjRayW8uWNRL5/46V5crV/lkybn9puDHxuZvlJzU/Vh4SyOOJHOrxgYhyBU1o
         UHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720622797; x=1721227597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UDRGCnen2eMRIWeoclWfDlQnsmaMv5ILJOERPNxlb4=;
        b=nbWufsFHqDyb97S+Td4LpBXEYGjC4UYBGSudpQGxPJDXR4fyDETKDvjb/je+5pbF8m
         FrgOTsKIZoYKkWAezo6ZfQEyoN01U8e9D3Ibsa4j/FQOHFUVaP/kvI9g3GwthQwBIWRW
         P5qtbf0vdcMItp7Yeg8XgBIxyFrVkr/5d6/K8ODqqITNOo/zECbl6xGqcwJcSGKU/CkM
         +ZDTA1GlWdnvM/AN6/TbWYJeOCodxDPoEBJ29XPM5qGrnVspIhvCWOKOmh3qly9D7+Gh
         LxpAuV6i21Eq5bpkEOj7AjkuHQk9FvzFCGH33moi9+HwChLuTBdKHtZlK+z55CDIrIWU
         km8w==
X-Gm-Message-State: AOJu0YwqGsRK7+K2qbPb1HuU0VXQLE5y7EcRHlSyMdBg0WOq4fBu+VF0
	XsvQBhgnLjdhpUFHIqdR7bNv3O7sr3Be0S+NPI1c7O0WWT6RVjrNfIW8Uw==
X-Google-Smtp-Source: AGHT+IF2HU/pK4TQMIOSnlkcehQGnoC+vugU90GtlmP8uE+vNNToZolLdZa+Tqq+IV7nkr9rAnI8yw==
X-Received: by 2002:a05:6a00:1748:b0:706:8066:5cdf with SMTP id d2e1a72fcca58-70b435e9912mr5742722b3a.21.1720622797175;
        Wed, 10 Jul 2024 07:46:37 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b4389bc22sm3876550b3a.44.2024.07.10.07.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 07:46:36 -0700 (PDT)
Date: Wed, 10 Jul 2024 22:46:37 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v10 01/10] fsck: rename "skiplist" to "skip_oids"
Message-ID: <Zo6ezSp2Lx2G9N7N@ArchLinux>
References: <Zo6eJi8BePrQxTQV@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo6eJi8BePrQxTQV@ArchLinux>

The "skiplist" field in "fsck_options" is related to objects. Because we
are going to introduce ref consistency check, the "skiplist" name is too
general which will make the caller think "skiplist" is related to both
the refs and objects.

It may seem that for both refs and objects, we should provide a general
"skiplist" here. However, the type for "skiplist" is `struct oidset`
which is totally unsuitable for refs.

To avoid above ambiguity, rename "skiplist" to "skip_oids".

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 fsck.c | 4 ++--
 fsck.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fsck.c b/fsck.c
index eea7145470..3f32441492 100644
--- a/fsck.c
+++ b/fsck.c
@@ -205,7 +205,7 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 		if (!strcmp(buf, "skiplist")) {
 			if (equal == len)
 				die("skiplist requires a path");
-			oidset_parse_file(&options->skiplist, buf + equal + 1,
+			oidset_parse_file(&options->skip_oids, buf + equal + 1,
 					  the_repository->hash_algo);
 			buf += len + 1;
 			continue;
@@ -223,7 +223,7 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 static int object_on_skiplist(struct fsck_options *opts,
 			      const struct object_id *oid)
 {
-	return opts && oid && oidset_contains(&opts->skiplist, oid);
+	return opts && oid && oidset_contains(&opts->skip_oids, oid);
 }
 
 __attribute__((format (printf, 5, 6)))
diff --git a/fsck.h b/fsck.h
index 6085a384f6..bcfb2e34cd 100644
--- a/fsck.h
+++ b/fsck.h
@@ -136,7 +136,7 @@ struct fsck_options {
 	fsck_error error_func;
 	unsigned strict:1;
 	enum fsck_msg_type *msg_type;
-	struct oidset skiplist;
+	struct oidset skip_oids;
 	struct oidset gitmodules_found;
 	struct oidset gitmodules_done;
 	struct oidset gitattributes_found;
@@ -145,7 +145,7 @@ struct fsck_options {
 };
 
 #define FSCK_OPTIONS_DEFAULT { \
-	.skiplist = OIDSET_INIT, \
+	.skip_oids = OIDSET_INIT, \
 	.gitmodules_found = OIDSET_INIT, \
 	.gitmodules_done = OIDSET_INIT, \
 	.gitattributes_found = OIDSET_INIT, \
-- 
2.45.2

