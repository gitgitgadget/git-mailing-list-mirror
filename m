Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD10C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 11:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiBPLCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 06:02:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiBPLCs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 06:02:48 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A191131F64
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 03:02:36 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id u1so2785164wrg.11
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 03:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SHo5y23SYBGsuLLl44Jw23tgD5Ds2Ki0ozG9UDBKenQ=;
        b=X/gQrlZQvJFK7mVAanKbfCY2viZlCchbhD1lKB8/bzHZbmrRizkQRN69K9PO7xpth8
         EA58CkWw/uZ6lx5Z6D+mdlhacA3jh6iuodcuZnDITlzxi93v92iWgLHrdP6NBPPd5eZY
         TiiTroP5nCjQLPYuQVUetDetA+g6wvt2ruHT9dJG/xNVhLqJ9nirK2NtPPgy8md7eeLt
         7GQb9EWqKAZaygelUmWs24rA+NDGTkUIqPG04UaoJurnmHLNCiwZLQPAphGvuYBr0TpL
         nGfdmTbwIsQm967qXqXEcR9teXINtGGHNfKjwPLBoncalUiaWH9DeTD/Ic1s5GiGrb+t
         ZwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SHo5y23SYBGsuLLl44Jw23tgD5Ds2Ki0ozG9UDBKenQ=;
        b=f84d8A8kQJSrWBzKKxfbblDmxeg6pMQ+on2uN5dmsjXPmx2MNN/uD99sZy/fNGxquX
         BOQvM27n6NKYEtif1XQ+C3mTEF3HLlFKzFWRBoU29Vk+Wu9HTJds5awa+dezCZr4GcaL
         ZayuZ7Y1Etey9Y7cKaehH9HiZ5F66BLP+zx8eAD37RaICqPnxa6DhtnrcrcFm2cu/tH/
         q5sEV6859lPKmqD2djI7BjjYlFD1abS0VlPBR1YrdUsKqpB08fXVTehMCrBBWQvX4dpH
         87DCERhENCEc/qS1Oc59TbeztC0veqEBQC4TnuAbtsmn5E9ci9vch0Og1eGIL5rKsfDh
         SBTw==
X-Gm-Message-State: AOAM530pNG8sY6JOU+/KrK8KPeTyJ8i3PYEP7YwvDaDj+Cze/qzg8zlo
        FG8tKekz1+0Eugvg9Klc/tAPYTDFlf8=
X-Google-Smtp-Source: ABdhPJxhZ/f30cLRa0plW/kDIPAvbCTsWWpNwkqyWRYFDkoVctPGwPyZgbA15k1VHnwJtZzAC/GRxA==
X-Received: by 2002:a5d:46d2:0:b0:1e4:b261:7e49 with SMTP id g18-20020a5d46d2000000b001e4b2617e49mr1823344wrs.669.1645009354891;
        Wed, 16 Feb 2022 03:02:34 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id az2sm27137900wmb.2.2022.02.16.03.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 03:02:34 -0800 (PST)
Message-ID: <7e6385f8-f25d-69f5-edae-6f5d6f785046@gmail.com>
Date:   Wed, 16 Feb 2022 11:02:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/1] xdiff: provide indirection to git functions
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Edward Thomson <ethomson@edwardthomson.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de
References: <20220209012951.GA7@abe733c6e288>
 <20220209013354.GB7@abe733c6e288>
 <220216.86wnhvvgeh.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220216.86wnhvvgeh.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/02/2022 23:40, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Feb 09 2022, Edward Thomson wrote:
> 
>> Provide an indirection layer into the git-specific functionality and
>> utilities in `git-xdiff.h`, prefixing those types and functions with
>> `xdl_` (and `XDL_` for macros).  This allows other projects that use
>> git's xdiff implementation to keep up-to-date; they can now take all the
>> files _except_ `git-xdiff.h`, which they have customized for their own
>> environment.
> 
> It seems sensible to share code here, but...
> 
>> +#ifndef GIT_XDIFF_H
>> +#define GIT_XDIFF_H
>> +
>> +#define xdl_malloc(x) xmalloc(x)
>> +#define xdl_free(ptr) free(ptr)
>> +#define xdl_realloc(ptr,x) xrealloc(ptr,x)
> 
> ...I don't understand the need for prefixing every function that may be
> used from git.git with xdl_*. In particular for these memory managing
> functions shouldn't this Just Work per 8d128513429 (grep/pcre2: actually
> make pcre2 use custom allocator, 2021-02-18) and cbe81e653fa
> (grep/pcre2: move back to thread-only PCREv2 structures, 2021-02-18)?
> I.e. link-time use of free().

I read that paragraph a couple of times and I'm still not sure I 
understand what you're saying. It is not unusual for libraries to define 
their own allocation functions and the code base is already using 
xdl_malloc etc so these defines seem quite reasonable. As you point out 
below we'd need wrappers for xmalloc() etc anyway so I'm not sure what 
the problem is.

> Of course trivial wrappers would be needed for x*() variants...
> 
>> +#define xdl_regex_t regex_t
> 
> This is a type that's in POSIX. Why do we need an xdl_* prefix for it?
> 
>> +#define xdl_regmatch_t regmatch_t
> 
> ditto.
> 
>> +#define xdl_regexec_buf(p, b, s, n, m, f) regexec_buf(p, b, s, n, m, f)
> 
> But this is our own custom function, which brings me to...
> 
>> +#define XDL_BUG(msg) BUG(msg)
> 
> ...unless libgit2 has a regexec_buf() or BUG() why do we need this
> indirection? Let's just have xdiff() use a bug, and then either libgit2
> will have a BUG() macro/function, or it'll fail at compile-time.
> 
> This seems to at least partly have been inspired by git.git's
> 546096a5cbb (xdiff: use BUG(...), not xdl_bug(...), 2021-06-07), i.e. we
> used to have an xdl_bug(), but now we just use BUG().
> 
> I then see on your libgit2 side 1458fb56e (xdiff: include new xdiff from
> git, 2022-01-29).
> 
> But why not simply?:
> 
>      #define BUG(msg) GIT_ASSERT(msg)
> 
> It would make things easier on the git.git side (etags and all).

If we want xdiff to be usable for other projects I think we're going to 
have to accept that it is sensible to namespace its functions.

Best Wishes

Phillip

