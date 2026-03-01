Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E80913E41A
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 14:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772373826; cv=none; b=Gzly5gyslG7sUzAzT8YPhECTOIgb0d9V8yIPHpZ7+Y5OtSnglP8RHQBdqpkMI7FnWuI/hln3R5efGyvl5KVvXESpUp3KDXgKcdCIRViYgzUatmsdy8BbLd2eJtGsk2/X6VDH+8gvk0RKcYz8uvsvhHmFP3b/kcYu+boVGSsdVGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772373826; c=relaxed/simple;
	bh=ixlYJMgxiOM2Y0Eu381xwq/b8EP1IBEOS7DLM3dnSMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZqGMLkrRsZ1UYSmmfjuDJGm/ntHpm18y5DExzI05d5tF8lkwo4/QNKxH0SUQOrlh6fehdsKzoYAdmYyYEBEjaqeSr0NGZcrYO2pDwP7bFoD8flOX1NofxW+ruhJKKrMA3x6qrQnKNQcOXilxpcKxfb2iS5MufTP+k8RRMuoyQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uyce/nGD; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uyce/nGD"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ae46b9c70dso2029225ad.1
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 06:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772373824; x=1772978624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4gXsej8ochLzjTRveCfCTFAPmP9WzGSlbF0ClExSrY=;
        b=Uyce/nGDg+TwFniXKfS1DL5GO7HbZGtfI1W6wvLgFXkD+ksY5lShB+Js469UKW6ZBW
         Wbt+zhBv4FtarxI7n7Ufl24+zrKqtDSyh1N22TeSR8JG4sufJggn9juI6dbJOSiUPbDu
         Pmm0kcgUXh1pDy+YZXNdYL2xdN3789aVvZ7ph8unJXApKPWz2dzPqG63X5xz5Q5gR6z6
         ++Ij0MblztRrHinzIwqDwKIH4ZR8HUvoy5zfHFshOCkJVovTF74dl+3zGxhmtWz2YGGR
         dxrtbiCIQKX91d9Nz77NudWBQegTntThLSYvvz14wFQHyyUs8alInLN8odE53n2EZpI8
         Ru2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772373824; x=1772978624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/4gXsej8ochLzjTRveCfCTFAPmP9WzGSlbF0ClExSrY=;
        b=f4GmCXxYFwdYVQ4Jfsq7hTA/slhEZ6/DdJ/Z2FhmKsKMzU/LsX6hT6CKDTmqjFz7JH
         jDle/xQ8WWjtcq3moNRH9WqPFEm9tyOFPBOfhHx91Mp8mA6xKUhfSdTRQjJs1SfwCcv2
         aFZmAik0D/WlWnHMefAm4bVhtuetUE6AtVWA5YAkuEN9iG3DuzgY4rOSzBuhueWPf3xO
         69F0T2LPU9WDBXrBV00m3FEag6p4J0A26bwbmQcO8HU1aUGHRscuFMtWOlh/c7ifW2LI
         zKbdiLV6wFFrDfVrpo7wmjKobcB/G1tGy3gdyuTKTCSqlOmavbWoVOHaV7Ep5Mbuv7jZ
         9cXw==
X-Gm-Message-State: AOJu0Ywr5ilVb+oJri+wA8KQ7fbrp+JRB5FYR+KoQMYEnUVXqBckRQHJ
	24LDPwMnC6AHD7yCPFbhO9gFLeu4VYp5rOwgeYlOo91zbWvz1pDCYNnnILCk0Jyo
X-Gm-Gg: ATEYQzyWy/va1wtXheYDN9kiZmieqVo98TTN9sLsqZUVtaG3f5VUAaE3QZvgD71GXJJ
	spWWSPlmXiQcWh2yvS4cmsrspL0Zr1N1r1ClEW4UBCTWXB1eLUukHMY1+xwSkHFvG4lRHenmhNm
	kczHNE1QTC4Gp0lgy2l83cSDoGAY8oWNl6xSgUmXf+7ewG8s0ODAxNZBvRVNgkk3p8hbDUqlS87
	5qpLShzfPR9Su3cWlXwnsh/lIWJllsMCMiSo3M9IKJSpfro4hglLqJkOZGaYDtmUb2vOKv0Yw5A
	vkIc3hai6gfkD8T36u2JwGz/saiXdGA+qhrG4XI7x5jUlFfVS4pI+5aH3dlQ0xZzGdroNfDjaYe
	/OsQA+cog8/p92oAHoYFM0xkmweF6KAzOnvxG69tIFqfJLDqENuqLzCNITvAbXeZp41CHUvooyd
	Nlw/qGLetPl1ThthTDfqYvxghXEHqJdkQa6fdoFRQW+aSF
X-Received: by 2002:a17:903:1a43:b0:2aa:e817:1bda with SMTP id d9443c01a7336-2ae2b6502e1mr87948655ad.12.1772373824558;
        Sun, 01 Mar 2026 06:03:44 -0800 (PST)
Received: from Pushkar.xu.edu.in ([103.92.44.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5c3b01sm116545785ad.31.2026.03.01.06.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 06:03:44 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthiknayak@gmail.com,
	lucasseikioshiro@gmail.com,
	patrick@pks.im,
	peff@peff.net,
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Subject: [PATCH 2/2] repo: add the field path.common-dir
Date: Sun,  1 Mar 2026 14:03:16 +0000
Message-ID: <20260301140315.1072729-2-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260301134412.1072596-2-pushkarkumarsingh1970@gmail.com>
References: <20260301134412.1072596-2-pushkarkumarsingh1970@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose the repository common directory through a new
path.common-dir field in git repo info.

This mirrors the information available via
git rev-parse --common-dir and allows structured
retrieval through the repo subcommand.

The value respects the --path-format flag.

Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
 builtin/repo.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/builtin/repo.c b/builtin/repo.c
index 8b4c7ae4cb..d42ac2478b 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -88,6 +88,21 @@ static int get_path_git_dir(struct repository *repo, struct strbuf *buf,
 	return 0;
 }
 
+static int get_path_common_dir(struct repository *repo, struct strbuf *buf,
+				 const char *prefix,
+				 enum path_format_type format)
+{
+	const char *commondir = repo_get_common_dir(repo);
+
+	if (!commondir)
+		return error(_("unable to retrieve common directory"));
+
+	strbuf_add_path(buf, commondir, prefix, format,
+					PATH_DEFAULT_RELATIVE_IF_SHARED);
+
+	return 0;
+}
+
 static int get_references_format(struct repository *repo, struct strbuf *buf,
 				 const char *prefix UNUSED,
 				 enum path_format_type format UNUSED)
@@ -102,6 +117,7 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "layout.bare", get_layout_bare },
 	{ "layout.shallow", get_layout_shallow },
 	{ "object.format", get_object_format },
+	{ "path.common-dir", get_path_common_dir },
 	{ "path.git-dir", get_path_git_dir },
 	{ "path.toplevel", get_path_toplevel },
 	{ "references.format", get_references_format },
-- 
2.43.0

