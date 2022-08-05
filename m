Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0546AC19F2D
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 15:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240950AbiHEPJm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 11:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240713AbiHEPJl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 11:09:41 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B30019C03
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 08:09:40 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-10ee900cce0so3237864fac.5
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 08:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=JvGbtjdm1xxxFcXA0bDAvCiRDITal/3cIfaD6aTHuKw=;
        b=JUgNd9EKG3n0YJtrC5iB631209IBk06EC4ToGfWxupOFoJDiaWXCHWjRRuXnwW9ZtO
         1V0vK3tzcRxUytUDWZ2YcHYs+/pkUwre33diOkuzIwurwdNdHQTNi1gAwBfnvaX+fXQr
         1iSQjLLh0qN1l1ZfBYOd97mWGpe2YNPAd1g6c3hrcWnvpPlk6Q1iCPO3KedRVzuirx5e
         374NUGkwMKh9M3A0jpixf/poUelDa0zIaBVJsuAAg24OWYh9czI4YDmXd62eaayYd0Fu
         sFY3cXfTeIYRWx/PoUCbEzB/UMhlpFf+oHlMe5urWJIXsWEQOiXHjdBMDG/rs+jlJ7bY
         w5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=JvGbtjdm1xxxFcXA0bDAvCiRDITal/3cIfaD6aTHuKw=;
        b=PeWSMP9mvfDQIYVyH13Vw3HGLG4nZYr1vZqodfq7OgWZkh0H7A8Z3RZtZFDKCqdCnX
         5uJShFNDA5RWB7Phgedsvt9dw4Yd6R4iTpXz8hs5GlXyIXyFHT0ufljg3IIm4u95wwCB
         vas0K0vwCTWmmMteGm5N22JpEm96c7WmBY84hAlx78GhUR22GKCNXNyjlDThO0rg5M8Q
         jFGSGPkwKbeRzsSURhgpCYQHrnFn2P9KkyCPl/BK2o/3IHYVvJ40m4yehvPqglSkRIcT
         4GwnVKgnWCSRNXkW90u0EBLMiGCYyBtu+OhnvhDb6rSs8NmZtyk+HyYH5AM8kIMgN192
         wldw==
X-Gm-Message-State: ACgBeo0Bw/8BPqb2sqb0Igon5Bki4A1GIM8JKqPfsIbMOxNKN3/bqJ7g
        I51hn7UXhHCAW35lgDP4I7Lf
X-Google-Smtp-Source: AA6agR63XNN6qsfM4WcDHVD0ffpxqY8rKwVFpSs9EGqJaqaa809Y7Xz0G6g07IuO8Fc8VXXn2urOGA==
X-Received: by 2002:a05:6870:311b:b0:10d:96:733a with SMTP id v27-20020a056870311b00b0010d0096733amr6773612oaa.190.1659712179983;
        Fri, 05 Aug 2022 08:09:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3928:8f07:23c6:89bf? ([2600:1700:e72:80a0:3928:8f07:23c6:89bf])
        by smtp.gmail.com with ESMTPSA id h17-20020a056870171100b00101bc3380a5sm731128oae.12.2022.08.05.08.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 08:09:39 -0700 (PDT)
Message-ID: <2184ffe4-4fde-878f-052f-e7dcdebe8161@github.com>
Date:   Fri, 5 Aug 2022 11:09:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 06/10] log: add default decoration filter
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com, steadmon@google.com
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
 <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
 <bec532fb8c63b3ae784d442f438687a4f0bbad37.1659122979.git.gitgitgadget@gmail.com>
 <220804.86iln8e9hl.gmgdl@evledraar.gmail.com>
 <ac7b3a81-7ca6-05d3-6633-4204066aa933@github.com>
 <220805.86zggirb7b.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220805.86zggirb7b.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/5/2022 10:50 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Aug 05 2022, Derrick Stolee wrote:

>> Now that this version removed the notes ref from the
>> decoration, the stance for inclusion is simple:
>>
>>   If Git offers to color the namespace with color.decoration.<slot>,
>>   then Git decorates with that namespace by default.
> 
> I'm a bit confused, sorry.
> 
> So aside from "notes", if we have a color.decoration.<slot> applying to
> a ref now, it's a bug in your series if it's not showing up anymore?

The possible slots are:

 * branch (refs/heads/)
 * remoteBranch (refs/remotes/)
 * tag (refs/tags/)
 * stash (refs/stash)
 * HEAD (HEAD)
 * grafted (refs/replace/ or GIT_REPLACE_REF_BASE)

These are exactly the namespaces that are now shown by default in
this series.

If someone adds a new color slot, then that would need to be
justified with a reason why that slot is important. We've already
had discussions as to why showing a decoration for notes is not
valuable to an end user. The stability of this config option (the
last addition of 'grafted' was in 2011) is good evidence that this
core set of namespaces is all users will need.

By contrast, the use of "hidden" namespaces is relatively new and
is expected to increase in the near future.

-Stolee
