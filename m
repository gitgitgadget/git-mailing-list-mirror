Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29BFC4743D
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 00:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B7C2613C9
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 00:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhFEAZL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 20:25:11 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:42615 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhFEAZL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 20:25:11 -0400
Received: by mail-ot1-f45.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so6360128oth.9
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 17:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KYKtC9VZMTK3LV+N1p0kbI4hSj/rqIyf1qzdDqom/24=;
        b=rjlRjNUz4xTpljr3Z7S69Mi0RYAzxLVxeMXw3q+Uq9wU0dwHWyDZt7eRmaZiYQlYEn
         xYrDizT02PCD4NT7InGy9IJutT+pjR0+JuGn8rt5YtGOTVc+bUWWbx2WBgHTf4Ylpr8i
         GV5V0UXou8qT+EVuFll9bA8qtS5Oxce2NXCOiFaJgkpob9e/s5AWsLou02rLXheAy/UL
         tTzxSD2cx06yyEI+R7tzfNlzQlWYafMjwTby1CiT6AHrRJ/Is4VVdTCjC1NeARbTL7DH
         xrUEoLbU7Dfq8DisoKaf+6w2UEwpfB4Em/Pmu3O/A+T1BoCRCUoCl0yeiIe0GlEp8BMa
         Z6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KYKtC9VZMTK3LV+N1p0kbI4hSj/rqIyf1qzdDqom/24=;
        b=frlKeNvnLxuL150TZTzVSE1tUz7yjlBd7OjuCbJTEEY8yUiI5CTTd0UoZyvYu9IA/a
         oMRhi+ciPXqYhtyzcNNePaWTK7Tn0qgMk92xxZRcM98BQHodBPdaB2pJwS971hng7oHB
         fNzwBcb6AjreWtYUriB9v9uTRAZmve2m+mSzuMwiupnmnmdxFkjzo+TvoNMIgZbnSjAp
         q+lK0S1HpEZzMZz5mHxVW8bPQ3qSl86mM4x9TyEwDWP8oxZ8lTadWKVwLzm0eBdusvB4
         TqK+mjdEU5ji6619CcGE3Q5CXGg607NkdK4zZ0c/0C0FChaxO0VMnZj7QY+CwOyP/l3y
         9DPQ==
X-Gm-Message-State: AOAM530ZC58QxlVPUWpuLefb9R+pxPXKdzbUHcau4NicwPH+LpqNzdUH
        facYsTiHHX6ymwUhnMpmoQEEAsfam0G1Qfl/CKQ=
X-Google-Smtp-Source: ABdhPJwSMTdBrcxdMMp9yhTorx5AjcH5EYELuIGiAX5ssL49BtVAHSzq/h+sI+c72tvxcRpIeYTJooE2qUNKcwG4F18=
X-Received: by 2002:a9d:1a8:: with SMTP id e37mr5653629ote.316.1622852535545;
 Fri, 04 Jun 2021 17:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1622580781.git.jonathantanmy@google.com> <b70a00b9b06e5142bb95891cfc2faa87d708ef0d.1622580781.git.jonathantanmy@google.com>
In-Reply-To: <b70a00b9b06e5142bb95891cfc2faa87d708ef0d.1622580781.git.jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 Jun 2021 17:22:04 -0700
Message-ID: <CABPp-BGqt2DsrtJZ3_C5AajVyPsN+6a6rhMscSKrgYiCPVDnfA@mail.gmail.com>
Subject: Re: [PATCH 4/4] promisor-remote: teach lazy-fetch in any repo
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Jun 1, 2021 at 2:38 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> This is one step towards supporting partial clone submodules.
>
> Even after this patch, we will still lack partial clone submodules
> support, primarily because a lot of Git code that accesses submodule
> objects does so by adding their object stores as alternates, meaning
> that any lazy fetches that would occur in the submodule would be done
> based on the config of the superproject, not of the submodule. This also
> prevents testing of the functionality in this patch by user-facing
> commands. So for now, test this mechanism using a test helper.
>
...
> diff --git a/t/helper/test-partial-clone.c b/t/helper/test-partial-clone.c
> new file mode 100644
> index 0000000000..e7bc7eb21f
> --- /dev/null
> +++ b/t/helper/test-partial-clone.c
> @@ -0,0 +1,34 @@
> +#include "cache.h"
> +#include "test-tool.h"
> +#include "repository.h"
> +#include "object-store.h"
> +
> +static void object_info(const char *gitdir, const char *oid_hex)
> +{
> +       struct repository r;
> +       struct object_id oid;
> +       unsigned long size;
> +       struct object_info oi = {.sizep = &size};
> +       const char *p;
> +
> +       if (repo_init(&r, gitdir, NULL))
> +               die("could not init repo");
> +       if (parse_oid_hex(oid_hex, &oid, &p))
> +               die("could not parse oid");
> +       if (oid_object_info_extended(&r, &oid, &oi, 0))
> +               die("could not obtain object info");
> +       printf("%d\n", (int) size);
> +}
> +
> +int cmd__partial_clone(int argc, const char **argv)
> +{
> +       if (argc < 4)
> +               die("too few arguments");
> +
> +       if (!strcmp(argv[1], "object-info"))
> +               object_info(argv[2], argv[3]);
> +       else
> +               die("invalid argument '%s'", argv[1]);
> +
> +       return 0;
> +}
> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> index c5bd0c6d4c..b21e8f1519 100644
> --- a/t/helper/test-tool.c
> +++ b/t/helper/test-tool.c
> @@ -46,6 +46,7 @@ static struct test_cmd cmds[] = {
>         { "online-cpus", cmd__online_cpus },
>         { "parse-options", cmd__parse_options },
>         { "parse-pathspec-file", cmd__parse_pathspec_file },
> +       { "partial-clone", cmd__partial_clone },
>         { "path-utils", cmd__path_utils },
>         { "pcre2-config", cmd__pcre2_config },
>         { "pkt-line", cmd__pkt_line },
> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> index e8069a3b22..f845ced4b3 100644
> --- a/t/helper/test-tool.h
> +++ b/t/helper/test-tool.h
> @@ -35,6 +35,7 @@ int cmd__oidmap(int argc, const char **argv);
>  int cmd__online_cpus(int argc, const char **argv);
>  int cmd__parse_options(int argc, const char **argv);
>  int cmd__parse_pathspec_file(int argc, const char** argv);
> +int cmd__partial_clone(int argc, const char **argv);
>  int cmd__path_utils(int argc, const char **argv);
>  int cmd__pcre2_config(int argc, const char **argv);
>  int cmd__pkt_line(int argc, const char **argv);
> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> index 584a039b85..e804d267e6 100755
> --- a/t/t0410-partial-clone.sh
> +++ b/t/t0410-partial-clone.sh
> @@ -604,6 +604,30 @@ test_expect_success 'do not fetch when checking existence of tree we construct o
>         git -C repo cherry-pick side1
>  '
>
> +test_expect_success 'lazy-fetch when accessing object not in the_repository' '
> +       rm -rf full partial.git &&
> +       test_create_repo full &&
> +       printf 12345 >full/file.txt &&
> +       git -C full add file.txt &&
> +       git -C full commit -m "first commit" &&
> +
> +       test_config -C full uploadpack.allowfilter 1 &&
> +       test_config -C full uploadpack.allowanysha1inwant 1 &&
> +       git clone --filter=blob:none --bare "file://$(pwd)/full" partial.git &&
> +       FILE_HASH=$(git hash-object --stdin <full/file.txt) &&
> +
> +       # Sanity check that the file is missing
> +       git -C partial.git rev-list --objects --missing=print HEAD >out &&
> +       grep "[?]$FILE_HASH" out &&
> +
> +       OUT=$(test-tool partial-clone object-info partial.git "$FILE_HASH") &&
> +       test "$OUT" -eq 5 &&
> +
> +       # Sanity check that the file is now present
> +       git -C partial.git rev-list --objects --missing=print HEAD >out &&
> +       ! grep "[?]$FILE_HASH" out
> +'
> +

Turns out that this test fails under GIT_TEST_DEFAULT_HASH=sha256; output:

error: wrong index v2 file size in /home/newren/floss/git/t/trash
directory.t0410-partial-clone/partial.git/objects/pack/pack-66a15be115d740341216938fb7abb31902e960bd6d464829d85164d1a4a25bec.idx
error: wrong index v2 file size in /home/newren/floss/git/t/trash
directory.t0410-partial-clone/partial.git/objects/pack/pack-66a15be115d740341216938fb7abb31902e960bd6d464829d85164d1a4a25bec.idx
fatal: couldn't find remote ref 74242c6e4a0d89f454d89d3496a1f7cb3f1f39f0
error: wrong index v2 file size in /home/newren/floss/git/t/trash
directory.t0410-partial-clone/partial.git/objects/pack/pack-66a15be115d740341216938fb7abb31902e960bd6d464829d85164d1a4a25bec.idx
error: wrong index v2 file size in /home/newren/floss/git/t/trash
directory.t0410-partial-clone/partial.git/objects/pack/pack-66a15be115d740341216938fb7abb31902e960bd6d464829d85164d1a4a25bec.idx
fatal: could not obtain object info
