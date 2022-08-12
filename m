Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34C1C00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 17:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239502AbiHLRAi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 13:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239536AbiHLRAe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 13:00:34 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C6E205CC
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 10:00:33 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t22-20020a17090a449600b001f617f2bf3eso7842384pjg.0
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 10:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=QfGb9GRNvmqC09qV7s5CN2A251DfYHElh/6N8/L4ScM=;
        b=MnSbAdjPAUa9HzTsKYhlWwacOszbcGPYwZ8eaf5GoYU/SuSZ+M7T/r3hMrXjxcPHaK
         HXtI+CPohJroa52NRjIQkQB2/r14qjcZdmKL5z/bB80cHILSDZxBuYIgBsPf7ye09JLW
         FyZwcPCTp8MBkTbURFA3kMdj3p/BYRciMBBDU6BQri/hFSjMukCpw2EVJON+vI89P7yO
         +aTZOAWw0/qRPTXYSTXBoAMtZHV8KvPv+KYjzUKEvdnQyFKL+nkdu2Ivq81V5P5ezxjH
         ezgQqmNEU09TT7R9KDz7HwHWi8Dt0fjW8imkgoMzT3ptk/x9f6r3TDooGukDNLeSfmVK
         JIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=QfGb9GRNvmqC09qV7s5CN2A251DfYHElh/6N8/L4ScM=;
        b=0NXs6kUk49gaaszU3hH7HmaQe5EFdcFa5aY83VRiCsxlyR8EGSXL5pnIXWRUaYwU+E
         8KIzAE2HFbZ08VlVBHEGAF34ENxGRqQlSgJfgHcVjybJmlDr002Z7CmNhqZogCeu53sy
         D/oWyKwP1VcmI7WPYr5cOjL9GtuFNQdZckrdAQWOW8rrRNEJmVAcCOt4JcWE8Fo45HSr
         Uic6o4kcPVgL7+KRFQq6vgVwUKfnHxSJ/LjZ7R24gh//mHc8RgHWErIlvhegvMopfiVp
         61NWXW5NFO7U1Oz4sZumwfC6kuiQOYC68xwrbBfjsjLGR2SEvyAVR8SiNn4y7uQEb2KR
         mWqA==
X-Gm-Message-State: ACgBeo0pch9XwPoWA+QbF1Szcybtj0p71OJ8xrRMQvL01TTqoRyFGltX
        3Y9RkrDqRtbdppQD22CxROaX
X-Google-Smtp-Source: AA6agR7cozskzq8G8m7D7wkeHROCh3w/tJ6defQu3N743FumZUlq56GebF4RRD7iF0W12HmEAeAoGg==
X-Received: by 2002:a17:902:bd08:b0:16d:4230:cb45 with SMTP id p8-20020a170902bd0800b0016d4230cb45mr4881037pls.59.1660323632508;
        Fri, 12 Aug 2022 10:00:32 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902d48100b001709e3c755fsm1989493plg.230.2022.08.12.10.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 10:00:31 -0700 (PDT)
Message-ID: <32f2cadc-556e-1cd5-a238-c8f1cdaaf470@github.com>
Date:   Fri, 12 Aug 2022 10:00:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v3 06/11] diagnose.c: add option to configure archive
 contents
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
 <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
 <0a6c55696d88cde666c11cd6b5d723c9e75a3b76.1660174473.git.gitgitgadget@gmail.com>
 <xmqq8rnviqhz.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqq8rnviqhz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> @@ -177,11 +182,13 @@ int create_diagnostics_archive(struct strbuf *zip_path)
>>  	loose_objs_stats(&buf, ".git/objects");
>>  	strvec_push(&archiver_args, buf.buf);
>>  
>> -	if ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
>> -	    (res = add_directory_to_archiver(&archiver_args, ".git/hooks", 0)) ||
>> -	    (res = add_directory_to_archiver(&archiver_args, ".git/info", 0)) ||
>> -	    (res = add_directory_to_archiver(&archiver_args, ".git/logs", 1)) ||
>> -	    (res = add_directory_to_archiver(&archiver_args, ".git/objects/info", 0)))
>> +	/* Only include this if explicitly requested */
>> +	if (mode == DIAGNOSE_ALL &&
>> +	    ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
>> +	     (res = add_directory_to_archiver(&archiver_args, ".git/hooks", 0)) ||
>> +	     (res = add_directory_to_archiver(&archiver_args, ".git/info", 0)) ||
>> +	     (res = add_directory_to_archiver(&archiver_args, ".git/logs", 1)) ||
>> +	     (res = add_directory_to_archiver(&archiver_args, ".git/objects/info", 0))))
>>  		goto diagnose_cleanup;
> 
> At first glance, it looks as if this part fails silently, but
> add_directory_to_archiver() states what failed there, so we show
> necessary error messages and do not silently fail, which is good.
> 
> There is a "failed to write archive" message after write_archive()
> call returns non-zero, but presumably write_archive() itself gives
> diagnostics (like "oh, I was told to archive this file but I cannot
> read it") when it does so, so in a sense, giving the concluding
> "failed to write" only in that case might make the error messages
> uneven.  If we fail to enlist ".git/hooks" directory, we may want to
> say why we failed to do so, and then want to see the concluding
> "failed to write" at the end, just like the case where write_archive()
> failed.
> 
> It is a truely minor point, and if it turns out to be worth fixing,
> it can be easily done by moving the diagnose_clean_up label a bit
> higher, i.e.
> 
> 	...
> 	res = write_archive(...);
> 
> diagnose_cleanup:
> 	if (res)
> 		error(_("failed to write archive"));
> 	else
>         	fprintf(stderr, "\n"
> 			"Diagnostics complete.\n"
> 			"All of the gathered info is captured in '%s'\n",
> 			zip_path->buf);
> 
> 	if (archiver_fd >= 0) {
> 		... restore FD#1 and close stdout_fd and archiver_fd
> 	}
> 	...
>

I like this idea, since I think there's value in indicating both the cause
("could not open directory") and effect ("failed to write archive") of the
error. I'll include this and [1] in a re-roll. Thanks!

[1] https://lore.kernel.org/git/9d1b0cb9-5c21-c101-8597-2fe166cb6abe@github.com/

> 
> Other than that, this new patch looks good to me.
> 
> Thanks.

