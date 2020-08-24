Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7EDC433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 17:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAD8720738
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 17:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFZ0VagD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgHXR3U (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728382AbgHXR2w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 13:28:52 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEC1C061573
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 10:28:51 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c19so6575174wmd.1
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 10:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qRcv8NUznSCr5PCsYNx842k4kkgFc1i8zJUgf02Y2z8=;
        b=OFZ0VagD9g+gdzvqAWW3RpnOmIujzUBi/gbdjDIPGyh+hd7CbJHPPiF3xHIPRDo47w
         S4eRinRlo1Dt9IvqTzgZtCBzKxoy4M0D+emNGD261BmfyBlukcXQj3V8Su3Y2Qtxx6pC
         bAqJB9Pi3LtDXxLGQHVLFuejXrjLHvpK943jmBT1UCMG4lbOmVm0ALSXhy3xFbZK7aIK
         OmrcOS8q4St49njrwqtkFzfi35CNT3z9ho/d3JSgtuANwAmGBfBH1Js8OUFRzGGPctsK
         CVwB9VdX9DjCmHVS+qKWUXqGlpS+eXZ0lfOP6EAoXHqDWSARdvd8q3hhFGG6g9NeLwZp
         o3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=qRcv8NUznSCr5PCsYNx842k4kkgFc1i8zJUgf02Y2z8=;
        b=DJ0H6Kk71Y5uXohVXUiWB8ROEwUd6yULh6witpU92Q7iG4oSfqy9BN44kfb0oq+WHF
         AOAX9gOiNzUt1ae4V13nOGUOjJWQGcephfvzWM3yoaXbUD1G/7j/KmRPJQRty9tMzV53
         97yeaxOKFltJbC+4c9QEyXXVYwGsdaWTv1btD7PhMKMhWlBGvsXmV/eGX5DnSJpadcLt
         krjAUFdBXANq9/nrhVEcTHn2BiaULJC/u3ODAXkxBf1YPNQIEQ0+VeoYNhjLQx4Tw0Gm
         71EEz7HgCzlUYTnMjd7pwKaDx3ABSdJ/fPwzx8sjMudBzieAjN9Xufu5j7UYXFSFPfKz
         MHnw==
X-Gm-Message-State: AOAM532gnyCNjrhv2YuiZnBypTPR5M8zNJokbnqbXDoxiuwpG+FfYvl1
        3do5MXpzTmjXAhkgzz9WLUCd6+uzTbg=
X-Google-Smtp-Source: ABdhPJxVGwSiCW6/9oRYG1bGCVrAmC86mN24IFUIbujg5CEuNOMU58PZ4oVz7sz3vZU2SE5WCL2S0A==
X-Received: by 2002:a1c:24d5:: with SMTP id k204mr277262wmk.159.1598290126186;
        Mon, 24 Aug 2020 10:28:46 -0700 (PDT)
Received: from [192.168.1.240] (125.22.198.146.dyn.plus.net. [146.198.22.125])
        by smtp.gmail.com with ESMTPSA id b202sm450252wmd.29.2020.08.24.10.28.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 10:28:45 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git add intent-to-add then git add patch no longer allows edit
To:     "Raymond E. Pasco" <ray@ameretat.dev>, phillip.wood@dunelm.org.uk,
        Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Sullivan <tom@msbit.com.au>, git@vger.kernel.org
References: <C55D662I6OBC.4J2O3KP58DJ2@ziyou.local>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <fe21c773-341c-d029-077c-00daeb6014f7@gmail.com>
Date:   Mon, 24 Aug 2020 18:28:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <C55D662I6OBC.4J2O3KP58DJ2@ziyou.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Raymond

On 24/08/2020 17:23, Raymond E. Pasco wrote:
> On Sun Aug 23, 2020 at 12:03 PM EDT, Phillip Wood wrote:
>> I think I was talking about edit rather than split. I'd forgotten that
>> it used to work with i-t-a additions. I just checked seen and it seems
>> to be working again since dscho's patch although the user is presented
>> with the full diff header rather than just a hunk header in the editor.
>> As you say once the user has staged some part of the diff the rest falls
>> out naturally.
> 
> Which topic is this? I can't find one where it works (it's always
> "Sorry, cannot edit this hunk" on seen 2.28.0.508.g7d1bebc7fe).

The patch I was referring to is 2c8bd8471a ("checkout -p: handle new 
files correctly", 2020-05-27)

I tested seen at 3981657b13 ("Merge branch 'rp/apply-cached-doc' into 
seen", 2020-08-21). I was using the C version of 'add -p' which is 
opt-in at the moment by setting add.interactive.usebuiltin=true in your 
config (or with git -c). I hope that helps, I'm going off line now for 
10-14 days

Best Wishes

Phillip

> Yeah, it's split that would be a problem, edit just stages and moves on.
> Split would be nice, but I don't actually recall it ever working before
> - it doesn't work now on diffs from actual blank files. Getting edit
> back (if there's a topic that does this already) makes it work for my
> usage.
> 
