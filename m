Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8063C433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 16:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbiCCQME (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 11:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiCCQME (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 11:12:04 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6479B198D29
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 08:11:18 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so5642435wmj.0
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 08:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cFMD94d5hnX812e3Sz1geyFnD6ssRs0a2V922R4C1PA=;
        b=L+U9GJBOAvYVjLmj7KbYxdx5tiMby0QFxTLZZKLtKC0s1kV35duXZf4QBK29olkDaG
         sQxKlqVUPqa8T22XP5WwWK3qgG3jNc+pjwG2oR49/bQD2JRM7yEFgbRTWWzUau1Ox9Hp
         SAhbZa4eypO1MD5Bj9P9GL6xp9WLO+bEZ4pdMDDtHgEEZuiB2T/srcq8ZrNRaaidLL02
         OZtoZ4WS6QpYaUy3BY0PZWMlHuLnhmRL8sxMTEyU25snvv7fOXqzs0HOS/QNFCAc2+xV
         warHKTlvbU2tR92J+CMLKtg6IkioUhYo9arnmkOF8LmIJ8vSHTn0DONQCWf/IQW1r8A4
         facw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cFMD94d5hnX812e3Sz1geyFnD6ssRs0a2V922R4C1PA=;
        b=GgpiVOKCR54mkcppk9TzfRQOXU4cjMWizFkv/S+YOwAI8eBonBpG7yMtTH/G9h+n3i
         UvIaah09MdbYx1L5e0TLwcA9SXEdFAl37eVKxe5YZ+W7DHRiApjdWULviivUenTyxmfE
         2tUJ2nXnAxcK3vcd6QpWtH2bgoBwRLQoUthdMz7ZXZO73ArDgiXScbXKuwgdqfW82tpL
         Yqmzusofs1jsWhuCz8ayB2l4vV4XjP8S5BFdlEldsq9SpXkChkjv7ibDt1GTY4hZc/Fv
         ilt3SzxXEkoZheI6H2+Xa9Yz0o5+8LZB3BOdPU8JmBqnVDJc8WB5izwzNU+Pj54jsSwJ
         HNvQ==
X-Gm-Message-State: AOAM533Q9V/KRMJ6h9IS0J3IUe60v0/15YYmHWGUGEeAPcillRjqO7qa
        WqJxKWZ0xZrzv0FdrqXkNpEtORqgHkE=
X-Google-Smtp-Source: ABdhPJwKQyHKuXxrIjgPyQuHzCr3b51wNxi0dtLNuScP+qR30MOI9Fv/JNgy34abTzIoRfBqti6Ssw==
X-Received: by 2002:a7b:c1ce:0:b0:381:86d6:d87c with SMTP id a14-20020a7bc1ce000000b0038186d6d87cmr4370749wmj.101.1646323876962;
        Thu, 03 Mar 2022 08:11:16 -0800 (PST)
Received: from [192.168.1.240] (230.2.7.51.dyn.plus.net. [51.7.2.230])
        by smtp.gmail.com with ESMTPSA id p6-20020a5d4586000000b001f0436cb325sm2237189wrq.52.2022.03.03.08.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 08:11:16 -0800 (PST)
Message-ID: <20334a5e-52b8-12a4-de93-a8baa5313858@gmail.com>
Date:   Thu, 3 Mar 2022 16:11:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 1/3] stash: add tests to ensure reflog --rewrite
 --updatref behavior
Content-Language: en-GB-large
To:     Junio C Hamano <gitster@pobox.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, John Cai <johncai86@gmail.com>
References: <pull.1218.v3.git.git.1645817452.gitgitgadget@gmail.com>
 <pull.1218.v4.git.git.1646260044.gitgitgadget@gmail.com>
 <08bb8d3a9b9cd75c8b2aed11db9456baef6f415b.1646260044.git.gitgitgadget@gmail.com>
 <xmqqlexsexse.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqlexsexse.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/03/2022 23:32, Junio C Hamano wrote:
> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
> [...]
>> +test_expect_success REFFILES 'drop stash reflog updates refs/stash with rewrite' '
>> +	git init repo &&
>> +	(
>> +		cd repo &&
>> +		setup_stash
>> +	) &&
> 
> Hmph, so this is done inside the subdirectory.  The implementation
> of the helper in this iteration does look cleaner than in the
> previous iteration.
> 
> But these many references to "repo/" and "-C repo" we see below
> makes me wonder why we do not put the whole thing inside the
> subshell we started earlier.
> 
> i.e.
> 
> 	git init repo &&
> 	(
> 		cd repo &&
> 		setup_stash_test &&
> 
> 		echo 9 >file &&
> 		old=$(git rev-parse stash@{0}) &&
> 		git stash &&
> 		new=$(git rev-parse stash@{0}) &&
> 		...
> 
> 		test_cmp expect actual
> 	)
>

I wonder if we could avoid the subshell entirely and avoid relying on 
REFFILES (assuming we're not trying to test the implementation details 
of that refs backend) by doing something like

test_expect_success 'drop stash reflog updates refs/stash with rewrite' '
	old=$(git rev-parse stash@{0}) &&
	setup_stash_test &&
	git rev-list -g stash >tmp &&
	sed /$old/d tmp >expect &&
	git rev-list -g stash >actual &&
	test_cmp expect actual
'

Best Wishes

Phillip

>> +	echo 9 >repo/file &&
>> +
>> +	old_oid="$(git -C repo rev-parse stash@{0})" &&
>> +	git -C repo stash &&
>> +	new_oid="$(git -C repo rev-parse stash@{0})" &&
>> +
>> +	cat >expect <<-EOF &&
>> +	$(test_oid zero) $old_oid
>> +	$old_oid $new_oid
>> +	EOF
>> +	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
>> +	test_cmp expect actual &&
>> +
>> +	git -C repo stash drop stash@{1} &&
>> +	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
>> +	cat >expect <<-EOF &&
>> +	$(test_oid zero) $new_oid
>> +	EOF
>> +	test_cmp expect actual
>> +'
>> +
>>   test_expect_success 'stash pop' '
>>   	git reset --hard &&
>>   	git stash pop &&
