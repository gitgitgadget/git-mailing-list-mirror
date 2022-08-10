Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA6AC00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 13:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiHJNOJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 09:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiHJNOI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 09:14:08 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92A8296
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 06:14:06 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 186-20020a1c02c3000000b003a34ac64bdfso991423wmc.1
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 06:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=j/Kjz6rG/hcXktiO5bCCBLdhTKv8bl4bNn7ANwOxpOo=;
        b=UbEigVLjVIIRecvXhi+Vt0jrsYFPGf/JY/W14UtaydJ+MLhWjuwXkRsxmutIehgPq/
         ympLZOPbYsmD0X+NBDe9gg4RPO/LCOFOP689gEwaGwqjww44nZMjqBKlGl6LavtYJzJy
         shbJFzcR9beMG3EB9+PumWK+Quuev+moGjpWLbHkIDX4mldDXKRNiomHKLepvXh0lyss
         jdHsimecebpaPvxY4xwsz8S+VYgtUuNy43E/bIJGq1q6N3c46O7vAnM2b8jYkvCF8ewG
         CvjvBHJPrtVkLS/L4yEX7Vbj2xwAyYIQdg4bApKIHWM59BfVVS7EGLlWENLuNoT9/S2u
         8VxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=j/Kjz6rG/hcXktiO5bCCBLdhTKv8bl4bNn7ANwOxpOo=;
        b=y4KlNe9a4qnMqB6sN854RDIZqVfQr4Xs4H9WwSETedjgzSbACj8R7q7Oj/1R8kzROT
         lgV7XGe9utUHEhvoYl5iSa3poFmtzUwJrmCFjp7nfzEC11+rIDOazAgbSFeraEkeBxAO
         9Gg5oj8HLu8ngA/PGIb2X1eQJj78IjH+e4Q+X6gGn8Csvdmi/Zoe8b4dklrpAJ0naYvZ
         BhZsIODncUEgJInPeDt7H/zo8OtZJtMbqRL7vN4xxIk+SltpcwfEmS805BvGYbOropZR
         dKIZX4PqN6gMiOOYj5tCuiBVDF/lOOAkbufRCkd9IBJcDtdv28QJBySHk5CPYV9eWs9h
         etMA==
X-Gm-Message-State: ACgBeo3nwKHGnthG/720GwiHieaVWLK/WQnLUAL8QrjgVm8OJX7GigWq
        I6VbfvO2hs7DnPNNW/vd/5AswcHmlZA=
X-Google-Smtp-Source: AA6agR4JuLbby3P7K/X9wmxOgC9ve7f0nG3IMia0FU+USLAR1bVDScValozrp9thyQFLC4KJBRiJUg==
X-Received: by 2002:a05:600c:40c6:b0:3a4:eff7:b183 with SMTP id m6-20020a05600c40c600b003a4eff7b183mr2419360wmh.180.1660137245348;
        Wed, 10 Aug 2022 06:14:05 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.144])
        by smtp.googlemail.com with ESMTPSA id b6-20020a5d6346000000b0022063e5228bsm16250635wrw.93.2022.08.10.06.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 06:14:05 -0700 (PDT)
Message-ID: <0e1be1b9-0a69-0531-8b2c-0f0f618925b7@gmail.com>
Date:   Wed, 10 Aug 2022 14:14:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v8 05/14] merge-index: add a new way to invoke
 `git-merge-one-file'
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20210317204939.17890-1-alban.gruin@gmail.com>
 <20220809185429.20098-1-alban.gruin@gmail.com>
 <20220809185429.20098-6-alban.gruin@gmail.com>
 <o759r3qn-nqn9-oq22-p90o-2nrn24085n80@tzk.qr>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <o759r3qn-nqn9-oq22-p90o-2nrn24085n80@tzk.qr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/08/2022 22:36, Johannes Schindelin wrote:
> Hi Alban,
> 
> On Tue, 9 Aug 2022, Alban Gruin wrote:
> 
>> Since `git-merge-one-file' will be rewritten and libified, there may be
>> cases where there is no executable named this way (ie. when git is
>> compiled with `SKIP_DASHED_BUILT_INS' enabled).  This adds a new way to
>> invoke this particular program even if it does not exist, by passing
>> `--use=merge-one-file' to merge-index.  For now, it still forks.
> 
> I read up about Stolee's and Phillip's suggestion,

I thought I was in favor of special casing git-merge-one-file. Stolee 
seems to have been worried about someone passing "git merge-one-file" 
but I think we only accept a program name and not a program plus 
arguments so that shouldn't be a problem.

> and about Junio chiming
> in, but I have to point out that all the objections against special-casing
> `!strcmp(pgm, "git-merge-one-file`") share one fundamental flaw: they fail
> to acknowledge that we will _have_ to special-case this value once we turn
> `merge-one-file` into a built-in.
> 
> And the reason is: there might be scripts out there that expect `git
> merge-index git-merge-one-file [...]` to continue to work even when
> building Git with `SKIP_DASHED_BUILT_INS`.
> 
> In light of that, I would like to point out that we really _must_ revert
> to `if (!strcmp(pgm, "git-merge-one-file"))`, ie. to what v6 did (see
> https://lore.kernel.org/git/20201124115315.13311-7-alban.gruin@gmail.com/).
> 
> And since we must do that anyway, I do not see any need for the `--use`
> option at all, it just complicates the usage and does not really provide
> any benefit that I can see.
> 
> On the upside: skipping the `--use` option will dramatically simplify this
> patch.

I'd be happy to see the '--use' option dropped as well.

Thanks for continuing to work on this Alban, I'm sorry I've not had time 
to look at it properly since v1, I'll try and take a good look at this 
version.

Best Wishes

Phillip

> Sorry for not catching this earlier.
> 
>> diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
>> [...]
>> @@ -44,8 +44,9 @@ code.
>>   Typically this is run with a script calling Git's imitation of
>>   the 'merge' command from the RCS package.
>>
>> -A sample script called 'git merge-one-file' is included in the
>> -distribution.
>> +A sample script called 'git merge-one-file' used to be included in the
>> +distribution. This program must now be called with
>> +'--use=merge-one-file'.
> 
> It probably makes more sense to just drop this paragraph because we will
> no longer provide that sample script.
> 
> Thanks,
> Dscho

