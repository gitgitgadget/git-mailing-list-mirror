Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FE4C433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 18:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB14020659
	for <git@archiver.kernel.org>; Wed, 13 May 2020 18:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="trpC1Z/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733144AbgEMSKt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 14:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732488AbgEMSKs (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 14:10:48 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A039C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 11:10:48 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j5so632707wrq.2
        for <git@vger.kernel.org>; Wed, 13 May 2020 11:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=epUOpZssMyRk8dZIoqUwicMQRiQwpMPISsw/0lq5QAI=;
        b=trpC1Z/J/99A6wQel82NiEyzZp55bA9pFq417822u7umGYu+AbkUQm6fLz2UjxworO
         HSR/E/UawVn8fi9Vvu5a+YBQya9v3xyMDNHQbEA+5Dadzxlxhlw5OVbDqv/MOwbidEU5
         0XH0dXKlIssTQ0zVaSKhTjS8aaXnx7aO4Ly8f40rMpkUTxrgfI6573LDBBJLdHfTI15q
         ekGz+tLl7VdLQhu1uk6315xegRG9N2fseADc1gG/QvcGcwTwhpCw2dSbRk4ohfb/P71s
         a3ikQ3fU0sBzDbsqYj740sqbD6MP5fIZPCVu6O/xo1QwUWTSocN8+flkNNA3LR+YMoMH
         elxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=epUOpZssMyRk8dZIoqUwicMQRiQwpMPISsw/0lq5QAI=;
        b=oPY1fiatUabMQdYB4PxGkmLte3sZCUcu6xD/hsPoozuDavbblsMORirPoBZEeik1eH
         sNmPNYKgQcTpJNvTEBNe5wKZ0iA/ddTDhY17dxhfUey5DDMVqaukJAhlN/ZRefhkyvRj
         GeprnO0WZ3RQPamBw1LXozPvA+yaEAyjYqWlWXZHSI6OG2zac1URA1+cedmfVuV8Edki
         T1gmSb7ODJq/SQNepBhVHJ1xRRKrRlgEX2l7Qdkf+tPUh+rFbPMHf4Fq9Js5ppa5bCZJ
         sPjskS2Ps37SR4DC4RA3nGQFNmF/wgeVDcDJW6NxKsvl7jQflZyPvfAbLT7m8W6bxqe2
         Pjgw==
X-Gm-Message-State: AOAM533NV58R/l83QJhHCNl5o2Ygp6Ywx8sFnE5K35Ae1IhucqojjLCU
        JKavf7onIa0U1RngOGSd/DtTK6UF
X-Google-Smtp-Source: ABdhPJxW6Sq4ZMiLYDyats57ayBik6sgJdD0EFEw6q6GPms37fJjs+8Vn9h2ELmLV/YUATIFOiNl+w==
X-Received: by 2002:adf:b30f:: with SMTP id j15mr645119wrd.394.1589393446966;
        Wed, 13 May 2020 11:10:46 -0700 (PDT)
Received: from [192.168.1.201] (155.20.198.146.dyn.plus.net. [146.198.20.155])
        by smtp.googlemail.com with ESMTPSA id r14sm12852298wmb.2.2020.05.13.11.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 11:10:46 -0700 (PDT)
Subject: Re: [PATCH v13 07/13] Write pseudorefs through ref backends.
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
 <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
 <2c2f94ddc0e77c8c70041a2a736e3a56698f058c.1589226388.git.gitgitgadget@gmail.com>
 <cd06245f-4717-3695-9550-0d8c4244725a@gmail.com>
 <CAFQ2z_Ptuu14G-UOVfDnGsG6-EwUH-XdBp8HTw_zuHML5aMsQA@mail.gmail.com>
 <c78e3022-0145-74e7-99b2-614fa422835b@gmail.com>
Message-ID: <b7bab271-be96-f52e-5512-b836f3632ff8@gmail.com>
Date:   Wed, 13 May 2020 19:10:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <c78e3022-0145-74e7-99b2-614fa422835b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/05/2020 11:06, Phillip Wood wrote:
> On 12/05/2020 17:48, Han-Wen Nienhuys wrote:
[...]
>>>> -struct ref_storage_be refs_be_files = {
>>>> -     NULL,
>>>> -     "files",
>>>> +struct ref_storage_be refs_be_files = { NULL,
>>>> +                                     "files",
>>>> +                                     files_ref_store_create,
>>
>>> The formatting has gone haywire
>>
>> This was clang-format's automatic reformatting. I've looked a bit
>> closer, and it was reformatting because the initializer list was
>> missing the ',' on the final entry. I've added that now.
> 
> It sounds like we need to look at the clang format rules we use, I think
> the original code is correctly formatted in this case (we've only
> allowed trailing commas relatively recently), it shouldn't need changing
> (which clutters up the patch with unrelated changes) just to satisfy
> clang-format.

I spent some time trying to fix the clang-format rules this afternoon
and got nowhere. Searching the web revealed plenty of questions but no
useful answers beyond "add a trailing comma" and it's not even clear to
me if that works all time. It is a shame clang-format does not seem to
support a fairly common way of formatting structure initializers. That
the formatting changes so much based on the presence or absence of the
trailing comma is really confusing and unhelpful.

Best Wishes

Phillip

> 
>>>> +     NULL, NULL,
>>>
>>> Should the wrappers above that invoke these virtual functions check they
>>> are non-null before dereferencing them? It would be better to die with
>>> BUG() than segfault.
>>
>> Done.
> 
> Great, I did wonder after I had sent the email if it would be better to
> implement the BUG() in the virtual functions in the packed-refs backend
> to avoid the check overhead in the other backends but it's probably not
> worth worrying about.
> 
>>
>>> I think this patch basically works but I'm concerned by the potential
>>> NULL pointer dereference. While it's unfair to judge a patch by it's
>>> formatting the changes to the formatting of existing code and the
>>> dropped assertion rightly or wrongly gave me the impression lack of
>>> attention which does make me concerned that there are other more serious
>>> unintentional changes in the rest of the series.
>>
>> I prefer leaving formatting up to automated tooling. They're better at
>> following mechanical rules precisely.
> 
> Right but in this case the changes completely obscured the important
> changes. What really raised a flag for we was that two definitions of
> the same structure where reformatted in completely different ways - I do
> use clang format but I also sanity check the results before submitting a
> patch.
> 
> I was looking at our use of git_path_cherry_pick_head() in sequencer.c
> (I mostly work on rebase) the other day, there are quite a few places we
> rely on CHERRY_PICK_HEAD/REVERT being a file, I suspect we probably do
> the same in wt-status.c and builtin/commit.c. The uses are generally
>     file_exists(git_path_cherry_pick_head())
> which I think we could just change to use get_oid()
> We also unlink() it in several places which we could replace with
> delete_ref() but we blindly call unlink() in some places so the ref
> might not exist.
> 
> In the sequencer we always use the refs api when handling REBASE_HEAD, I
> haven't got round to checking builtin/rebase.c and builtin/am.c for that
> yet.
> 
> Is there a plan to handle FETCH_HEAD with reftable? git rev-parse will
> parse the first oid in the file which is handy if you've only fetched a
> single ref, but the file itself contains several lines like
> 
> 2407200be2a37bfca57ea1a9474318822fec49b0		branch 'git-alias' of
> ssh://pi/home/pi/git
> 
> It might be special cased in the refs code already I haven't checked
> 
> MERGE_HEAD also contains multiple lines for octopus merges but I'm not
> sure if people really need to run rev-parse on that.
> 
> Apologies if the FETCH_HEAD and MERGE_HEAD points have already been
> covered elsewhere, this thread has got quite long.
> 
> Best Wishes
> 
> Phillip
> 

