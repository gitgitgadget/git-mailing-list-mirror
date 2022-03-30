Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287D5C433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 14:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346777AbiC3OZG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 10:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243476AbiC3OZE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 10:25:04 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3711DB3C7
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 07:23:19 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bg10so41862274ejb.4
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 07:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KcvXzjIL0dONzrCqqX5Fzatzp7MHivqmnN8d77XHKoA=;
        b=zc21OaaiozXTGnHfrPa+nv9NxKRqNBumx4x2aWGNFdvnMmWz5MSeXQzup9PtGTgUY7
         zESJvqMEVhFkC6pvUAmxto+mKSd6IEhnIXJS8rFpTx2gqegd9kXOO6NDt4WRpQq/jZzM
         6Hqj8nvjEvxsDz6typKNUzqul/+ycqhjTIjAG2OUxl3JMCO6JxL04vm8ORC6mH50+yok
         0NYGpdmLoCsi6SNAMhrUFq02eWhCfS1HKvmi6YymKFry7BhBlsuqzoBCwmcM8cN6UMYN
         qY191ywk/soGuuq257VrVz49sXy/bnrH9z9vB3bG+adJVhfCvJ8UaSZFM9y5dqkJBjmZ
         vpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KcvXzjIL0dONzrCqqX5Fzatzp7MHivqmnN8d77XHKoA=;
        b=EEtwdCpj7OXjQtXEY5/RjIIkEGK6WXF/XJuoh+28Xn6LXFvFJQHjmz/E81/Oejjz21
         pN9wbenlLmn4Z2SgVmsSvdRqffM6bQnBbgY/Gq8CfhCo+quLXh2AiZb9jdoKBLx/Jusw
         a4HVRfcmT4b/zHAu9uMC8FgozmfAPiT2zPHZcx1mU6lBSBqMYHH2JLuRg2awNABmmSko
         AbOCb1aPkXqv/98R5WfWAJmSYAc/hoo4J3l0QZUK4RDzzcdKZU7PI87x7ZYPHZB7OPfa
         nDFpgpAfUsv6WXUAsfmmsAsij38U+GgIVZOn7nF/FXMcDsdCrKMnylNUuIiT0f8LYZQo
         IhjQ==
X-Gm-Message-State: AOAM531SUIqYvVwy0U/al+xVAsHmpWt+A31RKaNEDzO63LZ3gvkP6399
        JqHrhcbe+/hjXGRDFvNGUbCZKlCj/AQ9vovmVSvUWA==
X-Google-Smtp-Source: ABdhPJyETZjYTUpaqPjm1RbuKNHrkYS7/aAsiu773jV1v2puPu1aIYxHZbTKCEBq+ebjXay4KU/cm5G/HtIZsg4aCYw=
X-Received: by 2002:a17:907:94d5:b0:6e0:2924:bd54 with SMTP id
 dn21-20020a17090794d500b006e02924bd54mr39297554ejc.170.1648650197938; Wed, 30
 Mar 2022 07:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1183.v4.git.1648553209157.gitgitgadget@gmail.com>
 <pull.1183.v5.git.1648624810866.gitgitgadget@gmail.com> <220330.864k3fpo32.gmgdl@evledraar.gmail.com>
In-Reply-To: <220330.864k3fpo32.gmgdl@evledraar.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Wed, 30 Mar 2022 16:23:07 +0200
Message-ID: <CAPMMpoiNZ8pvrZmMqJsRV2x+Fvq-=hpih1GGSLMe=KX785Dk0A@mail.gmail.com>
Subject: Re: [PATCH v5] tracking branches: add advice to ambiguous refspec error
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 30, 2022 at 3:27 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Wed, Mar 30 2022, Tao Klerks via GitGitGadget wrote:
>
> Nit: I think it's been Junio's preference not to introduce C99 comments,

Argh, my apologies, bad habits.

I wonder whether anyone has any tooling to help catch this kind of
thing - I'll ask in GitGitGadget, anyway.

> > @@ -219,6 +233,7 @@ static int inherit_tracking(struct tracking *tracki=
ng, const char *orig_ref)
> >       return 0;
> >  }
> >
> > +
>
> Stray whitespace?

Thx, I will check more carefully next time.

>
> >  /*
> >   * Used internally to set the branch.<new_ref>.{remote,merge} config
> >   * settings so that branch 'new_ref' tracks 'orig_ref'. Unlike
> > @@ -232,12 +247,16 @@ static void setup_tracking(const char *new_ref, c=
onst char *orig_ref,
> >       struct tracking tracking;
> >       struct string_list tracking_srcs =3D STRING_LIST_INIT_DUP;
> >       int config_flags =3D quiet ? 0 : BRANCH_CONFIG_VERBOSE;
> > +     struct find_tracked_branch_cb ftb_cb =3D {
> > +             .tracking =3D &tracking,
> > +             .ambiguous_remotes =3D STRING_LIST_INIT_DUP,
> > +     };
> >
> >       memset(&tracking, 0, sizeof(tracking));
> >       tracking.spec.dst =3D (char *)orig_ref;
> >       tracking.srcs =3D &tracking_srcs;
> >       if (track !=3D BRANCH_TRACK_INHERIT)
> > -             for_each_remote(find_tracked_branch, &tracking);
> > +             for_each_remote(find_tracked_branch, &ftb_cb);
> >       else if (inherit_tracking(&tracking, orig_ref))
> >               goto cleanup;
> >
> > @@ -252,9 +271,38 @@ static void setup_tracking(const char *new_ref, co=
nst char *orig_ref,
> >                       goto cleanup;
> >               }
> >
> > -     if (tracking.matches > 1)
> > -             die(_("not tracking: ambiguous information for ref %s"),
> > -                 orig_ref);
> > +     if (tracking.matches > 1) {
> > +             int status =3D die_message(_("not tracking: ambiguous inf=
ormation for ref %s"),
> > +                                         orig_ref);
>
> This isn't per-se new, but I wonder if while we're at it we shold just
> quote '%s' here, which we'd usually do. I.e. this message isn't new, but
> referring again to "ref %s" (and not "ref '%s'") below is.
>

I will fix the below, but I would default to not changing the above
unless someone thinks we should (not sure what the expectations are
around changing error messages unnecessarily)

> > +             if (advice_enabled(ADVICE_AMBIGUOUS_FETCH_REFSPEC)) {
> > +                     struct strbuf remotes_advice =3D STRBUF_INIT;
> > +                     struct string_list_item *item;
> > +
> > +                     for_each_string_list_item(item, &ftb_cb.ambiguous=
_remotes) {
>
> Nit: drop braces, not needed.

Thx, will do.

>
> > +                             /*
> > +                              * TRANSLATORS: This is a line listing a =
remote with duplicate
> > +                              * refspecs in the advice message below. =
For RTL languages you'll
> > +                              * probably want to swap the "%s" and lea=
ding "  " space around.
> > +                              */
> > +                             strbuf_addf(&remotes_advice, _("  %s\n"),=
 item->string);
> > +                     }
> > +
>
> Per the TRANSLATORS comments in get_short_oid(), it's also good to have
> one here in front of advice(). E.g.:
>
>         /*
>          * TRANSLATORS: The second argument is a \n-delimited list of
>          * duplicate refspecs, composed above.
>         */
>

Will do, thx.

> > +                     advise(_("There are multiple remotes whose fetch =
refspecs map to the remote\n"
> > +                              "tracking ref %s:\n"
> > +                              "%s"
> > +                              "\n"
> > +                              "This is typically a configuration error=
.\n"
> > +                              "\n"
> > +                              "To support setting up tracking branches=
, ensure that\n"
> > +                              "different remotes' fetch refspecs map i=
nto different\n"
> > +                              "tracking namespaces."),
> > +                            orig_ref,
> > +                            remotes_advice.buf
> > +                            );
>
> Nit: The usual style for multi-line arguments is to "fill" lines until
> you're at 79 characters, so these last three lines (including the ");")
> can all go on the "tracking namespaces" line (until they're at 79, then
> wrap)>
>

Yep, another oversight, thx.

> > +                     strbuf_release(&remotes_advice);
> > +             }
> > +             exit(status);
> > +     }
>
> Other than the minor nits noted above this version looks good to me, and
> I think addresses both the translation concerns I brought up, and the
> "let's not do advice() work if we don't need it" concern by Junio et al.
>

Awesome, thx!
