Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C4EC433DB
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 03:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2117E22B2E
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 03:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbhAQDoG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 22:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbhAQDoC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 22:44:02 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDDCC061574
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 19:43:19 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id x13so12880105oto.8
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 19:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aQ97nUsg8Ra38ZftbhEIVWWC1uSCdMiQKZOo1h0lrcI=;
        b=d7RDvatYgHKG+75VA1y6uK+8LkNFFr+qaBAgc4TLXHEyTKJhqsxkaJuLU7ukhsbKZo
         hrrnROT1HuIF9/vdtmaLzTLA7Ina3ZADKdziPSjIV6BDsKA2J+JipwdcZ0vbNvmfs4RT
         2Sg27WU9R/xbPA/Y6+Eb5cobSSi8OYXYIvQblqpRXQKOV31O34Gf57uSkdlHBeJYgoyE
         qoKtKX0/nry/JVp/ZHKOtmqH57mUh9r8GX3wqeUdAZZKQN/IAZ/XJVR9ikIg33DtCoQh
         +rFB7DLVDcEqVuxyqek2hiPcbVhhwRNM5gX/MKOVJFYO0DsTQ81Xzi41o98o9IgvrOtb
         6yDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aQ97nUsg8Ra38ZftbhEIVWWC1uSCdMiQKZOo1h0lrcI=;
        b=OLsNGUlqmRbGcsKthBmb3PWidABGMwKHhe6nKPrUKCbgr4+ywlSCsuMI5OFVfakBtD
         l5C1hUAf2ZzvPfZ9yUmIVsYTOwp0LVEXh5EBQEG1Xbs2J+bI+/q6WJT/cOTrL3dwha5l
         9fstn/Rfg0uXtK8s8VoFe9RX+c2kM9V3U/vooHreWcFX2948J/850PSfXjed3dEMK9h7
         D2zGM6xH9m7MAq0zfU1sdK4uBLojzdj7OMP/zJNcaDOmLpd9O6xfMzENhpTt1Wz090DQ
         f0PPeZt8qv2iHmmEF9mdW+GultV5/85MPkernU6eKjE0skP8CYC/ZTRee5xvepn8aDch
         pYMQ==
X-Gm-Message-State: AOAM532BPa6lyjh6SMZydHbch9BuuzmN5PryCJ9UmEyVI883YUxe6NA3
        xKppYdATBGdiE1DPdTgpoIdSFZvsD5XWcV8pLnQ=
X-Google-Smtp-Source: ABdhPJyXzqDa+BrZiMmnzP0be7OkfTRWOyZHmNpo2zlTsLcH30cuFVMicAye59fkSQLuN0TrMHMMS4OP95wG8gVTsR8=
X-Received: by 2002:a9d:741a:: with SMTP id n26mr6415845otk.210.1610854998529;
 Sat, 16 Jan 2021 19:43:18 -0800 (PST)
MIME-Version: 1.0
References: <CAPSFM5c2iqBn8_Dih2id7q6RRp0q=vfCSVUHDE5AOXZ8z3Ko9w@mail.gmail.com>
 <CAPSFM5f+cm87N5TO3V+rJvWyrcazybNb_Zu_bJZ+sBH4N4iyow@mail.gmail.com>
 <99b40665-45dd-6c4d-d46a-56c7dbf89568@gmail.com> <xmqq7dofxnru.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7dofxnru.fsf@gitster.c.googlers.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Sun, 17 Jan 2021 09:13:07 +0530
Message-ID: <CAPSFM5cEnex1xaBy5ia_xNFDNzt5_Y=W-6TB9d9yW_AiPAKxDg@mail.gmail.com>
Subject: Re: How to implement the "amend!" commit ?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio and Phillip,

On Fri, 15 Jan 2021 at 02:02, Junio C Hamano <gitster@pobox.com> wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
[...]
>
> > Note that we intend to allow
> > accept any prefix of "amend" and "reword" so --fixup=a:<commit> would
> > work.
>
> "a" and "r" may happen to be unique but we would not want to be
> limited to these two forever---future developers are allowed to
> invent other clever variants.  So let's say "accept unique prefix as
> abbreviation for these operating mode words like 'amend' and 'reword'"
>

Earlier, I thought to implement the UI of amend! commit as :
"git commit --fixup=a/amend:<commit>"

So users can either use 'a' as abbreviation or 'amend'. But I want to once
confirm if I got this right ? As I am doubtful about, what does allowing to
accept any prefix of "amend" and "reword" means ?

Thanks and Regards,
Charvi
