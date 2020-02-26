Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909C8C4BA21
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 20:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6375021D7E
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 20:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgBZUU7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 15:20:59 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:43554 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgBZUU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 15:20:59 -0500
Received: by mail-il1-f193.google.com with SMTP id p78so271855ilb.10
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 12:20:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6tt2pePyJr4D81HmyODPLFRSLXQJwsTS6C3vwgUvK6U=;
        b=Fw5sklS57Hch8rVBQdyi8Q/4ZOBsTqBdOllkrSk5Dtf1NPOrHHt3dfJ/dvUXllxkNF
         ntNO1za4EHKKrxHcCv90Kpx+68+LBoZVoHrKi3xbPcYWbFNl2Y4CKZROASwH/r8EJ9Xl
         ptjeTLK1SGpJIkRaZ8tivr/1m4AoSNFTvePSaVqV1xSmm7nvA83U+BcLleqHFK1X1lsr
         A93amb7wuVJixajmbUnPBKoghMG5LUPaqFSquiz0Njj8RzwUJN/B3PuA4JBgG+RqQdPh
         5nyAAbu9dTHjDrxYEwPYfUCniCo6zTO76/fpervImlXNy8w6BzJB7+EoyK0Rng0EnUH+
         cLJg==
X-Gm-Message-State: APjAAAX9BlGUH1rFXgf97GaBgcwMfZaRJA9f0kHBfEk9W7ntCCmPeZBX
        nSljo8zLXKNSCmfd8wzLD0kJ7HRpeZn/y8EUFpIben8w
X-Google-Smtp-Source: APXvYqwukIKjL5lALpuukMs5KZYXdHxfqooOfkhINPJ8R1H9NkdymDmEOM9Z1Tt13Nd4Wgnvf8oruo+GIWOYNyzkNXA=
X-Received: by 2002:a92:4448:: with SMTP id a8mr480951ilm.256.1582748456821;
 Wed, 26 Feb 2020 12:20:56 -0800 (PST)
MIME-Version: 1.0
References: <pull.714.git.git.1582747775.gitgitgadget@gmail.com> <9900cacbfefb46610114702e6d48d8020f3f2866.1582747775.git.gitgitgadget@gmail.com>
In-Reply-To: <9900cacbfefb46610114702e6d48d8020f3f2866.1582747775.git.gitgitgadget@gmail.com>
From:   Ed Maste <emaste@freebsd.org>
Date:   Wed, 26 Feb 2020 15:20:44 -0500
Message-ID: <CAPyFy2ArnEFe33GFLsbcOEV37DZ=VJpF-Sckn-V_tJUrToir=w@mail.gmail.com>
Subject: Re: [PATCH 1/3] t/lib-httpd: avoid using BSD's sed
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git mailing list <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 26 Feb 2020 at 15:09, Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Among other differences relative to GNU sed, BSD sed always ends its
> output with a trailing newline, even if the input did not have such a
> trailing newline.
>
> Surprisingly, this makes three httpd-based tests fail on macOS: t5616,
> t5702 and t5703. ("Surprisingly" because those tests have been around
> for some time, but apparently nobody runs them on macOS with a working
> Apache2 setup.)

Hmm, this is interesting - all tests (that are executed) are passing
on FreeBSD, in CI.

I tried on FreeBSD and do not see a trailing newline added; I'm not
sure how sed behaves on other BSDs. However, you probably want to
refer to macOS sed rather than BSD sed in the commit.
