Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC953A16AE
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 18:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781289018; cv=none; b=DJW0UyvGj61CiqQtDbas7N9CK3RbXE6yIMbHYwJxPhEYmcZILnrHKOCNwcx1SP8wxy4b7NHeaWQ2Y7E+KBe5xzO6vo/lNN6ULLgj+I2ANUnSnwyExoW0jREn1x7k8EO13KCcOHa9knDAx89I5DwvyVrdmIXJbEEQjOcniT0rejI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781289018; c=relaxed/simple;
	bh=mbEEUiZymbg4G5XJHWjdbpElpDwrzIu1aN5RCut61sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rY3OxkFZ0u1d/SACe4b0KHTXPsUDKiX+PVNGI8tCtn3ueWvJuDpsEAko4mojEW6bV1fv/8p+0QPnmlyWgBNrl3CmPkFEpdJJVLgwTYFrgpny4J/p8NSxHrjxSby+P23j5HT3emzldFmFrbIcu20CKtbXKVJKsHf/lXlPahuIrqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fe/6sgS3; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fe/6sgS3"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8424b00710aso986019b3a.0
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 11:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781289015; x=1781893815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhfHHHPF0SkqPQSI0xfLwOJuPPm1a1LI6Y08SVx9jXI=;
        b=fe/6sgS3OQ+ZqW/mgN/Vvl0dZ9CTD2sdFV0XMka8ujosUD1XSrbM8B6AK93o5f5gB6
         K+6q9pIicTCBddoVuK50wI5/QNlKJ1m3Df6/6uZ00UdkcwF2w4mSkEGXvmC33mTRJbHW
         1Wd19+5BhcJk6BTdkXGJ7+oAtsnHGB8sL9t8I2bd/iq6hdSbDtF2neRaSt/NSHNUzFJE
         9CK1wyTD1xTA4/1JfGWET8Po/zSdWNJE+/0cOdUxouaz3d0PzSIAH7lKaEGB4WAyEvWR
         SZagL7JTVjS9t1qEOIy2aob1KlSJq9T4fFziCo/WzwcOM0yytgc983X0UkG5AEbU562V
         1cXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781289015; x=1781893815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GhfHHHPF0SkqPQSI0xfLwOJuPPm1a1LI6Y08SVx9jXI=;
        b=U/5vXMujEqWXcZ7cnOfnS5ujTDHyqM/YlsZCvhI9Dq5AKjUARSHYeCcfESh4kOj8JF
         jea4JJIplTl+VGkGTRXQc6ZKW3VE9rubYjYjAmbpty+LebdftQs/f32wWQ4rfFIuM3JF
         KFUxpoOiE4TrwdY1Ewli4sol7WsSLQ0bUdC7NPhQuProKlQf2K5cI7GXXHu34LEWd9MC
         BJLeWLQ2g1khSSzXSLsEaBqwEKyZpmcjjTjY1F6IFmYPlq4VObk5l3SCWIIU6rM9Ezmz
         YtAYH7EpmNquRY3SsW5YCSqhrhTkoYxxixmvFg38CXpS5lkqP6cG1PxNsiw6udkixCCn
         rejA==
X-Forwarded-Encrypted: i=1; AFNElJ+3ykqrVoAjHeTwjf3jHhD45tYkWPjJnN7xdgXMdf5Nua5q6GeUakMb5gtFMW2riS2dSXU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjk/nT9H9Ve4qQx4+0trTQ+gejqPU1tnRKYP2MBLDxrrk2rMRI
	hxD69Td4WySCIedfBNK9dbHsJuocBGuJdInnXJ/2jnWscTE3WYYctHXZ
X-Gm-Gg: Acq92OF2dLVBQ0wzs6mNtXaMTGPwswtiafpq0PPmR+FnJLb4J46EHIj6GSmNlWgmm6b
	HrRUdz+Na1Axt5L6r4cII9Uv3pKZPeMXnKOqRIIL00u3BUS9lSSQ2HTgOJBxhtDi8vFjwW6BUWH
	fIRQl4tgJx/flGeNZmcR96VNdQVxo+s/Byh1tPgDR+c3f8BlxXYB088fhg+Tb/rsaATAzXzRnJ6
	DRtgkEEWpLa8L0Ae4D8kaHrQpJmEHfVgDxmR9ncOLxE00w3XKEH4S5K2rjdxhsYhcjtLzuWIIkh
	wex0pcaHv9XLTS5dh87I5dWcVNy0F6FuoTMbT88iIh7jq+Nu7/37XPSjMcJwIwkNAXNRRQVpSko
	XC/7sRIttluizwjiJ5fMpFTr0Dwl0rtwyVYKoQyREVhWCSj3R/6Ip2/tNU3/iuRzScZ02Zhydgp
	bHN56KuQXBuTe4A1qaoOuzRuIPyII9sUk8l8WvhAgtwBtnrJGaTpwpQvBsX08bwSScrPgfejDer
	79MpSsXoG1+EX+Z58qOAmgEgs0hQuAFVBS8qidW/iBL
X-Received: by 2002:a05:6a00:2e9c:b0:82f:5034:77a4 with SMTP id d2e1a72fcca58-8434cdeedabmr4459709b3a.21.1781289014568;
        Fri, 12 Jun 2026 11:30:14 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afc9fa8sm3341488b3a.32.2026.06.12.11.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 11:30:13 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: a3205153416@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	kumarayushjha123@gmail.com,
	lucasseikioshiro@gmail.com,
	phillip.wood@dunelm.org.uk,
	sandals@crustytoothpaste.net
Subject: [GSoC Patch v3 1/4] path: introduce append_formatted_path() for shared path formatting
Date: Fri, 12 Jun 2026 23:58:44 +0530
Message-ID: <20260612182847.562816-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612182847.562816-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260612182847.562816-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The path-formatting logic in builtin/rev-parse.c is tightly coupled
to that command and writes directly to stdout, making it impossible
for other builtins to reuse.

Extract the core algorithm into append_formatted_path() in path.c
and expose a path_format enum in path.h so that any builtin can
format paths consistently without duplicating logic.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 path.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 path.h | 36 ++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/path.c b/path.c
index d7e17bf174..5e83e3e4f6 100644
--- a/path.c
+++ b/path.c
@@ -1579,6 +1579,76 @@ char *xdg_cache_home(const char *filename)
 	return NULL;
 }
 
+void append_formatted_path(struct strbuf *dest, const char *path,
+			   const char *prefix, enum path_format format)
+{
+	switch (format) {
+	case PATH_FORMAT_DEFAULT:
+	case PATH_FORMAT_UNMODIFIED:
+		strbuf_addstr(dest, path);
+		break;
+
+	case PATH_FORMAT_RELATIVE: {
+		struct strbuf relative_buf = STRBUF_INIT;
+		struct strbuf real_path = STRBUF_INIT;
+		struct strbuf real_prefix = STRBUF_INIT;
+		char *cwd = NULL;
+
+		/*
+		 * We don't ever produce a relative path if prefix is NULL,
+		 * so set the prefix to the current directory so that we can
+		 * produce a relative path whenever possible.
+		 */
+		if (!prefix)
+			prefix = cwd = xgetcwd();
+
+		if (!is_absolute_path(path)) {
+			strbuf_realpath_forgiving(&real_path, path, 1);
+			path = real_path.buf;
+		}
+		if (!is_absolute_path(prefix)) {
+			strbuf_realpath_forgiving(&real_prefix, prefix, 1);
+			prefix = real_prefix.buf;
+		}
+
+		strbuf_addstr(dest, relative_path(path, prefix, &relative_buf));
+
+		strbuf_release(&relative_buf);
+		strbuf_release(&real_path);
+		strbuf_release(&real_prefix);
+		free(cwd);
+		break;
+	}
+
+	case PATH_FORMAT_RELATIVE_IF_SHARED: {
+		struct strbuf relative_buf = STRBUF_INIT;
+
+		/*
+		 * If we're using RELATIVE_IF_SHARED mode, then we want an
+		 * absolute path unless the two share a common prefix, so don't
+		 * default the prefix to the current working directory. Doing so
+		 * would cause a relative path to always be produced if possible.
+		 */
+		strbuf_addstr(dest, relative_path(path, prefix, &relative_buf));
+		strbuf_release(&relative_buf);
+		break;
+	}
+
+	case PATH_FORMAT_CANONICAL: {
+		struct strbuf canonical_buf = STRBUF_INIT;
+
+		strbuf_realpath_forgiving(&canonical_buf, path, 1);
+		strbuf_addbuf(dest, &canonical_buf);
+
+		strbuf_release(&canonical_buf);
+		break;
+	}
+
+	default:
+		BUG("unknown path_format value %d", format);
+	}
+}
+
 REPO_GIT_PATH_FUNC(squash_msg, "SQUASH_MSG")
 REPO_GIT_PATH_FUNC(merge_msg, "MERGE_MSG")
 REPO_GIT_PATH_FUNC(merge_rr, "MERGE_RR")
diff --git a/path.h b/path.h
index 0434ba5e07..6aca53b100 100644
--- a/path.h
+++ b/path.h
@@ -262,6 +262,42 @@ enum scld_error safe_create_leading_directories_no_share(char *path);
 int safe_create_file_with_leading_directories(struct repository *repo,
 					      const char *path);
 
+/**
+ * The formatting strategy to apply when writing a path into a buffer.
+ */
+enum path_format {
+	/*
+	 * Represents the default formatting behavior. Treated as
+	 * PATH_FORMAT_UNMODIFIED by append_formatted_path().
+	 */
+	PATH_FORMAT_DEFAULT,
+
+	/* Output the path exactly as-is without any modifications. */
+	PATH_FORMAT_UNMODIFIED,
+
+	/* Output a path relative to the provided directory prefix. */
+	PATH_FORMAT_RELATIVE,
+
+	/* Output a relative path only if the path shares a root with the prefix. */
+	PATH_FORMAT_RELATIVE_IF_SHARED,
+
+	/* Output a fully resolved, absolute canonical path. */
+	PATH_FORMAT_CANONICAL
+};
+
+/**
+ * Format a path according to the specified formatting strategy and append
+ * the result to the given strbuf.
+ *
+ * `dest`   : The string buffer to append the formatted path to.
+ * `path`   : The path string that needs to be formatted.
+ * `prefix` : The directory prefix to calculate relative offsets against.
+ * Pass NULL to default to the current working directory where applicable.
+ * `format` : The formatting behavior rule to execute.
+ */
+void append_formatted_path(struct strbuf *dest, const char *path,
+			   const char *prefix, enum path_format format);
+
 # ifdef USE_THE_REPOSITORY_VARIABLE
 #  include "strbuf.h"
 #  include "repository.h"
-- 
2.54.0

