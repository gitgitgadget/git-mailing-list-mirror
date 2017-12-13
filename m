Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA9221F407
	for <e@80x24.org>; Wed, 13 Dec 2017 18:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753629AbdLMSZP (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 13:25:15 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34598 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753477AbdLMSZO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 13:25:14 -0500
Received: by mail-qk0-f194.google.com with SMTP id d66so3143849qkg.1
        for <git@vger.kernel.org>; Wed, 13 Dec 2017 10:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=4L+N7EkN6ObEVeO33r4fV1XKJO8jFlm64ojP+o8YbEQ=;
        b=pgNBWqHUq9sbUJV5azLuCI/nfjPnYC8lpptsTdqzu7aa2wvKPs0+pVl+Fg9Bv4AJ2T
         teuxjNrkqLbx5TaTfdVoo4xS4dyzTsTjBHgqJen2tzPw7dcnK3M53J7r83MsxeJFLTBi
         SgpB040zodU2XAetv8yknRLNaPCFzKLCJ7clELHCchGEDAqBckOFPIZW0DX1PzGN25fB
         SMsWZKDKMjBZ+yQrlK+xH504bLIOxFaAcKwXz94rfodEJA/MdtmtPAG3HtoQdslYuXZF
         d2eYd27asJovX/3Pz1a/eRpwuvQWoFCnCayOUWUoaOdDR3EhYZX0UnePfrhlMyiS42zr
         eKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=4L+N7EkN6ObEVeO33r4fV1XKJO8jFlm64ojP+o8YbEQ=;
        b=ZwYVrTFy0EdRSMDzOfFTZeJnhW3yHoEn9x3q2VMZXJ1Xl/xlbQWJUVbfurNxEgIWyd
         evZbWKLfkb7xpVXK4awsCctTXFyLBV50g15rHb6dZ8+kgEkWauyIYCGFQgHi9CadGwLu
         AKEPpD8uomf6idSnsOBPnE/m8ywsSafYVVWT1ynWDJilW+O560+F8domIwsNdAvb9+Z3
         cId0rScgUUe9B5Iq5Yk4xTTZYG2ZgulZZr9f4wwBvTQg4kGrwsh4RArhwiv3but0NhYv
         riSWyfYydKh2t6Xsv1McC/QBLjyhGjIlyLbSKvTe0OsGgygQgy2TYEvHD5XETtlarOy9
         LO7Q==
X-Gm-Message-State: AKGB3mKW70B+5q1SgWk5vMsIB7mgd/f5wfpX3W6BbdJKMnTSjxMp8hbp
        fNMFJtgqqBxy+5AE/KPsLS0pKcmol6mHuoafIqs=
X-Google-Smtp-Source: ACJfBouONmw0hweigmcPezNIZePVh8N7B6S6YvLjPI5GGHC9RfwUyuEKWm5zct6tjhOv5cCkcJUHGj6xszIswBbUY7g=
X-Received: by 10.55.90.4 with SMTP id o4mr11666716qkb.296.1513189513721; Wed,
 13 Dec 2017 10:25:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.4 with HTTP; Wed, 13 Dec 2017 10:25:13 -0800 (PST)
In-Reply-To: <20171213151344.2138-4-chriscool@tuxfamily.org>
References: <20171213151344.2138-1-chriscool@tuxfamily.org> <20171213151344.2138-4-chriscool@tuxfamily.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 13 Dec 2017 13:25:13 -0500
X-Google-Sender-Auth: sH16tV84p_c-o9ogvTfus_rSUXs
Message-ID: <CAPig+cSev+U9Cchyz1c4uQUsf8O4N8vVGTAsa5FiSA5mTOekxA@mail.gmail.com>
Subject: Re: [PATCH 3/8] perf/aggregate: implement codespeed JSON output
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 13, 2017 at 10:13 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> Codespeed (https://github.com/tobami/codespeed/) is an open source
> project that can be used to track how some software performs over
> time. It stores performance test results in a database and can show
> nice graphs and charts on a web interface.
>
> As it can be interesting to Codespeed to see how Git performance
> evolves over time and releases, let's implement a Codespeed output
> in "perf/aggregate.perl".
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
> @@ -174,6 +181,63 @@ sub print_default_results {
> +sub print_codespeed_results {
> +       my ($results_section) = @_;
> +
> +       my $project = "Git";
> +
> +       my $executable;
> +       if ($results_section eq "") {
> +               $executable = `uname -o -p`;

Option -o is not recognized on MacOS and, on at least a couple of my
Linux installations, -p returns only "unknown".

A combination, on the other hand, which seems to work nicely on MacOS,
Linux, and BSD is: uname -s -m
