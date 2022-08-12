Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D250C00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 21:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbiHLVAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 17:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiHLVAr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 17:00:47 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FAF98CB0
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 14:00:45 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 130so1903160pfv.13
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 14:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=WFLCZLEH8vcWpM+3Y1vqsFA9f+g6dMh79JiowwdaVTg=;
        b=Rc3AhLMBnRSB4D7w9c7LuWSHm9WKilC4/EsghFGQo2xzUCQEO65g9LYhHY0O3HK2YW
         irZOrLr4+9tPRe8aBCCXhsOqXjJp7iT48yYxuUl1cIt7Go/3maCF0bcGzzCzEZWdKlEK
         ig5B8ruKpxaLNwCTlHykiemvS3orH9pU0akpDFZLVirZKl8BRo5J7Xy7+Rcl0FfsaG90
         2a14BB9UKI3zL+CYUcSsha6abe9cStD0FbqS59pNIJm23/ivDXI8BUsW8nrCa+QU4EBN
         zuM/S/UfXTUXIfUXGGQe4Mfi6cs3MlXHNUSpFjazwgtOvRoDPq1njPQS7DCt7GY9Ga6c
         B6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=WFLCZLEH8vcWpM+3Y1vqsFA9f+g6dMh79JiowwdaVTg=;
        b=c+HnIVyHF8n84jLJWvBJHrZoJ7Jo7haXeF3La495rQu/SQOqgYMcRjecQblUWEZLpg
         tWGbCEBl8L5arjjBuM/K2+mNgDh1W+LJsF5YxcdgUMGwlQWOOiYUG2biGVPKX+yDDdIw
         cPHut7AF6ZptzWDoxiuOX/7lMf4TyZqFc4Pa42q4EecTvtMzVHzYAAqonOXSxpqf+kUZ
         gvjwAFfgQOwGe3yCKQBr6gpuRKAD+t3to+sABOQ/36njyRbos3ZcjO4Nps/jEPnK+KNF
         W41RqUsd2XBu+Mj5mzbvx/UpjLG0H15EDf2R1TH8efGSkJx/QGkYKnaZBWBadxA9WyIv
         jCGw==
X-Gm-Message-State: ACgBeo1d45JaXKFVczJZVKJIYcYSFivWHq9i6/iHnuqfGC5mzbEGROZC
        9atHK+fsZaJN43zGQ8MSoeP9
X-Google-Smtp-Source: AA6agR4sHqc/tjXzZmsg5Ju3Bi5NKk6pz7vVbEkZ221NTHADVkqAn69hT7Ob3q1XYj38aNT14mygpg==
X-Received: by 2002:a63:9042:0:b0:41c:cdd4:ae66 with SMTP id a63-20020a639042000000b0041ccdd4ae66mr4418446pge.47.1660338043161;
        Fri, 12 Aug 2022 14:00:43 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id a5-20020a17090a70c500b001f23db09351sm232557pjm.46.2022.08.12.14.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 14:00:42 -0700 (PDT)
Message-ID: <a728c894-4e4a-44c3-a1f5-f87c8bfae13a@github.com>
Date:   Fri, 12 Aug 2022 14:00:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v4 05/11] scalar-diagnose: move functionality to common
 location
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
 <pull.1310.v4.git.1660335019.gitgitgadget@gmail.com>
 <c19f3632d4f2f966517a276e7096742c8477125c.1660335019.git.gitgitgadget@gmail.com>
 <xmqq7d3db43z.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqq7d3db43z.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +	res = write_archive(archiver_args.nr, (const char **)argv_copy, NULL,
>> +			    the_repository, NULL, 0);
>> +	if (res) {
>> +		error(_("failed to write archive"));
>> +		goto diagnose_cleanup;
>> +	}
>> +
>> +	fprintf(stderr, "\n"
>> +		"Diagnostics complete.\n"
>> +		"All of the gathered info is captured in '%s'\n",
>> +		zip_path->buf);
>> +
>> +diagnose_cleanup:
>> +	if (archiver_fd >= 0) {
>> +		dup2(stdout_fd, STDOUT_FILENO);
>> +		close(stdout_fd);
>> +		close(archiver_fd);
>> +	}
> 
> Hmph, after reading 
> 
> https://lore.kernel.org/git/32f2cadc-556e-1cd5-a238-c8f1cdaaf470@github.com/
> 
> I would have expected to see the above part more like:
> 
>                 res = write_archive(...);
> 
>         diagnose_cleanup:
>                 if (res)
>                         error(...);
>                 else
>                         fprintf(stderr, "Diag complete");
> 
>                 if (archiver_fd >= 0) {
>                         ...
> 

I originally planned to implement it this way, but instead went with adding
an error printout explicitly for failed 'add_directory_to_archiver()' calls
(in patch 6 [1]). I elaborated on the thought process/reasoning for
modifying the approach in the cover letter [2]:

> Improved error reporting in 'create_diagnostics_archive()'. I was
> originally going to modify the "failed to write archive" error to trigger
> whenever 'create_diagnostics_archive()' returned a nonzero value.
> However, while working on it I realized the message would no longer be
> tied to a failure of 'write_archive()', making it less helpful in
> pinpointing an issue. To address the original issue
> ('add_directory_to_archiver()' silently failing in
> 'create_diagnostics_archive()'), I instead refactored those calls into a
> loop and added the error message. Now, there's exactly one error message
> printed for each possible early exit scenario from
> 'create_diagnostics_archive()', hopefully avoiding both redundancy &
> under-reporting.

To add a bit more context: when I used the "move 'diagnose_cleanup'"
approach, I felt that the added message was either redundant or too general
to help a user identify an issue. Redundancy appeared when, for example,
'dup2()' returned a nonzero code; if that happened, we'd get the printouts:

$ git diagnose --suffix test
error: could not redirect output: <ERRNO error message>
error: could not write archive
error: unable to create diagnostics archive 'git-diagnostics-test.zip': <ERRNO error message>

The first two are from 'create_diagnostics_archive()', and the second
doesn't really give us information that we don't get out of the third (in
'builtin/diagnose.c').

Conversely, a failure in 'add_directory_to_archiver()' and 'write_archive()'
would give us the same printouts (at least within the scope of
'diagnose.c'/'builtin/diagnose.c'):

$ git diagnose --suffix test
error: could not write archive
error: unable to create diagnostics archive 'git-diagnostics-test.zip: <some error message>

Previously, "could not write archive" would point someone debugging to
'write_archive()'; now, it's unclear.

I ended up settling on adding the error message directly to the
'add_directory_to_archiver()' loop in patch 6 because it meant that:

1. 'create_diagnostics_archive()' would only ever print one error message;
   the others printed would indicate (IMO more clearly) where in the call
   stack the error happened
2. there would be a unique error message for each condition that caused
   'create_diagnostics_archive()' to exit early

Apologies for not sending another reply with these details before
re-rolling. I'll be more direct when changing plans in the future.

Thanks!

[1] https://lore.kernel.org/git/710b67e5776363d199ed5043d019386819d44e7e.1660335019.git.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/pull.1310.v4.git.1660335019.gitgitgadget@gmail.com/
