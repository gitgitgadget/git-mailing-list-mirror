Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E911CC7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 17:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239007AbjDZRaq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 13:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbjDZRad (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 13:30:33 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3678D83E2
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 10:30:25 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-54fbee69fc4so85250517b3.1
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 10:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1682530224; x=1685122224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WAPpAU6ucya1DrIekqMBILhCiXpHh8irqjcGrODyYeQ=;
        b=SpDD5XiPvQ2o2Y0Ydbp7Z9v6Iw/vU/EciphR+7zlLt1LCiLpwTb/fGTBSIoz4TMUpN
         Q3kPZ5V0kzOmaBWx85NbN9l7IMbRGZiujW/jogTlyyg6RMRnfBw/pUApHvOb2j72gC42
         eowqWitx1l/zbzGjfvqdn5XX/3j0RJOeGWMu5MBXyufLzTanSPIi5mVtjAk3x9pjEDQi
         cNfhdvNXh8CxAf+WZiCP3Lq8wrd79xfakPDcBZgFx7aOTKD5PDoamUNDHoj2ZT687r/X
         NLFdV2aVFg1pddpdZLkF/uHpqujHrcg+CNL3k1bDxht1Q2OC8xL6q6bu/ajdNSaDjk2e
         deRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682530224; x=1685122224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WAPpAU6ucya1DrIekqMBILhCiXpHh8irqjcGrODyYeQ=;
        b=WH974A1cy1Tndcgl48GTHKAtCZkChThFU2NFUEcFJ438BGDfFsUYnIN2vnaEjfsOq7
         CN9ZAqJhHSQxNkVxtuJYn61n3qnKoV81lRAsaIAC5vugCxHd8kC4el19ZLpS8iXG8D+h
         mn6fQMIYQZsyZQyh0FJwGRxkZyRXMsG7fNfdBmqAHpDe2YjOP5Gb7NitZU/UFLMZQcnG
         hBg1UCNzFFx4OnhrUpY1c+vZ04ZfFwERGp8fTt7XvQS0uMA6J1OyoFgYaoSFhn/iTrXQ
         A8gAHBXwAsFKyMFV+Xf+PM8p/LC40u5HEeKSK6KP2ELQNISE5LmmGcBQHma6eSp2VEIy
         oY2w==
X-Gm-Message-State: AAQBX9eRVuEgePXwI4y6gG+BHIJFizJdHGi2TT4JkQ1BNCAyBXccmexs
        gZpV5YQBYJvOgU1yZGzLlivoH3zFxahe2nXDzQ==
X-Google-Smtp-Source: AKy350YakdAGaaK7g7NoHme7udFgziWp02bvWZ0EnlAF3LMHhILVdm+dFuyBq9RN0f4dRdkbmc6hMA==
X-Received: by 2002:a81:a549:0:b0:54c:1405:2ce with SMTP id v9-20020a81a549000000b0054c140502cemr13985561ywg.49.1682530224380;
        Wed, 26 Apr 2023 10:30:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f1c4:1a6:d1a6:59da? ([2600:1700:e72:80a0:f1c4:1a6:d1a6:59da])
        by smtp.gmail.com with ESMTPSA id n64-20020a817243000000b005569567aac1sm2366535ywc.106.2023.04.26.10.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 10:30:23 -0700 (PDT)
Message-ID: <49695ce0-b9f9-0fc7-ed16-093dc7f12b7e@github.com>
Date:   Wed, 26 Apr 2023 13:30:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/2] negotiator/default: avoid stack overflow
To:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <hanxin.hx@bytedance.com>
Cc:     git@vger.kernel.org, xingxin.xx@bytedance.com,
        jonathantanmy@google.com
References: <cover.1682473718.git.hanxin.hx@bytedance.com>
 <cover.1682513384.git.hanxin.hx@bytedance.com>
 <0e69d70805e6da684e6e17642a1cf0d59a03dfc0.1682513384.git.hanxin.hx@bytedance.com>
 <xmqqedo6tvkj.fsf@gitster.g>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqedo6tvkj.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/26/2023 1:14 PM, Junio C Hamano wrote:
> Han Xin <hanxin.hx@bytedance.com> writes:

>> +		if ((commit->object.flags & SEEN) && !(commit->object.flags & POPPED))
>> +			ns->non_common_revs--;
> 
> Hmph, this is a bit unexpected to duplicate the non_common_revs
> counting logic here.  In the original, this piece of code was there
> just after we decided to continue digging into the parents, and even
> if this patch changes the mechanism with which "digging into the
> parents" from recursion to priority queue, it is not obvious why we
> can keep doing the decrementing for the current commit we are
> looking at, instead of doing that for parents of the commit like
> this patch does.  In other words, it is not clear why it needs to be
> changed while going from recursive to iterative.
> 
> Is it because ancestors_only is not usable inside the loop in the
> iterative version?  That is, if ancestors_only is not set, we do
> paint the initial commit as COMMON just as the parents we discover
> in the loop, but when ancestors_only is set, we need to skip painting
> the initial commit as COMMON, so the patch moves that logic?
> 
> It may solve the issue of special casing the initial commit, but it
> feels backwards in that the resulting loop becomes harder to
> understand by making it necessary to process the initial commit
> outside the loop only halfway.

The "ancestors_only" parameter is about treating the initial commit
differently than the ancestors. Since we add the initial commit to
the priority queue, the only way to know we are dealing with an
ancestor and not the initial commit is to do the processing when
visiting a parent for the first time.

> It may make it easier to understand if we had another local
> variable, "struct commit *skip_commit", that is NULL by default but
> is set to the initial commit when ancestors_only is set,

This is an interesting idea and could reduce the duplicated logic
for nw->common_revs.

> and do the
> painting with COMMON and counting of non_common_revs all inside the
> loop for the current commit that is being processed (instead of the
> parents the loop discovered).  I dunno.  It would avoid duplicating
> the logic and implements the "ancestors_only, do not paint or count
> the initial commit" in a more readable and straight-forward way, no?

However, we need to do the painting with COMMON when visiting a
parent in order to avoid adding duplicate entries to the priority
queue (and potentially growing exponentially).

Since we need to examine and modify a parent before adding it to
the queue, it is natural to do other "we are visiting a commit"
logic in that same place.

It is unfortunate that the logic for nw->common_revs is duplicated,
but I think this is a cleaner approach than other considered
approaches.

Thanks,
-Stolee
