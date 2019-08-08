Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D5691F731
	for <e@80x24.org>; Thu,  8 Aug 2019 14:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfHHOcU (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 10:32:20 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37441 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfHHOcU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 10:32:20 -0400
Received: by mail-ot1-f65.google.com with SMTP id s20so53877320otp.4
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 07:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qIRl1N+lb/IhPyrOQjaRxJLTiiwZuHodeSOxxkgfr3U=;
        b=f6c+0GxuMfflZwQjWyRQTH++B5sX1c0dM1iacWr+0vicwlrYWplgqJ+PEy54psNoZD
         +NKfNFi+mogXHXTeE1w8D6wCqa8pKD1A1Y7DA4gfUOVruu98Bhg46TZMWU4eNt+y0Y3G
         zqkOWPokvcyHqdldGh4W+D+S1KGG116zdHMjIRr2LbF/EwLsiqmOQksYtbPdXBBjC7BQ
         ythkDVUb6+6aDJqxgs3bRdy+oXAxGgVhI596jnp3ofYj3LSep7coO6vtSTAsJ8TRdrFC
         0VLoXLtyaDr+1ZNGGgbg4a0qoMEOa/dgUaWvgYr4yU7EWLte+qCY91vJL5omMW60VFq4
         yD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qIRl1N+lb/IhPyrOQjaRxJLTiiwZuHodeSOxxkgfr3U=;
        b=tJEf7eDsPWB1x/A/hSOVDpB5O5hWsQCB9yuKF7BKQ3c8TZbWA/B3Cy/FQRQoYpRWsp
         sbNAXOZ3w4BZxzvmZ9F14tLU+jVaPOjIK8Q+9MKwjrWGqynhAirr4oQ/6NEVMhphg4n1
         iiqP6tAlApDUfRRfUff6gQgE4pLr3WNgT2pBNb6rl46m5+vsQx29D5SvjSRMDyNPzyLp
         TrOEmD21N6OD6oFXqobud2klx9J2m6L9XmRQhIUhalnd8GEo3gQQx/AuO3BFNGtcV9PN
         kYE2yxpsEikEIej4aY7sY5cF7D4ZRgiGQcCFBSKlc88bQ/rer/kJ6xqGM6EqY5fl4VV1
         uTXQ==
X-Gm-Message-State: APjAAAW4y+IzDbymSDSth3fehmmywFcZWNKuhkCZd8WAIdR0HY40SfDP
        JYIaiWiaDJ/rLhmfmIUn6jd2irqjQv+2fLmNVH9Saw2Ah8w=
X-Google-Smtp-Source: APXvYqwZXhm5Kv+2IYMaOdwHcnXYKBBQQ2wOl6h5p/9Sd5GUH76QfeyoUTBxlQvPo4Vj8nwJYBNP207nTahUcKTbMeg=
X-Received: by 2002:a5d:968b:: with SMTP id m11mr9772471ion.16.1565274739687;
 Thu, 08 Aug 2019 07:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq36ifmg7v.fsf@gitster-ct.c.googlers.com> <20190806085014.47776-1-carenas@gmail.com>
 <20190806085014.47776-3-carenas@gmail.com> <nycvar.QRO.7.76.6.1908081556020.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1908081556020.46@tvgsbejvaqbjf.bet>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 8 Aug 2019 07:32:08 -0700
Message-ID: <CAPUEspg+04ifdjR0KyL=+MDRMUEWNBJ__bsY0Dc4mPtxbGQ-vA@mail.gmail.com>
Subject: Re: [PATCH 2/3] grep: make PCRE2 aware of custom allocator
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     gitster@pobox.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 8, 2019 at 6:57 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Tue, 6 Aug 2019, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> > Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Actually not so much suggested by me, as your patch still causes
> crashes (mine didn't):

the "equivalent" version in v4[1], that is still not on pu shouldn't,
if my hunch is correct

it also shouldn't crash if the test wouldn't be doing LC_ALL=3D"C" but
we have yet a couple of extra bugs related to that, including one[2] I
CC you on which would be nice to get validated as well.

Carlo

[1] https://public-inbox.org/git/20190807213945.10464-3-carenas@gmail.com/
[2] https://public-inbox.org/git/20190807095322.8988-1-carenas@gmail.com/
