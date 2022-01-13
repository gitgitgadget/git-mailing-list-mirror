Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB6CC433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 03:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiAMDf1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 22:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiAMDf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 22:35:27 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D245C06173F
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 19:35:27 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id v12so8725548uar.7
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 19:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=77+Jfwy4+2hDlJzTxcrd9AjHlq3V0pO/JoAar3jrUfY=;
        b=HNAhuo2g61BnAS4KkRLHB0AHVZnmreWAkRAsgwMEpUj7otp1UG4y743hz7K7Dvi7L/
         Hty13eU3to5bFmLsmCM0tvSzOF61zLAaIFrUmXRRbPHmBVLL5mx4oE69LUfob2gzv3oZ
         L/MauENA38kzlxenyq4HpitX8jfbm2ZBm4xbpks8DeOHXgbqcpu+FzNf3QQ0afU5y/1v
         xz65HHBK8a8GMTkjtfBv7zTmzW7h+2JqZGOs/L5y+viQMR4ONuxtePZE/I6SEg7tVOXu
         6kX5tJu1s5Yn0axU97ZdlLl9sRhzIVepgUwjdm94/0VpCQZFCavw1UpTkwAzN1L0z5j0
         Bylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=77+Jfwy4+2hDlJzTxcrd9AjHlq3V0pO/JoAar3jrUfY=;
        b=qVnJcIupxeHOnpWprE3lKcanGToixhh1xN9dM1mDbGTtgdaUykl6bhbfyfn8CS/jJS
         N8ujFuiazViiSi24OuJaySjBKw1074Ep04cA4YoFHU/S5z6FulCkLB1Q7Cpl9Hnpntxp
         kJQiUbLMwxHvWmprHhTvfWHT74v3KFacg4SFHCPh5EJ+hqkmFaH7BiGT6vAPO8dpqvBf
         IbFWcYH41KItNMSrPh6/f1nlqYmWb40afuAG8rZfhVDa2KPKHG34bgxgLGU4GNWP7mKu
         r2VpztRUirT05VlvRe1OV8JYQ2A6YvGL/0a2zep8zHYuHDM7H0jF8fmDP1TbNZa3gKbi
         lM+g==
X-Gm-Message-State: AOAM530HnzdS1o6VzSsPzKyi742uRgKln3t51A+Hmb/jhwTo32Ay1CNs
        mxLI/yhaIVkJGX947Z9UjfF5gH+CgU2hWRpP8x6PXHHDFitlitXI
X-Google-Smtp-Source: ABdhPJw6Pv9RDUwzDrdyNYKhvsNqvoc9+84wTeOWXjDKVvjLXXDtg+L7ECBqUbnhA4AGHPuX1iyYFoop3MYh6M0au3w=
X-Received: by 2002:a05:6102:418:: with SMTP id d24mr1551755vsq.8.1642044926242;
 Wed, 12 Jan 2022 19:35:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641440700.git.dyroneteng@gmail.com> <8dafb2b3779715aa277eb825a94af87b72f3e093.1641440700.git.dyroneteng@gmail.com>
 <220110.86ilurzcxo.gmgdl@evledraar.gmail.com> <Yd2zXOrf+4qX8VLD@nand.local> <220111.86iluqxaz9.gmgdl@evledraar.gmail.com>
In-Reply-To: <220111.86iluqxaz9.gmgdl@evledraar.gmail.com>
From:   Teng Long <dyroneteng@gmail.com>
Date:   Thu, 13 Jan 2022 11:35:15 +0800
Message-ID: <CADMgQSTpEG6iANtMZm58W81rdVfEQXiN2kpcomXCY_-Mw+g8Vg@mail.gmail.com>
Subject: Re: [PATCH v9 9/9] cocci: allow padding with `strbuf_addf()`
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, tenglong.tl@alibaba-inc.com,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 12, 2022 at 4:40 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

> Nowadays you can do this as:
>
>     git show -s --pretty=3Dreference
>
> See Documentation/SubmittingPatches
>
> I use:
>
>     $ git help reference
>     'reference' is aliased to '!git --no-pager log --pretty=3Dreference -=
1'

Make sense.
Thanks.
