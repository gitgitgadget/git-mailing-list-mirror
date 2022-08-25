Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19420C04AA5
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 00:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiHYAjh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 20:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiHYAje (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 20:39:34 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D4085A87
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 17:39:34 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id b2so14042989qkh.12
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 17:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=QQ+QD+puBoiKrp6jWqF1iia+XDT38bW7c07UT/IQCrU=;
        b=XYiSEdeg3W2H7DbKavjagG6qk2EYMEv//2t6CavTkv2Tes8c95OuT64836wbQud3v6
         wUKCyfBEFJ+ye9ZudzEzKmf88bi5HkR0mbEe31lY5PKh0z2LJ+8YOwx5tt9Vroke6J8b
         1mzTl6atwXorw3IeM3fKpbxgTPAB3N26/tiAz66KaIe1Y2UQUuBbVoABCUDM0aaxkwE5
         203idbfUnkG4YKVMA+EJUcVP3M0qiyUw02TJdKt7vg12Kd0YrnwJabxMro8q9qc/SrYA
         lGTJyVvvt4tXJEFFLuMvRbfbBTG4J5Et0HU/RlJzJDRdiEdXe9355tEgGsRzkJc6hCzu
         m1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=QQ+QD+puBoiKrp6jWqF1iia+XDT38bW7c07UT/IQCrU=;
        b=z+/A4sp/dq6KlasL1969cUhuRKzLH/6szLTDzeVJkBEGeXCUkKxNYCtAbzg37ZNquF
         AymfFsu5dvMuoP754cb9X7CWzaM/qsyohF3g3uajTigwyrnthan9mbszw28zPVqBUxKT
         JomOyAsduu4WMyaWOIR0u/RVgYX+X/1DKAHHgiJ7i7P4Wt+0wvx2xd7yOc/DDW6VhGAo
         gBxo8FdYtzGCfhKQsc7WHL1qmQu7PkWwXauZ5oyXWIFXNznz67nv7yJv+iYixzOWn5u0
         aAOun7hC1wR67LcvlOrjOKdBqeHHYuosDmsUA4fgUft/JWwqrtPaTl5WtnP3CSuE2RkH
         g3Tw==
X-Gm-Message-State: ACgBeo3TsbhkFHKJJIa/6ZUSZhTi0A2jfKe3lWz/qNp22SKv/ohHye5f
        ZKOZM5DYZdgrgTgBSaWl79L1
X-Google-Smtp-Source: AA6agR7KSmDyI2MBHokqWsuAoJ8fgKvcMDn47pO3NcgOPsaOX6tsCoWpAWiQ3s1AV1WBg+yBLZG52w==
X-Received: by 2002:a05:620a:248a:b0:6bb:16a8:a80a with SMTP id i10-20020a05620a248a00b006bb16a8a80amr1385475qkn.619.1661387973208;
        Wed, 24 Aug 2022 17:39:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:64e6:a996:33b5:bb90? ([2600:1700:e72:80a0:64e6:a996:33b5:bb90])
        by smtp.gmail.com with ESMTPSA id j7-20020a05620a288700b006b8d9d53605sm16035783qkp.125.2022.08.24.17.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 17:39:32 -0700 (PDT)
Message-ID: <243dab1e-990e-d8da-3a75-fe1beab18db2@github.com>
Date:   Wed, 24 Aug 2022 20:39:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v1 2/2] builtin/grep.c: integrate with sparse index
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     vdye@github.com
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220817075633.217934-3-shaoxuan.yuan02@gmail.com>
 <19dea639-389a-7258-e424-4912bde226df@github.com>
 <666dc1a3-5f18-c487-6290-44b0646f5724@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <666dc1a3-5f18-c487-6290-44b0646f5724@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/24/22 5:06 PM, Shaoxuan Yuan wrote:
> On 8/17/2022 10:23 PM, Derrick Stolee wrote:
>> On 8/17/2022 3:56 AM, Shaoxuan Yuan wrote:
>>> Turn on sparse index and remove ensure_full_index().

>>> -    /* TODO: audit for interaction with sparse-index. */
>>> -    ensure_full_index(repo->index);
>>> +    if (grep_sparse)
> 
> A side note: this condition should be `grep_sparse && cached`.
> 
>>> +        ensure_full_index(repo->index);
>>> +
>> As mentioned before, this approach is the simplest way to make the case
>> without --sparse faster, but the case _with_ --sparse will still be slow.
>> The way to fix this would be to modify this portion of the loop:
> 
> I'm not sure. If --sparse here means we want to expand the index, it
> is expected to be slow (ensure_full_index is slow), isn't it?
> 
>>     if (S_ISREG(ce->ce_mode) &&
>>         match_pathspec(repo->index, pathspec, name.buf, name.len, 0, NULL,
>>                S_ISDIR(ce->ce_mode) ||
>>                S_ISGITLINK(ce->ce_mode))) {
>>
>> by adding an initial case
>>
>>     if (S_ISSPARSEDIR(ce->ce_mode)) {
>>         hit |= grep_tree(opt, &ce->oid, name.buf, 0, name.buf);
>>     } else if (S_ISREG(ce->ce_mode) &&
>>            match_pathspec(repo->index, pathspec, name.buf, name.len, 0, NULL,
>>                   S_ISDIR(ce->ce_mode) ||
>>                   S_ISGITLINK(ce->ce_mode))) {
>>
>> and appropriately implement "grep_tree()" to walk the tree at ce->oid to
>> find all matching files within, then call grep_oid() for each of those
>> paths.
> 
> Tree walking is faster, yes. So, for this approach to be faster, I
> think you are suggesting we should not expand the index, even when
> --sparse is given? Instead, we just rely on the tree walking logic,
> right?

Yes. Tree walking is a sizeable portion of the cost of expanding the
index, but we also avoid constructing the new index _and_ we can use
the t1092 tests to show that we are satisfying the behavior without
resorting to ensure_full_index(). It shows that we are doing the "most
correct" thing.

Walking trees also provides the way to speed up when focused on a
pathspec, since maybe the pathspec reduces the scope of the tree
search automatically (from existing tree-walking logic). Expanding
the index means "walk all the trees, then scan all the files" when
there might be better things to do instead.

Thanks,
-Stolee
