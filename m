Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BE7C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 14:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FA3B613F7
	for <git@archiver.kernel.org>; Wed, 12 May 2021 14:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhELOLv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 10:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbhELOLu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 10:11:50 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982F1C061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 07:10:41 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id i13so18720526pfu.2
        for <git@vger.kernel.org>; Wed, 12 May 2021 07:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OGcB719UAMuqouBI0cthSFg76kts6xdmlBiWE9KosEU=;
        b=MICgf9R3uuCUMCmlMT2OrCi6JnPnLWyKhnhAGLfjimB750mCe/3ZV1xOPTCFON1qM0
         MXFW1RCxbktQn2v+gLZLfQGkBUT2NII9xJWyoBQYyrSr656UkTDFwMzDTLKvJaS7jv1A
         u8ZIx8oMiimx3u/dIkqO2sBtLrAoL/4JmZKenYEE0Qy4mqluawZ4U+pADTTYQqptmWHl
         Iw7WsoAg4NktuHRiNkgH4AeD9bZhWW+wQA1v02e0hW6NUMZqoaQoLif+bgdDExv3GOXu
         5GaK4dWh4gpoRMOSaS9uPZkRDCiAkEv/CP4hic0EcMcWCERmjkPEzXM3bXODDfG9g8oB
         OWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OGcB719UAMuqouBI0cthSFg76kts6xdmlBiWE9KosEU=;
        b=GrzlmFtOzJ4RLfP8ysfzcHdJyeNSDLIVXyaoQ3XTpetXc0SK6LkXaiMn3Z4DjWBcLh
         v4Do8uEXz5jcIQ3gK7t3bHftuJY7ySCUh5HCOEHx0cEDMpu+tnTlfCezPhTpT9aqBiH/
         0+b3EWl3z8HdnLaNzhWe3mKQKeEZqYwjf2MAv2mjkAQdFjKHv+A9x/7RWYBoYPRT6N1y
         gUga6yDibuPd6CDVHZP6NJ9MxCdIpiemZ3oXigtH44IwXXZ/PPveW4dbE9zSWMgXpJ1L
         ds+Yo+Z+tJqznBcoDj0gFvd2B3VPjjMeSO5VPSFN6ah+sTHN5zQegId30+HjiQJ1SQ8q
         0/Nw==
X-Gm-Message-State: AOAM531TYlgkAXt8xABjrKdAn3dUvjrxb+QlbqMp6CifOeXJ4EAig0y9
        hsaw8cKPyux2OD/phyVK3HheqZ1IIrS2+8lVvctxW5NIToFJ/8bij9A=
X-Google-Smtp-Source: ABdhPJxShm4moXCyGkh2+YIZoxnrsqNg5EITtG0TJIzcx9QpEuvy8ao2/8KaiL1MUgNZEdHyscRrncCePFQj/DwLQrw=
X-Received: by 2002:aa7:8a84:0:b029:231:ff56:2c7e with SMTP id
 a4-20020aa78a840000b0290231ff562c7emr36293502pfc.50.1620828641026; Wed, 12
 May 2021 07:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq4kffy224.fsf@gitster.g> <20210511064554.59924-1-dyroneteng@gmail.com>
 <xmqqpmxxknaa.fsf@gitster.g>
In-Reply-To: <xmqqpmxxknaa.fsf@gitster.g>
From:   Long Teng <dyroneteng@gmail.com>
Date:   Wed, 12 May 2021 22:10:29 +0800
Message-ID: <CADMgQSQfvacwfnhz=taR5904AJp=CWgiq50+5F0A=hN4jGo9pg@mail.gmail.com>
Subject: Re: [PATCH v2] packfile-uri.txt: fix blobPackfileUri description
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>It seems that the above needs a bit more polishing?
>
>I am not sure if moving the sign-off higher and inserting a
>three-dash line before "Jonathan Tan writes" would be sufficient,
>but with everything under that quoted material does not seem to
>belong to a proposed commit log message proper.

Sorry, I misunderstood.

I looked at some patches in the community. If I reply to the
reviewer=E2=80=99s suggestion separately and then submit a new patch, is it
the recommended way? (Distinguish between the =E2=80=98reply=E2=80=98 and t=
he
'patch').

Another question is, if I need to continue to complete this patch,
what do I need to do? I think it is to reply to Jonathan Tan
separately, and then resubmit Patch v2. Is this way correct?

Thanks for your reply.

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=8812=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=884:50=E5=86=99=E9=81=93=EF=BC=9A

>
> Teng Long <dyroneteng@gmail.com> writes:
>
> > Fix the 'uploadpack.blobPackfileUri' description in packfile-uri.txt
> > and the correct format also can be seen in t5702.
> >
> > Jonathan Tan <jonathantanmy@google.com> writes:
> >
> >>As for the commit message, limit the title to 50 characters or fewer if
> >>possible. Maybe something like "packfile-uri.txt: fix blobPackfileUri
> >>description" or something like that.
> >
> > Thanks for mention this, "packfile-uri.txt: fix blobPackfileUri
> > description" is good and meets the "50 characters" requirement. So the
> > title is modified.
> >
> >>Also in the commit message, maybe mention that the correct format can b=
e
> >>seen in t5702.
> >
> > Because I am implementing another patch[1] about supporting the commit
> > object in packfile-uri, I noticed the `configure_exclusion` function in
> > t5702, which is now mentioned in the commit message.
> >
> > [1]https://public-inbox.org/git/20210507021140.31372-1-dyroneteng@gmail=
.com
> >
> > Signed-off-by: Teng Long <dyroneteng@gmail.com>
> > ---
>
> It seems that the above needs a bit more polishing?
>
> I am not sure if moving the sign-off higher and inserting a
> three-dash line before "Jonathan Tan writes" would be sufficient,
> but with everything under that quoted material does not seem to
> belong to a proposed commit log message proper.
>
> Thanks.
>
> >  Documentation/technical/packfile-uri.txt | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/Documentation/technical/packfile-uri.txt b/Documentation/t=
echnical/packfile-uri.txt
> > index f7eabc6c76..1eb525fe76 100644
> > --- a/Documentation/technical/packfile-uri.txt
> > +++ b/Documentation/technical/packfile-uri.txt
> > @@ -35,13 +35,14 @@ include some sort of non-trivial implementation in =
the Minimum Viable Product,
> >  at least so that we can test the client.
> >
> >  This is the implementation: a feature, marked experimental, that allow=
s the
> > -server to be configured by one or more `uploadpack.blobPackfileUri=3D<=
sha1>
> > -<uri>` entries. Whenever the list of objects to be sent is assembled, =
all such
> > -blobs are excluded, replaced with URIs. As noted in "Future work" belo=
w, the
> > -server can evolve in the future to support excluding other objects (or=
 other
> > -implementations of servers could be made that support excluding other =
objects)
> > -without needing a protocol change, so clients should not expect that p=
ackfiles
> > -downloaded in this way only contain single blobs.
> > +server to be configured by one or more `uploadpack.blobPackfileUri=3D
> > +<object-hash> <pack-hash> <uri>` entries. Whenever the list of objects=
 to be
> > +sent is assembled, all such blobs are excluded, replaced with URIs. As=
 noted
> > +in "Future work" below, the server can evolve in the future to support
> > +excluding other objects (or other implementations of servers could be =
made
> > +that support excluding other objects) without needing a protocol chang=
e, so
> > +clients should not expect that packfiles downloaded in this way only c=
ontain
> > +single blobs.
> >
> >  Client design
> >  -------------
