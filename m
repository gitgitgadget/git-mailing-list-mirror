Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0B3C4363A
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 18:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B92272071A
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 18:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+v51oGD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgIUSFM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 14:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgIUSFM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 14:05:12 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BC0C061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 11:05:11 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e17so408649wme.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 11:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sg0Ny1qawsEeH2D0VO3cTC+z7wuoSsRT6MgPJU7duGo=;
        b=c+v51oGDKDH9uWL+pdSloEF8xCU2XQ+DOw+hDuAcYAIurTwXMQV9wdisbfdHBely1Q
         a/d4wJNCnKcW/DZ7PNk4CwoZ/qxO85jduBUHI5/0FmDIphbaP/K9NtM4+IdUfQxFE+06
         27ERuWolnNoZWBI288Cca42N0vsPBYDUqmPchaegGMWTfrUJi/NOnfLfPwErCcBaxAzo
         juTkvXoK6d8uAnsgpfJ/LVQz+YO0srzG1uxxwi/MCgbmxa1bOZ5itXFopogFGOuqrStw
         PLNsGV7RqK0WpeQtDqW3wU8FLGIcrmD2YRFFVKVhwhFK+JInszdZiUrXmy/NT7BaCMBR
         seGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sg0Ny1qawsEeH2D0VO3cTC+z7wuoSsRT6MgPJU7duGo=;
        b=fZCL+BaxXcYNy57dDTsTsMzrlBXZFrYUHai2TnDZBBF1s+OJbr5yamV/iGDu5GGXCd
         It7nqqw65uc8lobHK3rnJrF7AgD1F0TzZQ0IYQJGEtz2cQ2wurU3o8h+HK2fUEsGqo5d
         b8ZhPF16pkuZNVzvsPLyiZeanx3totyMIVfyXiEfn2CI1/OPRxZqsOgEkpDS1NNEUrzG
         eyl+Vi4egk3tzxEZ6AaVcS4lw0Af8N1p7fQIhS+brVfVrpS+0S8wRbHPm0e+EF91gqun
         CbDmZmJA5urJuu3zI/inxSKrdUZotDBAMiUvJW8FkQyK9soQN9mlIyjwBActtUeBhgDr
         z9mw==
X-Gm-Message-State: AOAM532Vdu23QptZJHxa5MFbJdc/X5aZWAsoEGEIn4/OSCpym6JskvxW
        LTkaqc0OYZUeJiF0N5MG6dU=
X-Google-Smtp-Source: ABdhPJx7CUXLiFAc1pGS39zlZ4JkU/PHls4KZbNOcx7yzZWtSRUNGkKXbxBAwwHUqnVy4H/1paZivQ==
X-Received: by 2002:a05:600c:22c5:: with SMTP id 5mr611027wmg.34.1600711510264;
        Mon, 21 Sep 2020 11:05:10 -0700 (PDT)
Received: from [192.168.1.201] (79.35.7.51.dyn.plus.net. [51.7.35.79])
        by smtp.googlemail.com with ESMTPSA id n66sm523262wmb.35.2020.09.21.11.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 11:05:09 -0700 (PDT)
Subject: Re: [PATCH 3/3] commit: add an option the reword HEAD
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.736.git.1600695050.gitgitgadget@gmail.com>
 <7f851e7c20aafdae5d5ae46ee1083b32ecc82c84.1600695050.git.gitgitgadget@gmail.com>
 <CAPig+cQNiB8nw-JwwFweHzeFYcozGA06pPKr=0N9Metp8PBbSQ@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <6da3752f-5e45-1381-b54c-64a81d642b72@gmail.com>
Date:   Mon, 21 Sep 2020 19:05:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQNiB8nw-JwwFweHzeFYcozGA06pPKr=0N9Metp8PBbSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric

On 21/09/2020 16:43, Eric Sunshine wrote:
> On Mon, Sep 21, 2020 at 9:31 AM Phillip Wood via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> +--reword::
>> +       Reword the commit message of the tip of the current branch by
>> +       replacing it with a new commit. The commit contents will be
>> +       unchanged even if there are staged changes. This is equivalent
>> +       to specifying `--amend --only --allow-empty` with no paths.
>> diff --git a/builtin/commit.c b/builtin/commit.c
>> @@ -1152,6 +1153,41 @@ static void finalize_deferred_config(struct wt_status *s)
>> +static void validate_reword_options(int argc, struct commit *current_head)
>> +{
>> +       if (amend)
>> +               die(_("cannot combine --reword with --amend"));
>> +       if (only)
>> +               die(_("cannot combine --reword with --only"));
> 
> Nit: It feels a bit odd (though not outright wrong) to disallow
> --reword in combination with --amend and --only after the
> documentation states that --reword is equivalent to using those
> options.

Yeah I decided to be quite strict, I'm in two minds about the 
documentation, I think it might be better to remove that line.

>> diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
>> @@ -713,4 +713,60 @@ test_expect_success '--dry-run --short' '
>> +test_reword_opt () {
>> +       test_expect_success C_LOCALE_OUTPUT "--reword incompatible with $1" "
>> +               echo 'fatal: cannot combine --reword with $1' >expect &&
>> +               test_must_fail git commit --reword $1 2>actual &&
>> +               test_cmp expect actual
>> +       "
>> +}
> 
> These error messages are subject to localization, so you'd want to use
> test_i18ncmp() here, I think.
> 
> Same comment for other new tests.

I decided to use the C_LOCALE_OUTPUT prerequisite and test_cmp rather 
than grep so I could check the exact output. I'm slightly suspicious of 
tests that just grep for an error message when that is all we should be 
showing. I should probably check that nothing is printed to stdout in 
these tests

Best Wishes

Phillip

