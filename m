Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B86C433FE
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 00:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 535B423358
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 00:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437880AbgLLAou (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 19:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437824AbgLLAoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 19:44:25 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19BBC0613CF
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 16:43:44 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c198so8917348wmd.0
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 16:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GCF8pAynRCY/bWFLZ1L1AWAd4d0F00Ta5gWTZ0wXTl0=;
        b=bqB6TF1r4tQWWlLQ/DtTrD11UZ0kCdDeItmSky4K+TUEIAuO6PjnBsJCCCLsbp8ZoR
         J6LpXwbu5XZVJNGuuvFkviUmRaIR/ZS1YN5+kWsr28Az5o7Vyd9mEqx6wgNdOgAVhljN
         RQmY27HxOhD6RJscM2M6GH3uR5RI0oKO33wPZ85j78gRl6AUbVpSogNm+4NdyJgInSKd
         uKhaGbFHMzFBDo5pZ3YQyTQCUHPyCONUOVJd2ZfWu5BpjeOPNrDZlkh/+zsLWlZYPjP1
         zYcNYqI2Mm+w7bYRp1PiQdzb927nfiCkjNpnjJS1N/19HshZUJ2t3eaAVTcHeSe7cjZT
         chbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GCF8pAynRCY/bWFLZ1L1AWAd4d0F00Ta5gWTZ0wXTl0=;
        b=AndRVBdQRjh8RQKQn7epKJE0LkrgshBSbSIEW6bMp1dbbj9Nlxldmyb8r2Yh9bQsZx
         oNYyO+P/VdVGl1MJdfXZVE80x1rCPIg2y38TyFXX0+/qPlboLeVH89Wg6sCITTH3h9lQ
         9PaI5bpq5h01QnlylIVOL+777FK1KKdOZvN1qkpclUHoqUI50hl+6arOr2rPMPxVFOnC
         bVS2sN7ISunhFJDOuQCAAJ9tVWcOGTrOvA6jwfVwL5K5OnTsnKB5bByp1HhSvWHXyJXm
         xDrZvgAeL4KaTMekCsA85M9IjoBJ5c5hpEiZdWhd0J2CoqIrw9a7KzHCehkXxlpQDV1Y
         ZREQ==
X-Gm-Message-State: AOAM530aD59W+gzyJCPgJTRtjrAbZqxi/L/wLBqFclmXdzKuiFscVCxZ
        /IHpOTsS9Qll7lKKRzZBRcd66YCvvfZU9xcjpB0=
X-Google-Smtp-Source: ABdhPJzm0NIzEmVQ4hrhb6DQQpUuQST5o69djzFrsRYpRqpsR05HywXuG3Vi6IPI2tFhg46c651hzHqkAO6PNHRItFU=
X-Received: by 2002:a05:600c:210e:: with SMTP id u14mr16354354wml.48.1607733823568;
 Fri, 11 Dec 2020 16:43:43 -0800 (PST)
MIME-Version: 1.0
References: <xmqqpn3j4ved.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2012091502000.25979@tvgsbejvaqbjf.bet>
 <xmqqk0tq1xf3.fsf@gitster.c.googlers.com> <20201210152715.GQ52960@mit.edu>
 <xmqqim99wm61.fsf@gitster.c.googlers.com> <CAMP44s2Po25VyHs-xQG0_oKhAOvPK_PNu5edQkYYsScZeBw1nw@mail.gmail.com>
 <xmqqim98inml.fsf@gitster.c.googlers.com> <20201211220938.GB575698@mit.edu>
In-Reply-To: <20201211220938.GB575698@mit.edu>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 11 Dec 2020 18:43:32 -0600
Message-ID: <CAMP44s2Hj7HbuyfkHfMUQiW-yS1W_xfS0JKGiEt5nxcJx1TKkw@mail.gmail.com>
Subject: Re: fc/pull-merge-rebase, was Re: What's cooking in git.git (Dec
 2020, #01; Tue, 8)
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 11, 2020 at 4:09 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:

> So if we think it is going to make things better going forward, I for
> one am very willing to deal with any short-term pain associated with
> changes here.

My proposal is that eventually:

  git pull --no-rebase -> git pull --merge
  git pull --ff-only -> git pull

I think that would even be easier on the fingers for you.

-- 
Felipe Contreras
