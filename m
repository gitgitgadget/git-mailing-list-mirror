Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5FDEB64DD
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 15:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjHKPFK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 11:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjHKPFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 11:05:09 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30F4124
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 08:05:08 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe2048c910so18743965e9.1
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 08:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691766307; x=1692371107;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kIFaYek9miEU5ugc9SnknHqhLgGlro8RAQ6s9U+H8Cs=;
        b=lwJXl2+sK8LXkPOmOIwa4h4t/UCB1otzSb3TzTgcFVw6q5/ezKs0/ArgJ8RF3nrNp8
         mG7CwPkoF1lN9rzrm4RHzt2zC8jcDglo6M6ox57OVl8KlkOIHIp6l3rILm+wRaGX+DH0
         WbehkD4SnJwOcwxhup+3P3E39t7ssTAbkUJfoPNdJPDgs5trG4D8MkKvxbfCPbOg6sN3
         QFhhn8mXMqZUwgij/hdhipaHcncl/I0zjGQAKuNpGSJe17107jnSfsqrZ8WsJqoZ84fy
         DWyg4B0rkhr1HsSmdHcCzZg5yMGAlZ+bQPv3Y9XPVYBgBxY4ACsHw4NeoDhfVpPZ7wE7
         CDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691766307; x=1692371107;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kIFaYek9miEU5ugc9SnknHqhLgGlro8RAQ6s9U+H8Cs=;
        b=eGWCMr4A7PkR23u4qUSHALhhp/Ai366mRvgyw5VixWM+MA6sX4Q53z5Qgqmp8wfaF8
         YkRrCeapMDt9hbEQEMRsU8dcziVdaltbOxUBRfY0DOtp1uBE+1pzpAaEArcJSRn4XzF7
         UX1yVZhjtOyPL1ZSyWNpdE8zc/oeeWZWzAw+75tPVp9eHnmHtpUgiK8rkZ8Ui3HbT0Fp
         HdOjPvqVMOZtwjZU4YqrAOmdI+7JuK7cfE/jlR2ds5gLdut7n6ciNdvaVirVd3i868uc
         W8YTXbxasSsrPAw1gD05H2ADk4kKPsWvPv0EVhat5SzMTHbhV61sc5qylsFVcee/ktDM
         wpkQ==
X-Gm-Message-State: AOJu0YyxAevrJNI3q7lu7mk4S0uF+Hhtz6eHM6ENrjxboIM85Mewtxzx
        cUCGVTQOSNJzaO2/eN30lS2X7ax95A4=
X-Google-Smtp-Source: AGHT+IFB38oQ5WhT92mGDD/YUqfnhcEg5lh/1rOMtwB2Id83Qyu7OTZ7qYlz/LKMvppOLOLxf1sWbw==
X-Received: by 2002:a05:600c:296:b0:3fb:b6f3:e528 with SMTP id 22-20020a05600c029600b003fbb6f3e528mr1697268wmk.25.1691766307031;
        Fri, 11 Aug 2023 08:05:07 -0700 (PDT)
Received: from [192.168.1.116] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id p5-20020a1c7405000000b003fe1630a8f0sm8329747wmc.24.2023.08.11.08.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 08:05:06 -0700 (PDT)
Message-ID: <dba3f15a-3575-e4f9-2291-c5a342cfed43@gmail.com>
Date:   Fri, 11 Aug 2023 16:05:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/2] sequencer: beautify subject of reverts of reverts
Content-Language: en-GB-large
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
 <20230809171531.2564807-1-oswald.buddenhagen@gmx.de>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230809171531.2564807-1-oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Oswald

On 09/08/2023 18:15, Oswald Buddenhagen wrote:
> Instead of generating a silly-looking `Revert "Revert "foo""`, make it
> a more humane `Reapply "foo"`.
> 
> This is done for two reasons:
> - To cover the actually common case of just a double revert.
> - To encourage people to rewrite summaries of recursive reverts by
>    setting an example (a subsequent commit will also do this explicitly
>    in the documentation).
> 
> To achieve these goals, the mechanism does not need to be particularly
> sophisticated. Therefore, more complicated alternatives which would
> "compress more efficiently" have not been implemented.

This all looks good to me, it seems quite sensible just to bail out if 
we see an existing recursive reversion. I'm not suggesting you change 
these tests but for future reference we now have a test_commit_message() 
function which was merged a few days ago to simplify tests like these.

Thanks for working on it

Phillip

> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> 
> ---
> v3:
> - capitulate at first sight of a pre-existing recursive reversion, as
>    handling the edge cases is a bottomless pit
> - reworked commit message again
> - moved test into existing file
> - generalized docu change and factored it out
> 
> v2:
> - add discussion to commit message
> - add paragraph to docu
> - add test
> - use skip_prefix() instead of starts_with()
> - catch pre-existing double reverts
> 
> Cc: Junio C Hamano <gitster@pobox.com>
> Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
> Cc: Phillip Wood <phillip.wood123@gmail.com>
> ---
>   sequencer.c                   | 11 +++++++++++
>   t/t3501-revert-cherry-pick.sh | 25 +++++++++++++++++++++++++
>   2 files changed, 36 insertions(+)
> 
> diff --git a/sequencer.c b/sequencer.c
> index cc9821ece2..12ec158922 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2249,13 +2249,24 @@ static int do_pick_commit(struct repository *r,
>   	 */
>   
>   	if (command == TODO_REVERT) {
> +		const char *orig_subject;
> +
>   		base = commit;
>   		base_label = msg.label;
>   		next = parent;
>   		next_label = msg.parent_label;
>   		if (opts->commit_use_reference) {
>   			strbuf_addstr(&msgbuf,
>   				"# *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
> +		} else if (skip_prefix(msg.subject, "Revert \"", &orig_subject) &&
> +			   /*
> +			    * We don't touch pre-existing repeated reverts, because
> +			    * theoretically these can be nested arbitrarily deeply,
> +			    * thus requiring excessive complexity to deal with.
> +			    */
> +			   !starts_with(orig_subject, "Revert \"")) {
> +			strbuf_addstr(&msgbuf, "Reapply \"");
> +			strbuf_addstr(&msgbuf, orig_subject);
>   		} else {
>   			strbuf_addstr(&msgbuf, "Revert \"");
>   			strbuf_addstr(&msgbuf, msg.subject);
> diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
> index e2ef619323..7011e3a421 100755
> --- a/t/t3501-revert-cherry-pick.sh
> +++ b/t/t3501-revert-cherry-pick.sh
> @@ -176,6 +176,31 @@ test_expect_success 'advice from failed revert' '
>   	test_cmp expected actual
>   '
>   
> +test_expect_success 'title of fresh reverts' '
> +	test_commit --no-tag A file1 &&
> +	test_commit --no-tag B file1 &&
> +	git revert --no-edit HEAD &&
> +	echo "Revert \"B\"" >expect &&
> +	git log -1 --pretty=%s >actual &&
> +	test_cmp expect actual &&
> +	git revert --no-edit HEAD &&
> +	echo "Reapply \"B\"" >expect &&
> +	git log -1 --pretty=%s >actual &&
> +	test_cmp expect actual &&
> +	git revert --no-edit HEAD &&
> +	echo "Revert \"Reapply \"B\"\"" >expect &&
> +	git log -1 --pretty=%s >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'title of legacy double revert' '
> +	test_commit --no-tag "Revert \"Revert \"B\"\"" file1 &&
> +	git revert --no-edit HEAD &&
> +	echo "Revert \"Revert \"Revert \"B\"\"\"" >expect &&
> +	git log -1 --pretty=%s >actual &&
> +	test_cmp expect actual
> +'
> +
>   test_expect_success 'identification of reverted commit (default)' '
>   	test_commit to-ident &&
>   	test_when_finished "git reset --hard to-ident" &&
