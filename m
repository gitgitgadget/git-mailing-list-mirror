Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFDCC77B72
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 09:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjDQJXz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 05:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjDQJXx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 05:23:53 -0400
Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEFE5FFA
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 02:23:16 -0700 (PDT)
Received: from [192.168.42.163] (205-49-142-46.pool.kielnet.net [46.142.49.205])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id C6A4B3C0251;
        Mon, 17 Apr 2023 11:22:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
        s=kas202302241129; t=1681723375;
        bh=Ah86/RlyPHdNqQ/iMgfjPEnvrqe/w7w/Cb0h+YR2Mj4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=vsZ4W5vEjiLnohL+MkSuBTAkKpQ8immDfRgzNPb/DOOSgcuPVOjsN9wtt5TgBBM3F
         RG/IgFTCSPqAhoiiqikoVA9iV+fzDGWTErqjfEMLjt7p8Ea8xavh4FNaMHgLoFVTZi
         vr21Zq3N07l+y9wWr1W6SR3HNc1NYt5VKeIicLmmVJrrKwTCSjkiLOlZX5oj203T06
         lXWh0n4gsJ28MBW/w7lwnt5BS6+ty0xh/RYAChdBxSzMvFTVcZTZf/pD3Uv5eZ3TFR
         +zGsgMfsGBZK8WTecukgpMzRh4oUS3OU0S4R9kH5JT9R/52UVU2dOZGs6nmwoVEnig
         nRCW9M6zIJ59A==
Message-ID: <6a8b92d8-5b86-9cf3-3619-4c8bedfa2d47@haller-berlin.de>
Date:   Mon, 17 Apr 2023 11:22:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: Should --update-refs exclude refs pointing to the current HEAD?
Content-Language: de-DE, en-US
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
References: <adb7f680-5bfa-6fa5-6d8a-61323fee7f53@haller-berlin.de>
 <d3895d9b-b45a-449d-a5e6-b8b8c5e6c4b8@app.fastmail.com>
From:   Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <d3895d9b-b45a-449d-a5e6-b8b8c5e6c4b8@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17.04.23 10:34, Kristoffer Haugsbakk wrote:
> Hi
> 
> On Mon, Apr 17, 2023, at 10:21, Stefan Haller wrote:
>> 2. I have a topic branch, and I want to make a copy of it to make some
>> heavy history rewriting experiments. Again, my interactive rebases would
>> always rebase both branches in the same way, not what I want. In this
>> case I could work around it by doing the experiments on the original
>> branch, creating a tag beforehand that I could reset back to if the
>> experiments fail. But maybe I do want to keep both branches around for a
>> while for some reason.
> 
> I would use a lightweight tag, too, since this option doesn’t touch tags.[1]
> 
> Why do you want to keep both branches around? 

Several reasons:

Maybe the original branch was pushed already, and I'm collaborating on
it with a coworker. At the same time, I want to run my rebase experiment
in parallel on a copy.

Maybe I want to create github PRs for both of them, in order to run CI
on them, or get feedback for both of them from my coworkers.

Also, it just seems to be the most natural workflow for many people. I
have seen my coworkers do this a lot without thinking much whether there
would be a better way.

My question is not so much whether copying branches is a good idea, it's
more about how --update-refs should deal with copied branches *if* you
decide to use them.

-Stefan
