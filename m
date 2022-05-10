Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97724C4332F
	for <git@archiver.kernel.org>; Tue, 10 May 2022 14:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345051AbiEJO5X (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 10:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345514AbiEJO42 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 10:56:28 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E952802D9
        for <git@vger.kernel.org>; Tue, 10 May 2022 07:17:22 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t6so24050361wra.4
        for <git@vger.kernel.org>; Tue, 10 May 2022 07:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9AlE7vOhx+d2azZQZajJDArAVqXIxTFBBDZIMa0Ypl0=;
        b=Iv9C6dYREpHniJV3XF3tqkLJ645DuB4xDfxHoCMbyIAJRFcBKHbFhijiI/9N9C5ZlW
         E0Idz5sFwSvfV0w3HtqJ3xp2X1WW094469FXClfYFbZ19R/Um6LZlkgsRNHV36IYhGTO
         AmY3JbJOr1GsODHPhF41bF/CQ+IGz9K5CbguJu3/MOqVfREc0zVLqXSYlWdVjzEGXgDl
         TjU1v2QqcxGOo8OJUIKTnmOK/qT1F6iRIl9E77Au+0GCzbUZ+AU+I4zSyI5TjlM88uI/
         vUDNccTtzWoYMUGyYG4jlN74oKZyaN9h+ZmBst/iiNi//UZs3p3YvG6qu/NwanpF31qU
         Rebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9AlE7vOhx+d2azZQZajJDArAVqXIxTFBBDZIMa0Ypl0=;
        b=LfKyS2zf+M5NvTYaZocoXOQD9mCXE4bqepEPONBNHGAScOZezAtE3RSjwQOu3QkJRu
         eCl8fcoRku2aUfy5eoH2aR3wrWD5yd3XIsQhePCLs/cuu7QLT7M7FOl3Wp4abK9F8/zh
         DTcMTxGN+ovG4sNZPei3yvRv7rZZJDRVTtxCR+oQCyGIh9IzNSE49eXN2CQn/Tgw0b1p
         kixHjPYqO10wkg/DEVO5W7TpbXDQht4hUhnz772JxM4wnStroKvsOEmYK59f99Z4fbMD
         Mx1BBqJUGv8icEhVSldhItFAfoeFRTQHRcNeavwTnvcrhyLHWmWj4GAFxJUWsoGQZTrL
         ZPgQ==
X-Gm-Message-State: AOAM533iXu6et5+0vtRwHHf5D/+F+z3FZhh68w5lhs/Q7N4912EXsFFh
        eMg7fvv50HOzY7gmceWUrl4=
X-Google-Smtp-Source: ABdhPJzDnJADDsbOlwdVFl/VwsHIXrQwxGZdlFQR082m1X8/Cwn2tRUQdNnjbGTXY6oajQPPcKZjoQ==
X-Received: by 2002:a05:6000:2ae:b0:20c:57b6:32e1 with SMTP id l14-20020a05600002ae00b0020c57b632e1mr18643002wry.285.1652192240753;
        Tue, 10 May 2022 07:17:20 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id a18-20020adfe5d2000000b0020c5253d90esm2721710wrn.90.2022.05.10.07.17.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 07:17:20 -0700 (PDT)
Message-ID: <a6094881-7e63-7dc6-2fc1-7e5573cfe55b@gmail.com>
Date:   Tue, 10 May 2022 15:17:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v4 0/3] fix `sudo make install` regression in maint
Content-Language: en-GB-large
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, bagasdotme@gmail.com, Johannes.Schindelin@gmx.de
References: <20220503065442.95699-1-carenas@gmail.com>
 <20220507163508.78459-1-carenas@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20220507163508.78459-1-carenas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo

On 07/05/2022 17:35, Carlo Marcelo Arenas Belón wrote:
> A reroll for cb/path-owner-check-with-sudo with most of the suggestions
> included but planned originally as an RFC, because I am frankly not sure
> that I read and addressed all of it, but also because after seeing how
> my only chance to get an official Reviewed-by: Junio vanished I also
> realized that I wasn't been clear enough and careful enough from the
> beginning to explain the code correctly and therefore had maybe wasted
> more of the review quota this change should require.
> 
> Important changes (eventhough most are not affecting the logic)
> * Document hopefully better which environments are supported and what
>    to do if you want to test it in one that is not (thanks to dscho)
> * Removed the arguably premature optimization to try to keep the sudo
>    cache warm which was actually buggy, as it was also not needed.
>    The CI does passwordless sudo unconditionally and even when running
>    it locally it will go so fast that is shouldn't be an issue (thanks
>    to Philip)
> * No longer using the ugly and controversial variable name so now it
>    will need GIT_TEST_ENABLE_SUDO to be used to enable it on CI (which
>    is not done in this series, but a run with it enabled on top of
>    seen is available[1])
> * Stop the arguing about what is or not a regression worth fixing and
>    instead document it as one through a test, which would be easy to
>    fix in a follow up since the code was already provided by Junio

I've had a read of the patches and I agree with Junio's comments on the 
second patch. I'd really like us to avoid sudo in the tests if we can as 
it causes a lot of problems. Just to let you know I'm going to be off 
the list for the next couple of weeks, so I wont be looking at these 
patches in that time.

Best Wishes

Phillip

> Lastly I am little concerned by the fact this is going to maint but
> has a "weather balloon" of sorts, which might not be wise, since it
> might prevent people that might be affected from upgrading if they
> have a -Werror policy.
> 
> The effect is minor though, as worst case, if someone has a system
> with a signed uid_t then this "feature" wouldn't work for them and
> nothing has changed but I think it is worth to consider the alternatives
> which are (in my own order of preference)
> 
> * Revert the change to use unsigned long and strtoul()
> 
>    This will mean that people running in a 32bit system with an uid bigger
>    than INT_MAX wouldn't be able to use the feature
> 
> * Move the code out (which is indeed an artificial restriction) so that
>    we can use intmax_t and strtoimax() instead and a cast to compare the
>    uid_t.
> 
>    This avoids all issues and restrictions but means more code changes
> 
> * Throw away the custom function and expand the API ones to be used
>    instead as dscho suggested.
> 
>    Even more code changes, but maybe less risk as we will be building
>    on top of battle tested code.
> 
> [1] https://github.com/carenas/git/actions/runs/2286452160
> 
> Carlo Marcelo Arenas Belón (3):
>    t: regression git needs safe.directory when using sudo
>    git-compat-util: avoid failing dir ownership checks if running
>      privileged
>    t0034: add negative tests and allow git init to mostly work under sudo
> 
>   Documentation/config/safe.txt  |  10 ++++
>   git-compat-util.h              |  49 +++++++++++++++-
>   t/lib-sudo.sh                  |  12 ++++
>   t/t0034-root-safe-directory.sh | 103 +++++++++++++++++++++++++++++++++
>   4 files changed, 173 insertions(+), 1 deletion(-)
>   create mode 100644 t/lib-sudo.sh
>   create mode 100755 t/t0034-root-safe-directory.sh
> 
