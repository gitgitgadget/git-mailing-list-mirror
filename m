Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10B0C433ED
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 19:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5910610CF
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 19:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbhDAT15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 15:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbhDAT1m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 15:27:42 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05621C03D20E
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 12:07:41 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id i81so2794416oif.6
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 12:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=flcJ0GGruKQ0XV5Lh/hRxYells6whJf1S5rAUZVgWr8=;
        b=dHcAKUy9Q506NCWlKCz7uJ6MchpkavkRPnpK3mmClk9R6N8rNFHZuOWpG41jSniiF8
         X7ehDZpaysCz26t/7oVmAwV4+/NUQRQr1JseoZ0GmmHl03zNiMoayBBrvVW+5J8aqXt1
         /b0fZhF6uERoAMO4cpMPGDDF/gHDos8SICUeD95rahMq7MNYBkaF5pI/7/x75fHG2rTV
         xo1ns6k9rjDxo/cQXcinZ/CWsqDdX9NyHFHEIZfcBT9PV5zL22bkxSE3hckg20qdYuET
         hVQcj9vEcPdRvr8I/XJ+9StKS4Hdg5Nh6EK8Lc6WY+OMcx2CyPkCTomAAis6Oa82SXk5
         H4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=flcJ0GGruKQ0XV5Lh/hRxYells6whJf1S5rAUZVgWr8=;
        b=TOlYSlspL/B/hIwNWny0+Vq4G1lB0s/wisJ/840QlO8kdxupljU06NAyOzl2gzpYDN
         blfkXGvYW2PhWEYFCVxzLOQtt4XeFkdrGTEYWZZamAvxIpC3hcayzwGjvWOPpR3R4HYA
         w1s1mwGu+I76lb5PWqljobxYsG//OkZu206L4hme0Nde9lbDsRblX3fkm786t+LfEWkq
         AdqhOOD9/FtzNNC3XHD7HYT+FWAAKSuL0lUSoqkCM873U+8ZQKL5GH8UqoO2FMPDSX1r
         Xy5JX3MPvkcdFrZLIcwDBD2dLw1+gEhp/FQVequuffki6jkdD8g6oQr+L8c2nBN6SWy3
         2nNQ==
X-Gm-Message-State: AOAM530irfJkc15RlH4biN+PhNrY8Z/Deek+2RpwOJkdg6jNVcVbh567
        EAZe8qpAzkWywI37MlrjpdDJDVnBy1ZVTg==
X-Google-Smtp-Source: ABdhPJzus+qGGPYSqq0HkcNdycNEVFftHzOB/geRfaLV5zTRuG1x0UJ3CoVCjE8YXM3M+C+iB02/Bg==
X-Received: by 2002:a05:6808:2d5:: with SMTP id a21mr7212402oid.88.1617304060171;
        Thu, 01 Apr 2021 12:07:40 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:1cff:cd17:c59a:654? ([2600:1700:e72:80a0:1cff:cd17:c59a:654])
        by smtp.gmail.com with ESMTPSA id a128sm1219868oib.7.2021.04.01.12.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 12:07:39 -0700 (PDT)
Subject: Re: should git maintenance prefetch be taught to honor remote.fetch
 refspec?
To:     Tom Saeger <tom.saeger@oracle.com>, git@vger.kernel.org
References: <20210401184914.qmr7jhjbhp2mt3h6@dhcp-10-154-148-175.vpn.oracle.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d246df21-fdaa-a391-847a-e03e8e664af1@gmail.com>
Date:   Thu, 1 Apr 2021 15:07:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210401184914.qmr7jhjbhp2mt3h6@dhcp-10-154-148-175.vpn.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/2021 2:49 PM, Tom Saeger wrote:
> I've recently setup git maintenance and noticed prefetch task
> fetches ALL remote refs (well not tags) and does not honor
> remote fetch config settings.

This is intentional. The point is to get the latest objects
without modifying any local copies of refs. You still need
to run "git fetch" manually to update the refs, but that
should be faster because you have most of the objects already
in your copy of the repository.

Here is the essential part of the documentation [1]:

	The refmap is custom to avoid updating local or
	remote branches (those in refs/heads or refs/remotes).
	Instead, the remote refs are stored in
	refs/prefetch/<remote>/. Also, tags are not updated.

	This is done to avoid disrupting the remote-tracking
	branches. The end users expect these refs to stay
	unmoved unless they initiate a fetch. With prefetch
	task, however, the objects necessary to complete a
	later real fetch would already be obtained, so the real
	fetch would go faster. In the ideal case, it will just
	become an update to a bunch of remote-tracking branches
	without any object transfer.

[1] https://git-scm.com/docs/git-maintenance#Documentation/git-maintenance.txt-prefetch

Thanks,
-Stolee
