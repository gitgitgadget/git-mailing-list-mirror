Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53351C001DB
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 18:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbjHHSSG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbjHHSRn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 14:17:43 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A4D812B1
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 10:24:57 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-589878e5b37so551457b3.2
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 10:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1691515496; x=1692120296;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u8yD8DFZIENrwO9bZE3aJC0Puf1YzFQkMn66xg7JGnE=;
        b=PpZ3cgKYhoHwNz/G55A5hVOEGDD+WORwEESH0ngetbahZz68d/WCWqgpRB+05gkUUI
         KkkPW4F4lvYkHMTq8a08FTNTqqUR2LIalxSc+dpPiEBXczlkrMAPVXVMt1BIHZqQ5V73
         5cUpgbylTrp5lKudgnBrAmFo8BkBCpiFpK5ABcvodRBxiPA+0esRfWdfF4qQZzXItdqi
         Fa624LJAfh84a1phmeQylfu3niCYG2rMQ8lAByPsE42Q8h6z3xYgifV/as9KKM0D8fx9
         EbocFnF7mQSoUzVVxWfiKLizSkgKAtFVpqBEt09mixBVshXJBKSRNbyI7U102F6flf/m
         2LYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691515496; x=1692120296;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u8yD8DFZIENrwO9bZE3aJC0Puf1YzFQkMn66xg7JGnE=;
        b=RKA/9gCYkJmCax/TdJu91SHioUqFtDoxwXR6EvMMkVBEx2PFuHqlxGSwyq9fNSgJcA
         MjjVXF8ngffoLx1xHoD7E+LySBeQ/F6IhYHgF5r6LGACQjDGCbLEWf70oEn7szvBhEjo
         T1vB0CAJkkPV8Q6O/btY7ayWT138WLpgH2r1Okr4S5mYWGvHf2RI73bj7IL6wPFUUp9u
         /oB0aCS/XLeudnjB9IPnQ6uMtirSv1qDM7ijouK40SAghNmc/D8XvXo4JJsRaJuA76OU
         KS62Pm2DjI8S9T9Zy1l0eF833T4G6OAgB7WVfFRgxTJC9i+J7ryJ3lNPXpOwwYKG2E2o
         yQSw==
X-Gm-Message-State: AOJu0Yynr/3C3keW+MaOMsISzotuFcHuEMFd4rnRxhj4y1svYzlIY9dH
        IhgBRxliSM4kJVFFx9tXHIYQUjkxNGvRf/4aUg==
X-Google-Smtp-Source: AGHT+IHvWuWkiGlN6kbxBcDJzuyf3Q7dtaOAEteOEXhDOp1DIcXoXSjlGPMCo95K1d1x5qWTHJOqNQ==
X-Received: by 2002:a0d:df50:0:b0:577:606b:735e with SMTP id i77-20020a0ddf50000000b00577606b735emr379310ywe.37.1691515496365;
        Tue, 08 Aug 2023 10:24:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f1d2:c14b:5536:5192? ([2600:1700:e72:80a0:f1d2:c14b:5536:5192])
        by smtp.gmail.com with ESMTPSA id w9-20020a0dd409000000b00586ba973bddsm2626043ywd.110.2023.08.08.10.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 10:24:56 -0700 (PDT)
Message-ID: <5bb4313a-01f3-4dea-b724-fb41a8def334@github.com>
Date:   Tue, 8 Aug 2023 13:24:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] maintenance: use random minute in systemd scheduler
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
To:     phillip.wood@dunelm.org.uk,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, lenaic@lhuard.fr,
        Taylor Blau <me@ttaylorr.com>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
 <14e340b75faaa66980479f42fec14c457aea5c74.1691434300.git.gitgitgadget@gmail.com>
 <adc0cf80-c2e3-7af2-6d7f-036b95d27f80@gmail.com>
 <8aa7be24-f4a8-4515-8425-dd4bc69e07b1@github.com>
In-Reply-To: <8aa7be24-f4a8-4515-8425-dd4bc69e07b1@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/8/2023 9:56 AM, Derrick Stolee wrote:
> On 8/8/2023 5:53 AM, Phillip Wood wrote:> Hi Stolee

>> So only one of these jobs will succeed. The cron entries are careful to
>> only run one job at a time, I think it would be worth doing the same
>> thing here. I think the using the following format strings would fix this.
>>
>> Hourly: "Tue..Sun *-*-* 1..23:00:%02d"
>> Daily:  "Tue..Sun *-*-* 00:00:%02d"
>> Weekly: "Mon      *-*-* 00:00:%02d"
> 
> I would modify this with dropping the "Tue..Sun" from the hourly schedule,
> as we still want 23 runs on Mondays.
> 
>> It looks like the launchctl schedule has the same issue.
> 
> I will take a look at this and consider some additional patches to correct
> these issues across both schedulers. Thank you for the attention to detail!

Taking a look, it seems that launchctl does not have this same problem.

The schedule is set via an <array> of <dict>s as follows:

	case SCHEDULE_HOURLY:
		repeat = "<dict>\n"
			 "<key>Hour</key><integer>%d</integer>\n"
			 "<key>Minute</key><integer>%d</integer>\n"
			 "</dict>\n";
		for (i = 1; i <= 23; i++)
			strbuf_addf(&plist, repeat, i, minute);
		break;

	case SCHEDULE_DAILY:
		repeat = "<dict>\n"
			 "<key>Day</key><integer>%d</integer>\n"
			 "<key>Hour</key><integer>0</integer>\n"
			 "<key>Minute</key><integer>%d</integer>\n"
			 "</dict>\n";
		for (i = 1; i <= 6; i++)
			strbuf_addf(&plist, repeat, i, minute);
		break;

This means that we create an hourly schedule for each hour 1..23
(no 0th hour means no collision with daily or weekly schedule) and
a daily schedule for each day 1..6 (no 0th day means no collision
with the weekly schedule).

Does this match your understanding?

The overlap _definitely_ exists in systemd, which I will fix.

Thanks,
-Stolee

