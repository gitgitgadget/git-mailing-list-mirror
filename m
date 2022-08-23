Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED4BC32772
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 18:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbiHWSmz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 14:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbiHWSm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 14:42:28 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C5D89CC4
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 10:06:06 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id i8so780394ilk.8
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 10:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=TxjnWjmcEZbPranEhaCx3sWDp1p5+82ucANlrvE/UU0=;
        b=IHw7ja+QzFfZbR45m6RnTRqC4nJGG4cwSlHZseaTGO0lf7/5ZnE5AOoUATPa01qPub
         4DQsMlVPmmR1oSH2w4RSiuhAmd5EnrGUSREItrN8gMTayajuBlgi0tRnp1et9CmxXCjN
         z5tvDTfwZVr1yCfNMbZOic6GhZbSJ4HXl7F+yhW2Vg2jU1kfo2IGA1CRUnKoDBUCco0d
         PgEK07wrNgYmtqrwOcretvzuLUSQp2r9mGswIsW50v0xhRucc7d1Bh0j+h9ISmCKXGl6
         aXGXbnVpNQNUufM45YMiZ6DX1B+q1p3dOfxNN/R4WPYjhNMA6W9jOi2OHTsnGPPlBanw
         kyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=TxjnWjmcEZbPranEhaCx3sWDp1p5+82ucANlrvE/UU0=;
        b=p4RlbbYFkgA+pC4ifJ4zv+LvQdW8kw9y39VxISL9hZyAmy7pCAlO7smYaRaD1MMeAe
         wE3S6XQJJ9MRg2+IIh+ZrGrQoOy8TaVUaHY0/Q1KUrDhZIEaSpl300dqGx2Y8Ruv2XnU
         OGfnBPiWA7dZRqH4G8ATEWtbJreY/XEvIjA/5nxYQc/8IbqBeR5zwgm7bkgb6dbDZtuh
         tzXY6rYdp2+Kjuza2RqsmDzo4Pi3GK+AAZX+JnmxkkwIQ1zXj4POrqdl4DjpDaFmE9Xl
         1VzNoux+7UA4ga379W2xiUPGY27f/RHqAGFZklf+uEzcnASN47X4PM1vJDTzKyjacMKW
         vDTg==
X-Gm-Message-State: ACgBeo3rK5Jj98NnEss9IRewGOHPRFPlk+GBPEEwOQmipW0VZtEHvitD
        ix7Y/KPrcjtFLDDxqfoL5qUG3I1nmIfG
X-Google-Smtp-Source: AA6agR7UCYq8N6q2dG1Gw5RpinMF1CRlIv3D/AR9ciBiS+tegnRFTIrRSzacznJ/o/bWP59sbnGlRA==
X-Received: by 2002:a92:8748:0:b0:2d9:3f81:d0b7 with SMTP id d8-20020a928748000000b002d93f81d0b7mr260627ilm.310.1661274366018;
        Tue, 23 Aug 2022 10:06:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f1b9:9fd8:f860:8737? ([2600:1700:e72:80a0:f1b9:9fd8:f860:8737])
        by smtp.gmail.com with ESMTPSA id y5-20020a027305000000b003427dcbb4d8sm5395690jab.84.2022.08.23.10.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 10:06:05 -0700 (PDT)
Message-ID: <9e737b4b-4a17-09d5-6452-4ca5eef3d9da@github.com>
Date:   Tue, 23 Aug 2022 13:06:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] gc: use temporary file for editing crontab
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Renato Botelho <garga@FreeBSD.org>,
        Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
References: <1dd29f43-1a8e-eb69-3320-7f5140a0e18e@github.com>
 <20220823010120.25388-1-sandals@crustytoothpaste.net>
 <6428252p-ssrn-7qs7-9p26-5so10r96s3os@tzk.qr>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <6428252p-ssrn-7qs7-9p26-5so10r96s3os@tzk.qr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/23/2022 5:12 AM, Johannes Schindelin wrote:
> Hi brian,
> 
> On Tue, 23 Aug 2022, brian m. carlson wrote:

>> +	tmpedit = mks_tempfile_t(".git_cron_edit_tmpXXXXXX");
>> +	if (!tmpedit)
>> +		return error(_("failed to create crontab temporary file"));
> 
> It might make sense to use the same `goto out;` pattern here, to make it
> easier to reason about the early exit even six years from now.
> 
> We do not even have to guard the `close_tempfile_gently()` behind an `if
> (tempfile)` conditional because that function handles `NULL` parameters
> gently.

I don't think this is hard to reason about. It might mean that we
need to change this if block in the future to use 'goto out', if we
added another resource initialization before this one. That "future
need" is the only thing making me lean towards using the goto, but
we are just as likely to be in YAGNI territory here.
 
>> +	cron_in = fdopen_tempfile(tmpedit, "w");
>> +	if (!cron_in) {
>> +		result = error(_("failed to open temporary file"));
>> +		goto out;
>> +	}
>> +
>>  	/*
>>  	 * Read from the .lock file, filtering out the old
>>  	 * schedule while appending the new schedule.
>> @@ -2086,19 +2096,6 @@ static int crontab_update_schedule(int run_maintenance, int fd)
>>  	cron_list = fdopen(fd, "r");
>>  	rewind(cron_list);
>>
>> -	strvec_split(&crontab_edit.args, cmd);
>> -	crontab_edit.in = -1;
>> -	crontab_edit.git_cmd = 0;
>> -
>> -	if (start_command(&crontab_edit))
>> -		return error(_("failed to run 'crontab'; your system might not support 'cron'"));
>> -
>> -	cron_in = fdopen(crontab_edit.in, "w");
>> -	if (!cron_in) {
>> -		result = error(_("failed to open stdin of 'crontab'"));
>> -		goto done_editing;
>> -	}
>> -
>>  	while (!strbuf_getline_lf(&line, cron_list)) {
>>  		if (!in_old_region && !strcmp(line.buf, BEGIN_LINE))
>>  			in_old_region = 1;
>> @@ -2132,14 +2129,22 @@ static int crontab_update_schedule(int run_maintenance, int fd)
>>  	}
>>
>>  	fflush(cron_in);
>> -	fclose(cron_in);
>> -	close(crontab_edit.in);
> 
> This worries me a bit. I could imagine that keeping the file open and then
> expecting a spawned process to read its stdin from that file won't work on
> Windows.

This is focused only on the cron integration, which is not used on Windows,
so I'm not worried about that.

I was initially worried that we lost the fclose(cron_in), but of course it
is handled by the close_tempfile_gently() at the end.

> In any case, I would consider it the correct thing to do to close
> the temp file here. In other words, I would like to move the
> `close_tempfile_gently()` call to this location.
> 
>>
>> -done_editing:
>> +	strvec_split(&crontab_edit.args, cmd);
>> +	strvec_push(&crontab_edit.args, get_tempfile_path(tmpedit));
>> +	crontab_edit.git_cmd = 0;
>> +
>> +	if (start_command(&crontab_edit)) {
>> +		result = error(_("failed to run 'crontab'; your system might not support 'cron'"));
>> +		goto out;
>> +	}
>> +

Here's the crux of the matter: we are no longer using stdin but
instead passing an argument to point to a file with our desired
schedule. I tested that this worked on my machine, and I'm glad
this use is the POSIX standard.

There is something wrong with this patch: it needs to update
t/helper/test-crontab.c in order to pass t7900-maintenance.sh.

Something like this works for me:

--- >8 ---

diff --git a/t/helper/test-crontab.c b/t/helper/test-crontab.c
index e7c0137a477..29425430466 100644
--- a/t/helper/test-crontab.c
+++ b/t/helper/test-crontab.c
@@ -17,8 +17,8 @@ int cmd__crontab(int argc, const char **argv)
 		if (!from)
 			return 0;
 		to = stdout;
-	} else if (argc == 2) {
-		from = stdin;
+	} else if (argc == 3) {
+		from = fopen(argv[2], "r");
 		to = fopen(argv[1], "w");
 	} else
 		return error("unknown arguments");

--- >8 ---

>>  	if (finish_command(&crontab_edit))
>>  		result = error(_("'crontab' died"));
>>  	else
>>  		fclose(cron_list);
>> +out:
>> +	close_tempfile_gently(tmpedit);
> 
> Here, I would like to call `delete_tempfile(&tmpedit);` instead. That way,
> the memory is released correctly, the temporary file is deleted, and
> everything is neatly cleaned up.
> 
> The way I read the code, `delete_tempfile(&tmpedit)` would return early if
> `tmpedit == NULL`, and otherwise clean everything up and release the
> memory, so there is no need to guard this call behind an `if (tmpedit)`
> conditional.

While the memory release is nice, I also think it would be good to use
delete_tempfile() so the temporary file is deleted within this method,
not waiting until the end of the process to do that cleanup.

Thanks,
-Stolee
