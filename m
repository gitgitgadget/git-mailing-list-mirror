Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A1CC5519F
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 06:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EE172168B
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 06:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s3B4e6Hb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgKTGet (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 01:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgKTGes (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 01:34:48 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A56EC0613CF
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 22:34:48 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id u24so4440185vsl.9
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 22:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eKNhc+XhYzH2IbzebbW4ZYW/UUaheEmqX0YoGSTu9s0=;
        b=s3B4e6HbnHTKZE+7XzSx6A6Q8bfJiKjC0Xvo8aq1VBUidwAo7+m+cxl3sGbqHOI3XT
         Z8bt0BQ/z9UXBXXSw4W2rUgAj/Z7Jacp0zZaPUfvUGwBP8aGAZ3UFqkw+ixHxBvUEtny
         u3YakzzWgvlSPbpyfZKN0YzgBrmC2qJWGnoGTTf93PBkq4ED7Nxf3xTdLg9oA/RCb9uP
         j+uJjiy2bu4SNjl21u4pOKe273McDi8f2diD+8CoAyGcwYvly4dbfbDJ0JKc41vGiK8Y
         IG4VSXCJETw+3efU6KwHKCqFfI8IqJDVG6QrJNbionfwYAElqhpjhAhPGfyteCEk9HuV
         Gv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eKNhc+XhYzH2IbzebbW4ZYW/UUaheEmqX0YoGSTu9s0=;
        b=NtsN7Ou0do7v6R5FmKYsY3nnYdxD5LS0RvkrOCxBCf7wKm0ZeVoLhIPfkNJPyTxnUt
         9vQQ/Xtoco8paMvadRiQZsIqWdjqa0HCxNYG9XIFM5GH52m54akcbCas8QnGkQ7k6v2w
         2UhLp/V9LXqW5al8GpC7VNbh/y2cr1pUPJu/KFrFGgDahg5dTsr5Z4lj2rLCZQlsYSzd
         OOHYvn4VTi+ylisDSnqsEXxfbZArtq+0bqrAfn3PV73bbm0Pp+qjgHJpMjeN6ufdm62A
         dz2r+qVg2JFlmkhHnCwhuYuGq07n3GW3b9qmFBiuQfqv/f7cfD2NLFsblSRNZnvW5GEt
         8FWw==
X-Gm-Message-State: AOAM530KyGGDAtVvLAMLaYgLRL5ktfXTVG7aIgZt8tyofONtoBi6Yq2I
        N5OYJ0uJA4xBgTipfQJfo7lBkyd383NVWngjz8g=
X-Google-Smtp-Source: ABdhPJxWukM8a0fbFoA+RAScGcuvZntkmmnnL3jAhOxbqL+TmzKVgsz8Nu3iwUE3Irge6fKiXgI8QAb0CkeBhLKbiR0=
X-Received: by 2002:a67:eb49:: with SMTP id x9mr10993801vso.29.1605854087862;
 Thu, 19 Nov 2020 22:34:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605123652.git.me@ttaylorr.com> <cover.1605649533.git.me@ttaylorr.com>
In-Reply-To: <cover.1605649533.git.me@ttaylorr.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 20 Nov 2020 07:34:35 +0100
Message-ID: <CAN0heSq59uX=4pqkhc904oLfeiwF5ctiEb_9cQXYY7T1t=Mt1g@mail.gmail.com>
Subject: Re: [PATCH v2 00/24] pack-bitmap: bitmap generation improvements
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 17 Nov 2020 at 22:46, Taylor Blau <me@ttaylorr.com> wrote:
> Not very much has changed since last time, but a range-diff is below
> nonetheless. The major changes are:
>
>   - Avoid an overflow when bounds checking in the second and third
>     patches (thanks, Martin, for noticing).

FWIW, the updates to patches 2 and 3 look exactly like what I was
expecting after the discussion on v1. I have nothing to add.


Martin
