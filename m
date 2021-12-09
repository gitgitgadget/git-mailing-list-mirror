Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84614C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 22:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbhLIWm4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 17:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbhLIWm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 17:42:56 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D517C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 14:39:22 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id z13-20020a627e0d000000b004a2849e589aso4442868pfc.0
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 14:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=X4STPSbc07zdoBShV2g4iswV6VbKeY2u5fYbfHxV3Ew=;
        b=IDS4HCREKFqBo3mzXqXGDoECFGGwdjezpGSNDIGiqwwyUM8KG36fFZANWK5KN/t5Jh
         8nTADyT+E2VvqARFM2S/40gHThqfCBkDF+V/mKDZr8LRdoVTgIsoHoJV0FkHYTjzfp3f
         DLf3ZF7feaspMtRytU7Nn2GAqvZXCLNV2WUNHmKPl1R5QIwNawDWcA3VnpBzvMLll1BY
         OCpSFr7+jIP3u/NayC0aWUPBD35lA1YL+ikVHhQ7dPK+LSywnohIRpiGd+vLiocv97Sb
         0l/QjByu+E9nJBJ50/vqytiYKMvBN6BS7AiXk8vS9ylmqDmNWpWS1Q23UXksv7P/wYyO
         KynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=X4STPSbc07zdoBShV2g4iswV6VbKeY2u5fYbfHxV3Ew=;
        b=vCPStDtDuxctm9A4kmqLMv9P1h+C3ENTqXWRL3paSQE1X2Q18/3vbNEkiZ59GQfxdm
         gLTz4mlQW59z4Jmpeq3jlrvUUH8X4kyKqLmjaF/ZxaMZSwGhVre2Ck9+CDClOpfswSe5
         gXSTE2hvrA1QDpAHkeKGow4dWlRNVV9BS9M6C/IrHF4hy2JkiMpHAp8d+betQpPgrqhB
         MZHdB68CmUvXYf1s7YJBxzsF4XsBGAVE6M73F0pYzIGzgHIFVR1P/lTF0vcMSBPBIb8o
         zEo/WxCcbHHjhZA2RCcIyh5XO/iwx7uVA+MEW2ySQUMa2iOWA/p5psZWR7j/pbUcGE0G
         aJSQ==
X-Gm-Message-State: AOAM530jVq2uUG9c+1LWgad4/9ym2lqlluYqGFxdj2iP48Kf5Iq3Zur0
        uhsOm9szCsBXmWgWTynzO6j053C1ld4EkRM3d1v+
X-Google-Smtp-Source: ABdhPJwRCZpkXD/YUTYb5+1EERok8wTEv6QUeNvsgR3W6LyPfPkgXxLxKnmds+JGJhkGukVvK1HhSABR0vpQ5l7INmrA
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:b919:: with SMTP id
 z25mr16283698pge.252.1639089561479; Thu, 09 Dec 2021 14:39:21 -0800 (PST)
Date:   Thu,  9 Dec 2021 14:39:19 -0800
In-Reply-To: <kl6lwnkean33.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <20211209223919.513113-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <kl6lwnkean33.fsf@chooglen-macbookpro.roam.corp.google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: Re: [PATCH v6 2/2] config: include file if remote URL matches a glob
From:   Jonathan Tan <jonathantanmy@google.com>
To:     chooglen@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> > +`hasconfig:remote.*.url:`::
> > +	The data that follows this keyword is taken to
> > +	be a pattern with standard globbing wildcards and two
> > +	additional ones, `**/` and `/**`, that can match multiple
> > +	components. The first time this keyword is seen, the rest of
> > +	the config files will be scanned for remote URLs (without
> > +	applying any values). If there exists at least one remote URL
> > +	that matches this pattern, the include condition is met.
> > ++
> > +Files included by this option (directly or indirectly) are not allowed
> > +to contain remote URLs.
>=20
> Wondering out loud.. Reading this and =C3=86var's comment [1], I wonder i=
f we
> should make it clear to users *why* we choose to forbid remote URLs.
>=20
> Since this series is setting a precedent for future "hasconfig:"
> conditions (files included by "hasconfig:foo.*.bar" cannot contain any
> "foo.*.bar" values), it would be useful to git developers to explain
> *why* we chose to do this. And if we're documenting it for ourselves,
> we might as well write it in the public docs. That way, users would know
> that this is more of a guardrail (because it's simpler to understand
> this way) than a hard limitation.
>=20
> [1] https://lore.kernel.org/git/211207.86k0ggnvfo.gmgdl@evledraar.gmail.c=
om

The explanation is rather long, though. It goes something like this:

  If the main config is:

  [remote a]
    url =3D bar
  [includeif hasconfig:remote.*.url:foo]
    path =3D foo
  [includeif hasconfig:remote.*.url:bar]
    path =3D bar

  and "bar" contains:

  [remote b]
    url =3D foo

  Should "foo" be included? For now, we avoid these situations
  completely by prohibiting URLs from being configured in "includeif
  hasconfig".

If you can think of a concise explanation, maybe we can include it.
