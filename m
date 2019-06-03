Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2052B1F462
	for <e@80x24.org>; Mon,  3 Jun 2019 22:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfFCWsc (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 18:48:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34965 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfFCWsc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 18:48:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id m3so13785163wrv.2
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 15:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RoyZ979CTglaoUVw3VZMsO7uWRYx6xdzhu8yHDov1fU=;
        b=s+gtHAlL8bySvVzbgMZacv7HPg+JuRtFeuSPlwm+aKXVlQmDzCLW1p0K8xdwz6vTsH
         wG+jWCB6IQjm+IR1F7roBopD2JWduhd45upV9fIaf9z+7wJMGM1obBcWxPhX3XB8DyPC
         5mEE4N+wEE/dXImWhsZ0XiN4iwHCIr/9ukHINPeKS729DdNSBkxmLkX5X1NQ/cv7iObR
         vqlkdE7KznKqzNal9wEGacBWQ11DwCNVDAsHVowqFkhxEXP4EZ95oTiDXi1H3W0FXVaR
         AWv7hxZvQV2WralRZe4dLBhtpAYe9ZueBpNr/fA/CCGUDshZrex0+djSYwWa0TDC1LOj
         VvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RoyZ979CTglaoUVw3VZMsO7uWRYx6xdzhu8yHDov1fU=;
        b=EKTCPzkqM0nrwk3DEy+leGA6cFv16eEMgIzRQTeRTafPGqKqcjfZp+yYkIyUnScV4I
         SBM3n9mSLEbsvB1GsGbuRipwb/oZkX4Szfsu6qlRMkf35M9+8BSncH//YshpqUlqNpBO
         /HRgs5LJIHMr+NrsLasRK7ulVTk4YZBW9q3gWD38/ERK8jXR7QrRdoxNOrHbe+k8gL6W
         eCjr8eXs8ZUN5AwQkI7QC+SDb2N/+zAUOROEgDmfW20mGvkomEibVKZit/7Lg4OQMHOU
         c9svKZSRsS9qApgLr0yJ0+SdKQ1hK/Q3uB9+dM1qAT8HuFtJDL9gP9lsRWYXAJZ05S2B
         +AGA==
X-Gm-Message-State: APjAAAVzz2xymargfM6n3U4ZKmg0dXLZMAXKmEHfXOp8y800KXNyCcX6
        dy56XqEj3Ax0SGVk8lM1nC7I2upd
X-Google-Smtp-Source: APXvYqwCt8D+zCaFv2H6GhsBe/4QZQaWIxyLpO/77LxH9etpfUfMCkSsozvM9O7vFRidtITXHhk2Sg==
X-Received: by 2002:a5d:63cb:: with SMTP id c11mr17887689wrw.65.1559602109951;
        Mon, 03 Jun 2019 15:48:29 -0700 (PDT)
Received: from gmail.com (79.108.96.12.dyn.user.ono.com. [79.108.96.12])
        by smtp.gmail.com with ESMTPSA id t63sm3758788wmt.6.2019.06.03.15.48.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 15:48:29 -0700 (PDT)
Date:   Tue, 4 Jun 2019 00:48:14 +0200
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Git mailing list <git@vger.kernel.org>
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stephan Beyer <s-beyer@gmx.net>, Taylor Blau <me@ttaylorr.com>,
        Patryk Obara <patryk.obara@gmail.com>
Subject: [PATCH] clang-format: use git grep to generate the ForEachMacros list
Message-ID: <20190603224814.GA15851@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ForEachMacros list can reasonably be generated grepping
the C source code for macros with 'for_each' in their name.

Taken almost verbatim from the .clang-format file in the Linux kernel.

Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
We wrote this for the Linux kernel a while ago, and it has been working
fine there, so I thought it would be nice to use the same approach here.
There are fancier ways of approaching this, of course.

 .clang-format | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/.clang-format b/.clang-format
index 41d4cd23fd..c592dda681 100644
--- a/.clang-format
+++ b/.clang-format
@@ -148,8 +148,21 @@ SpacesInSquareBrackets: false
 Cpp11BracedListStyle: false
 
 # A list of macros that should be interpreted as foreach loops instead of as
-# function calls.
-ForEachMacros: ['for_each_string_list_item', 'for_each_wanted_builtin', 'for_each_builtin', 'for_each_ut']
+# function calls. Taken from:
+#   git grep -h '^#define [^[:space:]]*for_each[^[:space:]]*(' \
+#   | sed "s,^#define \([^[:space:]]*for_each[^[:space:]]*\)(.*$,  - '\1'," \
+#   | sort | uniq
+ForEachMacros:
+  - 'for_each_abbrev'
+  - 'for_each_builtin'
+  - 'for_each_string_list_item'
+  - 'for_each_ut'
+  - 'for_each_wanted_builtin'
+  - 'list_for_each'
+  - 'list_for_each_dir'
+  - 'list_for_each_prev'
+  - 'list_for_each_prev_safe'
+  - 'list_for_each_safe'
 
 # The maximum number of consecutive empty lines to keep.
 MaxEmptyLinesToKeep: 1
-- 
2.17.1

