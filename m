Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC04BC433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 06:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C2F26127C
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 06:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhDTGFv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 02:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhDTGFu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 02:05:50 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B5BC061763
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 23:05:19 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id z14so3851770ioc.12
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 23:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L9G9ShGUltwOcggTb/1lPLjrh56j8jR+f7ged4EZvKQ=;
        b=OM3TyqFlIyp2WNJZIIFm/8oNEP+MDSFCXs/P+G5UBv8QvxD8z1sCz3G4J/A8jLQqtQ
         1KPrpTsGgEupr506w1xyTUpC8TCsALaFsCxGiidG5zihVGi6rqVTNUBzlsGBJsbE7Phe
         +QLecv8lb8Q8z4HS9M3SpaBJCxZd9UGKsQjjl48De5DSOa/kT7VyVJ/qr/JszYagov4d
         eaAl09kpqABJh3B8k8CojayqyE9VNqEzkGc2VWskQkd5UVDeZyIEqaziQ9/qyvyve3Qq
         DHad/EGZubZGYxVCQ+WTj0iM2AMy0G2GpF+1GdqD2U2KYHUJzSq2zZF0NBrdYZBZLqz7
         Yw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L9G9ShGUltwOcggTb/1lPLjrh56j8jR+f7ged4EZvKQ=;
        b=C6h7o/vNxwrLwfMm6Djz9NNyi5f7vcpG6ikhiqUWJe94gmKj5e4XI3KtTUQeTwzcF4
         NO2IHK/b1NM/zFSOlI3XMwonAAoYpC6iyQ+zRYfMuUDsovsfisYE/PYQk/29vKLg0Yz+
         RQhMTMHl3Ewolqc31DfPRJdcsLtlfYXmiUWXzgX8zRunjNXW4Iu13Q9jNTLCbi9X9/U/
         RgFc5URIoUlKz/u66VbtUwVrBCJkLypoIPY2LJtjtan/d5E3PJC54+tKAwMlRATqQiGY
         QvbR+EMhr/SNTbS/gHnKOX8COHYuEvD2Kkco2N0Prlt1NPWcdVPUyQxsqVUy2pRGZuXI
         Wz8Q==
X-Gm-Message-State: AOAM5306SFG30sSkUEwgQoixkYEdQ4GsReysNzkak5C1yrzVCdYXFA//
        a2Oz2kEP4CeKiNnhIiuwA8h9TTZ4G2Bf0mewgZk=
X-Google-Smtp-Source: ABdhPJxV9JohvkCgmlxO8wQ5zexc3EFOR66iQJPN4O6drFAwMR9tIFZIWpGyH7E4g73PlmQgO6seOOyiMDuU2aCt3yE=
X-Received: by 2002:a02:708e:: with SMTP id f136mr11384205jac.50.1618898718957;
 Mon, 19 Apr 2021 23:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.935.git.1618831726.gitgitgadget@gmail.com>
 <1c7a69ba072ac740273ef06972122f74cf3fa684.1618831726.git.gitgitgadget@gmail.com>
 <xmqq7dky9ear.fsf@gitster.g>
In-Reply-To: <xmqq7dky9ear.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 20 Apr 2021 14:05:07 +0800
Message-ID: <CAOLTT8SDv6bFOdqu6f_=QWPrQtbyFp_XYFkdRmONg4tJ7C=fAA@mail.gmail.com>
Subject: Re: [PATCH 2/2] [GSOC] ref-filter: reuse output buffer
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8820=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=885:04=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > diff --git a/builtin/branch.c b/builtin/branch.c
> > index bcc00bcf182d..00081de1aed8 100644
> > --- a/builtin/branch.c
> > +++ b/builtin/branch.c
> > @@ -411,6 +411,8 @@ static void print_ref_list(struct ref_filter *filte=
r, struct ref_sorting *sortin
> >  {
> >       int i;
> >       struct ref_array array;
> > +     struct strbuf out =3D STRBUF_INIT;
> > +     struct strbuf err =3D STRBUF_INIT;
> >       int maxwidth =3D 0;
> >       const char *remote_prefix =3D "";
> >       char *to_free =3D NULL;
> > @@ -440,8 +442,7 @@ static void print_ref_list(struct ref_filter *filte=
r, struct ref_sorting *sortin
> >       ref_array_sort(sorting, &array);
> >
> >       for (i =3D 0; i < array.nr; i++) {
> > -             struct strbuf out =3D STRBUF_INIT;
> > -             struct strbuf err =3D STRBUF_INIT;
> > +             strbuf_reset(&out);
> >               if (format_ref_array_item(array.items[i], format, &out, &=
err))
> >                       die("%s", err.buf);
>
> This change relies on the fact that format_ref_array_item() will
> never touch error when it returns 0 (success); otherwise, we'd end
> up accumulating err from multiple calls to it in the loop until it
> returns non-zero (failure), at which point we emit a single "fatal:"
> prefix to show multiple error messages.  Which leans me ...
>
> > @@ -452,10 +453,10 @@ static void print_ref_list(struct ref_filter *fil=
ter, struct ref_sorting *sortin
> >                       fwrite(out.buf, 1, out.len, stdout);
> >                       putchar('\n');
> >               }
> > -             strbuf_release(&err);
> > -             strbuf_release(&out);
> >       }
> >
> > +     strbuf_release(&err);
> > +     strbuf_release(&out);
>
> ... to suspect that the _release() of err will always be a no-op.
>

Yes, it's a no-op to _release(&err) In the present situation.

> It may be easier to follow if err is _reset() always where out is
> _reset(), from code cleanliness's perspective.  Then nobody has to
> wonder why we do not reset err inside loop even though we release
> at the end.
>
> It also is OK to document more clearly that we assume that the loop
> will not exit without calling die() when err is not empty.  If we
> take that route, we may want to drop _release(&err) at the end.
>
> I do not know which of the two is better, but the code presented
> which is halfway between these two does not quite look easy to
> reason about.
>

Ren=C3=A9 Scharfe mention that it make leaks checking harder if we without
releasing this err. So on balance, adding err's _reset() in the loop seems
like a viable option. The change in performance will also be minimal too.

Even though we're using _release() in the loop in v1, and then Peff think t=
hat
we don't need to _release() err, but code cleanness wasn't a concern
at the time.

So I'll add _reset() to the loop in the next iteration.

> Thanks.
>

Thanks.
--
ZheNing Hu
