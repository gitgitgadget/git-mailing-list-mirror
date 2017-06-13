Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96AB71FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 21:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753311AbdFMVzc (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 17:55:32 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:33262 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752327AbdFMVzb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 17:55:31 -0400
Received: by mail-io0-f177.google.com with SMTP id t87so62406116ioe.0
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 14:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=WBytalLJ2wvXhfiODReiv8AzKI/9rJ+zYbxE5cEScKQ=;
        b=AmfPnyVgK+LxLUaIwFGlT9Bsih/PBoDIsm4ze3aoQD6Nk59KmTVaAHte1fBDxmQtR0
         LwnS7HjyP2ZyrYXipUuDSqAwiwDO72PEttLWePXPpZy3m9+wSBnb6mKy3lQ9J6PfADOZ
         GQxYHgl/X+S6Ni7Z6EFmWjx1p3o0swpZEy+HB18oZpt8B2T5ic+JmVCmdEPD6p7jeRn3
         iAb3cK5Hrnz+yzHW5p5msgd1Rje4/fwJ8ENtE1L3JSYtmKw+ZUPwJ5pRxiUfY7HldES+
         FY9KCW+qaZHZj/FvABMERBxpQF8IWcUl7nB+USf5u7iHodG9/bSBAtikOTuUokImXDru
         7NTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=WBytalLJ2wvXhfiODReiv8AzKI/9rJ+zYbxE5cEScKQ=;
        b=otAu8+2ZWTatF5YnwiB0xpIDSio3FTsmvCtpuAlJ8jYN4U6/f0Ris5YjJD4A/OSuXM
         GkvAoU0lqU22O5es82vePJEha+0ew9M0iYlMWVdXg8XUXEV2CfxTJne/HPrkikmhLGTn
         EyGgkKMvg5RcrND4gLXuFcmMH0P7/Ii2C8aDbTWsx1LBND+x8IJjBzxrfQpFSUmmi0/J
         mwYMPH20SLvR+q559M4/+ge2fQ8quxs1gkylqjJSEpynm6sDOgNE6TXfr0zwCSdvMtkr
         RDo6bgxUszYZ2x4iJ0BdBi5B7pr3xkBodQwaTlx3uoN3J6rYC+lmcwxu9oe6qjEHjFzL
         f5iA==
X-Gm-Message-State: AKS2vOz0ccAiNyrLyLBpbrFydUkuQnAd64buJU1cmpnP3e823RZAttLI
        HrBJw/xYcD1eLqgSDu5rU8USOE1RTA==
X-Received: by 10.107.201.129 with SMTP id z123mr3044477iof.156.1497390931033;
 Tue, 13 Jun 2017 14:55:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.142.208 with HTTP; Tue, 13 Jun 2017 14:55:10 -0700 (PDT)
In-Reply-To: <20170613215138.GM133952@aiede.mtv.corp.google.com>
References: <20170612213406.83247-1-bmwill@google.com> <20170613210321.152978-1-bmwill@google.com>
 <20170613210321.152978-5-bmwill@google.com> <20170613210806.GJ133952@aiede.mtv.corp.google.com>
 <20170613213815.GP154599@google.com> <20170613215138.GM133952@aiede.mtv.corp.google.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Tue, 13 Jun 2017 14:55:10 -0700
X-Google-Sender-Auth: inGYoKJNUGD6MjMDQFPeB0nS-y0
Message-ID: <CAPc5daWpXnkNyuGNtFi4YTyB+Np5Yw8yZCGwu5VNzv+WON1u2Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] config: don't implicitly use gitdir
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2017 at 2:51 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> What is the next step, then?  You can find the notion ridiculous but
> it's how this project has worked in my experience (and how other
> projects with similar patch-based workflows work).

Does "patch-based" have much to do with this? I agree that distributed
nature of the development would bring this issue, but I tend to think that
using merge/pull based workflow would not alleviate it--am I mistaken?
