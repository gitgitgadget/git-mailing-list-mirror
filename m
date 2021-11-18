Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613AAC433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 02:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 358A461ABF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 02:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241744AbhKRCgR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 21:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbhKRCgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 21:36:16 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EE1C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 18:33:16 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id t5so20280934edd.0
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 18:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=zAzoO6ClvNxjzmUYrF+iw1ksnPJenzbAVgW+cji9Jgk=;
        b=UppICyk1tKgyywtF+sg/BA4qWVAiznsF0axdAvqPXgunviSOHkmEfH4RjFMadOCph+
         TT28VOOK64U3Ee4m9onl07e7g3qGXDZJaG1CuUBd7QSlFVf0DcedGueylcmzX9i73mFL
         6M47df5cBTljQhYLJiGU97r4Cl/V6DjsUou7RScuc241gglzfOV8uENnLfCHnIQnia1A
         A2ra28LttwWg92bi14yv5tIwtMtSZTkIPuTKQyt+uTS1AY1dPEfZOdfu9b5LEMngFiaj
         Jr3N+ztynlvfwGjD+nlVHJwmPYNs3KpArl8mwSveyZpEHcx7fkKmXvuSpmOF4f5jvw+y
         tLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=zAzoO6ClvNxjzmUYrF+iw1ksnPJenzbAVgW+cji9Jgk=;
        b=nbi3vvb5NPK65alxzCEElX39hJkYozm/Fz6EE3fwSspOC9x0L2e8DryByzxJjw0baP
         g7FJ8UPKGrDwIjq0nGf7wfUIlP1tPjexXuXF2ZpNV4reUy1gOzmNfi66oaWdW1jmrlo4
         O21+MEy5+x6+RRlskr6zF16yzzcrXBMGLgknGAhcggOi1HGDnFfa9tpZaYvrYhd6u6gn
         6Ucs7NOyvHqrEkFB3GFSLJP9S0TsVt6EbY8ID8Wqo5kLrgaeULHEfTR60Ho2PLrAXyqu
         UBLyZfv/So3DV85hcLtL+zSofAIiiIn7OvNKcn/HYanWHja/pzgW9bTI5Yca1K3YxYel
         umbA==
X-Gm-Message-State: AOAM530fh11+VmMWChg+Gz0FIocnTrCAkLaztAMUDGhbcIZMPeH5O+zE
        co0lT3FxgXhOY43Bh1zM+wrLH1rd906Kog==
X-Google-Smtp-Source: ABdhPJxGxDlzKZ0FE8W8GIRKOl+3hO2uYYjGOFvBPvjRPhWhGulf/4a6OYmiMi1H5WfX5+FOhovecQ==
X-Received: by 2002:a05:6402:7d8:: with SMTP id u24mr5587757edy.215.1637202795117;
        Wed, 17 Nov 2021 18:33:15 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id go10sm661935ejc.115.2021.11.17.18.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 18:33:14 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mnXEf-000Jxa-SL;
        Thu, 18 Nov 2021 03:33:13 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/1] git-compat-util: add a test balloon for C99 support
Date:   Thu, 18 Nov 2021 03:26:58 +0100
References: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
 <20211116021241.1565740-1-sandals@crustytoothpaste.net>
 <20211116021241.1565740-2-sandals@crustytoothpaste.net>
 <YZOh370ZMMqSADUE@coredump.intra.peff.net>
 <211116.86pmr0p82k.gmgdl@evledraar.gmail.com>
 <YZPGKHYE/9km1rH5@coredump.intra.peff.net>
 <YZRurUdyB/cGL6Y3@camp.crustytoothpaste.net>
 <YZRwpekXlilhOEx4@coredump.intra.peff.net>
 <YZWNumAlsek9Gi22@camp.crustytoothpaste.net>
 <CAPUEspg=ef9xSiYsVKHfo7zogExeMwL3gMnN_bq1QcKv0fnNng@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <CAPUEspg=ef9xSiYsVKHfo7zogExeMwL3gMnN_bq1QcKv0fnNng@mail.gmail.com>
Message-ID: <211118.86lf1m5h1y.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 17 2021, Carlo Arenas wrote:

> On Wed, Nov 17, 2021 at 3:18 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>>
>> On 2021-11-17 at 03:01:57, Jeff King wrote:
>> > My thinking was that breaking older compilers was preferable to breaking
>> > non-gnu ones, because at least old ones go away eventually. But your
>> > other email makes me wonder if those non-GNU ones may already be
>> > overriding CFLAGS.
>>
>> Our only problem platform, as far as I can tell, is RHEL/CentOS 7.  That
>> uses GCC 4.8, and even Ubuntu 18.04 ships with GCC 7.
>
> There are several odd BSD platforms that are still stuck in pre-GPLv3
> gcc (AKA gcc 4.2.1) like OpenBSD Alpha, hppa, landisk (and maybe also
> SPARC64 which is tier1) and that will need the same, there is indeed
> also luna88k that uses an even older gcc but hopefully will be able to
> work if it understands enough C99 and can be told to use it by this
> flag.
>
>> > Still, if we can come up with a solution that breaks neither (with some
>> > light auto-detection or heuristics in the Makefile), that could be the
>> > best of both worlds.
>>
>> I can move COMPILER_FEATURES out of config.mak.dev and into Makefile so
>> that we can make use of it.  We'll need to depend on GCC 6 for this
>> because we lack a way to distinguish 5.1 (which should work) from 5.0
>> (which will not).
>
> 5.0 works AFAIK, is anything older than 5 than does not as reported[1]
> before, but it won't be still a good fit, since it only works for gcc
> and clang AS-IS.
>
> Carlo
>
> [1] https://lore.kernel.org/git/CAPUEsphnCvK+RZ+h30ZarA1zo9yZ=ndEBrcAbKGf4W92j647vA@mail.gmail.com/

Rather than moving around COMPILER_FEATURES etc. we can just compile a C
program as part of our Makefile auto-configuration. See the direction
suggested in:
https://lore.kernel.org/git/87bl6aypke.fsf@evledraar.gmail.com/

That example is ad-hoc, but the right way to do this is:

 1. Stick a C program somewhere, maybe git-autoconf/compiler.c 
 2. (Try to) Compile that unconditionally
 3. Emit its output to a generated file that we then "include", which
    likewise if it fails indicate that in something the Makefile can
    "include".

Since we set up that file-based dependency relationship we'll only do
that auto-detection on the first build.

This is really much simpler than fiddling with the version parsing
shellscript, i.e. we can just compile a program with -std=c99 or
whatever and see if it works, and if it does we stick that flag in
CFLAGS or equivalent.
