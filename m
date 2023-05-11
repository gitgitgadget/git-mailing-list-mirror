Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DB2C7EE24
	for <git@archiver.kernel.org>; Thu, 11 May 2023 07:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbjEKHHi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 03:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237342AbjEKHH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 03:07:28 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193837DA7
        for <git@vger.kernel.org>; Thu, 11 May 2023 00:06:54 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f13d8f74abso9249809e87.0
        for <git@vger.kernel.org>; Thu, 11 May 2023 00:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683788813; x=1686380813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAJvPD5V8g1G78lp+c/x6EIixVqZwWxewADDEBuSLSY=;
        b=GicVPQ3G6lMTTWdIJfI+C+0mss+I3tOl6Qqq4rueqZZMSBZeEz7PY5NoeOGFMVuVAL
         AUwNnykjxCx605SvCyTrrK7jaO5vw+wkPlwVQTp3cuXL35tjfSJdUMr9MgSVT4SttI39
         mQGvkIIKjRzhu4XjErhaib6+mhF3zIvX3Kt6ZB+x49zgzMjmCzFJOcTIHTuVhesxiAqS
         Mcfdp0e2s5OCqTwGOwgi2uww0eM9MizTjYXdX82x4AeIFIqZDIc/QXV7A/HJ7BYXfAxk
         E1/ezTu3s+H9GuNLkZ7VUt08F88pyY362kUsU0Sw6E92Mlre6Xq0XP4F2oL8ZU6oj6zm
         sBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683788813; x=1686380813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAJvPD5V8g1G78lp+c/x6EIixVqZwWxewADDEBuSLSY=;
        b=iFKkKsAgxwSjUT9Jv6CqiJM5MF2O4ocGfNqtzZxzhy5tOqEus6LQezUR0toh6j+JIq
         NezHVitcOZotwLa24UPgMSXY37PqIt4ri5sWWw6rnIQMP0NfGj4AD/3m4LykHoLB03JJ
         Qg7A6JnSgku8HwXyLNsgE5IK8AQ79gtlRdMlYPaV+RDSKITgqIYiu/1bkbwnZo0I1gSx
         ih4aNW39C+pk0WZs6qnX2sr/33vcejKiTipttcCJZq3Mfdy0e9TDEI+hJu396oV8G/Rn
         mKwp+RUD/8ACsrup/+YnkmDUN+MvVaDLwg8vm+oQFJk8YOnQEg4dDJPejr2ZBPA2L4B7
         i0TA==
X-Gm-Message-State: AC+VfDxgxvm8DaXEn2ROkgGzqQvmO5oQYYeQoSjegwU3aexmQ3xPaQF7
        0Iud+REuoHfmzIra3aU78vqaSu5XKG8blD7jGFs=
X-Google-Smtp-Source: ACHHUZ5fi/g9pbp4EMiU/XLFipqVGYZRJsTwg6rA9DfHAQ46aZn6UatzWZ5Qf236c8YLdTbPk7AlUbAWhMtAFe+/UG4=
X-Received: by 2002:a19:a406:0:b0:4f2:5c2a:19ba with SMTP id
 q6-20020a19a406000000b004f25c2a19bamr1911834lfc.46.1683788813011; Thu, 11 May
 2023 00:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1527.git.1683008869804.gitgitgadget@gmail.com>
 <CABPp-BH8A=CnO3_UWXDegb87VTNEX8s+=CefB90m1_vjBZ_+Fw@mail.gmail.com>
 <CAPMMpogiTVksUKgZ==n4d3xm4ZJqxm7ki2dOF8j8S5BaJvu1Ew@mail.gmail.com>
 <CABPp-BGmPKyNcDa-wUh-oisTvvux+X=6BvGxSNQC2O7uodpFrA@mail.gmail.com> <CAPMMpojDm8jHWFr8i5EC-oEKK8WBt1g3iyRvixfy1bhk8qck2g@mail.gmail.com>
In-Reply-To: <CAPMMpojDm8jHWFr8i5EC-oEKK8WBt1g3iyRvixfy1bhk8qck2g@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 11 May 2023 00:06:39 -0700
Message-ID: <CABPp-BHGAVb06BahQ0--15LWetyyx7eHAoPH8-So9UyqpJv0sg@mail.gmail.com>
Subject: Re: [PATCH] RFC: switch: allow same-commit switch during merge if
 conflicts resolved
To:     Tao Klerks <tao@klerks.biz>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 8, 2023 at 3:44=E2=80=AFAM Tao Klerks <tao@klerks.biz> wrote:
>
> On Sun, May 7, 2023 at 4:48=E2=80=AFAM Elijah Newren <newren@gmail.com> w=
rote:
> >
> > On Wed, May 3, 2023 at 10:01=E2=80=AFPM Tao Klerks <tao@klerks.biz> wro=
te:
> > >
> > > I believe this question was resolved later in the thread. The proposa=
l
> > > is to allow the simplest case of merge only, for resolved
> > > (unconflicted) indexes only. If the change were to make sense I could
> > > update this message to be clearer that none of those other operations
> > > or situations are impacted by this change.
> >
> > As I mentioned to Junio, I understood fully that your implementation
> > limited the changes to this one case.  That did not resolve my
> > concerns, it merely obviated some other bigger ones that I didn't
> > raise.
> >
> > However, making it only available via a --force override (and then
> > perhaps also limiting it to just some operations), would resolve my
> > concerns.
> >
>
> Hmm, I think there is confusion here.
>
> My proposal was (and now, again, is) to add support for "--force" to
> "git switch", and to keep and improve that existing support for "git
> checkout" (where it is in my opinion broken during a rebase), but that
> proposal was mostly-unrelated to my main goal and proposal for
> supporting same-commit switches in the first place:
>
> A same-commit switch (*without* --force) serves the use-case of
> *completing a merge on another branch*. This is, as far as I can tell
> only *useful* for merges:
>  * during a rebase, switching in the middle (to the same commit,
> without --force) won't achieve anything useful; your rebase is still
> in progress, any previously rebased commits in the sequence are lost,
> and if you continue the rebase you'll end up with a very strange and
> likely-surprising partial rebase state)
>  * during a cherry-pick, it's just "not very useful" - it's not bad
> like rebase, because in-progress cherry-pick metadata is destroyed
>  * during am, and bisect I'm not sure, I haven't tested yet.
>
> The reason this in-progress is *valuable* for merges (in a way that it
> is not for those other states) is that the merge metadata not only
> says what you're in the middle of, but also contains additional useful
> information about what you've done so far, which you want to have be a
> part of what you commit in the end - the identity of the commit you
> were merging in.
>
> Supporting switch with --force, and having it implicitly destroy
> in-progress operation metadata, has value in that it makes it easier
> to break backwards compatibility of "git checkout" without impacting
> users' or tests' workflows; it helps make a change to make checkout
> safer; but it does not help with my other (/main?) objective of making
> it easy and intuitive to switch to another same-commit branch, to be
> able to commit your in-progress merge on another branch and avoid
> committing it where you started.
>
> Hence, if/when we add support for same-commit switching during merge
> (and potentially other operations, if that makes sense), it should
> *not* take "--force", which has a substantially different purpose and
> meaning.

Doh, sorry, brain fart on my part forgetting the checkout/switch
already have a "--force".  Replace "--force" in my email with "an
override" such as "--ignore-in-progress".
