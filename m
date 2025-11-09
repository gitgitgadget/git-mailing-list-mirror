Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215972FBDEA
	for <git@vger.kernel.org>; Sun,  9 Nov 2025 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762697662; cv=none; b=OW3ejHqeZfMQ8mlJWTNc//ZS+6VqJmugwrP3o6PBqaoerCiNPEZUAGVoizpbnxBRstgJHU7SKYb+z1jIl+MN1RvE9a8DVqrhID6/EphuO8gGinGw8VfeIklodM99IWWg9qA5HfhfHDs8s2AKGA3xfDeaEvjmaN6/j3RpWCYiQuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762697662; c=relaxed/simple;
	bh=oQOPPzmDCQ7J9SapbKj+D/4lsYHnfIQ3OUcmrU6qQ/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NEhPypbUrc4J/kXz5yVRjhaAePkWuCP/69dZUtM/rKP4YBPGBwkZWCPQDtbHX2PYH0p1TxmSvUAsxCfyu8HZb7itLrLZ5HEcUZDt0PreFY3wTJXpK7pWaQMbn+zxUK2fdyA60tuEmX/gtCJJzkaRz4bqGNdldonM2CzjJOE7wd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkvks4Wp; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkvks4Wp"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477632cc932so8236245e9.3
        for <git@vger.kernel.org>; Sun, 09 Nov 2025 06:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762697658; x=1763302458; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xtbnbv2tnwvp3cL9qRR4GYfFv62sq5wJahnLAPHXPDA=;
        b=dkvks4Wp+O+zSIVEdiu2CodSzEs6VD2ZZkB7n6JP/68bSrkrMZ8W0vT56lpH/UeBdx
         IGaTLh8SibxSSmBA5ZH3uqs6qDuLfxHp8xZD8lVM9fz5YNqHW8ACgb1IOWlYvsGL2EKE
         kahx+4rNQQmOTy9FQ9DG3b4SWMPPT41N2ihlcGc+lkmMS/zp7+6zs4zJQft4IXTFjqSE
         VvVFLD7wpF+GR4sUvlMXjKQpa8u56UloY5v5zLp+l54fxLYW6kU2u5o2+Kdzk7Uq4yNp
         XbTn4RKnJAAewwnZzyumMhHnof5uv+ktHAOQhqBVOqoCE43gPS9v0mYOAr1W00z36l2E
         U+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762697658; x=1763302458;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtbnbv2tnwvp3cL9qRR4GYfFv62sq5wJahnLAPHXPDA=;
        b=HjWlL+4aoJ+X1Uf/npiUpT7FgmuSW+3CN/0HIAJW+xwGDYGNtTiRGttVFiUHSl9UmZ
         oJr2hthEomAZZCX56x+4e9PrSAcaiKLC4Z+kj9wGlQYtc5LP2pcAsPym4hEU9IHH5gyX
         UAfCqKu0edjgAKIWKGCKk9Gxvg/QFjRJIu/9GKAFJmo0pLTJ5F2Mv6gq0sm1Vdkqwwxw
         G1LAf1TdVg49C/jhw2xbIfFX2CcLmQWh3Fwcs7/NNe59VWYHnEphlxvWOdNf+8IP4sb7
         mr+8I/lk4qMRX5U37rwWzelVbKiCMHfjCseT8aF1OptmY80Q0gqZSJ53su+KU6KtNEbY
         T22g==
X-Forwarded-Encrypted: i=1; AJvYcCW+lmtO9iwN0L5ewHVI4iwGLWL+OFComEgsjP4Rkc56b0OTQYnxvqtuJup4rrJWQbnwA/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJdyJ6Q/iHvWG5KSIRqvYU5a+4gzdkmvcUqTdkRQTSftSNCEjL
	PqgCcNILJKouqWv+1WKBSoZzVKQZ4f9guQzTqv52OF6Ohmt5cvys7fQk
X-Gm-Gg: ASbGncvMuWLAtadzCdN16O5PvTwcr6RpexOaO8FBPG7NkqRFZS0+kheIcrIKLsoIIAE
	oeEoIPWET2yGhnPOWqNzEG+z52YMS0EhhQRLNRsOrpEBpffRS0f0Hoe8F3DGC6PUchb3AUJoH3Z
	EADa0mmbLw6SvzxwqLhT7VsLxP7mqXd+eR+7XySs6nAZWGNgJrXGEvLI0b7XpPijC14LPFAKJZs
	3IIZPRUlur7e15RdXJyDtXNjaEpSSJbwfq38Z46oU87XgYUpicXLTdlKlEGI4StakkNBow9C0Yg
	ss868Cy9tsj8Mdcaq5xqAEMavm4KCH6y+aucz3/56FYkeMWUR3Qw7ZPDt7xOQ0isnKqL87QwH4r
	rSd1QKv0nifh6fumbyGLXax3G9IqE3fbrXo0dF1M+HBZxbJl8MekIINXAsmF9s1kzGXBOKqGC8N
	VeuXU1LfL9KJJVCUb1rVQHURg2+VY9jQ87wF1vWSIaRoO4uTFrEBi9
X-Google-Smtp-Source: AGHT+IHNWFe/XNmt2lqk3UKGmgrzSMCCIyBQfvHd8vGJkKAbzy2FaYUssEUX+tiGR2Kl8xHRFxF9TA==
X-Received: by 2002:a05:600c:4753:b0:475:dd8d:2f52 with SMTP id 5b1f17b1804b1-47773293939mr57752545e9.32.1762697658241;
        Sun, 09 Nov 2025 06:14:18 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cd45466sm268184605e9.0.2025.11.09.06.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 06:14:17 -0800 (PST)
Message-ID: <fa95b29a-077c-4df5-9c59-34e0c1447e70@gmail.com>
Date: Sun, 9 Nov 2025 14:14:11 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 01/10] doc: define unambiguous type mappings across C
 and Rust
To: Ezekiel Newren <ezekielnewren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Patrick Steinhardt <ps@pks.im>,
 Chris Torek <chris.torek@gmail.com>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
 <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
 <88133848d1a317f8a95c19ee5482b828a3f8705f.1761776388.git.gitgitgadget@gmail.com>
 <995f77a3-b94c-46df-87d3-22c7b2a3c762@gmail.com>
 <CAH=ZcbA25eyMhQpvK7eh=ydZkg5RdzbdRFEdj-22T+d1VuTazA@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAH=ZcbA25eyMhQpvK7eh=ydZkg5RdzbdRFEdj-22T+d1VuTazA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/11/2025 22:52, Ezekiel Newren wrote:
> On Thu, Nov 6, 2025 at 2:55 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 29/10/2025 22:19, Ezekiel Newren via GitGitGadget wrote:
>>> From: Ezekiel Newren <ezekielnewren@gmail.com>
>>>
>>> Document other nuances with crossing the FFI boundary. Other language
>>> mappings may be added in the future.
>>
>> Thanks for adding this, I've left a few comments below. Overall I
>> thought it was very well written.
> 
> Thanks.
> 
> I felt it was necessary since C vs Rust types keep coming up over and
> over again. I'm flexible with the wording of this document. I was just
> trying to convey a firm and clear stance on what is and isn't proper
> in Git.

That will definitely be useful as we add more rust code. In the future 
we may want to add a summary of which types to use to 
Documentation/CodingGuidelines but that doesn't need to be done in this 
series.

>> I tried building an html version of
>> this but even after adding it to the list of TECH_DOCS in
>> Documentation/Makefile with
>>
>> diff --git a/Documentation/Makefile b/Documentation/Makefile
>> index 47208269a2e..2699f0b24af 100644
>> --- a/Documentation/Makefile
>> +++ b/Documentation/Makefile
>> @@ -143,6 +143,7 @@ TECH_DOCS += technical/shallow
>>    TECH_DOCS += technical/sparse-checkout
>>    TECH_DOCS += technical/sparse-index
>>    TECH_DOCS += technical/trivial-merge
>> +TECH_DOCS += technical/unambiguous-types
>>    TECH_DOCS += technical/unit-tests
>>    SP_ARTICLES += $(TECH_DOCS)
>>    SP_ARTICLES += technical/api-index
>>
>> it fails with
>>
>> $ make -C Documentation/ technical/unambiguous-types.html
>>                                         Merge branch
>> 'ps/object-source-loose' into seen
>> make: Entering directory '/home/phil/src/git/Documentation'
>>       GEN asciidoc.conf
>>       * new asciidoc flags
>>       ASCIIDOC technical/unambiguous-types.html
>> asciidoc: ERROR: unambiguous-types.adoc: line 139: undefined filter
>> attribute in command: source-highlight --gen-version -f xhtml -s
>> {language} {src_numbered?--line-number=' '} {src_tab?--tab={src_tab}}
>> {args=}
>> asciidoc: ERROR: unambiguous-types.adoc: line 162: undefined filter
>> attribute in command: source-highlight --gen-version -f xhtml -s
>> {language} {src_numbered?--line-number=' '} {src_tab?--tab={src_tab}}
>> {args=}
>> asciidoc: ERROR: unambiguous-types.adoc: line 177: undefined filter
>> attribute in command: source-highlight --gen-version -f xhtml -s
>> {language} {src_numbered?--line-number=' '} {src_tab?--tab={src_tab}}
>> {args=}
>> asciidoc: ERROR: unambiguous-types.adoc: line 187: undefined filter
>> attribute in command: source-highlight --gen-version -f xhtml -s
>> {language} {src_numbered?--line-number=' '} {src_tab?--tab={src_tab}}
>> {args=}
>> asciidoc: ERROR: unambiguous-types.adoc: line 199: undefined filter
>> attribute in command: source-highlight --gen-version -f xhtml -s
>> {language} {src_numbered?--line-number=' '} {src_tab?--tab={src_tab}}
>> {args=}
>> asciidoc: ERROR: unambiguous-types.adoc: line 213: undefined filter
>> attribute in command: source-highlight --gen-version -f xhtml -s
>> {language} {src_numbered?--line-number=' '} {src_tab?--tab={src_tab}}
>> {args=}
>> asciidoc: ERROR: unambiguous-types.adoc: line 224: undefined filter
>> attribute in command: source-highlight --gen-version -f xhtml -s
>> {language} {src_numbered?--line-number=' '} {src_tab?--tab={src_tab}}
>> {args=}
>> make: *** [Makefile:396: technical/unambiguous-types.html] Error 1
>> make: *** Deleting file 'technical/unambiguous-types.html'
>> make: Leaving directory '/home/phil/src/git/Documentation'
> 
> I've never created documentation for Git before, so this helps. I'll
> incorporate your suggestions.

We should also add this file to Documentation/technical/meson.build. It 
seems those errors above are due to some incompatibility between 
asciidoc and asciidoctor as I just tried running

     make -C Documentation/ USE_ASCIIDOCTOR=1 
technical/unambiguous-types.html

and it worked just fine. I'm afraid I don't know enough asciidoc to make 
any helpful suggestions on how to fix it.

>>> +== Character types
>>> +
>>> +This is where C and Rust don't have a clean one-to-one mapping. A C `char` is
>>> +an 8-bit type that is signless (neither signed nor unsigned)
>>
>> I found this a bit confusing. Isn't the signedness of "char"
>> implementation defined rather than it being "signless"
>>
>>> which causes
>>> +problems with e.g. `make DEVELOPER=1`.
>>
>> I'm not sure what this is referring to - maybe -Wsign-compare?
> 
> When I build Git with `make DEVELOPER=1` and I compare uint8_t with
> char it complains about a difference in signedness. When I compare
> int8_t with char it also complains about a difference in signedness.
> So it is implementation defined, but it's also neither signed nor
> unsigned according to DEVELOPER=1 since it complains either way.

Oh, I see - this is saying mixing "char" and "uint8_t" causes problems. 
I agree, perhaps we could expand this slightly to mention comparison 
with uint8_t to make it clearer.

>>> Rust's `char` type is an unsigned 32-bit
>>> +integer that is used to describe Unicode code points. Even though a C `char`
>>> +is the same width as `u8`, `char` should be converted to u8 where it is
>>> +describing bytes in memory.
>>
>> I'm dreading the point where we start sharing "struct strbuf" with rust
>> and have to change the "buf" member from "char*" to "uint8_t*". While it
>> is not used in the xdiff code it is ubiquitous everywhere else and there
>> are lots of places where be pass the "buf" member to functions expecting
>> a "char*".
>>
>>          git grep -E '(\.|->)buf\W'
>>
>> has over 4000 matches
> 
> This is why I started in Xdiff since its code is mostly isolated.

Good plan!

> I
> think that we might have to bite the bullet and deal with the ugly
> mapping of char on the C side and u8 on the Rust side when dealing
> with strbuf. Maybe as we translate more of C into Rust someone will
> have a better suggestion. I think my ivec type would be better since
> strbuf is almost a special case of my ivec type, but dealing with
> strbuf is outside the scope of this patch series.

Yes, hopefully it will become clearer what the least painful route 
forward is as we get more experience with rust <=> C iterop.

>>> +While you could specify `char` in the C code and `u8` in Rust code, it's not as
>>> +clear what the appropriate type is, but it would work across the FFI boundary.
>>> +However the bigger problem comes from code generation tools like cbindgen and
>>> +bindgen. When cbindgen see u8 in Rust it will generate uint8_t on the C side
>>> +which will cause differ in signedness warnings/errors. Similarly if bindgen
>>> +see `char` on the C side it will generate `std::ffi::c_char` which has its own
>>> +problems.
>>
>> Yeah, we definitely don't want to be using "std::ffi::c_char" in our
>> rust implementations. I do wonder if we might want to use it (or CStr)
>> judiciously in function parameters and immediately convert it to u8 in
>> the function body where the function is called from C though.
> 
> That's basically the design pattern I've been using.
> 
> In many of my translations from C to Rust I create a Rust stub
> function that takes pointer types and wraps them into safe types which
> then get handed off to a safe Rust function. I think that in the cases
> where CString/CStr is required the Rust stub function would create a
> &[u8] slice for the safe function to operate on.

That sounds like a good pattern - we get a nice interface for the C code 
and the rust implementation uses the idiomatic rust types.

Thanks

Phillip

>>> +=== Notes
>>> +^1^ This is only true if stdbool.h (or equivalent) is used. +
>>> +^2^ C does not enforce IEEE-754 compatibility, but Rust expects it. If the
>>> +platform/arch for C does not follow IEEE-754 then this equivalence does not
>>> +hold. Also, it's assumed that `float` is 32 bits and `double` is 64, but
>>> +there may be a strange platform/arch where even this isn't true. +
>>> +^3^ C also defines uintptr_t, but this should not be used in Git. +
>>> +^4^ C also defines ssize_t and intptr_t, but these should not be used in Git. +
>>
>> [u]intptr_t and ssize_t are used in git already. As Junio has pointed
>> out there are sane uses for these types but we don't want to use them in
>> structs or function parameters where the struct or function is shared
>> with rust.
> 
> You're right, I should update the phrasing. Something like: "These
> types shouldn't be used if their explicit purpose is for FFI. Whether
> as a field in a struct or part of a function signature." I'll update
> the wording.
> 
>>> +
>>> +== Problems with std::ffi::c_* types in Rust
>>> +TL;DR: They're not guaranteed to match C types for all possible C
>>> +compilers/platforms/architectures.
>>
>> Is this official policy of the rust project?
> 
> No, this is a personal inference based on logical deduction. The c_*
> definitions have changed over time with new Rust version releases, and
> Git targets more platforms/architectures than what Rust officially
> supports. While it's not guaranteed that it won't work everywhere.
> It's also not guaranteed to work everywhere either. On top of that
> we're targeting 1.63.0 who's c_* definitions are different in 1.89.0
> which I show an example of with c_long_definition. Can anyone say with
> certainty that Rust got these mappings right or wrong for all possible
> C compilers/architectures/platforms? If so (which I highly doubt)
> could someone provide a link?
> 

