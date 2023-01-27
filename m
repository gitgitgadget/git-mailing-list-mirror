Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1843EC38142
	for <git@archiver.kernel.org>; Fri, 27 Jan 2023 15:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbjA0PIn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Jan 2023 10:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbjA0PIj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2023 10:08:39 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8927380F85
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 07:08:32 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id m14so4779276wrg.13
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 07:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jTZ5sqX9MTPD75ISnEYwsv8A1OGhZlJ9G3gGey48b6o=;
        b=QQutwZB43etzF4bjKWmZt+p1T51GVGJArZaGWJeN4SvRm/cpelkz+Vf++YSztDKld4
         TH0MZaJYNw/e12SliF2W8Fg7Ics/8MWppSmgU2X0zM86kTRSLjA1+R6SF/upSEPOQNTM
         rZy9CInjd4X5yvvJ6Jrqx9SYaz1DigKUL+KxBmaqfPHdA2MRKG1AQIvbTXWcjFsJwk91
         BeI262mqbZt5DaivhQE2MkC36JVFXzLF4K5bd52PBqQxRcez1FdmnQVsDg2CgFBATMK+
         KvTmfAMXPtVoed9iMo33WOp24a1rO557JH8pL6pkhm2OasaHRJhlcvlwFO3cYnKPsFkr
         pp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTZ5sqX9MTPD75ISnEYwsv8A1OGhZlJ9G3gGey48b6o=;
        b=0r1Elzf+QS9B3pYampr0c6rmio/jGf9Fb7+GNawds7ngxrJDpS1Q0T/GctBTWgHG3+
         A4Xe1GhKMXuia70brBkh5nLM7TSY6QYNoLkih7vxwztA0+JpQZBUBkQP4y6ufhiigObt
         962NuellHQX7ZOsQPsbz9yu4njNnzlyKT6axXhe4zumil7GLuDHhSFX4MH0I8Nti9Kwf
         A1sVfglccR5awVbOlmp9ZXCv8XfTgFg/PFygThZMQt3egmkpG/hFASUN6VoUUBAm5OoG
         OhjemaAzaoHFm5YV2HAers4klp6iYGUBniPXavMIQrHV6zWKl0Kw3LiZOgDsh40V/F2W
         siAg==
X-Gm-Message-State: AO0yUKVOB2Z6Qr7PwqRfMPXNK0UDQr3e8TYGxfEGUWj8tahOoWInJwE8
        cZFn9iMRy9qSuIL31HJ5EeQ=
X-Google-Smtp-Source: AK7set+1pznmnsa3H2xZZv9VhMlJ0hwFuxZMm8pSFn4LfNnXi73TOZbvLkr06lyCXzHYriBOmySO7g==
X-Received: by 2002:adf:e503:0:b0:2bf:bf4c:3f8b with SMTP id j3-20020adfe503000000b002bfbf4c3f8bmr7614782wrm.6.1674832110646;
        Fri, 27 Jan 2023 07:08:30 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id q12-20020a056000136c00b002882600e8a0sm4247858wrz.12.2023.01.27.07.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 07:08:30 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <5a905a5e-1c1e-2072-a7cd-e39b85df41c9@dunelm.org.uk>
Date:   Fri, 27 Jan 2023 15:08:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/5] sequencer: use the new hook API for the simpler
 "post-rewrite" call
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>
References: <cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com>
 <patch-4.5-7a55c95f60f-20230123T170551Z-avarab@gmail.com>
 <a2810f20-c093-ba73-0fed-5d179e3e954b@dunelm.org.uk>
In-Reply-To: <a2810f20-c093-ba73-0fed-5d179e3e954b@dunelm.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 24/01/2023 14:46, Phillip Wood wrote:
> Hi Ævar
> 
> On 23/01/2023 17:15, Ævar Arnfjörð Bjarmason wrote:
>> From: Emily Shaffer <emilyshaffer@google.com>
>>
>> Change the invocation of the "post-rewrite" hook added in
>> 795160457db (sequencer (rebase -i): run the post-rewrite hook, if
>> needed, 2017-01-02) to use the new hook API.
>>
>> This leaves the more complex "post-rewrite" invocation added in
>> a87a6f3c98e (commit: move post-rewrite code to libgit, 2017-11-17)
>> here in sequencer.c unconverted. That'll be done in a subsequent
>> commit.
> 
> As a reader I'd find it more helpful to explain why the conversion isn't 
> done here rather than leaving be to run "git show" to figure it out. If 
> you re-roll perhaps we could replace the commit citation with something 
> like
> 
> sequencer.c also contains an invocation of the "post-rewrite" hook in 
> run_rewrite_hook() that is not converted as the hook API does not allow 
> us to pass the hook input as a string yet.

Sorry, I forgot to say in my previous reply that I like the code change 
here - it is a nice simplification for callers. builtin/am.c has a 
similar function to the one that is converted here.

Best Wishes

Phillip

> Best Wishes
> 
> Phillip
> 
>> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>   sequencer.c | 18 ++++--------------
>>   1 file changed, 4 insertions(+), 14 deletions(-)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index 3e4a1972897..d8d59d05dd4 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -4834,8 +4834,7 @@ static int pick_commits(struct repository *r,
>>           if (!stat(rebase_path_rewritten_list(), &st) &&
>>                   st.st_size > 0) {
>>               struct child_process child = CHILD_PROCESS_INIT;
>> -            const char *post_rewrite_hook =
>> -                find_hook("post-rewrite");
>> +            struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
>>               child.in = open(rebase_path_rewritten_list(), O_RDONLY);
>>               child.git_cmd = 1;
>> @@ -4845,18 +4844,9 @@ static int pick_commits(struct repository *r,
>>               /* we don't care if this copying failed */
>>               run_command(&child);
>> -            if (post_rewrite_hook) {
>> -                struct child_process hook = CHILD_PROCESS_INIT;
>> -
>> -                hook.in = open(rebase_path_rewritten_list(),
>> -                    O_RDONLY);
>> -                hook.stdout_to_stderr = 1;
>> -                hook.trace2_hook_name = "post-rewrite";
>> -                strvec_push(&hook.args, post_rewrite_hook);
>> -                strvec_push(&hook.args, "rebase");
>> -                /* we don't care if this hook failed */
>> -                run_command(&hook);
>> -            }
>> +            hook_opt.path_to_stdin = rebase_path_rewritten_list();
>> +            strvec_push(&hook_opt.args, "rebase");
>> +            run_hooks_opt("post-rewrite", &hook_opt);
>>           }
>>           apply_autostash(rebase_path_autostash());
