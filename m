Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E577C2F2
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 01:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732669208; cv=none; b=Rvpe7HwFqoo0N3NeTof/8eS6ITndj4AeSSvd4jmRZ9OkZd3n4m4Cgg/3X1vuWufWbKNQzkovViuz4FBwB+9OYlVovqzidO9srJNSe47YYGxQ//oocPHdN3ykfHzC3JSW92+U9kL3LEgePvS4PhAWPCq6BAApYkpyHNDeL4YW7gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732669208; c=relaxed/simple;
	bh=X2VaIaMntmc9VU9b69QPWjhDdFX5rBtojjEasFi8VF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCrloBhqDFFg7o5I17a4f96E78/TlX7dOcOakqaeY24Aq4HVDrX1VbmDx0m3g1YBRs3SsQDNhT2g+hHMQsX1siVMxsNNLDDWAUy/SuJyRm09gCoLPg2yeS+9pitiF78eUfnNHwkXC9WEiwfmKHU2elPRHrQIE98m+SlvTpvYWu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNgvH+dc; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNgvH+dc"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-296252514c2so5806462fac.3
        for <git@vger.kernel.org>; Tue, 26 Nov 2024 17:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732669205; x=1733274005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erUhl5uuI4TnuCgs3xeNSVatBb9LC7OvXAhOmedCR3Q=;
        b=NNgvH+dcTKMxw082zNd16Zwb+UpYVt5+dnQvVziMYmy+XxBeXvmWEliJRtLlOppT4q
         xZBVDaFdzK+PwKBAvdQndIBR6hm8QBzs+itqCOIeD+MDsZawNj0YgLZAqcTxyCH2irYs
         gzPPIl1qBmrVWUc46tV9nfItHRHCcFa5frPgNe3xm7L9DJCC2nkxXdALtA7XqmCIdR8Q
         OS5goDIWp4P5dSl/BnHjIxRaK/oJLJ23974lEYWlUhWt5hpTa+ln86+SW6bw+nTykxa0
         PCAt5p2k8noDAFIQG3xBCDgIB++71L8926DFI1hmMeH6K+D0JEjmkaQhClNKvdMPr4lr
         XofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732669205; x=1733274005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=erUhl5uuI4TnuCgs3xeNSVatBb9LC7OvXAhOmedCR3Q=;
        b=oK1XVSlKQjo4b3a9xtATf0DnWFFVgzKAVrFT7I4wWYiLEVC4nRBJebq18wx4BbRsMh
         HCi08/bQWj28ZcdWulr7qHs6Y4chgHvZ2abS9V/oZNQ5XYNsBLOtbq5w/22/N5X42/wc
         0A+r5awctA2pn3owZVaJJnpYhk6f1lgdoEHhtx+m3auQDnZCmF1NsGTdKrFDQL15Zsz0
         z7p0CBDGBxMQYuu1C1ZQmxTWs4XEQrD7Bzchi35+cMrZCWI4AKJKseZGUxEmHDlxYrAE
         npbDS3/uQpiSv9zFmHPTIgQQgWdI349M+eJswy1kyu5FsRrPniEdyrkAgbg+Mm5r+z4p
         ozjA==
X-Gm-Message-State: AOJu0Yw7YIhRUfjLjrzPKUWtIBAxO9MQ9UM+Fxt190JzEokfv/uhrc+G
	svAglksFYFSgdFx2kcovQAxqw8gJE3Ktn01POiZeJpkokkzAv+sL/7y+/A==
X-Gm-Gg: ASbGncs/RvsX3xbTYmwkLv8Td3q64xeuf3Uoc0DP610Raac2nbMfwDG/IRaHxhtzUUz
	+Zmq7lpQNPvn7MeRW6DtYYI28LAJeQVpkbeXqlFkboQDsLsTvL3r/VpBgWnigNsi2TtXbCcZWrZ
	NarWixUM2d4wRARl92Ya/1RElp1HqfXaWH0PIP4ZHi3QOHOfSeBduWip4f4dAmRAAexYeux9crI
	kuLFxjHMB7hPkRnYp2/cZYmS2rKYbAwjDYtDno7E0v6DyJEm7nmlNeXpw==
X-Google-Smtp-Source: AGHT+IG4edtc4mjeb9c0Uc3l8H4dBVGNJSpXQX9mdQnQMQhfbTRwWveJxwbqkmOBwBR6CkXNdxV9qA==
X-Received: by 2002:a05:6871:29b:b0:270:1fc6:18 with SMTP id 586e51a60fabf-29dc3fb72aemr942011fac.3.1732669205241;
        Tue, 26 Nov 2024 17:00:05 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71c0378d26esm3316643a34.31.2024.11.26.17.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 17:00:04 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 3/4] fetch-pack: split out fsck config parsing
Date: Tue, 26 Nov 2024 18:57:06 -0600
Message-ID: <20241127005707.319881-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127005707.319881-1-jltobler@gmail.com>
References: <20241121204119.1440773-1-jltobler@gmail.com>
 <20241127005707.319881-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When `fetch_pack_config()` is invoked, fetch-pack configuration is
parsed from the config. As part of this operation, fsck message severity
configuration is assigned to the `fsck_msg_types` global variable. This
is optionally used to configure the downstream git-index-pack(1) when
the `--strict` option is specified.

The same parsed fsck message severity configuration is also needed
outside of fetch-pack. Instead of exposing/relying on the existing
global state, split out the fsck config parsing logic into
`fetch_pack_fsck_config()` and expose it. In a subsequent commit, this
is used to provide fsck configuration when invoking `unbundle()`.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 fetch-pack.c | 24 +++++++++++++++++-------
 fetch-pack.h |  3 +++
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index fe1fb3c1b7..e7d4f6e6e2 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1857,8 +1857,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	return ref;
 }
 
-static int fetch_pack_config_cb(const char *var, const char *value,
-				const struct config_context *ctx, void *cb)
+int fetch_pack_fsck_config(const char *var, const char *value,
+			   struct strbuf *msg_types)
 {
 	const char *msg_id;
 
@@ -1867,8 +1867,8 @@ static int fetch_pack_config_cb(const char *var, const char *value,
 
 		if (git_config_pathname(&path, var, value))
 			return 1;
-		strbuf_addf(&fsck_msg_types, "%cskiplist=%s",
-			fsck_msg_types.len ? ',' : '=', path);
+		strbuf_addf(msg_types, "%cskiplist=%s",
+			msg_types->len ? ',' : '=', path);
 		free(path);
 		return 0;
 	}
@@ -1877,14 +1877,24 @@ static int fetch_pack_config_cb(const char *var, const char *value,
 		if (!value)
 			return config_error_nonbool(var);
 		if (is_valid_msg_type(msg_id, value))
-			strbuf_addf(&fsck_msg_types, "%c%s=%s",
-				fsck_msg_types.len ? ',' : '=', msg_id, value);
+			strbuf_addf(msg_types, "%c%s=%s",
+				msg_types->len ? ',' : '=', msg_id, value);
 		else
 			warning("Skipping unknown msg id '%s'", msg_id);
 		return 0;
 	}
 
-	return git_default_config(var, value, ctx, cb);
+	return -1;
+}
+
+static int fetch_pack_config_cb(const char *var, const char *value,
+				const struct config_context *ctx, void *cb)
+{
+	int ret = fetch_pack_fsck_config(var, value, &fsck_msg_types);
+	if (ret < 0)
+		return git_default_config(var, value, ctx, cb);
+
+	return ret;
 }
 
 static void fetch_pack_config(void)
diff --git a/fetch-pack.h b/fetch-pack.h
index b5c579cdae..c667b6fbf3 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -106,4 +106,7 @@ int report_unmatched_refs(struct ref **sought, int nr_sought);
  */
 int fetch_pack_fsck_objects(void);
 
+int fetch_pack_fsck_config(const char *var, const char *value,
+			   struct strbuf *msg_types);
+
 #endif
-- 
2.47.0

