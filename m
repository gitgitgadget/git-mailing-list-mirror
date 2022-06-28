Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996C5C43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 19:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiF1Tqb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 15:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiF1TqP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 15:46:15 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5943E32EC9
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 12:40:41 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id l24so13881297ion.13
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 12:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jtiG4PDN+DAC8Cg8XUNNi/qcvU+o5NDscMtRXtE6eB0=;
        b=BxMBckxPXlXlhGLq2j5nVTEF86Ggh0xUJA4CidyOkuZvW71Tm96ImwfrtRgto+WE/O
         1VGTriCs6VfBe6nlH3Rkvrdc3qnwsqy3VJMlQHvmiZFLVh2i4R9sAxABUxQQRcFPNwTq
         rNz/5TiIgouDnRMn0PQT2A5wiz0w7cXG6Nezp6WKAvhQDZzewND9SyyQ91iPZq3FkmO6
         +hBfxPz8V3cIy6teFeiRSlxxxm3LPpaYF5aQ3WDLUGMTL3h/cZaGqrk3PFYSwac/1eC1
         CcMkEREEs8XY8ahtwQXt6ESGGHAHcUi2FUrLKGuhi82UYHUeKgsF1M/evfHZoBmIInqy
         8hrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jtiG4PDN+DAC8Cg8XUNNi/qcvU+o5NDscMtRXtE6eB0=;
        b=Uv9/GW8AghfHk5PDEhy1QEZhMGjBXpNOka/Ypx0ijXbiCXaVHwHqLQ4XN3xNlBXd8E
         07bUhGK+w6QuNsoei/O2gnKHTbtPCW6//bEFwCF+4VngVZjC9f4iTCvJgbaBryXkNCep
         p4bAAqt4Egqh3p0X2Iwraql+0T40fefkeY1lNP1FuXaCQJLsxKtnBF49UVaSwhdmKxiD
         Nj8M2T1tallaGWb2GdJ84juUGDnozVTTnE73xSi/aIv1ovG2L5hgXUt/NlQhp1ECJ6mP
         r3Im35q+J49GdrPCJxUpBW3CDrvi2eYQUX4huXr+y63m3SXyRMYDzu9JPmWiwzK0bDmM
         DUUg==
X-Gm-Message-State: AJIora/RxUZLc/tol/RNsOuQjXYlNHv94euh3DYz3IGsJwYzUFhaBbBR
        ebHQs691uCpuuQK0M5LC3xCzGEqa3tgm
X-Google-Smtp-Source: AGRyM1vu8G9iYXzI7d9PSlpZ/yBDK+yRmnHcryXWWUJ8uDk6ibq4UtNT/EOPi2lrzMmZlPLXEO1SZw==
X-Received: by 2002:a05:6638:3a0a:b0:339:ec66:febd with SMTP id cn10-20020a0566383a0a00b00339ec66febdmr11443879jab.313.1656445240692;
        Tue, 28 Jun 2022 12:40:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e803:5ac5:fad4:b3b2? ([2600:1700:e72:80a0:e803:5ac5:fad4:b3b2])
        by smtp.gmail.com with ESMTPSA id e39-20020a022127000000b0032e49fcc241sm6417834jaa.176.2022.06.28.12.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 12:40:40 -0700 (PDT)
Message-ID: <3fa71e6f-ebc4-b3f3-4624-777ad03a4fe2@github.com>
Date:   Tue, 28 Jun 2022 15:40:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] git-rebase.txt: use back-ticks consistently
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, Johannes.Schindelin@gmx.de
References: <pull.1270.git.1656364861242.gitgitgadget@gmail.com>
 <xmqqmtdwlodw.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqmtdwlodw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/28/2022 12:54 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>      3. Focus on the edits that most-recently edited these lines. Doing some
>>         scripting, I was able to construct this date-sorted list of previous
>>         edits (by diffing the git blame output before and after this
>>         change). The most-recent changes before this are:
>>     
>>     2005-08-26: 52a22d1e726 ([PATCH] Subject: [PATCH] Add some documentation., 2005-08-26)
>> ...
>>     2022-04-20: 9e5ebe9668a (rebase: use correct base for --keep-base when a branch is given, 2022-04-20)
> 
> That is a new concept ;-) 
> 
> It is an interesting exercise to see which previous changes had
> these mark-up mistakes, but it is not immediately obvious to me how
> we can take advantage of the information.

I just wanted to see how much of these edits were due to "really old
documentation from when we had different habits" and how many were
related to recent updates, so I should give more pause. I think the
discussion about the "apply" versus "merge" backends should have
given me more pause because those sections were written recently and
are more likely to have correct punctuation.
 
>>     I look forward to feedback on how to do this better (if it is indeed a
>>     good idea to do in the first place).
> 
> Correcting mark-up to result in an easier-to-read documentation is a
> good idea, of course.  I wonder if we can also help the developers
> mark-up correctly in their first attempt (e.g. do we have clear and
> concise guidelines that are well publicized?)

I'm not sure we have them well publicized. It's worth thinking about.

Hopefully creating a more standard use within at least one (long) file
will help establish some patterns organically.

>>  --strategy-option=<strategy-option>::
>>  	Pass the <strategy-option> through to the merge strategy.
>>  	This implies `--merge` and, if no strategy has been
>> -	specified, `-s ort`.  Note the reversal of 'ours' and
>> -	'theirs' as noted above for the `-m` option.
>> +	specified, `-s ort`.  Note the reversal of `ours` and
>> +	`theirs` as noted above for the `-m` option.
> 
> These references to "ours" and "theirs" is what we called out
> earlier in the "swapped" description (hunk -348,10), i.e.
> 
> 	when a merge conflict happens, the side reported as 'ours'
> 	is the so-far rebased series ... and 'theirs' is the working
> 	branch.
> 
> which the patch left in 'emphasis' not `verbatim`.  I think this
> section should do the same.
> 
> The 'ours' (but not 'theirs' because there is no such thing) that is
> explained as useless as a strategy in the intervening paragraph
> (hunk -360,9) refers to the name of a strategy, and it is correct to
> mark it as `verbatim`.
Thanks!

>>  --ignore-whitespace::
>>  	Ignore whitespace differences when trying to reconcile
>> -differences. Currently, each backend implements an approximation of
>> -this behavior:
>> +	differences. Currently, each backend implements an approximation of
>> +	this behavior:
>>  +
>> -apply backend: When applying a patch, ignore changes in whitespace in
>> +'apply backend:' When applying a patch, ignore changes in whitespace in
>> ...
>> -merge backend: Treat lines with only whitespace changes as unchanged
>> +'merge backend:' Treat lines with only whitespace changes as unchanged
> 
> It somehow looks curious (at the source level---I haven't seen the
> formatted HTML output) to have the punctuation colon as part of the
> phrase marked up.  I wonder if these were meant to be more like so:
> 
> 	apply backend;;
> 		When applying a patch, ...
> 
> 	merge backend;;
> 		Treat lines with ...

This appears to work well. The doc-diff shows this:

-           apply backend: When applying a patch, ignore changes in whitespace
-           in context lines. Unfortunately, this means that if the "old" lines
-           being replaced by the patch differ only in whitespace from the
-           existing file, you will get a merge conflict instead of a
-           successful patch application.
+           apply backend:
+               When applying a patch, ignore changes in whitespace in context
+               lines. Unfortunately, this means that if the "old" lines being
+               replaced by the patch differ only in whitespace from the
+               existing file, you will get a merge conflict instead of a
+               successful patch application.
 
-           merge backend: Treat lines with only whitespace changes as
-           unchanged when merging. Unfortunately, this means that any patch
-           hunks that were intended to modify whitespace and nothing else will
-           be dropped, even if the other side had no changes that conflicted.
+           merge backend:
+               Treat lines with only whitespace changes as unchanged when
+               merging. Unfortunately, this means that any patch hunks that
+               were intended to modify whitespace and nothing else will be
+               dropped, even if the other side had no changes that conflicted.

>> @@ -536,8 +536,8 @@ See also REBASING MERGES and INCOMPATIBLE OPTIONS below.
>>  
>>  -x <cmd>::
>>  --exec <cmd>::
>> -	Append "exec <cmd>" after each line creating a commit in the
>> -	final history. <cmd> will be interpreted as one or more shell
>> +	Append `exec <cmd>` after each line creating a commit in the
>> +	final history. `<cmd>` will be interpreted as one or more shell
>>  	commands. Any command that fails will interrupt the rebase,
>>  	with exit code 1.
> 
> As noticed by others, "git help -m rebase" is somewhat harmed with
> this change when rendered to plain text without any attributes.  The
> roff output actually is
> 
>     .RS 4
>     Append
>     \fBexec <cmd>\fR
>     after each line creating a commit in the final history\&.
> 
> and even on plain text tty, "exec <cmd>" part is now shown in bold
> (as opposed to be in plain text inside double quotes, which was how
> the original got rendered).  So I think this change is an
> improvement.

Thanks for digging into the details here. It would be interesting if
doc-diff could make this clearer, but that's a project for another time.

Thanks,
-Stolee
