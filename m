Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CB1C4BA24
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 13:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C651246A0
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 13:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVQwr5/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgB0NXS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:23:18 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:33324 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729088AbgB0NXR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 08:23:17 -0500
Received: by mail-ed1-f43.google.com with SMTP id r21so3287079edq.0
        for <git@vger.kernel.org>; Thu, 27 Feb 2020 05:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vPbRMXvb5pHxN3LVgTi0ElL+wvD6SM4VlDDGkOwchTM=;
        b=TVQwr5/PsGcHTRWVn9dICp71qoT+TRtsTZbO5th1uzlNFSO1khnD3bo0c8yihpYUyH
         pIDA3217lNyHGZPENjGcIhlXBDRO1Eoz5xVu7sQ+p/WBYSubmK9WQ9/eMKGvkyC4VCTG
         yaUBiMKOWpCc1YaNGKMbveB5CTYZiBd5SBJG0Tx7ed/vWI9hiSTTM2/BM45SULRUhS5K
         Xw5L0+UugJ/eC3K3E68Z0eTCcC7RZz44iijkJVXuWrhv0L7H+LsawypQJ+aNGamUKkxu
         QHe3DzWwUv3igHBiHARTbqNCGIyJn0Wr2ebvbDIUOJZeQqkMYvIOFAXZ55ea7YQDneLK
         ajFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vPbRMXvb5pHxN3LVgTi0ElL+wvD6SM4VlDDGkOwchTM=;
        b=NMqNUNCbTRlPXOgyxhGTMGwrLwM/sH//8kd3BkATtLwqiK82ZptvBqsCcx+FhoOLi1
         kf4u8a2UQqgZg/PtDYd1ZUI+WYLOpwc0u4PhYQ3nDC1R5zgEc5lPUfIQMlSZGFFLOxg+
         hzv14SBJ+zpk7x3DZ/30ibdUCVBUZspZle43NyGQqlWTydT5a4XtavCBaTSQVxO9hFw/
         WY84EdnXkmFMxsNQMhPnkXhovlUhttnv1Y43fsb9UA85qbEHRozEZrSsoxhwkAStGuMC
         CVZNn0Jfl0PT/g/qy+CY5FORy9gehg3hteTYGsOY+kayDCFvdsigX4PdygmRMFcfMUGN
         /yYw==
X-Gm-Message-State: APjAAAUZcw7Gbvi8ViBdvlAhYdYlYLYsEGpK5Ey7uzAoZkiFct9Ualph
        wjsKb+Pr58c1XIXqya348mXe+G2h
X-Google-Smtp-Source: APXvYqxHZuK5cI7ewggl9WOsXBYcn03/cn5xS/F2hPSgQquvdKG6uIL+sNsLuzmxnTZrsU0zAi9rsw==
X-Received: by 2002:a17:906:7c47:: with SMTP id g7mr4178060ejp.281.1582809794896;
        Thu, 27 Feb 2020 05:23:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fx9sm262339ejb.5.2020.02.27.05.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 05:23:14 -0800 (PST)
Message-Id: <pull.714.v2.git.git.1582809793.gitgitgadget@gmail.com>
In-Reply-To: <pull.714.git.git.1582747775.gitgitgadget@gmail.com>
References: <pull.714.git.git.1582747775.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Feb 2020 13:23:10 +0000
Subject: [PATCH v2 0/3] ci: upgrade to the latest Azure Pipelines agent pools
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ed Maste <emaste@freebsd.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At least the Windows agents we use will go away on March 23rd, 2020
[https://devblogs.microsoft.com/devops/removing-older-images-in-azure-pipelines-hosted-pools/]
, in favor of newer, faster, better ones. We might just as well use the
latter already long before the cut-off date.

While at it, let's also update to a newer macOS pool. This necessitates two
distinct fixes, though:

 * Our ci/ scripts were ill-prepared to deal with System Integrity
   Protection [https://support.apple.com/en-us/HT204899]. This resulted in
   the p4d -V call seemingly "hanging" (Narrator's voice: it did not "hang",
   it actually opened a GUI dialog to ask the user whether it was okay to
   execute this quarantined executable).
   
   
 * Apparently nobody ever bothered running the Apache2-based tests (t5616,
   t5702 and t5703, probably more) on macOS. I say that because they don't
   work, over-relying on GNU-specific behavior of sed. I rewrote those sed 
   calls to use Perl instead.
   
   

Changes since v1:

 * Avoid blaming BSD for what is (at least nowadays) squarely a macOS issue.
 * Targeting maint

Johannes Schindelin (3):
  t/lib-httpd: avoid using macOS' sed
  ci: prevent `perforce` from being quarantined
  Azure Pipeline: switch to the latest agent pools

 azure-pipelines.yml                | 37 +++++++++++++++++++----------
 ci/install-dependencies.sh         |  4 ++--
 t/lib-httpd.sh                     |  2 +-
 t/lib-httpd/apache.conf            |  6 ++---
 t/lib-httpd/apply-one-time-perl.sh | 27 +++++++++++++++++++++
 t/lib-httpd/apply-one-time-sed.sh  | 24 -------------------
 t/t5537-fetch-shallow.sh           | 10 ++++----
 t/t5616-partial-clone.sh           | 38 +++++++++++++++++-------------
 t/t5702-protocol-v2.sh             | 12 +++++-----
 t/t5703-upload-pack-ref-in-want.sh |  6 ++---
 10 files changed, 93 insertions(+), 73 deletions(-)
 create mode 100644 t/lib-httpd/apply-one-time-perl.sh
 delete mode 100644 t/lib-httpd/apply-one-time-sed.sh


base-commit: c522f061d551c9bb8684a7c3859b2ece4499b56b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-714%2Fdscho%2Fazure-pipelines-latest-pools-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-714/dscho/azure-pipelines-latest-pools-v2
Pull-Request: https://github.com/git/git/pull/714

Range-diff vs v1:

 1:  9900cacbfef ! 1:  af28d115ded t/lib-httpd: avoid using BSD's sed
     @@ -1,8 +1,8 @@
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -    t/lib-httpd: avoid using BSD's sed
     +    t/lib-httpd: avoid using macOS' sed
      
     -    Among other differences relative to GNU sed, BSD sed always ends its
     +    Among other differences relative to GNU sed, macOS' sed always ends its
          output with a trailing newline, even if the input did not have such a
          trailing newline.
      
     @@ -14,7 +14,7 @@
          The reason is that we use `sed` in those tests to filter the response of
          the web server. Apart from the fact that we use GNU constructs (such as
          using a space after the `c` command instead of a backslash and a
     -    newline), we have another problem: BSD sed LF-only newlines while
     +    newline), we have another problem: macOS' sed LF-only newlines while
          webservers are supposed to use CR/LF ones.
      
          Even worse, t5616 uses `sed` to replace a binary part of the response
     @@ -25,11 +25,11 @@
          hex-encode it, then calls on `sed` to prefix every hex digit pair with a
          `\x` in order to construct the text that the `c` statement of the `sed`
          invocation is supposed to insert. So we call Perl and sed to construct a
     -    sed statement. The final nail in the coffin is that BSD sed does not
     +    sed statement. The final nail in the coffin is that macOS' sed does not
          even interpret those `\x<hex>` constructs.
      
          Let's just replace all of that by Perl snippets. With Perl, at least, we
     -    do not have to deal with GNU vs BSD semantics, we do not have to worry
     +    do not have to deal with GNU vs macOS semantics, we do not have to worry
          about unwanted trailing newlines, and we do not have to spawn commands
          to construct arguments for other commands to be spawned (i.e. we can
          avoid a whole lot of shell scripting complexity).
     @@ -159,7 +159,7 @@
       	# Craft a situation in which the server sends back an unshallow request
       	# with an empty packfile. This is done by refetching with a shorter
      @@
     - 	printf "$(test_oid sed)" \
     + 	printf "s/0034shallow %s/0036unshallow %s/" \
       	       "$(git -C "$REPO" rev-parse HEAD)" \
       	       "$(git -C "$REPO" rev-parse HEAD^)" \
      -	       >"$HTTPD_ROOT_PATH/one-time-sed" &&
 2:  8739f8bac0f = 2:  5e5fcf3b76b ci: prevent `perforce` from being quarantined
 3:  f141c295fd8 = 3:  6d2f8e7e70e Azure Pipeline: switch to the latest agent pools

-- 
gitgitgadget
