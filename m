Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290E9C433FE
	for <git@archiver.kernel.org>; Sat,  8 Oct 2022 23:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiJHX25 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Oct 2022 19:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJHX24 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2022 19:28:56 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A762E326C9
        for <git@vger.kernel.org>; Sat,  8 Oct 2022 16:28:54 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o5so4839945wms.1
        for <git@vger.kernel.org>; Sat, 08 Oct 2022 16:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jUcv45yljDBlhnxLxXSDghC089+FeUGFbHCZO8/4zY=;
        b=Na7BX7omaPq3wTBxrPA6kDhiecKUeUZmhuz2fo8YV5Xxp9yIPgw7ULqfaV7O059hn4
         9sqfO+43Z2YfR0e8gzGNYxIReKeFfcR/4iMvK8jDQRabehCYEcrCEEjQJrSNqmA8UH2m
         2DhUwHXhifL6OQ8a4r96HOCjsZmEk2nF0O8KQ0U4Tcv3PvvfiMGXNbIG1CiBa9xNE2Wm
         Cl+CNgJixLzzQR2J7sJ5Vefzfe7jBbp2SFwkKbDx/doptAFDeraoRDX0U+zzOmz06r87
         GC55it1EvpeEpyMyI20pYQ7tlo/XgA6mkeKi/MowReQSEB2w1NCZf4XvZ9W5+/qa/zTT
         n4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3jUcv45yljDBlhnxLxXSDghC089+FeUGFbHCZO8/4zY=;
        b=cYvHutkFfLrD7+9HLBntX7DlmrsWtrmGQRpVE0znifJocoP/dHKl2iihFvGUcbJqRP
         yJqlfkLzg0InD2UpamtGP1Q0TLulcyWLGyf8QEg8Vh6u2y8tULCZ905kcj3QZzmPJCwo
         u4N0o7PFSHWEcOTPETcUnvQQIqbaCbPjpHAiqV/AOYnAFn++OiSzs2bQ+RBj4eHqtUv3
         evw975FfmA8vGAoLXFEtop2us2L9zl0mbKQCgQe8xRgObU2LFMxFP1u5Pt6JSuZi8WnQ
         z/djrQZmDVk9CJaU+4k2hbudT7WiP3B/tEpKGeNT7AmwkqbEywbzDGf0Pd+RR9DLCUTg
         GppQ==
X-Gm-Message-State: ACrzQf0WgjiwbHdjQyEcXgrMXaZooTbPnkxGuQ0DNcMCkXZ57bPq3Kfc
        v2XM0aNH+9rjc+P8/sGHOcUgIPYAE9E=
X-Google-Smtp-Source: AMsMyM6IfGhrckf5KQAzWfLI/V0pLtBjc+0xGnQfcwmrDU/ypfp1WwW/m8FUWBW7gM/JTuky6ELiGA==
X-Received: by 2002:a05:600c:1987:b0:3b4:9b03:c440 with SMTP id t7-20020a05600c198700b003b49b03c440mr7259220wmq.14.1665271732962;
        Sat, 08 Oct 2022 16:28:52 -0700 (PDT)
Received: from [192.168.2.52] (138.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.138])
        by smtp.gmail.com with ESMTPSA id d16-20020adf9c90000000b0022dd3aab6bfsm5300277wre.57.2022.10.08.16.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Oct 2022 16:28:52 -0700 (PDT)
Subject: Re: [PATCH v4] branch: support for shortcuts like @{-1}, completed
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
 <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com>
 <7abdb5a9-5707-7897-4196-8d2892beeb81@gmail.com>
 <2e164aea-7dd8-5018-474a-01643553ea49@gmail.com>
 <CAPig+cSX9jSPc_fJc0tuiER1-AqnbFGOk0r1tXEkv9gycVH-CA@mail.gmail.com>
 <f24837e9-7873-c34c-bd78-8ae3be0fc97a@gmail.com>
 <CAPig+cSn29Fq4ywC9zXoJYRVG8KUEhHuDdwEUSioFMUVs+S-ow@mail.gmail.com>
 <a7aca891-dd37-7e5e-61fc-8012fec18ae9@gmail.com>
 <CAPig+cRxy5C+CqUOzmhe16j+hssxsygha3huVga8tLJ+imM4Hw@mail.gmail.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <32e4f8cf-696c-317d-236b-0f64c1398a01@gmail.com>
Date:   Sun, 9 Oct 2022 01:28:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cRxy5C+CqUOzmhe16j+hssxsygha3huVga8tLJ+imM4Hw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 8/10/22 19:10, Eric Sunshine wrote:

>> All of this involves two files and that is how it is done almost everywhere
>> except in some places where it looks like an 'older way' (test_i18ngrep) of
>> doing it.  Is there any reason to do it this way and not using variables,
>> process substitution,..?
> 
> An invocation such as:
> 
>     test $(git foo) = $(git bar) &&
> 
> throws away the exit-code from the two commands, which means we'd miss
> if one or the other (or both) crashed, especially if the crash was
> after the command produced the correct output. These days we try to
> avoid losing the exit command of Git commands. It's possible to avoid
> losing the exit-code by using variables:
> 
>     expect=$(git foo) &&
>     actual=$(git bar) &&
>     test "$expect" = "$actual" &&
> 
> but, if the expected and actual output don't match, you don't learn
> much (other than that they failed). You could address that by showing
> a message saying what failed:
> 
>     expect=... &&
>     actual=... &&
>     if test "$expect" != "$actual"
>     then
>         echo "expect not match actual"
>         # maybe emit $expect and $actual too
>     fi
> 
> However, `test_cmp` gives you that behavior for free, and it emits a
> helpful "diff" upon failure, so these days we usually go with
> `test_cmp`.
>

This is already out of the subject, the patch, of this thread, so sorry,
but the context is worth of it.

I understand the possibility of losing exit codes or segfaults in
subcommands or pipes, but I'm more thinking in the element to compare to.
Having something like:
 
	test_cmp_str () {
		test -f "$1" || BUG "first argument must be a file"
		if test "$#" -gt 1
		then
			local F=$1
			shift
			printf "$@" | eval "$GIT_TEST_CMP" '"$F"' -
		else
			eval "$GIT_TEST_CMP" '"$1"' -
		fi
	}

to allow writing simpler tests like:

--- a/t/t3204-branch-name-interpretation.sh
+++ b/t/t3204-branch-name-interpretation.sh
@@ -142,8 +142,7 @@ test_expect_success 'edit-description via @{-1}' '
 	EDITOR=./editor git branch --edit-description @{-1} &&
 	test_must_fail git config branch.non-desc-branch.description &&
 	git config branch.desc-branch.description >actual &&
-	printf "Branch description\n\n" >expect &&
-	test_cmp expect actual
+	test_cmp_str actual "Branch description\n\n"
 '

--- a/t/t3204-branch-name-interpretation.sh
+++ b/t/t3204-branch-name-interpretation.sh
@@ -142,8 +142,10 @@ test_expect_success 'edit-description via @{-1}' '
        EDITOR=./editor git branch --edit-description @{-1} &&
        test_must_fail git config branch.non-desc-branch.description &&
        git config branch.desc-branch.description >actual &&
-       printf "Branch description\n\n" >expect &&
-       test_cmp expect actual
+       test_cmp_str actual <<-\EOF
+       Branch description
+
+       EOF
 '

My doubts are that maybe this can induce to some bad usages, is
unusable in some systems, it has already been explored and discarded,
using files gives the diff with nice names not "-",...

Maybe this needs a new RFC thread. I dunno.

Thanks for your comments and explanations.
