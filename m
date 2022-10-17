Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E9DC433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 09:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiJQJkA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 05:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiJQJj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 05:39:56 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75A41DA51
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 02:39:52 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id d26so23538407ejc.8
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 02:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7qKVddhMrE409SlwrIRQ7dazRVAqpF9RVIzg3/FASi4=;
        b=nHQy6DYieOQ1jCVdkDXLMJZ0rEosHkwf8A36YSZOoHKiHvBWwKn1zOcS9Gjpc0AK+b
         FeUebuhIpX0oJ+i8MlDJ5T4atF0Iolgnt2Q3o4eLXbMp3Xz7dtuaVTMuZvevwet1HY4d
         rG0apshJjavUY08WxRq3xz1Rm/Pn+Fz2wbbqq8sAbwqA5M5VfY3ZUsKlWlwU8v645s6Y
         AmP2EO5LQWbVOhWY7t2fPC4blcRRWYMmhrG1jQ9S/Bfhgsxav8mVvqfQWbDmzazmVzVN
         wWfpm9f+6Ow0Trc/q6JI9lIsay9Nwa8I9Z0hh7kZQq/ISMh/bwVFYhD2GeJ8tjQALiPF
         aSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qKVddhMrE409SlwrIRQ7dazRVAqpF9RVIzg3/FASi4=;
        b=HyVNdrQBOL2hzmJUo/wB5CYfJyzY3E1SJQyxeG6kLzWV5zwaOx6nya4PZrt5BOgNKB
         Bxh7SvounwgH8PhaRirifrmw56WKxIgI6nHMZWrS7OcuQM90SJxlsQ8p2QJ4cHdWO1qW
         b1eAqw9OWY4qY37SSbhDsOjhduom9y5q5JraWofME/Lu6z3mvGr/Oo6XGkMM4FHpAH2e
         MiCWBz2eY1GPUpih9dBJm0f5vTYAtQzvw97P55qVjH4RQ6OSWWavJe3b/9X3zVnMfzSB
         AIqAHzedJ6Kw5KHefy3d4XCXPi3HJZMFVfCq0btZZ+agHbUTIhyVzRoWyYQq1qGoCZMl
         RtCA==
X-Gm-Message-State: ACrzQf3DiVt/4/bZ+IOPhatuOJLf7P8QcxAdqCKjFWkOlxwjxnQTr2Hy
        raMm1kab29gYiGNwq7lZ+4M=
X-Google-Smtp-Source: AMsMyM6xKZGRvbYBOhL61VmpMpKhQhfr7VYraBkuPA6E7dua0/omMFXpT6gHYbn6N1Mc2gdKrqxrKQ==
X-Received: by 2002:a17:906:ee86:b0:741:89bc:27a1 with SMTP id wt6-20020a170906ee8600b0074189bc27a1mr8054156ejb.725.1665999591052;
        Mon, 17 Oct 2022 02:39:51 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id g10-20020aa7c84a000000b0045cbe305be1sm6958474edt.49.2022.10.17.02.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 02:39:50 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <c0213afe-658d-8562-3d2a-9e254c742730@dunelm.org.uk>
Date:   Mon, 17 Oct 2022 10:39:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 6/8] rebase: factor out branch_base calculation
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
 <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
 <2efbfc94187d9f0968e5b670c9152651cd8f1a5b.1665650564.git.gitgitgadget@gmail.com>
 <221013.867d13ldzm.gmgdl@evledraar.gmail.com>
In-Reply-To: <221013.867d13ldzm.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/10/2022 20:21, Ævar Arnfjörð Bjarmason wrote:
>> +static void fill_branch_base(struct rebase_options *options,
>> +			    struct object_id *branch_base)
>> +{
>> +	struct commit_list *merge_bases = NULL;
>> +
>> +	merge_bases = get_merge_bases(options->onto, options->orig_head);
>> +	if (!merge_bases || merge_bases->next)
>> +		oidcpy(branch_base, null_oid());
>> +	else
>> +		oidcpy(branch_base, &merge_bases->item->object.oid);
>> +
>> +	free_commit_list(merge_bases);
>> +}
> 
> I wondered if this could be a bit shorter/less wrap-y

Where's the wrapping?

> with shorter
> variable names, anyway, I see it's code copied from above, so nevermind
> in advance... :)

As it is copied it is easier to review leaving it as is I think.
  	
> 	static void fill_branch_base(struct rebase_options *o, struct object_id *dst)
> 	{
> 		struct commit_list *mb = get_merge_bases(o->onto, o->orig_head);
> 		const struct object_id *src = (!mb || mb->next) ? null_oid() :
> 			&mb->item->object.oid;
> 	
> 		oidcpy(dst, src);
> 		free_commit_list(mb);
> 	}
> 
> 	
>> @@ -1669,8 +1678,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>>   		if (!options.onto)
>>   			die(_("Does not point to a valid commit '%s'"),
>>   				options.onto_name);
>> +		fill_branch_base(&options, &branch_base);
>>   	}
>> -
>>   	if (options.fork_point > 0)
>>   		options.restrict_revision =
>>   			get_fork_point(options.upstream_name, options.orig_head);
> 
> I wouldn't mind the stray whitespace change, but here it seems
> unintentional, in 7/8 your change on top is:

Thanks, well spotted, I'm sure I've fixed this at least once already, I 
must have reintroduced it when fixing a rebase conflict. I'll fix it again.

Best Wishes

Phillip
	
> 	@@ -1680,6 +1691,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> 	 				options.onto_name);
> 	 		fill_branch_base(&options, &branch_base);
> 	 	}
> 	+	if (keep_base && options.reapply_cherry_picks)
> 	+		options.upstream = options.onto;
> 	+
> 	 	if (options.fork_point > 0)
> 	 		options.restrict_revision =
> 	 			get_fork_point(options.upstream_name, options.orig_head);
> 
> Presumably we want to have \n\n spacing for both of those, and to not
> remove the spacing here in 6/8, only to add it back?
