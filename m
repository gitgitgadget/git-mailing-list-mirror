Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F188C4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 14:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50A1323120
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 14:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgLEOCW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 09:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgLEM6x (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 07:58:53 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33AEC0613D1
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 03:46:11 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id r5so8582998eda.12
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 03:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SMEKiADwWQxiVITR00zeBMGUlEmLCHv2H1IIc9QUlx8=;
        b=UwbJUda3tAG6A3rcwTtw2PLF5y6LTV7PZFE8gBhbq5wWE4/xw+M/+sl8KicrMI8Jft
         RnTfjfyElaH00Yy6Xb2fk+SiNIJs5IR2Z292FPHGs8byKwAHHakNzGxJW+HHMVQo/LIU
         iXBVqG02B3EpIu6i3gcTFQrM2ytjMvPYksK9yBdJg8tIViM5twBWOMGt/KCtV+VfGMMN
         7d3bIz9nzC8f1NxnX/rpvQ3apT3CSVRgPgKiey5TCHLkFjAMr2RzmjfiX9cpitGrl92F
         t43vmdtdGs/CEd2V3A6X8IkOdXRS1eWRG1Y33at5SP9/TgqsFuOisGIrlyvdo8O3XKqx
         U6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMEKiADwWQxiVITR00zeBMGUlEmLCHv2H1IIc9QUlx8=;
        b=UBG9Jl7RngOKUtbxgOItoZRMkHAE4mcSjY6AX1IIqZCwI648pl6nvORJXUyeTuwfXd
         y+ogqw9iUYwL1bBfp7Qrx5GVWAOu+73Li6eUwbOl4UGnmN0pDp9DFFUySYgZcZBfZfRC
         qqJlijQ8oUiBarCFIXRJadGFYObruHHAo3pYMh2tROgVOV5k5SDyT+Vai5m3UtMmNSih
         RCfQlA7cCNBnN3gpHDh7rKZxjKAOI/5Kci962KE3T8tkPxEuTDTw6duyfvGYqtxpRl3T
         NGJJ74WtslwUZKldYScx6dU0DvZWq6T+wDSP33LW1CG3udRZ+TazOtnK+UNGqFMxo3Cc
         ejJQ==
X-Gm-Message-State: AOAM5339VpLnDQ4CqdfYsQnVrtkKXZMiNwtHk7yii3SDEnVVS3/NSCqv
        njqJ8jo7SBK5S0rjs4/uXtFCmMXUvf8bXxFl3A4=
X-Google-Smtp-Source: ABdhPJwqF4d6vLd5pxFwazQJkVhpI1bX2pq/xOa1VwFwArDqZGAu/PoAjnmsZ26xC0eYvOGTHTilhfFYmXcLMAmCjlg=
X-Received: by 2002:a50:8744:: with SMTP id 4mr588401edv.362.1607168770375;
 Sat, 05 Dec 2020 03:46:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604521275.git.matheus.bernardino@usp.br> <8ce20f1031172bd6821392a562a3ecac65c6bc84.1604521275.git.matheus.bernardino@usp.br>
In-Reply-To: <8ce20f1031172bd6821392a562a3ecac65c6bc84.1604521275.git.matheus.bernardino@usp.br>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 5 Dec 2020 12:45:59 +0100
Message-ID: <CAP8UFD2v1JrWm7o7yx9FPf0mj+b_PZGJJn9uyBeWR4SLNMoWxg@mail.gmail.com>
Subject: Re: [PATCH v4 03/19] convert: add get_stream_filter_ca() variant
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 4, 2020 at 9:33 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:

> -struct stream_filter *get_stream_filter(const struct index_state *istate,
> -                                       const char *path,
> -                                       const struct object_id *oid)
> +struct stream_filter *get_stream_filter_ca(const struct conv_attrs *ca,
> +                                          const struct object_id *oid)

Nice that the `path` argument could be removed here.
