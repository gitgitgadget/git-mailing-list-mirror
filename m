Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEEDC433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 15:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiJUPOe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 11:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiJUPOF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 11:14:05 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DC124A55A
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 08:14:03 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a10so4827655wrm.12
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 08:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCv6/p3ecQFKtTnCgpFOgTIHGb+AYBU4emdCsGw+pEw=;
        b=I/X0GQO7nSULS7JeGAQRNQDmFiAmzArrUrn9LjyKDH6UP1cAaV3USq38ZR3Dq0x7dc
         VdKspF/5zNGzd7m4fcWCgv+sbQkyWgSf7eIzqzRz3QLp4O1u00o9tjKPYBPGX0UO5uvA
         YAwta0asssDmXkj/KjwWs/CR9Na9CDlF1ziQPRIiT2IUblcUe9TKEKF74xNO66Nwv/z6
         x69RwMBzJF5iyOMlrrdRksjNOuM4vyvvL7ud0KeiscexmvcZpbXfdv1WG1f0XTMA8hXJ
         IVpObIS9gKi6msWu+o7SMAGs+ZmxVvZcn+OPp/TN9Rdjum8+dFM4f+dLbazpri6iP3ax
         d29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JCv6/p3ecQFKtTnCgpFOgTIHGb+AYBU4emdCsGw+pEw=;
        b=sKi7ZxjDQbJsbH8cN9RO8ox2etO6akr9RmRFTjrjZ9Rkx3BsdPfQlnLd6mqJocXGrB
         CM1epCw52Ka7VLIBwV8neBxwEYgRyUGGhw4Hr8dHuSlYSDqGUEh9tBPCETem8Bkp41gF
         E/9fvOQNSQoAGZXyYtly2y+yk1RqV/q7U1uwp5af3acmnLhGoxQE+zywt8+U1DNJ+Dw9
         BSA6sgTWb1tmi0lUjPDWEuq/QGCUFI0UhnHJq7esaavT6+5SpuUa2HWlcvknCHBxz4Pk
         SijKI5nIvWRWO6CaFQYgQMeayQ1XtX2YVuAE9gP/fIlVPZJ55IoUfzioLAlg2SNITraT
         gaLQ==
X-Gm-Message-State: ACrzQf3W5Z9j4xzMT4wrZ8dr/N3Sm6lgA74DfouNqy8mUCyHmeNmdd4R
        OpGid6mgXqxejNRvGqscc12LRv3DDQ4=
X-Google-Smtp-Source: AMsMyM4/hfYoOD6yJYi+bg1FMFf5ptamHhx6+WNU29nehz2ptJJUh/LFqO9M/AEkXA4DPfdUEDsK1A==
X-Received: by 2002:a5d:4050:0:b0:22c:dfcc:675b with SMTP id w16-20020a5d4050000000b0022cdfcc675bmr11932617wrp.105.1666365231231;
        Fri, 21 Oct 2022 08:13:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p63-20020a1c2942000000b003c6c5a5a651sm2789539wmp.28.2022.10.21.08.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 08:13:50 -0700 (PDT)
Message-Id: <429b3656f503785b60297ace4f83fcceb7363a4c.1666365220.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1390.git.1666365219.gitgitgadget@gmail.com>
References: <pull.1390.git.1666365219.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 15:13:36 +0000
Subject: [PATCH 6/9] subtree: use named variables instead of "$@" in cmd_pull
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Luke Shumaker <lukeshu@datawire.io>,
        Thomas Koutcher <thomas.koutcher@online.fr>,
        James Limbouris <james@digitalmatter.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

'cmd_pull' already checks that only two arguments are given,
'repository' and 'ref'. Define variables with these names instead of
using the positional parameter $2 and "$@".

This will allow a subsequent commit to pass 'repository' to 'cmd_merge'.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/subtree/git-subtree.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index d91a9679075..2b3c429991b 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -1005,9 +1005,11 @@ cmd_pull () {
 	then
 		die "fatal: you must provide <repository> <ref>"
 	fi
+	repository="$1"
+	ref="$2"
 	ensure_clean
-	ensure_valid_ref_format "$2"
-	git fetch "$@" || exit $?
+	ensure_valid_ref_format "$ref"
+	git fetch "$repository" "$ref" || exit $?
 	cmd_merge FETCH_HEAD
 }
 
-- 
gitgitgadget

