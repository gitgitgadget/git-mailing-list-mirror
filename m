Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97FEC6FD1D
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 13:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjC3NAn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 09:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjC3NAm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 09:00:42 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6554F9EE0
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 06:00:36 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id f188so4870778ybb.3
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 06:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680181235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+x9o8mWf0rDfzpWH4iGkk/SANTYWoEsD6l4wVbK4P0=;
        b=Fp1UGLht9jKh2Z8IJ6aMQ1w2cCThvUOFsi8AzxEgpAPqQ7Lt5nCvu5eKkUoywclWxs
         pVbmStTbetcusXsOcu8s7oR48q17rROQof6lgwUORWYKNASwrrsX+WyCZy0nUoIjjSSV
         2YkeP90vlPIMopB5PPRghIXWRhv4Uhj2CUKzO5Jfli/KH9RfqoZYtuh1RYZPGMvTwaM0
         6ca3h2KkY5usc+wIK6f9yRckeFH/8TPJWCtKG8sT6H7Y7b2sxSmVRii45P8nQpuTg7Yl
         LX/A/zoPC9bPnGIpbC5PTVcbZ9dm6btMLPIWaPtmBok1AapkE56x4NadVO4lvlS8Mupy
         aYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680181235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+x9o8mWf0rDfzpWH4iGkk/SANTYWoEsD6l4wVbK4P0=;
        b=4Qx/ugGUxe411oc2berqe8lsht/iCOqrEYX5Wi7ShwJdhM2zirK4H+PymK/4k1nOgT
         boCfV4jY3psunFZo/lCZGSC8GCpj9rIBuoOsAovvbwFtn4Fc1ORes/LtyUSUnOzdQwPM
         Gip+UkoSkHH2sNzgI4EJ1MynMogvcRemmrXU++Z+hmaOr8WHJT5LA7NidyXiM1hQ8q49
         dtcrKNthR5pF89hVIWUwviNrsHjog/g+H61uFQyMJHptqgn0fqHEs/jKYdlKrb9rdUNy
         BhX6uSlPok2G1jbxTOcNLTEQtc4NNJeeiPcTrBhun/u+px3w8syEmWBzdwY11Puh1EZW
         PdqQ==
X-Gm-Message-State: AAQBX9cAWm0bY2FxnLUM5WrKaZEUomLBUeqyYz1wo7yVJCBX1727uv5W
        sDJhx6zR8O/d/PBTJ+05W2paFk8Bg5JeAQ3rkxg=
X-Google-Smtp-Source: AKy350ZhSd/TxOXo/IFRh5dvQl468fESl820omx2zohu/dzhugQFwdRrw2z+6tpgYEWpavddAtbwbEA7wuoqbOQ7CVI=
X-Received: by 2002:a05:6902:1205:b0:b69:fab9:de60 with SMTP id
 s5-20020a056902120500b00b69fab9de60mr15156828ybu.0.1680181235530; Thu, 30 Mar
 2023 06:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230328173932.3614601-1-felipe.contreras@gmail.com>
 <ZCONCVC2ITBJWoBA@tapette.crustytoothpaste.net> <CAMP44s07W6SzJZnmpMMejM8cTNvwrKnNiD+1U=JWMBwUX8JbMA@mail.gmail.com>
 <230329.861ql7x4k4.gmgdl@evledraar.gmail.com> <CAMP44s1z6PBS8whv6+nhbzQr-H2+QYTDw=WHf0AkY2mbJDZfMA@mail.gmail.com>
In-Reply-To: <CAMP44s1z6PBS8whv6+nhbzQr-H2+QYTDw=WHf0AkY2mbJDZfMA@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 30 Mar 2023 07:00:24 -0600
Message-ID: <CAMP44s1MuQK1uWTnWLv9AJ4X6P_Xd3XSH1KGJOG0bn0aaBNMqQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] test: make the test suite work with zsh
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 29, 2023 at 5:19=E2=80=AFAM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Wed, Mar 29, 2023 at 3:58=E2=80=AFAM =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason
> <avarab@gmail.com> wrote:

> > But we do need to carry some hacks going forward, some of it seems
> > pretty isolated & easy to spot, but e.g. the 6/6 fix of:
> >
> > -               if test "$c" =3D " "
> > +               if test "$c" =3D " " || test -z "$c"
> >
> > Is quite subtle, you might look at that and be convinced that the RHS i=
s
> > redundant, and be right, but only because you assume POSIX semantics.

Actually, that isn't even true (see below).

> > If we are going to include this I think the relevant t/README and
> > Documentation/CodingGuidelines parts should be updated to note that
> > we're not targeting POSIX shellscripts anymore, but the subset of it
> > that zsh is happy with.

But in this particular case the exact opposite is true: the script is
*not* POSIX, it just happens to work on bash and other shells.

You *assume* it's POSIX because it works on bash and it doesn't work
on zsh, but in this particular case bash is the non-POSIX one, zsh is
following POSIX correctly.

> There's no point in that. I consider it a bug in zsh, along with 5/6,
> so presumably at some point it's going to be fixed.

Actually, no. I've changed my mind.

I was going to report to the zsh dev mailing list the fact that this
created an extra empty field at the end (in sh mode):

  IFS=3D, ; str=3D'foo,bar,,roo,'; printf '"%s"\n' $str

But then I read the POSIX specification, and the section 2.6.5 Field
Splitting [1] is very clear on what should happen.

What muddles the waters is the distinction between `IFS white space`
characters (newline, space and tab), and non-`IFS white space`
characters (all the other).

If we ignore all the shite space stuff and concentrate on the rules
for non-`IFS white space` characters (as comma is), then we arrive at
this subitem:

3.b. "Each occurrence in the input of an IFS character that is not IFS
white space, along with any adjacent IFS white space, shall delimit a
field, as described previously."

In other words: each occurence of a non-`IFS white space` character
shall delimit a field. Or: each occurence of a comma should delimit a
field.

The script only works if the last delimiter does *not* delimit a
field, and thus it's not following POSIX, it just happens to work on
most shells. My patch does make it align with POSIX.

I've reported bash's non-compliance with POSIX to their mailing list [2].

But I bet nobody here will care, because POSIX is just an excuse to
segregate the shells the main developers want to make work, from the
ones they are not (Brian even used the language of certain shells
being one of "the good ones").

Cheers.

[1] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.ht=
ml#tag_18_06_05
[2] https://lists.gnu.org/archive/html/bug-bash/2023-03/msg00152.html

--
Felipe Contreras
