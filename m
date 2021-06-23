Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5F6C48BC2
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 18:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3E7860E0B
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 18:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhFWSlf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 14:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhFWSlf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 14:41:35 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5B0C061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 11:39:16 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id d9so4733877ioo.2
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 11:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uA6CXbMU3sG/d5XI1it0N6ZlGYbf8eMQMpj6xY+pvYI=;
        b=RmM5AMyxxHQ6YmJl/A/JAYOrj/hse8QWfHQFQc6IJeOaPEf7mAwS48cNLS890AvNdj
         si9O+yEiwdEwbR70zNjuXX2FQTRJC19CkbWFKHdFqkMRtB5M+s9qXZYxI/YbIyrYaefD
         l7jNN1RbUB9db2vE9OP9Ats+Pa3IDsRa0MlKOWpCjT2+jbfsj8kYzIw3xxirCS8F5Ywf
         BMOoL7R6AM887S5dwlfVtpcxF1QrGVFSya7ia30RikV6kB/McoAAbWuFTOZW670vAUyL
         paCOfBwhklkEZ1exnU1ZaubbEA1gtchkNNNfFiCdDz3UCc2ANouaf2qFlmpoXFig4BVs
         vu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uA6CXbMU3sG/d5XI1it0N6ZlGYbf8eMQMpj6xY+pvYI=;
        b=Q+n+lzlS+OSxmCy7HF8JlbduxGDrwzD4fbvKmX0HA2f9kfCj7pUbPV3zy4LJKgmaCW
         WLrWscZ/RG2XjUYXJbJf7ql34LnR9iyU5Kl8V9bULF4goXcpzok+xoTRVGkXbNtryf0T
         YUL43YL1etahtxy5jrffAACEMZC8+0cxrmgAIcsBZlc5WxThkp4zulqH2UN3AwGYogxx
         DofeY5c21Dyuuiztg1etg0DveGU3B8SGSIfCPs51YFnBu7N0kbXQGaQf3sLPInUNlfJc
         UBcm7KkI8ezdrfQM4HF42hHBusoUjrZODdEMpVTCHJ+zYHZGo4x0ku5uJnpSV0IHOlf/
         BikA==
X-Gm-Message-State: AOAM530v82VEEJkRw6vhSVqMftSuTEzBWj9K80dKJNxHdCPVKJo2JxPl
        K/LStDzy5MllRKnNl6e7cYcZzZ0AGTahYNqH
X-Google-Smtp-Source: ABdhPJw0m4jvrN7JMBWZNpdSt6tNvFfDZim5YjFfTPwueffkdDej7hKUg14EOH6ZrBt39iZG6Bl1aw==
X-Received: by 2002:a6b:720f:: with SMTP id n15mr712816ioc.209.1624473556092;
        Wed, 23 Jun 2021 11:39:16 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:827b:778a:e73b:3ade])
        by smtp.gmail.com with ESMTPSA id t21sm302733ioj.10.2021.06.23.11.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 11:39:15 -0700 (PDT)
Date:   Wed, 23 Jun 2021 14:39:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
Subject: [PATCH 4/4] midx: report checksum mismatches during 'verify'
Message-ID: <94e9de44e3b52513c5ab48aecd74f809dc34cbe3.1624473543.git.me@ttaylorr.com>
References: <cover.1624473543.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1624473543.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git multi-pack-index verify' inspects the data in an existing MIDX for
correctness by checking that the recorded object offsets are correct,
and so on.

But it does not check that the file's trailing checksum matches the data
that it records. So, if an on-disk corruption happened to occur in the
final few bytes (and all other data was recorded correctly), we would:

  - get a clean result from 'git multi-pack-index verify', but
  - be unable to reuse the existing MIDX when writing a new one (since
    we now check for checksum mismatches before reusing a MIDX)

Teach the 'verify' sub-command to recognize corruption in the checksum
by calling midx_checksum_valid().

Suggested-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c                      | 3 +++
 t/t5319-multi-pack-index.sh | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/midx.c b/midx.c
index a12cbbf928..9a35b0255d 100644
--- a/midx.c
+++ b/midx.c
@@ -1228,6 +1228,9 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 		return result;
 	}
 
+	if (!midx_checksum_valid(m))
+		midx_report(_("incorrect checksum"));
+
 	if (flags & MIDX_PROGRESS)
 		progress = start_delayed_progress(_("Looking for referenced packfiles"),
 					  m->num_packs);
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index d582f370c4..7609f1ea64 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -418,6 +418,11 @@ test_expect_success 'corrupt MIDX is not reused' '
 	git multi-pack-index verify
 '
 
+test_expect_success 'verify incorrect checksum' '
+	pos=$(($(wc -c <$objdir/pack/multi-pack-index) - 1)) &&
+	corrupt_midx_and_verify $pos "\377" $objdir "incorrect checksum"
+'
+
 test_expect_success 'repack progress off for redirected stderr' '
 	GIT_PROGRESS_DELAY=0 git multi-pack-index --object-dir=$objdir repack 2>err &&
 	test_line_count = 0 err
-- 
2.31.1.163.ga65ce7f831
