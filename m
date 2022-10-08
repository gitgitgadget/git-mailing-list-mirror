Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E208C433F5
	for <git@archiver.kernel.org>; Sat,  8 Oct 2022 09:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiJHJhG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Oct 2022 05:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJHJhF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2022 05:37:05 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C05D28735
        for <git@vger.kernel.org>; Sat,  8 Oct 2022 02:37:04 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so5541080pjl.0
        for <git@vger.kernel.org>; Sat, 08 Oct 2022 02:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w+Vqf62EXtkch5clvLrHSqkd1o/G48XCJKNYvJIJI7A=;
        b=dlSuLRfRWhc9ni75ZcUg4bsTRrwLKybb+KUcffvwX5DJ12Vror/Ade/41DxDclthHV
         EtBwzRvgzT0IVc5Zjvors/EIfPOcVWWYgyP20gpuD62hAs47MB5wk554pgiZRqLC5wJe
         CdnrOE95ZwzEyWfVzF7v7V0H1KhiEEvbbleJ8amNHRl8GqTaqlDxtc6YUZi+d/wJTzGY
         CxsJ0gDhNzmJKZtc93EEBY7f6sK3MGD6Lq5Fr7lp3bWpu7a9I2XTrtT1OzCWszU/GWrZ
         eSXCXEXayU694tXAg+tV0LWSb80VfBg9zjsSNNpV4WeMbWQMkqxBKcknUv6gsQfCQfER
         Yg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w+Vqf62EXtkch5clvLrHSqkd1o/G48XCJKNYvJIJI7A=;
        b=tWGdYzLWmLz5/aX10nty9KlQvA8y/M/QVu6/oSMPXtywtVqFGx89CubGwlCE046ath
         sRZyzY8zEgWXuL+9GiMBz3TQE45puJeZREntHqYWf3fa18zlxuoeN8O8mMeKEtDDgzn6
         Xsk+3T92CpmsCIO2OXJ1I06LxbB54ula2YloWUiKqKyxmZtA3CSPgbBZfADeCfD7w+od
         rj0VOGpVE8OvuZ+v7vp7mjGOWZY3MGSyaJhtF53Pt+P2KwihG0/yFWEqBMBQ84tfhKYW
         D5wjLKU0eIJWmi3d8LwUNdwFYU3NSPMQP73XcOcecHB/PTrNTopB9dDDlV2H6lPT3AhX
         rSEw==
X-Gm-Message-State: ACrzQf2fMSCCtzqzTPeD+4XNW3CWSumK2P8427WKh1wV6KmevlKIM4vF
        qGOnh329zvjrlsA6+T/c4uQhVfY9fTU=
X-Google-Smtp-Source: AMsMyM7V09dOQ/c+CqC8ydken1NhNt+wkjld0kSUqUFBkE0OhbTdVzwDD+COuF31u0qktH4BLBYN5g==
X-Received: by 2002:a17:90b:1c11:b0:20c:d721:8813 with SMTP id oc17-20020a17090b1c1100b0020cd7218813mr1806200pjb.244.1665221823437;
        Sat, 08 Oct 2022 02:37:03 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-18.three.co.id. [116.206.28.18])
        by smtp.gmail.com with ESMTPSA id y2-20020aa79e02000000b005604c1a0fbcsm3059406pfq.74.2022.10.08.02.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Oct 2022 02:37:03 -0700 (PDT)
Message-ID: <0b44cdca-3115-e09e-70c8-6f56101c3d9c@gmail.com>
Date:   Sat, 8 Oct 2022 16:37:00 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] symbolic-ref: teach "--[no-]recurse" option
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>
References: <xmqqleprcn08.fsf@gitster.g> <xmqqsfjzaq78.fsf@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <xmqqsfjzaq78.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/8/22 11:34, Junio C Hamano wrote:
> Suppose you are managing many maintenance tracks in your project,
> and some of the more recent ones are maint-2.36 and maint-2.37.
> Further imagine that your project recently tagged the official 2.38
> release, which means you would need to start maint-2.38 track soon,
> by doing:
> 
>   $ git checkout -b maint-2.38 v2.38.0^0
>   $ git branch --list 'maint-2.3[6-9]'
>   * maint-2.38
>     maint-2.36
>     maint-2.37
> 
> So far, so good.  But it also is reasonable to want not to have to
> worry about which maintenance track is the latest, by pointing a
> more generic-sounding 'maint' branch at it, by doing:
> 
>   $ git symbolic-ref refs/heads/maint refs/heads/maint-2.38
> 
> which would allow you to say "whichever it is, check out the latest
> maintenance track", by doing:
> 
>   $ git checkout maint
>   $ git branch --show-current
>   maint-2.38
> 
> It is arguably better to say that we are on 'maint-2.38' rather than
> on 'maint', and "git merge/pull" would record "into maint-2.38" and
> not "into maint", so I think what we have is a good behaviour.
> 
> One thing that is slightly irritating, however, is that I do not
> think there is a good way (other than "cat .git/HEAD") to learn that
> you checked out 'maint' to get into that state.  Just like the output
> of "git branch --show-current" shows above, "git symbolic-ref HEAD"
> would report 'refs/heads/maint-2.38', bypassing the intermediate
> symbolic ref at 'refs/heads/maint' that is pointed at by HEAD.
> 
> The internal resolve_ref() API already has the necessary support for
> stopping after resolving a single level of a symbolic-ref, and we
> can expose it by adding a "--[no-]recurse" option to the command.
> 

The example case above is from recent Git releases, right?

I think the wording should instead use generalized version numbers.
For example the still maintained release tracks are X.Y-1 and X.Y,
but now X+1 have been tagged, which creates X+1.Y track.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
