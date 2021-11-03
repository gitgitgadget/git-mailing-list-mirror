Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583A1C433EF
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 11:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DB8A61151
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 11:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhKCL0J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 07:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhKCL0H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 07:26:07 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620EFC061714
        for <git@vger.kernel.org>; Wed,  3 Nov 2021 04:23:31 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u1so2971984wru.13
        for <git@vger.kernel.org>; Wed, 03 Nov 2021 04:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JnaZD2yh34aEdcKjr+8kaH2bAwmVxgOjf/syIXih82c=;
        b=S+Ykaajkvg8c4MrUYZzGxK461wFHGnB3K5qY+aHv9Dsg3ElQitynpxE/5aKcf9DN41
         XQjF6FyAwsSlkIvmROWLltIZJCH+P5DoDVYzmlD72bt3nvTYaws7MJLPLfhY+e4/qjyt
         F9AhPuvq7zW3xnQyZY/qHv9yoxxeLvl9r9Yjjjx6ojSY58t8nlIzzRGDyOHSGTR7SKgS
         Wzlm3YfWQ2enjLhCfvF3Wh99qh2Vq0TKsFSxuqoHUCzueGJsqeg/vcApv48QQGFo3aHC
         4jdvKgqPoM3XOv7IqkJEUTajzanJK+X02RTh9DJCEvg/0dbprItTJGBrMxAlYw0rePBg
         AC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JnaZD2yh34aEdcKjr+8kaH2bAwmVxgOjf/syIXih82c=;
        b=FsmSUGhp4wyWS80izVB5IcmV3AiEfprzXfP/y8nKfSUQgBIlBhvzX3ZzuD306xlGF0
         joBc/NOTxTN1WDchHOCB5yDHA4GFoM9s0t5QQmC0FMZDK+X+9k/oVkzf6/jfgmJ9AgA3
         dbn4nHUn4P/UQo72G4SEOrYWPDrxHfF17pTTMZhWyuLqYpeVpEG39QYtB15TZKTs+5il
         BhS20e34bYsgQZmdUHcQ0XXCu2iiWBYImeFa+eZX/DmVRRizImZHzCX8WWFh3X5rvJjb
         1juXy5KC9SXPxu+aCWFu7crjRIdT5EVordFnT1fdZBgee1OIgMl2sVaytHOxvk7ydfhZ
         41Iw==
X-Gm-Message-State: AOAM531qV2MUm//40hQOAqMdgGJeEk5A5MEwcjEcSE1DFmFxnP5QrvVI
        soZIaTKcLqGH1ClGbz1nG5A=
X-Google-Smtp-Source: ABdhPJzIf83GdIiABX4xuOwQWFy28Iwha8TTcOR16Hwfhrs4LyxkK0qEydj3KlMMr4xVDssc8aLKlQ==
X-Received: by 2002:a5d:6da2:: with SMTP id u2mr7272007wrs.273.1635938609925;
        Wed, 03 Nov 2021 04:23:29 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id x21sm5050645wmc.14.2021.11.03.04.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 04:23:28 -0700 (PDT)
Message-ID: <101071b2-0b7d-5ee8-ca81-171e08a1ffdf@gmail.com>
Date:   Wed, 3 Nov 2021 11:23:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -i: fix rewording with
 --committer-date-is-author-date
Content-Language: en-US
To:     Jeff King <peff@peff.net>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Jonas Kittner <jonas.kittner@ruhr-uni-bochum.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1123.git.git.1635883844710.gitgitgadget@gmail.com>
 <YYG8aq85UmMMVW4l@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <YYG8aq85UmMMVW4l@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff

On 02/11/2021 22:32, Jeff King wrote:
> On Tue, Nov 02, 2021 at 08:10:44PM +0000, Phillip Wood via GitGitGadget wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> baf8ec8d3a (rebase -r: don't write .git/MERGE_MSG when
>> fast-forwarding, 2021-08-20) stopped reading the author script in
>> run_git_commit() when rewording a commit. This is normally safe
>> because "git commit --amend" preserves the authorship. However if the
>> user passes "--committer-date-is-author-date" then we need to read the
>> author date from the author script when rewording. Fix this regression
>> by tightening the check for when it is safe to skip reading the author
>> script.
> 
> That description makes sense, and the patch matches. Not being that
> familiar with this area, my biggest question would be: are there are
> other cases that would need the same treatment? And is there a way we
> can make it easier to avoid forgetting such a case in the future?

I don't think there are any other cases (but then I thought that when I 
wrote the buggy patch...). The only time we change the authorship is if 
the user passes --committer-date-is-author-date or --reset-author-date. 
I agree it would be good to have a way to avoid this problem in the 
future but I haven't come up with an easy way to do that. One 
possibility would be to go back to always reading the author script. 
That would mean revisiting the changes to do_merge() in baf8ec8d3a so 
that it always writes the author script and .git/MERGE_MSG but removes 
them when fast-forwarding (the problem that baf8ec8d3a tried to solve 
was a left over .git/MERGE_MSG when do_merge() fast-forwarded) I don't 
want to do that in the rc window though.

>> diff --git a/sequencer.c b/sequencer.c
>> index cd2aabf1f76..ea96837cde3 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -997,7 +997,9 @@ static int run_git_commit(const char *defmsg,
>>   
>>   	cmd.git_cmd = 1;
>>   
>> -	if (is_rebase_i(opts) && !(!defmsg && (flags & AMEND_MSG)) &&
>> +	if (is_rebase_i(opts) &&
>> +	    ((opts->committer_date_is_author_date && !opts->ignore_date) ||
>> +	     !(!defmsg && (flags & AMEND_MSG))) &&
>>   	    read_env_script(&cmd.env_array)) {
>>   		const char *gpg_opt = gpg_sign_opt_quoted(opts);
> 
> This conditional is getting pretty complicated. I wonder if a helper
> like:
> 
>    if (is_rebase_i(opts) && !needs_env_script(...))
> 
> might help, but I guess it needs a funky array of inputs (defmsg, flags,
> and opts). So maybe it is just making things worse.

As you say it needs a lot of inputs so I'm not sure how much a function 
would help. I did consider changing it to

         if (is_rebase_i(opts) &&
	    ((opts->committer_date_is_author_date && !opts->ignore_date) ||
              defmsg || !(flags & AMEND_MSG)))

but as we're in the rc phase I decided to leave the existing condition 
alone.


>> +test_expect_success '--committer-date-is-author-date works when rewording' '
>> +	GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
>> +	(
>> +		set_fake_editor &&
>> +		FAKE_COMMIT_MESSAGE=edited \
>> +			FAKE_LINES="reword 1" \
>> +			git rebase -i --committer-date-is-author-date HEAD^
>> +	) &&
>> +	test_write_lines edited "" >expect &&
>> +	git log --format="%B" -1 >actual &&
>> +	test_cmp expect actual &&
>> +	test_ctime_is_atime -1
>> +'
> 
> This test make sense (I had to look up what "-1" means for
> test_ctime_is_atime; it's passed to git-log to decide which commits to
> look at).

Yeah I had to check what the -1 was for when writing the test, maybe we 
should change the helper to add the '-' for us once 2.34.0 is out.

>> +test_expect_success 'reset-author-date with --committer-date-is-author-date works when rewording' '
>> +	GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
>> +	(
>> +		set_fake_editor &&
>> +		FAKE_COMMIT_MESSAGE=edited \
>> +			FAKE_LINES="reword 1" \
>> +			git rebase -i --committer-date-is-author-date \
>> +				--reset-author-date HEAD^
>> +	) &&
>> +	test_write_lines edited "" >expect &&
>> +	git log --format="%B" -1 >actual &&
>> +	test_cmp expect actual &&
>> +	test_atime_is_ignored -1
>> +'
> 
> And this one I guess is covering the --ignore-date cut-out in the code?

Yes

> I think it would pass even without it, as that is just noting a case
> where we _don't_ need to call read_env_script().

That's right.

> But I don't know if
> there is any user-visible effect of accidentally calling it when we
> don't need to (my impression is that it's just a performance thing).

There should not be any user-visible effects from reading the author 
script when --ignore-date is given but we don't need to read it in that 
case so I opted not to.

Thanks for your comments, are you happy for this to go in as is or 
should I look at simplifying the conditional?

Phillip


> -Peff
> 

