Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EE2C433EF
	for <git@archiver.kernel.org>; Fri, 27 May 2022 22:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355072AbiE0WxJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 18:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355064AbiE0WxI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 18:53:08 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D23132A2D
        for <git@vger.kernel.org>; Fri, 27 May 2022 15:53:05 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id i27so11125050ejd.9
        for <git@vger.kernel.org>; Fri, 27 May 2022 15:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=G2QZ7KufKktyLg/eBV1jJM7lAS/Td9tbIG1P2/1oOEo=;
        b=JS+WlI1zpCBXADrsNALuuH0+aNlU1idwDcghAE0PVu1x1FNm9TsWy+ODudcXauPZ/E
         dHCUKetmuTtZNbbjkin8fMSolOVTgl2LDcDzZR+sWHc6u6IFa/U2B3ls/M6Knc5xWmy6
         C3Fooz2WdlyinHJFaZUE5RCdeOqvLg+4RQfAN9JntNOLKQPZfz/wdFbBiPRHqNEbhSFT
         pvIivsW5sEyrfiPf37ivjtE4z7VbW9H/36Vv3qsHUTkX8nT+YzdCVPAM3s3kSvlrtlQY
         lul+KmCMeACdDb/wslOqv2Bu4Up8OemeIScpj0gHQIim3cxbcvOyCf3300LKVdA7447d
         opSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=G2QZ7KufKktyLg/eBV1jJM7lAS/Td9tbIG1P2/1oOEo=;
        b=CAO+yeMo9A5hzyAdhzMimdAxbwDsplC50FH470158mlapZg9nKDoVxRv26i3B9nnBk
         mSsU7hbDFhq889DnNSuN8SvmqVuVK2EBwMgvCpBSUEHrpinPM+nJpaYkxiYcvBcUWHQy
         DdqtX4QMrMO+8v3656LtmgJ3cHBLDCfMUt5JeTqDnLPZQEEpGz+QNMAt9nhMgdhwz12x
         UrzR5xsyEWznkC6EsQXXE5QatnY3HdfRmv2WFA0Q8C86iyW8sWa2CVcpncjqy4z0OAVS
         kZIGfujWApD2y9C/MUfAdSS4qGlO9jgT0czkLwB6fr8gUkqABHJOCLwKP2ajsNu59MvR
         IUWA==
X-Gm-Message-State: AOAM5334KF1bQM0lKRQQ4oNqdzwW7Qp550wVZFw6GUPqKa/TSFP2MaKL
        6PnrN+oqmy6sBRyLbJc2PJ+J8IxmXGwdag==
X-Google-Smtp-Source: ABdhPJznnuAlKVJgu3/sqkigvlH5Lsa936m+pCq4z5rB45jijw5sTNWwARXLMXYCFbusYs0EecJhuQ==
X-Received: by 2002:a17:907:d86:b0:6ff:1557:a080 with SMTP id go6-20020a1709070d8600b006ff1557a080mr12943477ejc.678.1653691984282;
        Fri, 27 May 2022 15:53:04 -0700 (PDT)
Received: from [10.25.18.6] ([181.214.173.27])
        by smtp.gmail.com with ESMTPSA id r25-20020a50aad9000000b0042bda1327ddsm2631482edc.73.2022.05.27.15.53.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 15:53:03 -0700 (PDT)
Message-ID: <55585ede-0135-b996-08da-fc1919827981@gmail.com>
Date:   Sat, 28 May 2022 00:53:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 4/5] receive-pack: use bug() and BUG_if_bug()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
 <patch-4.5-c590f4273c0-20220521T170939Z-avarab@gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
In-Reply-To: <patch-4.5-c590f4273c0-20220521T170939Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/05/2022 19:14, Ævar Arnfjörð Bjarmason wrote:
> Amend code added in a6a84319686 (receive-pack.c: shorten the
> execute_commands loop over all commands, 2015-01-07) and amended to
> hard die in b6a4788586d (receive-pack.c: die instead of error in case
> of possible future bug, 2015-01-07) to the new bug() function instead.

A verb is missing after "to". "to use the new bug() function", perhaps?

> 
> Let's also rename the warn_if_*() function that code is in to
> BUG_if_*(), its name became outdated in b6a4788586d.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
