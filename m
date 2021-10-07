Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BDDC433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA58261090
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240827AbhJGKb1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 06:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbhJGKb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 06:31:26 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003E4C061746
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 03:29:31 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id p13so21671899edw.0
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 03:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=3iiz4fZtRK+AqKXKg5OYhuwaws/TEmIp4j9rTYsf8Bc=;
        b=Z8UO/BnJECsKNZFV3HQNxgSNYJe/guDpZlorRoZpX8XWrIS42xZSsLfqu9ofE3t5Ef
         OwKPMJrn3witWkOja44c/CLzdWfDR1btwjlZ+v7dixU9UUDjLnUx0bzEK6ZCcBvTUQIi
         3x8flGssT10JVXAMjOBFZHfu6nZwngHYNfoEQDkjRLym0h2W/kM3KZu6zcc6Ace81Dfe
         3JZ3be67DJZkMmYtDEE0+t+rrt5NMkENbiPIp5xDBDwQ+VcF9IdkuwKPsmCBS4LqnKAh
         iykig165zyQ9LtgywI6S6Cu8G8yuc/RgNYCLom3IUXxrWd4bqqSP4iLo0k0fTgGbfoZM
         +fpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=3iiz4fZtRK+AqKXKg5OYhuwaws/TEmIp4j9rTYsf8Bc=;
        b=lV5/HGxaJXu5JwdOwUZJtb/0AOz+poxaTMjWltmJ0uDyhfnZmnG2I1M2ccHGWt1ty4
         7djLg600yCPWqs2/J5scmVkA0dTivHp+zSHV4tur4XLlGgdylowzI7l7nFrtQbCmAAAo
         dvA9VIkpWXDn1kgAaAdGkuig2dtETsHeIN5vyKVJWUWYz4dlyBftpJ1o60jaAyO9NIVo
         BpCggdnqeRsAcJGhdzRBeMXvsswsuUhfVbBLElcnAHLSDZH5dq/wcHP/zKvVbhHxqNcV
         SLUCkkQ0krdLgT0NR4i8WLmqatzZumar82nE+3qDHMKWDGk6FGhSkrrP6JAJJh9ZnkrF
         qfhw==
X-Gm-Message-State: AOAM533dIRbxmTJICzr49f8V+BiMpu4385TdvdhHqDj3iLgMNw98e1D8
        W4mNXlXfWrBS1eLodGgO9wQ=
X-Google-Smtp-Source: ABdhPJzF+bKJN/5n8p4ykcwwuYsKnmQADNcyFaoUCptisEXTsSrMQGIR9gZK5wUTUY1cR5cA2ZS3ZQ==
X-Received: by 2002:a17:906:5789:: with SMTP id k9mr3048272ejq.107.1633602570074;
        Thu, 07 Oct 2021 03:29:30 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ee13sm9066975edb.14.2021.10.07.03.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 03:29:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/5] cat-file: mention --unordered along with
 --batch-all-objects
Date:   Thu, 07 Oct 2021 12:18:45 +0200
References: <YVy1sx8Xb1xMLFQT@coredump.intra.peff.net>
 <YVy2DNd+XemykKE0@coredump.intra.peff.net>
 <877derjia9.fsf@evledraar.gmail.com>
 <YVzGeE1T/Kp8DDZD@coredump.intra.peff.net>
 <87tuhuikhf.fsf@evledraar.gmail.com>
 <YV3LonbeIS8DrMsN@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YV3LonbeIS8DrMsN@coredump.intra.peff.net>
Message-ID: <87k0ipgmbb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 06 2021, Jeff King wrote:

> On Wed, Oct 06, 2021 at 11:02:59AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> I thought that --batch-all-objects and --batch were mutually exclusive,
>> but they're obviously not.
>
> Right. In fact, the former is useless without the latter (or
> --batch-check).
>
>> In my defense I think the help/code is very confusing. I hacked up some
>> WIP changes to change it from:
>
> That's fair, but...
>
>> Looking at the history it seems you added --batch-all-objects around the
>> same time as the OPT_CMDMODE() was used in the command, so we should
>> probably have something like this to start with:
>>=20
>> -- >8 --
>> Subject: [PATCH] cat-file: make --batch-all-objects a CMDMODE
>>=20
>> The usage of OPT_CMDMODE() in "cat-file"[1] was added in parallel with
>> the development of[3] the --batch-all-objects option[4], so we've
>> since grown[5] checks that it can't be combined with other command
>> modes, when it should just be made a top-level command-mode
>> instead. It doesn't combine with --filters, --textconv etc.
>
> This is not right. --batch-all-objects does not provide a mode exclusive
> with "-t", etc, by itself.

Yes it does. See the "if (opt) {" branch on master. We just don't
implement it via a cmdmode, but --batch-all-objects can definitely be a
CMDMODE (I see you found that out below...)

> Those in theory should be OPT_CMDMODE, but I don't think they can be,
> because they also take an argument. So we'd need some OPT_CMDMODE_ARG()
> or something, but then it needs _two_ value fields. So I think it would
> require major surgery to parse-options.

Aside: I think it would be worth it to teach it a general concept that
option X is incompatible with option Y, or group X, Y, Z and declare
those as incompatible with another group.

The current CMDMODE check is rather cryptic seemingly because it's
trying to avoid re-looping over the list while it emits an error.

> Using --batch-all-objects without --batch or --batch-check would be an
> error, and we do flag it as such.

*nod*

> So you are not wrong that using --batch-all-objects with -t is nonsense,
> and we do indeed error on it currently. But it is not because the two
> are themselves exclusive, but because of the chaining of the two rules.

Isn't it nonsense? I think so. I suppose we could make it a a synonym of
some --batch=3D<fmt> in that context, but that just seems like complexity
for no good reason.

> The groupings you showed in your larger output mostly make sense, but...
>
>>     Run <rev>:<blobs|tree> via conversion or filter
>>         --textconv            for blob objects, run textconv on object's=
 content
>>         --filters             for blob objects, run filters on object's =
content
>>         --path <blob>         use a specific path for --textconv/--filte=
rs
>>=20=20=20=20=20
>>     Emit objects in batch via requests on STDIN, or --batch-all-objects
>>         --batch-all-objects   Emit all objects in the repository, instea=
d of taking requests on STDIN
>>         --buffer              buffer --batch output
>>         --batch[=3D<format>]    show info and content of objects fed fro=
m the standard input
>>         --batch-check[=3D<format>]
>> [...]
>
> These groups aren't mutually exclusive. You can use --textconv in batch
> mode. Which further muddies the CMDMODE waters; --batch is a mode that
> overrides "-t", but _not_ "--textconv", where it is a modifier.

Indeed, I conflated --batch* there again, those two are mutually
exclusive with --batch-all-objects, but not the other two. Will update
if I get to submitting this...
