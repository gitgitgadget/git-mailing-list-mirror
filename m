Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DD7C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 16:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244474AbiHIQy3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 12:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242649AbiHIQy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 12:54:28 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999DA2229C
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 09:54:27 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso18243553pjo.1
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 09:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=DtgVHt83hoeXeWfN/DpHfFtLIaP26/Ya/V4m3ZHE89k=;
        b=F67fRxHcJeS6nuwbQPJIAayXmpwd4EERWgYZomV6T57WudyCbbKSSgfE9BGqdfFnD7
         JGdquEggdYIeuU2l2SraNRDngdAk49QDo0ijIeAOOp/9X2u6qG3yi4IVLkKI/9lDOoV8
         sNpdUnWHkUT1PmixLCxZN2kZDrbBz7HyG4JEomAkMWkFRsHUkSpvbLynfr5/vv20xoyI
         nfYg/fgzawoy0O3dRnQZ9RumzE9aPSe91S5zqnzwtAg8eKJfNCQcNmgZb6eSKk/qRUCu
         iiMtRKlhwFN4dfdqB+daa+UIZDDro+CgmgqZdfo2LFZRZpuAfpF61sRoNgSylOnTwJQ9
         e50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=DtgVHt83hoeXeWfN/DpHfFtLIaP26/Ya/V4m3ZHE89k=;
        b=QU7mIEJmEOkxr/b7gMfc5oklFC83ksElJZZ3QxQ7MHkVBlOUuGjg2B8OPpspw++CdA
         f3mVMZHbF9HiSFtLMIC9EDKaeZjhstTE2kuJmuFZSlUZOghcjX9hbOIKuVGNzQLeXBWL
         wW/FtTB+JNHaxWw4S5MYeTftoSfIGFIX+2TY80B/API5LU69fqATlP0yTTkBu+WexXXG
         gJKTij31EEvYIk7de42V8E/K/VmgH6YOGHrqwKVXrD4idndaUPZ8N6pZcCFylFxgNKOQ
         h8wM92N2PxEvwzPv008mWD5X2MmGix/PsTXTMjHoC5PA7GvOhnUgVbiSMI8gCbKgrhzy
         a6gA==
X-Gm-Message-State: ACgBeo16GWHrv1cc++reHRqnCnCFk8WICbI1MEH5NGFuOOU7nErCiSqe
        SDnH3gWDwzZsBX9jfh1ExigQ
X-Google-Smtp-Source: AA6agR797JFpsDNmzb+4SeTyIpaa72zKXlxFLEbAcEI0ghq5sSaXWQPMu79utUAeGUfizDpn9Shp9g==
X-Received: by 2002:a17:90a:9dc7:b0:1f3:1a8:41a1 with SMTP id x7-20020a17090a9dc700b001f301a841a1mr27373212pjv.23.1660064067110;
        Tue, 09 Aug 2022 09:54:27 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id y7-20020aa79ae7000000b0052aaf7fe731sm141555pfp.45.2022.08.09.09.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 09:54:26 -0700 (PDT)
Message-ID: <73f168c4-543c-9ff3-5bf2-9a4c789d7fad@github.com>
Date:   Tue, 9 Aug 2022 09:54:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v2 09/10] scalar-diagnose: use 'git diagnose --all'
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
 <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
 <6834bdcaea838cc49f209efd785bf2bdf09e9c08.1659577543.git.gitgitgadget@gmail.com>
 <220804.86r11webp8.gmgdl@evledraar.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <220804.86r11webp8.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Aug 04 2022, Victoria Dye via GitGitGadget wrote:
> 
>> From: Victoria Dye <vdye@github.com>
>>
>> Replace implementation of 'scalar diagnose' with an internal invocation of
>> 'git diagnose --all'. This simplifies the implementation of 'cmd_diagnose'
>> by making it a direct alias of 'git diagnose' and removes some code in
>> 'scalar.c' that is duplicated in 'builtin/diagnose.c'. The simplicity of the
>> alias also sets up a clean deprecation path for 'scalar diagnose' (in favor
>> of 'git diagnose'), if that is desired in the future.
>>
>> This introduces one minor change to the output of 'scalar diagnose', which
>> is that the prefix of the created zip archive is changed from 'scalar_' to
>> 'git-diagnostics-'.
>>
>> Signed-off-by: Victoria Dye <vdye@github.com>
>> ---
>>  contrib/scalar/scalar.c | 29 +++++++----------------------
>>  1 file changed, 7 insertions(+), 22 deletions(-)
>>
>> diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
>> index b10955531ce..fe2a0e9decb 100644
>> --- a/contrib/scalar/scalar.c
>> +++ b/contrib/scalar/scalar.c
>> @@ -11,7 +11,6 @@
>>  #include "dir.h"
>>  #include "packfile.h"
>>  #include "help.h"
>> -#include "diagnose.h"
>>  
>>  /*
>>   * Remove the deepest subdirectory in the provided path string. Path must not
>> @@ -510,34 +509,20 @@ static int cmd_diagnose(int argc, const char **argv)
>>  		N_("scalar diagnose [<enlistment>]"),
>>  		NULL
>>  	};
>> -	struct strbuf zip_path = STRBUF_INIT;
>> -	time_t now = time(NULL);
>> -	struct tm tm;
>> +	struct strbuf diagnostics_root = STRBUF_INIT;
>>  	int res = 0;
>>  
>>  	argc = parse_options(argc, argv, NULL, options,
>>  			     usage, 0);
>>  
>> -	setup_enlistment_directory(argc, argv, usage, options, &zip_path);
>> -
>> -	strbuf_addstr(&zip_path, "/.scalarDiagnostics/scalar_");
>> -	strbuf_addftime(&zip_path,
>> -			"%Y%m%d_%H%M%S", localtime_r(&now, &tm), 0, 0);
>> -	strbuf_addstr(&zip_path, ".zip");
>> -	switch (safe_create_leading_directories(zip_path.buf)) {
>> -	case SCLD_EXISTS:
>> -	case SCLD_OK:
>> -		break;
>> -	default:
>> -		error_errno(_("could not create directory for '%s'"),
>> -			    zip_path.buf);
>> -		goto diagnose_cleanup;
> 
> Just spotting this now, but we had ad error, but we "goto
> diagnose_cleanup", but that will use our "res = 0" above.
> 
> Is this untested already or in this series (didn't go back to look). But
> maybe a moot point, the post-image replacement uses die()..

Nice catch - this does appear to be a pre-existing bug in 'scalar diagnose'.
Given that both 'git diagnose' and 'git bugreport --diagnose' handle this
case more appropriately, though, I agree that it's a bit of a moot point and
not worth the churn created by a bugfix patch.

> 
>> -	}
>> +	setup_enlistment_directory(argc, argv, usage, options, &diagnostics_root);
>> +	strbuf_addstr(&diagnostics_root, "/.scalarDiagnostics");
>>  
>> -	res = create_diagnostics_archive(&zip_path, 1);
>> +	if (run_git("diagnose", "--all", "-s", "%Y%m%d_%H%M%S",
>> +		    "-o", diagnostics_root.buf, NULL) < 0)
>> +		res = -1;
> 
> The code handling here seems really odd, issues:
> 
>  * This *can* return -1, if start_command() fails, but that's by far the
>    rarer case, usually it would be 0 or >0 (only <0 if we can't start
>    the command at all).
> 
>  * You should not be returning -1 from cmd_*() in general (we have
>    outstanding issues with it, but those should be fixed). It will yield
>    an exit code of 255 (but it's not portable)).
> 
>  * If you're going to return -1 at all, why override <0 with -1, just
>    "res = run_git(...)" instead?

Thanks for the info, I'll replace the hardcoded '-1' return value with
something derived from 'res' in the next version.

> 
> I think all-in-all this should be:
> 
> 	res = run_git(...);
> 
> Then:
> 
>>  
>> -diagnose_cleanup:
>> -	strbuf_release(&zip_path);
>> +	strbuf_release(&diagnostics_root);
>>  	return res;
> 
> 	return res < 0 ? -res : res;
> 
> Or whatever.

