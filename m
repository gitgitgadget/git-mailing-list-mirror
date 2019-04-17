Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB8B620248
	for <e@80x24.org>; Wed, 17 Apr 2019 19:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733217AbfDQTxg (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 15:53:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35047 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbfDQTxg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 15:53:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id y197so107437wmd.0
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 12:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9GZa8cE1IJ9p8jIU3IaW3q1wQmTLhJ08TMouV3UXS3o=;
        b=iiNuvh6KK2C3DCZnYqkyU/42jjXGCuxFQlva8WEwWOqaUUejswyd2/5GwDWuN7PcB3
         fj2FqMxms3EOgV90Rjv7293HfVZhqXPnaVSZPmQmLcoEraEdAbpaDRStKIQrvbThhZJj
         V1Lqy9qDYn7fKVrdEW5ZO7gEkTs3PNABwIy9/pJIoarrOE0SSRtOqmCREwKzUbI+TRdK
         Ork/0eCtTkaiHNSx8VtC/SJu/2lwYlq5r0Ta5y64EhWi9XPICXQRfwOHu+qH/ZvbpG5v
         +nh6xe4SjacBhx1qgElkpUBQuETOpgcW6jRajeJHlyIVluPl2qpQ+ss0HGe0M1rFffe6
         crMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9GZa8cE1IJ9p8jIU3IaW3q1wQmTLhJ08TMouV3UXS3o=;
        b=BrE7+IKEkldWcwBTJ7LWleFNMGE9MRv+xEutjy0w2XnVrBUUeQul+46GSzOp5xmidJ
         YQ+yL0DqybShEOMy5h4GyiXjhivmhwSfA74RRfAPc74n4p83P6Va+q0RWJRDjn9AQ9Qq
         URd+eDMbdk9v0A6IaHw3lBlgSLggpolRjglMqTXfm2x6IiswJ2xVOlbLjJHgWXhxdwOi
         7QTiBEEQYOVUeWSvgJV5XMvDakUYm/zk2Y08Rvn122I0N3lYQnhepYQnwNadEVu2V6G9
         zf6VymaBk4q3v5q2hIXJFJ5BOQVRgSx8g+jlCxOLpg94D1cYtGGDUde1Oiiun1QYLSti
         sIkQ==
X-Gm-Message-State: APjAAAVf9XOObEJk7oLhZIZyLPW78d53tgVrZR0E7bXxyUPsO8gy20iN
        8AiIkDE2KCRmKzAu6iplQM8=
X-Google-Smtp-Source: APXvYqxbkDN0RK6OiDwP/0PClLM+Bw9LjcStM+COk7xpvwg1aTN7fmuYD+1baDeM9fQcyEAiMz6zWQ==
X-Received: by 2002:a1c:6889:: with SMTP id d131mr226685wmc.114.1555530814395;
        Wed, 17 Apr 2019 12:53:34 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-21-176.as13285.net. [92.22.21.176])
        by smtp.gmail.com with ESMTPSA id u10sm3825886wml.32.2019.04.17.12.53.32
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 12:53:33 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v10 09/10] sequencer.c: save and restore cleanup mode
To:     Denton Liu <liu.denton@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <cover.1553150827.git.liu.denton@gmail.com>
 <20190417102330.24434-1-phillip.wood123@gmail.com>
 <20190417102330.24434-10-phillip.wood123@gmail.com>
 <20190417170247.GA9636@dev-l>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <ccf75cb1-8afa-6de7-9f1e-cfc21d599ad3@gmail.com>
Date:   Wed, 17 Apr 2019 20:53:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417170247.GA9636@dev-l>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

On 17/04/2019 18:02, Denton Liu wrote:
> On Wed, Apr 17, 2019 at 11:23:29AM +0100, Phillip Wood wrote:
>> From: Denton Liu <liu.denton@gmail.com>
> 
> We should drop this line before applying the patch since Phillip did all
> of the hard work for this patch and he's the primary author.
> 
>>
>> If the user specifies an explicit cleanup mode then save and restore it
>> so that it is preserved by 'git cherry-pick --continue'.

Sorry when I removed your Signed-off-by: as you suggested I forget to 
change the authorship of the patch

Best Wishes

Phillip

>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   sequencer.c | 28 +++++++++++++++++++++++++++-
>>   1 file changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index b049951c34..3f4b0896e3 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -535,6 +535,24 @@ enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
>>   		die(_("Invalid cleanup mode %s"), cleanup_arg);
>>   }
>>   
>> +/*
>> + * NB using int rather than enum cleanup_mode to stop clang's
>> + * -Wtautological-constant-out-of-range-compare complaining that the comparison
>> + * is always true.
>> + */
>> +static const char *describe_cleanup_mode(int cleanup_mode)
>> +{
>> +	static const char *modes[] = { "whitespace",
>> +				       "verbatim",
>> +				       "scissors",
>> +				       "strip" };
>> +
>> +	if (cleanup_mode < ARRAY_SIZE(modes))
>> +		return modes[cleanup_mode];
>> +
>> +	BUG("invalid cleanup_mode provided (%d)", cleanup_mode);
>> +}
>> +
>>   void append_conflicts_hint(struct index_state *istate,
>>   			   struct strbuf *msgbuf)
>>   {
>> @@ -2366,7 +2384,10 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
>>   		opts->allow_rerere_auto =
>>   			git_config_bool_or_int(key, value, &error_flag) ?
>>   				RERERE_AUTOUPDATE : RERERE_NOAUTOUPDATE;
>> -	else
>> +	else if (!strcmp(key, "options.default-msg-cleanup")) {
>> +		opts->explicit_cleanup = 1;
>> +		opts->default_msg_cleanup = get_cleanup_mode(value, 1);
>> +	} else
>>   		return error(_("invalid key: %s"), key);
>>   
>>   	if (!error_flag)
>> @@ -2770,6 +2791,11 @@ static int save_opts(struct replay_opts *opts)
>>   		res |= git_config_set_in_file_gently(opts_file, "options.allow-rerere-auto",
>>   						     opts->allow_rerere_auto == RERERE_AUTOUPDATE ?
>>   						     "true" : "false");
>> +
>> +	if (opts->explicit_cleanup)
>> +		res |= git_config_set_in_file_gently(opts_file,
>> +				"options.default-msg-cleanup",
>> +				describe_cleanup_mode(opts->default_msg_cleanup));
>>   	return res;
>>   }
>>   
>> -- 
>> 2.21.0
>>
