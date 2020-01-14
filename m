Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE71C33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 19:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78B424670
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 19:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBLgZCWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgANT0O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:26:14 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43598 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbgANT0I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 14:26:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id d16so13373211wre.10
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 11:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sjUEYqSl92yptU6bjgD39zWnbcFUoSQLxTHejdxF+Sg=;
        b=gBLgZCWnPF93piJAQssd2LVS4+JfMFuGvbUwXIXsY1OXR9TNIz9Dtl0Y2KtIH5AH/b
         WMXMhxroblJ/SxVFJIyG4hdTrDeqLmm8YLWqf9vdiihJRp513pppt7x6Tbtc30VNTxRL
         1E0dmTm9BfK2XqslJnP5HOrnFBpVRAhk+8IoWTw5N5BXgZZbAwn6TKQYMmArYWsRwrMj
         hnV5Rx/VVTF4vQEvn9DzZOM/ENymQkcwNpDA/CfN6Kvt+M/hFoNhwVn3xqXjYtKTPqM1
         LiCcXjSiQX/NOKROBGGzAip9IOJn8W8gq/7PEtHJxTs8aC6BBv0edle726ka7ybspz6V
         ASuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sjUEYqSl92yptU6bjgD39zWnbcFUoSQLxTHejdxF+Sg=;
        b=JzFZzzoIb51arHtx5xbaEVgkui82pMP/cZuiJ702Vh170OBvoMzKHEcx8EGdWYTIoX
         L/eOqNaY4NwnNVzGDWQhi0n53B/EEJECz/xCsV779vNusn9kzP9SNMafc/qoCaxHuY3H
         NG4NdTomJJzGd5TG3v3SuqcEZaqi21D6lRQ7n2o8cwfAz/Ff9xRNvMLPIT23sAbw1PU4
         pA97vbp+jYvuP2ptHvFZ/rF/yhFi0OHuGazEGc8TvEq0Xt0XU7gJiee53rfnYcKPfY7L
         jKDxPXaGnQxPhgGb26YiUptQ2so76sPJS6Go9fbhhJmBfqe19/GugmBK46IKSLLGnn6k
         3AJg==
X-Gm-Message-State: APjAAAV84QeDl65VIhV+XD8YSCZgw1YvrzHY9YF7miRMaAbSNY8gs7Jt
        fcNepZHmQ+Er0EDQZvY6kEBJ/Dzb
X-Google-Smtp-Source: APXvYqyz7g8Zld1JLnBZxnFCzScMTSs9AonqGmC/jasYscUbyPB5oE8U8nqWwGtgeBGF1ZxwHRes5w==
X-Received: by 2002:a5d:53c1:: with SMTP id a1mr26004902wrw.373.1579029966501;
        Tue, 14 Jan 2020 11:26:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q68sm21380360wme.14.2020.01.14.11.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 11:26:06 -0800 (PST)
Message-Id: <3ef8e021a586bd986e5a2a7e1bc956daf2d874d2.1579029963.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.git.1579029962.gitgitgadget@gmail.com>
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jan 2020 19:25:57 +0000
Subject: [PATCH 3/8] clone: fix --sparse option with URLs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The --sparse option was added to the clone builtin in d89f09c (clone:
add --sparse mode, 2019-11-21) and was tested with a local path clone
in t1091-sparse-checkout-builtin.sh. However, due to a difference in
how local paths are handled versus URLs, this mechanism does not work
with URLs.

Modify the test to use a "file://" URL, which would output this error
before the code change:

  Cloning into 'clone'...
  fatal: cannot change to 'file://.../repo': No such file or directory
  error: failed to initialize sparse-checkout

These errors are due to using a "-C <path>" option to call 'git -C
<path> sparse-checkout init' but the URL is being given instead of
the target directory.

Update that target directory to evaluate this correctly. I have also
manually tested that https:// URLs are handled correctly as well.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/clone.c                    | 2 +-
 t/t1091-sparse-checkout-builtin.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 4348d962c9..2caefc44fb 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1130,7 +1130,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_required_reference.nr || option_optional_reference.nr)
 		setup_reference();
 
-	if (option_sparse_checkout && git_sparse_checkout_init(repo))
+	if (option_sparse_checkout && git_sparse_checkout_init(dir))
 		return 1;
 
 	remote = remote_get(option_origin);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 37365dc668..58d9c69163 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -90,7 +90,7 @@ test_expect_success 'init with existing sparse-checkout' '
 '
 
 test_expect_success 'clone --sparse' '
-	git clone --sparse repo clone &&
+	git clone --sparse "file://$(pwd)/repo" clone &&
 	git -C clone sparse-checkout list >actual &&
 	cat >expect <<-\EOF &&
 	/*
-- 
gitgitgadget

