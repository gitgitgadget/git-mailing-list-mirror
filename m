Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5C8C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 19:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbiLTTaq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 14:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbiLTTaF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 14:30:05 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822791DA6A
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 11:30:03 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id v7so9568366wmn.0
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 11:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cIIftC/ykI3fN6ZXjrTM+P1JItL8zMW6qjyrMeAAgIY=;
        b=dwKm8dSJiwFjZdzdfCZ8zZejwmVwBHiArnJrihkwwYOlklOG1fscesfEKwYZnV0bcp
         C1jzP7/+4GPwDpFTDZMCGlPYDWDV4vHqLCd85gyfF2yc9VAfCOswhkxe1xI8orixRjlU
         m337bPP2c2bgcn/N48Vq81pFRHY6A9qS3DU79H2ILjVh277p4Rbr56Zav26B5jjovVWq
         J1NmT+CwIt1bwlAp+s3Wq5ovDgLio5a7V1Q42mipVnZZ/a3s32RFekCP4SRHQLStZ6+w
         AS2yCi4DPQWbnD/CUzmixTr3yrIOgIVSZhcAExd+TZRgdbkR2z3/Lt1+ZkRumdX4bxjY
         ip5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cIIftC/ykI3fN6ZXjrTM+P1JItL8zMW6qjyrMeAAgIY=;
        b=x13MTQ65kkaHVT8zcHzjG9fma2IzF5mdL1FQutoAgiVYD0F5okf3tGd51QEb1saYSn
         4lSXqgbrxTMLtm4rSjrtXcYi7pleckly2B5T3ATkQYpyEo7ewyv4RdnaBEDvVN3/VHfy
         fdzh/TXpiqfcUeVGMiceDPnTmHTV0hc3WqDw/piG0TGdIr0zs5+qAOO5AnFNdQVgUCW4
         SWZ4AluoGEEh6IF6sBjzhgVjj5GCdOei9HApJ2v3vUhJkPaFJ7qWSWshXtYpPOkW1Bo4
         np9KK1asc+XEtmLHgaZFZfGkwuucJLav973A7WvwvEiCTCg8hd16K3/7MLB77YJRlWmP
         O/hw==
X-Gm-Message-State: ANoB5pmUqf8ONglbTIAf9IxsxWThivN5qqTrSNtlC1tFjZvwjjZNb7fz
        l3W5eZvH0kLrr7V/X39w4qJRrqJGsrA/Zk8c
X-Google-Smtp-Source: AA0mqf7Iwf6Ro+H63dPN7gUaW2sfGT/c3VH68CwsTL9tt0JyqPQHh+U+vzBfY+OWIm/9HgCN25vdew==
X-Received: by 2002:a05:600c:21c2:b0:3d1:e907:17c1 with SMTP id x2-20020a05600c21c200b003d1e90717c1mr36131362wmj.38.1671564602064;
        Tue, 20 Dec 2022 11:30:02 -0800 (PST)
Received: from ?IPV6:2003:f6:af0c:f800:f5ff:4df9:7300:71d0? (p200300f6af0cf800f5ff4df9730071d0.dip0.t-ipconnect.de. [2003:f6:af0c:f800:f5ff:4df9:7300:71d0])
        by smtp.gmail.com with ESMTPSA id q1-20020a1c4301000000b003d04e4ed873sm24030148wma.22.2022.12.20.11.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 11:30:01 -0800 (PST)
Message-ID: <2b04b19a-a2bd-3dd5-6f21-ed0b0ad3e02f@grsecurity.net>
Date:   Tue, 20 Dec 2022 20:29:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] grep: fall back to interpreter mode if JIT fails
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Carlo Arenas <carenas@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        pcre-dev@exim.org
References: <20221216121557.30714-1-minipli@grsecurity.net>
 <221216.86o7s31fyt.gmgdl@evledraar.gmail.com>
 <62a06c5b-9646-17f8-b4d5-39823d3cc25a@grsecurity.net>
 <xmqqlen7kksr.fsf@gitster.g>
 <CAPUEspjqgSOS4KKw2nTaRYdiCFo4Ok6OfmKrqb+Mjq+oXn5nsg@mail.gmail.com>
 <221219.86bknz21qj.gmgdl@evledraar.gmail.com>
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <221219.86bknz21qj.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.12.22 um 10:00 schrieb Ævar Arnfjörð Bjarmason:
> 
> On Fri, Dec 16 2022, Carlo Arenas wrote:
> 
> [CC-ing pcre-dev@ for this "future error API" discussion]
> 
>> On Fri, Dec 16, 2022 at 3:09 PM Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> Mathias Krause <minipli@grsecurity.net> writes:
>>>
>>>> ... However, from a user's point of view a fall back to
>>>> interpreter mode might still be desired in this case, as a failing
>>>> 'git grep' is simply not acceptable, IMHO.
>>>
>>> "git grep" that silently produces a wrong result (by falling back
>>> after a problem is detected) would not be acceptable, either.
>>
>> except that an error at this point only invalidates the use of JIT,
>> so calling pcre2_jit_match() is invalid but calling pcre2_match() is not.
>>
>> the later is setup to be used later by the code that is added,
> 
> I think we could stumble ahead, but if this were to happen our
> assumptions about how the API works have been invalidated.

Well, pcre2_jit_compile() might fail for internal reasons, e.g.
pcre2jit(3) states: "[...] If a pattern is too big, a call to
pcre2_jit_compile() returns PCRE2_ERROR_NOMEMORY."

For example, the following fails for me:
$ git grep -P "$(perl -e 'print "(.)" x 4000')" -- grep.c
fatal: Couldn't JIT the PCRE2 pattern '(.)(.)(.)(.)…

But explicitly disabling JIT makes it "work":
$ git grep -P "(*NO_JIT)$(perl -e 'print "(.)" x 4000')" -- grep.c
$

It's a made up example and might even be intended behavior by git, but
it also proves a point Carlo already mentioned, a failing call to
pcre2_jit_compile() only invalidates the use of the JIT engine. We can
still use and fall back to the interpreter.

It would be used anyway if PCRE2 was compiled without JIT support, so I
don't see any issues with falling back to interpreter mode if the JIT
compilation fails -- for whatever reason.

> The pcre2_jit_compile() doesn't promise to return a finite set of error
> codes, but:
> 
> 	[...]0 for success, or a negative error code otherwise[...]
> 
> But if new codes were added it's anyone's guess what state we'd be in,
> so I think the safe thing is to BUG() out if we get as far as
> pcre2_jit_compile() and don't get either PCRE2_ERROR_JIT_BADOPTION or
> PCRE2_ERROR_NOMEMORY.

But why BUG()? JIT is an optimization that might fail for PCRE2 internal
reasons. Why should we make 'git grep' fail too in this case when we can
handle it just fine by attempting to use the interpreter?

If the pattern is really bogus, the interpreter will complain as well
and we'll error out. But failing just because the JIT engine can't
handle the pattern? Doesn't sound right to me.

>>> Receiving BADOPTION could be a sign that there is something wrong in
>>> the input, not from the end-user but from the code, in which case
>>> stopping with BUG() may be a more appropriate?
>>
>> The way PCRE handles this kind of errors internally is to instruct pcre2_match()
>> to use the interpreter.
>>
>> While a BUG() might be a way to ensure the code is using the right set
>> of options
>> I would expect that the failure will be reported by pcre2_compile
>> instead, with the
>> only cases left, only being interna to PCRE (ex: JIT can't yet support
>> a feature the
>> interpreter has)
> 
> I agree that it's possible in general that an external library might
> start returning a "benign" error code that we could recover from, so
> BUG(...) would be overdoing it.

And I think that's the case here: JIT is an optimization that might not
be available under all circumstances, as, for example, under SELinux's
'deny_execmem' setting. So we need to have a backup plan for such
systems anyway. Why not always try to use the interpreter if JIT
compilation fails?

> I just don't see that libpcre would do that in this case. In general the
> JIT supports all patterns that the normal engine does, so if we're past
> the "is it available?" hump it should work.

Leaving my above example aside, showing that JIT cannot handle very long
patterns the interpreter mode does, it is, in fact, unfortunate that
libpcre2 announces JIT support when it could know better that it does not.

In fact, I also try to fix this misbehavior in PCRE2/SLJIT[1,2], but the
maintainer thinks it's a bug in git which should be fixed by handling
errors from pcre2_jit_compile() and falling back to interpreter mode[3].

While I still think this can pretty much be fixed in PCRE2 alone,
handling possible PCRE2 JIT errors in git and falling back to
interpreter mode is still a sensible thing to do.

[1] https://github.com/PCRE2Project/pcre2/pull/157
[2] https://github.com/zherczeg/sljit/pull/136
[3] https://github.com/zherczeg/sljit/pull/136#issuecomment-1307254018

> If it starts not doing that I'd think they'd do a major version upgrade,
> or opt-in with a new flag etc.
> 
> Note that it already has a way of checking for "we tried to do the jit
> thing, but it wasn't on in the end". See the code I added in
> a25b9085043[1] (grep: fix segfault under -P + PCRE2 <=10.30 + (*NO_JIT),
> 2017-11-23), which comes right after the pcre2_jit_compile().

Yeah, that's required as well, unfortunately. :/

> So not only would a BUG() biting us here require them to create a new
> code for the state of "we have the JIT, but can't use it here" (for some
> reason I can't imagine, as "PCRE2_ERROR_NOMEMORY" is already
> "overloaded" to mean that).
> 
> It would also require them to invent a new "soft" failure mode for the
> JIT, i.e. not the facility added in a25b9085043, where we can use the
> JIT, but it's not on after all due to a "(*NO_JIT)" in the pattern
> itself.

We should really treat PCRE2 JIT as an *optional* optimization that
might not be available for certain cases. For these we should, IMHO,
simply use the interpreter mode, instead of bugging users with a BUG() /
die().

> But I may be wrong, so I've CC'd pcre-dev@ to see if they have any
> commentary on this proposed API paranoia. For them: The greater context
> of this thread on the git ML is at [2].
> 
> 1. https://github.com/git/git/commit/a25b9085043b8029169b4d5b172b78ca3f38fb37
> 2. https://lore.kernel.org/git/20221216121557.30714-1-minipli@grsecurity.net/

Thanks,
Mathias
