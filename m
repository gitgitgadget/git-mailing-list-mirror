Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37782CE7A8A
	for <git@archiver.kernel.org>; Sun, 24 Sep 2023 10:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjIXK6A (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Sep 2023 06:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjIXK5p (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2023 06:57:45 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F31107
        for <git@vger.kernel.org>; Sun, 24 Sep 2023 03:57:29 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32003aae100so4022668f8f.0
        for <git@vger.kernel.org>; Sun, 24 Sep 2023 03:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695553048; x=1696157848; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ij61tncpuQFcHSVAEn1qcC0pEaJRO+Oe2qBLFFjmYMo=;
        b=MMdyHYCaCadwr6klX5q0TsHBYbAWsUrfnhzszFypKbb15gY2vn4NjVHJ59o1z/70sy
         AindoINvGLqK7K013ZyslWwGuD++FbUZTjO54wo3uJcmmqnrEy95DcTBp9EwkoJXZyks
         YEYBuo2Jl7DlZhvdm4Q9/51XPR+t5q8RvDSXEllXN3jVq+CUBFRq7A+5lHFnuUBIXlHM
         QiEWNUm9+ASDX9ZlcCXGIXZga5C/ZUeXCs3C5CkwmiaMcCEj8AOaT9gLrhDzMlAvUTO0
         0ukV+RF/3NnH55/PhpwPsNTDIjoXyfZfKHz05YwvtnHQXYBVgvOspDUBA9bAfGdfo4GV
         oa+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695553048; x=1696157848;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ij61tncpuQFcHSVAEn1qcC0pEaJRO+Oe2qBLFFjmYMo=;
        b=S7Wf/vlUFxAOLGxgOuIvzFdgg/rAQaRrSIDgXTO5nrFsnXvjZQpu+Q4CbhCq7FFPE3
         AwMR3QDsrG8X3/KLyNZY7rgICOeDP67C9nGsQdnwkJQUSAv66sjEkXvmUGw6NtsuZIzQ
         OeMerFhJf+9LCxa+jOmB6fBX/y5h37sgzTp6abL1PezcoyJ+5Et2WCXJL8lD2Ax/lQQo
         cMXRpr+zD2LUGMV41QBzfNGdKDvIelKLdzForRIFbzxydcdLM8N/xalfUsT34XwT0KSA
         nBhp7nmnqUGSn6zZkBCPq+RQYaXCY2dElY+fn4Q+Mpr68KGdq/p5a+SyHTT3RPPy2GN9
         o/ug==
X-Gm-Message-State: AOJu0Yx9k/jiMRelPGZqogk/ZVshcj+xnzli795UTe0oBJYwSgQzA8/r
        MGaErXWknRCwMF4s4qoJdcRh1Fx0J90=
X-Google-Smtp-Source: AGHT+IGDAiisWEs8AK5jsehTltNP68/S0D0Bo5czIV+chTKvWz3u+H5GDGxS+lvkDxDxtpFwqU8RKg==
X-Received: by 2002:adf:e945:0:b0:31f:fcc8:5c53 with SMTP id m5-20020adfe945000000b0031ffcc85c53mr3130873wrn.26.1695553048038;
        Sun, 24 Sep 2023 03:57:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bo12-20020a056000068c00b00323287186b2sm9455wrb.29.2023.09.24.03.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 03:57:27 -0700 (PDT)
Message-ID: <7cfd7b244ea92db333848577f130956854db1b35.1695553043.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1589.v2.git.1695553041.gitgitgadget@gmail.com>
References: <pull.1589.git.1695392027.gitgitgadget@gmail.com>
        <pull.1589.v2.git.1695553041.gitgitgadget@gmail.com>
From:   "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 24 Sep 2023 10:57:20 +0000
Subject: [PATCH v2 3/4] doc: update links for andre-simon.de
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Josh Soref <jsoref@gmail.com>, Josh Soref <jsoref@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Josh Soref <jsoref@gmail.com>

Beyond the fact that it's somewhat traditional to respect sites'
self-identification, it's helpful for links to point to the things
that people expect them to reference. Here that means linking to
specific pages instead of a domain.

Signed-off-by: Josh Soref <jsoref@gmail.com>
---
 Documentation/gitweb.conf.txt | 2 +-
 gitweb/INSTALL                | 2 +-
 gitweb/gitweb.perl            | 4 ++--
 gitweb/static/gitweb.css      | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index 1edabdfef36..417289dcd17 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -242,7 +242,7 @@ $mimetypes_file::
 
 $highlight_bin::
 	Path to the highlight executable to use (it must be the one from
-	http://www.andre-simon.de[] due to assumptions about parameters and output).
+	http://andre-simon.de/zip/download.php[] due to assumptions about parameters and output).
 	By default set to 'highlight'; set it to full path to highlight
 	executable if it is not installed on your web server's PATH.
 	Note that 'highlight' feature must be set for gitweb to actually
diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index a58e6b3c44b..0f8bc39ad84 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -203,7 +203,7 @@ You can specify the following configuration variables when building GIT:
    created.  [Default: /etc/gitweb.conf]
  * HIGHLIGHT_BIN
    Path to the highlight executable to use (must be the one from
-   http://www.andre-simon.de due to assumptions about parameters and output).
+   http://andre-simon.de/zip/download.php due to assumptions about parameters and output).
    Useful if highlight is not installed on your webserver's PATH.
    [Default: highlight]
 
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d23468690ed..b6659410ef1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -197,7 +197,7 @@ our @diff_opts = ('-M'); # taken from git_commit
 our $prevent_xss = 0;
 
 # Path to the highlight executable to use (must be the one from
-# http://www.andre-simon.de due to assumptions about parameters and output).
+# http://andre-simon.de/zip/download.php due to assumptions about parameters and output).
 # Useful if highlight is not installed on your webserver's PATH.
 # [Default: highlight]
 our $highlight_bin = "++HIGHLIGHT_BIN++";
@@ -269,7 +269,7 @@ our %avatar_size = (
 # Leave it undefined (or set to 'undef') to turn off load checking.
 our $maxload = 300;
 
-# configuration for 'highlight' (http://www.andre-simon.de/)
+# configuration for 'highlight' (http://andre-simon.de/doku/highlight/en/highlight.php)
 # match by basename
 our %highlight_basename = (
 	#'Program' => 'py',
diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
index 32126010326..48d2e510154 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -667,7 +667,7 @@ div.remote {
 }
 
 
-/* Style definition generated by highlight 2.4.5, http://www.andre-simon.de/ */
+/* Style definition generated by highlight 2.4.5, http://andre-simon.de/doku/highlight/en/highlight.php */
 
 /* Highlighting theme definition: */
 
-- 
gitgitgadget

