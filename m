Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B7FC433E0
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 00:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9B1364DD5
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 00:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhBLAUw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 19:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhBLAUt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 19:20:49 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68A4C061788
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 16:20:09 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id o12so6911147ote.12
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 16:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fXtlz8kmykXmn+qgnwU9+LTJpczp9DuMAepYZRDRQA0=;
        b=ekfrrOb4L1dIZs7zFIv+pE/uBCpAMPCFP1kS/7KiO72WYGUWc+gV3QG6fosweJB8x+
         USDKgd4O99tIKf9MeZQQeST7IKFM/NgCmwwMS+GHTbiJEHozByEoHnV1nhFpNcgnT3IC
         c/xtWAmYlBJeFrA/yZ1/StBB+FM/PyuED+PMbLKFXi+VVUeHT9xGSRxcQzldbBusl/MT
         7hlpXYERiJTQTTjU9yM96xe1kL1HKqWwUrhCFQAl1C4VlYwH20SxgBvkvxdXd21EMOUy
         elsx56xsX+RcK5+lOuhOt2xT3y9w5V/lcx7kDV8x3VS87us2/MGpRvVfV3Uyz8wvzGQh
         4CgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fXtlz8kmykXmn+qgnwU9+LTJpczp9DuMAepYZRDRQA0=;
        b=qfuDLEr1S4BxKPtjMJRVoBdYypEN5KqfEcszfqr01LtAzAoeoXq1TD5kVz8+Frq7Io
         TdIF6eb1FRIUSdfYgKPBPmZTCdkskWAuiKauDjbhCXcgx6Ps+ekJ6Sc7uqVmOpB/YESd
         LTelE0KD5uMrS7yC+omLZkbP/fPdxXBCvewiUAtBepTTzU2oZAQ193ScRRoV+Z+jCszM
         XR4p28PYJ9OO5h9xk8iSU1IVyUaf6l0Fc+ugNEvxs0PMXYvsMQC/pzPyWMVvLMwPSOQa
         kLi5Jk7EWeAnnZFb9EYy+96Fgugy7iEmJZRTi01Ng1TAAEFJyZu9WFDBI4dP9+1oS4Ay
         BW+w==
X-Gm-Message-State: AOAM5325fQ+lXa14z8CI01/6g5rRM74PHaqKjT7OIn5KP4EQ2qF/gBtJ
        zoqJZUF448OokDukMkMnYDuG2v6FjOGvAzMpa4A=
X-Google-Smtp-Source: ABdhPJwXwsjuT6kxULU//E5PtPZLc3LZX52t7KiHqRKcRAMMTys7xzxODyXnfNTu4vBbQIW71wDrlQJCiSnuSzZgjUY=
X-Received: by 2002:a9d:313:: with SMTP id 19mr364674otv.147.1613089209095;
 Thu, 11 Feb 2021 16:20:09 -0800 (PST)
MIME-Version: 1.0
References: <20210207181439.1178-1-charvi077@gmail.com> <20210210113650.19715-1-charvi077@gmail.com>
 <xmqqeehmy129.fsf@gitster.c.googlers.com> <CAPSFM5fWmTXRHKseqXwZyE6MOVccR2OPSs5kyEu-k1K1p01EPw@mail.gmail.com>
 <xmqqblcqw7ff.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqblcqw7ff.fsf@gitster.c.googlers.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Fri, 12 Feb 2021 05:49:57 +0530
Message-ID: <CAPSFM5d2FMU+ofJMPbNW0MhuEUpgurYJNHyHHSjq4h1rknHd8w@mail.gmail.com>
Subject: Re: [PATCH v3 00/11][Outreachy] Improve the 'fixup [-C | -c]' in
 interactive rebase
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 12 Feb 2021 at 04:14, Junio C Hamano <gitster@pobox.com> wrote:

> Sorry, but I do not quite understand.
>

I thought to rebase the "[WIP] Implementation of amend! commit"
that adds option to `git commit --fixup` , as discussed
earlier[1] onto cm/rebase-i.
Because cm/rebase-i branch includes the working of the
"amend!" commit upon --autosquash and also in sequencer with
command `fixup -C`. But..

> Aren't you talking about adding even more features to what is
> already there in the cm/rebase-i plus cm/rebase-i-updates topics?

..Yes, it's correct ...

> Or are you saying that what is in these two topics is still buggy
> and we need fixes to it before we can give them to the general
> public?
>
> I had an impression that it was the former, and if that is the case,
> then moving them to 'next' and then to 'master', regardless of the
> follow-up changes, would be a useful thing to do.

...Okay, I agree and will do it in this way.

Thanks and Regards,
Charvi

[1] https://lore.kernel.org/git/CAPSFM5f+cm87N5TO3V+rJvWyrcazybNb_Zu_bJZ+sBH4N4iyow@mail.gmail.com/
