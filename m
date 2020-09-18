Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F227C43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 20:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 082F322211
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 20:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVD70YGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgIRUA1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 16:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgIRUA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 16:00:26 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E996C0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 13:00:26 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id y9so7534261ilq.2
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 13:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4wOsiBWngltzZ7Cae6M6v6C4IYSx4mt/ClvFQVfB9P8=;
        b=BVD70YGW0fwXMjJaAqYC/slty/VD6DePtWW0RjdE/tvVvHu7kToxQKlf8I70tZePBn
         D9oFbn7y94IQj2eScyua+aCMo8KIvo/ldVBcS7Qv6w2Lv7W+2Yn1bvjlf2iF1Qh1aWj3
         2Db7rInx9r4YUubgzIkIegL5S8imoQfcLYvyOmI7MBc2r9CvasigA0E8sVRRVCTxT+dh
         FHbnbEIH/+koHGUt2QFnviPeZZn2uit00RvLvzA2K0Q3FurDqG0BdpftlQe4HglroZi7
         KPr/AQXz875qrz1kb3aEMfIj0ynylCWyCGAeEoAYKo4uI8PQ7evVzii3oNgIzvaLnIIu
         uFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4wOsiBWngltzZ7Cae6M6v6C4IYSx4mt/ClvFQVfB9P8=;
        b=S0ba9rn3auxRimH0T/Sa0UsGiyBXeLFfPGDxSEgDZPpEhE5tT5Q08zkiAT8oND8K9Q
         NTfHY8kPiQmNtANH04IrfUcQ+ubY5wGcPjzk2791xKtxAOjtl612TjJ4PpYB0g1bU8kf
         2eKyH37JiRrKDlXa5TFlV7oB2w4T1PIo9fuRljRe4ZSHDXfuWMpwiPKy/A1KFCQ4/IiI
         xs6TZh7JaMZZw2yKG3ySsVKn6feNowBmhxX2uys3MzmAZM3IV9OlLHZO5Vm/fO0BJfyJ
         b2PFtIkFGIPq4EGa9WbfXHnGd+BLtdbgKG2xzUTOMZkwi0VbXOs0Wgng8O7icXZk8Yvi
         4mFQ==
X-Gm-Message-State: AOAM5306up4O7SMf6ik1ihLjnDJcJcBaYNFir1FakTcm1egxRHxncdWw
        F9FBRxsaik/mVpL4bcH6+zhFo1Rg2ihlWlxWRoMIKTnIgNM=
X-Google-Smtp-Source: ABdhPJwT6kK1CLOqxEQe9yQ317xH/AZXgPtLY2VZMQNtkmTPq2/zB5iE2+N+2v0YIGQsD2YT0crUbzvdb1/4fXt0ed0=
X-Received: by 2002:a05:6e02:11:: with SMTP id h17mr11727680ilr.300.1600459225784;
 Fri, 18 Sep 2020 13:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHpGcMJqmUmCR_u3fxSVppzwBo8_6RJG5-WLrXAWXm+OQ6_3bA@mail.gmail.com>
 <xmqqbli3nlda.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqbli3nlda.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Fri, 18 Sep 2020 22:00:14 +0200
Message-ID: <CAHpGcMLEtuKAi1xeaAaC0pMi+mn3wuYVtg0zT4VqJuRHtVHVoA@mail.gmail.com>
Subject: Re: Apply git bundle to source tree?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Fr., 18. Sept. 2020 um 17:41 Uhr schrieb Junio C Hamano <gitster@pobox.c=
om>:
> Andreas Gr=C3=BCnbacher <andreas.gruenbacher@gmail.com> writes:
> > I'm wondering if there's a way to apply a particular head in a bundle
> > to a source tree, for example:
> >
> >   $ git bundle create v5.9-rc1.bundle v5.8..v5.9-rc1
> >   $ cd linux-5.8
> >   $ git bundle APPLY ../5.9-rc1.bundle v5.9-rc1
> >
> > That would allow to reconstruct either the original repository or just
> > the underlying source tree, so the bundle could be used as a kind of
> > super diff.
>
> There seem to be a bit of misconception.
>
> Do not think that a bundle is like a patch.  When you created the
> bundle in the above example, you did not create a "super diff"
> between v5.8 and v5.9-rc1 that you can apply to a working tree files
> that correspond to v5.8 release.  That is not what you did.
>
> What you created is an equivalent of a (shallow) repository, that
> contains everything needed to get v5.9-rc1 by those who have a Git
> repository that has v5.8 to fetch/pull from.  It is OK to have more,
> but you MUST have v5.8 for the bundle in the example to be usable.
>
> So assuming that your 'linux-5.8' is not just a tarball extract but
> a Linux repository with v5.8 tag in it (i.e. "git log v5.8" gives
> you sensible output) then the command to use is not apply but fetch,
> e.g.
>
>     $ git bundle fetch ../5.9-rc1.bundle v5.9-rc1
>
> which will give you v5.9-rc1 tag.  What you can fetch from the bundle
> can be listed by using the list-heads subcommand on the bundle.
>
> And starting from that point, you would be able to do things like
>
>     $ git checkout -b my-fork-of-5.9-rc1 v5.9-rc1

Yes thanks, that's roughly what I could infer from the man page.

> Now, assuming that your original question indeed came from thinking
> of a bundle like a patch and not like a repository, we have a
> question for you.  What in
>
>     $ git bundle --help
>
> gave such an incorrect impression? The documentation must be at
> fault here, and we need to clarify so that future readers of it will
> not be confused into the same misconception.

I think the documentation is fine, nothing in it indicates that what
I'm looking for is supported. That's why I was asking if it's possible
to reconstruct the v5.9-rc1 source tree from the v5.8 source tree plus
a v5.8..v5.9-rc1 bundle at least theoretically.

Poking a little further, I see that the bundle depends on v5.8 and all
the ancestor commits of v5.8 that were merged into v5.9-rc1, which
only makes sense now. The bundle doesn't contain any of the objects
coming from those commits, so there's simply not enough information
there for what I was trying to achieve.

Thanks,
Andreas
