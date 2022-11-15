Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757B0C433FE
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 01:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbiKOBoX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 20:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiKOBoV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 20:44:21 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677F42DCD
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 17:44:20 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id 13so32761777ejn.3
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 17:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lG3LoXN7HkxWQaxle28La+azBeoS/dG6nvKWZh4Ok64=;
        b=feCh/ar9GNJQrYo9vmfgDjM79jpupwROEv+4aULVu/BKkd7Z1awpoTw1kKxUTIYBVO
         5okWZdtNf6GY/jV/UVsV25gtp4dZ1kTIJ340m5PTskgQQlZDdxZ6lvMDtOtTZkYRM61t
         BGwpphdPutWu9rBPYC1gZcDkfYcUpghp6ET6sgsZs0oTtt2T6E+22xuneqO+qMwIvGKH
         o9G+bY/ZfQmDtARdSih6PJ4J4/uzjKQb7Ts56lzotvgG8a6BsDU/DhfePjXy4kB8dt2+
         J5+frBsMS+Sg+7HEpbdsdVc/STTE9Dw469+nGyPbgoV4KVbSs7HlWAK5ITc30Iix8Dlh
         Q4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lG3LoXN7HkxWQaxle28La+azBeoS/dG6nvKWZh4Ok64=;
        b=s1VQEPmwszqjhW4MfcC7dTfy+9xg95zk5WcX+3Iwd0n1a1mLxgktUd0xWyZc2tYd5+
         qeoC9rUQuc10eXo18QsetVJMgpqNLVPTXvzvy53xOJwb9LlXKBWO2LodGai89rynxZOY
         hCH9Ch2Z+AUIf7FF4iWUAzdJVj+1V+Ce0LQzGeI1qtSEgloWgGIb8kwpAWhuxT7oJKTJ
         Os6xSIVe6B+PIM25u2YJXSU3o7hWHP9AiGd21oFuweokmrEs06jmqpUHT337QgrZjK9m
         CbpGqsoxI1z+hM3HxxPAxzjNpJ0P0+MWY1NhhjOfdoRwoz9t4trVI+YlJkn7WuzJdDX3
         y9dA==
X-Gm-Message-State: ANoB5plDJo5ZtU/Kd0rbUvRyuD/DjzyS+/J4Z1gzWYyrxEZSfOdlJ95D
        h+YoZV+o60OpM+zN1LOuEcKsE0ymIYZhNg==
X-Google-Smtp-Source: AA0mqf7TgWEJV3LhJf8A4YBp80GVcdnEqs6Ek5zz+QJTalQSI+NyKMIb1Zaa45hSzpu+nU8ukp5i5g==
X-Received: by 2002:a17:906:29d6:b0:7ad:b284:1357 with SMTP id y22-20020a17090629d600b007adb2841357mr12516246eje.149.1668476658799;
        Mon, 14 Nov 2022 17:44:18 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id we10-20020a170907234a00b00782fbb7f5f7sm4849747ejb.113.2022.11.14.17.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 17:44:18 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oukzp-003LqS-0N;
        Tue, 15 Nov 2022 02:44:17 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] Get rid of "git --super-prefix"
Date:   Tue, 15 Nov 2022 02:37:45 +0100
References: <20221109004708.97668-1-chooglen@google.com>
        <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
        <kl6ltu373ae5.fsf@chooglen-macbookpro.roam.corp.google.com>
        <221110.86zgcznjah.gmgdl@evledraar.gmail.com>
        <kl6l5yfm2taf.fsf@chooglen-macbookpro.roam.corp.google.com>
        <kl6lv8nl1h19.fsf@chooglen-macbookpro.roam.corp.google.com>
        <221111.86fsepmbhe.gmgdl@evledraar.gmail.com>
        <kl6lsfip0yfx.fsf@chooglen-macbookpro.roam.corp.google.com>
        <221114.86y1sdlq2d.gmgdl@evledraar.gmail.com>
        <kl6lmt8tnmbt.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <kl6lmt8tnmbt.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <221115.864jv1kn4e.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 14 2022, Glen Choo wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> As noted in the CL above I included this because I see you're keen to
>> include it, but I'm personally a bit "meh" on it. I.e. it's just
>> renaming an existing unrelated option, although being able to use
>> OPT__SUPER_PREFIX() makes it slightly nicer.
>>
>> As post-cleanups go I think removing the "submodule_prefix" from the
>> "struct repository" would make more sense, and maybe it's worth peeling
>> off the 10/10 to include in such a post-cleanup series? I.e. the below
>> on top of all of this works, and reduces allocations and cargo-culting
>> around the submodule API.
>
> As a first impression I'm not particularly keen on this, since it makes
> perfect sense to me to have a repo->submodule_prefix, especially when
> recursing into N-level deep submodules...

This is mainly a quick experiment I drafted up, with that context...

>> -- >8 --
>> Subject: [PATCH] repo & submodule API: stop carrying "repo->submodule_pr=
efix"
>>
>> As this change shows the "submodule_prefix" field to "struct
>> repository" added in 96dc883b3cd (repository: enable initialization of
>> submodules, 2017-06-22) was only used by "ls-files" and "grep". Let's
>> have those two carry forward the "super_prefix" instead.
>>
>> Having every user of "struct repository" needing to worry about this
>> created a mismatch in the API where e.g. "grep" would re-compute a
>> "name_base_len" which we knew before. Now we use a "struct strbuf" in
>> the "struct grep_opt" there instead, so we'll know the length
>> already. This simplifies "grep_cache()" and "grep_tree()".
>>
>> We're also deleting cargo-culted code that the previous API foisted
>> upon us. In 605f0ec1350 (submodule: use submodule repos for object
>> lookup, 2018-12-14) the "Mark it as a submodule" code was added to
>> "open_submodule()", but the resulting xstrdup()'d "submodule_prefix"
>> was never used by anything.
>
> (As an aside, I think open_submodule() should have been replaced by
> repo_submodule_init().)
>
> In which case, yes it isn't used by anything in that code path, but
> being meticulous about maintaining .super_prefix means that other
> callers could use it if they wanted to, which might be crucial once we
> start plumb "struct repository" deeper and deeper and...

...I just don't see the point of maintaining an API with this sort of
reach for just two callers, when it's a bad fit for what those two
callers need.

>>
>> Still, removing this field might not be a good move, as the
>> "super_prefix" might be a common enough case in the future, e.g. when
>> eventually migrating the "submodule--helper" users[1] to run
>> in-process.
>>
>> As the "grep" example demonstrates I don't think that's the
>> case. There instead of xstrdup()-ing all the way down we're now
>> carrying a single "super_prefix" in the form of a "struct strbuf". As
>> we recurse we then append to it, and strbuf_setlen() it back when we
>> we recurse out of that submodule. This is similar to how e.g. the
>> "read_tree_at()" API works.
>
> This technique might no longer be so appealing. We _could_ pass both
> "struct repository" and "super_prefix", but that seems odd given that
> the super prefix is tied to the repository.

FWIW I don't even think a "super_prefix" being tied to a repository is a
useful abstraction level in general.

E.g. I've got some local hacky patches to make "git ls-tree" able to
recurse down submodules, and for that code you usually just want to
print the prefix to the current *dir*, and having to print the prefix to
the current module, then the current dir-within-module, then the file
just makes things needlessly complex.

> But that's just a first impression anyway. I don't mind taking another
> look if this gets a standalone review.

*nod*
