Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95008C004D4
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 09:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjASJTt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 04:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjASJTr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 04:19:47 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853A553F91
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 01:19:45 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ss4so3922838ejb.11
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 01:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sSksiEzT7o2o1B+ERoXLn1TV5nHaUi5vrujZsXk2UdQ=;
        b=rLmiXz+uzhJXhdq1aHDR7fE09NiuSHWdv6UxfsAH1sJsjuX3PtT1HwZg10KM4zNUjH
         E5b9n7rVXVP+BYztjtrijodE0OqCKX/dkdc039Iq7ai2syHGu341dBrKgCFzHmQKByi7
         cn5dPv5+xBIV2pSsIcyTM8iwzu6m99VrKH9Pj7DZQjIlXpveb2QziaTeBaGjItQ2y3dW
         v7423WCnbe1Iz8mM/uH+ML9iZX0OL2YdgKh/gIIfdaPcTIu1hHXMKgIz9Dgo11YbSv3S
         RVYY5vwZpw4qd8T3F3dPjK5/4apSDYMWGVqztn4rPc+NNrt+0fMbIN8xHDbdA0IUlMJu
         +xwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sSksiEzT7o2o1B+ERoXLn1TV5nHaUi5vrujZsXk2UdQ=;
        b=mr5x8pU8elLl0nVBcSZ9l1S19XT9qQ+mB0m/DXenMQ71ycyrt1bONs036+8GsVS9lr
         kQPXQwO8QWvq31K1E+p+zPr0USUD/O6hd35jYicyNB170AXtadO9GEmTurO4K8U15o+l
         N5ra3bX4+fVu8VnItpC6vvyR4/OoO/R68ezgG5dlw6DI/KMiv5PWGsP1Zs0MLgpf0U+o
         pDOnP25OexrNT1wSDMLhjkkq8XcrMzCUrk4I9R8LkznBvg6gZ5C3tICBnXPgYKGL9AgB
         II7yvuh2V0DKjqwO5MZxgKGxfscwqzSHc8UEsecSGRkiqwbMSgBQx3j5iNRJ32kfOIUI
         9TSA==
X-Gm-Message-State: AFqh2krop84lmJDyxnursjod4ZM1jRV3EJlVpiXULIWqvybUbDewBgRU
        H+gf9xG+1rh60f9U/fgD9ampaA==
X-Google-Smtp-Source: AMrXdXsK34tpkYBJp43ndG1OL0EsEWPmlCt3t43zTutI7akgCu/NLJ9W6dati3H/n21++FBpK6xD+w==
X-Received: by 2002:a17:906:abc6:b0:86c:b710:dacf with SMTP id kq6-20020a170906abc600b0086cb710dacfmr10629827ejb.62.1674119983960;
        Thu, 19 Jan 2023 01:19:43 -0800 (PST)
Received: from ?IPV6:2003:f6:af07:2300:bfaf:911d:f14:9630? (p200300f6af072300bfaf911d0f149630.dip0.t-ipconnect.de. [2003:f6:af07:2300:bfaf:911d:f14:9630])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906311200b0084b89c66eb5sm15861880ejx.4.2023.01.19.01.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 01:19:43 -0800 (PST)
Message-ID: <1b119c0a-a720-be19-1d26-6d581282fc92@grsecurity.net>
Date:   Thu, 19 Jan 2023 10:19:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] grep: fall back to interpreter mode if JIT fails
Content-Language: en-US, de-DE
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Carlo Arenas <carenas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20221216121557.30714-1-minipli@grsecurity.net>
 <221216.86o7s31fyt.gmgdl@evledraar.gmail.com>
 <62a06c5b-9646-17f8-b4d5-39823d3cc25a@grsecurity.net>
 <xmqqlen7kksr.fsf@gitster.g>
 <CAPUEspjqgSOS4KKw2nTaRYdiCFo4Ok6OfmKrqb+Mjq+oXn5nsg@mail.gmail.com>
 <221219.86bknz21qj.gmgdl@evledraar.gmail.com>
 <2b04b19a-a2bd-3dd5-6f21-ed0b0ad3e02f@grsecurity.net>
 <221220.86bknxwy9t.gmgdl@evledraar.gmail.com>
 <f680b274-fa85-6624-096a-7753a2671c15@grsecurity.net>
 <230118.86lelzx2c4.gmgdl@evledraar.gmail.com>
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <230118.86lelzx2c4.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18.01.23 16:44, Ævar Arnfjörð Bjarmason wrote:
>>> [snip]
>>> But silently falling back kind of sucks, but unfortunately pcre2 doesn't
>>> provide a way to say "failed because of SELinux" v.s. "failed because
>>> the pattern is crazy", except that we could try to compile a known-good
>>> pattern with the JIT, to disambiguate the two.
>>
>> Exactly, so what about something like this:
>>
>> If JIT is generally available, try to JIT the user supplied pattern:
>> 1/ If it fails with PCRE2_ERROR_NOMEMORY, try to compile a know good
>>    pattern, e.g. ".":
>>    1a/ If this fails with PCRE2_ERROR_NOMEMORY as well, fall back to
>>        interpreter, as JIT is non-functional because of SELinux / PaX.
>>    1b/ If not, it's a "crazy" pattern, suggest '(*NO_JIT)'.
>> 2/ If it succeeds or fails with a different error, continue as of now,
>>    i.e. use JIT on success or die() on error, optionally suggesting
>>    '(*NO_JIT)'.
>>
>> That should handle the case you're concerned about and only fall back to
>> interpreter mode if JIT won't be functional anyway. Admitted, this would
>> also allow crazy patterns, but there's simply no way to detect these
>> under such constraints.
> 
> That sounds good, i.e. we could narrow the JIT falling back case to
> these SELinux cases and the like, distinct from generic internal errors.
> 
> Maybe it's too much paranoia, but it should work & get rid of the
> ambiguity.

Nah, it's fine.

>>> [snip]
>>> See above, but maybe it's the least sucky thing (and definitely
>>> simpler). I'm mainly checking that we're doing that we want here, and
>>> that we're going into it with eyes open.
>>>
>>> That we're now discussing a topic entirely different from SELinux on a
>>> thread where we're (according to the commit message) fixing pcre2 where
>>> the JIT is "unusable on such systems" is my main concern here. 
>>
>> Yeah, I overlooked that angle initially, but it's a valid concern.
>> However, limiting the functional change of falling back to interpreter
>> mode on "JIT's broken anyway" systems only should address these and get
>> me a functional 'git grep' again.
> 
> *nod*
> 

>>>>> [snip]
>>>
>>> To summarize some of the above, I think performance also matters, we
>>> have cases where:
>>>
>>>  A. We could use the non-JIT
>>>  B. We could use the JIT, and it's a *lot* faster
>>>  C. We can't use the JIT at all
>>>  D. We can't use the JIT because we run into its limits
>>>
>>> I think it's fair to die on "D" as in practice you only (I think!) run
>>> into it on pathological patterns, but yes, another option would be to
>>> fall back to "A".
>>>
>>> But thinking you're doing "B" and not wanting to implicitly fall back to
>>> "A" is also a valid use-case.
>>
>> Agreed. My above sketched handling should do that, as in not falling
>> back to interpreter mode when the JIT would be functional per se, but
>> just failed on this particular pattern.
>>
>>> So I'm inclined to suggest that we should be less helpful with automatic
>>> fallbacks, and just suggest a "try it with '(*NO_JIT)'" advice() or
>>> something.
>>
>> Well, that's a real pain from a user's (my) point of view. Trust me, I'm
>> suffering from this, otherwise I wouldn't have brought up the issue ;)
> 
> That's fair enough, falling back in the "D" case sounds good.
> 
>>> But as noted above needing to always disable an apparently "available"
>>> JIT on some systems (SELinux) does throw a monkey wrench into that
>>> particular suggestion :(
>>
>> Yep.
>>
>>> So I'm not sure, I'm mainly trying to encourage you to think through the
>>> edge cases, and to summarize the full impact of the change in a re-roll.
>>
>> Yeah, I agree. The implied fallback to the interpreter, even for the
>> more obscure cases should have been mentioned in the changelog, but I
>> overlooked / ignored that case initially.
>>
>> My take from the discussion is to do a re-roll with something like this:
>>
>>   if (p->pcre2_jit_on) {
>>       jitret = pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_COMPLETE);
>>       if (jitret == PCRE2_ERROR_NOMEMORY && !pcre2_jit_functional()) {
>>           /* JIT's non-functional because of SELinux / PaX */
>>           p->pcre2_jit_on = 0;
>>           return;
>>       } else if (jitret) {
>>           die("Couldn't JIT the PCRE2 pattern '%s', got '%d'\n"
>>               "Try prefixing the pattern with '(*NO_JIT)'\n",
>>               p->pattern, jitret);
>>       }
>>       ...
>>   }
>>
>> ...with pcre2_jit_functional() being something like this:
>>
>>   static int pcre2_jit_functional(void)
>>   {
>>       pcre2_code *code;
>>       size_t off;
>>       int err;
>>
>>       code = pcre2_compile((PCRE2_SPTR)".", 1, 0, &err, &off, NULL);
>>       if (!code)
>>           return 0;
>>
>>       err = pcre2_jit_compile(code, PCRE2_JIT_COMPLETE);
>>       pcre2_code_free(code);
>>
>>       return err == 0;
>>   }
> 
> This seems sensible as pseudocode, although please don't add another
> pcre2_compile() entry point (as e.g. passing NULL here will bypass the
> context we carefully set up, and if we have a custom allocator...).

That was intentional, actually. I specifically want to use the most
basic API to test for "general JIT availability." That test should tell
if PCRE2 JIT is working /in general/, not specifically how we make use
of it in git, which might not. However, that would be a different error,
i.e. not because PCRE2 failed to allocate JIT memory but us using the
API wrong, hitting limitations, etc.

Making use of the PCRE2 context we set up in compile_pcre2_pattern()
(and thereby possibly generating errors because of it) could mask API
usage errors resulting from these and may lead to a false fallback to
interpreter mode when we want to die() instead?

> Instead you could just re-enter the API itself via
> compile_grep_patterns(), or perhaps lower via
> compile_pcre2_pattern(). Then add some flag to "struct grep_opt" to
> indicate that we shouldn't die() or BUG() there, but just run a "jit
> test".

This feels kinda hacky and overkill, actually. A dedicated simplistic
test looks much cleaner, IMHO.

> This code also treats all failures of pcre2_jit_compile() the same, but
> here we only want PCRE2_ERROR_NOMEMORY.

Does it really matter? I mean, we could change the final test to 'err !=
PCRE2_ERROR_NOMEMORY' but we also return early when we're unable to
generate PCRE2 code for the "." pattern -- not strictly a JIT error as well.

I'd say instead of splitting hairs, pcre2_jit_functional() should stay
as above, as a failure to compile "." as a pattern can only happen (a)
under very tight memory constraints or (b) for JIT internal reasons,
which would boil down to not being able to allocate the required
resources to generate JIT code --- it's such a simple pattern it's not
expected to fail in any other way. Case (a) can be ignored, IMHO, as
that would lead to follow up errors soon anyway.


Thanks,
Mathias
