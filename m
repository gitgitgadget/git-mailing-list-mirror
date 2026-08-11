Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1F541A57C
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437225; cv=none; b=LqCbYMFa8nBG3LjzlTaJNhK2A0QBHYp9O1AQiPDA9U9d4xT3x2m5ouW0CHINtI9pzIuGolRPzAuY0BbU55zHmkbCOdamjN0sM40E+Stz+wTsSFnn7xo6WzFaExAwRlLPu+CNX2OnAjrUMG+lt+uDrCZO3EkLgH58zEU5WMEqoHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437225; c=relaxed/simple;
	bh=OB8m1S++hzQVSWgp3lk0V41uYIq8r8PArUhAH2JL6Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idhHW724Y2RN8XrF6eyQUcewHjTF3yxXv+rzfuncPVeAWJcE1GKIFHfESqyIXJi0SheAvRih7yJg+039+HdgSlllHSYRMHfXPI4Q/BEOyWmdsATM+p2+ZipTrKF4t3HDKi9PTGJhMx/hMmuuRi8RArwhWjXv0SfWwCSvv+o5uBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+bWCpb/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+bWCpb/"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4980dc26022so28574415e9.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 01:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786437221; x=1787042021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N4yOZnBIZ/uid5dRvOWt8wxODXrlQsYEY4xKctkSO/4=;
        b=a+bWCpb/Mo8OIJI5dCSjP7KsDA/HAXDmjR6EXBeXdZxN/+SxRcqv1J8spv/TrYhYrg
         aPTkAhurkO9/2qMWl9DiABLabS1Z+de/Pe0Cw9itIiF62imC26z8JF6VbnIJ9z79VR4s
         yrbS1VoQzR+1fmbVTmJohUl5e0qJc/wRDWS13tZxHD6bYo1k9pmOzAgt9YsKv3Za2VHV
         8Se1vxl7KIhv5zz6uCCIqaeXKIGicrH7UP52tOZkcmDYYt1tsRIhlJkVHSdycFP2m8Kd
         ZDMyyPyNoyjltd9Z3hGcwvb/4CpkhO4wFN0ia8zXvwPl8XmnRAPK2ah4xC+19mdE0lHK
         knQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786437221; x=1787042021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N4yOZnBIZ/uid5dRvOWt8wxODXrlQsYEY4xKctkSO/4=;
        b=pR3kGgoJLPjqKG3nzutZaH9U7gDVnVoJUZqFN4KxtlqokP1OnTFtNr/c4fpL67U0qb
         WwWm1VNMBAh+ELtJ3LvRs74ZCoqzy6PFus2J6dzHkqmdHXkvWuy0FiNWtCUF+nhcfu08
         5MdByi+O6S4yeygpGlsZvJdLKT4y22czgx/VZVwuwgJ4JYg/861r+xeFmZ3dFc5IoEE7
         my77pKG9dGO6S8b4qrauEUAThybxPwV4fxisLIaBEVBboqlI1PZmPcYKgE4ljFZl5dAz
         3eft/HTVvaY/ZyIDOorI91/XIXWPsm3Su0+7qq8uWPhrQPzikW/bGqoVAM8136SzBhhZ
         Hyhg==
X-Gm-Message-State: AOJu0YxBnT3c6V+M0+EL2PWWpu9rIda96WoIixgEK+MPxB5OZHThEJce
	f6aJho/Nhz3qeP3HhHWIKUBR+3rj4HepevSn2RiEd1zB5pfGTCSNRE36DhWfzw==
X-Gm-Gg: AR+sD12HUPb9te7ZDN2VDjKCvnDiwc/QDh3+GySWmNfQF1h+Xen/nKUntEKwLU5hqqG
	272Lh2qc1eGv/OakuAB2FUtIUqJfInfgeq2Dzjxbi1P7C+U0B7G5QK6dXTHdJUJNKLHaNFWqoj7
	iIMUD7VF2trA8iCVVUHDFp5Rio/WxbgjcvubXRy1TIZyeQMLGO9S4utk91L51ZapKaMhfPOX+k2
	ysU/vPcNqS6au5ljqJ+vQPK0JmM4qN7A1+ourzHfWVgoi2VKeyU22hQ5A4IOOfboApFla5Dakhq
	6rDac9tV7AvG3fGetYLmyzJHXlqdff1iGq/GkYrzuiBKhaTTm0E9UVLFyFE5Iw1x/PqhItMbtjt
	xBWgRR+R+tOZvBoV2VqDfKbmw3R2WA7WC9uSE+vQlYR1ldiVJ3QmDV4T4lDxUjItK5k7tRgVUMY
	wTT7GVyjUbT2hiPp4DMQDzPB7lIY8Q8yBt5/t3i0p1X7oo5UjDqQ9YyluLaFvSAWfCoObd+a71n
	SdJtEomeh1B5lr3iXBF3LmovLBrYzGxr2xfB7nWeMo2QwIoYf3KK+rTCr1M9856nVQz40y3Dxp9
	/sw=
X-Received: by 2002:a05:600c:4683:b0:499:5210:c537 with SMTP id 5b1f17b1804b1-4997842c1efmr25278125e9.1.1786437221238;
        Tue, 11 Aug 2026 01:33:41 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([2001:863:5c3:4d0d:8be2:b2d7:3667:a5fd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997889c302sm18728075e9.1.2026.08.11.01.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 01:33:40 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 06/12] fast-import: factor out option_*() functions
Date: Tue, 11 Aug 2026 10:33:08 +0200
Message-ID: <20260811083314.2023489-7-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.530.gdb3615d990.dirty
In-Reply-To: <20260811083314.2023489-1-christian.couder@gmail.com>
References: <20260804100355.1299498-1-christian.couder@gmail.com>
 <20260811083314.2023489-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a following commit we are going to use the parse-options API to
start parsing options. Some options will have to be parsed using
OPT_CALLBACK as they process their arguments in special ways.

When the processing code is already factored out in an option_*()
function, like for `--date-format`, we can reuse that function.
Unfortunately for other options the processing code has not been
factored out yet.

Let's do it now and factor out the code that handles the following
options:

  - `--max-pack-size=<n>`
  - `--big-file-threshold=<n>`
  - `--signed-commits=<mode>`
  - `--signed-tags=<mode>`
  - `--quiet`

into new option_*() functions:

  - option_max_pack_size()
  - option_big_file_threshold()
  - option_signed_commits()
  - option_signed_tags()
  - option_quiet()

so that we can reuse these functions in following commits when the
parse-option API will be used.

Note that there are some behavior changes as we now die() with a
proper error message when git_parse_ulong() cannot parse the argument
from --max-pack-size or from --big-file-threshold. Previously we would
end up calling die("unknown option") instead.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 builtin/fast-import.c | 69 ++++++++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 21 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 9c8edd7c89..a6e3cc0033 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3751,25 +3751,55 @@ static void option_rewrite_submodules(const char *arg, struct string_list *list)
 	free(s);
 }
 
+static void option_max_pack_size(const char *arg)
+{
+	unsigned long v;
+
+	if (!git_parse_ulong(arg, &v))
+		die(_("--max-pack-size: argument must be a non-negative integer"));
+	if (v < 8192) {
+		warning(_("max-pack-size is now in bytes, assuming --max-pack-size=%lum"), v);
+		v *= 1024 * 1024;
+	} else if (v < 1024 * 1024) {
+		warning(_("minimum max-pack-size is 1 MiB"));
+		v = 1024 * 1024;
+	}
+	max_packsize = v;
+}
+
+static void option_big_file_threshold(const char *arg)
+{
+	unsigned long v;
+
+	if (!git_parse_ulong(arg, &v))
+		die(_("--big-file-threshold: argument must be a non-negative integer"));
+	repo_settings_set_big_file_threshold(the_repository, v);
+}
+
+static void option_signed_commits(const char *arg)
+{
+	if (parse_sign_mode(arg, &signed_commit_mode, &signed_commit_keyid))
+		usagef(_("unknown --signed-commits mode '%s'"), arg);
+}
+
+static void option_signed_tags(const char *arg)
+{
+	if (parse_sign_mode(arg, &signed_tag_mode, &signed_tag_keyid))
+		usagef(_("unknown --signed-tags mode '%s'"), arg);
+}
+
+static void option_quiet(void)
+{
+	show_stats = 0;
+	quiet = 1;
+}
+
 static int parse_one_option(const char *option)
 {
 	if (skip_prefix(option, "max-pack-size=", &option)) {
-		unsigned long v;
-		if (!git_parse_ulong(option, &v))
-			return 0;
-		if (v < 8192) {
-			warning(_("max-pack-size is now in bytes, assuming --max-pack-size=%lum"), v);
-			v *= 1024 * 1024;
-		} else if (v < 1024 * 1024) {
-			warning(_("minimum max-pack-size is 1 MiB"));
-			v = 1024 * 1024;
-		}
-		max_packsize = v;
+		option_max_pack_size(option);
 	} else if (skip_prefix(option, "big-file-threshold=", &option)) {
-		unsigned long v;
-		if (!git_parse_ulong(option, &v))
-			return 0;
-		repo_settings_set_big_file_threshold(the_repository, v);
+		option_big_file_threshold(option);
 	} else if (skip_prefix(option, "depth=", &option)) {
 		option_depth(option);
 	} else if (skip_prefix(option, "active-branches=", &option)) {
@@ -3777,14 +3807,11 @@ static int parse_one_option(const char *option)
 	} else if (skip_prefix(option, "export-pack-edges=", &option)) {
 		option_export_pack_edges(option);
 	} else if (skip_prefix(option, "signed-commits=", &option)) {
-		if (parse_sign_mode(option, &signed_commit_mode, &signed_commit_keyid))
-			usagef(_("unknown --signed-commits mode '%s'"), option);
+		option_signed_commits(option);
 	} else if (skip_prefix(option, "signed-tags=", &option)) {
-		if (parse_sign_mode(option, &signed_tag_mode, &signed_tag_keyid))
-			usagef(_("unknown --signed-tags mode '%s'"), option);
+		option_signed_tags(option);
 	} else if (!strcmp(option, "quiet")) {
-		show_stats = 0;
-		quiet = 1;
+		option_quiet();
 	} else if (!strcmp(option, "stats")) {
 		show_stats = 1;
 	} else if (!strcmp(option, "allow-unsafe-features")) {
-- 
2.55.0.530.gdb3615d990.dirty

