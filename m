Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CC5C43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 12:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348239AbiFJMEu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 08:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245262AbiFJMEs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 08:04:48 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1983EB97
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 05:04:47 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a15so42479290lfb.9
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 05:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XxmX1FePU3ZiFFa/Ihg4WFJb2v5t3DuqooFfD5eE2+U=;
        b=g8hVRsrLngT+9SGB+rUytgB4eObVkM8+p5EQJ5A4Z2x/3CX2blz+UK6QKRfe2LE+hM
         NHaY8bhTXFJnyAe80C4u4VQSp6QJ2iyat81Hh4BZpnfIO/Zy60ikirYDZpnjtIqXL2uP
         jvhV3eHYZTfNbryBGzGUGWxnhoMspUenXN0o2kFjf3Zdoj6hPWAFQk+kDrBK9lVDXIAE
         0zgMdCnR+goDpSrqx1n7QCx7DpQ1RfZ/rPhHhoftm4sSzLAZ2KuiGI8T9WCTcGBXCu3Z
         3PtBDrqGfIBQ+oBSx55v/H//v2G4KO7Bt5up/WKBtUnqAW05Slu2enafi270nH5FK97Z
         UF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XxmX1FePU3ZiFFa/Ihg4WFJb2v5t3DuqooFfD5eE2+U=;
        b=CAIwHxeC5E4u8sWst/yUw0kH40k9rBJkbseC9zclNUypWZzZUQacyksVYA94IiwgM+
         0Zma1D0qnPxOl6Ok5K5qUh8NdnFxnQAeirrapIRw08TcjyJ99mL2X69SoeVW5uYakWXw
         WzPmcXk9h9ZQMwGv7rjUnGgt9x9J72uzntMMVEZinhulSP+Tl4JjY5ypHPcX4UdajIBP
         uxhxpzDGMkhjQNvqZd9CqrDJq7hTIaDm64ctQA7yxEjiIacdl6AkygXfWyKUSZ2WVgRE
         uYG0NzaYA89wvtOOTrJ6AmWaa/Mk0HqnqZK5tvcFeuk4he07DncctPanyyLd1oE+vmQ6
         22Ww==
X-Gm-Message-State: AOAM533qngNDqSpc+40WIvv/yCkB0EtapBQp0kevraCIIGfYA2M1bXN9
        jPj+ygtavxtZ1OAe2vl5TMBFKF78d+goKinTOmc=
X-Google-Smtp-Source: ABdhPJwX/sL7bUilqrFMItaIysuKuQQKLlX4s7ScNu9j8d/oipj72GEw30r4KHnkCapKsUzk6omhbgM3aPhU8SDTO+k=
X-Received: by 2002:a05:6512:2a9b:b0:479:1737:a5ec with SMTP id
 dt27-20020a0565122a9b00b004791737a5ecmr24622713lfb.481.1654862685556; Fri, 10
 Jun 2022 05:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com>
 <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com>
 <patch-v13-1.7-12873fc9915-20220604T095113Z-avarab@gmail.com>
 <xmqqpmjl7i7y.fsf@gitster.g> <CAO0brD2s-i2Bp7r2n+TRLs2LckzM-i1-293rr=sgmC2TbLozow@mail.gmail.com>
 <xmqqa6allmjl.fsf@gitster.g> <CAO0brD3tU+v_5dS9En_fTpEyYVmgEMVb7iVGsPk6iuYNGdpYBg@mail.gmail.com>
 <220610.86mtels249.gmgdl@evledraar.gmail.com>
In-Reply-To: <220610.86mtels249.gmgdl@evledraar.gmail.com>
From:   Han Xin <chiyutianyi@gmail.com>
Date:   Fri, 10 Jun 2022 20:04:34 +0800
Message-ID: <CAO0brD0_CidpW8vKD2xbW=tXmZS-1Nup57Daz6DhcSN=WwPdEg@mail.gmail.com>
Subject: Re: [PATCH v13 1/7] unpack-objects: low memory footprint for
 get_data() in dry_run mode
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 10, 2022 at 10:07 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Fri, Jun 10 2022, Han Xin wrote:
>
> > On Fri, Jun 10, 2022 at 2:27 AM Junio C Hamano <gitster@pobox.com> wrot=
e:
> >>
> >> Han Xin <chiyutianyi@gmail.com> writes:
> >>
> >> >> I am not sure if this is not loosening the error checking in the
> >> >> dry-run case, though.  In the original code, we set the avail_out
> >> >> to the total expected size so
> >> >>
> >> >>  (1) if the caller gives too small a size, git_inflate() would stop
> >> >>      at stream.total_out with ret that is not STREAM_END nor OK,
> >> >>      bypassing the "break", and we catch the error.
> >> >>
> >> >>  (2) if the caller gives too large a size, git_inflate() would stop
> >> >>      at the true size of inflated zstream, with STREAM_END and woul=
d
> >> >>      not hit this "break", and we catch the error.
> >> >>
> >> >> With the new code, since we keep refreshing avail_out (see below),
> >> >> git_inflate() does not even learn how many bytes we are _expecting_
> >> >> to see.  Is the error checking in the loop, with the updated code,
> >> >> catch the mismatch between expected and actual size (plausibly
> >> >> caused by a corrupted zstream) the same way as we do in the
> >> >> non dry-run code path?
> >> >>
> >> >
> >> > Unlike the original implementation, if we get a corrupted zstream, w=
e
> >> > won't break at Z_BUFFER_ERROR, maybe until we've read all the
> >> > input. I think it can still catch the mismatch between expected and
> >> > actual size when "fill(1)" gets an EOF, if it's not too late.
> >>
> >> That is only one half of the two possible failure cases, i.e. input
> >> is shorter than the expected size.  If the caller specified size is
> >> smaller than what the stream inflates to, I do not see the new code
> >> to be limiting the .avail_out near the end of the iteration, which
> >> would be necessary to catch such an error, even if we are not
> >> interested in using the inflated contents, no?
> >>
> >
> > Yes, you are right.
> >
> > Instead of always using a fixed "bufsize" even if there is not enough
> > expected output remaining, we can get a more accurate one by comparing
> > "total_out" to "size", so we can catch problems early by getting
> > Z_BUFFER_ERROR.
> >
> > diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> > index 64abba8dba..5d59144883 100644
> > --- a/builtin/unpack-objects.c
> > +++ b/builtin/unpack-objects.c
> > @@ -139,7 +139,8 @@ static void *get_data(unsigned long size)
> >                 if (dry_run) {
> >                         /* reuse the buffer in dry_run mode */
> >                         stream.next_out =3D buf;
> > -                       stream.avail_out =3D bufsize;
> > +                       stream.avail_out =3D bufsize > size - stream.to=
tal_out ?
> > +                               size - stream.total_out : bufsize;
> >                 }
> >         }
> >         git_inflate_end(&stream);
> >
> > Thanks
> > -Han Xin
>
> Han, do you want to pick this up again for a v14? It looks like you're
> very on top of it already, and I re-sent your patches because I saw that
> your
> https://lore.kernel.org/git/cover.1653015534.git.chiyutianyi@gmail.com/
> wasn't picked up in the interim & you hadn't been active on-list
> otherwise.
>
> But it looks like there's some interest now, and that you have more time
> to test & follow-up on this topic than I do at the moment, so if you
> wanted to do the work of properly rebasing ot in tho recent fsync
> changes that would be great. Thanks.

OK, I am glad to do that.

Thank you very much.

-Han Xin
