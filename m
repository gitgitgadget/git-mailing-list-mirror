Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973C9C433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 06:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FB7A2100A
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 06:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tuIrHlYU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgFRGUe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 02:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgFRGUe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 02:20:34 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9CEC06174E
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 23:20:33 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id e12so3967787eds.2
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 23:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ohR/G4QlvyU5Fkbwu5o8TNAGpsOfif+n1y/2LPKd0NY=;
        b=tuIrHlYUBpHvaI85yO1bxeAPU4mBT1zsGIjCHSGDxmGNRhKcw5138lAhMrhF4F1bCP
         Mi9Gevye6z6eMal7+m+sjpaQur1zJAgw8hJ2LH4fL97Y0Vx1hv2LN79meOBLPamfe2cs
         bZ8fIX8HS0O5nQRXP1BxO5VG/uXBHtr5wR36ij2lczfIyXpJXZwnFreKDIfcwEaeuj/u
         CP81WH5QLEa0Pax1DdF4+YKhHf4F6jnrCbmfMOMfbQiemGbNFk4XNUvk09RhX+g0n0oZ
         nBwfKhNTnCDfUz8P3h4ZZt5HCZEDYDri/FgfhHR9zJQPowNfnapqguastjGlEAGrk76p
         RrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ohR/G4QlvyU5Fkbwu5o8TNAGpsOfif+n1y/2LPKd0NY=;
        b=qmW3vxT2ifWfWp2ws/1lSRG0hmRPQQx6kPOvRgjx53FO9E3YjF8t20NRv2OTZlrtDe
         GsIcsMA2CFnr/MZQRqj334Kbm9jDBJdEMlPeBJtHf6WKbLskaLtq/gKQOM/Cy533VMGQ
         KdRICTNwDw2nJ9zuelKXuhvInB/P6wSY8yAx+I8XB0EtA5lrO9kp9ShEGjeZB5cDfcJF
         bjCkFd/xjySuL15jzpGbw9AWUubRQaKTayONti0xj+sISIQUIXnClB/2xBg3uWYDnm1T
         nmTexYIp9Jdszsm6WEmiDvpEK5A14D+xqmv7YXPlx15rKhTbjkK3k3JYnCD7Qt27uYth
         i7Tg==
X-Gm-Message-State: AOAM533onkitBAXhdGuDEoZcSftSo80VrZ7QHSI+BFqcq5XqZLPN2cv7
        yFwq5h7J75pLoSv8iN8IJ0ND2d8fsxdzu3QcCN0=
X-Google-Smtp-Source: ABdhPJzN+Rn/AJS0XeMkmbVptGiXIr5cKGkX06kFvuE2b3ZT4ZDQM72D3glxOh03lYFGEkxXUjV+BoVaRi9YzdaK9gA=
X-Received: by 2002:a50:c359:: with SMTP id q25mr2681954edb.123.1592461232437;
 Wed, 17 Jun 2020 23:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.806.git.git.1591858774.gitgitgadget@gmail.com>
 <b4cb448e8d76ae16f6fa38a773244bb4a8499938.1591858774.git.gitgitgadget@gmail.com>
 <xmqqzh97zu5k.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqzh97zu5k.fsf@gitster.c.googlers.com>
From:   Brian Malehorn <bmalehorn@gmail.com>
Date:   Wed, 17 Jun 2020 23:19:56 -0700
Message-ID: <CAJB88a0PkHmZTVQSi2tQZ7b2Adk46k0qEU4Xz8W+bYuHAeunuw@mail.gmail.com>
Subject: Re: [PATCH 4/4] clean: optimize and document cases where we recurse
 into subdirectories
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Catching up on this - thanks Elijah for jumping on this bug and fixing
it immediately. I'll let you know if I see similar bugs in the future.

Thanks,
Brian

On Fri, Jun 12, 2020 at 5:28 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > ...
> > However, in clean's case we don't need to recurse into ignored
> > directories; that is just a waste of time.
>
> Nice.
>
> > Rather than relying on other bugs in fill_directory()'s former
> > logic to provide the behavior of skipping ignored directories, make use
> > of the DIR_SHOW_IGNORED_TOO_MODE_MATCHING value specifically added in
> > commit eec0f7f2b7 ("status: add option to show ignored files
> > differently", 2017-10-30) for this purpose.
>
> Thanks.
>
