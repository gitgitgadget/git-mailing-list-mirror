Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88781C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 08:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EE5D61004
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 08:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbhHIIro (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 04:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbhHIIrn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 04:47:43 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA16C0613CF
        for <git@vger.kernel.org>; Mon,  9 Aug 2021 01:47:22 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id a20so15661816plm.0
        for <git@vger.kernel.org>; Mon, 09 Aug 2021 01:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=mbfi2Lxv/7Rb7VdxTzt1C8Cb2GxkBakE6C7Ucvo/4rw=;
        b=lbpoPi4ApcMQQBKAWmcYf+7qcZNPj+CytT9lUGGvPUDu5d64grcS1qyiLHJLtrCLig
         MzQKU2yQ2F4AMK3rIJ5uxWUvq+t/Qf6SXAjWRwXoE/TLVn7Vz9cxLQ+r9dcnGz7POdRc
         kY1YP2me2dpbkQeqMAQ6l35leIrmL66JglNT0IJr8YX2iHac7iOYnuFevuunRdlixzuh
         hKTZ4PALcY+f++wFetYqcZJZ/nwuheWGmnjZWO54S7LAJT7KjDRuY528toYtOJLKIP21
         dXm/Men6ZxR2aea7Ir2UmYsjd4/lEk9KKirHLqbC0g8Jx7HXarqHOrjlosaL6yqZM/7O
         m4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=mbfi2Lxv/7Rb7VdxTzt1C8Cb2GxkBakE6C7Ucvo/4rw=;
        b=Rh9aHLYUQbpuoMsTViAJ0AdmOeKaFz9KuyX/FN8JtC2tcDdg+ntiHsxaOX1VRRgVq/
         aT8rBCYV7Pd6YgKMVg8C7tBa1uLI9j4+cHwhTdptrdiwN4fpTVsklqUlHbaSNF0s01c2
         8+hPUR7jhmi95qEzdvGjxvqkiv6Hf6RjXrefIMetYjx5tPS0Ue76DAUybcn/ygKGnbY0
         Vj/jdeSHaDTvVRlzJlzuUj9W4LGzdVA2JmHAT+2mc5RbluRSWFZbn4UFGcBM+2VlZ5np
         sRrmyMHArUxDPNwHCiHj+WW3QLRIpB9R5VFdgepQUhf4ydhxAPs0ZXEtnX50g9jFn2Ce
         259w==
X-Gm-Message-State: AOAM530yaiAad9LWgf/Athg8z6rquUI43Mpbl2A7c0yyhZNI/SXY0/a8
        Hmk35YP36jmqD8DrlPwnW+A=
X-Google-Smtp-Source: ABdhPJxg9t85Sxs/gZ6+HWkaCtMIxB3oy0QJXwLDUOPaEnyBjGw9Ds+hbfERikTIbIc/crx8980fow==
X-Received: by 2002:a17:90b:1bce:: with SMTP id oa14mr23680631pjb.221.1628498841546;
        Mon, 09 Aug 2021 01:47:21 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id n17sm22042735pgj.93.2021.08.09.01.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 01:47:21 -0700 (PDT)
References: <20210806120147.73349-1-raykar.ath@gmail.com>
 <20210807071613.99610-1-raykar.ath@gmail.com>
 <20210807071613.99610-2-raykar.ath@gmail.com>
 <0752736f-11d5-103b-653f-a4bbe6436304@gmail.com>
 <187083ab-a2e3-0933-5bff-9b409b2946ea@gmail.com>
 <m27dgvaxfj.fsf@gmail.com>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, avarab@gmail.com,
        christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        pc44800@gmail.com, periperidip@gmail.com,
        rafaeloliveira.cs@gmail.com, sunshine@sunshineco.com
Subject: Re: [GSoC] [PATCH v4 1/8] submodule--helper: add options for
 compute_submodule_clone_url()
In-reply-to: <m27dgvaxfj.fsf@gmail.com>
Message-ID: <m2wnov9f8s.fsf@gmail.com>
Date:   Mon, 09 Aug 2021 14:17:15 +0530
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Atharva Raykar <raykar.ath@gmail.com> writes:

> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
>
>> On 08/08/21 11:11 pm, Kaartic Sivaraam wrote:
>>> On 07/08/21 12:46 pm, Atharva Raykar wrote:
>>> [...]
>>>  	char *remote = get_default_remote();
>>> @@ -598,10 +598,14 @@ static char *compute_submodule_clone_url(const char *rel_url)
>>>   	strbuf_addf(&remotesb, "remote.%s.url", remote);
>>>  	if (git_config_get_string(remotesb.buf, &remoteurl)) {
>>> -		warning(_("could not look up configuration '%s'. Assuming this repository is its own authoritative upstream."), remotesb.buf);
>>> +		if (!quiet)
>>> +			warning(_("could not look up configuration '%s'. "
>>> +				  "Assuming this repository is its own "
>>> +				  "authoritative upstream."),
>>> +				remotesb.buf);
>>>  		remoteurl = xgetcwd();
>>>  	}
>>> -	relurl = relative_url(remoteurl, rel_url, NULL);
>>> +	relurl = relative_url(remoteurl, rel_url, up_path);
>>
>> After reading 2/8 of the series, I just noticed that 'remoteurl' is always
>> initialized in 'resolve_realtive_url'. It is either initialized to the return
>> value of 'xgetcwd' or retains its assigned value of 'NULL'. But it looks
>> like that's not the case here. 'remoteurl' could be used uninitialized
>> when the above if block does not get executed which in turn could result in
>> weird behaviour in case 'remoteurl' gets a value of anything other than 'NULL'
>> at runtime.
>>
>> This again has nothing to do with the change done in this patch. Regardless, it
>> looks like something worth correcting. Thus, I thought of pointing it out.
>>
>
> Right. I agree it should be corrected.

Actually on having another look, I'm not sure if we need to assign NULL
to 'remoteurl' at all.

The 'if (git_config_get_string(...))' on success will allocate
'remoteurl'. If it fails, it will be given the return value of
'xgetcwd()'. There is nothing in the config API docs that suggest a
success mode for the git_config_get_*() functions that will assign
nothing to the buffer we give it. Therefore, by the time we get to the
variable's first use in the 'relative_url()' function, we are guaranteed
to have a well-defined value.

It seems to me that the original 'resolve_relative_url()' had an
unnecessary NULL initialization.
