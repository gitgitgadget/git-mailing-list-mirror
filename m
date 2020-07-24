Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C493C433FB
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 13:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6921120663
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 13:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqAcnpaD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgGXNgl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbgGXNgj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 09:36:39 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442D6C0619D3
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 06:36:39 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id l64so1787726qkb.8
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 06:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sCn0zFMbPVJSfy10Gyc7r1m0ATV3/vfwtmHH0jvPAQI=;
        b=eqAcnpaDcgZ5Jl8r9AigCk21ca2sIJ5mLDkbKpmxhzh6LCDnmkgHHCHA39B7LgJOoV
         Np5Z5MuozLRU686awPV4yp+f/2M2GFz6HZPq+g1vkCkecliLig/vkZGOVAeZVqTiTu5u
         TAIem2dyEUvELYzfPBjuIbiWcCQCHC1kPjUOEgQFP1cWWMqUEitwbryzfHeHCGB3dIwM
         l/okD92G3Fow0lwNlv8JbZi6Qg2jrPWaskZ+XjdRcs59PpTB6uoM43wEhUtoTRRUlFx0
         Ns+6w0jAqKxqcQDr8J8fnzBKcygSqmWUkffirskzmPGuDn6uPaTl5vv0EtlywkWntLMt
         z8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sCn0zFMbPVJSfy10Gyc7r1m0ATV3/vfwtmHH0jvPAQI=;
        b=fN2XmIcAEetTdr7ogqdL9Mr/3rIdRiijYAnBb5ypCETWGrgSQoOTO2Wt/SAoUAth9f
         +zKCZRZxB8JylaXP+zBPpn2445tPMUyp5hZAmD+B6r/+Yzl+Sng4MhxaURoWg85ozHsM
         LtTbyQOwg9hjfOXlZEW+IaNb5BoiWbjj0zG28BWmbICFRBOf/G4IIUTCBm0Ukqx9dico
         UBrjIlDuu0Ap/c9oa+RqjOF1WeViPENOCOGbewfKYHiR1zmrSXnorCVgRsCfF/cQvyxx
         ouxzHiCiR+fUYmfGnrklLKdW3CzV4wK+5t9hEiee39kKHvdpUVbT+95ZZ1naR9N4JsRr
         VotA==
X-Gm-Message-State: AOAM532yJjNLDBNJ4qxPe3dPuwtsGgHYCe5ONFA2ti7YEt8SvvgyVWOU
        6Rx+UMf2NgTpOU8DgyH3hXU=
X-Google-Smtp-Source: ABdhPJzvwsqxWM/4GIDa9mfRabjqDMXY36AR93NwB4TPt6BWKS2A5a5JNIO6OhJdodgumzsEUCaF1w==
X-Received: by 2002:a37:54a:: with SMTP id 71mr10201840qkf.193.1595597798289;
        Fri, 24 Jul 2020 06:36:38 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:dd66:75cb:8c22:1387? ([2600:1700:e72:80a0:dd66:75cb:8c22:1387])
        by smtp.gmail.com with ESMTPSA id d8sm1196167qtr.12.2020.07.24.06.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 06:36:37 -0700 (PDT)
Subject: Re: [PATCH v2 06/18] maintenance: add --task option
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <a09b1c16874c0fad6dd0df3ace573a2ffe34519e.1595527000.git.gitgitgadget@gmail.com>
 <xmqqimeeq8x4.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2c5e5ed3-155e-f963-02c8-2789c799f3f7@gmail.com>
Date:   Fri, 24 Jul 2020 09:36:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:79.0) Gecko/20100101
 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <xmqqimeeq8x4.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/23/2020 4:21 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> +static int compare_tasks_by_selection(const void *a_, const void *b_)
>> +{
>> +	const struct maintenance_task *a, *b;
>> +	a = (const struct maintenance_task *)a_;
>> +	b = (const struct maintenance_task *)b_;
>> +
>> +	return b->task_order - a->task_order;
>> +}
> 
> It forces the reader to know intimately that task_order *is*
> selection order in order to understand why this is "tasks by
> selection".  Perhaps rename the field to match what it is
> (i.e. "selection_order")?

Good idea. I made this fix locally.

>>  static int maintenance_run(void)
>>  {
>>  	int i;
>>  	int result = 0;
>>  
>> +	if (opts.tasks_selected)
>> +		QSORT(tasks, num_tasks, compare_tasks_by_selection);
>> +
>>  	for (i = 0; !result && i < num_tasks; i++) {
>> -		if (!tasks[i]->enabled)
>> +		if (opts.tasks_selected && !tasks[i]->selected)
>> +			continue;
>> +
>> +		if (!opts.tasks_selected && !tasks[i]->enabled)
>>  			continue;
> 
> I am not sure about this.  Even if the task <x> is disabled, if the
> user says --task=<x>, it is run anyway?  Doesn't make an immediate
> sense to me.

You already replied that you figured this out. However, I could make
it easier by adding some foreshadowing in the commit message here.

> As I am bad at deciphering de Morgan, I'd find it easier to read if
> the first were written more like so:
> 
> 		if (!(!opts.tasks_selected || tasks[i]->selected))
> 			continue;
> 
> That is, "do not skip any when not limited, and do not skip the ones
> that are selected when limited".  And that would easily extend to
> 
> 		if (!tasks[i]->enabled ||
> 		    !(!opts.tasks_selected || tasks[i]->selected))
> 			continue;

This isn't quite right, due to the confusing nature of "enabled".
The condition here will _never_ allow selecting a disabled task.

Perhaps it would be better to rename 'enabled' to 'run_by_default'?
That would make it clear that it is choosing which tasks to run unless
specified otherwise with --task=<task> here, the config option
maintenance.<task>.enabled later, and the --auto conditions even later.
Looking even farther down the line (into the next series) there will be
similar checks for auto-conditionschecking time-based schedules.

Since this loop becomes more complicated in the future, I specifically
wanted to group the "skip this task" conditions into their own if
blocks:

	1. If the user didn't specify --task=<task> explicitly and this
 	   task is disabled, then skip this task.

	2. If the user _did_ specify --task=<task> explicitly and this
	   task was not on the list, then skip this task.

	3. If the user specified --auto and the auto condition fails,
	   then skip this task.

	4. (Later) If the user specified --scheduled and the time since
	   the last run is too soon, then skip this task.

With this being the planned future, I'd prefer these be split out as
separate if conditions instead of a giant combined if. And since that
is the plan, then I won't work too hard to combine conditions 1 and 2
into a single condition.

>> +
>>  		result = tasks[i]->fn();
>>  	}
> 
>> @@ -842,6 +861,44 @@ static void initialize_tasks(void)
>>  	num_tasks++;
>>  }
>>  
>> +static int task_option_parse(const struct option *opt,
>> +			     const char *arg, int unset)
>> +{
>> +	int i;
>> +	struct maintenance_task *task = NULL;
>> +
>> +	BUG_ON_OPT_NEG(unset);
>> +
>> +	if (!arg || !strlen(arg)) {
>> +		error(_("--task requires a value"));
>> +		return 1;
> 
> There is no need to special case an empty string that was explicitly
> given as the value---it will be caught as "'' is not a valid task".

Sounds good. No need for this extra message.

Thanks,
-Stolee
