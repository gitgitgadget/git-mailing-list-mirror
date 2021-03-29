Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4703AC433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 10:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1151860230
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 10:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhC2KMq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 06:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbhC2KMg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 06:12:36 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A14CC061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 03:12:36 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id e14so18496381ejz.11
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 03:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VGcSHquv+OTwPbS7w7ocoVQ5en+kWRXYgDamUVrX+Mw=;
        b=W0LykKXk+Qizds0HSurM91wacuacvxA2WuNCU7pt/eQuE7rMJm5y8NR4H8xfdNGcVU
         7oTgdEHtk96Gt7S72mJb13bFzi3wgqjfqE1nK0ppSHMaNrYbRdN3Sl3Ov8p0D8ER1Hbk
         RyaijqJl9d8I+5yZzvc1xKdQ3q4i2HLi4w3ONb6CYjJbDycv2PNTDN5z4d2OS9p/b0ng
         GCY4AGSXXXBr03Y9cEliXoLsnkkpx1/qMD75sFoR5BpmFA7S++K0gyH02++BP0NIQ5aY
         vxdXVg0MAaGYlRplKGmkqmrwu0oWJTLo8LVQPfwhRWDiOukfmr9z9eJHS6vhHyb+DJ57
         tiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VGcSHquv+OTwPbS7w7ocoVQ5en+kWRXYgDamUVrX+Mw=;
        b=n7mRwDV8bnLXHU4rs6MYCksu0dSMhlY5Zg9OSVl41OwBqbalA04Jd9gRvOZxcsIcje
         jg0ZFMxlhMZSG5FLmYROVW0zm7hE2HSAqT0IFYrVi+p3SCelpEue9Nv9mM9+JlUXc2XI
         zruRhMeaAW5O67eB61MAsheRYMIrbAOPfQP5Vc4OUyv11CycibdQ1tMvSVV+ktILxCvE
         RLQyOpM5Kfpv3Ugpf14xLmsiIHiqZSracJ6H5t419EHjgyG6Gs4tjeOC8LXJiqM0i4lf
         1FXdWWrcvBQW18ZwscWi/NGIQzjBgodRA0sxX8/DOMar0ArhOw7MgXJ8ZbZ3vBH5r1Nl
         agGQ==
X-Gm-Message-State: AOAM532/1A55gaPuS8ZVdzxmmeU91ILF8H8qXEeFcqIrLxk6y76F7CmS
        zOo3W84W8v1Fhi2kbp4KOqax2oC00RU=
X-Google-Smtp-Source: ABdhPJxAAj0CTaI52SpN6yknIaZbzUbVprFmKBCinP7n8BKaybzTAybMcCPDQd3Dp9TRo0LAOn6dYA==
X-Received: by 2002:a17:906:bcfc:: with SMTP id op28mr27427562ejb.238.1617012755143;
        Mon, 29 Mar 2021 03:12:35 -0700 (PDT)
Received: from [192.168.1.201] (243.20.198.146.dyn.plus.net. [146.198.20.243])
        by smtp.googlemail.com with ESMTPSA id gz20sm8104650ejc.25.2021.03.29.03.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 03:12:34 -0700 (PDT)
Subject: Re: [GSOC][PATCH] userdiff: add support for Scheme
To:     Atharva Raykar <raykar.ath@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20210327173938.59391-1-raykar.ath@gmail.com>
 <xmqq5z1cqki7.fsf@gitster.g> <EBC020E6-BE8B-4332-8225-A988CB7CFA69@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <cfd75dc0-7828-f36c-fd7b-c9f5a2e8d4cc@gmail.com>
Date:   Mon, 29 Mar 2021 11:12:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <EBC020E6-BE8B-4332-8225-A988CB7CFA69@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Atharva

On 28/03/2021 12:51, Atharva Raykar wrote:
> On 28-Mar-2021, at 04:20, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Atharva Raykar <raykar.ath@gmail.com> writes:
>>
>>> +         /*
>>> +          * Scheme allows symbol names to have any character,
>>> +          * as long as it is not a form of a parenthesis.
>>> +          * The spaces must be escaped.
>>> +          */
>>> +         "(\\.|[^][)(\\}\\{ ])+"),
>>
>> One or more "dot or anything other than SP or parentheses"?  But
>> a dot "." is neither a space or any {bra-ce} letter, so would the
>> above be equivalent to
>>
>> 	"[^][()\\{\\} \t]+"
>>
>> I wonder...
> 
> A backslash is allowed in scheme identifiers, and I erroneously thought that
> the first part handles the case for identifiers such as `component\new` or
> `\"id-with-quotes\"`. (I tested it with a regex engine that behaves differently
> than the one git is using, my bad.)
> 
>> I am also trying to figure out what you wanted to achieve by
>> mentioning "The spaces must be escaped.".  Did you mean something
>> like (string->symbol "a symbol with SP in it") is a symbol?  Even
>> so, I cannot quite guess the significance of that fact wrt the
>> regexp you added here?
> 
> I initially tried using identifiers like `space\ separated` and they
> seemed to work in my REPL, but turns out space separated identifiers in
> scheme do not work with backslashes, and it was working because of the way
> my terminal handled escaping. Space separated identifiers are declared like
> `|space separated|` and this too only seems to work with Racket, not
> the other Scheme implementations.

I think the bar notation works with some other such as gambit and 
possibly guile (it's a while since I used the latter)

Best wishes

Phillip

  So I stand corrected here, and it's better
> to drop this feature altogether.
> 
> But somehow, the regexp you suggested, ie:
> 
> 	"[^][()\\{\\} \t]+"
> 
> does not handle the case of make\foo -> make\bar (it will only diff on foo).
> I am not too sure why it treats backslashes as delimiters.
> 
> This seems to actually do what I was going for:
> 
> 	"(\\\\|[^][)(\\}\\{ ])+"
> 
>> As we are trying to catch program identifiers (symbols in scheme)
>> and numeric literals, treating any group of non-whitespace letters
>> that is delimited by one or more whitespaces as a "word" would be a
>> good first-order approximation, but in addition, as can be seen in
>> an example like (a(b(c))), parentheses can also serve as such "word
>> delimiters" in addition to whitespaces.  So the regexp given above
>> makes sense to me from that angle, especially if you do not limit
>> the whitespace to only SP, but include HT (\t) as well.  But was
>> that how you came up with the regexp?
> 
> Yes, this is exactly what I was trying to express. All words should be
> delimited by either whitespace or a parenthesis, and all other special
> characters should be accepted as part of the word.
> 

