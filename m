Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7355BC6FD19
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 18:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjCISxX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 13:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjCISxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 13:53:16 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BAE41B59
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 10:53:13 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id d3-20020a17090acd0300b00237659aae8dso3080610pju.1
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 10:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678387992;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wbR18NeScvn4Vl452du50n518lIWJB7jf+nMzKwkTqg=;
        b=hvL7mWibuvyHqYtn+AtB7tRmuiJKVb5ZrgifofUT4OeOIO7Ecn8vDUxy0O+cMN3Vvr
         WfCmL5MO67zAGDZtkJYHHfdiA2R4meLsQluA0QTnWoK5j/pxsH2BS/CIa8UqZDEadhLA
         NdMUsdt7lG9HdmvSFcWOUuT3/z5NiEkBuo8s6hwKEG/peIcIYLycmAeV5IXVLUD3UwMq
         W96cnOAdvv6g7UW6vzGPRq+ALsIUSQu+P8xm2Kzi7WjRRTZ7qSoth9Hhi9nOsiPCzIBu
         gEVQ8VLlmLUPM3dT12jsK3Qzh3eOFIM/C//CDjYA2TycCcLkUpWvc5131gef5C5LpoRR
         Is7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678387992;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wbR18NeScvn4Vl452du50n518lIWJB7jf+nMzKwkTqg=;
        b=woK0VPhN/oiNnXvanXkzVRLpYTAD3SWVhbt7ghPx18kQU7UgRg/W0D9kugc8QeuuOT
         X4NuJTyn8W8MaHuPaexPG+KchscAN5lWQhD8R3jjBlw/ovqCJP/NWEaLRnaVngRPMrF3
         5SWXvmEaC4r3u6eII1IMVrrZv/BkKk2LQ3hzwc/YF56g3SfJdjyT9YyXVAsR5GnDEJSH
         4GRMSI/U/NxB4NmtjtBaLJtvqg6Kt/hTzt8xV1t+yTCyoC4sSHww5GttMp0kzZbVM4uz
         +m+on10S7uxzZxe338RJ3XxnQ9dPluLewghvfR41ggCnSOrv+Xxczrjut63dw1AgHNQK
         GeAw==
X-Gm-Message-State: AO0yUKUMgD1dCNY1aMICZYX0/mhD5tB+fbQUHlNAbBdckL3SEuztjKRg
        imfB/CO3e+9fVddiW9Rha17oDYRHOJnmHg==
X-Google-Smtp-Source: AK7set/pQH2l3f1gb4e6cL8eIJ1mPhvxrXUcvL64zUifiYwdn5Nnqs7Ebd7Wfn2ni9UrImJbAwL3h9fj7ij8xQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:902:edc2:b0:19a:9834:bb2c with SMTP
 id q2-20020a170902edc200b0019a9834bb2cmr9140808plk.11.1678387992634; Thu, 09
 Mar 2023 10:53:12 -0800 (PST)
Date:   Thu, 09 Mar 2023 10:53:10 -0800
In-Reply-To: <patch-v7-3.9-a977b7b188f-20230308T090513Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-v6-0.9-00000000000-20230307T180516Z-avarab@gmail.com>
 <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com> <patch-v7-3.9-a977b7b188f-20230308T090513Z-avarab@gmail.com>
Message-ID: <kl6ledpxhi3t.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v7 3/9] config API: add and use a "git_config_get()"
 family of functions
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "SZEDER =?utf-8?Q?G=C3=A1b?= =?utf-8?Q?or?=" <szeder.dev@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> diff --git a/config.h b/config.h
> index 7606246531a..7dd62ca81bf 100644
> --- a/config.h
> +++ b/config.h
> @@ -465,6 +465,9 @@ void git_configset_clear(struct config_set *cs);
>   * value in the 'dest' pointer.
>   */
> =20
> +RESULT_MUST_BE_USED
> +int git_configset_get(struct config_set *cs, const char *key);

IIRC, feedback on v4 [1] mentioned that since git_configset_get() can
return negative values, it probably shouldn't come under this comment:

  /*
  * These functions return 1 if not found, and 0 if found, leaving the foun=
d
  * value in the 'dest' pointer.
  */

I think moving it to before the comment would suffice, maybe with a
pointer to the corresponding repo_* or git_*.

1. https://lore.kernel.org/git/xmqqv8kjpqoe.fsf@gitster.g/


> @@ -485,6 +488,14 @@ int git_configset_get_pathname(struct config_set *cs=
, const char *key, const cha
>  /* Functions for reading a repository's config */
>  struct repository;
>  void repo_config(struct repository *repo, config_fn_t fn, void *data);
> +
> +/**
> + * Run only the discover part of the repo_config_get_*() functions
> + * below, in addition to 1 if not found, returns negative values on
> + * error (e.g. if the key itself is invalid).
> + */
> +RESULT_MUST_BE_USED
> +int repo_config_get(struct repository *repo, const char *key);
>  int repo_config_get_value(struct repository *repo,
>  			  const char *key, const char **value);
>  const struct string_list *repo_config_get_value_multi(struct repository =
*repo,
> @@ -521,8 +532,15 @@ void git_protected_config(config_fn_t fn, void *data=
);
>   * manner, the config API provides two functions `git_config_get_value`
>   * and `git_config_get_value_multi`. They both read values from an inter=
nal
>   * cache generated previously from reading the config files.
> + *
> + * For those git_config_get*() functions that aren't documented,
> + * consult the corresponding repo_config_get*() function's
> + * documentation.
>   */

After rereading config.h, I really appreciate comments like this that
try to control the documentation load. We have configset*, repo* and
git*, _and_ the comments are spread out hapzardly around config.h with
no pointers to the corresponding comments. I think we're overdue for
reorganization, and this sort of comment helps a lot with that.

As a suggestion, it seems like the git_config_get*() functions are
actually the better documented ones - nearly all of them have comments,
whereas the repo_config_get_*() ones typically don't, so maybe adding
the comment to git_config_get() instead of repo_config_get() would be
better for this series:

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
  diff --git a/config.h b/config.h
  index 7dd62ca81b..aa9bdf8df4 100644
  --- a/config.h
  +++ b/config.h
  @@ -489,10 +489,10 @@ int git_configset_get_pathname(struct config_set *c=
s, const char *key, const cha
  struct repository;
  void repo_config(struct repository *repo, config_fn_t fn, void *data);

  -/**
  - * Run only the discover part of the repo_config_get_*() functions
  - * below, in addition to 1 if not found, returns negative values on
  - * error (e.g. if the key itself is invalid).
  +/*
  + * These repo_config_get*() functions each correspond to to a git_config=
_get*()
  + * function. Consult the corresponding git_config_get*() documentation f=
or more
  + * information.
    */
  RESULT_MUST_BE_USED
  int repo_config_get(struct repository *repo, const char *key);
  @@ -532,12 +532,13 @@ void git_protected_config(config_fn_t fn, void *dat=
a);
    * manner, the config API provides two functions `git_config_get_value`
    * and `git_config_get_value_multi`. They both read values from an inter=
nal
    * cache generated previously from reading the config files.
  - *
  - * For those git_config_get*() functions that aren't documented,
  - * consult the corresponding repo_config_get*() function's
  - * documentation.
    */

  +/**
  + * Run only the discover part of the repo_config_get_*() functions
  + * below, in addition to 1 if not found, returns negative values on
  + * error (e.g. if the key itself is invalid).
  + */
  RESULT_MUST_BE_USED
  int git_config_get(const char *key);
----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----

Though in the long run, I'd prefer having the docs on the more "general"
APIs (configset_*, repo_*) instead of the more "specific" ones (git_*).
Perhaps you had a similar intent while making this change, but I think
this might be better left as a cleanup.

As an aside, I really appreciate your effort in sticking with the config
interface work. I think it's grown quite unruly, and it's worth trying
to tame it.
