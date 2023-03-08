Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68FFC64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 23:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjCHXKp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 18:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjCHXK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 18:10:29 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E5DB6D2B
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 15:10:00 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id ju20-20020a170903429400b0019ea5ea044aso39538plb.21
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 15:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678317000;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iJXpjAUrl7vc8piCMYDLNZy9x3/hP5TsREUYywC9ta8=;
        b=McadfQgkbycNEbnEE340pf5l9Ja0Nt0tnqUFZVsEjj3o1ivCodfpWLdGIlSTMm7fya
         GRWJr/HOVSqz4sNmbZQHKs1ho320ytKjgXMItbhCs4gyfDApQpROhmMgpp7L7BtM/g/r
         AEwLZP1S3CZtMKaobuj2/8NaGnKWC3ZaCL13SaOWCgNEbsq9vwMQ4eBSh+0evxNQk5nX
         5sQU8mHndUnVQLZ3ZteiuTJvLpSfl8l9RUx5+DUDx/ha1jB/ypQc8Di2mHwQ9+pUuRCp
         FlpdrciNkPVwZtqpU/xcI7ZvYAqL01Em9zMgjHLXXnN66UHsOF1qEMZDMRZaTnh8Ft7A
         nqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678317000;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iJXpjAUrl7vc8piCMYDLNZy9x3/hP5TsREUYywC9ta8=;
        b=ES+CqZRWXR+RPMDoitsj7JlOEsYEDZg75gW9EY5vhoFSu/hCMxFWZhFiFbXFVSEnjN
         4gmkMtJzWmcWT375sLgvNNMcJn2nnLcnTSR2ir19+2GF1o6lAr5ptMvm2gtvKSRL7mG1
         HFc1uuUhAKI1nikxTAlFlyi2K2cmi+YMtrQvi+ita2I99h+0k7O2rqI7wxS5a1u1CZIj
         SA9p3j7/1qRH94krOZjO25RIslbShjYO1qJELnSOjRGQ+xRiEgPLVZCL4BENKplMh5Nq
         uNe6vEmafVaoP3024iWDaDPZBloJS/ao9Ky0vEWaDvVcnlC6ElL9tTprrXtkCVxp/Mlo
         Qweg==
X-Gm-Message-State: AO0yUKWsr9cMaIq9+wyTTHkVSDOZDAe3luQ9EqHwv07OIWG3LhJw0MEQ
        dBltincDmEwW9T7y9kzgRe0cDco4/n6QGw==
X-Google-Smtp-Source: AK7set9PdUltUIK04M4dFloccxh55yDqPrVzTUcOeI+Avj/ddj0fsFueV29DipXwq8F96XHKgUXyTDVwiIvj6Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a63:9318:0:b0:503:917e:c0a3 with SMTP id
 b24-20020a639318000000b00503917ec0a3mr7101493pge.2.1678317000108; Wed, 08 Mar
 2023 15:10:00 -0800 (PST)
Date:   Wed, 08 Mar 2023 15:09:52 -0800
In-Reply-To: <230308.86y1o7y0jc.gmgdl@evledraar.gmail.com>
Mime-Version: 1.0
References: <kl6l356heeqb.fsf@chooglen-macbookpro.roam.corp.google.com>
 <20230306223804.3414251-1-jonathantanmy@google.com> <230308.86y1o7y0jc.gmgdl@evledraar.gmail.com>
Message-ID: <kl6lr0tyhmbj.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 0/6] [RFC] config.c: use struct for config reading state
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Mar 06 2023, Jonathan Tan wrote:
>
>> Glen Choo <chooglen@google.com> writes:
>>> By configset interface, I believe you mean the O(1) lookup functions
>>> like git_config_get_int() (which rely on the value being cached, but
>>> don't necessarily accept "struct config_set" as an arg)? I think that
>>> makes sense both from a performance and maintenance perspective.
>>
>> Ah, yes. (More precisely, not the one where you call something like
>> repo_config(), passing a callback function that.)
>>
>>> Given how painful it is to change the config_fn_t signature, I think it
>>> is important to get as right as possible the first time. After I sent
>>> this out, I thought of yet another possible config_fn_t signature
>>> (since most callbacks only need diagnostic information, we could pass
>>> "struct key_value_info" instead of the more privileged "struct
>>> config_reader"), but given how many functions we'd have to change, it
>>> seemed extremely difficult to even begin experimenting with this
>>> different signature.
>>
>> Yeah, the first change is the hardest. I think passing it a single
>> struct (so, instead of key, value, data, reader, and then any future
>> fields we would need) to which we can add fields later would mean that
>> we wouldn't need any changes beyond the first, though.
>
> For the configset API users we already have the line number, source
> etc. in the "util" member, i.e. when we have an error in any API user
> that uses the configset they can error about the specific line that
> config came from.

Yeah, and I think we should plumb the "util" (actually "struct
key_value_info") back to the users who need that diagnostic info, which
achieves the same purpose as plumbing the "config_reader" to the
callback functions (since the callback functions only need to read
diagnostic information), but it's better since it exposes fewer gory
details and we can refactor those using coccinelle. The difficult part
is replacing the callbacks with the configset API in the first place.

> I think this may have been conflated because e.g. for the configset to
> get the "scope" we need to go from do_git_config_sequence(), which will
> currently set "current_parsing_scope", all the way down to
> configset_add_value(), and there we'll make use of the
> "config_set_callback", which is a config_fn_t.

I think this is half-right (at least from a historical perspective). We
started by just reading auxiliary info like line number and file name
from the "current config source", but when we started caching values in
config sets, we had to find another way to share this auxiliary info.
The solution that 0d44a2dacc (config: return configset value for
current_config_ functions, 2016-05-26) gave us is to also cache the
auxiliary info, and then when we iterate the configset, we set the
global "current_config_kvi" to the cached value.

So they aren't conflated per se, since the reason for their existence is
so that API users don't have to care whether or not they are iterating a
file or iterating a configset. But as you've observed...

> But that's all internal "static" functions, except
> git_config_from_file() and git_config_from_file_with_options(), but
> those have only a handful of callers.
>
> But that's *different* than the user callbacks, which will be invoked
> through a loop in configset_iter(), i.e. *after* we've parsed the
> config, and are just getting the line number, scope etc. from the
> configset.

in practice, very few users read (and should be reading) config directly
from files. Most want the 'config for the whole repo' (which is handled
by the repo_* and git_* functions) and others will explicitly call
git_config_from_file*() so I don't think the config API needs to keep
users ignorant of 'whether the current config is cached or not'.

We could convert callbacks to the configset API, and if we then we plumb
the key_value_info to the configset API users, maybe we can retire
"current_config_kvi".

> There's other edge cases, e.g. current_config_line() will access the
> global, but it only has two callers (one if we exclude the test
> helper). But I think the answer there is to change the
> config_read_push_default() code, not to give every current "config_fn_t"
> implementation an extra parameter.

I agree that we should rewrite config_read_push_default(), but wouldn't
we still need to expose auxiliary information (line number, scope) to
users of the callback API? e.g. config.c:die_bad_number() uses the file
name [*], and builtin/config.c definitely needs it for 'git config -l'.
Also, an express purpose for this series is to prepare
git_config_from_file() to be used by callers out-of-tree, which would
definitely need that information.

I'm not sure if you're proposing to move state from "the_reader" to
something like "the_repository.config_state". I'd hesitate to take that
approach, since we're just swapping one global for another.

[*] config.c:die_bad_number() is actually a bit broken because it
doesn't use the cached kvi info from the config set. I'll probably send
a fixup patch to fix this.
