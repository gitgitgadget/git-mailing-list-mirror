Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C39C4332F
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 22:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiKTWKv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 17:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiKTWKu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 17:10:50 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581372612B
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 14:10:49 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id k7so8976062pll.6
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 14:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jdo01ftJ5QwUdII32D/zFWSNxuJXSfOoqRsJeJfrjZg=;
        b=MVzdxAjMThbLZtwfhUevNCnuBCZlrCxSGwyU20fAJN5xyqhhISVG+b89trmZVnXxiV
         mRuZPtiEou6ZJ2Rl93+g33VTy/7qvYSIaN2c4s1HBT1kL/0nFw8FS0fukK1ie3X82ncU
         16m6cIoiuC19FLaFakQREHO8on4AOvE+dxWGbX1pk55Mn3QtuAHfSCe1zWjIDhCGNqZK
         pVTV8eBmjR4uRcEzuvKUl+qepqwwSq9fBQ6yRx7fDR/vFjvZqzzv5uTj42sV+5XPQHKc
         KvTa2rsA5dE9MZP+IMsFL8WuL5x8aO5O2K5xylv1jB4ayGjIAzP/0Z2rwVJt4SMuUWyE
         gKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jdo01ftJ5QwUdII32D/zFWSNxuJXSfOoqRsJeJfrjZg=;
        b=U1LAvXDwleueJ3Rrub3/LqNKeE3DSdCSlEnhVkBra3WQF3l+eVHgrd1E+yyM6m7osZ
         vaG/AaKJhPy6Dd2zbLD1ohrAIVpZIvNf1nu2FNag10uNkVOBdLKz1fkQYkwaVCbybsYz
         K28DELt8BbKnp2NzOe1XTjcp+vdpycmAbNGE2jfX57JoT7RYMYeKn8EgOw64Qb8KNS4t
         Z+jzZyFo82SizrFm8PmIDZU0Z9rLNqifihusI5fv0MVcukfwF9P5OLxJiodrAQ7e+wPY
         Vl6MvZglZsRq0obf/GDPWlFQnWy22vSUmQtqRG/sMfjsyDGGC0hoYCj6zzwPpwhTD/95
         frKA==
X-Gm-Message-State: ANoB5plt9aICtTjqZfa3mInIucjJIf2EAHiS0LQQ39BCnATALVdOTKV2
        k8l4sfe5mOR7ezMxK/VfgZL0
X-Google-Smtp-Source: AA0mqf7FkiTibWrNWH5w8NbKPIBANj9pdWGv+G9OxuuMXv96IFacyXrgwpBCCKRirA3shQeE1AGJNg==
X-Received: by 2002:a17:90b:3944:b0:214:1df0:fe53 with SMTP id oe4-20020a17090b394400b002141df0fe53mr23172981pjb.214.1668982248688;
        Sun, 20 Nov 2022 14:10:48 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id w23-20020a1709026f1700b0017f637b3e87sm7658428plk.279.2022.11.20.14.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 14:10:48 -0800 (PST)
Message-ID: <87a2a095-636a-61ce-e304-e3f1dbcd74b4@github.com>
Date:   Sun, 20 Nov 2022 14:10:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH 2/2] branch: clear target branch configuration before
 copying or renaming
To:     =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>,
        Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
References: <f0b2d46c-2e9c-2630-2870-8ed550dd1606@gmail.com>
 <762c1e8f-fd0c-3b4b-94a0-709d8c9431e4@gmail.com>
 <8457ad4c-51c7-4c2d-8dbf-02a60045d288@github.com>
 <042c18df-deb6-6214-2d49-c214a872e1c1@gmail.com>
Content-Language: en-US
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <042c18df-deb6-6214-2d49-c214a872e1c1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo wrote:
> On 17-nov-2022 18:10:52, Victoria Dye wrote:
>> Rubén Justo wrote:
>> I wasn't sure whether "transfer the source's tracking information to the
>> destination" was the desired behavior, but it looks like it is (per
>> 52d59cc6452 (branch: add a --copy (-c) option to go with --move (-m),
>> 2017-06-18)). Given that, I agree this is the right fix for the issue you've
>> identified.
> 
> Yes, a reference to that commit is a good information to have in the
> message.  But I prefer to not refer to it as I don't think that commit
> is responsible or explains this unexpected result, though I cc'ed Ævar
> ;-)

It does allude the _expected_ result, though ("[-C] uses the same underlying
machinery as the --move (-m) option except the reflog and configuration is
copied instead of being moved").

> 
> The design decisions in branch.c and config.c have brought us to this
> unexpected result, which just need to be addressed. IMHO

It's helpful to reviewers and future readers to include relevant context in
a commit message; a commit doesn't need to be responsible for a bug to help
someone understand what you're trying to do and why. In this case, I needed
to search through the commit history myself to gather that information (that
is, how you decided clearing the destination first was the "correct"
approach rather than, say, preserving the destination branch's config and
not copying the source's), so I would consider the explanation in the
current commit message incomplete. 

In general, it's often not enough to "just fix a bug" without elaborating on
why something *is* a bug. This isn't an obvious thing like a 'BUG()' or
segfault, so context like 52d59cc6452 is needed to convey the nuance of the
issue.

>>> +	test_when_finished git branch -D moved &&
>>> +	git branch -t main-tracked main &&
>>> +	git branch non-tracked &&
>>> +	git branch -M main-tracked moved &&
>>> +	git branch --unset-upstream moved &&
>>> +	git branch -M non-tracked moved &&
>>> +	test_must_fail git branch --unset-upstream moved
>>
>> If I'm reading this correctly, the test doesn't actually demonstrate that
>> 'git branch -M' cleans up the tracking info, since 'moved' never has any
>> tracking info immediately before 'git branch -M'. The test could also be
>> more precise by verifying the upstream name matches. What about something
>> like this?
>>
>> 	test_when_finished git branch -D moved &&
>> 	git branch -t main-tracked main &&
>> 	git branch non-tracked &&
>>
>> 	# `moved` doesn't exist, so it starts with no tracking info
>> 	echo main >expect &&
>> 	git branch -M main-tracked moved &&
>> 	git rev-parse --abbrev-ref moved@{upstream} >actual &&
>> 	test_cmp expect actual &&
>>
>> 	# At this point, `moved` is tracking `main`
>> 	git branch -M non-tracked moved &&
>> 	test_must_fail git rev-parse --abbrev-ref moved@{upstream}
> 
> You are right, good eye.  Thanks.  That first '--unset-upstream'
> eliminates the possible undesired inherited tracking info.  Removing it
> is needed to make the test meaningful.  'rev-parse' is a good change,
> but as the test is not testing that '-M' works as expected but doesn't
> work in the unexpected way the message describes, I don't think we need
> it here, imho.

But by always having the destination branch have no tracking info, this test
doesn't verify that the unexpected behavior (that is, "mixing" the source
and destination config) has been fixed. You still need a case where the
destination config is non-empty and the source is empty (or some other
non-empty value) to reproduce the issue.

As for the 'rev-parse' vs. '--unset-upstream': making the test more precise
here doesn't increase its scope *and* makes the overall test suite more
effective at detecting regressions. And, a read-only check like 'rev-parse'
is more readable for other developers (especially if they need to debug the
test in the future), rather than needing to understand that
'--unset-upstream' is doing two things: throwing an error depending on the
presence of an upstream *and* removing the upstream from the target branch). 

In other words, it helps to separate your assertions from your setup steps.
If you still need to '--unset-upstream' for the rest of the test, you can do
the 'rev-parse' then '--unset-upstream' as two separate steps. 

> --- >8 ---
> 
> Thank you!
> 
>  t/t3200-branch.sh | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index c3b3d11c28..ba959a82de 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -218,17 +218,16 @@ test_expect_success 'git branch -M should leave orphaned HEAD alone' '
>  	)
>  '
>  
> -test_expect_success 'git branch -M inherites clean tracking setup' '
> +test_expect_success 'git branch -M inherits clean tracking setup' '
>  	test_when_finished git branch -D moved &&
>  	git branch -t main-tracked main &&
>  	git branch non-tracked &&
> -	git branch -M main-tracked moved &&
>  	git branch --unset-upstream moved &&
>  	git branch -M non-tracked moved &&
>  	test_must_fail git branch --unset-upstream moved

This change makes the test less comprehensive (by removing the
"tracked-overwrites-untracked" case) and does not solve the issue of 'moved'
always having no tracking info before the 'git branch -M' (therefore not
properly reproducing the error case fixed in this patch).

>  '
>  
> -test_expect_success 'git branch -C inherites clean tracking setup' '
> +test_expect_success 'git branch -C inherits clean tracking setup' '
>  	test_when_finished git branch -D copiable copied &&
>  	git branch -t copiable main &&
>  	git branch -C copiable copied &&
> 

