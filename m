Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D78C433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 07:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FACF22BEF
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 07:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgLUHY0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 02:24:26 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:40514 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgLUHYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 02:24:25 -0500
Received: by mail-ed1-f41.google.com with SMTP id h16so8602779edt.7
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 23:24:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YrzjKMvYV2gDIFm1vfW2wb8MByaFNI7nlEGY5p7shJA=;
        b=bnI4KqC4klfV+5LtWJ7OT7cuKP9IHrHRMb5fRGQXdC3AfrU1wgskiIvSGZOOcb7+Ff
         txgdRD/DKgNTGAglF9n/pz3iwEv6Cto9f/0caG668hTV6IIcprkjx2/3pskkeXKZrg1U
         061NTp2+Rgn5Xu08cQ6nMJX8ETm57FyGPGn7iDlpJ8+5xH660FdrE+/FAnlPn82Fb6LJ
         INHJaF0Xx6zeWOUnykGHZxUY5AGq1HdP1iUbp/hBkRzZ5/8YKth6687lgdkGvwY++4Yg
         27ETzQRd03DX9sBdoEc5sQ0RHc176dH1MTHCkNy/hYXpQR1f34IwYncXgjpwC+v9y/M+
         oA4Q==
X-Gm-Message-State: AOAM531Z2XprW2NUOwPItgRdT5T9gN9cPBt34X7YBww9xpMAFBWrRmPt
        4U0Xn41PPiJ9izdtcqGjuQW2aZyz3FCNaGckbf4=
X-Google-Smtp-Source: ABdhPJzwqFdeAmD8PaF8suVJpkEOLGC4LATvuNGryWze5Fgz8xgsxKuBvCfcNgRdUbQCfhni/Qsjj3NZ/SdsnE8DhiQ=
X-Received: by 2002:a05:6402:46:: with SMTP id f6mr14957745edu.163.1608535424181;
 Sun, 20 Dec 2020 23:23:44 -0800 (PST)
MIME-Version: 1.0
References: <20201216073907.62591-1-sunshine@sunshineco.com>
 <xmqq5z514lj5.fsf@gitster.c.googlers.com> <CAPig+cR+4Wh4Sgk6UhUML4SHqaQsvYmw_77ih+oec2YmqQJCCg@mail.gmail.com>
In-Reply-To: <CAPig+cR+4Wh4Sgk6UhUML4SHqaQsvYmw_77ih+oec2YmqQJCCg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 21 Dec 2020 02:23:33 -0500
Message-ID: <CAPig+cRK1rq6xpAXp0bG-nekJOgv9gTZKZZV3xsTVh7CoZY4sQ@mail.gmail.com>
Subject: Re: [PATCH] t/perf: fix test_export() failure with BSD `sed`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Sangeeta <sangunb09@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 16, 2020 at 2:29 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> That's almost good enough, but test_export() needs to accumulate the
> to-be-exported variables across multiple calls, so the non-recursive
> definition would likely be:
>
>     test_export () {
>         test_export_="$test_export_ $*"
>     }
>
> which would make a nice cleanup atop this portability-fix patch.

A cleanup patch has been posted[1].

[1]: https://lore.kernel.org/git/20201220212740.44273-1-sunshine@sunshineco.com/
