Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2D7C38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 16:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 299912192A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 16:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epnXoLo5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgEHQ54 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 12:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgEHQ54 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 12:57:56 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB50C061A0C
        for <git@vger.kernel.org>; Fri,  8 May 2020 09:57:55 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id f11so2418612ljp.1
        for <git@vger.kernel.org>; Fri, 08 May 2020 09:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=tlkeAjG5dwR+i+XW+i3AkoS2BOkkWHCNbkAYtoS0bWg=;
        b=epnXoLo5XV4s+03xbmmJLHDWFIhBzv9HQoH7yBP/3EdP3RWEDHZ1tmQyjHmhZi/n9Z
         3dkkFowItldxikH0PqbHqU1RlC9gwVUm/3/qGWkX6sdWhu3S9u3sAug66z0drorvytmD
         Zk+YGZSr6kdNZF9557OYKO2YhQMYFPqnHXS7QYMhKH6pr6OyNSvsWM6V3dypJndj/Vs/
         zrbVvPmbIoQIQIelLtu1SKFfY8/c9EjMKrBhK12vmx0RQfyv7oenKsGuGp3GOUYtwV4L
         D/1VnTfh8e6OCO0IIlKlt+q8OL5pzwAHe0egokqo2RVYn2yiCV3RL2ccySAv0Z/LEWCc
         mZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tlkeAjG5dwR+i+XW+i3AkoS2BOkkWHCNbkAYtoS0bWg=;
        b=e/zPKhmJUcgIvb99uuxYXwxHCRIgjIC6kI9HstnbQxb8vK8U79EgnZHAiZF9+TPeO/
         gH+TFTWh5/BRS1xDSRSlVfEVN8CHxJPhLbKtzoFYAi7KCCbQTX+SCf9CPoLRONBZJ8ns
         5kHEPF+ZBDOJhemRGdbNC9QawcvauNeUpoADF3w40R98y+DR6FSk9p21jlnLxfZLWCF2
         EPdOLZoguXPrcWE0A2jLSarYpdCuKRstudEPcivTyRYnHxsZlj91E3emvgD0r7doxKpH
         RqQ6L8NRhntjrAPNN7kwfPuNRHxOJwd0PgixTN1LqcP13XF8S6kixkQ68q6tsYqpBpEo
         2nZw==
X-Gm-Message-State: AOAM532tc2iICRCYRPBCyFvggkeHomUcIF5jw9+PkDC6/aEA2YKRXE4k
        qQgdgop6NfDR5dpojSM9ujdkJADJh+3hk2tk
X-Google-Smtp-Source: ABdhPJwjiNmac74+ZPmrcgeOMGFx8Az4X5SJBBrjHsGNBi6n4/ezHz5PL4lRgqdRKKqo8UvURJ1/gw==
X-Received: by 2002:a2e:90c9:: with SMTP id o9mr2204545ljg.187.1588957074064;
        Fri, 08 May 2020 09:57:54 -0700 (PDT)
Received: from [192.168.178.23] (aftr-62-216-206-147.dynamic.mnet-online.de. [62.216.206.147])
        by smtp.gmail.com with ESMTPSA id g6sm1583299ljj.78.2020.05.08.09.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 09:57:53 -0700 (PDT)
Subject: Re: [PATCH] rebase --autosquash: fix a potential segfault
To:     Philip Oakley <philipoakley@iee.email>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Paul Ganssle <paul@ganssle.io>,
        Jeff King <peff@peff.net>
References: <pull.625.git.1588624804554.gitgitgadget@gmail.com>
 <2367cf9d-2e37-b8c2-6881-f3e6c951a460@gmail.com>
 <nycvar.QRO.7.76.6.2005071626340.56@tvgsbejvaqbjf.bet>
 <1a03a7b4-f436-83c5-f825-3b68c07785e9@iee.email>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <4f2ddbba-a9ba-a96a-36c1-b233ea861575@gmail.com>
Date:   Fri, 8 May 2020 18:57:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1a03a7b4-f436-83c5-f825-3b68c07785e9@iee.email>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-08 18:43, Philip Oakley wrote:
> On 07/05/2020 15:27, Johannes Schindelin wrote:
> Is this ability to have a commit message `fixup! <commit-hash>` documented?
> I've looked a few times in the past and didn't find it. The docs for
> `git commit --fixup=` doesn't put the oid in the commit's subject line,
> rather it puts the subject of the referent commit after the "fixup! ".
>
> Searching from a different direction I've just seen it is mentioned in
> the v1.7.4 release notes.
>
> Would a doc fix to clarify this be appropriate or have I missed something?
>
> Philip

Yes, it's documented in description of --autosquash: "A commit matches the `...`
if the commit subject matches, or if the `...` refers to the commit's hash."
