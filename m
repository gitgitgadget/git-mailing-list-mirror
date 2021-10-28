Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069BCC433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 20:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3B0C60F21
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 20:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhJ1UxN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 16:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbhJ1UxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 16:53:09 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20095C061745
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 13:50:42 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id j128-20020a1c2386000000b003301a98dd62so2230183wmj.5
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 13:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/3BQ47Of5lw0cRdrRiB/L5MVqoyNIW0Sj9oxuURLlVI=;
        b=DaLztAzygQIbKD1r4ycmKcrTcP7Rw41cwvCYzZpJIMoei/z8JS4RrpHmRzA7n3aDoN
         PwYzA5gOkg+TplS6RsdnSijWw7vFzK2LXB13SDZjg8LJX72tT2NarsARr6kClzRjXW3m
         m/vUcMjBovv2AC+56TXaORLbVvstO6ik1K8F0HNiUxV1LI/z0lSHLN3/jMUpbsn7EkeN
         ndlyMDQVo+cojBfH/NcMLYxeGQaFoF6XKZgjla3zdxfHUxgDSWyxfAMD9ciuOmm56ahb
         ah/MzPDSgwfUO6QSwgXSPK3oaB9wfwZb7hQomAllCqthii6pa3rL4jrSmO0GhNdIDkFO
         t9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/3BQ47Of5lw0cRdrRiB/L5MVqoyNIW0Sj9oxuURLlVI=;
        b=b2tkZFVxIXIoqKZKaYFtkFyCRw8SEbXpIaRtfFpUkxKLAkJBk2BRWbp2+gw5M/C14T
         ugKgsj94e4Ok++Of8DKURGetbh+ADvUYsdBrnaJcVrg19Ohr3tcv6UQS8WZJPio5arhP
         xSJioEoh9G/hLE1EnnC4+Gq9O6DxmJEE4sfbc4XHSfnCzRBV3bb61r9nnhvfpg5KekQL
         T0GzhlPxRyyYnG7CR61sp8uCBqn57e9oAwBsH50jVCowCYE/1WzhpKUnpEgysMY35Kuv
         vyp9jD36B84AHnIXmiz6h2tZUeWqy4XS9BnEiQkt4lyQE6vxiqGBPVCG3xD1SV8d0oIY
         S0HQ==
X-Gm-Message-State: AOAM530O7PsTCt3fBmI29aWSh9l+Hz49sJcGGgyjba9dB/7SXxT9jiTw
        +nmZKHug+173rdXwxGOrTO9YC8V2PKk=
X-Google-Smtp-Source: ABdhPJzhsIDGd3xFPVF0jjNJcAEhjDMOBI95TsgbHCJYZr5pMYxIn7cSbNjtZwodLGfwfmIL+WXYaw==
X-Received: by 2002:a1c:2507:: with SMTP id l7mr14591035wml.186.1635454240752;
        Thu, 28 Oct 2021 13:50:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z1sm4140721wre.21.2021.10.28.13.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 13:50:40 -0700 (PDT)
Message-Id: <1bdded86f5db61e3983a0f817817f0fbfbae112c.1635454237.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
References: <pull.1068.git.1635320952.gitgitgadget@gmail.com>
        <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
From:   "Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 Oct 2021 20:50:33 +0000
Subject: [PATCH v2 3/7] t1051: introduce a smudge filter test for extremely
 large files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matt Cooper <vtbassmatt@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matt Cooper <vtbassmatt@gmail.com>

The filter system allows for alterations to file contents when they're
added to the database or workdir. ("Smudge" when moving to the workdir;
"clean" when moving to the database.) This is used natively to handle CRLF
to LF conversions. It's also employed by Git-LFS to replace large files
from the workdir with small tracking files in the repo and vice versa.

Git pulls the entire smudged file into memory. While this is inefficient,
there's a more insidious problem on some platforms due to inconsistency
between using unsigned long and size_t for the same type of data (size of
a file in bytes). On most 64-bit platforms, unsigned long is 64 bits, and
size_t is typedef'd to unsigned long. On Windows, however, unsigned long is
only 32 bits (and therefore on 64-bit Windows, size_t is typedef'd to
unsigned long long in order to be 64 bits).

Practically speaking, this means 64-bit Windows users of Git-LFS can't
handle files larger than 2^32 bytes. Other 64-bit platforms don't suffer
this limitation.

This commit introduces a test exposing the issue; future commits make it
pass. The test simulates the way Git-LFS works by having a tiny file
checked into the repository and expanding it to a huge file on checkout.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Matt Cooper <vtbassmatt@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1051-large-conversion.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t1051-large-conversion.sh b/t/t1051-large-conversion.sh
index 8b7640b3ba8..7c1a2845005 100755
--- a/t/t1051-large-conversion.sh
+++ b/t/t1051-large-conversion.sh
@@ -83,4 +83,17 @@ test_expect_success 'ident converts on output' '
 	test_cmp small.clean large.clean
 '
 
+# This smudge filter prepends 5GB of zeros to the file it checks out. This
+# ensures that smudging doesn't mangle large files on 64-bit Windows.
+test_expect_failure EXPENSIVE,!LONG_IS_64BIT 'files over 4GB convert on output' '
+	test_commit test small "a small file" &&
+	test_config filter.makelarge.smudge \
+		"test-tool genzeros $((5*1024*1024*1024)) && cat" &&
+	echo "small filter=makelarge" >.gitattributes &&
+	rm small &&
+	git checkout -- small &&
+	size=$(test_file_size small) &&
+	test "$size" -ge $((5 * 1024 * 1024 * 1024))
+'
+
 test_done
-- 
gitgitgadget

