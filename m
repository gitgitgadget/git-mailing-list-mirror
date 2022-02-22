Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169AEC433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 16:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbiBVQiV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 11:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbiBVQiU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 11:38:20 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D83BBE3F
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:37:51 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id o24so34499916wro.3
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q8qNQfoUFB81j6hvt2QrgPevj0qO0GtmEZgO+bqQQ/Y=;
        b=JJdIA51ZLvvfBSlpt+BLpSNPp1VRofFzF0XQdsmTNP/SHkjH6+hN8qzJCHRpc0Hr0Z
         qnPC7nhTlvukMd16f/b+KWvzPhAWjO5M9M4+ZDsxONgefNZuMk8IZeDKtB1yR3msnjuR
         BST8U6iUe5ItZzH8i7xp52ILLW9XPIFz1lFD+Y9Mgss6GWhKfxFx6Wyza6bV+l+AkCnU
         LaBH7GwHC0qnvwXgiQVDrwjt54VCZ9ULTTc3aFIbZWICgySyudQLmIQJ7n5LJw1rrR2z
         +sMvKITh0mXK1XP0T6qVM23zgGZLMf0ybJl/qmizDftYRP4h2dNqo28Aq1nDm5DfqZRS
         2A4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q8qNQfoUFB81j6hvt2QrgPevj0qO0GtmEZgO+bqQQ/Y=;
        b=dh1BfkMigPi/NDW0e0+nFsHekfNMD146XgjPKro/iKnX82Na2Xzjl3L/AaCzd2Lk3E
         U7vREtV6dqiIV1S9zrc2BDousqqJYDxPGhcum1ffmvWcHzQOQ9VMaBQhnp694kZe63Ra
         Dp0jUAGDi/uh6hkjj+Lw/Te1XXaexgwU6u0Up7dqvemVMhQ5rcfGjqPOFB3htuaPOW1M
         sKJyWdXJOhQDjOUP0mliKP6umu90hAHEqmtz7ynd7XHZAFlYfq1/0dD0Ap3alRRtp6WY
         P21o5EyIrYn6nyrLK23lIJlhGrw0WxcgpgnkJgmTA+0FTJGiGidr3eCJvjGPhK6ORqhU
         BOMw==
X-Gm-Message-State: AOAM532bR/kj9tQ1Cu+vi9J59APOzUhBoKKcm8rm4lFvgSUBwCKY451a
        mYRDW5uh6TCnkEactYc3QbwgKmBc5H8=
X-Google-Smtp-Source: ABdhPJw0JpyK0Q58HbGTjx+kFE0Ih8bBqqqgSbQ7CL/W+aMrfF0zBItd47E7LpPvr+YkH1w6YBtAdA==
X-Received: by 2002:adf:ec07:0:b0:1e3:1ef2:5ff6 with SMTP id x7-20020adfec07000000b001e31ef25ff6mr20251140wrn.255.1645547870242;
        Tue, 22 Feb 2022 08:37:50 -0800 (PST)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id t1sm64996404wre.45.2022.02.22.08.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 08:37:49 -0800 (PST)
Message-ID: <3101d7c2-c78c-1f96-a7c6-08979d8f246b@gmail.com>
Date:   Tue, 22 Feb 2022 16:37:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: When rebase.autoStash=true is used, 'git pull' merge process
 still complains when incoming changes are in a different place of the file
 than local changes
Content-Language: en-GB-large
To:     Yuri <yuri@tsoft.com>, Git Mailing List <git@vger.kernel.org>
References: <efdd752b-5cff-c483-80eb-654b53fdde7c@tsoft.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <efdd752b-5cff-c483-80eb-654b53fdde7c@tsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Yuri

On 17/02/2022 20:50, Yuri wrote:
> I have a file "x" that has one local change and some incoming pulled 
> changes.
> 
> Pulled changes are contextually very far away, so it should be possible 
> to merge them without user interaction.
> 
> But git still complains:
> 
> $ git pull
> Updating 91bfe02..522ccf2
> error: Your local changes to the following files would be overwritten by 
> merge:
>      x

pull only uses rebase.autoStash if you ask it to rebase, if it is trying 
to merge then you need to pass --autostash on the command line or set 
merge.autoStash (assuming you want merge to always use --autostash).

Best Wishes

Phillip

> 
> Yuri
> 
> 
