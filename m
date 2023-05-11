Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188A4C7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 18:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239112AbjEKSLG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 14:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239109AbjEKSLE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 14:11:04 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7D9618E
        for <git@vger.kernel.org>; Thu, 11 May 2023 11:10:41 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3078c092056so4283469f8f.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 11:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683828637; x=1686420637;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZhFDGmqjC6o6CL26mgnGBnxyvAceRWz2SgtOUWsswA=;
        b=OVhJMTalLwdJfIsgLR955xf6VbITq56dH1FFoRI+guzLPD8ghlzIlCmENTyDatNjjO
         kTXHiBZR5bo0VmwEq84MpxoVRa9ouC5T6sRp4i4kZXQBtB3tHpqKUNxqWOuuNDR/lbfI
         0Z/tjhWkqkJATpIbB7neL5COOiysHwITyLrrzriVnjdfr3/7HMaFhaxpo4I/5QjWhT+N
         o+HH3+uTx3hFLoHAzSNrTNqjoH3v85vR8o+4KyyflZHgu8C0kiJLX0tbHiaSfH2Z9T9M
         GuU2e+V5r8EPH9YXWeLyzaBbbVZ94HAgMOnqstWWPsAs8Epnam0WNSplB8lMghd64xLp
         O/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683828637; x=1686420637;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZhFDGmqjC6o6CL26mgnGBnxyvAceRWz2SgtOUWsswA=;
        b=QlrTp8jXJ1R6IOEDVLh4UiP+T8q0TysbUcJ1Ph4vul15KAF1LqS4PTs3wN5l3ALRp0
         1fAcLomiY9rPGapPMBKDoJlawA/+gEJcg6DciTutGN+e/YMP03AbUCbOa42AzUZcakNq
         GRO3A9K19X+66tQkqV9/sTm1FrvRAZKCpGA3+ew+eaqUSHH5amL+ejuY5HZ8tljY1tfd
         JIlc9Z0EUZvQI0mRbgF5uPEhfemqZciOB+TN7pylZATdIVTaN9BIcTX+wKOXvZYENSqz
         +8W53M0KeUWwZctqfxROHmU+6aI7R/Cwv0B7jQDDtPBt5sVF4cIDpu6AzVkpcH8Gh9rx
         3gXQ==
X-Gm-Message-State: AC+VfDxcA/F5B4VVQ7JLWM4Ls8N/LHpwm/RpsLUk60oBmX16kLhXZ1Bc
        t84Q16Ea4hrHEzwDzvl+nk0DpkvNg+M=
X-Google-Smtp-Source: ACHHUZ5WyCXXfgs2TcgYQesCWY4rINIh/AvrOCX85Pm2oTlqAHOT6MagNNUF178lKwSsNDJZAmO+og==
X-Received: by 2002:adf:f1c9:0:b0:2ce:aa2d:c625 with SMTP id z9-20020adff1c9000000b002ceaa2dc625mr14649527wro.22.1683828637202;
        Thu, 11 May 2023 11:10:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p1-20020a5d4581000000b0030639a86f9dsm20968351wrq.51.2023.05.11.11.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:10:37 -0700 (PDT)
Message-Id: <0d462010b798f834fef55cc7aa767f3f2a177f91.1683828635.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1501.v3.git.git.1683828635.gitgitgadget@gmail.com>
References: <pull.1501.v2.git.git.1683659931.gitgitgadget@gmail.com>
        <pull.1501.v3.git.git.1683828635.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 May 2023 18:10:31 +0000
Subject: [PATCH v3 1/4] docs: clarify git-pack-refs --all will pack all refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

--all packs not just branch tips but anything under refs/ with the
exception of hidden refs and broken refs. Clarify this in the
documentation.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/git-pack-refs.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-refs.txt
index 154081f2de2..e011e5fead3 100644
--- a/Documentation/git-pack-refs.txt
+++ b/Documentation/git-pack-refs.txt
@@ -49,10 +49,11 @@ OPTIONS
 
 The command by default packs all tags and refs that are already
 packed, and leaves other refs
-alone.  This is because branches are expected to be actively
+alone. This is because branches are expected to be actively
 developed and packing their tips does not help performance.
-This option causes branch tips to be packed as well.  Useful for
-a repository with many branches of historical interests.
+This option causes all refs to be packed as well, with the exception of hidden
+and broken refs. Useful for a repository with many branches of historical
+interests.
 
 --no-prune::
 
-- 
gitgitgadget

