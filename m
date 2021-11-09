Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96A3C433EF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 19:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C16A7611C9
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 19:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243144AbhKIT0V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 14:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243085AbhKIT0V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 14:26:21 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9019C061764
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 11:23:34 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id m11so463493ilh.5
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 11:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qnsth6gKl1FR104IHlKAr2iD2VZV6ittYHbU2i5zhsw=;
        b=z3NM3QXjdY9mvu+Wc+r2aVGCZIuDnm7g1ywNNJQaJxEqgFQK8CTKpXtOr80ILcnCuk
         4kLS95HW+GvARmdwW8ZZ55cJz6J0Cr3Qr/fRVxFxXVptIOXXlPMjJ88B4bXQcUDp55r7
         +Ruhc3U/MCjSPorqt5o+ZwcNc+Dm4tu+jEfwWCWvdBiBuEVXHoA+4qYWQ+C+OgS0f3T6
         PSADm1RevKVPmvrzofqB7qB3ytlDQ40acMGbT7iQZ41zhmwTx8yQ9RGAHtOZBEO2jt0R
         yc9x88cdvaTjMXNiQ4TOFl7m8C77H/tzhf8Om7LX+TodjOHCNQrFPCDbZE9GkxBbwfO5
         4o2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qnsth6gKl1FR104IHlKAr2iD2VZV6ittYHbU2i5zhsw=;
        b=DSVIRMgRaSOYJ7TvIaUBNXqRnuheiyHBntn8ni9EI3PAfQfX3v9YK0w3rVQC39x8kn
         sgpU14dS8uxjBwp6zXUcIoWkteFFDzD8dZTk66+f+BiT/PnCRORVKhpsE211ZNNf153d
         9OCjZ4mryiGKxtrwSSP9QGSBLLkqN8KeznHZaBiIbvmTpiZhLEAknJh40tNYUfUT/mt5
         2S7av52Qgzp2CGyu6xg6ymXmO5bs1rF6hzTFTeDm86DAmxTs8eygjDsq+lzbjNKmZOeo
         AusDOOeA/rHZK6YiYWH4iu6cklbD5wBk7qhln80acNglts1dTWPxFwzN/HSSEsVKYp46
         vuQQ==
X-Gm-Message-State: AOAM532j7IqtaJtrjB2frrwCZZYceaHnvMmdRlwJpGOsd3psLcyvgUY8
        ykAhoixWxk4WsQ4y2rE2Z2l53w5PpWvpollH
X-Google-Smtp-Source: ABdhPJw+XoXshunRwCd9WAYghw62686Z/XgoDGlQJbc2hkNNhF8BYvqeyRq2dV7gGLA9yNjBORny/g==
X-Received: by 2002:a92:c983:: with SMTP id y3mr6962693iln.24.1636485814236;
        Tue, 09 Nov 2021 11:23:34 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g11sm10486255ile.30.2021.11.09.11.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 11:23:33 -0800 (PST)
Date:   Tue, 9 Nov 2021 14:23:32 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Description of github.com/git/git, was Re: [PATCH]
 builtin-commit: re-read file index before launching editor
Message-ID: <YYrKtHJzapNdpXCF@nand.local>
References: <pull.1127.git.git.1636423586620.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2111091732040.54@tvgsbejvaqbjf.bet>
 <xmqq5yt12lta.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5yt12lta.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 09, 2021 at 11:03:45AM -0800, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > I would be in favor of changing this description. How about:
> >
> > 	Git Source Code Mirror - Pull Requests can be submitted via GitGitGadget
>
> Presense of GGG does not change the fact that the repository is
> publish only.  But "all pull requests are ignored" is not correct
> anymore.
>
>     Git Source Code Mirror - This is a publish-only repository but
>     pull requests can be turned into patches to the mailing list via
>     GitGitGadget. Please follow Documentation/SubmittingPatches
>     procedure for any of your improvements.
>
> I didn't double-check but I presume SubmittingPatches these days
> talk about GGG?

I don't think so. Documentation/MyFirstContribution.txt does as of
76644e3268 (documentation: add tutorial for first contribution,
2019-05-17), but the same treatment was not applied elsewhere.

I would not be sad to see a reference to GGG be made in
SubmittingPatches.

Thanks,
Taylor
