Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654B0C00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10AAE2225E
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOXr60+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgKBSfd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 13:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgKBSfc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 13:35:32 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763C2C0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 10:35:32 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id j5so7251655plk.7
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 10:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8lnUvANkvXszBa83sR027PaeVwfzPYpi+r5dHC123OE=;
        b=UOXr60+LIv61HGqOIReVFwzNJOUibxfE/26DnQ0rPBlOxN+hlMf+X87n2g/u6LYdJ7
         K3KlL6WFyGjLY4X8fKEp2bTj3AzRVkWy1y4Yr+YMY5D22cF3GSkqVNeTcu4uXPVX7diV
         bA/n/yIxugmaLTBdjSGmRaeDyK74vebtmnPR7gxaFpxYMBhcuSrxKDHvIxeYOLXm/KrC
         029sQUSVoHEds2LGUg5Ra+XHQhcnMCt2KlXsZ0HDuvoF9uHzhXmQO5DuuOK8Aoqz7yw5
         mB2v6zhMyP/DRc0TKYHVEKgtMHPnrKaamR7xKE7yW2gf8wsFWxRVUZn88Nn3KAsqK2Nm
         0OOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8lnUvANkvXszBa83sR027PaeVwfzPYpi+r5dHC123OE=;
        b=eHbV2SDIktkYgabjj0zwSH8oBRbcYSmy76GPOhXV06kh1WqTLQZl725+jaxGx3peDY
         WUcNJKbLjobwl5yyPHaY05I0HOKD7761vb+VYDGnzJBGxlggxn17NacHh5se4B0v5mvi
         9MXir3VSivj21s2mV2d0fpJZDQ3WI9nmPm+LVe1ChNhkqMTqPBFRkl4Vw7hdMQvIB7m4
         r2pLVcLUbxHnlVUDzkN93IuwnEyKTZfK+9XVlUX/UDsev2lpBR3FyTgiYPQdvMsG5iF+
         9dGktc5eau3gQHevIwfbcsFzT71+CRVRZjYRGTggY0wSbCrjcRg3PC6D/2Y7cv/JgaTi
         tCaQ==
X-Gm-Message-State: AOAM530Um+n9Hi+Lj4bxZvhmNPjcCr/P1yH8Cfao9gAM2JA0gdT/zvmX
        QeubY9whggvByhQuVqfhkguWN7aGMko=
X-Google-Smtp-Source: ABdhPJwsQvywO+z/8o/mKc/y7UL1Ygr43x3bUw31I3f0tNRLsw3I7oFHFmID8uEkeubCQ2gT9l25oA==
X-Received: by 2002:a17:902:8608:b029:d4:c459:f1e8 with SMTP id f8-20020a1709028608b02900d4c459f1e8mr21695286plo.36.1604342131753;
        Mon, 02 Nov 2020 10:35:31 -0800 (PST)
Received: from [192.168.208.42] ([49.205.87.94])
        by smtp.gmail.com with ESMTPSA id gc17sm168085pjb.47.2020.11.02.10.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 10:35:31 -0800 (PST)
Subject: Re: [Outreachy][Proposal] Accelerate rename detection and the
 range-diff
To:     Elijah Newren <newren@gmail.com>
Cc:     Sangeeta NB <sangunb09@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>
References: <CAHjREB6Hh+urW3j2c9p45ZudSdDv0rUP28Lb4e4TZasqTzRmDA@mail.gmail.com>
 <CABPp-BF3MEAkJmmLv_0fWBJV_2AMqh_8P7Dqk62c2_Uz9Pa3Lw@mail.gmail.com>
 <6dfa865d-cb32-47fa-b9b4-fe3901a0cf63@gmail.com>
 <CABPp-BE7+9_AiYCP+m7TOY85d4FWHG4rORk16Z6bsnAWxVPwCg@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <af22d119-7ab9-d49e-279c-c912786098dd@gmail.com>
Date:   Tue, 3 Nov 2020 00:05:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BE7+9_AiYCP+m7TOY85d4FWHG4rORk16Z6bsnAWxVPwCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On 01/11/20 2:01 am, Elijah Newren wrote:
> 
> On Fri, Oct 30, 2020 at 2:02 AM Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
>>
>> Thanks for the detailed concerns. Some thoughts:
>>
>> - Given that a major portion of the project would be to evaluate
>>     various algorithms and identifying the most suitable one, I believe
>>     implementation conflict shouldn't be a problem as it's expected to
>>     start only by late-January. Also, as Christian pointed out elsewhere
>>     it might be a good learning experience.
> 
> "late-January" _might_ be okay, but I'm worried that relying on
> optimistic timelines is a bad idea.  However, if the primary purpose
> is a good learning experience, or if the primary purpose is to
> evaluate different algorithms (i.e. we're not relying on the timelines
> to avoid conflict, it's just a bonus if they don't), then sure, no
> problem there.
> 

Yeah. I believe a good part of this project would be evaluating the 
various algorithms. Implementation would be a part of it, sure. I don't 
think it would be too time sensitive, though. So, I hope we can work 
through the timelines as the project and your work progress.

>> - I do have a concern about one thing, though. For evaluating the
>>     algorithm in the context of Git, we might need to do some experimental
>>     implementations to get some metrics which would serve as the data that
>>     we could use to identify the optimal algorithm. I'm  wondering whether
>>     your planned changes might affect that. In the sense that, is there a
>>     chance for the evaluation to become obsolete as a consequence of those
>>     changes? If yes, what could we do to overcome that? Any thoughts on
>>     this would be helpful.
> 
> That is certainly a possibility, yes.  One way to address that concern
> is for me to freeze some branch (likely some version that I deploy
> internally at $DAYJOB for testing), and for you to build on that.  If
> all the new merge backend code gets reviewed and upstreamed fast
> enough, and the areas you depend on don't change too drastically based
> on reviewer comments, then building on merge-ort creates no
> impediments for the Outreachy project to get upstreamed at the normal
> time.

Thanks. That does sound like a good way to overcome that problem. We can 
discuss more about that once the intern is selected and their internship 
period begins.

> I can understand, though, if that plan seems worrisome due to
> worries about how fast the new backend will be upstreamed or how much
> it needs to change in the process; that is, after all, why I raised my
> concerns in the first place.
> 

Which indeed is very helpful for planning the project. Thanks for that! 
Its pretty clear now that closely following your work and adapting the 
timeline accordingly as time progresses is a part of the project. That 
might indeed be an interesting experience in and of itself for the 
intern who would be working on this project.

-- 
Sivaraam
