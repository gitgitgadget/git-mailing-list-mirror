Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA91ECAAA1
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 23:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiJaXrn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 19:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJaXrk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 19:47:40 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91833E014
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 16:47:39 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id d123so6360896iof.7
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 16:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TzeFBE/02V1+BOVURoUdU4ZJxN6VYDJGPt6PIap9zHQ=;
        b=EjdOkqEFl3SymQ+cZ7xkEPW7UllW2ht8AUIRRPbQ8+i33eDdZoJ/Sg0b+/CvBaHsBL
         TxZeHoXmnkE8RDvP7wB4zrq3VszSJ3WpgEuO9PSr99ZBFKUnFJAWCy8Taa//4UhI5rIM
         0ybibSo6lzJyaKeeh8ZIpalfhiSL4Ins4dBFcJet26TCgr0qNinOvhmy5PB29VGHYCvn
         G4PNpjxnioykeQo0tgXJLbNbO8/ypiFWbCPDB7LcirD9S1p/5f/kKebf7UTmRG+mXfAR
         fKRcgxEnfgs6ZkOmIcmH7S8nG6P84jUG+rPA19xpL8P9gN2ksr7Hwdu47LQ96O5SZFA2
         Hdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TzeFBE/02V1+BOVURoUdU4ZJxN6VYDJGPt6PIap9zHQ=;
        b=oOiDAZqK2VWv4oSwNseomnclog7uMvvp0TLfQh12BgO6+qwrLJYRglieYvJvIJzRdU
         w0ZMjPhPOu/ks2ISMBnoSc7I6P6NYQ/jW9GPgdSlTYDgaFcNuytPXBydaxeq9HpUQPcB
         pmGOSjEGWNWVQEMrHXsSQm0kIoxJyuxFEcpJiMMLi8f5bksuP40VXH8mHng8Q5i7AVTi
         kqjOCI2hpy3wJB5+xYQT2FSe3v1wmVgcW2fZpAQjgAfKvUAtv9pQDHMm5Ohkqa1orAj4
         wc5WzVT5Prvw/Zwf3zQM+zDAd/Dyg5eijw0eoBLQMeFh/ww5xCM4nox+CfXe6SS4quCV
         LDpw==
X-Gm-Message-State: ACrzQf1ZCx6h+HYk39TDapnL9dECwQ5kxHbMSSK5YaFSq8xf9xkD6o+0
        78snbCybsFW9m8heRHHtYKDeQN/WkXb0IWif
X-Google-Smtp-Source: AMsMyM6is8o3vCBoUbwxCFox4xBaNLtTlZGCer0N8SL/L2B9Dz6WaFEep+GrKNlu7mpgfRBFae79bw==
X-Received: by 2002:a05:6602:13c2:b0:6bd:26f1:dc21 with SMTP id o2-20020a05660213c200b006bd26f1dc21mr9095909iov.189.1667260058776;
        Mon, 31 Oct 2022 16:47:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s3-20020a92ae03000000b002f16e7021f6sm2943407ilh.22.2022.10.31.16.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 16:47:38 -0700 (PDT)
Date:   Mon, 31 Oct 2022 19:47:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 0/2] Documentation/howto/maintain-git.txt: a pair of bugfixes
Message-ID: <cover.1667260044.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation on how to use the scripts in 'todo' has a couple of
small typos that make it confusing when generating the Meta/redo-jch.sh
and Meta/redo-seen.sh scripts the first time.

Correct these to avoid any confusion in the future.

Note that this branch is based off of 'tb/howto-using-redo-script'.

Thanks in advance for your review.

Taylor Blau (2):
  Documentation: build redo-jch.sh from master..jch
  Documentation: build redo-seen.sh from jch..seen

 Documentation/howto/maintain-git.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.38.0.16.g393fd4c6db
