Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBCCC4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 00:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8295C60F01
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 00:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbhHCAhN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 20:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbhHCAhM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 20:37:12 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C14C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 17:37:01 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id t66so18497984qkb.0
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 17:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5SvZVIp1OYCE8MAPt7M0UORSANVW+Sh7VW1GQeJVgEk=;
        b=HyTDQpwDIiVbEFLVByjDSkL97e251GY7ZFNpgEgIHHeXc6Aa6EToxD0F8DvQQsqzAk
         G/kGmESbOWFtT2zVMHvtDh9iRMYnI4D+aj6SVkHoG8OG1emi4lyzkakvr3Jc5hPXOqov
         SMmrGtIr/wbvbeQLoM1PocjLjn14LbX3QunAlgIX1gkH4d3DUnVGstbX2QHFk95vnS9L
         s2pBncVwaJyaNEOcEFAVGzt11H6at+pIoXzyZZlgleHs+KWWBCTCLuotV48TMNsY2Ybq
         ze6dlBgSDxOS6P5uj+wU/2mQ9CFevZwejX3+n89tU9WFedGnXUcQ9FvJI6zQHYDFR0IA
         ykQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5SvZVIp1OYCE8MAPt7M0UORSANVW+Sh7VW1GQeJVgEk=;
        b=UyepuVCtl+Yzfl4pCtz/4m4eNsh+NnHg2dM+oZJKl39ONYhet2jjoEVte4FNoLMIng
         RctcW05EDFxOaLok8z935+11CnpHcrFnh20+NiutfawCYp+LJXfPLTvfv+o+3sBTrP9n
         h+JaSOM87OGkF5yPHMylmxQ/ZBaa4epTSulVOj5TFiu2gkqTtCTkKztZeUBhwfHmmpTm
         d78bi4I2fbZZC61Pf36UsK/pcdFaW66rNv+eDEz3GHHTQb9EMHJhwDLgryP/CGjfGr6U
         hAnKf60Y+YAX/RuvLhPSFpTwwh0W7TYmDgLtmYAN4lfqpqeyKx6SwJggwZm1Vcqy0/Fb
         xbQA==
X-Gm-Message-State: AOAM533vekeMzpuCQ3jBd9eEfsQPd43N3alrA1Y0ONXfHp+fnw5FwGxk
        L2Da9xxZGFalTFP0zuuewLs=
X-Google-Smtp-Source: ABdhPJwtSW70Kb/i5FhCJVw+qInI2jpLCad6HK4jyVFYlv53i5is/K10fxoOF7m0CWULSQ6yu0Wlew==
X-Received: by 2002:a05:620a:893:: with SMTP id b19mr18258871qka.487.1627951021045;
        Mon, 02 Aug 2021 17:37:01 -0700 (PDT)
Received: from localhost ([24.169.20.255])
        by smtp.gmail.com with ESMTPSA id v11sm5654523qtc.0.2021.08.02.17.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 17:37:00 -0700 (PDT)
Date:   Mon, 2 Aug 2021 20:36:59 -0400
From:   Ben Boeckel <mathstuf@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 2/4] advice: add enum variants for missing advice
 variables
Message-ID: <YQiPq3gFnDa49UA7@erythro.dev.benboeckel.internal>
References: <20210731022504.1912702-1-mathstuf@gmail.com>
 <20210731022504.1912702-3-mathstuf@gmail.com>
 <nycvar.QRO.7.76.6.2108022333360.55@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2108022333360.55@tvgsbejvaqbjf.bet>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 02, 2021 at 23:52:54 +0200, Johannes Schindelin wrote:
> On Fri, 30 Jul 2021, Ben Boeckel wrote:
> > These were missed in their addition in 887a0fd573 (add: change advice
> > config variables used by the add API, 2020-02-06). All other global
> > variable settings have entries already.
> 
> It took quite a bit of reading and looking through the `git log` history
> to piece together what is going on here, and I wish the commit message
> would have explained this better.
> 
> A big puzzlement came from the claim that "These were missed" is not only
> missing a noun that clarifies what "These" are meant to be, but also from
> the fact that `git grep advice_setting 887a0fd573` comes up empty. Which
> suggests to me that nothing was missed there, but the problem lies with
> `hw/advise-ng`, merged via c4a09cc9ccb (Merge branch 'hw/advise-ng',
> 2020-03-25), is based on v2.25.0, but was only merged after v2.26.0, which
> contains daef1b300b0 (Merge branch 'hw/advice-add-nothing', 2020-02-14).

Ah, I missed the logical merge conflict that was in effect here. I'll
add this to the commit message.

> In other words, the addition of the two entries `addEmptyPathspec` and
> `addIgnoredFile` happened in a diverging branch from the addition of the
> `advice_setting` array, and the problem lies with the merge of the latter
> into a branch that already had merged the former.
> 
> It would have helped me to read something along these lines:
> 
> 	In daef1b300b0 (Merge branch 'hw/advice-add-nothing', 2020-02-14),
> 	two advice settings were introduced into the `advice_config`
> 	array.
> 
> 	Subsequently, c4a09cc9ccb (Merge branch 'hw/advise-ng',
> 	2020-03-25) started to deprecate `advice_config` in favor of a new
> 	array, `advice_setting`.
> 
> 	However, the latter branch did not include the former branch, and
> 	therefore `advice_setting` is missing the two entries added by the
> 	`hw/advice-add-nothing` branch.
> 
> 	These are currently the only entries in `advice_config` missing
> 	from `advice_setting`.
> 
> FWIW I manually verified that last paragraph's claim.

I did as well :) ("All other global variable settings have entries
already."). I also verified the reverse, but that was going to be moot
with the other patches anyways. But having it called out as a separate
paragraph sounds better.

Thanks,

--Ben
