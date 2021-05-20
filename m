Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4426FC433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2943461163
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhETPPN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 11:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbhETPPN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 11:15:13 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C10C061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 08:13:51 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id h3-20020a05600c3503b0290176f13c7715so5450435wmq.5
        for <git@vger.kernel.org>; Thu, 20 May 2021 08:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gDCV6lpOr71wB+N03VgatmkioEylB+nDl5hyJdKELTo=;
        b=KEzHUORlFCiIOSLrY6fXGnBglKmv0vt6c64L9vZ5f+Pkippl4+yJr4NIaF0GS4z/tu
         DUX8CL4CXlmj9TH69ZP7b+QKG6QXVOH/c8ds/FFSFUA3Te6ksz21nW2ZSdoW7eI8+HTq
         J/YJljqCMCr0vt4L+7FiA9L2Xmmeu9kpU/T2Bv7vdYWSym73SRmtMHJ4Ihi4vO18wBp1
         XsUBZ+CAKzpx74taxrg/oed/Be77N91EALCHTO+J1MSiPda4Qjwj9FJPq4MrRqvAw60k
         4o8W9I0dbnHqdb5GlzHyAjz1sEqaS9UxhoOt0Ivb4QNL8ryuuU4wcIahhCZqEOYsgagu
         WIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=gDCV6lpOr71wB+N03VgatmkioEylB+nDl5hyJdKELTo=;
        b=hWrJ/oUQMlOOARZ6EFYkXddlmH1yIrs68NTjOOblCys/IqrkaFkuada2TLETGBa1JN
         TGq/7T5Uw+PqIrQBdmhvh+oBpvDbBWukSnyDdQf7uw4k/i4gP+PVVqRDRY51fZBMxkl8
         +7tOPjbh6GylAuHDFHc0iALneKzx3T7X7VvUK1OTqhg4E19LdrphHdOGVZWcAnF4xikE
         u/8tr9kAkeiMoC2hl3pWl9c4BN1t4kafZnvYtDS30hounI4PS0eMGPg/dnh09/E53QEk
         ZHEFBNHnFHRUBQzQGyFvN3JxsmS64OSB3BCHDAhtEr1wC/okyfG5zPq+rptCeJPth+Mg
         Flzg==
X-Gm-Message-State: AOAM531V08507TFqWpGkM/vKsEC3wLZjFqXIFRXfIJoFqxJ9sBEUxd1W
        u/dmA1d8Arta1L058Ce3y90=
X-Google-Smtp-Source: ABdhPJzQ63kBKKA4Kai9qpdwDbb8UYOpo4BgenNP8NJNnc6ciljpd+bY2Uj4ZpcDhnAM9Mu+TAXpDA==
X-Received: by 2002:a05:600c:350a:: with SMTP id h10mr4593238wmq.154.1621523629947;
        Thu, 20 May 2021 08:13:49 -0700 (PDT)
Received: from [192.168.1.240] (88.22.198.146.dyn.plus.net. [146.198.22.88])
        by smtp.gmail.com with ESMTPSA id i1sm2968047wmb.46.2021.05.20.08.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 08:13:49 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4] help: colorize man pages
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Leah Neukirchen <leah@vuxu.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>
References: <20210520040725.133848-1-felipe.contreras@gmail.com>
 <842221d6-51c4-e08a-4299-c4efb8bf1dcb@gmail.com>
 <60a66b11d6ffd_2448320885@natae.notmuch>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <b58cbdcc-abd3-ec82-7d8d-771f47c484ff@gmail.com>
Date:   Thu, 20 May 2021 16:13:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <60a66b11d6ffd_2448320885@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/05/2021 14:58, Felipe Contreras wrote:
> Phillip Wood wrote:
>> On 20/05/2021 05:07, Felipe Contreras wrote:
>>> We already colorize tools traditionally not colorized by default, like
>>> diff and grep. Let's do the same for man.
>>
>> I think there is a distinction between 'diff' and 'grep' where we are
>> generating the content and help where we are running man
> 
> It makes a difference for git developers, not for the user.
> 
> The user doesn't care how the output of `git grep` was generated, all
> she sees is that it's different from `grep`. It's in fact more
> surprising than a difference in `git help` because it's even the same
> comand.
> 
> Maybe if the command was `git man` they would be equally surprising, but
> it's not, in fact, `git help` can be used to 1) output directly to the
> terminal 2) view in a browser, 3) view in info program, 4) view man page
> in woman, 5) view the man page in koqueror 6) view the man page in man.
> 
> Only in one case among many would the user expect to see man, therefore
> a colorized `git grep` is more surprising.

I'm not sure I follow that argument

>>> Our man pages don't contain many useful colors (just blue links),
>>> moreover, many people have groff SGR disabled, so they don't see any
>>> colors with man pages.
>>>
>>> We can set the LESS variable to render bold, underlined, and standout
>>> text with colors in the less pager.
>>>
>>> Bold is rendered as red, underlined as blue, and standout (prompt and
>>> highlighted search) as inverse magenta.
>>>
>>> Obviously this only works when the less pager is used.
>>>
>>> If the user has already set the LESS variable in his/her environment,
>>> that is respected, and nothing changes.
>>
>> However if they have specified the colors they would like by using the
>> LESS_TERMCAP_xx environment variables that the previous versions of this
>> patch used their choice is overridden by this new patch.
> 
> That is true. We could add a check for that:
> 
>    if (getenv("LESS_TERMCAP_md"))
>            return;
> 
> However, it may not be necessary since many of the tips online set these
> variables inside a function.

The only person who has tested this patch has reported a problem with 
it, it seems unlikely that no other users will have similar issues. The 
Arch Linux wiki (which I think is probably where I got the idea to set 
LESS_TERMCAP_xx) has a section on less[1] suggesting that 
LESS_TERMCAP_xx is exported unconditionally in .bashrc, and a later on 
man suggesting setting them in a function.

Best Wishes

Phillip

[1]
https://wiki.archlinux.org/title/Color_output_in_console#less

>> I've got LESS_TERMCAP_xx set and running
>> 	LESS='Dd+r$Du+b$Ds' man git add
>> changes the output colors
> 
> You have them set in the environtment? Not inside a function like
> man () { ... command man "$@" } ?
> 
>>> A new color configuration is added: `color.man` for the people that want
>>> to turn this feature off, otherwise `color.ui` is respected.
>>> Additionally, if color.pager is not enabled, this is disregarded.
>>>
>>> Normally check_auto_color() would check the value of `color.pager`, but
>>> in this particular case it's not git the one executing the pager, but
>>
>> s/git the one/git is not/
> 
> You mean s/it's not git/git is not/
> 
> Fine by me.
> 
> Cheers.
> 
