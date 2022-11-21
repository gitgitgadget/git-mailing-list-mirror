Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1224BC433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 03:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiKUDAf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 22:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiKUDA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 22:00:28 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A29F2FC13
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 19:00:27 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id b12so4111155wrn.2
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 19:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCaIGT8G+GqKz4PWOcqc32ri69czi5anqnyaDUI4HEY=;
        b=DU2s3jwNDZH5weMZ5fkv8Z4Pdv6ZRopTQjjblqWqbiv85FshcVZVAcMGjnG4hxT8N/
         +tTZr9r/xn47qc6B2eWuu8C9lP071rAynl5JybQ0zdNQ62ZcPYavAeNs71fv3FOmmg5Z
         QwsXBUmyBhfcEXEAt2iiCgLJjRh1Zsv7IsCkYBCe/z9U+tMya1INrTHwfop9/WVe3UbO
         cG/BS5+FEdEBq1+6Rf2FTG6pdRb8NE1yZwgJaEVKr6R9/eNHHfSyJgr0Al6Y8VeYueI+
         AiI38IMywmJDdS0M8zjOKfuVLnc7YEHmhBYlF9JX4pTi9hlBSjOTd45uDJJgn3S/Dftq
         iUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCaIGT8G+GqKz4PWOcqc32ri69czi5anqnyaDUI4HEY=;
        b=kutWiuICDtUyRzwPMb9+WKquhLKBRRLuS2lv3NVn3NxEUrzQS7kXnWTeg1IBDu6cnE
         8sXku4EEBoreFVYdRpx1l3+lQQ3Ogp9tFqjy0G2ZeqKMU99VEg6/RMnyfGCP9E6qeTpa
         HRdJgeZKD89C/sRhlBs8QBDTYVS2/cNTw4tTzwtUAUtwQ4yrUglP0RjqAWwQ+vgd8kxb
         /okumK8IXNfLEpkt2ZQ+i9sRiAA7xISu2f674Zbzh5lTTxHhqqsTVC6njwqw/dA7j/zh
         eP5Jx5gDPjpDSztpB4N+uRaCvoFmEk/7ill7t1+e/ySgwfGdEP9l/Gv+X8s/VCn0ovu3
         o/iw==
X-Gm-Message-State: ANoB5pn3dJumoc5aNbV8z/dtuGWtX3aRz4b5cPOYF0QzY4Dxl6u7wPT9
        qfzbwRubBM9o9ztbWFLtR09lCSdYpGM=
X-Google-Smtp-Source: AA0mqf6xumimGrhXTBSo8ujOaRUVDIkQBciQ538SNbTuPPPp+6nblvXS2EqEE/H3g4CW2pShbkQ5Zg==
X-Received: by 2002:adf:f847:0:b0:241:d9c7:3400 with SMTP id d7-20020adff847000000b00241d9c73400mr570441wrq.620.1668999625845;
        Sun, 20 Nov 2022 19:00:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d4cc1000000b002365b759b65sm9921100wrt.86.2022.11.20.19.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 19:00:25 -0800 (PST)
Message-Id: <97ada2a1202190776ce3989d3841dd47e2702316.1668999621.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1425.git.1668999621.gitgitgadget@gmail.com>
References: <pull.1425.git.1668999621.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Nov 2022 03:00:21 +0000
Subject: [PATCH 3/3] t1509: facilitate repeated script invocations
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

t1509-root-work-tree.sh, which tests behavior of a Git repository
located at the root `/` directory, refuses to run if it detects the
presence of an existing repository at `/`. This safeguard ensures that
it won't clobber a legitimate repository at that location. However,
because t1509 does a poor job of cleaning up after itself, it runs afoul
of its own safety check on subsequent runs, which makes it painful to
run the script repeatedly since each run requires manual cleanup of
detritus from the previous run.

Address this shortcoming by making t1509 clean up after itself as its
last action. This is safe since the script can only make it to this
cleanup action if it did not find a legitimate repository at `/` in the
first place, so the resources cleaned up here can only have been created
by the script itself.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t1509-root-work-tree.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t1509-root-work-tree.sh b/t/t1509-root-work-tree.sh
index d0417626280..c799f5b6aca 100755
--- a/t/t1509-root-work-tree.sh
+++ b/t/t1509-root-work-tree.sh
@@ -256,4 +256,9 @@ test_expect_success 'go to /foo' 'cd /foo'
 
 test_vars 'auto gitdir, root' "/" "" ""
 
+test_expect_success 'cleanup root' '
+	rm -rf /.git /refs /objects /info /hooks /branches /foo &&
+	rm -f /HEAD /config /description /expected /ls.expected /me /result
+'
+
 test_done
-- 
gitgitgadget
