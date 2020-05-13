Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FD2CA90AF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 10:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4F10206D6
	for <git@archiver.kernel.org>; Wed, 13 May 2020 10:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvNQuzmm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732934AbgEMKGq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 06:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732723AbgEMKGq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 06:06:46 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4E5C061A0E
        for <git@vger.kernel.org>; Wed, 13 May 2020 03:06:45 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h17so11232126wrc.8
        for <git@vger.kernel.org>; Wed, 13 May 2020 03:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TlQwwDCSyOt/RCbpYBAKQV3oVwKAtZAOkAay5fbJGNs=;
        b=bvNQuzmmu5g7mKu4dY2VNSOwB1x5IrdvAxw0hVRQIf7e2auTtGr3SrZxQE7HVlZHu1
         gqqYmKyyM8gzj+qC40dV7B4VlktZfZboDOzVVD0ghk5AXlTQHtGU2aSYfwetthrRwk0B
         dSxP3A/qFnIX41q8k3U3XfJOIbpz6QaIO9pRQ4XkovTKXTT6+j3NaJi94dEjitTKkT3g
         h9VhoedQQLtX110Do889NYQyF+9fjZMeZ/wbPsCwAmZ/JipHP+Bxa2Mueu6GOTRfr6CS
         PKue9Nq9+Nwi3q1NsgxrCib7mtG7JSx7Sbcc9gJ6102MxVRUYFHn75PVvwSQOmxslOSu
         6e9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TlQwwDCSyOt/RCbpYBAKQV3oVwKAtZAOkAay5fbJGNs=;
        b=BbmA6xBjvOIu5JfUIael9UyifMsBEQ1kVSTrr8Ask0BG4dm1Mdmo2BzgI5J23y9Qn7
         QUai275M3HgOm/uf23POQaUTVJ+IqjOpI+soh3ZeJtR4XQ8X8klLg3rmGGUdVfAzp4ku
         oRogE+K6Shbfib9ZWdB+zeaz9b3ddZzmM0P72Tu+6c6780QsTQwIo1dRjFrOP2Zp+lpJ
         ++uflLdvkg4BkTCcvM1YkUeFswt84ucV62yQsabk1JbSdn6YYcaQOgOChwTdk2/JEzun
         bcZacNNgUR3K1k5Y50xln3eYkcs0jgmkKEwN+3yt3dgBRT4jVpsHgJ+/5Owc7+kj7Cyg
         i4Xw==
X-Gm-Message-State: AGi0PuaRU+IlIoIt5XCd6/rcGKD7v1wu++ZhISwRj1YzvDqryjpORRNs
        zz7NUJTDp9BQ7iZPKKyniZk=
X-Google-Smtp-Source: APiQypJaIMukIWHM441wzTkGZ9W+xLZCHSaSJmp9REZ95rGw22RUkSyre6SRRxJIGdEfgLTny/XiTg==
X-Received: by 2002:adf:f102:: with SMTP id r2mr29518412wro.316.1589364403922;
        Wed, 13 May 2020 03:06:43 -0700 (PDT)
Received: from [192.168.1.201] (155.20.198.146.dyn.plus.net. [146.198.20.155])
        by smtp.googlemail.com with ESMTPSA id v20sm29927815wrd.9.2020.05.13.03.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 03:06:43 -0700 (PDT)
Subject: Re: [PATCH v13 07/13] Write pseudorefs through ref backends.
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
 <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
 <2c2f94ddc0e77c8c70041a2a736e3a56698f058c.1589226388.git.gitgitgadget@gmail.com>
 <cd06245f-4717-3695-9550-0d8c4244725a@gmail.com>
 <CAFQ2z_Ptuu14G-UOVfDnGsG6-EwUH-XdBp8HTw_zuHML5aMsQA@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <c78e3022-0145-74e7-99b2-614fa422835b@gmail.com>
Date:   Wed, 13 May 2020 11:06:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFQ2z_Ptuu14G-UOVfDnGsG6-EwUH-XdBp8HTw_zuHML5aMsQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/05/2020 17:48, Han-Wen Nienhuys wrote:
> On Tue, May 12, 2020 at 12:22 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>>       if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
>>> -             assert(refs == get_main_ref_store(the_repository));
>>
>> I don't think you meant to delete this line, the equivalent line is left
>> untouched in the next hunk and there are comments in refs.h saying this
>> should only me called on the main repository
> 
> yep. - Whoops. Fixed.
> 
>>> -struct ref_storage_be refs_be_files = {
>>> -     NULL,
>>> -     "files",
>>> +struct ref_storage_be refs_be_files = { NULL,
>>> +                                     "files",
>>> +                                     files_ref_store_create,
> 
>> The formatting has gone haywire
> 
> This was clang-format's automatic reformatting. I've looked a bit
> closer, and it was reformatting because the initializer list was
> missing the ',' on the final entry. I've added that now.

It sounds like we need to look at the clang format rules we use, I think
the original code is correctly formatted in this case (we've only
allowed trailing commas relatively recently), it shouldn't need changing
(which clutters up the patch with unrelated changes) just to satisfy
clang-format.

>>> +     NULL, NULL,
>>
>> Should the wrappers above that invoke these virtual functions check they
>> are non-null before dereferencing them? It would be better to die with
>> BUG() than segfault.
> 
> Done.

Great, I did wonder after I had sent the email if it would be better to
implement the BUG() in the virtual functions in the packed-refs backend
to avoid the check overhead in the other backends but it's probably not
worth worrying about.

> 
>> I think this patch basically works but I'm concerned by the potential
>> NULL pointer dereference. While it's unfair to judge a patch by it's
>> formatting the changes to the formatting of existing code and the
>> dropped assertion rightly or wrongly gave me the impression lack of
>> attention which does make me concerned that there are other more serious
>> unintentional changes in the rest of the series.
> 
> I prefer leaving formatting up to automated tooling. They're better at
> following mechanical rules precisely.

Right but in this case the changes completely obscured the important
changes. What really raised a flag for we was that two definitions of
the same structure where reformatted in completely different ways - I do
use clang format but I also sanity check the results before submitting a
patch.

I was looking at our use of git_path_cherry_pick_head() in sequencer.c
(I mostly work on rebase) the other day, there are quite a few places we
rely on CHERRY_PICK_HEAD/REVERT being a file, I suspect we probably do
the same in wt-status.c and builtin/commit.c. The uses are generally
    file_exists(git_path_cherry_pick_head())
which I think we could just change to use get_oid()
We also unlink() it in several places which we could replace with
delete_ref() but we blindly call unlink() in some places so the ref
might not exist.

In the sequencer we always use the refs api when handling REBASE_HEAD, I
haven't got round to checking builtin/rebase.c and builtin/am.c for that
yet.

Is there a plan to handle FETCH_HEAD with reftable? git rev-parse will
parse the first oid in the file which is handy if you've only fetched a
single ref, but the file itself contains several lines like

2407200be2a37bfca57ea1a9474318822fec49b0		branch 'git-alias' of
ssh://pi/home/pi/git

It might be special cased in the refs code already I haven't checked

MERGE_HEAD also contains multiple lines for octopus merges but I'm not
sure if people really need to run rev-parse on that.

Apologies if the FETCH_HEAD and MERGE_HEAD points have already been
covered elsewhere, this thread has got quite long.

Best Wishes

Phillip
