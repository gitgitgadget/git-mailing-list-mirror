Return-Path: <SRS0=73cz=AB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E1BC433E0
	for <git@archiver.kernel.org>; Sat, 20 Jun 2020 14:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 001A623CCD
	for <git@archiver.kernel.org>; Sat, 20 Jun 2020 14:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDFiOVE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgFTO7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Jun 2020 10:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbgFTO7B (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jun 2020 10:59:01 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2076BC06174E
        for <git@vger.kernel.org>; Sat, 20 Jun 2020 07:59:00 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id i1so2963430vkp.8
        for <git@vger.kernel.org>; Sat, 20 Jun 2020 07:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=VG7KDCAU4z9EWuU69OMV5KBXZ8UeYGo8V8w7UNMB5NI=;
        b=qDFiOVE3Ju0CPBhIYGpBMpOTwKHimKFmCkguCXnG2lGytcIU3WGENIAGfcUKmZyai/
         p5hjji8ayUKVeCLA0ZRJ6ci5VETRy7weHZcwbBaJXFFlErEj0k7RrpPu1MLmHBksyhDI
         2dBUPuVMTLzRIdxUU4svTC1M7W08otTgZS+ynG5gTqKjjtiQAR9DZXS/iyQ3Jq13Ga/S
         qX7C5+wi8Yph02nvg2rZgxYTLiTq+hn7PZqsagN/egQD6L2n2BpIGkBEfJesT9pVwF8R
         AGPfNzHEvPtR5SXamPjXR9YhWIZGNkyNXcRFIHK/RKS+rWVIMdqVRvqnZmwr4AGbblWK
         VVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=VG7KDCAU4z9EWuU69OMV5KBXZ8UeYGo8V8w7UNMB5NI=;
        b=OWyROj4obdQUYdYObAfp4QMooTUFuCTmTPQrmvnytONgWWfpV4xS0NbQ8wZs2hSssq
         qnnJV3uFql+ztmzAGf5ZYGAdLAHSm/VxdDH+ny6jQ7S3gQZSyWn21yQFBEUoLiNhgw7v
         8V/pD8y7wFKzJ17fqRPwzUztsdbpMNZ5QP9A1s3emhSNO0aTm4YjfbPd5pdvMCVb6c8Q
         py4oxVG5WwDU1stFRr11XU4CFD/gs8EfUGjxPW3jWWI5E0aoVhFiitimyCyMYsyN1j/F
         YALLnEBGjBIrR6u5hAaxO7pc/QHGmki3M/dgbFHzbIUk38SBIEX7kwWyw6HgKsU18kwZ
         6hWg==
X-Gm-Message-State: AOAM531s4Om19MHAzzAoleDFd+2rkUTHY/yOQ3ULkqbT/dTi53JnXwet
        bRvEm0YhvLYjwbHhYr4qLkkMysEr6BCw1E82GVla5ZyQxqs=
X-Google-Smtp-Source: ABdhPJyb+H7cm0W27P/r81d59KOIIKrjZ1Mcau2O/PMoSpxqKHUcolpMtDNDMFKBMee3/p414x00VKuqW+kVumEt/BM=
X-Received: by 2002:a1f:d783:: with SMTP id o125mr10968208vkg.46.1592665138736;
 Sat, 20 Jun 2020 07:58:58 -0700 (PDT)
MIME-Version: 1.0
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Sat, 20 Jun 2020 22:58:47 +0800
Message-ID: <CAGP6POKvZHHWDcV4-4P6Y4yy6gCujm7vpEqKxWW0whT2FyqYEw@mail.gmail.com>
Subject: error: Unable to get pack file
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have a local repo mirror for https://source.winehq.org/git/wine.git
which was updated some time ago. When I try to update the local repo
to its latest version, I meet the following error message:

$ git pull
error: Unable to get pack file
https://source.winehq.org/git/wine.git/objects/pack/pack-3776ee1d93e316ed56507e9062d8fc8e5c07feed.pack
The requested URL returned error: 416 Requested Range Not Satisfiable
error: Unable to find 6ed1d04b1325d4c2480907b76b8b1d5529caebab under
https://source.winehq.org/git/wine.git
Cannot obtain needed object 6ed1d04b1325d4c2480907b76b8b1d5529caebab
while processing commit bf454cc39428fc5299e5c26d9c0ddc6a9277c7ae.
error: fetch failed.

Any suggestions for this problem?
-- 
Hongyi Zhao <hongyi.zhao@gmail.com>
