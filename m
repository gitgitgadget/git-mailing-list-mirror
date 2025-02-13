Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD1F24501F
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 18:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739471864; cv=none; b=LRoTSIYcRQ36NaKl4cVi4oUofyqQE4VJ/0ts+g/Vzvs1rz2CVloRZsn3HUi9JB5LkQYvkuBSTXdB66ZQuI966IWbxJmjtyY5U+87nW0VeAGH0iAfcqbG3mF3XNtk02TOROwBLLvMkVrlkrlwSIL8ZlDRj28nD2hxLAbspTcdOdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739471864; c=relaxed/simple;
	bh=d/Wrk1rTkKzS4A7YwuNULV/p9g4eDZub6n9alCpw5sM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Nf87CC0W/8+VP9ok1GiwZnnp+z+VgFSO7AHyBil19blRt8QMj/c5BcukCy6RmGbkQaicfowOTf9eF56d+47sLt7nIgvEmep/GDJ83IGeur7gm/5Qse+6V8rycFUqSixYQFy7bv6KWT8xRPVabshUBuOZfsrdwNv5+bxZ9twWkac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpT34h/v; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpT34h/v"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4395a917f33so13559475e9.1
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 10:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739471861; x=1740076661; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gUnb8PvkUm852wzGwRUf+B8/SGgILadrY5710w09Fw=;
        b=fpT34h/vkn6Xrib6y9U3tOdFSYcFWSoTVrRNYkzmHVB84IFPpv1Ugzeo0eSoVvEPm9
         j00vv21UoqgJSwaaP3HNeIYtaVNc3+ZShzaUePSyQrVIFHokyT77m0RW3QWFFbalY6gU
         zmVZrKAcMjl92WPv6IOb9QRGUZNcn4IIB36CCDsobuC7P7QAOlTfEmNJxSQYjE40fv02
         c2zrDCegjesz3R0qrvfUc8aguhlF3qTZVWINNCBNzd1tg6GYaOLe/fo0FgDYwXl8KC5x
         XsZU+qeXdygOvRCnLAxK4sBgVCLTgqLlz/MviPhVwqahOnKCqlc3Mg3+jYgDnDhtFlQC
         2wtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739471861; x=1740076661;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gUnb8PvkUm852wzGwRUf+B8/SGgILadrY5710w09Fw=;
        b=sOri+4uqGJIknnaCJ9nuUFVCxWiD5xSsNAwR+QY74lLCnyAeJDASl2ti5pIXi6PLZu
         xO2+7cG/14PoGqdXFpDOOWZDwDT7jVKezml8i+e+p6ZBDXnb1Mqd+U0UPxbeGZEPEkDx
         7sTfBOJSPvsVBpf8fPiNUmysU95+0PtqbEtmIewrG3Q0jF0GjLaNY00+xwnTNIqNvDgZ
         pHeLFWUs9dqvZ44arcQW32kO4BhO+c9Pn88aEeC5Cso048y0EZLjdUA5xRTeT5/9tCZ4
         xv0QnXt2mVZbye9n7aLnYS7VgyBM3CSMyaJ/GA4cRnfln6mV/vp2fmae6pAherqOfVOT
         kRjQ==
X-Gm-Message-State: AOJu0YxHUvnwVsN6/M1/S6yItKtg+eBIZBiF4oVeqPeg0LK0+yD7mQLz
	lWEpUYkn75oydPDDVDHkLwttyKvgg7dH+KVD6CAgetf6g/Z2h5Zll0o6Rw==
X-Gm-Gg: ASbGncvjduAlS3EkJFaisdy8KTqjqNr/CGkKs4Zj+qBfpk8qyRWtsSxJP2IrphPZCz0
	Fk7k22EzSeFi2ABaqiDQlWwl7vWLuAuGTttsiFTSYars95on51vOnixc9It+SL5ZPiWHOOmdIHu
	hrlmPs9HwMb6ESCqAQWftezBsESvdNzDZhNry6IAcOWvRnL7pShBMcUU370Pw1mM+thJjnQG2oE
	uyri/53MKlpT6RqVxDRQWEdmQSvuKawGK5SjGugKAv13XBngKWJg4R1C8LyT2cbUMWn3AUYwD6T
	XRQOc1ApxyG86P1e
X-Google-Smtp-Source: AGHT+IG9lIREzBg3SClTCgJ0WDRYOUg1rqjkt1qMWGFlVlfU/atsU6GVVj36fUQOIdYpMOcOpaHgZQ==
X-Received: by 2002:a05:600c:1906:b0:438:e2ce:92d2 with SMTP id 5b1f17b1804b1-43960e819d2mr43776365e9.4.1739471860842;
        Thu, 13 Feb 2025 10:37:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04ee48sm56236425e9.3.2025.02.13.10.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 10:37:40 -0800 (PST)
Message-Id: <7ac8aa63af94e94c30e0429d0e088f6e0f8e5cb4.1739471859.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1859.git.1739471859.gitgitgadget@gmail.com>
References: <pull.1859.git.1739471859.gitgitgadget@gmail.com>
From: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Feb 2025 18:37:38 +0000
Subject: [PATCH 1/2] meson: wire up credential-wincred
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
Cc: Patrick Steinhardt <ps@pks.im>,
    M Hickford <mirth.hickford@gmail.com>,
    M Hickford <mirth.hickford@gmail.com>

From: M Hickford <mirth.hickford@gmail.com>

Fix an error when compiling with MSVC.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
 contrib/credential/meson.build                      | 3 +++
 contrib/credential/wincred/git-credential-wincred.c | 2 ++
 contrib/credential/wincred/meson.build              | 1 +
 contrib/meson.build                                 | 1 +
 meson_options.txt                                   | 2 ++
 5 files changed, 9 insertions(+)
 create mode 100644 contrib/credential/meson.build
 create mode 100644 contrib/credential/wincred/meson.build

diff --git a/contrib/credential/meson.build b/contrib/credential/meson.build
new file mode 100644
index 00000000000..4017ae3fa88
--- /dev/null
+++ b/contrib/credential/meson.build
@@ -0,0 +1,3 @@
+if get_option('credential_wincred')
+  subdir('wincred')
+endif
diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index 4be0d58cd89..04145b51183 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -12,7 +12,9 @@
 
 #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
 
+#ifndef _MSC_VER
 __attribute__((format (printf, 1, 2)))
+#endif
 static void die(const char *err, ...)
 {
 	char msg[4096];
diff --git a/contrib/credential/wincred/meson.build b/contrib/credential/wincred/meson.build
new file mode 100644
index 00000000000..8c59d47174e
--- /dev/null
+++ b/contrib/credential/wincred/meson.build
@@ -0,0 +1 @@
+executable('git-credential-wincred', 'git-credential-wincred.c')
diff --git a/contrib/meson.build b/contrib/meson.build
index d74b64a5181..c414c98d5a7 100644
--- a/contrib/meson.build
+++ b/contrib/meson.build
@@ -1,3 +1,4 @@
 foreach feature : get_option('contrib')
   subdir(feature)
 endforeach
+subdir('credential')
diff --git a/meson_options.txt b/meson_options.txt
index 5c12e9055e6..7554528482a 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -29,6 +29,8 @@ option('version', type: 'string', value: '',
 # Features supported by Git.
 option('contrib', type: 'array', value: [ 'completion' ], choices: [ 'completion', 'subtree' ],
   description: 'Contributed features to include.')
+option('credential_wincred', type: 'boolean', value: false,
+  description: 'Build helper git-credential-wincred. Requires Windows SDK.')
 option('curl', type: 'feature', value: 'enabled',
   description: 'Build helpers used to access remotes with the HTTP transport.')
 option('expat', type: 'feature', value: 'enabled',
-- 
gitgitgadget

