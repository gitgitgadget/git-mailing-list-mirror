Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63256C54EAA
	for <git@archiver.kernel.org>; Fri, 27 Jan 2023 22:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjA0WSl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Jan 2023 17:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjA0WSi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2023 17:18:38 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC7283943
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 14:18:37 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id lp10so5896298pjb.4
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 14:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zU061K7ngmQEOrkWErnZrBnRryXRqKTFUfF8uRwZ0z8=;
        b=KFEsuFsQ7ocnemmpIepfvkXkaSOqiKDDFlx8mPA0x3QErpsfKHWDi/18S55G6ta0gc
         bMxz+7L9C/RrQmKHqBsdjohdDyFrmHBvAsyoOrjMdcnFCu9SwljSqgmuon7JkSKGS31d
         T7Tv49oBDohStjnW0gJhEBucs3i/1D6hpKN2dsWo20J/K+pivVJZWt9LJUCl159EI83v
         l1HAAtgMXS2N9e8gaWXi6/nHbWEHJM7c2Hddl/1bEntNlo9gZRfZ+tIi6hp9m9kTJ0ac
         7FXM+kM35RgXVeKHFiX/wha9iASr02QhUhluNMxZyA2AXQLYGejkghi6T0vnuHDCM8OY
         veog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zU061K7ngmQEOrkWErnZrBnRryXRqKTFUfF8uRwZ0z8=;
        b=l+ltYVyXudrkCqg6OEgZDBsFgJDpsCRhqa4iecjz9usVXQdHgAxUqVv3HnPymLcME8
         QXJpW8DQp8yZz/MNjU4OHrrtig7msmvwch8DdagJWb9DClkIbe7srobEelfUQZ15mbfL
         +WoBeCLrgqpSCK0rnByn7UfQoMKlytb/8//9n/B8PDBIr6hPQ2E2czb0aJ+yehfG+VYE
         e0NcyF3eYEnTzExjfac2xbADa0JACwrne6HXB+5fQKlQsfdpTDcJwcBnGLXLnsOf7vLZ
         TyhEwZrFkn2fglX3Zqa1tT7SVJkcQNmvd8gyGNoC/wKbD4R0wEQAJMQ/hibk++LzZhqI
         EQVA==
X-Gm-Message-State: AO0yUKXmU6Yyt/iDu5J8bHJcCmK9V5UpaxSX9FxAGBr618EdqY021E45
        EbpLbj85F00/Y9WsYo+zrtUo
X-Google-Smtp-Source: AK7set9UkNkdeNRwf7aPfGbltEGdGGTok8rAD1JxaAtcCjrdP0zQQ2dSJko2Z0zjTVEkcrZR90Ipag==
X-Received: by 2002:a17:902:ce89:b0:196:1ab9:afc8 with SMTP id f9-20020a170902ce8900b001961ab9afc8mr17396260plg.4.1674857916697;
        Fri, 27 Jan 2023 14:18:36 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id jc7-20020a17090325c700b00192588bcce7sm3348260plb.125.2023.01.27.14.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 14:18:36 -0800 (PST)
Message-ID: <3ade6d9f-8477-40c2-d683-d629e863c6ab@github.com>
Date:   Fri, 27 Jan 2023 14:18:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 3/3] scalar: only warn when background maintenance fails
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
References: <pull.1473.git.1674849963.gitgitgadget@gmail.com>
 <d75780e0567b5f765816ab7522afe550ebaa3521.1674849963.git.gitgitgadget@gmail.com>
 <xmqqleln90ka.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqqleln90ka.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> A user reported issues with 'scalar clone' and 'scalar register' when
>> working in an environment that had locked down the ability to run
>> 'crontab' or 'systemctl' in that those commands registered as _failures_
>> instead of opportunistically reporting a success with just a warning
>> about background maintenance.
>>
>> As a workaround, they can use GIT_TEST_MAINT_SCHEDULER to fake a
>> successful background maintenance, but this is not a viable strategy for
>> long-term.
>>
>> Update 'scalar register' and 'scalar clone' to no longer fail by
>> modifying register_dir() to only warn when toggle_maintenance(1) fails.
>>
>> Since background maintenance is a "nice to have" and not a requirement
>> for a working repository, it is best to move this from hard error to
>> gentle warning.
> 
> Wasn't the main selling point of scalar that users do not have to
> worry about various minute details of configuration settings to
> maintain their clone of projects on the larger side?  The "maintain
> their clone" certainly should include running periodic maintenance
> tasks without them having to worry about it.  It feels like this is
> calling for an explicit "disable periodic maintenance tasks in this
> repository" option to help these esoteric environments that disable
> cron-like system services, while keeping the default safer,
> i.e. fail loudly when the periodic maintenance tasks that the users
> expect to happen cannot be enabled, or something.

I see Stolee's approach as more in line with how FSMonitor is treated by
'scalar', which is "only turn it on if it's supported, but otherwise do
nothing" (the main difference here being that a warning is displayed if
maintenance can't be turned on). That still fits the stated goal of 'scalar'
("configure all the niche large-repo settings for me when I
clone/register"), but it makes 'scalar' more forgiving of system
configurations that don't support maintenance.

That said, this doesn't distinguish between "maintenance couldn't be turned
on because the system doesn't support it" and "maintenance couldn't be
turned on because of an internal error". The latter might still be worth
failing on, so maybe something like this would be more palatable?

--------8<--------8<--------8<--------
diff --git a/scalar.c b/scalar.c
index 6c52243cdf1..138780abe5f 100644
--- a/scalar.c
+++ b/scalar.c
@@ -252,6 +252,10 @@ static int stop_fsmonitor_daemon(void)
 	return 0;
 }
 
+static int have_maintenance_support(void) {
+	/* check whether at least one scheduler is supported on the system */
+}
+
 static int register_dir(void)
 {
 	if (add_or_remove_enlistment(1))
@@ -260,7 +264,7 @@ static int register_dir(void)
 	if (set_recommended_config(0))
 		return error(_("could not set recommended config"));
 
-	if (toggle_maintenance(1))
+	if (have_maintenance_support() && toggle_maintenance(1))
 		return error(_("could not turn on maintenance"));
 
 	if (have_fsmonitor_support() && start_fsmonitor_daemon()) {

-------->8-------->8-------->8--------

> 
> Perhaps I am not the primary audience, but hmph, I have a feeling
> that this is not exactly going into a healthy direction.

I don't think this change would be the start of a larger pattern, since most
Scalar-related settings aren't system-dependent (only FSMonitor and
maintenance are, AFAIK). What would be worse, I think, is setting the
maintenance behavior with a new command option - I could very easily see
*that* leading to a slippery slope of endless options to toggle 'scalar's
behaviors, completely defeating it's whole "set everything up for me"
purpose.

> 
> Other two steps that led to this step looked quite sensible, though.
> 
> Thanks.

