Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECE7C77B75
	for <git@archiver.kernel.org>; Mon, 22 May 2023 19:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbjEVT31 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 May 2023 15:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbjEVT3S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2023 15:29:18 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3C611A
        for <git@vger.kernel.org>; Mon, 22 May 2023 12:29:09 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-309438004a6so4064631f8f.2
        for <git@vger.kernel.org>; Mon, 22 May 2023 12:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684783748; x=1687375748;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dL8RywK3IbRfheNuCT7+B/rpq26oTVcacZsRBOSlJMo=;
        b=GI49mn+jvA95mb1g6lXbGeDEJgm4u2sH6R4V6LWSmk9aBeiwod1EVbowKepR1tKqNv
         Rn1oBz9im0tyddQkZz5fH57ov7o41/MeKFBlLVqizz2ARd0eYb+PvrGHd8PaK2wL3LcS
         lBgIcnMDfQfWe0v2/oczEuMvJJ+NOvixhuWYZDIfRco3Ys8/7AZtfanlQMDxyts7KPcl
         ttq/2ccoV4VGyaUQfzN/Vn53UzrX61mCGWeKcR/XqTq+9PTHQiyfkd6wMihv1OwGi6or
         yMdCnX8RYtkc2C3GIjcX725SA02g+KFClQAbKBuRga/yJqM9XSHr7V8Agdfqf586xM+k
         l6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684783748; x=1687375748;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dL8RywK3IbRfheNuCT7+B/rpq26oTVcacZsRBOSlJMo=;
        b=RFaWw2CoPr+uy+tJ5VpCPKAvbF8aWUzpJNI9/9+aoLZWivkORoD018h8hCv73QK+5e
         orZ5cP7tt5+TgRcfUbyJIO7F172XTFX0hQ6/K54gXo3S8Xxt7hhSqMXILAxecCbn06nU
         VtwzGwEdauBhuSDpfEN7ZUklUPxRitG3kQD+QP8HPJ7C2Gpub2S+7aMF8zYpscVkT6uC
         HbfZb0SdUSwkts3SOuRG17LQ5QRB9LTU3TKLUmgLxE83899uTouGocPz29qBD47/ZQeX
         ziUsZ8DlOBzWJlYQajPHGL+s5XLNvlYSsLjZLCTvyq7Z+4RUDdd4BpvrXXV8M7qWCvpg
         iIWQ==
X-Gm-Message-State: AC+VfDzX0nmoabqTc40M/NVI+9UWH1dldQopAsrPt8TVomyJ1WKFQYjB
        qXrp7/plEx2j4QWDmN3ZzCRcbToMhFA=
X-Google-Smtp-Source: ACHHUZ629SnzQbxZfUDUdl+sbsx3IvlXE5C3zCkqpcrRE9Flm1tJA04SFHoYcFdQGrq6nEfg+q3T0A==
X-Received: by 2002:adf:ee8b:0:b0:309:32e5:b47a with SMTP id b11-20020adfee8b000000b0030932e5b47amr9285609wro.63.1684783747801;
        Mon, 22 May 2023 12:29:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10-20020adfde0a000000b003021288a56dsm8717750wrm.115.2023.05.22.12.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 12:29:07 -0700 (PDT)
Message-Id: <17226c56e7b8927c423d31ca2fa4c74859e65f86.1684783741.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1515.v2.git.1684783741.gitgitgadget@gmail.com>
References: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
        <pull.1515.v2.git.1684783741.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 May 2023 19:29:01 +0000
Subject: [PATCH v2 6/6] completion: complete AUTO_MERGE
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>, Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The pseudoref AUTO_MERGE is documented since the previous commit. To
make it easier to use, let __git_refs in the Bash completion code
complete it.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index bcda376735c..945d2543b07 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -767,7 +767,7 @@ __git_refs ()
 			track=""
 			;;
 		*)
-			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD REBASE_HEAD CHERRY_PICK_HEAD REVERT_HEAD BISECT_HEAD; do
+			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD REBASE_HEAD CHERRY_PICK_HEAD REVERT_HEAD BISECT_HEAD AUTO_MERGE; do
 				case "$i" in
 				$match*|$umatch*)
 					if [ -e "$dir/$i" ]; then
-- 
gitgitgadget
