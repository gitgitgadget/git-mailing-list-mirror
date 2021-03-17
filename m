Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10B7C433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 19:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 805E464F30
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 19:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbhCQTzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 15:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbhCQTzU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 15:55:20 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C85AC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 12:55:20 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id y131so183439oia.8
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 12:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Com8Y3dqVnHux0C2Vw3YK5gcLUhqNaJiyfIDU3vpezk=;
        b=ERVlQWqMhpIUW6xQvPCtsfPfilBmBaF1iX9oW2xCXI9pq8r9FiOfDYEuFAOPtmlrvZ
         RNNoSatz6MpFC12VE3IZvHwqzIvBiMBrGAx3rIAdRLl2iL/jzRn5TnEv+CPq58H/aj5e
         PbtUTDAxiTecZHhBonKJ7JX2NsSCMH25s1fovgxLYYfLvHgnPdiYgaCaf2mIE6lqBSFf
         0IBkVWfIud7PfzIqr7zhlXH0L2sLSjE4sjJNiQVAyqRnZXCL6Zuzl31qoE7epX1NKvSx
         7ehZMXpEL1EOYmWURF/og7LpToP2snapnzhKKuHsM92z6MKXfLLHg7+1x+Nc6YNwCMat
         XSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Com8Y3dqVnHux0C2Vw3YK5gcLUhqNaJiyfIDU3vpezk=;
        b=mhzuWkPJfJ0HEUqqPOo/896xu6QdTB/FORkCyOg/c5e8tOujYBbfs02w4jnsiOMF+k
         BHFd6HQKlo6q40DPSnJ3jfCRqzKisx2izfvwYdhEDjYwy1KLENO06ej+1Y4qdhsbvC0+
         8v5O6CQQpT8JyVjdtbz9McMxn3PvGzr+KL3FurK2zVPMJq/5t108KAqEU3z3LTx/r+cR
         poZ3/UsaRuBtrYqMoFQmJ0CW6ykgJ2rJn5XD3W/MKAme/m/jE8ikxKfKwyAKDHzIkIJ8
         SovZhr9DkCHQISVVJjFFBaixYDEClxAILpnRdJDG3UbwCgiJbYf4OmPebzgBgWCXuKXm
         gsrQ==
X-Gm-Message-State: AOAM5334Opn+2oD5OrHMDakP8Dh2iJTrYN/HU/eQevDwQFOcVQLVCcTM
        IsuKs7bER2E2o8xBVvwWSc4=
X-Google-Smtp-Source: ABdhPJyOLBEdGbK6vdixSu588HsvXhRrLjbvFjh6Clo9qTbw0ViLFgGr+1zDzSzwXFQUVnUsEh0p1g==
X-Received: by 2002:aca:c6d5:: with SMTP id w204mr383890oif.54.1616010919486;
        Wed, 17 Mar 2021 12:55:19 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:5df9:6440:37ca:197f? ([2600:1700:e72:80a0:5df9:6440:37ca:197f])
        by smtp.gmail.com with ESMTPSA id o197sm6854ooo.44.2021.03.17.12.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 12:55:18 -0700 (PDT)
Subject: Re: [PATCH v3 11/20] sparse-index: convert from full to sparse
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        pclouds@gmail.com, jrnieder@gmail.com,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
 <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
 <e41b14e03ebb143c874cc276adcbc36059f0c64e.1615912983.git.gitgitgadget@gmail.com>
 <87wnu5zyif.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1de9bc8a-b0fd-596a-3ae2-2e055b37534b@gmail.com>
Date:   Wed, 17 Mar 2021 15:55:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87wnu5zyif.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/17/2021 9:43 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Mar 16 2021, Derrick Stolee via GitGitGadget wrote:
>> @@ -251,6 +251,8 @@ static inline unsigned int create_ce_mode(unsigned int mode)
>>  {
>>  	if (S_ISLNK(mode))
>>  		return S_IFLNK;
>> +	if (mode == S_IFDIR)
>> +		return S_IFDIR;
> 
> Does this actually need to be mode == S_IFDIR v.s. S_ISDIR(mode)? Those
> aren't the same thing...
> 
>>  	if (S_ISDIR(mode) || S_ISGITLINK(mode))
>>  		return S_IFGITLINK;
> 
> ...and if it can be S_ISDIR(mode) then this becomes just
> S_ISGITLINK(mode), but losing the "if" there makes me suspect that some
> dir == submodule heuristic is being broken somewhere..
 
I have a vague recollection that I did that at one point, and
it didn't work. However, using the simpler

	if (S_ISDIR(mode))
		return S_IFDIR;
	if (S_ISGITLINK(mode))
		return S_IFGITLINK;

passes all of my tests.

Looking at the history of create_ce_mode(), this "||"
condition was created in this commit:

commit 9eec4795d44439cd170fb52c73827c728252648d
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Apr 9 21:14:58 2007 -0700

    Add "S_IFDIRLNK" file mode infrastructure for git links
    
    This just adds the basic helper functions to recognize and work with git
    tree entries that are links to other git repositories ("subprojects").
    They still aren't actually connected up to any of the code-paths, but
    now all the infrastructure is in place.
    
    The next commit will start actually adding actual subproject support.
    
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
    Signed-off-by: Junio C Hamano <junkio@cox.net>

There isn't any justification of why S_ISDIR() is there. Perhaps
it was defensive programming? If that is the case, then this simpler
logic will work.

Thanks,
-Stolee
