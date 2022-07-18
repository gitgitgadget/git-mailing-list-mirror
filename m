Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80275C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 08:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbiGRIcD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 04:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiGRIcC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 04:32:02 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647FF18E00
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 01:32:01 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id v12so14225254edc.10
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 01:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=/fuYVZQhohqPkGAUFsgT+rojrkmur9q2qUBF5xQKWX4=;
        b=mMKO+oDaRFhU1Al8Fuerk3wX18NNPUz75Iv+Hgj/tdO2fH3MVuMNAlrbXf9TP/FucO
         MNf7OTf6Q7CMGe29EAQMpV6QP6vqyzUAc/kJzmUU9HA9PwXxS6Zfx+nb2BLFnk80wuKQ
         i7cl3+Dn9ojq0Ue3YFHvr4sWkh2ya0R6MxFDLk8pr0DcSJ3HCAtLgmR/Za3eSc/0JLC1
         gbgL3qblQ9V7t7h4pG3/mrK8NYz9JicolJxSen7ez//9iDwRb9fVETHoWktNwNybEbW4
         /0E3ENnANC5+rFMLbk+OeIYpZUH+KYDcLlSIdNRGVlKgbyW3aHBWtJ4YjBgVJ93Py3Mt
         423w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=/fuYVZQhohqPkGAUFsgT+rojrkmur9q2qUBF5xQKWX4=;
        b=wxZAvI53Y5+McW3Rl28oYVYTbjHeZBBtdtk3ZTmf2OoN+MNhVyWxvU+77RdTnIBDE4
         zGd8pRwoakpYJP+nSuPnjZMV3Ab68FyXbl+1OM724oKUJGFdsNRtqXCuFhUrF/sgobij
         BBrWDzYgRth4TExIHIYD1RUD7vzKpZim6HTx0SgWDz1eKyeeBVujZ0CCZTmUubd//Y7v
         w8kbnMpJlEgwrO71YV/D1RwW9bPi4EKaiMHS2grLdwoQSPrhCfJdlCpou1U1mQZY78lT
         Z5nh3uMhXrXoaf9XGN1R6j44rhjyyDNM1oCZnEPBNpum7a9ez5tIaZHooM3AtUTIvYzS
         gkQA==
X-Gm-Message-State: AJIora+zhk0hXjnk1pvdrexhlQX99gIAvwgUg7HtWmlN+tdftZjCgtn6
        eOAo4SXdtjL1NyZNFtIuTPNLSMhoaGw=
X-Google-Smtp-Source: AGRyM1ui0Iji1lT7KxucwJh8smbneZ483Wj013q4sriypC5INzRIXGTMmxC+QPZ5L780l+7oMs62fw==
X-Received: by 2002:a05:6402:5cb:b0:434:eb48:754f with SMTP id n11-20020a05640205cb00b00434eb48754fmr35982330edx.421.1658133119805;
        Mon, 18 Jul 2022 01:31:59 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709061da900b006fec27575f1sm5202085ejh.123.2022.07.18.01.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 01:31:59 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oDMAY-002zSL-KR;
        Mon, 18 Jul 2022 10:31:58 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <jch@google.com>
Cc:     git@vger.kernel.org, "ZheNing Hu" <adlternative@gmail.com>
Subject: zh/ls-files-format (was: What's cooking in git.git (Jul 2022, #05;
 Sun, 17))
Date:   Mon, 18 Jul 2022 10:29:48 +0200
References: <xmqq7d4bt8n4.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq7d4bt8n4.fsf@gitster.g>
Message-ID: <220718.86lesqyg75.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jul 17 2022, Junio C Hamano wrote:

> * zh/ls-files-format (2022-07-13) 1 commit
>  - ls-files: introduce "--format" option
>
>  "git ls-files" learns the "--format" option to tweak its output.
>
>  Will merge to 'next'?
>  source: <pull.1262.v7.git.1657692472994.gitgitgadget@gmail.com>

I think it's ready except for a very last set of small fix-ups noted in
https://lore.kernel.org/git/220718.86pmi2ygbt.gmgdl@evledraar.gmail.com/
