Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 228251FF6D
	for <e@80x24.org>; Tue, 20 Dec 2016 08:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754451AbcLTIuq (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 03:50:46 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33561 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753910AbcLTIup (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 03:50:45 -0500
Received: by mail-wm0-f66.google.com with SMTP id u144so22966741wmu.0
        for <git@vger.kernel.org>; Tue, 20 Dec 2016 00:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FgXMFBj5RlGuH5MgZtGhRuUISAvFOBxTk/S5vaIdjT0=;
        b=Y5rvo+neeEI6QQ9FU3kqdgIRvq/6mKjPwvZgoXd782GPPvln5rDc4Ku30o3vSTV7X1
         ERgMB8DuvtpRw7AUU7BUc4FjGcz+p//sE1LmenoCZ4RFuNqvBKvpbnw4gtowSH3kX3za
         yccUlJKCtypAGR2BErtLIwmszc9r4PLP/4eh30H9irLPr4N0opZAAZY2btbHThaalDNb
         C1zNtbKQCWGwgvpOfkdvX5HXRyrU+jyJabI2Zx3kOcQ3B5956jwExC0T7l2d6ltLBfR5
         cu0+ezPGivZH497yDkm0j6bu6Y11SJaK/d1Xo1xZGEWkx6k2c18lMBHqqGvkZc1U1HQI
         Lrkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FgXMFBj5RlGuH5MgZtGhRuUISAvFOBxTk/S5vaIdjT0=;
        b=FlOSW0usOVwKFDgvmoACJUp6MASlgY2Hdl9ytuZomVdm9Lz6JfVP/nOyw8Ab93VxEj
         imvZXm9X6Gynv37lvNNdvKShdPFgww7zXJJjOqzG2mZtVQi3mns64zn1NcyLf2fnKSFt
         TbcYvYA2oNTwtEw6LKxzgC5OFjMdthiJf1lRjfzUCAG070V/6vAlHFrXor3vt2XK4/Fp
         3LwSFK+nZ+VID6D2mbapzv3GSQ7G/gbyYQCYt6Uren4ZzzQpVyyUYo0JNhOraMzsPRkD
         ST7vLKwBOgUdVE2tqvOavFPwnfDPfGEwxxUU5VDd60TN7Vgmi9hbjW5Q3+zDc2LnuHBJ
         7sqA==
X-Gm-Message-State: AIkVDXLgtumFYbG5qGV03xzpsrQqXox0xfDME/0YcsDOYm3R1KeuUp4J7GnGZ9x7Iqg3lpv8OvxlZb+1vIUp+w==
X-Received: by 10.28.220.197 with SMTP id t188mr826668wmg.57.1482223843379;
 Tue, 20 Dec 2016 00:50:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.194.145.101 with HTTP; Tue, 20 Dec 2016 00:50:42 -0800 (PST)
In-Reply-To: <20161214170852.bzh5pyl4bov6rwbt@sigill.intra.peff.net>
References: <20161005033353.Horde.33pf2naqnF4HgwPWSy9DaHV@webmail.informatik.kit.edu>
 <20161208142401.1329-1-szeder.dev@gmail.com> <20161214170852.bzh5pyl4bov6rwbt@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Tue, 20 Dec 2016 09:50:42 +0100
Message-ID: <CAM0VKjmDDKgYCvtbwpx=GcwRENzvSDLW_Xhia3btdeMjtAjAvg@mail.gmail.com>
Subject: Re: [PATCHv2 0/7] Fix and generalize version sort reordering
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Leho Kraav <leho@conversionready.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2016 at 6:08 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Dec 08, 2016 at 03:23:54PM +0100, SZEDER G=C3=A1bor wrote:
>
>> > With my patches it looks like this:
>> >
>> >     $ git -c versionsort.prereleasesuffix=3D-pre \
>> >           -c versionsort.prereleasesuffix=3D-prerelease \
>> >           tag -l --sort=3Dversion:refname
>> >     v1.0.0-prerelease1
>> >     v1.0.0-pre1
>> >     v1.0.0-pre2
>> >     v1.0.0
>>
>> And when there happen to be more than one matching suffixes starting
>> at the same earliest position, then we should pick the longest of
>> them.  The new patch 6/7 implements this behavior.
>
> The whole approach taken by the suffix code (before your patches) leaves
> me with the nagging feeling that the comparison is not always going to
> be transitive (i.e., that "a < b && b < c" does not always imply "a <
> c"), which is going to cause nonsensical sorting results.
>
> And that may be part of the issue your 6/7 fixes.
>
> I spent some time playing with this the other day, though, and couldn't
> come up with a specific example that fails the condition above.
>
> It just seems like the whole thing would conceptually easier if we
> pre-parsed the versions into a sequence of elements, then the comparison
> between any two elements would just walk that sequence. The benefit
> there is that you can implement whatever rules you like for the parsing
> (like "prefer longer suffixes to shorter"), but you know the comparison
> will always be consistent.

I considered parsing tagnames into prefix, version number and suffix,
and then work from that, but decided against it.

versioncmp() is taken from glibc, so I assume that it's thoroughly
tested, even in corner cases (e.g. multiple leading zeros).
Furthermore, I think it's a good thing that by default (i.e. without
suffix reordering) our version sort orders the same way as glibc's
version sort does.  Introducing a different algorithm would risk bugs
in the more subtle cases.

Then there are all the weird release suffixes out there, and I didn't
want to decide on a policy for splitting them sanely; don't know
whether there exist any universal rules for this splitting at
all.  E.g. one of the packages here has the following version (let's
ignore the fact that because of the '~' this is an invalid refname in
git):

  1.1.0~rc1-2ubuntu7-1linuxmint1

Now, it's clear that the version number is "1.1.0", and the user
should configure the suffix "~rc" for prerelease reordering.  But what
about the rest?  How should we split it "into a sequence of elements",
is it { "1.1.0", "~rc1", "-2ubuntu7", "-1linuxmint1" } or { "1.1.0",
"~rc1-2", "ubuntu7-1", "linuxmint1" }?
What if there is a hard-working developer who is involved in a lot of
Debian derivatives (and derivatives of derivatives...), and, for
whatever reason, wants to put derivative-specific versions in a
particular order?  With my series, or conceptually even with master if
it weren't buggy, it's possible to specify the order of suffixes of
suffixes, and that dev could do this:

  $ git -c versionsort.suffix=3D-rc
        -c versionsort.suffix=3Dlinuxmint
        -c versionsort.suffix=3DYADoaDD
        tag -l --sort=3Dversion:refname
  '1.1.0*'
  1.1.0-rc1-2ubuntu7-1linuxmint1
  1.1.0-rc1-2ubuntu7-1YADoaDD2
  1.1.0
  1.1.0-2ubuntu7-1linuxmint1
  1.1.0-2ubuntu7-1YADoaDD2

and would get Linux Mint-specific tags before "Yet Another Derivative
of a Debian Derivative"-specific ones.  Not sure whether this is
relevant in practice, but I think it's a nice property nonetheless.

(Btw, just for fun, I also found a package version
2.0.0~beta2+isreally1.8.6-0ubuntu1.  "isreally".  Oh yeah :)

> It would also be more efficient, I think (it seems like the sort is
> O(nr_tags * lg(nr_tags) * nr_suffixes) due to parsing suffixes in the
> comparator). Though that probably doesn't matter much in practice.

I don't think there will be more than only a few configured suffixes
in any repository.  However, if you consider O as "number of
starts_with() invocations", then there is an additional suffix_length
factor.  But then again, these suffixes tend to be short.

> I dunno. I think maybe your 6/7 has converged on an equivalent behavior.
> And I am certainly not volunteering to re-write it, so if what you have
> works, I'm not opposed to it.
>
> -Peff
