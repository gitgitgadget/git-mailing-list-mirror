Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFB1E20248
	for <e@80x24.org>; Wed, 20 Mar 2019 01:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfCTBuj (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 21:50:39 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:36079 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfCTBuj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 21:50:39 -0400
Received: by mail-it1-f195.google.com with SMTP id h9so8016072itl.1
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 18:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oUFByi2rcsyia6evr+yqvq9sWKo92Q5Qe7R/6vAtoqg=;
        b=fO8usQt3FTIS9qMmYPep0xHbS2ar7Z7W5yl74TmmW1wAtjC3L16BD6bKFRYHf7RSnw
         IFStnk6nAqmeXLXSQuBTfuO9UyTSGU3i4cWLq4cHuU94Q0zBWQ3l4G/dXyezAcR1BqFl
         yXMlYxY7Jg1CpSGlNP5LfESXHxQiwfxgD7z/hp+UdmqnNDeelhRmV/ijIVQW+haq2TzE
         qNmExXuze5LwewpK4a4lrQMClgWY9FcU0K9lglOpzr1Rode00tJ4wMl4VIiYL0NkDfvJ
         93oM569f/rcH911NwtEB+rVQ+qR8nj2xGUDa1bMu2jOsjzXmiRtupN4tsMgFKVCMVZKU
         203Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oUFByi2rcsyia6evr+yqvq9sWKo92Q5Qe7R/6vAtoqg=;
        b=EYepsuOcqxYhtukHLCX8Ehxo6Dw8QGfvihOJu63Xf1i0aoAaDb9cy6ntP3wMq3rVxV
         a+JonCFE1q3l7YQLTE/3/xE1WnENsE3JxcQJPTGK0rx3cKVRP0SXeWdLWzzA8Vxz6V1H
         8NFHmOmkehd4Opzx89fQl0gp5ieFTbUPofaVQDoMgdGKQHKb5lK0KNvoGanhcxX9tCRF
         kaMyAr0YCoQSpMMiCJTyH4iBYq7qYzpnD/fTd6gqldQP91EmNweIC5HR2z9gQW+xeyS3
         u2zI9dTGtDy+/PYSm/A0MYTEkqm1yv3a0x6YyxD8J5xq9+VnJ8ACRgs3kPDrDwM+2jao
         Iniw==
X-Gm-Message-State: APjAAAW/xgTl5RXObvBJ/J1nXz2T2LAN4sH9dyZWC7gSA8le23bC+CFt
        g6cz5TlAv8G3nBQaMsZ1gBzvotOW6kMAlSNs/D0njQ==
X-Google-Smtp-Source: APXvYqw2Y8+TUBq61Rsup1o4ceuTihziaMskXMtRnyOIp3vfw3IpIVcEuOCQ1vGaA1xlNYtVIkOf0/v8kHE8mkXntAc=
X-Received: by 2002:a24:7542:: with SMTP id y63mr3359012itc.70.1553046638598;
 Tue, 19 Mar 2019 18:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190319190317.6632-1-phillip.wood123@gmail.com> <20190319190317.6632-2-phillip.wood123@gmail.com>
In-Reply-To: <20190319190317.6632-2-phillip.wood123@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 20 Mar 2019 08:50:12 +0700
Message-ID: <CACsJy8CRN1NUD1DdKXkOoaYqCU_RJU56ph=eBAGSS-EXMAcmww@mail.gmail.com>
Subject: Re: [RFC PATCH 01/11] sequencer: always discard index after checkout
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 20, 2019 at 2:04 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>     It would perhaps be better to pass around the_index rather than
>     the_repository

Not by a large margin. For sequencer.c most operations require more
than just the index and passing 'struct repository *' around has been
the norm. And as soon as you need to load the index back (not sure if
you should do it here btw, after discard_index, since we have the
index loaded before) you need 'struct repository' not 'struct
index_state'.

>  builtin/rebase--interactive.c |  2 +-
>  sequencer.c                   | 27 +++++++++++++++++----------
>  sequencer.h                   |  3 ++-
>  3 files changed, 20 insertions(+), 12 deletions(-)
-- 
Duy
