Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE11C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 14:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB07320838
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 14:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQlH7xYZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbgHNOGW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 10:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgHNOGE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 10:06:04 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6B5C061384
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 07:06:04 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id x142so2033384vke.0
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 07:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pnFheQS2n6ZO+6N7hAzlrMOgwOS8G0wFq6KRShTAWuE=;
        b=pQlH7xYZxG5IycIKU6YB3AO+TMv4uEMBjUONt4eJm+9ISFRpP0+B3UAFwSmIsAl6XI
         L8dvJv3mNo+c8QDyXwwVIb+1Ar14qjQjvZjVTpQos7fmDx8JNjhJ7Mw9HUaoM2TQcu+4
         VkYmr32c4s7ZKdzyGphziKV6UMxFs9EFWSeOnXscwze/zsszNWAn8jHw4/rRHE3Tqvop
         4vKrINOI5yqNPu1c686uUhOScb0/wOguiutBtr1Nb1qckaHCk7YIY2GNOzmYSwMsud86
         OxTPljIW0q4xmQjx6Xh5Sho94ok+xjqDLOE9+AXEQ01Lgm5s4NRE9fTiOavEbQpQMqoC
         49xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pnFheQS2n6ZO+6N7hAzlrMOgwOS8G0wFq6KRShTAWuE=;
        b=D2VfXe5WzRmhrgDbm+BMilQICX0iCCrflBnIdoliqQA3nt8KV9lNVwZpG4+Eb4vVvY
         eYwvbvVPdooe5tknyCzC8qHbEdAlBc16jMXz7iTjs9cvh56aGsaBI0aX1WMbArqiEL0C
         BJzr54pJLHtYdFZRPqDIrrpKmVbTveTXpst/i3GGAZc4ZC8eT4gITDQr3ekTMkBURWf2
         5XvlEOXxngoE1MbPtDU/EoJPp8BAPKyCAH4dMkBwv7mN3Kk0ps9rSQB0v47yzNhMXOxe
         mrftu6SJMIEM+wMaPUHfmhUUxHiQqb2YHjVOVWGG93c+QgLX7H3Qg1JPIcD0PyXB3uvU
         x2Tg==
X-Gm-Message-State: AOAM530yFRuEmFVHr4QoQWZLC/UwhaVbAgrukt0Ffm5CxavB2/FnD+JS
        NlCCxp4b2Gn1OOYgaev+FOmNRw3JVnaSvQy2fX8=
X-Google-Smtp-Source: ABdhPJyhL95Dv1kYN094Y1VSOcHMwyHIfVKg5JR8sjPvXFeuUVFrN6pZzOwNq3klgvIO3SHeNEI+7MDy6Ez2T4FhIOE=
X-Received: by 2002:a1f:1d12:: with SMTP id d18mr1591615vkd.88.1597413957284;
 Fri, 14 Aug 2020 07:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200813224901.2652387-1-sandals@crustytoothpaste.net>
 <cover.1597406877.git.martin.agren@gmail.com> <13798dfb121c9631e9d811f5f74f9a78c1fcfdf9.1597406877.git.martin.agren@gmail.com>
 <73e1ce78-a461-1204-99d5-a588f8e65fc9@gmail.com>
In-Reply-To: <73e1ce78-a461-1204-99d5-a588f8e65fc9@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 14 Aug 2020 16:05:44 +0200
Message-ID: <CAN0heSraHteU1fG7Eu_S7aE6r60vuVUFC=DnxdZNgpvHk4G0MQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] protocol-capabilities.txt: clarify
 "allow-x-sha1-in-want" re SHA-256
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 14 Aug 2020 at 14:31, Derrick Stolee <stolee@gmail.com> wrote:
>
> On 8/14/2020 8:21 AM, Martin =C3=85gren wrote:
> >
> >  If the upload-pack server advertises this capability, fetch-pack may
> > -send "want" lines with SHA-1s that exist at the server but are not
> > -advertised by upload-pack.
> > +send "want" lines with object names that exist at the server but are n=
ot
> > +advertised by upload-pack. (Note that the name of the capability
> > +contains "sha1", but that it's more general than that: in SHA-1
> > +repositories, the "want" lines provide SHA-1 values, but in SHA-256
> > +repositories, they provide SHA-256 values.)
> >
> >  allow-reachable-sha1-in-want
> >  ----------------------------
> >
> >  If the upload-pack server advertises this capability, fetch-pack may
> > -send "want" lines with SHA-1s that exist at the server but are not
> > -advertised by upload-pack.
> > +send "want" lines with object names that exist at the server but are n=
ot
> > +advertised by upload-pack. (Same remark about "sha1" as above.)
>
> This "as above" is brittle to future changes.

Fair enough. :-) I actually thought this might be *less* brittle, since
we wouldn't need to do any additional changes twice.

> I think it
> could be improved with
>
>         (As in "allow-tip-sha1-in-want", the "sha1" in this capability
>         refers to object names, not the hash algorithm chosen for the
>         repository.)
>
> Or, just repeat the same note again.

These two paragraphs are identical before this patch, so it might make
sense not to change that property. Thanks.


Martin
