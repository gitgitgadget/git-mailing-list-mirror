Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB23BC433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 10:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB92E20706
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 10:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/mgeJVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390189AbgFXKUP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 06:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388197AbgFXKUM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 06:20:12 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF48C061573
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 03:20:09 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id v3so1728433wrc.1
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 03:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rpnt1W8exLtQo2ouGZHTIZAXBBwB0Aw0c+l2VJ337+s=;
        b=s/mgeJVTjcG+9zofHtVK0cgSQAAVqiAuG4fNIvbiecA8OJgIfDekWODofzOLQo8Kab
         E6yE0zVteqdkW2Zyqhj68mjUWe5zrOQ7qBH4f6i5biAD1HlPEo0R2mpWcPA5Cj3+ZXXq
         RrXQNR8tqQbl5qAYSkVbBm8r0md7rLr2JM98ZPyIBFzJaW06voSQlwwSwovlmomws5o0
         IHp3ecyuBaUkf5FYdHSzg7HbVOQjB7soMbjLP/7JH3Q3fX39TE7uH4YQIKsKlmj8OgBy
         MqpJk3G+iQwP5HmZGx58w6hu8DAR/ZRIcno/YgxuHcMXgX0ZjL57Pqs5m4lsSVyCra9b
         KUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rpnt1W8exLtQo2ouGZHTIZAXBBwB0Aw0c+l2VJ337+s=;
        b=Dq86fihlFYuWLzK+KarTzHav2661MVOK+OMKK1dXVyh9DLs0cNayeHMMHNCQN6LqmO
         f+O6CRke4fmU5ETXWYO2VKJs9JRNYIiyesXGyGwpEmV+t0sPT1wmCEJkjJSBuV2ivTl7
         WkNXI1IXNFM2Cxe2QRk92mNOOS8AvUie/H3tCVyQQFtJiHT2fCCG2kOsSNX/uBOnuanu
         Y/2yNP6PGuGl1TdcL5a8gxSSsQkdD6VvB28DkPwDlmPcHr3ZSVWoo2q7DzT1y1haygXa
         uIyIDm+Bz0ux2JjIzSgtqXsNNsOtRfYbtlXA3m2r7HZRgIwzbtx7TQ0oFm9SM8OApj9F
         Fj3g==
X-Gm-Message-State: AOAM531pRjq8JSMhCUWjm3TtiNxtESXCE/N/z7IsZPgIC/q6VhD+289v
        E0msiP7zougo7O8acY4s3EI=
X-Google-Smtp-Source: ABdhPJyY4vXaPrHCL8Lbf9ScZW17z0L2Q2nA3EvYY/Pv3v+KVIQAuvRxjPBwDrrR+rYpPBrtRwqJbg==
X-Received: by 2002:a5d:5341:: with SMTP id t1mr32182690wrv.207.1592994008275;
        Wed, 24 Jun 2020 03:20:08 -0700 (PDT)
Received: from [192.168.1.201] (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.googlemail.com with ESMTPSA id z9sm7235637wmi.41.2020.06.24.03.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 03:20:07 -0700 (PDT)
Subject: Re: [PATCH v2] checkout: teach --worktree
To:     Denton Liu <liu.denton@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <d10cb03dd8ce00cb6033c61ff9b9b30bbf5f9c89.1592058281.git.liu.denton@gmail.com>
 <2a434d328429907a304ad6aaad4c1d9261d27831.1592124367.git.liu.denton@gmail.com>
 <3c223d33-7f3f-7f4c-df91-3b72271308cd@gmail.com>
 <20200623155538.GA2014954@generichostname>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <dd17f82a-f5b3-d57e-d296-c1b5ecc8c1f5@gmail.com>
Date:   Wed, 24 Jun 2020 11:20:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623155538.GA2014954@generichostname>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

On 23/06/2020 16:55, Denton Liu wrote:
> Hi Phillip,
> 
> Sorry for the late reply.
> 
> On Tue, Jun 16, 2020 at 05:01:53PM +0100, Phillip Wood wrote:
>> I'm afraid I'm not sure that adding another option to `git checkout` is a
>> good idea. The behavior of `git checkout` is already complicated enough
>> which is why we ended up with switch and restore separating out branch
>> switching from file updating.
> 
> I think that since this option clearly applies only for a
> restore-type action and there are checks in place to ensure that
> the user is not attempting to use it for a switch-type action, it
> doesn't introduce much more complexity than the `git restore --worktree`
> option does.

It introduces more complexity to checkout by existing. The point I was
trying to make was that checkout is complicated to use and adding more
features makes that problem worse. As to being obvious that it applies
to a restore-type action, when I first saw the patch subject line my
immediate thought was that it was going to be doing something with
worktrees.

I am worried that people will think 'checkout --worktree' is the same as
'restore --worktree' but it isn't it's the same as 'restore --overlay
--worktree'. Having subtle differences like this between commands is
confusing for users and wastes our time answering queries about the
difference on the mailing list. It is not possible to make 'checkout
--worktree' imply --no-overlay as that would be inconsistent with
'checkout <pathspec>'

> 
>> Given `git restore` provides a way to update the worktree without touching
>> the index I'm not convinced we should be further complicating `git checkout`
>> especially as it defaults to --overlay unless -p is given which is confusing
>> in itself.
> 
> I don't think it'll hurt to provide more than one way of doing it.

I disagree, it is confusing to users if they see one person saying "use
checkout" and another "use restore". They will wonder if there is a
difference between them and which one is better. It's to be expected
that there will be some overlap in functionality between commands as git
grows and adds new commands but in this case we're adding functionality
that already exists. There was a lot of thought and discussion put into
designing and implementing 'switch' and 'restore' to make more
predictable and easier for users to understand, adding more options to
'checkout' under cuts that by muddying the waters on which command
should be used.

> As a
> pretty long-time user of git, I've been having trouble picking up the
> switch/restore commands in favour of good ol' checkout due to muscle
> memory. I agree that I should try and switch over to these new commands
> but old habits die hard and I think it would be much easier to just
> provide this option to checkout.

While I have sympathy with that (I still use checkout myself a lot of
the time) it's hard to argue you have a muscle memory for an option that
does not exist!

Best Wishes

Phillip

> Thanks,
> 
> Denton
> 

