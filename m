Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D22DC433E6
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 11:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01B0A21D7F
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 11:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbhAKLS1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 06:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729472AbhAKLS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 06:18:27 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C097C061786
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 03:17:46 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id n26so24149251eju.6
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 03:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tcoFT5zC5ngJgwxXNTFHyXwn7MXI8HhQLoP4m9isFVo=;
        b=IGyNI+XDgVy+bHpwT7q315y1VVV0vU5jBSnCPP/UWVC9QbCTgtmc7m/WMRTpKoF9/o
         /e9TXnAXObzQ1zxrhANL6YKok9rawvqQlBNTzWGXEgr1lVynCukeXgUlhNgSmcamHiKP
         z9RoUe4x7Uvuo+7uSzb+H0VxxudQ8uuMy0xz3L10R0NBU50ebNb5CECdpaWN4S926ML1
         WMk8p1K23uGPnGrQxU4aPDlKIMjdjm0LmKwypDioyrFoZNNhLFyINJjEX6dUkH7Rue1N
         UwXxu/L4WCMpekWfNJe1Mnqpb+Nx6E5Ojkq3JfanJrsMdrrx9nTHsP3DdZfZV0tal/5I
         6EDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tcoFT5zC5ngJgwxXNTFHyXwn7MXI8HhQLoP4m9isFVo=;
        b=GgiRPgHg+cvtjWioKYA5WLFqsEQiKAYCgJH2AXV4Rg4lW4phoT678mGeBpq4LMi7rD
         bAB4hNNGlT/GctYE7Mi4TjbgF5jS49ZWV2I2dDzUQSzSTlgKwI/H3aocXqJlWs/IcgdE
         WRSc/zjuW97QdnskT1j6zohiM6+61R3vGjAZCapvpMwLdzsi4gZs4NYSVYbTwpJzWs1/
         kdQy6UCluHpYbsulkiSc+5giIAL3/l6ZFS+DEPo890WX1/iy083AkETViEHNOl5xkB4I
         tQdaKnTf+xQV3EO2/VaSYFw3zPak1Z7pED0rW9xKrCSMlj5heRJcgUj/rXMatCgDUtRm
         wsMQ==
X-Gm-Message-State: AOAM5331S6PSH1HXca2Y/pIp1onYKC935ONzhiwrHLW9ych+2P58q9Bk
        fBqOVKzVM9xWsIzKOypUC1WZxEmrVIvFsbY9x75yUSFsLkM=
X-Google-Smtp-Source: ABdhPJwM9GwnmSToRiA7MADuWy/KfrvZa17bqaadjvbUNPWS/9LdSBTEIl6qa2cUOXKcjDJyyRJW3ChB4p19vZGyiko=
X-Received: by 2002:a17:906:d209:: with SMTP id w9mr10239961ejz.211.1610363865396;
 Mon, 11 Jan 2021 03:17:45 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610027375.git.ps@pks.im> <cover.1610362744.git.ps@pks.im> <a19762690eb7f9957ac31d73e110f0103aeb2307.1610362744.git.ps@pks.im>
In-Reply-To: <a19762690eb7f9957ac31d73e110f0103aeb2307.1610362744.git.ps@pks.im>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 11 Jan 2021 12:17:34 +0100
Message-ID: <CAP8UFD1MhbGr7pBbF-TEBpry-0ocUWLgWO2F0GobfeR0b88qdg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] fetch: use strbuf to format FETCH_HEAD updates
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 11, 2021 at 12:05 PM Patrick Steinhardt <ps@pks.im> wrote:
>
> This commit refactors `append_fetch_head()` to use a `struct strbuf` for
> formatting the update which we're about to append to the FETCH_HEAD
> file. While the refactoring doesn't have much of a benefit right now, it
> servers as a preparatory step to implement atomic fetches where we need

s/servers/serves/

> to buffer all updates to FETCH_HEAD and only flush them out if all
> reference updates succeeded.
