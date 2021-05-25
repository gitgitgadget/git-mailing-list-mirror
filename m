Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D1BC2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 06:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FEA6610FC
	for <git@archiver.kernel.org>; Tue, 25 May 2021 06:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhEYGXS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 02:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbhEYGXR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 02:23:17 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08721C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 23:21:47 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c12so11199013pfl.3
        for <git@vger.kernel.org>; Mon, 24 May 2021 23:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lo/sei17t0JzlSjCkuejvCckF5hDNeDIlMXAvMTU9co=;
        b=mSzJ0GAD8P47siHL17r+n9iLWFqrrLDOv++O/t0l4JGJnWRbzHA3IRpIwpLLg7pECF
         K2kJ0H7L5+IZ7SB1/Qqosm/rB/vyC9bb6rMQaTOIKVM+C2M9cx6noidad6iOeTvLDaBB
         Z8RiznVbPJCHJFwKFvPKyclcgB7cNsUK25dKxxEWziylLFNkm6JhWUqqJ+ulgEcVxjIo
         yJAPqrqr/7oL6CuhXdCTu6UO3hiT2KHE+dZOsMDJoWWa3pCApAPGW1qm+luohTNHy5YP
         P4rfx34TJmHYPpxswB+GlmH/xJOIAm0pV9kpP+Wu5kM6J0SpsU1x9bkZWl2gB58FfbW5
         sWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lo/sei17t0JzlSjCkuejvCckF5hDNeDIlMXAvMTU9co=;
        b=Wq7MM5WXLmL4U5uWO46cvkvY38xqXWrUbBCvDSYE8xpqlyFXBFzI7U2nH/PV/hqGA7
         e/Fq3SxFk5V6xpO7l3pKnP2lsJwM/ARxRDsi1r7cCl670gtV3oX2ZZAIquOXAhhENoXX
         VV34gAt9kSh/c4aRChVoEsacuTub0MH01aWZ6k/OdXNEjy7q9uhK3/7bmmo9RXiSwCGE
         TwJDn9h4bqFg78a3YJWvEcaM+FJMPNuykkPMhPWzh3kQJIJexHnGyrjWUOXnNOqBpdtW
         zsSd/3u9gh7T17STdDH/BhheLhFLum39cMRq2MMAd51CqtBS4mfh7EalUZAkuML7jee6
         wrKg==
X-Gm-Message-State: AOAM532FySktN5B2hgO4X9JL5ub7FgqBVtcfbPSucVvDiPPpHfFrr0cj
        9B6/MFeCA2y+9SVdYEbdY+Se5Kinr5379rOOaxf/Cw==
X-Google-Smtp-Source: ABdhPJxKUbIJbR2XYgga8v4/uY96vNDmOgsZ/tWDniO0m98k0lMXcGzKilxCFQTGgwheboSFbs2QLcxmqZUje0lTX3M=
X-Received: by 2002:a63:7703:: with SMTP id s3mr17521322pgc.339.1621923706556;
 Mon, 24 May 2021 23:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <bb30fe2b-cd75-4782-24a6-08bb002a0367@kdbg.org>
 <cover-0.2-00000000000-20210524T231047Z-avarab@gmail.com> <patch-2.2-d097e7b0b81-20210524T231047Z-avarab@gmail.com>
 <xmqqh7iripzg.fsf@gitster.g> <874kerny0e.fsf@evledraar.gmail.com> <871r9vnxtb.fsf@evledraar.gmail.com>
In-Reply-To: <871r9vnxtb.fsf@evledraar.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 25 May 2021 08:21:35 +0200
Message-ID: <CAG3jFyu8AzSJS2EZwYKD9YKiewLVQLeKZZYEvUobyV+a6_VsDw@mail.gmail.com>
Subject: Re: [PATCH 2/2] send-email: don't needlessly abs_path() the core.hooksPath
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 25 May 2021 at 08:15, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com> wrote:
>
>
> On Tue, May 25 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> > On Tue, May 25 2021, Junio C Hamano wrote:
> >
> >> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
> >>
> >>> In c8243933c74 (git-send-email: Respect core.hooksPath setting,
> >>> 2021-03-23) we started supporting core.hooksPath in "send-email". It'=
s
> >>> been reported that on Windows[1] doing this by calling abs_path()
> >>> results in different canonicalizations of the absolute path.
> >>
> >> I see the author of that patch CC'ed; the change in question
> >> explains why we switched from "the hooks directory immediately under
> >> $repo->repo_path()" to "ask 'rev-parse --git-path hooks'", but it
> >> does not say why we call abs_path() on the result.  I guess that is
> >> because $repo->repo_path() has always been a result of applying the
> >> abs_path() function to something, so it was to safeguard the callers
> >> that expect an absolute path coming back from hooks_path?
> >>
> >> And that makes this change dubious, especially as a band-aid for a
> >> breakage immediately before the final release, doesn't it?  Are we
> >> convinced that the callers are OK with seeing sometimes relative
> >> paths?  Certainly the cases the tests J6t fixed are not negatively
> >> affected, but is that sufficient?  To what directory is the
> >> configuration variable supposed to be relative to, and are we sure
> >> that the user will always invoke "git send-email" from that
> >> directory?
> >
> > The one caller is git-send-email.perl is fine with it, at least on *nix=
,
> > this fix still needs testing on Windows.
> >
> > The repo_path() function was introduced in c8243933c74, so it's never
> > been in a release, thus I think it's fine to alter its behavior.
> >
> > The code here doesn't need to concern itself with what needs to be
> > relative to what, you run send-email in some working tree directory (or
> > top-level), and depending on core.hooksPath we'll either return a
> > relative path to the .git/hooks or an absolute one, the system()
> > invocation will accept either.
>
> ...I think the one issue with my 2/2 is that it doesn't go far enough,
> we should just remove the repo_path() from Git.pm and instead use its:
>
>     $self->command_oneline('rev-parse', '--git-path', 'hooks')

This looks good to me.

>
> ...in the one user in git-send-email.perl, as discussed in other
> serieses Git.pm is "public", so stuff we stick in there we can't
> alter. In this case we're doing so before a release, and nobody wanted
> this except git-send-email.perl.
>
> That caller is likely to just go away if and when Emily's "git hook run"
> lands, so I think it would be best (but not strictly needed for the
> pre-rc fix) to just remove that API.

That sounds like a sane approach. If core.hooksPath is needed in more
locations in the future, it can be added then.

>
> What do you / Robert Foss think (maybe he wanted this for something
> else...)?
