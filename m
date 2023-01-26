Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0490C54E94
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 01:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjAZBgf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 20:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjAZBge (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 20:36:34 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF7441B47
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 17:36:32 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id k38so418595lje.5
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 17:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQV1oUwOXnMZReke0dASwGko+JJv5TVFrb8wdjb/APE=;
        b=gZ4IwfX+0M5sZe9GVLfQCh2kVyL4jAXHVVc4XPOY+dWk7kD1b0/0nX0a6I7QKmMF6P
         ophDMQPqQ7IVX/iqKsEOkzSe+M76SAHNUbWoqyPYOsbYbvzRfNEWhlKo1kSa+IvOBIWf
         0jd3WPsezistEPFbA1DxZxp1gvCQ5ZUxF+TMo7Aq4NR3wuU7r1vXV43dCws9/tVu2Wzt
         F7LjE4YI967IeMoW+/LT5W6DSW4Ux3ZbVM1xBeMhTLIvu4oehYsJlTkpIIAX+IfTVOd2
         joEV1LsdpaQCOJ1TmUUW6jFIJZzFNiez7HrwbOKIejlnEO8TPNNZxqGVGkLRXiEIGond
         yxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQV1oUwOXnMZReke0dASwGko+JJv5TVFrb8wdjb/APE=;
        b=7sOjDVw32553xR5EX4DTMgw99cqpjjwxJwwnwom0QXxlhHphJqsQDn84DU6jcslOBL
         1uEnmzKF//tGjJ+oM6UUQqA/GNdyNrGTh4KPNFSQGSNBT1alHmxDwiz+M/WXRgUpVwvp
         ZAfOkwSgL7wNSPi9CJprVqiZkdMn5pKluplZ5pLQO+kEwLPytuew8+2lF9S+qNTW9U4D
         9HSVta1+KC4n0F8MRTgzPcqTmxOiknoC8lf0KvBlKmtCtbmTpmBf1nS6WZsLjBOTuZvo
         RIj1ygNnCrE5SLpvH9T/+y1wTwFoCnzDwbiFilo67pYkbl8m7zHimG3GOM+/7p3JABqD
         GPRw==
X-Gm-Message-State: AFqh2koMxwK2ImH+hprRz8kM9R5axEV9byyivUYnkUIu8Ck5DH2UK0ri
        NDPlLvn2npEMyh4PTEpoHpOnXRJ80hiFZjjxJCk=
X-Google-Smtp-Source: AMrXdXthLq+i+1KV8F/A0TuUrr9KXDCCs3VfczAFF7H2zlhMAswp4uBCO1NWnMQ1KGvYF7kblzCApGYasGVVXfjd8Ds=
X-Received: by 2002:a2e:3a06:0:b0:28b:c9a8:ced5 with SMTP id
 h6-20020a2e3a06000000b0028bc9a8ced5mr856321lja.182.1674696990986; Wed, 25 Jan
 2023 17:36:30 -0800 (PST)
MIME-Version: 1.0
References: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
 <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com> <patch-v5-07.19-1fac90c306a-20230118T120334Z-avarab@gmail.com>
In-Reply-To: <patch-v5-07.19-1fac90c306a-20230118T120334Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 25 Jan 2023 17:36:00 -0800
Message-ID: <CABPp-BHg00gpwo6emQXPK63Ub=7xRR=3w2jw6uWdpnpJWPZruQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/19] repack: fix leaks on error with "goto cleanup"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2023 at 5:10 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Change cmd_repack() to "goto cleanup" rather than "return ret" on
> error, when we returned we'd potentially skip cleaning up the
> string_lists and other data we'd allocated in this function.

This is hard to parse; the comma followed by "when" suggests you are
only changing things under a certain set of conditions rather than
explaining why you are making an unconditional change.  Perhaps:

In cmd_repack() when we hit an error, replace "return ret" with "goto
cleanup" to ensure we free the necessary data structures.


> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/repack.c                    | 13 +++++++------
>  t/t6011-rev-list-with-bad-commit.sh |  1 +
>  2 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index c1402ad038f..f6493795318 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -948,7 +948,7 @@ int cmd_repack(int argc, const char **argv, const cha=
r *prefix)
>
>         ret =3D start_command(&cmd);
>         if (ret)
> -               return ret;
> +               goto cleanup;
>
>         if (geometry) {
>                 FILE *in =3D xfdopen(cmd.in, "w");
> @@ -977,7 +977,7 @@ int cmd_repack(int argc, const char **argv, const cha=
r *prefix)
>         fclose(out);
>         ret =3D finish_command(&cmd);
>         if (ret)
> -               return ret;
> +               goto cleanup;
>
>         if (!names.nr && !po_args.quiet)
>                 printf_ln(_("Nothing new to pack."));
> @@ -1007,7 +1007,7 @@ int cmd_repack(int argc, const char **argv, const c=
har *prefix)
>                                        &existing_nonkept_packs,
>                                        &existing_kept_packs);
>                 if (ret)
> -                       return ret;
> +                       goto cleanup;
>
>                 if (delete_redundant && expire_to) {
>                         /*
> @@ -1039,7 +1039,7 @@ int cmd_repack(int argc, const char **argv, const c=
har *prefix)
>                                                &existing_nonkept_packs,
>                                                &existing_kept_packs);
>                         if (ret)
> -                               return ret;
> +                               goto cleanup;
>                 }
>         }
>
> @@ -1115,7 +1115,7 @@ int cmd_repack(int argc, const char **argv, const c=
har *prefix)
>                 string_list_clear(&include, 0);
>
>                 if (ret)
> -                       return ret;
> +                       goto cleanup;
>         }
>
>         reprepare_packed_git(the_repository);
> @@ -1172,10 +1172,11 @@ int cmd_repack(int argc, const char **argv, const=
 char *prefix)
>                 write_midx_file(get_object_directory(), NULL, NULL, flags=
);
>         }
>
> +cleanup:
>         string_list_clear(&names, 1);
>         string_list_clear(&existing_nonkept_packs, 0);
>         string_list_clear(&existing_kept_packs, 0);
>         clear_pack_geometry(geometry);
>
> -       return 0;
> +       return ret;
>  }
> diff --git a/t/t6011-rev-list-with-bad-commit.sh b/t/t6011-rev-list-with-=
bad-commit.sh
> index bad02cf5b83..b2e422cf0f7 100755
> --- a/t/t6011-rev-list-with-bad-commit.sh
> +++ b/t/t6011-rev-list-with-bad-commit.sh
> @@ -2,6 +2,7 @@
>
>  test_description=3D'git rev-list should notice bad commits'
>
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  # Note:
> --
> 2.39.0.1225.g30a3d88132d

Code changes look fine.
