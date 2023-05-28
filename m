Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA74C77B7C
	for <git@archiver.kernel.org>; Sun, 28 May 2023 12:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjE1MER (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 May 2023 08:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1MEP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2023 08:04:15 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEE8AF
        for <git@vger.kernel.org>; Sun, 28 May 2023 05:04:14 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-30ae967ef74so130827f8f.0
        for <git@vger.kernel.org>; Sun, 28 May 2023 05:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685275453; x=1687867453;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PrUOZwnx9qDI30hKgWIlEU8P3hWIuMStwFwuPIJu5J0=;
        b=WwAIRO7bLXm4xMF0tiUvc72IC0ro9LnS+pyaxk3x0EysWpK7zjhOidZ6tsUF4QZPud
         DK15iSHhuhcpsS20DuA1SlfY2hSRbBgiSaF66Wk3Et2gGdg2y6ZfvwEjWZ3RhtIuuJ4E
         ArXvKsZU7x/LTiEJQ7vJjjjeODzCstRzZMHErjSZir3XVvul9m/v9Wk7GUfcogtWl+FS
         HuqKXfDRNZiBk/4D25Pa0lw0JpTMFaOAsZBTtv4IjLRhZxOrVnIYdimDcdIww90Yh7pL
         OnkgHExelHT21lO//jUvvExxIhWAwYjW+lSqt/NrpK8aGl33SJ4frY+Com4AbPJkC1n5
         6bQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685275453; x=1687867453;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PrUOZwnx9qDI30hKgWIlEU8P3hWIuMStwFwuPIJu5J0=;
        b=ff2KRM1R4TXX0ClvNjzSpH4e05nFoP6i9j65X2cLB2vMqUPH2GDE4lc45Oh8sm6Dm7
         mA4pSt8d5vdWwJyqETJQM3H+RgX/pmSim24Q185Pga9ldA7CH+hbsJHgiDGl3ZzfzdR8
         dSFwyOpg41ACQUO8LfpsA9N/NbxmoCFe+cLNTcpGMFbxG3pdiO4L3wCDPPw0tlNOTmNa
         stbXkIp2UGWO+Hyb9ktfGHAB7kj++0IA5+H4RwawsBLksD8mo3Bv/C2ZbQyBIcHsR8rH
         BN/wX57C0MaNLFvK1jnnkFVJmF+0n9VhbGELzKDS327tM3Y/dlenol82GS3Wmt8yZpEh
         nrLA==
X-Gm-Message-State: AC+VfDw8WbGLRd3TElQPJQ7jHPournpkzW8R8AKSupb9wJ3OM6vqff1a
        +RwfabN8ZZDbiBlk56+Sn34BtHGURJE=
X-Google-Smtp-Source: ACHHUZ78ZIIX1J+iRLIjG8nxR727o0/a+2wwCLnyxixPlh1XBSwvcKVc3e/nY5z2g0WjpYsAmPgsUA==
X-Received: by 2002:a5d:5648:0:b0:307:8fa5:6e36 with SMTP id j8-20020a5d5648000000b003078fa56e36mr7184876wrw.54.1685275452638;
        Sun, 28 May 2023 05:04:12 -0700 (PDT)
Received: from [192.168.1.212] ([90.255.142.254])
        by smtp.gmail.com with ESMTPSA id o8-20020adfcf08000000b00306c5900c10sm10759889wrj.9.2023.05.28.05.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 May 2023 05:04:12 -0700 (PDT)
Message-ID: <4d29e5d4-6ce3-c099-15a7-e89ad787780d@gmail.com>
Date:   Sun, 28 May 2023 13:04:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/7] sane-ctype.h: move sane-ctype macros from
 git-compat-util.h
To:     Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org
References: <20230526211911.2291886-1-jonathantanmy@google.com>
Content-Language: en-US
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230526211911.2291886-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Calvin and Jonathan

On 26/05/2023 22:19, Jonathan Tan wrote:
> Calvin Wan <calvinwan@google.com> writes:
>> Splitting these macros from git-compat-util.h cleans up the file and
>> allows future third-party sources to not use these overrides if they do
>> not wish to.

I think splitting these out makes sense. If you have time to add a 
comment highlighting the differences from the standard library versions 
that would be really helpful. As far as I know the differences are

  - our versions are locale independent
  - our isspace() does not consider '\v' or '\f' to be space
  - our versions expect a signed or unsigned char rather than an int
    as their argument
  - our versions do not accept EOF
  - our versions do not require an explicit cast to avoid undefined
    behavior when passing char on systems where char is signed

>> Signed-off-by: Calvin Wan <calvinwan@google.com>
>> ---
>>   git-compat-util.h | 65 +-------------------------------------------
>>   sane-ctype.h      | 69 +++++++++++++++++++++++++++++++++++++++++++++++
> 
> Any specific reason for the "sane-" prefix? I think it would make more
> sense if it was just named ctype.h: see below.

I don't have a strong opinion either way but "sane-ctype.h" makes it 
clearer why we're doing something different to the standard library.

>> -/* in ctype.c, for kwset users */
>> -extern const unsigned char tolower_trans_tbl[256];
> 
> I'm not sure what this has to do with sanity, but this is indeed defined
> in ctype.c, so it's easier to justify moving this out if the criterion
> was "what's in ctype.c" rather than "what's related to sane ctypes".

There is only one user of this so it could be moved to 
diffcore-pickaxe.c or kwset.c where it would be more discoverable if 
anyone needs to add another user in the future.

>> -extern const signed char hexval_table[256];
> 
> And this one has nothing to do with ctypes or sanity, but rather, what's
> considered to be a hex character. I think we need another patch to move
> this to hex.h.

Isn't "what's considered  to be a hex character" related to ctypes and 
sanity though as it is used by the "sane" definition of isxdigit().

>> -#define isxdigit(x) (hexval_table[(unsigned char)(x)] != -1)
> 
> Same for this one.

I'd much rather keep all of our "sane" ctype replacements in one place 
as Calvin is proposing. isxdigit() is defined in <ctype.h> so it should 
be in our "sane" version of that header.

Best Wishes

Phillip

> With the above suggestions, I think we do get what we want - a split
> between things that make ctype more sane and between other compat stuff,
> and also a split between those two and more platform-agnostic things
> like what a hex character is.
