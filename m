Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6648B2D8DA7
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869833; cv=none; b=IoqNQ8tHI6WsUFsg5i8TFBfqamwOxhhKvYrHGM61wDpgA9P4pKzGJ3CYhtuIkhW8blQ4JcPt7zOvlJLMz7wdoiRimW1ZoQXmE1eGyIE/rWKLJLllBvMqHl9Sp79hR7fy1mM5xXoKDW9AFyJqoO+IWDYpy1llpMl54RqTPvHc9hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869833; c=relaxed/simple;
	bh=anm90cE6oQbh86schdLhxQYtEI25TXQ0xD81rTbazmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qhmcwvHz8KU5ImQ+/cDSJPtHxKL1F+cSQP9P6DaWh2iBIJxdWat2TkggZyz1R8CKSSPlbKX/MvycmiN72wCb3AvAKgQyXiJrkpS+rR4/YIP5BZHQPwQH+mfCOQzSK+e+G84csfdeXKFnRyqo36Q5uVuR/rAVtK8sXPQxvtUOhUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ybt8YHCc; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ybt8YHCc"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so32825a12.1
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 09:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750869828; x=1751474628; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PaRNo2JHkSBRLPeYg+2C1pcawC30oKvyipla7lol1jA=;
        b=Ybt8YHCcFwhugrXNhBjwX7DGqWcku6HC5jOyHgf8togCMKIz5oNgs/pwP8noh5lvV1
         0gu4umFqkkTGyimwLvTsQtOgs8YGt/cYtOHnPiM3DUtj5KffBetbXQTn6ggMiFlls3v8
         kU7LKubGnJ4H0hmIiSFC8lYl+2WOHZxnguLOccvefa7dgnRyDvsWHFL4RPW9GUOoRx8s
         uK8tZBnVKp0777byH32cSYQZINqVQLwFEkP4kV/LcIVHwbuAfRpCHLeChvzvReXT72ZL
         hAhzlTMxVBwJOz5WjLFa9T53eeYT6L2M6RUZAeXsmWvJtVw3kPyiFYw8LQslUNBNbN6R
         aF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750869828; x=1751474628;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PaRNo2JHkSBRLPeYg+2C1pcawC30oKvyipla7lol1jA=;
        b=ubb0lDtjkaGzhSUfeakRFcqQJuZexmG3WhAQco18I6PfHAblUfaiO1WZQp10+22OIH
         b7VAWTAJmwPdJiy7BJvlj13v/DTX7IfZBH33eSBzONvCLIPJyuTbMVIPFFM3Ocuf1Bty
         3qozxHqxCjcMtB+P7PZDMZ3T1AYX41o/VyPDD7irAWaLSmFV3tkEPjKlYxoio57xEBA3
         sqb/ygD72nkgU6Y985k46fjFOFlUIoiCoJTxlwy8JSDhD5xrJbWUcZLWoZmDOCStpTTY
         TXz+yd743Ukp6WFMv7hlh7+dp3ewtYdt7TZF6OSjDLYasfFWxJQu9u/DmpFFcpnEvHYQ
         uF3Q==
X-Gm-Message-State: AOJu0YzperzfFBjoey6d+PaxhX+kvca40xUU5QkjcgBd7cty0D0Crx6m
	4jC73hfjEHFmBVXonS8oU5p3h6gvlYf1yYjPOUV74rLpWYTUYvY2JXBn
X-Gm-Gg: ASbGncvTXPDDtra6b2IQ8HrT8l+hN/16qfBMLZOTVR8PdGXRUPdlw7Jjt+EdK67KKU6
	Tuihg2OjDVoKc4HAvd58P7bJSKqJSb94m1img647dK+S6vyj3dvjvY5FiAoTv6Zq1wFJwhYSFgY
	lNfAbMMocQPyfkZ2VqzgmdzH+qrN+turybYfCLnlJq4yeItFKnu6ITVCmbdQ6NactcNlO/X3+CY
	QWOrCMN0nkFUodsGLHAnc+CXSZ7ZeZYcGVBsvppQEwlTkACR0iXTUblQYNR/dqFRA1pki+wLXqb
	gN+dUDnTYU+8Y4TTAq14TNZ6VlPsijf4k7SqsuKI4dApAA==
X-Google-Smtp-Source: AGHT+IEYpWggk6x2qJbU8T9nB8YTzOv0HWKPTeHv8l7H5A22uq8d75ZcNWjvOHNHDBWCVgVu9Dp3nA==
X-Received: by 2002:a05:6402:1e93:b0:608:f493:871c with SMTP id 4fb4d7f45d1cf-60c4d2aa486mr3165681a12.14.1750869828449;
        Wed, 25 Jun 2025 09:43:48 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:b5f1:56b2:13d2:a5cf])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c2f1b8e14sm2661774a12.35.2025.06.25.09.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 09:43:47 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 25 Jun 2025 18:43:29 +0200
Subject: [PATCH 4/4] meson: add rule to run 'git clang-format'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-525-make-clang-format-more-robust-v1-4-67a49ecc2fd5@gmail.com>
References: <20250625-525-make-clang-format-more-robust-v1-0-67a49ecc2fd5@gmail.com>
In-Reply-To: <20250625-525-make-clang-format-more-robust-v1-0-67a49ecc2fd5@gmail.com>
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1257; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=anm90cE6oQbh86schdLhxQYtEI25TXQ0xD81rTbazmI=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhcJ0AA5/goPP5xRNbeNrCGpdOjfVU4HrdXN
 e+f5+uzGH6SPokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoXCdAAAoJED7VnySO
 Rox/7K4L/RPJiUw+GenAOfBjvLyy1WnLakppbAqrkwRJKDlb94lmOmkc3VVhcgEKT2h6X4NFoOJ
 hS9Fn6dTgOOJpYV8qZA0hFaiMuaLkK9JwZxSzEODkM0DFqc2zFn8SkDGV/DlagqRMsDxPSfh1oG
 sk3aFltaFUa7iePEaoF1EHEIAHBKabQQtmHSgNdvQlBCAbkOJ05lgZzq5vZ4mDrKJdDKbxvaNVa
 NvZMRLrtdbtGWuRDDnwfJNmOEQrhJAi3uYxqGJX3ZLnXJEr8DkRHPH5BJk9MTSestI/XtrbaBfq
 5LsvIQM8J1PwjmhGsgUrkmjQo4E5ufjoBPmqu12s+qPOkIXqkjqkAttzqpcHlSN3hMUlD52ocII
 1MjAOllk0BlwWvmUh9ABMsXHjhikDHA1UdI9mUJK5u27vsmsREeAa9O6M9ijj9EzXvuWemLklpS
 8ujOi5KXfhTwd29REtFxiGw0uwYiJDbTY7ItiTtwO1aTwm9ZUd9PYe8LcG6Xjcjt9aVM6hW8/M3
 4o=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The Makefile has a 'style' rule to run 'git clang-format'. While Meson
intrinsically supports a 'clang-format' target, which can be run when
using the ninja backend by running 'ninja clang-format', this runs the
formatting on all existing files.

Our Meson build doesn't yet support a way to run 'git clang-format',
which runs the formatter between the working directory and commit
provided. Add a new 'style' target to Meson to mimic the target in the
Makefile.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 meson.build | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/meson.build b/meson.build
index 7fea4a34d6..578db26df2 100644
--- a/meson.build
+++ b/meson.build
@@ -2144,6 +2144,18 @@ if headers_to_check.length() != 0 and compiler.get_argument_syntax() == 'gcc'
   alias_target('check-headers', hdr_check)
 endif
 
+clang_format = find_program('clang-format', required: false)
+if clang_format.found()
+  run_target('style',
+    command: [
+      'git', 'clang-format',
+      '--style', 'file',
+      '--diff',
+      '--extensions', 'c,h'
+    ]
+  )
+endif
+
 foreach key, value : {
   'DIFF': diff.full_path(),
   'GIT_SOURCE_DIR': meson.project_source_root(),

-- 
2.49.0

