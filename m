Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D804FC433DB
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 12:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3FC961A1B
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 12:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhCYMmA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 08:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhCYMlb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 08:41:31 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2957DC06175F
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 05:41:31 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h10so2198949edt.13
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 05:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=JHUw5Gq0niygPH5vDJL2y3lnYuYKDDSZ4gHwA+rcsks=;
        b=r7Azq9qTaeTW7xriNjGDddwKihfg71u+9O3J3TaCOtCejs2QA1A/r3IHuKXuxAAYiK
         EYgBzevrHrVnmnKv7Knc70j+sDfG9v51SNN0W7Dn4Lofk87RkXSMUpFFV2XkSCh37MnE
         +5QAlpFipNla1iIpWqU/ir3qJ/1yZh4Qc/eUWaRzsZPT5NpmpHmDVtf2qzOTUg8lXm/L
         AtpdckK4N/Ep1QDvkwKQOcWJO9G63oIM2e4/48aAHDajAwhamcECyDlrzCCBPD0wrVBv
         52UzuzgUo61yrmuSGpWVP8TDi/8FLiHDkrQZpYcJ7ccqgzTQv9cOt2MLijlVAoczB8mu
         EP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=JHUw5Gq0niygPH5vDJL2y3lnYuYKDDSZ4gHwA+rcsks=;
        b=Cu59ihn7hI8AMlOpaoqUQRKmXTVBQ5Oi8U8AW0fX5mztG5nZk6BKo9c55ovqSsLGW5
         q88shDWIcepbddc5tHqaXsY6HLLvS0mxTcPbbVNy47XDqFcYZFLS3cb0q6AeoG/NWC9e
         i7lXvM9ybagaTYHuG/uHlqumdOU3Ki7i6gk4f4CYTuFyZZXViLRaJStg4Eul9X3+yH7t
         UVYng60V66BcVBypXlycMIUtksrRwOb6V++XC2aycrwXmseZcsA66MqSvb4XR4e2Edjg
         tOp5GNBygktVUf/N8cnvL1o9yr7VG+6SkRELr8NUazFV8cisRr5mFAu/FV2KDPMy4Omf
         mWmg==
X-Gm-Message-State: AOAM532tz5cxmePUGI+/CEqhBrxROKD/8/hK6A9Pq9sErFjqSarMWjNd
        v2SQau7vjLPCz7VsLOcwi5CLpLyi/+Qbgg==
X-Google-Smtp-Source: ABdhPJxrJMSPaSnLG3ehEBEQseD0bc6zYRijEKzCds1v8DsRF/iv5oNuAe4/IMrMWHbtLVXvoOV0OA==
X-Received: by 2002:aa7:c3c4:: with SMTP id l4mr8755294edr.335.1616676089612;
        Thu, 25 Mar 2021 05:41:29 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id y12sm2346427ejb.104.2021.03.25.05.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 05:41:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v8 00/37] config-based hooks
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <87mtv8fww3.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <87mtv8fww3.fsf@evledraar.gmail.com>
Date:   Thu, 25 Mar 2021 13:41:28 +0100
Message-ID: <87y2ebo16v.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 12 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

A small correction to one of my comments:

> On Thu, Mar 11 2021, Emily Shaffer wrote:

>  2. You're sticking full paths in the git config key, which is
>     case-insensitive, and a feature of this format is being able to
>     configure/override previously configured hooks.
>
>     So the behavior of this feature depends on git's interaction with
>     the case-sensitivity of filesystems, and not just one fs, any fs
>     we're walking in our various config sources, and where the hook
>     itself lives.
>
>     As recent CVEs have shown that's a big can of worms, particularly
>     for something whose goal is to address the security aspect of
>     running hooks from other config.
>
>     Arguably the case-sensitivity issue is just confusing since we
>     canonicalize it anyway. But once you add in FS path canonicalization
>     it becomes a real big can of worms. See the .gitmodules fsck code.
>
>     Even if it wasn't for that it's relatively nastier to edit/maintain
>     full paths and the appropriate escaping in the double-quoted key in
>     the config file v.s. having it as an optionally quoted value.

So the "case-insensitive" part of that *mostly* doesn't apply.

I'd forgotten that we don't consider the "LeVeL" part of
"ThReE.LeVeL.KeY" to be case-insensitive, but the other two components
are, as discussed in git-config(1)'s docs.

I say "mostly" because that's tolower()'s idea of case normalization,
which may or may not match the FS's, but anyway, I think that's probably
splitting hairs, but I worry more about the path normalization aspect
noted in the last two paragraphs there.

>  3. We're left with this "*.command =3D cmd", and "*.skip =3D true"
>     special-case syntax. I can't see any reason for why it's needed over
>     simply having "*.command =3D true" clobber earlier hooks as noted in
>     the proposed docs above.
>
>     And that doesn't require any magic to support, just like our
>     existing "core.pager=3Dcat" case.
>
>     I mean, I suppose it's magical in that we might otherwise error on
>     non-consumed stdin (do we?), anyway, documenting it as a synonym for
>     "cat >/dev/null" would get around that :)
>
>  4. It makes the common case of having the same hooks for N commands
>     needlessly verbose, if you can just support "type" (or whatever we
>     should call it) you can add that N times...
>
>  5. At the end of this series we're left with the start of the docs
>     saying:
>
>       You can list and run configured hooks with this command. Later,
>       you will be able to add and modify hooks with this command.
>
>     But those patches have yet to land, and looking at the design
>     document I'm skeptical of that being a good addition v.s. just
>     adding the same thing to "git config".
>
>     As just one exmaple; surely "git config edit <name>" would need to
>     run around and find config files to edit, then open them in a loop
>     for you, no?
>
>     Which we'd eventually want for "git config" in general with an
>     --edit-regexp option or whatever, which brings us (well, at least
>     me) back to "then let's just add it to git-config?".
>
>  6. The whole 'git hook' config special-casing doesn't help other
>     commands or the security issue that seemed to have prompted (at
>     least some of) its existence
>
>     In the design doc we mention the "core.pager =3D rm -rf /" case for a
>     .git/config.
>
>     This series doesn't implement, but the design docs note a future
>     want for solving that issue for the hooks.
>
>     To me that's another case where we should just have general config
>     syntax, not something hook-specific, e.g. if I could do this in my
>     ~/.gitconfig:
>
>        ;; We consider 'config.ignore' in reverse order, so e.g setting
>        ;; it in. ~/.gitconfig will ignore any such keys for repo-level
>        ;; config
>        [config "ignore"]
>        key =3D core.pager
>        keyRegexp =3D "^hook\."
>
>     We'd address both any hook security concerns, as well as core.pager
>     etc. We could then just have e.g. some syntax sugar of:
>
>        [include]
>        path =3D built-in://gimme-safe-config
>
>     Which would just be a thin layer of magit to include
>     <path-to-git-prefix>/config-templates/gimme-safe-config or whatever.
>
>     We'd thus address the issue for all config types without
>     hook-specific magic.
>
> Anyway. I'm very willing to be convinced otherwise. I just think that
> for a first-draft implementation leaving aside 'hook.<command>.command'
> and the whole 'list' thing makes sense.
>
> We can consider the core code changes relatively separately from any
> future aspirations, particularly with a 40-some patch series, and the
> end-state of *this series* IMO not really justifying, that part of the
> implementation, and thus requiring reviewers to look ahead beyond the
> 40-some patches.

Emily: *Bump* on being interesed in what you think about the rest of
this though.
