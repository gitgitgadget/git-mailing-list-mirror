Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF67C7EE2A
	for <git@archiver.kernel.org>; Fri, 19 May 2023 04:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjESES0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 May 2023 00:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjESESH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2023 00:18:07 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06AA10F5
        for <git@vger.kernel.org>; Thu, 18 May 2023 21:18:00 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-30796c0cbcaso2786185f8f.1
        for <git@vger.kernel.org>; Thu, 18 May 2023 21:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684469878; x=1687061878;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uT6jl+hfZy+5jBejVeoGS17KRh0aHKd4GnSV24Icj4M=;
        b=NBFX6AbWB5oAyWb1bTpVZxP6fyqmHNt3ZtB3VLcVCDYsPkNuy9Pe17Zskxh+35Wjz1
         80fTN6CC0503uzgYCuytgi6Thm/7RiGrfJ/CAiGxZb0GpqFLk1FPR7lZlDuwKVbu/XR/
         RcB2eDTddQwflJba8tWxgdluqckxiSjjh64CsjsfroyXwWX/RXk8dk2u2zToHVKsQTwX
         o6yDNkKuauy99whb9KVVPU5KjotBKOVFfJon8/2WixmJi1uFsj8K79KSxSlhEDlrxNK6
         hTxzBT0AK5bWij1U8KNPTj50yLYAT0QJUL5pLxl/evBG95RPUKegbU6SBHgTd92YrdWn
         Tzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684469878; x=1687061878;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uT6jl+hfZy+5jBejVeoGS17KRh0aHKd4GnSV24Icj4M=;
        b=ZpfQcT7JENen9yRSIi/raLHuQOL0HwLSbpbULwea4oZCwJzvs38EPoXr24Lfk/8qZd
         cs+fmngEzweMne7ophJeRTYcPGUBunLArZkSTvx240sX1bFmNMzEHkYuofMgIiRdGCe+
         gm2tLtx9b65jwHYMYm4lXJ3ArpNUTj/ljqG18I25gOWHBkboYA1Dwl7VIYwPhP48Z9a4
         EJMMBS8ZOCI0qyoCbDDi3xWD2O8x9iLmS7h5P+bOmdS/4ZYr8HrFkeMv5imbuBXPn7OV
         /sQFA1gbDpf8kbEKK1/utGEVlZSj1Ymh5mqAHJwtfOp0wk5EUKe1LEpWcuOD4V/mBedf
         jXQg==
X-Gm-Message-State: AC+VfDxgJt1LonU1zh53jhu3Ol6ZXPirrIowknYay5CtfkELCVGH1ltL
        VZ1+5H7rrqfClBxLeh3Uyyh59UDNGcE=
X-Google-Smtp-Source: ACHHUZ78cY3hchLrKN2ZfxacVNvUaXbbcl0D1sFMz4rdcWZMYXRDNeaZsPxirphLlQUXE1XeqEQqbA==
X-Received: by 2002:adf:f8c4:0:b0:309:4358:5afd with SMTP id f4-20020adff8c4000000b0030943585afdmr434436wrq.54.1684469878528;
        Thu, 18 May 2023 21:17:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j3-20020adfe503000000b003062675d4c9sm3971485wrm.39.2023.05.18.21.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 21:17:58 -0700 (PDT)
Message-Id: <68c35f605aea8577b05c1f7b5917e1bcfbd16df1.1684469874.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1471.v4.git.git.1684469874.gitgitgadget@gmail.com>
References: <pull.1471.v3.git.git.1684152793.gitgitgadget@gmail.com>
        <pull.1471.v4.git.git.1684469874.gitgitgadget@gmail.com>
From:   "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 May 2023 04:17:52 +0000
Subject: [PATCH v4 4/6] ls-remote doc: show peeled tags in examples
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Sean Allred <code@seanallred.com>,
        Sean Allred <allred.sean@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sean Allred <allred.sean@gmail.com>

Without `--refs`, this command will show peeled tags. Make this clearer
in the examples to further mitigate the possibility of surprises in
consuming scripts.

Signed-off-by: Sean Allred <allred.sean@gmail.com>
---
 Documentation/git-ls-remote.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index af71cf4a92d..aabc1a7b90b 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -106,10 +106,10 @@ c781a84b5204fb294c9ccc79f8b3baceeb32c061	refs/heads/seen
 
 $ git remote add korg http://www.kernel.org/pub/scm/git/git.git
 $ git ls-remote --tags korg v\*
-d6602ec5194c87b0fc87103ca4d67251c76f233a	refs/tags/v0.99
-f25a265a342aed6041ab0cc484224d9ca54b6f41	refs/tags/v0.99.1
-c5db5456ae3b0873fc659c19fafdde22313cc441	refs/tags/v0.99.2
-7ceca275d047c90c0c7d5afb13ab97efdf51bd6e	refs/tags/v0.99.3
+485a869c64a68cc5795dd99689797c5900f4716d	refs/tags/v2.39.2
+cbf04937d5b9fcf0a76c28f69e6294e9e3ecd7e6	refs/tags/v2.39.2^{}
+d4ca2e3147b409459955613c152220f4db848ee1	refs/tags/v2.40.0
+73876f4861cd3d187a4682290ab75c9dccadbc56	refs/tags/v2.40.0^{}
 ----
 
 SEE ALSO
-- 
gitgitgadget

