Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BC8C4743C
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 18:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62DD56108D
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 18:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFDSnx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 14:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhFDSnx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 14:43:53 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B64DC061766
        for <git@vger.kernel.org>; Fri,  4 Jun 2021 11:42:07 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id t140so5425351oih.0
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 11:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mFfw008ffzxa8UMlLljTi8ktf1aGUL1KHRe6HuGOOUk=;
        b=UpvHL2XiTixrOJklOmhQJJR0qnJH2AgXj/0DdOefnr0T7+o7xIE4/bWVOB/L6NnGz9
         rsg0DZdVZE779rOtCpsAerIhFA0HA0HHoJvM+wRDUdr8WxEBmyA0roYG4OYhQL2LeK7Q
         +nxbuSGbccF6wxfoBoxj+vL6ElVV9Q3/XBYgMJmIa4pV7iCNLShgYrhDMwyd6Od5LUIX
         QwuvQEvbgXP/LUMVT7ZlEDjh8PF0wCuW3pX2jZea+Qdvw/YsWD/fLiDBtlE2BwRE7iNw
         2NiC+hmKT+bfF+CjpY64ZvdNgRP9Za5uBOL7Q41/9K82obS64h1zUfgtNrTM77vQyA3z
         hLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mFfw008ffzxa8UMlLljTi8ktf1aGUL1KHRe6HuGOOUk=;
        b=jo50HPFpQDvp7mTMgEl6gy/YjoD0FbWeeApghtswpSQs1iNDtUwrBaHCIl2Ta5NUsA
         iITQEWfwjl9Tlk2fXzEyFKUKAdrs71VU6LS0ytTOA82ArfFwt/FzKJeDWexb/gaAdblr
         1ATVW4HmXqz6JHsKe17U4yyIbPzA/M5DE9TfwUWZy43A7uetXBSaWx1+evRKM4oWnjsD
         RcObobMmSPnNWDcCLJWEqtsi6gcxROuKkUmgjBnqrRNDwN7SmdVeVqQP0j4ryU6UEmbz
         KXDJz/6JR4zd7rq16D+Pj/UlzDYua9Opdh5hHOi+yv1skdzz7q9SOyMIAbfUssNIXQOs
         8YwA==
X-Gm-Message-State: AOAM530EZtUL0Jxju9H+7XFbDgRFQQz/hzHQng03f3euZ2fv/DjLNlu6
        hcUgFmuY0yAPpQz5Afj/zCQ=
X-Google-Smtp-Source: ABdhPJygqVPgnvU2DJAjvRhxWAzZibP9bkrwp35DLvpwAwhacNI8BRVudEIe/ScP/2Li9o6tinustQ==
X-Received: by 2002:a05:6808:209b:: with SMTP id s27mr3911351oiw.77.1622832125477;
        Fri, 04 Jun 2021 11:42:05 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:a8e5:75e1:b132:878d? ([2600:1700:e72:80a0:a8e5:75e1:b132:878d])
        by smtp.gmail.com with ESMTPSA id q26sm636716otn.0.2021.06.04.11.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 11:42:04 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] Optimization batch 12: miscellaneous unthemed
 stuff
To:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <pull.962.v2.git.1622559516.gitgitgadget@gmail.com>
 <pull.962.v3.git.1622781578.gitgitgadget@gmail.com>
 <a5755340-c0c8-8028-7c03-3c8e7f0268d1@gmail.com>
 <CABPp-BEsiw-E9_TGUDaGEkhQHNqLH48=ZTu7yXX7XqRaM2JdOQ@mail.gmail.com>
 <YLpWbLkaqVYqTrGL@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c9d596f3-cfc9-4bb7-1008-4873dafd8270@gmail.com>
Date:   Fri, 4 Jun 2021 14:42:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YLpWbLkaqVYqTrGL@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/4/2021 12:35 PM, Jeff King wrote:
> On Fri, Jun 04, 2021 at 08:48:21AM -0700, Elijah Newren wrote:
> 
>>>>           Signed-off-by: Elijah Newren <newren@gmail.com>
>>>>      +    Acked-by: Derrick Stolee <dstolee@microsoft.com>
>>>
>>> I believe the sign-off should always be the last thing in
>>> the message. Perhaps Junio is willing to fix this without a
>>> re-roll?
>>
>> Interesting, this is the first I've ever heard of such a requirement,
>> and I've submitted patches this way numerous times and have seen
>> others do it.  A quick search through git.git history says there are
>> 5133 commits that place such trailers before the author's
>> Signed-off-by, and 1175 that place them after.  While the former is
>> clearly more common, and some of the latter could have been Junio
>> adding trailers while applying the patches, there still seem like
>> plenty of counter-examples suggesting that there is no rule here.
> 
> I don't think there's a hard rule here. The usual advice (which I also
> didn't find documented from a quick grep, but hopefully is kind of
> intuitive) is that trailers should be chronological.
> 
> So if you picked up a patch from person X who signed off, then you
> modified and signed off the result, then Junio signed off after
> applying, we'd expect that chain of custody to be represented by reading
> top to bottom. And that's what happens if you use "am -s", "commit -s",
> etc.
> 
> Whether "Acked-by" happens after the author signs off or not is
> debatable. Obviously it happens after the version of the patch that is
> sent out. But if you re-send with an Acked-by, is the signoff your one
> from before that happened first, or a new one that happened as you sent
> out the patch? Perhaps a question for the philosophers. ;)

I guess I was just interpreting that the "Acked-by" was part of
the content you created, and hence it should be covered by the
sign-off. I can imagine that if Junio added it, then it would be
after your sign-off but before his.
 
> Anyway, I think it is perfectly fine either way (as your numbers
> indicate).

I agree. I didn't mean to make a big deal of it.

Thanks,
-Stolee
