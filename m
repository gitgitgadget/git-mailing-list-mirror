Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E70C433E6
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 16:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A44B364FBB
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 16:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhCJQgj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 11:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbhCJQg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 11:36:27 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CBBC061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 08:36:27 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id t16so16964021ott.3
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 08:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HqW+U5i30Nu48tVqlAwicrquSa7GQEb7xfYB/D6vn8w=;
        b=KsEULGbl+WJf5ApimDFtGjiMy2A2xGwaxUzy1TifNqCSal2uSawu2CQ/VKQ5doL3L2
         lqoYbbRqbcJQpZ2TjNBQD1qBsgxc3LWEmpXp4KjhrQAzxOzqRoTay6TuuRXqMYJGqPlA
         SLmgH0wO/5/vzaQkbIjGZ0rrKSr+YO1PxXG2tenwyMR48m9t8/Q8BOMtxy8LJhdbVaew
         WTh7z57jKifJ8zitWxDu4FfCgDF4BhgWpQtqrfCjynDsNx/kIuiWt7sxQNVsJ94urRId
         appKhlJenAU3dkYEZJ4NrEiP1VHFb2lXIOV5pxh7cx4FgBVQxmimJiQ+VByMrdTeHXUR
         ykPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HqW+U5i30Nu48tVqlAwicrquSa7GQEb7xfYB/D6vn8w=;
        b=GGGOEA2J0jrV8C23InLAYlQrkwrJU3DgkG3AlhReSUuCFCFqGlbn23EhRUN7knPOr5
         aohm3KsWlLNQNMy6RMFLN2RZFDBIKKTJk0wweSaY8abSisOHSvz7ZLbrfCv4OfEeqVqd
         8LUMS6TpMMY0tGXHJ75ceBzevHnYS0Kam/u5ymjfj5OHckisq8TFEAljkiuDb8CQ4oAE
         RI64o6S/+oANCZOS1CYc9Bl+bJE7SpVL4T7LVrfWwvA1/Xg66+Prbdm6PiX+y6J2OJyf
         ywLmwOXxW6OzMlAOKNFeMDDsNHrWBcvUja0PXFHw0si7set/nZ1VNMihjRJmkeyTn44u
         TzIQ==
X-Gm-Message-State: AOAM532CgNUNhx77dd2AGB7GCPgxl36g6jJfO8PTNEO+BEAK8v6sxYqV
        NiTS8Wx/oZcIZTMdHl1oBnCsgTl+IpDx3rSv3HczQbEtMxUxhQ==
X-Google-Smtp-Source: ABdhPJz3KSt2GNCkXqa0p3G1sRdXZmzwOYHFMAqf66YvIIZxnwditTaC1HEABGRk0n8mfZtNXT91a6M6J+Lc2BWl3co=
X-Received: by 2002:a9d:4d0e:: with SMTP id n14mr3149201otf.316.1615394186871;
 Wed, 10 Mar 2021 08:36:26 -0800 (PST)
MIME-Version: 1.0
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
 <20200729231428.3658647-1-sandals@crustytoothpaste.net> <8735x3i59m.fsf@evledraar.gmail.com>
In-Reply-To: <8735x3i59m.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 10 Mar 2021 08:36:15 -0800
Message-ID: <CABPp-BFFLichkBY6Jh2qzE-=Md2eU5tZzHm4aVQVnVpJFD7b0w@mail.gmail.com>
Subject: Re: [PATCH v6 00/39] SHA-256, part 3/3
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 10, 2021 at 4:04 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> [I couldn't find a more relevant thing to reply to]
>
> On Thu, Jul 30 2020, brian m. carlson wrote:
>
> > [...]
>
> B.t.w. thanks again for all your work on SHA-1 -> SHA-256.
>
> I found a missing spot that wasn't trivial to fix, so sending an E-Mail:
>
> In git-filter-branch.sh we have:
>
> _x40=3D'[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
> _x40=3D"$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
>
> Then later we have a case condition based on matching a SHA-1:
>
>         $_x40)
>                 echo "Ref '$ref' was rewritten"
>                 if ! git update-ref -m "filter-branch: rewrite" \
>
> Just deleting that case arm has filter-branch tests passing, so whatever
> it's meant to do it has zero coverage, which explains why it hasn't
> broken with our tests.
>
> I didn't have time to dig, so sending off this E-Mail instead.

Hmm, perhaps we should revive the "separate non-core tools out of
git.git" thread --
https://lore.kernel.org/git/a784a61e-1320-be1e-9dfb-d533a01827ec@gmail.com/=
.

Honestly not sure it's worth bothering fixing filter-branch at this
point, given the strong WARNINGs we added to it.  If anything, I'd
just add another warning to the pile for this issue.  If folks really
still want/need filter-branch once SHA-256 is the only option, I'm
sure they'll be motivated to make the necessary fixes (or just use/fix
filter-repo's filter-branch-ish).
