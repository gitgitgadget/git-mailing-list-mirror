Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2C9EE3F09
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 17:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbjILRaj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 13:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjILRaf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 13:30:35 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1B310D9
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 10:30:31 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31ae6bf91a9so5995433f8f.2
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 10:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694539829; x=1695144629; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bco/mAN7rbz9PWrb1z+C/swcIslgubyAJMeM6ZFfiGo=;
        b=nIonOUjkrqScU25zrW6FJ/BqYfPzhareX2jXT2IWARk1cMrwSv5u4p0Qe6jzd8cLSu
         CyvdmnZTsVlr4G0la5eWWixT5dBkSyTuwzBkrE60spnEdbSELC1db/1Xz+12gIZmtfbE
         J2BhTwlKx/Ju+QY7t0EZP9UHj36KMOY4/jShtblc3lRBw3nJEnHqRVGoNH076JeoK1Mm
         ItzBtIXUG/Y+8hAE4fWr60MtXioPvxy7twgHGKu3UZgyOXuhqMACLCgMn/CIMwAP2Brp
         Su9R3cxmO29Oi4Eq67S/ZemsOm1ZMfEVqSNM7HoROOjr1sSuHrVoT6UaoShe6Z6D015x
         t1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694539829; x=1695144629;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bco/mAN7rbz9PWrb1z+C/swcIslgubyAJMeM6ZFfiGo=;
        b=q7xOoWMhUqyvZH4XEZTl1zskkEc+y1/YBj+7yxI01oedIvppdcNowAwjXn63j6k6q+
         FCO1yNvMFi3AwGl2tfi5ZUYYXqhfFFRX+eWg6231KF48JBVIQhmICRp0a3543gHXWDDZ
         FMBbkGeokU5ORU8z7NO/YhgyhmFoQKB9ffx/oN7ZFMkf9H9xEKfYlsyy3g8bqjMYncOZ
         prwygpqFekI5IMg4JDHm8hpHIDg6DJwPoFXk+gBD978cNZL8ePOoS50gDNjw8+3SFnHH
         o/MlCRIVkiQNiA25I5qz2FGLe9ONvDw7OVVmc9JE9PpzB+ImU3s7HCeH7NzajLCMNyaI
         WDEQ==
X-Gm-Message-State: AOJu0YwU3wrlCjwjANMr1HNplaD+GVcZEGFE14k8xpDt3IiaaFAGldZ0
        4BsBSb30YI3ZN/G8dqqD9T/Vjxn1lJk=
X-Google-Smtp-Source: AGHT+IE+P6l+z1Ycvh5Tcrlm91ROgit6ACPHGsYEupD/83phb1KMkWfYz4MZwIvIXNZeY0x23TAiMQ==
X-Received: by 2002:adf:d08e:0:b0:31d:cf59:8d8 with SMTP id y14-20020adfd08e000000b0031dcf5908d8mr164035wrh.14.1694539829083;
        Tue, 12 Sep 2023 10:30:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e12-20020a5d594c000000b0031ad5470f89sm13248120wri.18.2023.09.12.10.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 10:30:28 -0700 (PDT)
Message-ID: <pull.1583.v2.git.1694539827.gitgitgadget@gmail.com>
In-Reply-To: <pull.1583.git.1694108551683.gitgitgadget@gmail.com>
References: <pull.1583.git.1694108551683.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Sep 2023 17:30:25 +0000
Subject: [PATCH v2 0/2] completion: commit: complete configured trailer tokens
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2: This series adds support for completing configured trailer tokens in
'git commit --trailer'.

Changes since v1:

 * added all Martin's suggestions as an additional commit on top since
   pb/complete-commit-trailer is already in next.

Philippe Blain (2):
  completion: commit: complete configured trailer tokens
  completion: commit: complete trailers tokens more robustly

 contrib/completion/git-completion.bash | 9 +++++++++
 1 file changed, 9 insertions(+)


base-commit: 1fc548b2d6a3596f3e1c1f8b1930d8dbd1e30bf3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1583%2Fphil-blain%2Fcompletion-commit-trailers-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1583/phil-blain/completion-commit-trailers-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1583

Range-diff vs v1:

 1:  a31d7a29af9 = 1:  a31d7a29af9 completion: commit: complete configured trailer tokens
 -:  ----------- > 2:  9cb33c20294 completion: commit: complete trailers tokens more robustly

-- 
gitgitgadget
