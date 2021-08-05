Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859EAC4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 10:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 529986105A
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 10:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240411AbhHEKOA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 06:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240203AbhHEKN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 06:13:58 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750B9C061765
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 03:13:43 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id c16so5755115wrp.13
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 03:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fjFnT3tFN3DDNUv4KHjTrSLRM5R8Axkx/uJ3oGXJX5Q=;
        b=eEFv5JM4okYtX+fbp8OH/zmMsWtFkJH3xdRhTUHCxT6EunMbVN4rInioUGwEpx6G1u
         HgvKCndgouDfa0Wil3EGk0H04ISG13jl4UsX7KjHK3TEQnGX3VyIWHzaWOAlbQjVEo9A
         FXkQnW0Q4yQuXuCBm0MC5m8/C6bcsMtmQPAVzfmy8QfeKEl+SCc2IFmWxsw2a6Txsaj3
         BkRMMq11k2uuiPaFLlT7SEi9RHus3wJ9LqzsrO3uZXaxUaTedfRK8ooo7SUTASPRHWeS
         D2LanY1X3Ip39Thb4Z1C6gIK9GeOeREZdbIsS9EcQbhktCGgNo3DXoqbQjHtbcECtmGP
         ADxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fjFnT3tFN3DDNUv4KHjTrSLRM5R8Axkx/uJ3oGXJX5Q=;
        b=FT+9QY35zJHzDzvDAySKrX0JhmZDEtcO3SbpTbgsOHnw3YYSLQ13aRStdSPmot4xRB
         HEPm6edmU+Nyh6N2/37aXya6addOIu5GGZY7hFNTxR2vwigwgXXjH6T+P/Cz2FaMEs0a
         B4XO5JUDpOZunukUvL6beDF5bI6Q/R3J++bYQ/m81Liq+IaAM2eYdVuw+Do+WRc61Dv4
         vcxpRQx4OoaCUDFARyHczM47hLD6HqjpazJCQJfEr6R5g8oJiAY/LJe+1UeHFf9mN6IM
         S/gSxS621qi69LNXPUZ95yBlW3jX3OEfcY5qbZbRWcgFcR6IV08xRZCvsDMt5UDse36m
         ZIVQ==
X-Gm-Message-State: AOAM532+AUloqKTBQM+GYng7GxluDOK9W7SPC5MFO9x/KuVHOI+naeqq
        K0vvbkjjPDr1UuYNxGbUhGcBU+OTJiI=
X-Google-Smtp-Source: ABdhPJyt7tBkW1uyNtHz2lwAIPRUw0vKVhkVkFSuWLDyTQVX8zbgGSeay/ZH6S5yCYDMOZ55R+a7OQ==
X-Received: by 2002:adf:ba0d:: with SMTP id o13mr4217579wrg.134.1628158422096;
        Thu, 05 Aug 2021 03:13:42 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.232])
        by smtp.googlemail.com with ESMTPSA id j5sm5437540wrs.22.2021.08.05.03.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 03:13:41 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH] sequencer: warn on skipping previously seen commit
To:     Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
References: <4d83766ab3425a5f4b361df2ac505d07fefd7899.1628109852.git.steadmon@google.com>
 <xmqqsfzonbm1.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <d3f6eb6c-f2e4-b00c-3b4c-bf1e04c846b4@gmail.com>
Date:   Thu, 5 Aug 2021 11:13:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqsfzonbm1.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/08/2021 22:28, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
>> Silently skipping commits when rebasing with --no-reapply-cherry-picks
>> (currently the default behavior) can cause user confusion. Issue a
>> warning in this case so that users are aware of what's happening.
>>
>> Signed-off-by: Josh Steadmon <steadmon@google.com>
>> ---
>>
>> We've had some complaints at $JOB where users were confused when
>> rebasing branches that contained commits that were previously
>> cherry-picked into their master branch. How do folks feel about adding a
>> warning in this case?
> 
> I'd unconditionally in support if this were done under --verbose
> option, but it becomes iffy if this is done unconditionally.

Perhaps we could skip the warning if the user is going to edit the todo 
list as they should see that the skipped commits have been commented 
out. I'm not sure about requiring --verbose - that might mean the users 
who would benefit most end up missing warning. As you say below I think 
it depends how often it appears in practice.

> This is because I do not expect everybody will stay to be ignorant
> of the behaviour of the tool they use every day, and I'd fear that
> we'd start hearing "yeah, I know the command would skip to avoid
> duplicated changes, why waste lines to tell me that?" complaints.
> 
> Having said that, I _hope_ that in a project with good hygiene, such
> a multiple cherry-picking would not be so common and an exception,
> and if my _hope_ proves to be true, then I am OK with giving this
> warning unconditionally.  The user may know what the command does
> when it sees a duplicated change, but the warning becomes about the
> presence of such duplicated changes, which would be a rare event
> that is worth notifying about.
> 
>>   		is_empty = is_original_commit_empty(commit);
>> -		if (!is_empty && (commit->object.flags & PATCHSAME))
>> +		if (!is_empty && (commit->object.flags & PATCHSAME)) {
>> +			warning(_("skipped previously seen commit %s"),
> 
> I am debating myself if s/seen/applied/ should be suggested here.
> 
> The existing text in the manual page says "a patch already accepted
> upstream with a different commit message or timestamp will be
> skipped", and "accepted" is a verb that would apply only in a
> certain workflow, which is OK in the manual page that give more
> context, but not here.  But 'seen' feels a bit too weak to me.

Yes, I think 'applied' or 'cherry-picked' would be better than 'seen'

>> +	if (skipped_commit)
>> +		warning(_("use --reapply-cherry-picks to include skipped commits"));
> 
> I'd be hesitant to endorse doing this kind of "here is how to use
> this command" unconditionally.  Perhaps under --verbose, or hide it
> under "advise.*".

and use advise() rather than warning(). I'm guess this might be helpful 
but it wont help them get their commits back as there is no way to stop 
the rebase from dropping them at that point.

Best Wishes

Phillip

> Thanks.
> 

