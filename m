Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0265C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 05:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E41720709
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 05:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gIx7igBG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfKTFBH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 00:01:07 -0500
Received: from mail-vs1-f48.google.com ([209.85.217.48]:43700 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfKTFBH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 00:01:07 -0500
Received: by mail-vs1-f48.google.com with SMTP id b16so15980910vso.10
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 21:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h+hayhaI2HWnrJlZelAckwbmWIPHf9IgunZv4weCsF0=;
        b=gIx7igBGicHVSjR80WHLEB+4JaDVlA+MlAsOVCTNf94gz0S7tkEaJ0WuMvlyH1vS0A
         eaMjlpd0CYqyBA0IR1UEIpCE54PgEpV9vXkiKZD+LS6R67DcJ3m/ySHAfEUw/wv7ap5I
         ilXAdlHSGa/J6fpOTIhuLva8zcxtPuwF7LRo/gVxKPP7BNNhmxzcyKAr4AT2M0K7BiAU
         WcyfiEKO6bR0Ee04A17qpU0PqGPPjX+/w4X8OE42vsjns+sQISsRD9lr6F+XJHoa6MQc
         goS4v60LywfwtEd/Ij14wbqzIyvj0LOLu+LPIO74jpi8kQmsuNXCJrJkd+tphGg/YEgb
         yKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h+hayhaI2HWnrJlZelAckwbmWIPHf9IgunZv4weCsF0=;
        b=j7LGtRQgiJHAjQ9GNSXbVAJD1Ne03TUEnCfWpM1Zi1gL5krSgi9LPiTq0KYxL5fZ90
         uBR9phxFNmT0aVJYAm2LHo4DSdQNLkRj+MWVM3WwGXj7XQAbZiOj3/2th2xuTSsg1dyj
         l8kjS57psen0ERccM1/8xoCSLsV0tPwEUu5wjXZNCXhwzzxSWeqrT2t3Eovr2Ym1sCJ7
         +4BrgqIMhcsT0cPyQfnf5W1v7llmc74wmLm4Q7DNLfS8cbkA/kjxfmj8omfzbpU9vkht
         gG+XCBGaMFsYjpzrJoEDmTfo7JZlOS4DR0xkbm23uk4sIiuaEtWEMoi45ViztEkOa6hU
         9vBA==
X-Gm-Message-State: APjAAAUhhjm56BkG1mIlvnElq/sUWXw/F8+txXfyzLVE/5USEJgFvojW
        mujh0X/YOv/LdEx5cgqg9A1m0kE4mEeqNJBh8ngCGg==
X-Google-Smtp-Source: APXvYqyZ5Kvc7OvaPeMAyrlBGXGKM2ywMixBATomIIwMlA7ggw5VgqRdGVypGgF+vGpKe3VTU1A40K+gOF/ySkHFzAo=
X-Received: by 2002:a67:f98a:: with SMTP id b10mr423392vsq.203.1574226066177;
 Tue, 19 Nov 2019 21:01:06 -0800 (PST)
MIME-Version: 1.0
References: <CAFQ2z_OMr4J-gF1HXXkSQFheiDkf+7WBbn-oLYeDydmuLSfN1w@mail.gmail.com>
 <xmqqsgmjb13r.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsgmjb13r.fsf@gitster-ct.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 19 Nov 2019 21:00:54 -0800
Message-ID: <CAFQ2z_N611Y+3TXWLsOKjL=muk3XON11gaS1qyGxZUWp8Leqag@mail.gmail.com>
Subject: Re: none
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 19, 2019 at 8:53 PM Junio C Hamano <gitster@pobox.com> wrote:
> My initial impression was that the API overuses typedef.  We tend to
> avoid doing
>
>         struct _foo { ... };
>         typedef struct _foo foo;
>
> and instead write "struct foo" explicitly to make us well aware of
> what we are talking about.

Thanks, i'll have a look at changing it. I use typedef mainly for
ergonomics, but now that the code is written, I can introduce more
verbosity.

> But the set of operations defined in the header file seemed at the
> right granularity in order to interface with the refs.h & refs/* API
> we have.  It however was unclear to me how transactional ref updates
> would work with it.

Transactions have to interface with the file system. I imagine that
different libraries (libgit vs. cgit) would have different primitives
for dealing with the file system, hence I haven't implemented that
part. Do you have an idea of how I could implement it in a way that is
agnostic of libgit2 vs. cgit?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
