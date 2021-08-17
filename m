Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA167C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 10:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9767860F41
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 10:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbhHQKKR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 06:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbhHQKKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 06:10:16 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279D4C061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 03:09:43 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id x12so27723931wrr.11
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 03:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7LrftMzQAq+9hf0q2l/xwoLccJj5G1/Yt6ofp6nzOeQ=;
        b=Wda51XgGVxLLkuH5PW/inApo7wRW2LJAgBYLGUD+dsmzcYJD5OtUNEbpFA7sIKhzcq
         WffH4NJWt0GjwHBLpmwnGm9N4sAeBkyxtevGrbh67EWvXOFIcpZ5nS308jSIgc26fi5b
         rGbrGhYpZeqYQQWnnOVS4MmEFsGZEHjZvZyTc0K3VOcaY1mwAjA6Fos4AdarI0/936xd
         NtiVx7GxjXd6djKutiELTzVD9lxP9Jjw9imEz6nROhudhu/Yw4oB/jnljQU5Qd/U1Gl8
         0jXy86Zwtc4vbfBhXuSQXMoDFIL54ryO5osnLjwQdgFlqmgs6QaQfaa+F4nNI/Ld0rdj
         9HrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7LrftMzQAq+9hf0q2l/xwoLccJj5G1/Yt6ofp6nzOeQ=;
        b=LmuFnOmc9/XWQOVLfTQtcs3EAFYT6tPZ9mDxgjxVybA2bT2EJt9m1kX527IaWn0KKH
         lM5wDMxwk7RnOWPmA8/mlHDQUh/fTCyQ9/IsWX3sQTrpmEKNrZVN1qBmiAE6A9RgF/S2
         QM5pcjgAjye0LHueaj6vsf8oHs0poMHgpSXpc4uNp7DN0sSJPi6NlOvjlQC+OFnmIgkB
         XXixkVpDEayuMecSRqYLrl6333W4vKhTXTKylmIvhCG5dWWZv60AsxUanlGi4z3VLTHp
         4zhLsUyakqWECX6Q73cPn2JJ1jvk85Q4IDNu0SAizmoJP4JdadTTgxLRx4BQ7+P8gIvE
         CKhQ==
X-Gm-Message-State: AOAM532hypwgQUZWaqKOtIwsdr42PHp2Z2JDmZAgCl18O7Kt+d5bM6Ka
        0wqJOSuo0UCYp2v1NxxN3N/7EYd6Eiw=
X-Google-Smtp-Source: ABdhPJyluu3s4ELP/t/KZQeXDdfK1ASAUuva/T9OTi48EW0Ey3G814MgiOyWop2sQOhtTWpCUHnXCQ==
X-Received: by 2002:adf:e551:: with SMTP id z17mr3161478wrm.40.1629194981837;
        Tue, 17 Aug 2021 03:09:41 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.144])
        by smtp.googlemail.com with ESMTPSA id j7sm1616774wmi.37.2021.08.17.03.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 03:09:41 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] [GSOC] cherry-pick: use better advice message
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <pull.1010.v2.git.1627953383.gitgitgadget@gmail.com>
 <pull.1010.v3.git.1628142482640.gitgitgadget@gmail.com>
 <a510722c-d5a2-f00c-dd20-dd7f76da2408@gmail.com> <xmqqzgtlumob.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <ed09ebd8-69f7-6a66-bd62-3c18b7021104@gmail.com>
Date:   Tue, 17 Aug 2021 11:09:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqzgtlumob.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/08/2021 21:14, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>> +++ b/t/t3507-cherry-pick-conflict.sh
>>> @@ -53,9 +53,12 @@ test_expect_success 'advice from failed cherry-pick' "
>>>    	picked=\$(git rev-parse --short picked) &&
>>>    	cat <<-EOF >expected &&
>>
>> If you quote the here doc end marker then there is no substitution in
>> the here doc so writing
>>
>> 	cat <<-\EOF >expected &&
>>
>>>    	error: could not apply \$picked... picked
>>> -	hint: after resolving the conflicts, mark the corrected paths
>>> -	hint: with 'git add <paths>' or 'git rm <paths>'
>>> -	hint: and commit the result with 'git commit'
>>> +	hint: Resolve all conflicts manually, mark them as resolved with
>>> +	hint: \"git add/rm <conflicted_files>\", then run
>>
>> means you can replace \" with " here
> 
> Hmph, actually the double-quote that opens the body of
> test_expect_success should be stared at with a very cautious eyes,
> as they often do not mean what the author of the patch thought they
> do.  I can see that it already fooled your eyes into thinking that
> there is no substitution, but $picked needs to be substituted into
> its value.  The backslash before it is *not* about guarding it from
> substitution inside here-doc; it is to pass literal "$" into the
> string, which is the last parameter to test_expect_success, that
> gets eval'ed.

Good point, you're right I had completely missed that, thanks for 
pointing it out

Phillip

> 
> The original of this one, for example, would probably have been
> better if written like so:
> 
> test_expect_success 'advice from failed cherry-pick' '
> 	pristine_detach initial &&
> 	SQ='\'' &&
> 
> 	picked=$(git rev-parse --short picked) &&
> 	cat <<-EOF >expected &&
> 	error: could not apply $picked... picked
> 	hint: after resolving the conflicts, mark the corrected paths
> 	hint: with ${SQ}git add <paths>${SQ} or ${SQ}git rm <paths>${SQ}
> 	hint: and commit the result with ${SQ}git commit${SQ}
> 	EOF
> 	test_must_fail git cherry-pick picked 2>actual &&
> 
> 	test_cmp expected actual
> '
> 
> And because there is no single quote in the updated text, it would
> become:
> 
> test_expect_success 'advice from failed cherry-pick' '
> 	pristine_detach initial &&
> 
> 	picked=$(git rev-parse --short picked) &&
> 	cat <<-EOF >expected &&
> 	error: could not apply $picked... picked
> 	hint: Resolve all conflicts manually, mark them as resolved with
> 	hint: "git add/rm <conflicted_files>", then run
> 	EOF
> 	test_must_fail git cherry-pick picked 2>actual &&
> 
> 	test_cmp expected actual
> '
> 
> which makes it far easier to see that $picked needs to be
> substituted, and the "git add/rm" are to be enclosed in dq pair.
> 

