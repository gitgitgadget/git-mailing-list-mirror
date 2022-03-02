Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD533C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 09:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240554AbiCBJgo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 04:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiCBJgn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 04:36:43 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F36B7C61
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 01:36:00 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id y11so862746eda.12
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 01:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bUhJsGi7EuhS9BjaisZqDy7mDtedCQAMHLmM4aC6flg=;
        b=PZseYvAXLdXSyqFIUWziqQvMkOzlFvKGHy8CNVxG09QWIiPqe+HDqRVK8u9cO0NuLh
         Kwy4GStnV8Slqg5b8oJbFpdIjdwD2aYJbpA7hgEPcBkOI7cnqjzMxgYGWruaSuBqBpGC
         K2qsEEaJmum3swiO3DSg8CWseTmQlDuaMtf0LkGpLFzHnkMRgwPnGL/7QpI0P2gY3Nhv
         An+6D1ovxWG8UX29ODtVt3LEH/qScZRWPCuvCMNJqCYujK1SvYFOFVIRbvPATfteaeV4
         yDjyllp2TJW3FsvEZKIeYy/HsFCmVQhZNbfNJKg5zQgazTDM0FaOkDHSJn2lD+GUfFll
         xYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bUhJsGi7EuhS9BjaisZqDy7mDtedCQAMHLmM4aC6flg=;
        b=OxGpPfbGfBxh/Uv43n97pmdMUJ1YVMB2MrmEczIauSsct7v38X/tSsFv+UBaSDfwMS
         w9JafGJZJSxRHI76jcB5ldRR8WH2g3SoNgX28MQRRekyI3Mu6iqdjrcJU6xMf+jwQfqA
         oy2pEe2EjxU7rNHrMyDgHFi9kvgOgr2T2zRlGoJrD+Zqat2tTgBKNJbGeMJ+6isJ4Rq8
         bDEIXAvSmgB5+0XTHib6xuSlDC5j+NAkYCr/xIsGpgdDlVLf2lz+shQ6UEBWhmJijBCX
         8cr3InZITWFQH5cyN/EM8IpcdK9KUkEld7zTYn2YfVkz0Dh2Wdqq8bg5nFqmaV9u1+QV
         1xrQ==
X-Gm-Message-State: AOAM530KVALmhnuQ8JIIDB1uZXPY2aM182iD20Xzu6hiboO6aY4oQs9X
        krwofwrkZwgu4SLGAxq4geS/08w8yeB2hyLEbl4IyQ==
X-Google-Smtp-Source: ABdhPJy0yH0FEYIzDwD57f3WQ12UAofxWandOQXtk/e5ilOrsnU55d5h5z1JF31lkrAVfeXk+rYUIhmsZ5WweM9D2+0=
X-Received: by 2002:a50:fc05:0:b0:408:4d18:5070 with SMTP id
 i5-20020a50fc05000000b004084d185070mr28630812edr.365.1646213758614; Wed, 02
 Mar 2022 01:35:58 -0800 (PST)
MIME-Version: 1.0
References: <pull.1161.v2.git.1645815142.gitgitgadget@gmail.com>
 <pull.1161.v3.git.1646032466.gitgitgadget@gmail.com> <0b5d47895120539d6a72a91398f33a0e33df7cd5.1646032466.git.gitgitgadget@gmail.com>
 <220228.86k0df5key.gmgdl@evledraar.gmail.com>
In-Reply-To: <220228.86k0df5key.gmgdl@evledraar.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Wed, 2 Mar 2022 10:35:47 +0100
Message-ID: <CAPMMpoi9gQscSQ5Xn1xTb6WaCXu+qR67DJh9nCbqN0jp7-b_5A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] merge: new autosetupmerge option 'simple' for
 matching branches
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 28, 2022 at 11:56 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Mon, Feb 28 2022, Tao Klerks via GitGitGadget wrote:
>
> I think squashing 2/2 inot this would make this much easier to follow,
> i.e. to have tests along with the new feature.
>

OK! Doing.

> > +     /*
> > +      * This check does not apply to the BRANCH_TRACK_INHERIT
> > +      * option; you can inherit one or more tracking entries
> > +      * and the tracking.matches counter is not incremented.
> > +      */
> >       if (tracking.matches > 1)
> >               die(_("not tracking: ambiguous information for ref %s"),
> >                   orig_ref);
>
> This function is the only user of find_tracked_branch(). For e.g. "git
> checkout we emit";
>
>     fatal: builtin/checkout.c:1246: 'foo' matched multiple (4) remote tra=
cking branches
>
> Perhaps we can do something similar here

I'm not sure what you're pointing to specifically - the fact that the
checkout message provides a count? If so I guess I understand/agree,
find_tracked_branch() could be enhanced to keep counting rather than
exiting at the first sign of trouble, to support such a
slightly-more-explicit message here.

I'm not convinced that this situation is common enough to warrant
change: mapping multiple remotes to the same remote-tracking path
seems like a strange setup - is this something we recommend or
document anywhere? maybe to have 2 "remotes" that correspond to the
same server over different protocols appear as one set of tracking
branches?

On the other hand I am of course happy to make things better if we
think this will do that!

> even with some advise()
> emit information about what other branches conflicted.

I believe the conflict is not about different "branches" exactly, but
about *refspecs* that map to the tracking branch.

If I understand correctly this change would entail creating a new
advice type (and documenting it), and figuring out what the advice
should look like - something like "find and disambiguate your fetch
refspecs to enable auto tracking setup! If you want to keep your
ambiguous refspecs, set auto tracking setup to false!" - but nicer :)

>
> > +     if (track =3D=3D BRANCH_TRACK_SIMPLE) {
> > +             /*
> > +              * Only track if remote branch name matches.
> > +              * Reaching into items[0].string is safe because
> > +              * we know there is at least one and not more than
> > +              * one entry (because not BRANCH_TRACK_INHERIT).
> > +              */
> > +             const char *tracked_branch;
> > +             if (!skip_prefix(tracking.srcs->items[0].string,
> > +                              "refs/heads/", &tracked_branch) ||
> > +                 strcmp(tracked_branch, new_ref))
> > +                     return;
> > +     }
> > +
>
> I wondered when reading this if there isn't a way to merge this and the
> "branch_get" call made in "inherit_tracking" earlier in this function in
> the "track !=3D BRANCH_TRACK_INHERIT" case.
>
> But maybe not, and that whole API entry point is a bit messy in needing
> to cover both the use-case of an existing branch & nonexisting
> (i.e. initial creation).

Hmm, I had a hard time understanding this comment. I *think* you were
saying "why don't you use an existing API to get the full ref name of the
new local branch, and compare that to the full name of the remote
branch you already have, rather than messing with a "refs/heads/"
prefix explicitly/redundantly"... Is that right?
