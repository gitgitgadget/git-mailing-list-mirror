Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B67FC47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C951610A8
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbhEaR2t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbhEaR1o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:27:44 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51462C072137
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:07:29 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id e27-20020a056820061bb029020da48eed5cso2875277oow.10
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Ph3i0wyHwV/H8kH7ID7qp2RkzH0EHqZhrD14MJHHMWk=;
        b=MfR2JXVTVTdnlREW99iHKuvDi6VmqkTqtBN1ijaXAkpPzUNTKzt+ToI7AjH0HMGt0R
         C2SbwalfBX+eAWgMJ2R6inlWcb/2efVMWSnwBEFikEKhr59GScZalHBKbPTL4BQnMmg1
         It5DFE/ZFIdsibTFyFdKAvv7jyk53KmPrIWxPflsAw0NfxDgeb2RLnWUomAndjB9R4zD
         NjIG/Eaj2gEwbUvchCEaCkBbQE+oL32vzIAKseVygUY7a9ZIeuEL6YSWCvWCqVzGmv6O
         upmNpJ3jPmoakWNWlnW8MtTi0coWhS2yzO1cyhzKhaSl6MACcAaje4fFJxhLay2QcgRL
         2ALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Ph3i0wyHwV/H8kH7ID7qp2RkzH0EHqZhrD14MJHHMWk=;
        b=IOyQ1qVC+ESd2mbfXnYFX05s/2+wSfY60FONg7cM+lxHa07TXcaZx9jidSF31/Qb+x
         HpSZI7DrUGNZh+mYOY4d07pM6Wx37pmCADNO+mbhVWUOKNP2MeOMp0pUREV6KzgcfKzq
         sLkUva3Fh0yKbGE4I1QfNdpf+qPiImc6gvjuVPqyuGNlta9APePihb6nZHHNkvifkU9b
         6vX8ys40Z0XilKKT2AofJEyyufYc3Qkcr9nes8f7yMRk9ba7g54A4jpOCJgaDv4KV+ha
         adZeZzwKi7A2SOKUlZxLYmSSXP+jeTtFxy7KITKD3x2fniK87sk9D/xV5FOzRPn152Lo
         AZ2A==
X-Gm-Message-State: AOAM5314EYyPdnSHy9amrc74oPuFCkVmFWaEfmJfCnHmzs43bbOf89zv
        yedYbaH+dY59omf2NvFRvLQ=
X-Google-Smtp-Source: ABdhPJwxT8Ie6xAPqK+CxfjJhKynPwvnppPl8yOp7QJkge399N9TKaEPZJasf3MhdhgoXiY7dKkM3g==
X-Received: by 2002:a4a:e89c:: with SMTP id g28mr2299002ooe.60.1622477248703;
        Mon, 31 May 2021 09:07:28 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id i4sm3148029oth.38.2021.05.31.09.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 09:07:27 -0700 (PDT)
Date:   Mon, 31 May 2021 11:07:26 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Message-ID: <60b509be97423_24d2820856@natae.notmuch>
In-Reply-To: <YLT2UfCZyQIXWIOv@coredump.intra.peff.net>
References: <pull.965.git.1622363366722.gitgitgadget@gmail.com>
 <YLP/GEN0qIXvWEUn@coredump.intra.peff.net>
 <CAOLTT8Q0zbxh8X03ZmgAzHadTbE4-Af+AB3POOUF2n22u8RExw@mail.gmail.com>
 <YLT2UfCZyQIXWIOv@coredump.intra.peff.net>
Subject: Re: [PATCH] [GSOC] cat-file: fix --batch report changed-type bug
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> The simplest test is just:
> 
>   git -C all-two cat-file --batch-all-objects --batch="%(objectname)" >/dev/null
> 
> which will currently fail. It would be nice to verify that its output is
> sensible, but I'm not sure how to easily do that (it will spew a bunch
> of binary tree data, and it cannot even be parsed reliably since we
> haven't output the sizes).

I use ruby to parse binary data from git all the time:

        git log --format='%b%x00' |
                ruby -e 'ARGF.each("\0", chomp: true) { |chunk| p chunk }'

-- 
Felipe Contreras
