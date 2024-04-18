Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DD31442F4
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 18:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713465668; cv=none; b=WBbSMZqKVcwC5HRBegpE5QlVGts/JG3bSOXbClo+Or5+7ui1qpbW19dB3itftHu74PZL6xOSoxSYakoGpmh0SzV/7zdC5F+dDWNpTtKoO4ckMTtYlLQ9e80xg4sj1H26ZP/ZDiWXR/CtOwv6ODgReUscZOM3mtlEe1kyLTGj8ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713465668; c=relaxed/simple;
	bh=EVvDz1LlLXbUrD2vKTwc5YSXTSRM10IiSgfejBTEpbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BS/xDDef36XVtvLdCApIinKnwuktTZ1yLEUoXU7vgcCcjsQEwffn5pI8l2dYJszEQ5VmRUMcDSewaFuHJNfe8JMQ1anreKGAyAbGaPz/DGMOEKWV3yIHQpyMxPFdet3ojM2C3YGF1Mo7OjQLYBPouf9os48cI5RvE9LNOwU8zsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZjBc/MQ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZjBc/MQ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41550858cabso9237895e9.2
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 11:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713465664; x=1714070464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7Y0PGMG/OeSnikLwTeetw2v3faGtG5ifwuC7RrJJs4=;
        b=XZjBc/MQ/uWQJAzHDGZZxhDTSjYOZZ/AqPzCc7sboPGTrSw1ElcbJxp/y+TAqpvVQz
         PH8Z1y3GBOj08xIvX9l+Ys0ToJuAkKZOWY8IYSri+oLCMqOhPmtHLtJML9jqpaGDSx4n
         pouDD6xBGfQs8f6MCwYI8gSYnjMVw5wvlbTSNVINaKNzFW2zMUN5bNpa+hY1C59ECDNX
         4wencrr7ewgbzcJUQvBMNhVCPCiTYxlsyQQpjF6MnaUog18PdcWWLcP2fepn1pdwmXUQ
         oIfimcpYKAyfFcpD8EfP7C2ZpfN5CNVBn7AImo4x9tpB6OdkkXSL7FceWyX5KfdWVlKe
         zmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713465664; x=1714070464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7Y0PGMG/OeSnikLwTeetw2v3faGtG5ifwuC7RrJJs4=;
        b=EPZK6TlJ/OhXzaDBkxdRTQAEZaO6lCuFjDbxF804A87MMR+a3tjJplUdgHVJuJyLMx
         +c52Rep5bwFzt09UM1YZiXder0s2eIDkyhZcTkVIvmvJ3AilUpGLRHw6SpiKwrpGxQ6v
         sR3e1wN/VmWZZxNJQChZ1mTggxIfF8oQc6+5wympfcUjDU81bt1IAAo7z4lW3MkJotuQ
         9FCrfa4ntpPmOE1TTcrnfWd/kOv8uYURXhW0ua9vYfm24Q5rrQ/wm42snpzi3dqnfGKF
         ap1Xd533N1y/0hD45tGp1oVGPEBgwW9JyAn1245CQXHKCSzAF1CgT5IZVhVaM6Lp1d0p
         xJ5w==
X-Gm-Message-State: AOJu0YxpO6d2+NwuD4r8CSp5igd48U8gg1oYw2C2mttRediaa/WPr94M
	wVB+1f7NL4aNsv/WkUMh45AyNCZ8bcF9cmMqA1if0qdSEUobybveKYQdJg==
X-Google-Smtp-Source: AGHT+IGlxfG0VbFGRBh7amyf/w8Xm3FiiCLbMyzBn52NIgHM2GGjDPamRGmtA873tP13ta/rdAZk8g==
X-Received: by 2002:a05:600c:1d12:b0:418:fd27:692 with SMTP id l18-20020a05600c1d1200b00418fd270692mr543151wms.14.1713465664239;
        Thu, 18 Apr 2024 11:41:04 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c450d00b00417f700eaeasm3653670wmo.22.2024.04.18.11.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 11:41:02 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/4] missing: support rejecting --missing=print
Date: Thu, 18 Apr 2024 20:40:41 +0200
Message-ID: <20240418184043.2900955-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.44.0.655.g111bceeb19
In-Reply-To: <20240418184043.2900955-1-christian.couder@gmail.com>
References: <20240418184043.2900955-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`git pack-objects` supports the `--missing=<missing-action>` option in
the same way as `git rev-list` except when '<missing-action>' is
"print", which `git pack-objects` doesn't support.

As we want to refactor `git pack-objects` to use the same code from
"missing.{c,h}" as `git rev-list` for the `--missing=...` feature, let's
make it possible for that code to reject `--missing=print`.

`git pack-objects` will then use that code in a following commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/rev-list.c | 2 +-
 missing.c          | 4 ++--
 missing.h          | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index f71cc5ebe1..a712a6fd62 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -539,7 +539,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			int res;
 			if (revs.exclude_promisor_objects)
 				die(_("options '%s' and '%s' cannot be used together"), "--exclude-promisor-objects", "--missing");
-			res = parse_missing_action_value(arg);
+			res = parse_missing_action_value(arg, 1);
 			if (res >= 0) {
 				arg_missing_action = res;
 				break;
diff --git a/missing.c b/missing.c
index 83e0c5e584..d306dea2d9 100644
--- a/missing.c
+++ b/missing.c
@@ -2,7 +2,7 @@
 #include "missing.h"
 #include "object-file.h"
 
-int parse_missing_action_value(const char *value)
+int parse_missing_action_value(const char *value, int print_ok)
 {
 	if (!strcmp(value, "error"))
 		return MA_ERROR;
@@ -12,7 +12,7 @@ int parse_missing_action_value(const char *value)
 		return MA_ALLOW_ANY;
 	}
 
-	if (!strcmp(value, "print")) {
+	if (!strcmp(value, "print") && print_ok) {
 		fetch_if_missing = 0;
 		return MA_PRINT;
 	}
diff --git a/missing.h b/missing.h
index c8261dfe55..77906691e7 100644
--- a/missing.h
+++ b/missing.h
@@ -13,6 +13,6 @@ enum missing_action {
   if parsing failed. Also sets the fetch_if_missing global variable
   from "object-file.h".
  */
-int parse_missing_action_value(const char *value);
+int parse_missing_action_value(const char *value, int print_ok);
 
 #endif /* MISSING_H */
-- 
2.44.0.655.g111bceeb19

