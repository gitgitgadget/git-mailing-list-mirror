Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162D0C43331
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE1126146D
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376679AbhCDAWZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842736AbhCCILP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 03:11:15 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B954DC061756
        for <git@vger.kernel.org>; Tue,  2 Mar 2021 23:36:00 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id w65so1393864oie.7
        for <git@vger.kernel.org>; Tue, 02 Mar 2021 23:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=As/l0MeUXW6jGRKruS98oScp5fewA8LOo8h4hl1TeB8=;
        b=h34C2TYY6QDKLPn7JmawGjbTmVp4CkAFowsUC5FCN3yeUcfu1opmdHa3dJw9zDGX1I
         Q9Ay5WbdVnP//zMZ4/L+pLfQZLFGxA+6FPjjnGhWMQMPxvXID133/VDe9h5cjYrUmsEd
         Hx5g4vHNNJ3o8myjBGfV0LTiHCg+xsKIi3/7eqg7LjqQXHa1jmw2KqBVLIrtZ2g81bwN
         pWCALxyY7UQqELjWE8Dks+NaMv6+j6hyqC2vod6O++CFIeQ76icVS2HNE984BMozdypX
         Iz24ewncIgg05juNxi6wmVadXR9jCd2GUC8TQK3bygho4GPwGuZzGezH0q3bKouCmYdo
         4tVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=As/l0MeUXW6jGRKruS98oScp5fewA8LOo8h4hl1TeB8=;
        b=n/QTtNj40rASFfKCH4/EcD+rA+mEVhES0MEN74Wh7GW7sKQZEsTiTVCrHLoSBoBB2W
         cEysNfObdDsShy0lgXsLcQKgpd4MhnyukICTX3nSicoSodE+u8i/PshF0Fc27lUPhDnP
         3GcgHRlIxByp4Pa/5q4r91nDCrSKUo7VE3H1JB235JT0IkCnHxIQSVIJouJhFQp/Kjdw
         G0AAaAmd5oFTfSfwKFfU7MTuecI+d/HX0ZE3evCGrAB19qR3EOhgsL8WjMtNfhuOA8qj
         OEuvzdKE0y7aqOY/hozmSaeZwakXpkCOCslPgaZeCNrvLLAKEBCmjl52Nw0BKd/FwBP8
         oaHQ==
X-Gm-Message-State: AOAM5302sM8ibdTNgTOb8hqfi44nVs9pyEq6jj+uxioL4mPF0QCYkw6G
        15ua4ECx0uhlRIff2sb8M/c6KLxS4KO30Pu/es4=
X-Google-Smtp-Source: ABdhPJz6jYG2nuDUJv5Di03kCpJI+J9jgF9tz/AQqMoBPnYbBUUSgZyGLOTYsZhZ8HMFC/G9fcYKvlEPB+MjcONr7yI=
X-Received: by 2002:aca:a809:: with SMTP id r9mr6140632oie.163.1614756960109;
 Tue, 02 Mar 2021 23:36:00 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210301084512.27170-2-charvi077@gmail.com>
 <CAPig+cSaZ+i+2P0x67BiHLxAGZaggNFK=dHxLJkmOfY8uafS5g@mail.gmail.com>
In-Reply-To: <CAPig+cSaZ+i+2P0x67BiHLxAGZaggNFK=dHxLJkmOfY8uafS5g@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Wed, 3 Mar 2021 13:05:49 +0530
Message-ID: <CAPSFM5eqspjRbQa-i+W5q+NkggaSuBhYVqu6uQrU1KBMxh1Ceg@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] sequencer: export subject_length()
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     20210217072904.16257-1-charvi077@gmail.com,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2 Mar 2021 at 01:55, Eric Sunshine <sunshine@sunshineco.com> wrote:

> Now that this function is public, is the name too generic? Most other
> functions in this header have "commit" in the name. So,
> commit_subject_length() might be one possibility (assuming the current
> name is too generic).

Agree, I will change it and update the patch. Thanks for this fix.
