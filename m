Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF80ECAAD8
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 08:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbiITIkS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 04:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbiITIjw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 04:39:52 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8475D1144
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 01:38:56 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o5so1366326wms.1
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 01:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date;
        bh=HKfvkZVphmx55tXQIdckR4zx/Hz3mrU5+vK8DQLLNk0=;
        b=RtddDEnn7ULU8xXYsa9aS3DQeaSZU0/nprMWvejXnMmWUNjJSHSxg51M0osi9IEWH/
         ZQJEe/58/OYHZBbYojkovVWBt36Kyl9flBoGi3H7H69o+KD33ZbqG+/oUkJAPjnGpNfI
         CMQKdT3VEZFc2ZpA5kBpoHcD3G/KNssgxgJKZYgusM9UK7yWHM/WgZvuH17P3uMxgP1F
         yvTCOgULti9H2hqyEShvGFHhbDIQbmDOUh1eKXznlTRcXyZ+LWbi/m8/VXYKQjV02+7f
         nBZ6EzSSSL45fMzLj5KfX+S0904M9JVmEA+TqA4tu1rMkA+SuLocGvoOKupikWhyo0m3
         G6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date;
        bh=HKfvkZVphmx55tXQIdckR4zx/Hz3mrU5+vK8DQLLNk0=;
        b=PGSgHbytl6Fqb8BJTKYTLY1MqjKO+h5YW+HVtFqBsEKN7ITfxuhpzHJbnWzDMkCpIK
         uV+aJhYTh9MCYKwDZd6Xnr2QuJC8TSnkKU98T9Eo7Bw+hte6PGc0I0zgkxKRXllYP9nH
         T7Rro9c9PeLVhujs57ytmZLc0qK0lgrWnTtZL78JK65qj2B2XL3LpfsnWLBJHm5R8n9+
         Utb2MqAr0ARD7QFrPfynu0RJBExpkCfiYN0yu9WxxUdsT6qAstVkFT9RcxZcTS8XfENt
         aOLjqKfCgn3DvemB43GW1Ql+yVhCEhdZrQeCUwS7MHMBvAmpLU7LR9qjVLLVREmNfLka
         yTYA==
X-Gm-Message-State: ACrzQf3vABgcqBIGVe15rD097XdPxznHGwYohjVvsSNNfdetbhg40/iZ
        bIrBhegrzT4nJJcnAVe2OT8=
X-Google-Smtp-Source: AMsMyM4ZFeCvCuRC3kUGRIf2cP5EC6abfmndN5jZEXiEqB/eckChMhRfa9A3DNs1OqQ6aplHkrMs1g==
X-Received: by 2002:a05:600c:4f13:b0:3b4:9a07:efdb with SMTP id l19-20020a05600c4f1300b003b49a07efdbmr1477887wmq.94.1663663134967;
        Tue, 20 Sep 2022 01:38:54 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id q9-20020adff509000000b0022aeba020casm920188wro.83.2022.09.20.01.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 01:38:54 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <07e739b7-bb60-c23f-7077-2c8f8cc00b62@dunelm.org.uk>
Date:   Tue, 20 Sep 2022 09:38:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Handling the Git trademark
Content-Language: en-US
To:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
References: <CAP8UFD3WQ64FuXarugF+CJ_-5sFNBCnqPE0AEBK-Ka78ituKTg@mail.gmail.com>
In-Reply-To: <CAP8UFD3WQ64FuXarugF+CJ_-5sFNBCnqPE0AEBK-Ka78ituKTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian

On 13/09/2022 13:11, Christian Couder wrote:
> Hi everyone,
> 
> The Git PLC (Project Leadership Committee) is responsible for handling
> the "Git" trademark and the Git logo with help from the Software
> Freedom Conservancy. And we would like at this point to report about
> how we have been handling it, and to open the conversation about this
> subject.
> 
> We have a web page about our trademark policy on
> https://git-scm.com/about/trademark. There, we list our guidelines for
> others who would like to use our "Git" trademark. Unfortunately a
> number of people don't respect our guidelines and use the trademark
> without asking us first (sometimes in ways that we might not like).
> 
> If we don't enforce our trademark, there is a risk of us losing any
> right to it. So far we have tried to enforce it, especially in cases
> where people want to register a name based on it.
> 
> The issue we have with enforcing the Git trademark is that we don't
> have much resources to enforce it. And in general we want to avoid
> spending time and money enforcing our mark in all possible instances.
> Legal discussions, going to court, etc can be very time and money
> consuming, and we would prefer doing more productive things with our
> resources instead.
> 
> So, as much as possible, we don't want to take legal action. For
> example, we would much prefer to respond to a disagreeable use of our
> mark by first contacting the party and asking politely for them to
> change their use. Usually this is sufficient to deter infringing uses
> of our mark.
> 
> We would be Ok if necessary to publicly say that for example one
> company is using our trademark in a way we don't like. We think that
> the threat of us doing that (if the company doesn't agree to change
> the way they use it when we ask politely) is in most cases enough to
> deter people from using it.
> 
> This way of handling issues has worked well so far. The reason we
> think it works well, is that people think about the "Git" name as very
> cool, and that's why they want to use it in their product or company
> names. If the Git project would say that it doesn't like the way this
> company is using the Git trademark, it would likely create some bad
> buzz about that company and would go completely against their goal of
> being perceived as cool.
> 
> Now we cannot be sure that this will always be enough to enforce it in
> the future. We might have to go to court in some cases. Also we still
> spend some time on this, so another possibility would be to stop
> enforcing the trademark and the logo altogether.
> 
> We also would like to thank the Conservancy and the layers they have
> hired for all the information, help, advice and guidance they have
> provided on this.
> 
> Now we are open to your thoughts about this.

Thanks for taking the time to start a discussion on this. My immediate 
reaction is that it would be a shame to lose control of the trademark by 
not enforcing it. If it is taking up too much of the leadership 
committee's time perhaps we could consider asking for more volunteers to 
handle some of the load. Would a few people volunteering a couple of 
hours a month make a useful difference?

One other thought is that there are a number of companies which use 
"git" in their name that benefit indirectly from the git project 
enforcing the trademark and thereby ensuring the name "git" is trusted. 
If we were ever in the unfortunate position of having to take time 
consuming (and presumably costly) legal action perhaps we could approach 
them for support?

Thank you to all the leadership committee for the time you spend 
handling these administrative issues.

Phillip

> Thanks,
> Christian for the Git PLC
