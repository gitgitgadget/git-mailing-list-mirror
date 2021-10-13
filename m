Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E814FC433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 13:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5CC060F11
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 13:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbhJMNpf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 09:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbhJMNpc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 09:45:32 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C37FC061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 06:43:29 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ec8so10470736edb.6
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 06:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=yU+hVvyR0rBfO9GgJHq7bQw/x8WX3Phs+7qjoz3TTwc=;
        b=lY5LWUmsLdtA8xyJy5wCK+sZGiwioYAw8iZ4GIWzJQqQIrhXvA3dTTMh1wCCxboSRT
         3SwNFDfS62ZvhjS+jw1U7JfBSIljL4Jxs+03k8WlsUB1Xs09MCybGcG5ChgugPu1DBjH
         EFAcSoFlO52zfUGQojy2vKuReabLaWRl7OiFNsjYypOPS10bhNgFoucHXLtp5JdopWbu
         dRvxi5irbPIDxeqye1feY6NXriMZ8bLrWbN3QVg8Up3lJh0wgJ0kDv5CdGn4LKunUhgw
         rNDhb+iBXPspWY6x49gT5cSXzGEyfY++I3uhs+tCDE8kv2d6QuFYYL7/jX02jlk5iKpd
         /dSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=yU+hVvyR0rBfO9GgJHq7bQw/x8WX3Phs+7qjoz3TTwc=;
        b=sD52L2Ga7TLi4hWV+qVHx7IdSGVwJqTIFjglL7xXZ1GO6K34mdmoap6hcoBt3Ml+WJ
         lGQF+uX5DS25IDXVmcejYreEaD/4+FT9ZJuTFhA4iDIgp7M2vCi8H/Z6cBS8X1wWSzHX
         aNAnk46g7Ry3hroery45SkXGUMRC8FP06mnUvp4YGhMfayT4ZwuGl0BEQ5B8d0ePz7Wx
         +8qlcfZ0vjsm7WSBz+eZnXpi/kVcLYIfEfKdYecrjpiJQd2pAvA1bTHUthUp4OV8dlRs
         YVslqnbELVS0+mWMkxKoA48PwA96xrXBTDtodlKbTPYI7YXaUZhtETU78bJ2HJcruR9Y
         IqsA==
X-Gm-Message-State: AOAM533OjIG37Tdn3uv7mEzg23HVX9gUponsxJfZ4bvurfU8ehJfLqjM
        Mi4xJIN6ROi3vQeba5ERw4I=
X-Google-Smtp-Source: ABdhPJxQGCmdNpH6jMvF8oFPRCnx89DV2RcRW6BS6MlvlpvoocVvXq4Ri7Pqbj8dbV7b1G+1gGftHg==
X-Received: by 2002:aa7:c44d:: with SMTP id n13mr5525327edr.34.1634132603011;
        Wed, 13 Oct 2021 06:43:23 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 6sm6862687ejx.82.2021.10.13.06.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 06:43:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 5/7] ls-files: fix a trivial dir_clear() leak
Date:   Wed, 13 Oct 2021 15:39:55 +0200
References: <cover-0.7-00000000000-20211006T095426Z-avarab@gmail.com>
 <cover-v2-0.7-00000000000-20211007T100014Z-avarab@gmail.com>
 <patch-v2-5.7-73cf1018953-20211007T100014Z-avarab@gmail.com>
 <xmqqily8o3kw.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqily8o3kw.fsf@gitster.g>
Message-ID: <8735p5hwg6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 07 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> This does add a bit of complexity, but I think it's worth it to just
>> fix these leaks when it's easy in built-ins. It allows them to serve
>> as canaries for underlying APIs that shouldn't be leaking, it
>> encourages us to make those freeing APIs nicer for all their users,
>> and it prevents other leaking regressions by being able to mark the
>> entire test as TEST_PASSES_SANITIZE_LEAK=3Dtrue.
>
> This does more than necessary, though.  Introducing "ret", replacing
> an early return with an assignment to it, and returning "ret"
> instead of hardcoded 0, would have been the "fix a trivial leak",
> and the "ah, report_path_error() always returns true" does not
> belong here.
>
> These things look small, but small things add up.

I think you mean that you'd have liked:

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a2000ed6bf2..5e6b6f2d4a0 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -672,6 +672,7 @@ int cmd_ls_files(int argc, const char **argv, const cha=
r *cmd_prefix)
                         N_("suppress duplicate entries")),
                OPT_END()
        };
+       int ret =3D 0;
=20
        if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
                usage_with_options(ls_files_usage, builtin_ls_files_options=
);
@@ -776,15 +777,13 @@ int cmd_ls_files(int argc, const char **argv, const c=
har *cmd_prefix)
                show_ru_info(the_repository->index);
=20
        if (ps_matched) {
-               int bad;
-               bad =3D report_path_error(ps_matched, &pathspec);
-               if (bad)
+               if (report_path_error(ps_matched, &pathspec)) {
                        fprintf(stderr, "Did you forget to 'git add'?\n");
-
-               return bad ? 1 : 0;
+                       ret =3D 1;
+               }
        }
=20
        dir_clear(&dir);
        free(max_prefix);
-       return 0;
+       return ret;
 }

Instead of this:

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a2000ed6bf2..fcc685947f9 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -672,6 +672,7 @@ int cmd_ls_files(int argc, const char **argv, const cha=
r *cmd_prefix)
                         N_("suppress duplicate entries")),
                OPT_END()
        };
+       int ret =3D 0;
=20
        if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
                usage_with_options(ls_files_usage, builtin_ls_files_options=
);
@@ -775,16 +776,12 @@ int cmd_ls_files(int argc, const char **argv, const c=
har *cmd_prefix)
        if (show_resolve_undo)
                show_ru_info(the_repository->index);
=20
-       if (ps_matched) {
-               int bad;
-               bad =3D report_path_error(ps_matched, &pathspec);
-               if (bad)
-                       fprintf(stderr, "Did you forget to 'git add'?\n");
-
-               return bad ? 1 : 0;
+       if (ps_matched && report_path_error(ps_matched, &pathspec)) {
+               fprintf(stderr, "Did you forget to 'git add'?\n");
+               ret =3D 1;
        }
=20
        dir_clear(&dir);
        free(max_prefix);
-       return 0;
+       return ret;
 }

Doesn't make much sense, but I can re-roll with it if you feel strongly
about it. I think the current version is ready to be picked up.

Yeah we should avoid refactoring-while-at-it, but in cases where a patch
removes the only reason a nested if/if statement exists, unrolling it
into a single "if" handly seems too much. I think the alternative just
leaves the reader squinting at the diff wondering why we still need that
nesting...
