Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998172EB5CF
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 13:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587598; cv=none; b=HJrWMr9nzy4rmOmxIXJSRBGsXBF0MRR1pvko9hKtIo+mdEeryUtsaWAnC59Lc3bTRYFy3u/aRo/sx/S6m9RdJDZhtMvhFjWt749/MFGGtauC77oM0RIpvUetDWrSjmZO2NnaW/AxjXTP/0wY9Qf4VFOkaAQqpsn7DkZSSBwSSMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587598; c=relaxed/simple;
	bh=VbLbGvm+PB3unTX3rlisYturvfB+j3opxessMsEPko4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3aO5tWZJvzuPHBYj0MrsQoeIAeOhqWBWwxzvKpxhNho6Y6hk4SkdBXqz2DumAS5ojBErOVvzP+kIJW8v3GRHnX7UXUPhtmGVDb8gHBCWM2+FAqMlkiI3RyQztVV8yikB3vG3UGZF1jRKXjrsJ59iuHYqlZqIrglhiLyeFvNeUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXwlylgG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXwlylgG"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-451d6ade159so39748235e9.1
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 06:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752587595; x=1753192395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=le2QGaGzo0bSe4kbwhr/jCVyaZqfv5a/FTodEzgsr1o=;
        b=QXwlylgGT11aOKEwpYt3pdar93HDsxBeIjSOx11P79yZ9KKxiFJ5WjwhJUDOuB3am2
         tFLHZaEH3K6rMzhBbGCMMrpCn9L8UGkoMXkRP0UBhqgXezwPqSD3E9Lm5Vf+gZ8TEK82
         Y9KmccnhhNl6B7QboyulNpnHq6UWnwKhcsRPXjeQznUMnZ9UjfMOuQDpn2IKnxysRMIc
         WNSqW/RZRhrbVAUWujCI/lCv33aGnv4HFtX2UwD9QFtP2gt2bdVH7ccZq4h3jYPk3iS+
         QgihwSG/5dAxpCtnxoENWtQv4ew8jp/3cE2wX6ui0wFqWsDCH36vAwsj1GRNx0puG2Ud
         w/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752587595; x=1753192395;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=le2QGaGzo0bSe4kbwhr/jCVyaZqfv5a/FTodEzgsr1o=;
        b=ZTh91YUMGruietuajZg61buyJOL6xdAtBuhw/EywPfOPVZdtM1AsHtG5tcfF9pnZnL
         dGdMghZqlU5Jqho/R7fQE8S2clQ7tbWqKkTqTaSAdf3dRalPX/JMVofiFr+b6ue+b7j4
         f9Z3xY65Cwz0WKPZGDclglr9Y/szcvWSKwPj19nq73UDvXWPdlN/GlqUXes/jvKrHfkJ
         HeR7j70lugFe6yVeeu/HTykI1PQ9vc62ZXHigH81BnL3DJU/Pnr+jLbSyPJzAqjMciXo
         ITe0QfVCZm+qvcrz/hN+PNYGKanGAerWLf/mpHJUhD15pYmQ/J4JNsscQDE97aNK07pX
         FCwQ==
X-Gm-Message-State: AOJu0YxhPgAIOI357BFbrAr02WMRzW1OGQejuZWsjeA1q2ZBthtbVxMo
	OWjOIRV7mTu7OJPh4XqqzMelxI2OHT/kkZLL/83wlQZWemkBurXi/XH5poEW1w==
X-Gm-Gg: ASbGncs9HiPeGgjHL1lXV5X4RNG3mapAa7tS6YvKhe8YJMW49suc733TzsvwvtgRHwe
	l72VrqSyxhNHRk1zq42dnF09mvdsuuJFUUbNYrR47TLs19UYjvfzYsONQr2gzq2dQtOo883IRaD
	WxCNn09NsvduEX+v+pjG0z5v6BNrzee5g2dK2tVVQA2vaN9tn2RdCl+v0d5+QQyI2OX5UyO0IvV
	mdfx5v7NRsU+uqmVYRR/oGOrPZ+nopxhY2o/k2EFv0GOpgGJ6C9nRolLwbw3U6mGzlFUFlFATOB
	H+DGseqTgQqRbXDJZnyTTV4oQlYfPw63RjyFCNFqV8Zxza+1Z/BLQ0r3xbwJDib+sPex4qcEhK4
	3U8UIk3kZCunuRQ74yxR6NE1MTcZheCxDxOm9Vl8yXS1UYAXYrVJmJbQ=
X-Google-Smtp-Source: AGHT+IFwB1ntCktjvAGivd7STnsyU2estaN+L74adwLpR2fe8qZ7/g96TCU3Lo0pKmTXcpqZdk9wDg==
X-Received: by 2002:a05:600c:8b75:b0:450:cf46:5510 with SMTP id 5b1f17b1804b1-454f426190amr156516795e9.29.1752587594736;
        Tue, 15 Jul 2025 06:53:14 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc3a54sm15421112f8f.39.2025.07.15.06.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 06:53:14 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	"Brian M . Carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 3/3] strbuf: convert predicates to return bool
Date: Tue, 15 Jul 2025 14:52:52 +0100
Message-ID: <66968714739dcca36c63cb951b13bd2aee6b9958.1752587571.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1752587571.git.phillip.wood@dunelm.org.uk>
References: <cover.1752499610.git.phillip.wood@dunelm.org.uk> <cover.1752587571.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Now that the string predicates defined in git-compat-util.h all
return bool let's convert the return type of the string predicates
in strbuf.{c,h} to match them.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 strbuf.c | 28 ++++++++++++++--------------
 strbuf.h | 12 ++++++------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index f30fdc69843..6c3851a7f84 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -8,55 +8,55 @@
 #include "utf8.h"
 #include "date.h"
 
-int starts_with(const char *str, const char *prefix)
+bool starts_with(const char *str, const char *prefix)
 {
 	for (; ; str++, prefix++)
 		if (!*prefix)
-			return 1;
+			return true;
 		else if (*str != *prefix)
-			return 0;
+			return false;
 }
 
-int istarts_with(const char *str, const char *prefix)
+bool istarts_with(const char *str, const char *prefix)
 {
 	for (; ; str++, prefix++)
 		if (!*prefix)
-			return 1;
+			return true;
 		else if (tolower(*str) != tolower(*prefix))
-			return 0;
+			return false;
 }
 
-int starts_with_mem(const char *str, size_t len, const char *prefix)
+bool starts_with_mem(const char *str, size_t len, const char *prefix)
 {
 	const char *end = str + len;
 	for (; ; str++, prefix++) {
 		if (!*prefix)
-			return 1;
+			return true;
 		else if (str == end || *str != *prefix)
-			return 0;
+			return false;
 	}
 }
 
-int skip_to_optional_arg_default(const char *str, const char *prefix,
+bool skip_to_optional_arg_default(const char *str, const char *prefix,
 				 const char **arg, const char *def)
 {
 	const char *p;
 
 	if (!skip_prefix(str, prefix, &p))
-		return 0;
+		return false;
 
 	if (!*p) {
 		if (arg)
 			*arg = def;
-		return 1;
+		return true;
 	}
 
 	if (*p != '=')
-		return 0;
+		return false;
 
 	if (arg)
 		*arg = p + 1;
-	return 1;
+	return true;
 }
 
 /*
diff --git a/strbuf.h b/strbuf.h
index 6362777c0a0..a580ac6084b 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -660,9 +660,9 @@ char *xstrvfmt(const char *fmt, va_list ap);
 __attribute__((format (printf, 1, 2)))
 char *xstrfmt(const char *fmt, ...);
 
-int starts_with(const char *str, const char *prefix);
-int istarts_with(const char *str, const char *prefix);
-int starts_with_mem(const char *str, size_t len, const char *prefix);
+bool starts_with(const char *str, const char *prefix);
+bool istarts_with(const char *str, const char *prefix);
+bool starts_with_mem(const char *str, size_t len, const char *prefix);
 
 /*
  * If the string "str" is the same as the string in "prefix", then the "arg"
@@ -678,16 +678,16 @@ int starts_with_mem(const char *str, size_t len, const char *prefix);
  * can be used instead of !strcmp(arg, "--key") and then
  * skip_prefix(arg, "--key=", &arg) to parse such an option.
  */
-int skip_to_optional_arg_default(const char *str, const char *prefix,
+bool skip_to_optional_arg_default(const char *str, const char *prefix,
 				 const char **arg, const char *def);
 
-static inline int skip_to_optional_arg(const char *str, const char *prefix,
+static inline bool skip_to_optional_arg(const char *str, const char *prefix,
 				       const char **arg)
 {
 	return skip_to_optional_arg_default(str, prefix, arg, "");
 }
 
-static inline int ends_with(const char *str, const char *suffix)
+static inline bool ends_with(const char *str, const char *suffix)
 {
 	size_t len;
 	return strip_suffix(str, suffix, &len);
-- 
2.49.0.897.gfad3eb7d210

