Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DD1C43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 21:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97CF120848
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 21:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gm1eIFfs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgIRVpN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 17:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgIRVpN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 17:45:13 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1BFC0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 14:45:12 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id f82so7754604ilh.8
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 14:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QOpFM3H8WQIUV+zItrkvzKmoYXIEp0pchIcUxydRIGs=;
        b=Gm1eIFfso4dWXVmV6KkeobZS87Y4wT9AdLzs2Ei20vN0e8AKdtFeOJE8blYCrs7/GO
         wpYz9bPTZNozmGL9QlqpC9PZ0SvI8J3wS1auB32StNReGPIp4zFb71Ae21FVJcbh3FpU
         H00p/n6ydqg9H6BWnPnLJQBrBnZMdJlnIHIq6km7BqXZc73gkQpNkH6VmG5AM/kU0Rby
         l4RLOwqkWXY9xRMDnC1N3tfg/XMgmtkAXUmUyjGwFThlvark/fce1w39jph5qENOioHm
         cEEGwB3eV9Fg3qOMnCioZVnySTi6r7jdPSWxwb/6DCG9hl8ECfHEoEGPErTQ5yipfisv
         Juww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QOpFM3H8WQIUV+zItrkvzKmoYXIEp0pchIcUxydRIGs=;
        b=JgZKZRpW8hady+/179mmHDix/qGzfJqBOumeVuP7BS+9x78XzCC/cggsKNcsYYy3x0
         HrjVzHjF8a5m8gwqZ7zdS8+6fwvKL8q26G7QZkqDcNxSRCyIN2I1Ixm2Rt3IgLHxAqeG
         wQNBglTZfuO9PqSFrtp1srQ3OsNJWZXPLG8S3yKpWhAVRFeQFIGn2YRAeHD9MXjU6rq+
         Z7n6q8uhVAAwUrpxXKFQlzAUIk5Snzh8Pmti+ylYtr42OrCLUrRkiopeDCwxhTDhDz7i
         FrTvFqWKjhml/YNlqzNkMl33/gQpZmKg+LUzskNJAykssQ90o5ZU5EmceeRtLV5rVhm5
         i4QQ==
X-Gm-Message-State: AOAM533mLEvVHq0TuIlT+4bqemR/Uu50zT8c983HmuuDpjl+5XBYebH4
        pNfZA4gKSrRqjL8LwskcuXQMV4Jl5TAMCQufZ4NCKfV9
X-Google-Smtp-Source: ABdhPJwqMZyZMlQwLEK4dSkduu1zbu16UO1hhLpyQPiglheFWcKfwESZ/ajyqJctzrcow6ZB/1TlclGwGPFeVF5pJt4=
X-Received: by 2002:a92:98c5:: with SMTP id a66mr31588529ill.50.1600465512207;
 Fri, 18 Sep 2020 14:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAHpGcMJqmUmCR_u3fxSVppzwBo8_6RJG5-WLrXAWXm+OQ6_3bA@mail.gmail.com>
 <CAMwyc-RCiEREpPsTb76LjhLc43Zr2qw-uxYVVPfuznexTTB+Tg@mail.gmail.com>
In-Reply-To: <CAMwyc-RCiEREpPsTb76LjhLc43Zr2qw-uxYVVPfuznexTTB+Tg@mail.gmail.com>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Fri, 18 Sep 2020 23:45:01 +0200
Message-ID: <CAHpGcMJy=0deaByZ=jXHRiHgHH7utHc0JTG=BMq9Yf1DOKvuGw@mail.gmail.com>
Subject: Re: Apply git bundle to source tree?
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Fr., 18. Sept. 2020 um 22:18 Uhr schrieb Konstantin Ryabitsev
<konstantin@linuxfoundation.org>:
> On Fri, 18 Sep 2020 at 07:14, Andreas Gr=C3=BCnbacher
> <andreas.gruenbacher@gmail.com> wrote:
> >
> > Hi,
> >
> > I'm wondering if there's a way to apply a particular head in a bundle
> > to a source tree, for example:
> >
> >   $ git bundle create v5.9-rc1.bundle v5.8..v5.9-rc1
> >   $ cd linux-5.8
> >   $ git bundle APPLY ../5.9-rc1.bundle v5.9-rc1
>
> I know this is not what you are asking, but since you used the kernel
> as your example, you can use the following to achieve the result
> you're looking for:
> curl --header 'Accept-Encoding: gzip' -L
> https://git.kernel.org/torvalds/p/v5.9-rc1/v5.8 | gunzip - | git apply

Oh, that's neat.

What I had in mind were actually distro packages: most projects
nowadays live somewhere in git repositories. When they're packaged,
this usually results in a source package with a diff on top of a
baseline release, so the commit history is lost. Friendly packagers
include the commit hashes and point users to a suitable git
repository, but that's not enforced or consistent. Including the
actual git history in packages would be much nicer (i.e., a git
bundle), but if that can't replace the patch as well, it's rather
unlikely to happen.

Thanks,
Andreas
