Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37D0ECAAD3
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 18:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiISSoI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 14:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiISSoC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 14:44:02 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53330481DD
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 11:43:54 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id v9-20020a17090a4ec900b00200bba6b0a1so34165pjl.5
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 11:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date;
        bh=ZH7qinhZ7EUuWkNvVLYED05Z37USyOxkWBachcpJiAQ=;
        b=SkbtEZvbOqwqBru8r8O1ZMDAKOywZyx94MbKbJXHROpUqXAQqGpRjNgLuPhPRL0hh2
         O7V17cn511NzyB24WtNX7dbL/F1EYI2bITmYE7KhEkMGpsvjSjD4guQ+5Z08IfapjCDw
         6hn4MiG/kIEatIj+Lj+dLRuyQf4RT3E4h7oRAARB3KinOQLVwvqr6oj3yv5rF2JPSOSJ
         Xe7imhsarxnxl9KH7WVpUifERwmqZ0GrDSAzvaO9EYU/oB7upgJO+lYPP94zZKO5U4cM
         lZR/Q1CTSY9KWyC5fhTKFwqDL17QCNLaFiTUjPQx2Rmb8kwmIaDnl94OeJwj+LWAU7dO
         XntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date;
        bh=ZH7qinhZ7EUuWkNvVLYED05Z37USyOxkWBachcpJiAQ=;
        b=pH5lvZ35EGSaSYS1pMs/25NYtzJvSebGNBKTiyDTFAyYt+ibLIx8LuQsRgcciWRLGQ
         jZKNQxjmVWJAF6xVG9EuyswAwxL8PKwf95P9+mnG0LifKYL0xVeVdtasQsGW6rCPMuQj
         6wvH6VpwPg7e2EEhweSIrNkzGSL9sqUwC1Tc/81ahXEBtKj8J6DStrRWQOiwYpmwk+hI
         zEV+dU3kEMtO23mmEEt6JkjOWdfaiwPmUs83dQeYiScVDhrB2GdZW4/5qcXl3oSyAEEs
         k/IBEDJ6BVwk0LdBD2Gd1Un96ZlblF4Iye2yTEvraMmW/dKWe6m1ALs4O2az6KPZOWHM
         lyEg==
X-Gm-Message-State: ACrzQf2j4+QQhY9KBa7AprTYUGxWJZUsSL20AFBypnD4GM1XjZ0Yqsw6
        Q12/P4lwoIIjEAaNrM0OhSxT/H66pV9Lrg==
X-Google-Smtp-Source: AMsMyM5NGLvoo8q7dm5yZdRa8oSzpBXQvwbiWhh9x5vw58wxjmTw0sMOi9DeK0NqW+7GadRslPSjOTrto5sX3g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:4a03:b0:202:d026:c9d6 with SMTP
 id kk3-20020a17090b4a0300b00202d026c9d6mr32450937pjb.55.1663613033259; Mon,
 19 Sep 2022 11:43:53 -0700 (PDT)
Date:   Mon, 19 Sep 2022 11:43:51 -0700
In-Reply-To: <36621ba8-ad8e-8758-3e17-ea7a83432b4c@gmail.com>
Mime-Version: 1.0
References: <CABxXVRS-9unw-8_N8w2bdj4E5Ch780tMetJyD+++ixdWsBv90A@mail.gmail.com>
 <36621ba8-ad8e-8758-3e17-ea7a83432b4c@gmail.com>
Message-ID: <kl6l8rmfcihk.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: Question related to submodule and different recurse config options
From:   Glen Choo <chooglen@google.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Pieter-Jan Busschaert <pieterjan.busschaert@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Hi Pieter-Jan,
>
> Le 2022-09-08 =C3=A0 11:01, Pieter-Jan Busschaert a =C3=A9crit=C2=A0:
>> However, it seems with this config a git pull will act as if
>> fetch.recurseSubmodules was set to true (instead of on-demand) and do
>> a fetch on all of the submodules. For me this does not correspond to
>> the documentation (which says the value of submodule.recurse will only
>> be used if fetch.recurseSubmodules is NOT set). I would have thought
>> that this recent commit:
>> https://github.com/git/git/commit/ed54e1b31ad1a9a35ef6c23024d325a2c4d852=
21
>> describes this scenario and fixed it, but I still have that behaviour
>> (git 2.37.3). Maybe that patch only covered true/false settings for
>> fetch.recurseSubmodules and doesn't properly handle the on-demand
>> setting?
>>=20
>> Is what I see the intended behaviour?
>> Is it possible in any way to configure git to only fetch & update
>> submodules if the pointed-to commit changes?
>
> I'm not sure if that's the bug you are hitting, but I remember noticing t=
hat
> the actual order of the two configs in the config file mattered (whereas =
it should
> not). With this:
>
>     fetch.recurseSubmodules =3D on-demand
>     submodule.recurse =3D true
>
> the "submodule.recurse =3D true" is read last and then the "on-demand" se=
tting for fetch
> is effectively ignored.
>
> With this order:
>
>     submodule.recurse =3D true
>     fetch.recurseSubmodules =3D on-demand
>
> I think it would work correctly. But I might be misremembering (I did not=
 try it).

Thanks Philippe! Rereading that patch, I'm quite convinced that `git
pull` is doing the right thing, so the issue is probably in `git fetch`.

Config ordering _does_ matter, because both submodule.recurse and
fetch.recurseSubmodules are read into "recurse_submodules" (see
builtin/fetch.c:git_fetch_config).
https://git-scm.com/docs/git-config#Documentation/git-config.txt-fetchrecur=
seSubmodules
says "(fetch.recurseSubmodules) Defaults to on-demand, or to the value
of submodule.recurse if set", which sounds to me like
fetch.recurseSubmodules should take precedence over submodule.recurse,
and there is a real bug here. I haven't invested time into figuring out
whether this has always been broken, or whether this is a more recent
regression.

Here's one (really ugly) fix:

  diff --git a/builtin/fetch.c b/builtin/fetch.c
  index fc5cecb483..5fb81e0d7d 100644
  --- a/builtin/fetch.c
  +++ b/builtin/fetch.c
  @@ -78,6 +78,8 @@ static const char *submodule_prefix =3D "";
  static int recurse_submodules =3D RECURSE_SUBMODULES_DEFAULT;
  static int recurse_submodules_cli =3D RECURSE_SUBMODULES_DEFAULT;
  static int recurse_submodules_default =3D RECURSE_SUBMODULES_ON_DEMAND;
  +static int config_fetch_recurse_submodules =3D RECURSE_SUBMODULES_DEFAUL=
T;
  +static int config_submodule_recurse =3D RECURSE_SUBMODULES_DEFAULT;
  static int shown_url =3D 0;
  static struct refspec refmap =3D REFSPEC_INIT_FETCH;
  static struct list_objects_filter_options filter_options;
  @@ -107,14 +109,14 @@ static int git_fetch_config(const char *k, const ch=
ar *v, void *cb)
    if (!strcmp(k, "submodule.recurse")) {
      int r =3D git_config_bool(k, v) ?
        RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
  -		recurse_submodules =3D r;
  +		 config_submodule_recurse =3D r;
    }

    if (!strcmp(k, "submodule.fetchjobs")) {
      submodule_fetch_jobs_config =3D parse_submodule_fetchjobs(k, v);
      return 0;
    } else if (!strcmp(k, "fetch.recursesubmodules")) {
  -		recurse_submodules =3D parse_fetch_recurse_submodules_arg(k, v);
  +		config_fetch_recurse_submodules =3D parse_fetch_recurse_submodules_arg=
(k, v);
      return 0;
    }

  @@ -2112,6 +2114,10 @@ int cmd_fetch(int argc, const char **argv, const c=
har *prefix)

    if (recurse_submodules_cli !=3D RECURSE_SUBMODULES_DEFAULT)
      recurse_submodules =3D recurse_submodules_cli;
  +	else if (config_fetch_recurse_submodules !=3D RECURSE_SUBMODULES_DEFAUL=
T)
  +		recurse_submodules =3D config_fetch_recurse_submodules;
  +	else if (config_submodule_recurse !=3D RECURSE_SUBMODULES_DEFAULT)
  +		recurse_submodules =3D config_submodule_recurse;

    if (negotiate_only) {
      switch (recurse_submodules_cli) {

This _should_ work, but I wouldn't merge it as-is since

- The proliferation of static variables is just awful. Maybe we can do
  better by using repo_config_get_*() instead of the config iterator
  function.
- this doesn't have test coverage

I don't think I have the time to turn this into a full fix (not for a
few weeks at least), but I'd be happy to review patches.

>
> Cheers,
>
> Philippe.
