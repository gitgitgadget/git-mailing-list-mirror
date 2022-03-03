Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E52C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 16:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbiCCQyH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 11:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiCCQyG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 11:54:06 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7672F123422
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 08:53:18 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id o1so6358577edc.3
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 08:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=8mNg1Oz2Al04DHvtVqatNp9aVJVwO5KJKT458G0BfBQ=;
        b=DGzcHkvtvpxmPXE46hNBFmVPYr1OcBM5Yd0lt4sUs+NPr0qDq6ahe6wS4+KaU8vvWG
         EW+NGu6N6n7uSr4FfivuEoV124vusjFNYAQ9amJHwUbkco8zMrPjKHvQnTO3jzFAmEAP
         h6pkcjn3zQG10w76qPBJ6//wbnbYdgx9oQ4VUWwmKjoXSU1BT0SQPYo5eHV59G74kHoq
         RnqtHq0nuKJ9zWhpCXAD2f8GNiagXWVTpDLexBw5aoMP35bSGn+CvEVVMmHpM2X5w0oy
         Jjaf/KQNMI21kDDVSnPydpC1ja6HJULPZ88fbZx/Br5wtLD2gPXEGXbLOxPDYkGYZ9kX
         FTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=8mNg1Oz2Al04DHvtVqatNp9aVJVwO5KJKT458G0BfBQ=;
        b=a/x6K+f6Xi2Jy9f9ArVPAHKLsJ1hRAyghDSF+Z7bUfB9rbHKsbtZACuEolADYGbdkA
         5zJzZo3hBDNh5M0ByNLFSlhwkAT9BmNOB2/T0ZSAhrgkE2wRBf5cU9JiKY/ULoMB+ZXp
         4Lw5srF9XUb9sAwh8tQFvCMluHz8uA2KJTSms2kwELM0ixLuZf+Gp9c32yMtGPy1bp6f
         vKgFPVkMEazTTqnpPG3Nyx13l/VHlIfAkKcBf6AWQm2kAiMOA30x0NFKmblOchYPZI05
         cy9F8vLCrt5B61ZCloQoJ8PbAEJi72vLpfjDaT8YaIWM2SnUAjBjRiIcqDWpgKKynqvO
         NB7g==
X-Gm-Message-State: AOAM531xEU5itf+g20hCN1BbIMPHkrXLxEj0odhOboQCMFkLrwye9tQE
        ANhnnZa02i5zKjXLXfwXMQY=
X-Google-Smtp-Source: ABdhPJz8IrW74RBgO+e1hdKQLotJYLLXljdkVuK24O7bJQX+oxnOTY5T169t7rokTPXW8c0L4hxFlw==
X-Received: by 2002:a50:fb02:0:b0:40f:bd67:205f with SMTP id d2-20020a50fb02000000b0040fbd67205fmr35060311edq.409.1646326396546;
        Thu, 03 Mar 2022 08:53:16 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id t4-20020a056402524400b00415b90801edsm1094388edd.57.2022.03.03.08.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 08:53:16 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nPohX-000emO-GG;
        Thu, 03 Mar 2022 17:53:15 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v4 1/3] stash: add tests to ensure reflog --rewrite
 --updatref behavior
Date:   Thu, 03 Mar 2022 17:52:23 +0100
References: <pull.1218.v3.git.git.1645817452.gitgitgadget@gmail.com>
 <pull.1218.v4.git.git.1646260044.gitgitgadget@gmail.com>
 <08bb8d3a9b9cd75c8b2aed11db9456baef6f415b.1646260044.git.gitgitgadget@gmail.com>
 <xmqqlexsexse.fsf@gitster.g>
 <20334a5e-52b8-12a4-de93-a8baa5313858@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20334a5e-52b8-12a4-de93-a8baa5313858@gmail.com>
Message-ID: <220303.86a6e72d1g.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 03 2022, Phillip Wood wrote:

> On 02/03/2022 23:32, Junio C Hamano wrote:
>> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> [...]
>>> +test_expect_success REFFILES 'drop stash reflog updates refs/stash with rewrite' '
>>> +	git init repo &&
>>> +	(
>>> +		cd repo &&
>>> +		setup_stash
>>> +	) &&
>> Hmph, so this is done inside the subdirectory.  The implementation
>> of the helper in this iteration does look cleaner than in the
>> previous iteration.
>> But these many references to "repo/" and "-C repo" we see below
>> makes me wonder why we do not put the whole thing inside the
>> subshell we started earlier.
>> i.e.
>> 	git init repo &&
>> 	(
>> 		cd repo &&
>> 		setup_stash_test &&
>> 		echo 9 >file &&
>> 		old=$(git rev-parse stash@{0}) &&
>> 		git stash &&
>> 		new=$(git rev-parse stash@{0}) &&
>> 		...
>> 		test_cmp expect actual
>> 	)
>>
>
> I wonder if we could avoid the subshell entirely and avoid relying on
> REFFILES (assuming we're not trying to test the implementation details 
> of that refs backend) by doing something like
>
> test_expect_success 'drop stash reflog updates refs/stash with rewrite' '
> 	old=$(git rev-parse stash@{0}) &&
> 	setup_stash_test &&
> 	git rev-list -g stash >tmp &&
> 	sed /$old/d tmp >expect &&
> 	git rev-list -g stash >actual &&
> 	test_cmp expect actual
> '

Unless I'm missing something that "rev-list -g" will emit only the RHS
of the stash logs, i.e. no "0000..." etc.

And if we only look at that the difference with specifying the flag
isn't visible, no?

>>> +	echo 9 >repo/file &&
>>> +
>>> +	old_oid="$(git -C repo rev-parse stash@{0})" &&
>>> +	git -C repo stash &&
>>> +	new_oid="$(git -C repo rev-parse stash@{0})" &&
>>> +
>>> +	cat >expect <<-EOF &&
>>> +	$(test_oid zero) $old_oid
>>> +	$old_oid $new_oid
>>> +	EOF
>>> +	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
>>> +	test_cmp expect actual &&
>>> +
>>> +	git -C repo stash drop stash@{1} &&
>>> +	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
>>> +	cat >expect <<-EOF &&
>>> +	$(test_oid zero) $new_oid
>>> +	EOF
>>> +	test_cmp expect actual
>>> +'
>>> +
>>>   test_expect_success 'stash pop' '
>>>   	git reset --hard &&
>>>   	git stash pop &&

