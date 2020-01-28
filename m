Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CB3C2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 13:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E3A24683
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 13:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgA1Nmd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:42:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38208 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgA1Nmd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 08:42:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id a9so2589404wmj.3
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 05:42:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wTUppIcm+ra7oqWJRjKqDHP/GlYpjhAqYIBRHIIPuqc=;
        b=qh4ofN4jFuHz6mPMEEavubALsmUVOoO8U8XQj/GfWGSKGSMwonTQt7Pfww9G75fy8g
         9W5qOeIEzV3F6K1pSef9Kwt7fMkeyu9FlJk/0pwAvVtbGY31pcOBxOcP9R+PBFO2zpdN
         0Oz1B9yXRpmTl3DA7PK/5JHAPzaNRDW1FF0t/fsk20uWwnSr8rnfZnY/orIzTfKnvY4X
         fB7dyU5Qa/gdHPBLLJ45s2EyGxa53zWIymlId5pAbgay2npqmuVY7bRwdlFuIQtrGJjh
         jZsb3+6sJXKocccGQtsaqsJf4i3QvCsXusVnoalT1GXWEF/aSjEwnqINuuaNyFoMNZKQ
         rMmg==
X-Gm-Message-State: APjAAAVydRpN+wtTr07Vm/AT+90Z9usMtD3a7LvElVXL2ev+wJ9uqIMA
        4bN82OdHSvxXA9RiTdHs1KGeoaUb67fAZZurA6Bgbg==
X-Google-Smtp-Source: APXvYqz40jKjGjnfY3yvQo+nW2hEgO3R2Rd7SmQaZmHo9TAyi09F6YO+YvGCyDIP6HAG0Bqamrdv4FQXdn1Y9mNa3uM=
X-Received: by 2002:a7b:c190:: with SMTP id y16mr5224778wmi.107.1580218952259;
 Tue, 28 Jan 2020 05:42:32 -0800 (PST)
MIME-Version: 1.0
References: <20200127100933.10765-1-git@zjvandeweg.nl> <20200127100933.10765-2-git@zjvandeweg.nl>
 <CAPig+cS03oS9PhN_cusjpzoCzwNmgc5rXiVAmG3ceUCFw71PVg@mail.gmail.com> <20200128092414.GB574544@coredump.intra.peff.net>
In-Reply-To: <20200128092414.GB574544@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 28 Jan 2020 08:42:21 -0500
Message-ID: <CAPig+cQJeT-pU-cUE4YEKcb4P_0X2sB1srGMCiOfyt6DZEcbgg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] config: learn the --stdin option for instructions
To:     Jeff King <peff@peff.net>
Cc:     Zeger-Jan van de Weg <git@zjvandeweg.nl>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 28, 2020 at 4:24 AM Jeff King <peff@peff.net> wrote:
> On Mon, Jan 27, 2020 at 11:59:03AM -0500, Eric Sunshine wrote:
> >     set SP <key> SP <value> NUL
> >     unset SP <key> LF
>
> The section and key parts of a config key are pretty restricted, but the
> subsection portion can contain anything except newline and NUL. So in
> particular, it would be valid to have a space, which would make the
> input ambiguous.

I was wondering if that might be the case (particularly, if space was
allowed). Thanks for the education.
