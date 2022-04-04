Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BA2C433EF
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 09:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354217AbiDDJ3M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 05:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353978AbiDDJ3B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 05:29:01 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCF83BBE3
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 02:27:05 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q19so6567377wrc.6
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 02:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RIbMsJRrHMZCWg3+3Lsqy/t/F0+JH+QMu5AH7R49mP8=;
        b=blwUrazkhPBIrF8fT4g2DW/59xqJzpTegMk5PHn72d2szTQux09iaASgcLZbxJmf8N
         cPzl6UGohDgrSNbhEm0xdu5AscACXhyPn5TULy31gTxH/PWrr8+eqSL/CEbSAmuGI/Ag
         8SviU1un5r9TDodnu9wP+hw/dpPjBfHQmnCIPcecY4BGcmp4ipVg+q0egAsake1W1dnL
         k0qUMcmiGqQM0AYWcO0owTrtCbxIALUGYua8hQhcXChwXf3EXqk0bYR8w+tVXCr9ET3w
         gvLZ24D1uSCygmZ65sqx60RrgZQ5YRuMLsHtlml0sLqwJu20VgPH2VjWxHEucjJ2ga62
         hEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RIbMsJRrHMZCWg3+3Lsqy/t/F0+JH+QMu5AH7R49mP8=;
        b=RxgIaD52beBBSc+5BAnIcRlOKU4vnYiWjqHEJtTYctw7FtXVIqD71LqhTEaBpsp8fb
         7xaMOH4Iy5vwxYDCrUtQOb6gHvsAHjww35b8WOjJiBYhFememVXpYNfdsr+xZ+6QjvPV
         fkc/z//AUTpnRhZ7PrXUJsKBO+5NbdSf8QK1bJPessmieXZPCgoBAujWktSAQdQY8nOg
         q/F2KiQccIoNkh9VCJ3ueoKaz30EVQhe2pNporvVUE0WnUXLPGm0L7TvOQZ69z/LEFfd
         w7wktDa+z+sQ9P75SBF7SfIgXlogjHuIRSN5HAFb38lPSWsue9kinpz7LM0k6g7L/fMV
         6EQQ==
X-Gm-Message-State: AOAM5307vwrxQtYhJM8lLb0Lsm6ULwjLfXGrOSOQG+atNgGPClXmDfTQ
        VD9XqcnMkSquR+UxV4Caexw=
X-Google-Smtp-Source: ABdhPJzwEoRrM35MIq2a0EwAKeO6xWAlW/GNjt/wlwcBt2WocNzrlgAitk+24ASL0N34zhkl03e+rQ==
X-Received: by 2002:a05:6000:184a:b0:206:1360:4bba with SMTP id c10-20020a056000184a00b0020613604bbamr2399050wri.319.1649064424266;
        Mon, 04 Apr 2022 02:27:04 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.224])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c4e8900b0038cc29bb0e1sm20014449wmq.4.2022.04.04.02.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 02:27:03 -0700 (PDT)
Message-ID: <9b577148-dc7d-cfdd-56ae-edd933cfd1fa@gmail.com>
Date:   Mon, 4 Apr 2022 10:27:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 13/27] revisions API users: use release_revisions() in
 builtin/log.c
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
 <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
 <patch-v4-13.27-02ca92660af-20220331T005325Z-avarab@gmail.com>
 <14c17fa9-e9ff-ac5f-dbda-4a566ed09fd3@gmail.com>
 <220403.865ynqmeun.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220403.865ynqmeun.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 03/04/2022 15:07, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sat, Apr 02 2022, Phillip Wood wrote:
> 
> [A comment on v4, but also applies to v5 I think]
> 
>> On 31/03/2022 02:11, Ævar Arnfjörð Bjarmason wrote:
>>> In preparation for having the "log" family of functions make wider use
>>> of release_revisions() let's have them call it just before
>>> exiting. This changes the "log", "whatchanged", "show",
>>> "format-patch", etc. commands, all of which live in this file.
>>> The release_revisions() API still only frees the "pending" member,
>>> but
>>> will learn to release more members of "struct rev_info" in subsequent
>>> commits.
>>> In the case of "format-patch" revert the addition of UNLEAK() in
>>> dee839a2633 (format-patch: mark rev_info with UNLEAK, 2021-12-16),
>>> which will cause several tests that previously passed under
>>> "TEST_PASSES_SANITIZE_LEAK=true" to start failing.
>>> In subsequent commits we'll now be able to use those tests to check
>>> whether that part of the API is really leaking memory, and will fix
>>> all of those memory leaks. Removing the UNLEAK() allows us to make
>>> incremental progress in that direction. See [1] for further details
>>> about this approach.
>>
>> This breaks "git bisect" but only when running the test suite to
>> detect leaks so I guess that's not too bad. An alternative would be to
>> manually remove the UNLEAK() when you're testing rather than
>> committing the change.
> 
> It doesn't, for this series each individual commit passes with

Oh I'd missed that, thanks for explaining

>      make test
>      GIT_TEST_PASSING_SANITIZE_LEAK=true make test SANITIZE=leak
> 
> And also in a stricter mode that I have locally (not in git yet):
> 
>      make test
>      GIT_TEST_PASSING_SANITIZE_LEAK=check make test SANITIZE=leak
> 
> Which ensures not only that the tests we marked as leak free pass, but
> that no other tests we *haven't* marked pass unexpectedly (requires prep
> changes before this series to mark the still-not-marked-but-should-be
> tests).
> 
> I think that should address/help explain things re your questions about
> some of the UNLEAK() back-and-forth.

Yes it does, the next patch makes sense to me now as well thanks

> [...]
>>> @@ -558,7 +564,7 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
>>>    	cmd_log_init(argc, argv, prefix, &rev, &opt);
>>>    	if (!rev.diffopt.output_format)
>>>    		rev.diffopt.output_format = DIFF_FORMAT_RAW;
>>> -	return cmd_log_walk(&rev);
>>> +	return cmd_log_deinit(cmd_log_walk(&rev), &rev);
>>
>> This is a rather unusual pattern, at first I wondered if there were
>> going to be more added to the body of cmd_log_deinit() in later
>> commits but there isn't so why not just call release_revisions() here
>> to be consistent with the other release_revisions() call that are
>> added in other patches?
> 
> It's just a way to save every single call to this callsite a change on
> top like this:
> 	
> 	diff --git a/builtin/log.c b/builtin/log.c
> 	index 5dad70aa47e..ece03536bed 100644
> 	--- a/builtin/log.c
> 	+++ b/builtin/log.c
> 	@@ -684,8 +684,11 @@ int cmd_show(int argc, const char **argv, const char *prefix)
> 	 	opt.tweak = show_setup_revisions_tweak;
> 	 	cmd_log_init(argc, argv, prefix, &rev, &opt);
> 	
> 	-	if (!rev.no_walk)
> 	-		return cmd_log_deinit(cmd_log_walk(&rev), &rev);
> 	+	if (!rev.no_walk) {
> 	+		ret = cmd_log_walk(&rev);
> 	+		release_revisions(&rev);
> 	+		return ret;
> 	+	}
> 	
> 	 	count = rev.pending.nr;
> 	 	objects = rev.pending.objects;
> 
> Which, given that there's 6 of them nicely cuts down on the resulting
> verbosity.

If you want to adopt this pattern more widely then if there was a helper 
function in revisions.c it could be used in patches 11 and 14 as well as 
this one I think.

Best Wishes

Phillip
