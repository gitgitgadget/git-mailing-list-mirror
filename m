Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 442491F404
	for <e@80x24.org>; Mon, 26 Mar 2018 20:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbeCZUjN (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 16:39:13 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:41780 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbeCZUjM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 16:39:12 -0400
Received: by mail-yw0-f178.google.com with SMTP id u15so6557884ywg.8
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 13:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=693E5JAaok7+e/68KABC+w7I1vWVhG2jK9/d6PG8v4U=;
        b=VC5O1BuGGqH/b8ZKTVVe8uPwEU82aUzbZzRn8qqMtXPb3xtj3mTfSqb/AP856TdfCt
         Mctrss9gN1em4QRglO8FC8fyFws3cDvbzPpntCTmk2yJCAW2weDORdwTErWrRXDHGGtT
         P+dR7JzzR4GNM/yaTTemCg5CYNGUNlBJKeuB7lQPksJx4wLP5UL+b77ulY08Xg6REiCH
         LmTcZ7BW6fhyyEWZoK486lJxMLsXba1Q/tWvUXRmkuvdC9b0+n80Ua25Eqj0ieA3dYp5
         IAsbUiKkyYvKvAuOX2mdow3mTkATLvzDS/IUQLvX11AMfN+wvUlsDIJh13Oh47Lkx77y
         92bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=693E5JAaok7+e/68KABC+w7I1vWVhG2jK9/d6PG8v4U=;
        b=Kan2GLjMrLEwmrqcOPCGnCM2eJvpICr8cQRIgvBw9jCIlJyW9ds6GCiHs0hiUSQGXZ
         tYGni/Zdla0t357e9EeNi+ov+DHToHGo/eyZrIBFBS5YGRDjYae2L2eUJP8GvSjz93Et
         A2rHUDatE6XpmqJGZfrcLKpet/akUOpvPe86uUtK8whAob79Ujw3uKuyYlw6VmhvRLyF
         RmyF6XQf1AmZq8eWRHIbYoBtLE9kbfH+3yFzqQ0VnbdKRrNQjst4wKIMnmLIvbz2FCib
         Qx+Ehamh7UzgY2rarDNFyUUnjDagGdSsAPzXSVUSM7DJOJHLnCqmygOemYkDAxq8TvMu
         4inA==
X-Gm-Message-State: AElRT7HfMLfHaRHIMGOmoCgHq6p+NOCDJKWfi2JddUdlxS6GjAWOg5DO
        hUVSXfmFM47rQ5WKOwkQuCgchL3ztQovXSllMVV+1A==
X-Google-Smtp-Source: AG47ELspeMnMYMSM2NlHXGu30jRTnSiA4tVW48kQGp/oJSw8CwnxKYWd/KPyTb/uhx8mTj0L6R77Bnpg1KZWkPANg3k=
X-Received: by 10.13.208.199 with SMTP id s190mr15249072ywd.33.1522096751769;
 Mon, 26 Mar 2018 13:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180308114232.10508-1-pclouds@gmail.com> <20180316183200.31014-1-pclouds@gmail.com>
 <20180316183200.31014-7-pclouds@gmail.com>
In-Reply-To: <20180316183200.31014-7-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Mar 2018 20:39:01 +0000
Message-ID: <CAGZ79kamsRrqZ09BtUZPdQEKXNn9X3CphsmUdoqsKv-T=kGSsg@mail.gmail.com>
Subject: Re: [PATCH v4 06/11] pack-objects: move in_pack out of struct object_entry
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Wong <e@80x24.org>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

sorry for the late review, as I am pointed here indirectly via
https://public-inbox.org/git/xmqqy3iebpsw.fsf@gitster-ct.c.googlers.com/

On Fri, Mar 16, 2018 at 11:33 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com>
wrote:

> +LIMITATIONS
> +-----------
> +
> +This command could only handle 16384 existing pack files at a time.

s/could/can/ ?

> @@ -3191,6 +3200,9 @@ int cmd_pack_objects(int argc, const char **argv,
const char *prefix)
>                  }
>          }

> +       /* make sure IN_PACK(0) return NULL */

I was confused for a while staring at this comment, /s/0/NULL/
would have helped me.

> +static inline unsigned int oe_add_pack(struct packing_data *pack,
> +                                      struct packed_git *p)
> +{
> +       if (pack->in_pack_count >=3D (1 << OE_IN_PACK_BITS))
> +               die(_("too many packs to handle in one go. "
> +                     "Please add .keep files to exclude\n"
> +                     "some pack files and keep the number "
> +                     "of non-kept files below %d."),
> +                   1 << OE_IN_PACK_BITS);

The packs are indexed 0..N-1, so we can actually handle N
packs I presume. But if we actually have N, then we'd run the

   /* make sure IN_PACK(0) return NULL */
   oe_add_pack(.., NULL);

as N+1, hence the user can only do N-1 ?

Oh wait! the code below makes me think we index from 1..N,
treating index 0 special as uninitialized? So we actually can only
store N-1 ?


> +       if (p) {
> +               if (p->index > 0)

s/>/!=3D/ ?

The new index variable is only used in these three
inlined header functions, and in_pack_count is strictly
positive, so index as well as in_pack_count could be made
unsigned?

Given that oe_add_pack returns an unsigned, I would actually
prefer to have in_pack_count an unsigned as well.

> +                       die("BUG: this packed is already indexed");
> +               p->index =3D pack->in_pack_count;
> +       }
> +       pack->in_pack[pack->in_pack_count] =3D p;
> +       return pack->in_pack_count++;
> +}
> +
> +static inline struct packed_git *oe_in_pack(const struct packing_data
*pack,
> +                                           const struct object_entry *e)
> +{
> +       return pack->in_pack[e->in_pack_idx];
> +
> +}

extra new line after return?

> +static inline void oe_set_in_pack(struct object_entry *e,
> +                                 struct packed_git *p)
> +{
> +       if (p->index <=3D 0)
> +               die("BUG: found_pack should be NULL "
> +                   "instead of having non-positive index");

Do we also want to guard against
     p->index > (1 << OE_IN_PACK_BITS)
here? Also there is a BUG() macro, that would be better
as it reports line file/number, but we cannot use it here as
it is a header inline.
