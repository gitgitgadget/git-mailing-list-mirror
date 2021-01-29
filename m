Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7921DC433E0
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 01:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3183D64DF1
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 01:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhA2Bcu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 20:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbhA2Bcq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 20:32:46 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70E3C061573
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 17:32:05 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id z22so5658531qto.7
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 17:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s3yEv4KKwu+T/pNNC6AE9ALKGgPNcxNvA6pyF6Y8gFE=;
        b=G0CSMvMBrzzVEtrZO05TCEnLLUA3alDlF/GWf5Xws5O4AP1F3guSVldVqCdcQHIgc1
         mY2C58BEZkJ9zQ4fIRxY34+HIwhR39PJ7JeSj/Y16uZB2Qz8WfwwG76npXFHnnhOIlTz
         ZZKBLzGFUX/6vSFsSS8m06use/+SXe1YjHFCOwHJHeLFIpkX0bc7AWix5sMC+5Fn0u2A
         PLEjEsNY/RSKWypqoZbKc/6StI61gl+TofYTUfv3RCUO9jVlNvR3DkoTglHKeAc6s7M0
         Wk3ykmeByNvZ32+IWUsUQNf3ePewIRrzQVU9qsSMbj1shtTjLWmVeW6yHbAdrXn0ZhwX
         h++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s3yEv4KKwu+T/pNNC6AE9ALKGgPNcxNvA6pyF6Y8gFE=;
        b=MG6GAXQzHgXOE4rhz0W1VQ+61y8GLx6YEdrVZDP3fmrKYpF10myG39MN/hh5Wp9587
         xY/WXBJd0U6jLw9hLgFj7Pr5y4rFOrwNUk9BYU4Vjm6UAWo3ZKoV4vHgvMDFkR9pu9h6
         y8FGmyelOm+osWcA6eQ5HCT4Ee7s8pmTGxwXPbFT0maTS9KqK8crR/o47XbY3YhaUFVU
         zUYOLOFYIcnBaYUKjIRalzXGg/xf8cgvRA/oNbFJmUzcTBz02DadyuwEGwDpEq/prR7b
         stFm/Ev6ZvLPgO+uFt7XyJvmsuLo8HNI1uCWmc3GWgCLA29Ptbf9C/mpo2pZqnJK1XJP
         102g==
X-Gm-Message-State: AOAM530tCwES0oQgaYzcJn3GtssxK7U75Km5KGb63sBQHoGJt+/peXD6
        CGQyIwpzZyB8d58sORIsSd++Qw==
X-Google-Smtp-Source: ABdhPJwIGPhap7wwDmyyuVkSTVVtIScgG3pt0K8rRkxTczit4fGCnJzNOR1y/+7ZOQ3SjA4iH0Rirg==
X-Received: by 2002:ac8:4551:: with SMTP id z17mr2213291qtn.295.1611883925148;
        Thu, 28 Jan 2021 17:32:05 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:5d6b:9c45:5e60:e7b4])
        by smtp.gmail.com with ESMTPSA id h22sm4396695qth.55.2021.01.28.17.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 17:32:04 -0800 (PST)
Date:   Thu, 28 Jan 2021 20:32:02 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com
Subject: Re: [PATCH v3 10/10] t5325: check both on-disk and in-memory reverse
 index
Message-ID: <YBNlkvrxvAYrLeMc@nand.local>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1611617819.git.me@ttaylorr.com>
 <38c8afabf25a7f5e144850938cf00b53e9cf25fd.1611617820.git.me@ttaylorr.com>
 <YBNfZeRiHgQwSqGq@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBNfZeRiHgQwSqGq@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 28, 2021 at 08:05:41PM -0500, Jeff King wrote:
> Oh, I forgot to mention: if re-rolling, s/fortuan/fortuna/.

I do like your suggestion quite a lot: it gets rid of some ugliness,
while making the overall test structure simpler. Here's a replacement
for the final series.

Junio: when queuing, please apply this one instead of the original v3
10/10.

Thanks,
Taylor

--- >8 ---

Subject: [PATCH] t5325: check both on-disk and in-memory reverse index

Right now, the test suite can be run with 'GIT_TEST_WRITE_REV_INDEX=1'
in the environment, which causes all operations which write a pack to
also write a .rev file.

To prepare for when that eventually becomes the default, we should
continue to test the in-memory reverse index, too, in order to avoid
losing existing coverage. Unfortunately, explicit existing coverage is
rather sparse, so only a basic test is added that compares the result of

    git rev-list --objects --no-object-names --all |
    git cat-file --batch-check='%(objectsize:disk) %(objectname)'

with and without an on-disk reverse index.

Suggested-by: Jeff King <peff@peff.net>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5325-reverse-index.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/t/t5325-reverse-index.sh b/t/t5325-reverse-index.sh
index a344b18d7e..da453f68d6 100755
--- a/t/t5325-reverse-index.sh
+++ b/t/t5325-reverse-index.sh
@@ -94,4 +94,27 @@ test_expect_success 'reverse index is not generated when available on disk' '
 		--batch-check="%(objectsize:disk)" <tip
 '

+test_expect_success 'revindex in-memory vs on-disk' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit commit &&
+
+		git rev-list --objects --no-object-names --all >objects &&
+
+		git -c pack.writeReverseIndex=false repack -ad &&
+		test_path_is_missing $packdir/pack-*.rev &&
+		git cat-file --batch-check="%(objectsize:disk) %(objectname)" \
+			<objects >in-core &&
+
+		git -c pack.writeReverseIndex=true repack -ad &&
+		test_path_is_file $packdir/pack-*.rev &&
+		git cat-file --batch-check="%(objectsize:disk) %(objectname)" \
+			<objects >on-disk &&
+
+		test_cmp on-disk in-core
+	)
+'
 test_done
--
2.30.0.138.g6d7191ea01

