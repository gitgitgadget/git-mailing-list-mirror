Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AF8C433E8
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 22:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CCF520774
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 22:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="icVvoQzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbgG1WgE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbgG1WgD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 18:36:03 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EB5C061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 15:36:03 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t6so9984564ljk.9
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 15:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uPtnkXGW7PEUkdctrUEhaxBT5L5YT5Qpt4+keQlBSno=;
        b=icVvoQzEXJOcHKA5uVKuz9ZQPlGrNrXgrXoXOwutxJrbd/VJdpS/ZcNpcJIVL3UpPV
         UUlGvesJURyhKMer4CXLy0CKoFARFL7fE+RIi/q1ccHHQFbmraq5qv7fCfTdwmZkcFng
         i5K2OLkJd5YFMz5wpP0JFaX3v9vw5p4ZUmmWvXFQg/xtjet/E8eUEwM6tbP7cHajn7Ix
         jsFnf/YR1De34TnGSsT3pt+pFLMIB4RW5Wb5GpwYIN3kIYEA2z5RxU/Hw4+p6+7nfrR/
         gDRhOE8+hFeuaYAGBB9kGuCVIcCaQVqQjKJhQTLm/OaDb8mOH/IgoeZbIyUVXJsC1HeU
         lIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uPtnkXGW7PEUkdctrUEhaxBT5L5YT5Qpt4+keQlBSno=;
        b=UbVak1V4Zd1s2QL82uZt5cw/IIU5Ffz+6JoWdFmagonJrh3ACn7D/D2YNlysqb4M2d
         nlB4L2yDVEfqvGxEBaiDXn3j37lJeU/YXFTu2iJJK6DVmip1U2WDhvBR6brRKMw/rFVd
         bnrE8UbNNHIJ0T4KPrQQ4U1cnIVppKceyKzaJc4+B5+nRMb/OTD9fZYc6wWoK5nBzqpA
         d672qJP5inhh9pCRp3i46Nspos7zDTDpn10M4JgF88tK6rZBaoYFjo6os5FrsL80PPvV
         Aa0/Iz1Yt+5/R+fdWQdshW7KFSHdpqptwuUA0vwb9ydJZZ+HOlkLcE+q06xEVj1HeuDj
         hVkw==
X-Gm-Message-State: AOAM530WWBgkqGpx4lHnGkSUGjbGAFw6c/rUC1WH/VNlze/VKBDBISzV
        RZpfdIzsqMCP1RfoePnS+7uwAE+j4yvdhAgx1bKULg==
X-Google-Smtp-Source: ABdhPJxtJuLF6kBFlwuFP3dftYhKZrIBwl65AEZEJxXNL0Vu75Zu1igHLnhCgsyS1pwrVAU1OHKhpmPiIQ+LlQ/85kU=
X-Received: by 2002:a05:651c:2006:: with SMTP id s6mr12603523ljo.74.1595975761402;
 Tue, 28 Jul 2020 15:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <551da4ae-c75a-0f2b-7786-2fee32939b2b@web.de>
In-Reply-To: <551da4ae-c75a-0f2b-7786-2fee32939b2b@web.de>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 28 Jul 2020 19:35:50 -0300
Message-ID: <CAHd-oW68nGch8b3tfas4AUUgA8so-ihwazAf8-W-xQNPi31=Mw@mail.gmail.com>
Subject: Re: [PATCH] grep: avoid using oid_to_hex() with parse_object_or_die()
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 6:40 PM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> parse_object_or_die() is passed an object ID and a name to show if the
> object cannot be parsed.  If the name is NULL then it shows the
> hexadecimal object ID.  Use that feature instead of preparing and
> passing the hexadecimal representation to the function proactively.
> That's shorter and a bit more efficient.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>

Good catch. And this seems to be the only place where we use
`parse_object_or_die(oid, oid_to_hex(oid))`.

Reviewed-by: Matheus Tavares <matheus.bernardino@usp.br>
