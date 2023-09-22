Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C5BE6FE32
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 14:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbjIVOOJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 10:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbjIVOOE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 10:14:04 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D1D136
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 07:13:54 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4051fea48a8so24979375e9.2
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 07:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695392033; x=1695996833; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIeqJYcftDJXJCm3Hs6y7XALb5q4bJAnfVRfJNsRQBg=;
        b=kXexV+5G41ov4nFkUsr4Rvf7ePUVgz47+wJpikn5BGV/CzdZBLwps3VaNUL4Nc4Q83
         0GIz/q6/iJxle1TzKBv3Z3EyTJhdInBb2t9fT1lgyGeAjUf+YycUdNmnBSUXOMjRXfnr
         ec6q+hkKAQyiGyPO7laJkFMU4xdQuA5Y3YMBCwDpRrzADzcEdM+kRFzDohig6kNxdNfo
         PZsr7qzy9Jp8YFswCfgPIeAhXuKdImEmgdqsV9SkfnT99SAjo2KZD0XwNW+dknuXa6JG
         bWWqcLV5/eQGcDsy5j/JNCxjuvvvRpkK2JllLH3WJtrk7NFxEKAGHxOiWgoqjgj/8+6G
         fF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695392033; x=1695996833;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIeqJYcftDJXJCm3Hs6y7XALb5q4bJAnfVRfJNsRQBg=;
        b=quK+Q66DZvuGzTi51k4lFv5xaQhlAxrGj24lISBZ8KPsl5pyhmiT6RFWUhSk6kWC61
         5Qndh9dzpCBXmxg2+CcBwUs2mJqiiYJpUIKoGveRgpvs0cKjfSKN3FOsgpkHvUlZ1it9
         cjsq8TZOF/mueuOOx/YfzIwAF3r2/ZejBTWYHrEVt1L9vXT3f2frB8HTGYMv3r//wVyd
         zKoykBZ33d/bUz2EYWUQyWi4ZQvpNyRRsOHf62cdSbumDKFRxogtNhetdd8zSQhgKgLT
         kqniVXiZS6rYgvITcZ9ZuzmkCE/QPGY/vbPbpRkSHy1SxQ8Mmc2xGlPa3YQlrD+v34nn
         5Yrg==
X-Gm-Message-State: AOJu0Yyv9e1dRYMCb0obje6OHMjFu3T14GjYRgFyXB7PyTq3rnL1Zugl
        k5BD/QH1FIOs7t0xWsHzcB0kN4OJyzM=
X-Google-Smtp-Source: AGHT+IGBGn4caZie/7/Z+EvaW+vVZEySgmnf4cfhzddZI8HoWm7OQWnNlmVTCgc1ahoJwY3Kn92M2Q==
X-Received: by 2002:a05:600c:acd:b0:401:b2c7:34a8 with SMTP id c13-20020a05600c0acd00b00401b2c734a8mr7428447wmr.7.1695392032732;
        Fri, 22 Sep 2023 07:13:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y2-20020a7bcd82000000b00403bbe69629sm4790655wmj.31.2023.09.22.07.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 07:13:52 -0700 (PDT)
Message-ID: <100ea749b5bab7760e19b86711626e3cc06fba87.1695392028.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1589.git.1695392027.gitgitgadget@gmail.com>
References: <pull.1589.git.1695392027.gitgitgadget@gmail.com>
From:   "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Sep 2023 14:13:46 +0000
Subject: [PATCH 3/4] doc: update links for andre-simon.de
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

