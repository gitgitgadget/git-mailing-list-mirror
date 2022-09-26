Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABB7C07E9D
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 15:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbiIZPCZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 11:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbiIZPBy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 11:01:54 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A11B8663
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 06:32:16 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id i16so3527113ilq.0
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 06:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=0tgxJeGYg6V9RjoWoPhtFyKqT976BFSAj+zdPQCZQ44=;
        b=Tp9t9/rOXvVsaapq2BKyhAAnbFAFZmHEizJf3ingRcccfmdkjGLbGv6haaagV0Whwi
         7CWRv7MUHTEiVzsANDlXR5tNcX/m/s5koB8tvuUMIlVsREE3fYK7PCDnXhtBZ+vjZxyR
         EeoFoghjM7rOnCMYRWPEv5VQDnVEgxdZ2Yy8JU+CvpFilLrJyd8d7P/8QeUhzkrzcN9S
         uVDQCw0lqoMkP5FOQv8BIl7kekSNR5hKbCPWSv7CSDMdP2rk9EQUvXJzXJF6PDnKGgoj
         Af+/00IHy29sUW45lsrpzRA4loi5ZYAwN/eKFVtSdxEc2kuBNIRyuF87smRgplTBHxok
         AOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=0tgxJeGYg6V9RjoWoPhtFyKqT976BFSAj+zdPQCZQ44=;
        b=S1/0ZxtWjqGy8VHDqquxSjCb94mZanOm2FeN18yHjinjlaTmD9GfiSD8ROuNVnA4+V
         SpDG47Z/5jDDo9AusvkGPuE4yhAPEiw1dAMlLSqLrCk3oxC5KD+BxpmaklmMtde5O2w3
         ke50dMH5+M0z+6TEiSWyBZ2HywkRh/oJtyW/fdbPtt3SIgGtr89djX2ruaPV3b0YqumH
         lWXF1bviVB5su55cOvUg/KrucFUvk5kD9Ivb7qE3t4IRw5j+2v1JFaxvZRADGySkHbDl
         kJMnbnFBQC+GJVDJWfjAOSwCi17JNbwnJX4Vm3BzQlHD4/wM2aOKYD554+Cl3MfA4LRt
         3HJA==
X-Gm-Message-State: ACrzQf1b28oBGPKLdH3hmuCngeYBnhmYoAMz35q+FG+phT/z4TSp4AAZ
        ae5+TDw2ngPpaCrFOZavpqguTFWcrpqR
X-Google-Smtp-Source: AMsMyM6xzOTLutqlUL+DkM6D6ck+kUZoqm37SRQmq3BgQPWltUUmFstvBVzyEKpsg4Vvuu5T1Qxqrw==
X-Received: by 2002:a92:6912:0:b0:2ea:fa2e:462d with SMTP id e18-20020a926912000000b002eafa2e462dmr10236505ilc.155.1664199136043;
        Mon, 26 Sep 2022 06:32:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:6c7d:bb49:cfa:a946? ([2600:1700:e72:80a0:6c7d:bb49:cfa:a946])
        by smtp.gmail.com with ESMTPSA id x4-20020a92de04000000b002f4e385252asm6418203ilm.39.2022.09.26.06.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 06:32:15 -0700 (PDT)
Message-ID: <fc6739c3-2f7c-5dab-e4a2-8243deafde50@github.com>
Date:   Mon, 26 Sep 2022 09:32:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 1/2] maintenance: add 'unregister --force'
Content-Language: en-US
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com
References: <pull.1358.git.1663635732095.gitgitgadget@gmail.com>
 <pull.1358.v2.git.1663853837.gitgitgadget@gmail.com>
 <69c74f52eefd906c38494759a02e137e4d7c01d8.1663853837.git.gitgitgadget@gmail.com>
 <20220923130832.GA1761@szeder.dev>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220923130832.GA1761@szeder.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/23/2022 9:08 AM, SZEDER Gábor wrote:
> On Thu, Sep 22, 2022 at 01:37:16PM +0000, Derrick Stolee via GitGitGadget wrote:
>>  static int maintenance_unregister(int argc, const char **argv, const char *prefix)
>>  {
>> +	int force = 0;
>>  	struct option options[] = {
>> +		OPT_BOOL(0, "force", &force,
>> +			 N_("return success even if repository was not registered")),
> 
> This could be shortened a bit by using OPT__FORCE() instead of
> OPT_BOOL().  OTOH, please make it a bit longer, and declare the option
> with the PARSE_OPT_NOCOMPLETE flag to hide it from completion:

Looks like I can do both like this:

		OPT__FORCE(&force,
			   N_("return success even if repository was not registered"),
			   PARSE_OPT_NOCOMPLETE),

>> @@ -1538,11 +1545,23 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
>>  		usage_with_options(builtin_maintenance_unregister_usage,
>>  				   options);
>>  
>> -	config_unset.git_cmd = 1;
>> -	strvec_pushl(&config_unset.args, "config", "--global", "--unset",
>> -		     "--fixed-value", "maintenance.repo", maintpath, NULL);
>> +	for_each_string_list_item(item, list) {
>> +		if (!strcmp(maintpath, item->string)) {
>> +			found = 1;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (found) {
>> +		config_unset.git_cmd = 1;
>> +		strvec_pushl(&config_unset.args, "config", "--global", "--unset",
>> +			     "--fixed-value", key, maintpath, NULL);
>> +
>> +		rc = run_command(&config_unset);
> 
> It seems a bit heavy-handed to fork() an extra git process just to
> unset a config variable.  Wouldn't a properly parametrized
> git_config_set_multivar_in_file_gently() call be sufficient?  Though
> TBH I don't offhand know what those parameters should be, in
> particular whether there is a convenient way to find out the path of
> the global config file in order to pass it to this function.
> 
> (Not an issue with this patch, as the context shows that this has been
> done with the extra process before; it just caught my eye.)

Thanks. I'll look into it.

-Stolee
