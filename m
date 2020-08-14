Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736CCC433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49CE8205CB
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVH9shH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgHNUf0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbgHNUfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 16:35:25 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DC9C061385
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 13:35:25 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id q68so3030828uaq.0
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 13:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qyVR+9B2dWlNI4Uyww5h6z8LaGe2iYrxWdWLVUjMQDc=;
        b=BVH9shH2iwIx8jdb5ordWMSyLbp7rlNDqyD9K7EV9ixxKAf6zhIxRRnot+TQ+lZ6p0
         LgBH96+otyOZGZoK1XNJDAmbjWItj0PgGq7YInD2iFAd0zfqtXk/06Nc4suiINeTOrcV
         tHnn/lH/R0zbxjxCvUT1SpDuPD9a5hMgj9MgI7u2pT5FfbpycNpu5JwFlgZy1Pjvhcyj
         36+9DZFQ16GOTM8OlVHhZ0efgRDl2pJ/gTrmBsEB9mxfcHGGX7RzdNDz8NdmzwKxnA1u
         8tTBXBqdwuDnWVh21ZlIPwsPETUM5rvl6rQMDbODkmTvMvAzaxSVdV1KYYSWMdS5tB3u
         q/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qyVR+9B2dWlNI4Uyww5h6z8LaGe2iYrxWdWLVUjMQDc=;
        b=XMtQX5QH9CExEwm/O4pQ+jR/pbyx5cOHhjL3LOvFR4Mjk2mMY0yn4PlsBQEpk1p8oT
         JgVy6rO5KaXsA7ecGWEjL2b6KHTN3qHdUhEttGIyCdR3IZF0u37Z7DZ/6aNZkk9tSs0b
         GO7bNRP1IjYv1tS7uaPFSjPLeAjb3t69kGukzlevsqkCpPVQ7YGwicSUeMSi55E074WR
         +gcM4uN13w/SFTldy8hkH4GRFR5Xw6OwR9d/QnVmTtBb3SQylkDRZ5zIhorNsTbv3uAv
         NDaZj6LUWQRq82uE62HbIm5Src+YQoWZUg8VZ2ANnbPgLc5SzYumVekj0kocTl1p+7Ka
         EpHg==
X-Gm-Message-State: AOAM530NfRX+L+CLV0ZN2LrdrzoJbX73BmQXNJcwPdogBT+fhAB9mIIu
        T74Fq3kA3y6RGpjboLZcole9ZmXiuAqyQfN416g=
X-Google-Smtp-Source: ABdhPJw47PCUXPpGil0cmfkaFkOLvHLOrWauYUsVc/KlakTHhVXQ17o3Md7EvHJ0Iwn/bEBg3bEDAhTKydGiT6eZWMc=
X-Received: by 2002:ab0:2ea2:: with SMTP id y2mr2517018uay.15.1597437325050;
 Fri, 14 Aug 2020 13:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200813224901.2652387-1-sandals@crustytoothpaste.net>
 <cover.1597406877.git.martin.agren@gmail.com> <13798dfb121c9631e9d811f5f74f9a78c1fcfdf9.1597406877.git.martin.agren@gmail.com>
 <xmqqft8pxhd9.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqft8pxhd9.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 14 Aug 2020 22:35:10 +0200
Message-ID: <CAN0heSpv5L67hYSX44LkwQ1pJ+_px_W=FQ4piXKS1anpMi0n2w@mail.gmail.com>
Subject: Re: [PATCH 3/5] protocol-capabilities.txt: clarify
 "allow-x-sha1-in-want" re SHA-256
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 14 Aug 2020 at 19:33, Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
> > Two of our extensions contain "sha1" in their names, but that's
> > historical. The "want"s will take object names that are not necessarily
> > SHA-1s. Make this clear, but also make it clear how there's still just
> > one correct hash algo: These extensions don't somehow make the "want"s
> > take object names derived using *any* hash algorithm.
> >
> > Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> > ---
> >  Documentation/technical/protocol-capabilities.txt | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/technical/protocol-capabilities.txt b/Docume=
ntation/technical/protocol-capabilities.txt
> > index 36ccd14f97..47f1b30090 100644
> > --- a/Documentation/technical/protocol-capabilities.txt
> > +++ b/Documentation/technical/protocol-capabilities.txt
> > @@ -324,15 +324,18 @@ allow-tip-sha1-in-want
> >  ----------------------
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
>
> I think we should have either a new sha256 capability or a more
> generic hash-algo capability whose value can be set to sha256.
> Neither the connection initiators or the acceptors should talk
> in sha256 until both ends agreed to do so.

I think we should, and I think we do. I haven't dug into the details,
but "object-format" looks like it's just that.

Maybe instead of SHA-1 and SHA-256, this should talk about "whatever has
been negotiated through 'object-format', or SHA-1", similar to brian's
suggestion elsewhere.

> I do not think of any other way to make sure hosting sites to serve
> projects that migrate at different pace.  Per project, you might be
> able to have a flag day.  You cannot have a flag day that spans the
> world.

Yeah, that makes sense.


Martin
