Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0FCC433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 13:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 048D06121D
	for <git@archiver.kernel.org>; Mon,  3 May 2021 13:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbhECN0a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 09:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbhECN03 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 09:26:29 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A11C06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 06:25:35 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id p15so3670344iln.3
        for <git@vger.kernel.org>; Mon, 03 May 2021 06:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pEGs/aqzAaZegdfOFqAIK9f+D39zO31ajJPQ9BAa/f4=;
        b=okuJ27m76+ix2JIHi/EwSJ78P7j01vsoWRQws54aN1MXvJstaPOeMoQCYyekIFiO2D
         ywdbaKmLtnjA3+a2huYA5MRfaSEJQmjYFuyDMmQZ5ie/9To+1a1nKVB8U2yfhc1RQvI/
         4Npin0+TADotiMQAoktE204yPtsSWz2kWL+4fKiFTAs09fTpLRU9rlYIm7ryXz5+Asee
         CEp9Fl8LmJZCh5ewrXsvyKBT20LNDcszUA6IFDKwJQEh1Od8osrmnKk7+UFiiW0b1cx9
         eUo2RcyQetgkv45P6mCn6H03fAdoSrQK59CzMxSqvQ2uVGBZt77wqCyR/18Z36IybxoD
         CKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pEGs/aqzAaZegdfOFqAIK9f+D39zO31ajJPQ9BAa/f4=;
        b=dvEO491fdSUdewp7myCsf21rkdVkTWukmh3hKtoKJ9xB7cYt/YCV4RwoPgaKTqWKvZ
         B3WRVbYzaN37S65QJLU0ctGqRdPYFQdLElFwjbFyHLR+Jp8A+aRjZXaQMbo8rmiJHTRh
         DeBvHGg+z4fF8r4oYIKL9oKeZTqJ69Df8S3QxyPp8saMnVPTyNh1XbHxeb3vEpvFWXD9
         707c8mZNXbCG0X2LVMBLy/ugUWV5JKAmxzgqi9csLkoXBfTUbxpiuGaChpHNTqPSz0+w
         Rsqtn9q1DZTClfywA6TCjOd1+lkWzsiFJuvq28628sVD+192CupGBJeJ7Pj7Rf4Agej3
         t3ZQ==
X-Gm-Message-State: AOAM531qwJn7GcWTD7jdX1btkS4KijEY3ISBy5QV7m/+daqTTE125mrf
        Z0M8Ks2R7DhUv8itTyaqn1G+h3IcksOGCPRBiFo=
X-Google-Smtp-Source: ABdhPJy2Cxhgx3gizCyEQVvCKrHTTjTyzt/RcLtbi4wg3zCAAn0+pDAWx66aUEfAq4a8YxqLjO/eXooYC9aZly2XEuk=
X-Received: by 2002:a05:6e02:1152:: with SMTP id o18mr16102112ill.174.1620048329834;
 Mon, 03 May 2021 06:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <pull.944.git.1619691880696.gitgitgadget@gmail.com>
 <38083c1b-f92b-7624-67b7-3a5dcf213d79@web.de> <CAOLTT8TGaVxxHJRF_-Dq0Gnd50_H-80C6zPhjQAQruiO59qw2A@mail.gmail.com>
 <xmqqsg34a5j8.fsf@gitster.g>
In-Reply-To: <xmqqsg34a5j8.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 3 May 2021 21:25:14 +0800
Message-ID: <CAOLTT8R2-uZQ4rAs+TNKSZXzfXjjB-=unuBUykMo=taguTPw7A@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] ref-filter: add %(notes) format atom
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=883=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=8810:57=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> > Note that `cat-file --batch` should be a superset of `ref-filter` and
> > `--pretty`, because
> > it supports all objects, while `ref-filter` only supports "commit" and
> > "tag" two kinds
> > of objects, and `--pretty` only supports "commit" one kind of object.
>
> What?  A ref can point at any kind of objects, not necessarily
> commits and tags.  %(objectname), %(objecttype), etc. obviously
> are applicable to any type of object.
>

Thanks for correcting. I only saw tag and commit in the output
of `git for-each-ref` before, and blob and tree are not processed
in `grab_values` in `ref-filter.c`, which deepens my illusion.
`git update-ref` can make a ref point to a blob object or tree object,
although I don't know what these refs are used for... A reference to a
commit object makes sense, but if it is a blob, are there any suitable
scenarios?

> Another thing worth noting is that ref-filter needs to deal with
> traits that are not tied to any particular object, but to the ref
> itself, like who its upstream is and where it would be pushed to.
>

Indeed need to be considered "%(push)" "%(remote)" will change
"refname".

> > So it may be reasonable to provide `%(notes)` to "commit","tag"
> > objects in `cat-file --batch`
> > in the future, now integrate them into ref-filter firstly.
>
> And you can attach notes to objects of any type, not limited to
> commits and tags.
>
> >> >     So in this patch, I tried to migrate --pretty=3D%N to --format=
=3D%(notes).
>
> What do you mean by "migrate"?  Are you making both available?
>

Well, here are some incorrect statements, I just want to express that
the `--format=3D"%(notes)"` implemented in "ref-filter" has the same semant=
ics
as "--pretty=3D%N".

> >> > diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-=
for-each-ref.txt
> >> > index 2ae2478de706..07f037a16e13 100644
> >> > --- a/Documentation/git-for-each-ref.txt
> >> > +++ b/Documentation/git-for-each-ref.txt
> >> > @@ -139,6 +139,9 @@ deltabase::
> >> >       given object, if it is stored as a delta.  Otherwise it
> >> >       expands to the null object name (all zeroes).
> >> >
> >> > +notes::
> >> > +     The notes associated with the ref.
>
> "The notes associated with the object pointed at by the ref".
>
> A note is never associated with a ref.  It can only associated with
> an object.
>

Indeed.

> If we are going to have %(notes), it may be natural to desire
> grabbing notes for the given object from specified notes ref, e.g.
>
>     git for-each-ref --format=3D"%(notes:amlog) %(subject)" zh/pretty-dat=
e-human
>
> may want to give the same kind of information as
>
>     git show -s --format=3D'%N %s' --notes=3Damlog zh/pretty-date-human
>
> The underlying notes machinery however may not be prepared to work
> with more than one notes tree at the same time, so
>
>     git for-each-ref --format=3D"%(notes) %(subject)" --notes=3Damlog zh/=
pretty-date-human
>
> might be a better syntax, as --format=3D"%(notes:X) %(notes:Y)" may
> not be something you can easily support.
>

Here is a "bad" idea that might support this feature: use another subproces=
s
"git notes --refs=3Drefs/notes/amlog" :)

Thanks.
--
ZheNing Hu
