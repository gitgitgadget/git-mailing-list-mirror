Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19E152047F
	for <e@80x24.org>; Tue,  1 Aug 2017 18:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752078AbdHASQH (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 14:16:07 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:34112 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752069AbdHASQC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 14:16:02 -0400
Received: by mail-vk0-f48.google.com with SMTP id n125so9399811vke.1
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 11:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=myitcv.io; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0g0VuqMrRbxMmw8V7OenAM85pNV3kKpX644kQf6J2AI=;
        b=QbsPdp5tEjkYyo9Ct7Tze3weRxoNZGkT7x//mwZhCR4W/UrPap2kcDPqQogkVFVANy
         eV9YNsyQ3/xe4nFheIbAzo0aPKW4Khn1L+TTPSEMMH2Nh8VCfm8KXIE5ZScBVZFDFaR8
         3D0CkUp3Ulgijz0bby9nuDjeRrGuhhz4VKq9o569uA7YVBF0iFwWRCeVBgJxPThaSOvV
         X3XwbVXSdpJvsLWtQRUCRHjPvwNt31ozjiE1HnxQQ/wMapEdGlvdBY+0xUPp5Kf9htkq
         7eoX6SLH/q9JjGw9yjYsmpZnc+7m0zzGM8qssR5WtuillGfpG/bEXhcSCylB4YXtlnla
         9tEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0g0VuqMrRbxMmw8V7OenAM85pNV3kKpX644kQf6J2AI=;
        b=fuaDRRZ9uaDjBq5gwqYtTeQiYYly3pmPi9nmLn7/ftb4PoNzkvKDJ5UTzqVN0TKZeF
         y87Xlxd1HnwvGEoacgWCesXdAG5BAuofcWai29XyaqClG09CmH9FuoOKAFNkmxvExRzu
         JaLJpUUtUx2EQPDQQ3WKRPcw/tHR5RaWEzwSNYKOae5ZSFFv0stMvS+TJ1c8j9qqoQ3L
         RVBRRFiJhm03z0CF5PuR6xW52jYNDL+B6FOb8njn2pnOsqELHiuKRVu+kX8WvfirC59z
         qP3Nc/yHv3hMFG8HQUo5Ml8TJCmPSTMdq8NS01K7mt6U6bPTHtqRkUrmzUtC19kqlmv7
         wGdw==
X-Gm-Message-State: AIVw112iLlcDJ8z4EKxInnzRyaVkfcv3xrdjPQ3689KXE9VBfYY+xMgd
        GougDFfHqG/UupTXSZVFSgs/ZwCbfYoK
X-Received: by 10.31.95.202 with SMTP id t193mr12579318vkb.176.1501611361493;
 Tue, 01 Aug 2017 11:16:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.16.234 with HTTP; Tue, 1 Aug 2017 11:16:01 -0700 (PDT)
In-Reply-To: <20170512181950.GE98586@google.com>
References: <xmqqefwpdx9x.fsf@gitster.mtv.corp.google.com> <20170512162109.49752-1-paul@myitcv.io>
 <20170512172657.GA98586@google.com> <CACoUkn5fyk054BJ5e+C8KynYMJg=EkMLOTiZya8KTNZh+=u5dQ@mail.gmail.com>
 <20170512181950.GE98586@google.com>
From:   Paul Jolly <paul@myitcv.io>
Date:   Tue, 1 Aug 2017 19:16:01 +0100
Message-ID: <CACoUkn7wv2QUjf__frfCd7mczBj-j3YsPmaiaHssL0LG0f+fkg@mail.gmail.com>
Subject: Re: [PATCH 3/2] ls-files: only recurse on active submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, jacob.keller@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> Thanks for the quick response.
>
> Course, let me know if you find anything else! :D

Brandon - doesn't look like this change has made it's way into master:

https://github.com/git/git/blob/master/builtin/ls-files.c

Is there a plan to merge it?

Thanks
