Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA1DC433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 00:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbiKJAqT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 19:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiKJAqD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 19:46:03 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59D9165A6
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 16:45:30 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id s15-20020a170902ea0f00b00187050232fcso233506plg.3
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 16:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KmV5zy5hxtpVtmipdFh4FjcJke/5A+lN/FP3D3JRf4k=;
        b=KPLjGWl/7j6e+EUkasq/sO7rFIJvtQVZMA0EllgOMGgB/aHuM38wdSuHyj6aLRO1w7
         ionpqwOLJm6OLFvqyW5Ic8WtzHuggU+38hAKC0+1ZFnrPzdui9++zjaUj2cevCvK0QCs
         Lm13D4/crhRE0m0IThhIDFVSsCjbGkv4yg041UV6yEd4MZ8AhwgQrwsqurobFYie0iBU
         0+9BupoU7Bw4cc0OYJXCyqgBqV5p/cYaKaacY3b0sHEAj6jcJack1FlO62fXiGZTjKMM
         4ouaqy5zUhPzR9LsdEJtPR+nhSVKEIKnXhaVoyosq/ChmZ7czRqQqoBKEKgglNntVwgP
         gVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KmV5zy5hxtpVtmipdFh4FjcJke/5A+lN/FP3D3JRf4k=;
        b=7sIy+EahbbX/LgHT41Qrmwvdc2dB9zZ6X+vp0KQlDdhv3qW6CjOPG9O6J5/N/ErhD3
         6RHr+MITK28++HhsUWwH9bu0Fw3D1hnf1pE8jZnI8tCj5rNzjt4verHtu43+XQMR6l96
         ZS3lUeLEpM0GHYuQyUw8n3XAb4kfFIOMmAxvBLjL4jwq8xLSJQnM/S3zR+rWjpHjICO2
         wVNjCWvD7WqbkleJFQeO+XvKDO0g5vphNFKflMJkJrjIQdSHWpiFYoAnCZD4ACZNKJHK
         t6qxTkJLyJ7UYeT+VIiEiRI2ZJeJpya9CDcvrshGp8pV+oJQVbCKbOcNm6Ouy44FlYtv
         lDVw==
X-Gm-Message-State: ANoB5plMstZtzcKfYzbYhNgiTG0uL7JSWiSyG1ypE+qol/fw3D0dbLjQ
        Czf8tgE1yrGKbAUW7YxX7qUpsRqXjYo3Gw==
X-Google-Smtp-Source: AA0mqf5vcpNXW2FZ/5odq/h1WHl3/BFkYZF6GikhC/Tyac4G8ZScrNYIeeYxlSGZvPHz5jxdTc1CUIb8FQeu/g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:744b:b0:188:8e6b:978a with SMTP
 id e11-20020a170902744b00b001888e6b978amr8112635plt.11.1668041130313; Wed, 09
 Nov 2022 16:45:30 -0800 (PST)
Date:   Wed, 09 Nov 2022 16:45:22 -0800
In-Reply-To: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
Mime-Version: 1.0
References: <20221109004708.97668-1-chooglen@google.com> <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
Message-ID: <kl6ltu373ae5.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [RFC PATCH 0/8] Get rid of "git --super-prefix"
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the series! I haven't fully figured out where I stand on
this, but I can share some initial thoughts and comparisons to my RFC.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> An RFC alternative to Glen's [1], and what I *thought* he might be be
> going for in the earlier discussion[2].
>
> The difference is that in Glen's there's no "git --super-prefix", but
> rather each set of commands still using it ("submodule--helper",
> "read-tree" etc.) geit their own command-level option.

Yes, and a secondary intent was to give exact definitions and a shared
implementation to the command-level options instead of having each new
command figure out what to do every time a similar use case pops up.

>
> But it still works substantially the same, in that we're juggling a
> global variable that we set, and read out later somewhere down the
> stack.

Yes, intentionally so. I was under the assumption that the various
prefixes would still be used, and that adding them to commands will be a
necessary evil, so it was better to have them share a single
implementation.

> Whereas here there's no renaming of the option, but:
>
>  * For "submodule--helper" only the sub-commands that need it take the
>    option, it's not an option to "submodule--helper" itself.

In writing [1], I ended up convincing myself that it isn't just that all
of "submodule--helper" _does_ support "--super-prefix", but that all of
it _should_ support "--super-prefix". I'll have to take another look.

At the very least, the subcommands that are just entrypoints for
git-submodule.sh should support it, since they all need to print
submodule paths in a semi-consistent way. I still think it would be nice
for these to take a top level flag.

There are other subcommands that are implementation details of other
commands that need to run in a submodule because of assumptions
the_repository, e.g. create-branch, push-check. Maybe these don't need
"--super-prefix", I'll take another look.

I'm not sure if there are others.

(As an aside, when you remove git-submodule.sh, I wonder if we should
split up submodule--helper along this dual-use line? e.g. the ones that
are entrypoints could be moved to "builtin/submodule.c", and the
implementation details can stay in "builtin/submodule--helper.c". Or
maybe you're already one step ahead of me here :))

As you noted (somewhere) in the series, only commands called recursively
need "--super-prefix", because otherwise "submodule--helper" is called
from the root of the superproject and the 'prefix' is already
well-known. I didn't make this argument because it was hard to word, so
I'm glad you mentioned it.

[1] https://lore.kernel.org/git/20221109004708.97668-2-chooglen@google.com/

>  * There's no passing of the "super_prefix" as a global, instead we
>    pass it all the way along until we recurse to ourselves. For
>    "submodule--helper" this is quite straightforward.
>
>  * Then in 8/8 we're left with just "read-tree" needing the remaining
>    "--super-prefix", and we likewise don't pass it as a global, but
>    instead add it to the "struct unpack_trees_options", which will
>    pass it all the way down into unpack-trees.c and entry.c, until
>    we're going to recursively invoke another "read-tree".

I worry a little about two "necessary evils":

- (As stated earlier) we may have to add "--super-prefix" or similar to
  more commands
- We may need to read "--super-prefix" from many parts of the code,
  since many parts might print paths.

Having globals makes both of these cases easier, and is quite a bit
closer to the original implementation of "--super-prefix" (so your
characterization of only getting to a halfway point is accurate). This
was mostly to stave off opposition that it would tedious to add new
per-command "--super-prefix"-es, but if nobody else cares, maybe it's ok
to get of the globals.

If we do want to pass a context object around, we probably have to be
more principled about it (e.g. in 8/8 I notice that checkout_stage()
doesn't receive the context object and we resort to passing NULL
instead), but we'd want that anyway if we want Git to move towards being
more library-like.

It's quite likely that if any new "--super-prefix"-es are added, they
would be added by a Googler (even the original ones were ;)), so I can
probably go through the roadmap and figure out how costly these extra
"--super-prefix"-es might be.
