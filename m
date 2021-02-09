Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5949CC433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 16:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 097E964EAC
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 16:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbhBIQz1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 11:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbhBIQzY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 11:55:24 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14563C061574
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 08:54:44 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id k10so15718451otl.2
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 08:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JUc1g/+GyDrdIp4/Eobu/WgthT0flupLbwAp3tz0cZk=;
        b=FfgbWTmq4Mp0zsucu/Yj4t19mwOq216/tWLE63Lyhb89kL23hty9jK0BsfayGeg5hU
         IDp3uwJcxW9WV2tuho4xH7USm8W0Fg4OoXi4CthMPX6F4c930CP7JrBxq0cX6IsPpvDa
         mG1rxDnHcsQKko6ae0CpIXzjiEbPtRowv8bsAAKmOCkSyOYIVDiYY27F3NTyimvISvmC
         jp+DiYB1B7JwnM7Fq7hfz8bsnH9XAULtdkhr7ENxOh5CYM/S65uygl80uduTt+H7EIuk
         g0A7mg3+w+9a9hQrBt872NZf/Eej+dwDLRzO5uTBcGmXI6Ys9tzaNcaxRE+JPVaOCXIS
         xVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JUc1g/+GyDrdIp4/Eobu/WgthT0flupLbwAp3tz0cZk=;
        b=WS1++BIiN68R+ApV0dPbfxBEi8FC4hrWWF/5BDWiQ8H5Yt86nLY++qkXQtRm1SxjSZ
         rwYOx7cmbTcVfoNl7qM/cBe7y1QC68LGxqfdWbtuckwlcXwb4wg0wEV4J02YsPxI3aL3
         hDJ695LQ7gYBeMjXrZxtpvZYpWyYdF/3U2Dwq4Tg2NeyAspNQUefE/vbFPKnJY+PARmd
         jELe/jxaD3QvJQqd8vZxYg5JwatnLjPwt4gJntbyfd5t0C76iuGDNMM7Jx/GdXyogEZx
         6McPAKjv7FixwwapVm8Jo6O8Oyf3ivm5SacpccYqeIzU8O1l+wBq+z0OBPb0Izp2EK/F
         vCYw==
X-Gm-Message-State: AOAM530+c1NKtITiOySZg6UcCYx9gJgiT18sgiWAN/5fqMubVGUQMA/D
        xmu1idPaGOGovTqpqS9/eJw=
X-Google-Smtp-Source: ABdhPJzo6IOH4zPII68e85TeTSNLsQI5U0eXYLorzDsjmuTXLoxT8rEFoMcIFcOKV3SwdLbLKI3hxQ==
X-Received: by 2002:a05:6830:1d82:: with SMTP id y2mr335864oti.204.1612889682909;
        Tue, 09 Feb 2021 08:54:42 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:7c18:1f04:a165:5ea0? ([2600:1700:e72:80a0:7c18:1f04:a165:5ea0])
        by smtp.gmail.com with UTF8SMTPSA id h6sm389880otn.38.2021.02.09.08.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 08:54:42 -0800 (PST)
Message-ID: <1eff631f-b079-d097-b16d-36dc974efea9@gmail.com>
Date:   Tue, 9 Feb 2021 11:54:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v4 2/8] maintenance: add --schedule option and config
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        sluongng@gmail.com,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.724.v3.git.1601902635.gitgitgadget@gmail.com>
 <pull.724.v4.git.1602782524.gitgitgadget@gmail.com>
 <dae8c04bb5523c9b63c770862a1104a0ff4aa6c4.1602782524.git.gitgitgadget@gmail.com>
 <87blctcp30.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <87blctcp30.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/9/2021 9:06 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Oct 15 2020, Derrick Stolee via GitGitGadget wrote:
> 
>> +--schedule::
>> +	When combined with the `run` subcommand, run maintenance tasks
>> +	only if certain time conditions are met, as specified by the
>> +	`maintenance.<task>.schedule` config value for each `<task>`.
>> +	This config value specifies a number of seconds since the last
>> +	time that task ran, according to the `maintenance.<task>.lastRun`
>> +	config value. The tasks that are tested are those provided by
>> +	the `--task=<task>` option(s) or those with
>> +	`maintenance.<task>.enabled` set to true.
> 
> I see from searching on list and from spying on your repo that patches
> for this maintenance.<task>.lastRun feature exist, but there's no code
> for it in git.git.
> 
> So we've got a 2.30.0 release with a mention of that, and it can't work,
> because it's only in the doc due to b08ff1fee00 (maintenance: add
> --schedule option and config, 2020-09-11).

Thank you for pointing out this docbug. This is based on an early
version of the patch series and should have been changed.

Please see this patch which attempts to do a better job. I can
create a new thread with this submission if we need more edits.

Thanks,
-Stolee

--- >8 ---

From 46436b06caf65ee824e781603a8108413bb87705 Mon Sep 17 00:00:00 2001
From: Derrick Stolee <dstolee@microsoft.com>
Date: Tue, 9 Feb 2021 11:51:32 -0500
Subject: [PATCH] maintenance: properly document --schedule
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The documentation for the '--schedule' option is incorrect and based on
an early version of the background maintenance feature. Update the
documentation to describe the actual use of the option.

The most important thing is that Git takes this option as a hint for
which tasks it should run. Users should not run this command arbitrarily
and expect that Git will enforce some timing restrictions.

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-maintenance.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 6fec1eb8dc2..d4b5aea6760 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -155,15 +155,15 @@ OPTIONS
 	exceeds the `gc.autoPackLimit` config setting. Not compatible with
 	the `--schedule` option.
 
---schedule::
+--schedule=<frequency>::
 	When combined with the `run` subcommand, run maintenance tasks
-	only if certain time conditions are met, as specified by the
-	`maintenance.<task>.schedule` config value for each `<task>`.
-	This config value specifies a number of seconds since the last
-	time that task ran, according to the `maintenance.<task>.lastRun`
-	config value. The tasks that are tested are those provided by
-	the `--task=<task>` option(s) or those with
-	`maintenance.<task>.enabled` set to true.
+	whose `maintenance.<task>.schedule` config value is equal to
+	`<frequency>`. There is no timing restriction imposed by this
+	option, but instead is used to inform the Git process which
+	frequency to use. The command scheduler created by
+	`git maintenance start` runs this command with `<frequency>`
+	equal to `hourly`, `daily`, and `weekly` at the appropriate
+	intervals.
 
 --quiet::
 	Do not report progress or other information over `stderr`.
-- 
2.30.0.vfs.0.0.exp



