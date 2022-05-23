Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB510C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 19:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiEWTHO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 15:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiEWTEX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 15:04:23 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7826110FD3
        for <git@vger.kernel.org>; Mon, 23 May 2022 11:44:30 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id e20so12722453qvr.6
        for <git@vger.kernel.org>; Mon, 23 May 2022 11:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=YO49wW54ZFxXfkkPi9aRe1xjLJOq1a93veNXlRwBsao=;
        b=HQlk8RmKzNankcAx7SD0KdrHd3V+NVmsVCQYuEg4A//t1oNw5+UAwmANIqUhGKjN7Z
         I3XQEiNdzebp+RahclE+5XfDGV99+cnZG5Gan78nf1AOiBd6U7qP2qaJUUVF2viNToNY
         6pDeaKjtN1YjwmrbD+giZCyFSWjyqKa9aqyHZG5mpqQ+Mtz3/iduo1kbgDumOhToN7fA
         j1YfIo0TLn6hWCHDn86+ZtnMixttoTQ0oiTVjEQEgDU3+ODtiE1GW0KlZCoSZml7ZcaC
         /pcvCxiQI1zNH40Vber7QB7mMG/wyPTFYeMG9tgVOh7udhvMbNmruyZHeNJRkMD88z19
         Pv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YO49wW54ZFxXfkkPi9aRe1xjLJOq1a93veNXlRwBsao=;
        b=kMGqZjdrT+lX47K6VUTXKRPV8PqDAohdwPF72hZQFc0jWo8N6Obb7wZGIvziosKJrX
         uxlVe6eiIrdvNcaM/+tTGybDYvhTciM2lwI5pfjZN/85hJ80lFnP/cYnSNzXE3tKQ4AN
         VGJpCOqcYY9H1p+JqR8JngU+Hpu4mWDM+vWBg9jAvHG9JXk0XvUrVworHyflvV6MOj7A
         rOkxZ2Hjz5Qb1ZidyuLesmbpMMXSnEUs+JBoBL4Q+qk7kXyTW+7qpifQdCbMeuDlnItu
         z3XH6jJxyB9Xyj0k/KUbTfr5VKoNFMvXycthdbfVUdLmOw/KuluI4Lx5Y57lyCljbRSm
         JtTg==
X-Gm-Message-State: AOAM533v1PV+dV/OxHbiAlT99Ok0mfsURqAooWeobmwUMsdscisQ5oPP
        SjFI7DsyBR17gTL0ws85Ex90txv2BjpJ
X-Google-Smtp-Source: ABdhPJypSTqVIhACI9kly9fX3B232d+eFwjWyTs5qD1DSZMHTPN6mdxgwMfzjntV8dxGw28BlSvR4g==
X-Received: by 2002:ad4:5c8f:0:b0:456:3dbf:f58e with SMTP id o15-20020ad45c8f000000b004563dbff58emr18132546qvh.37.1653331469287;
        Mon, 23 May 2022 11:44:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:71ba:8ad9:40cd:d364? ([2600:1700:e72:80a0:71ba:8ad9:40cd:d364])
        by smtp.gmail.com with ESMTPSA id y76-20020a37644f000000b0069ffe63228fsm5168527qkb.121.2022.05.23.11.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 11:44:28 -0700 (PDT)
Message-ID: <acc3c765-7476-ae00-1546-f6cc07fb5c75@github.com>
Date:   Mon, 23 May 2022 14:44:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH] setup: don't die if realpath(3) fails on getcwd(3)
Content-Language: en-US
To:     Kevin Locke <kevin@kevinlocke.name>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
References: <80eeba2b2a58af2a5497f398beb5c03447c41f61.1653003552.git.kevin@kevinlocke.name>
 <CABPp-BH+=zd_ZpPMy=S5Q-ygTW85ZXD9-RLOk9Apt_Q1_SgzzA@mail.gmail.com>
 <Yoji02YhO+sE817q@kevinlocke.name>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Yoji02YhO+sE817q@kevinlocke.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/21/22 9:02 AM, Kevin Locke wrote:
> Thanks Elijah and Junio,
> 
> I appreciate your reviews.  I agree with all of your suggestions. I'll
> send a revised patch that incorporates the suggested changes shortly.
> 
> Cheers,
> Kevin
> 
> 
> On Fri, 2022-05-20 at 17:14 -0700, Elijah Newren wrote:
>> On Thu, May 19, 2022 at 4:39 PM Kevin Locke <kevin@kevinlocke.name> wrote:

Hi Kevin,

Welcome to the Git mailing list!

One minor thing to keep in mind is that we try to avoid
top-posting.

A few other things that were mentioned in this v1 would
be noticed by reading a few documents in the tree:

 * Documentation/CodingGuidelines
 * Documentation/MyFirstContribution.txt
 * Documentation/SubmittingPatches

There's A LOT in there, so we all forget some of the
things some of the time.

Thanks,
-Stolee
