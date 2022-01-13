Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7B6C433FE
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 13:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbiAMNYS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 08:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbiAMNYR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 08:24:17 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B19C06173F
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 05:24:16 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id t24so22931371edi.8
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 05:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=HXyM+e0zCQbnveJmG6qFeYh3U99eO39MCJkV+sJAm74=;
        b=GtUA5m/GduHJF/wXg3hSKDbVUrGJSxkxKg5Pc8f0rB5gPpztaoDMyD3cJNa5W4x+W1
         79DVFe2oq8TOWHHfHGqVNp9p+JZIspO2jQZpWQZlrBk3I3zGy9IYz+JQHYjDo7/7I3Uu
         LYVs3mpOLxwpHMbAxROWwgrT9JGijq57AKN6khKXx4n7+ataUoyzlba+oj9bQGp0azIT
         xwZW0KYwicZEBXcOt0TinNIpDRfAZBWQL6bML/K7ucBiVSZK+QTpwB5lOtuMvCM5h8Rn
         q0gIa9oys67rrFcctlgpm0kXfesEK6fjRpkZIUvwth5aO9DEc51Lop3YzDSRVBHUQJ0s
         nGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=HXyM+e0zCQbnveJmG6qFeYh3U99eO39MCJkV+sJAm74=;
        b=brbmZOOClEbeW6yDpV9Pm6m53vepGR2Cp5LMhZ0Xno/mWLPA0cDpC1tJAK7/lXip/7
         zYCiqYQrHuBDsER97Q+ZiUmDlEXwzSN5afJsHeUubzfWFRXUPPlCh15Ix5+HFiJ4538Q
         7glDz/DKVhywKLMSaQmkCsajbBk07l+9IC3vSntrjojl+q94xeW/xgFLPtIHN2ajUBF+
         0gsbCpY1uT1Djzt6hZaCSyYTPJSEWgSP/ylFGvFAj5ru0dzvKZIJCkuSiI4IQ2S770Wv
         UZIg/ZzfUiJjSnJIx2cs15akx8tp5mMP7CaTiqxA/aqkxX4usTgYjbsDPYIIokXJeSp4
         x4YQ==
X-Gm-Message-State: AOAM533o2jU0T1v+fW1AzxHExnGkyxn+hE36FZfkINqVXWh6IF90O6Jf
        vISxxulb9JwS+57slnoCdE0=
X-Google-Smtp-Source: ABdhPJy9BfbufAMu91nXGVX5QYCNqNesyp9P3IKVXC67KYQ2PQQT914bvDZI6zoJQyG88fOqS2gzgQ==
X-Received: by 2002:a17:907:8a1a:: with SMTP id sc26mr3575052ejc.498.1642080254423;
        Thu, 13 Jan 2022 05:24:14 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hd17sm884843ejc.58.2022.01.13.05.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 05:24:13 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n805N-000w4g-7p;
        Thu, 13 Jan 2022 14:24:13 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     rsbecker@nexbridge.com, 'Taylor Blau' <me@ttaylorr.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [BUG] Re: Git 2.35.0-rc0
Date:   Thu, 13 Jan 2022 14:21:44 +0100
References: <00fd01d80691$c87e3ad0$597ab070$@nexbridge.com>
 <Ydzw+RqR6IfbT/oM@nand.local>
 <010b01d80697$0c848770$258d9650$@nexbridge.com>
 <Ydzyv8ZCEpDDRBXT@nand.local>
 <010d01d8069e$8d330480$a7990d80$@nexbridge.com>
 <xmqqzgo0u5j7.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqzgo0u5j7.fsf@gitster.g>
Message-ID: <220113.864k67vkea.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 12 2022, Junio C Hamano wrote:

> <rsbecker@nexbridge.com> writes:
>
>> diff --git a/config.mak.uname b/config.mak.uname
>> index a3a779327f..9b3e9bff5f 100644
>> --- a/config.mak.uname
>> +++ b/config.mak.uname
>> @@ -576,6 +576,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
>>         NO_SETENV = YesPlease
>>         NO_UNSETENV = YesPlease
>>         NO_MKDTEMP = YesPlease
>> +       NO_UNCOMPRESS2 = YesPlease
>>         # Currently libiconv-1.9.1.
>>         OLD_ICONV = UnfortunatelyYes
>>         NO_REGEX = NeedsStartEnd
>>
>> Could we get that into rc1?
>
> Sure, with an appliable patch that is properly signed off.
>
> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
> Date: Mon, 10 Jan 2022 22:51:39 -0500
> From: "Randall S. Becker" <rsbecker@nexbridge.com>
> Subject: [PATCH] build: NonStop ships with an older zlib
>
> Notably, it lacks uncompress2(); use the fallback we ship in our
> tree instead.
>
> not-Signed-off-yet-by: Randall S. Becker <rsbecker@nexbridge.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  config.mak.uname | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index a3a779327f..9b3e9bff5f 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -576,6 +576,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
>  	NO_SETENV = YesPlease
>  	NO_UNSETENV = YesPlease
>  	NO_MKDTEMP = YesPlease
> +	NO_UNCOMPRESS2 = YesPlease
>  	# Currently libiconv-1.9.1.
>  	OLD_ICONV = UnfortunatelyYes
>  	NO_REGEX = NeedsStartEnd

I've run into some other cases on testing on platforms hwere the
NO_UNCOMPRESS2 is now needed.

It's a bit of an annoyance, as git would previously compile cleanly on
almost any system with NO_CURL=Y NO_OPENSSL=Y, most of those with a C
compiler have a libz, even if it's ancient.

As I noted in
https://lore.kernel.org/git/87wnn62nhp.fsf@evledraar.gmail.com/ this use
of uncompress2() is just saving a few lines of boilerplate instead of
using the underlying zlib functions, which every other in-tree user
uses.

So I think it would be most welcome if someone wanted to work on moving
to that API use, and IMO such a change could even happen before the
final release. After all we don't use reftable for anything except the
tests it runs, so as long as those pass it IMO outweighs the new
annyonce in compiling git on those platforms.
