Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EB9C43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 14:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1948D21973
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 14:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHew4EXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgIROvA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 10:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgIROvA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 10:51:00 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0BDC0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 07:50:59 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id j2so7075181ioj.7
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 07:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3ObSOnh6rq987myZYhf2tz1pZ86g7UnvaS5PpW2bV4k=;
        b=VHew4EXHjLQu8B7LCdGZrl9yA8+wemPDUDoLf+qwZo8/7vtLEfkMV0nZa6lj8Md4nQ
         qGLeONnrF18TPQjf94oZTpXTRRR5i39zidixwxPAKC2Xkd7s8sLwnIGxhsPCCwHl2xQV
         TiIbhBqQ5Kce4exyZAO8n2JaSAW+oJ/UdANCjeeWbuKUJpHhLBcyKMCcXEfhhOvQ6Dt/
         Wbyp+ZtMtJwNPz3pDjvq1cZisuP6362P0f8uoedHu0/4glxNQXx0OfMJ5EP/oMuMpphB
         rLdiHS5qHes3EM3YTrCnIs75fl0nLh76M9ac814JWDxO69ZNTRyFSj2r4DnB/XFwN4HN
         blCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3ObSOnh6rq987myZYhf2tz1pZ86g7UnvaS5PpW2bV4k=;
        b=fQ4Jq7ZstaI3T1Q/ZFJwNQ7h9oMXVYhMhKpmWOZx15JmM+f8IaIyTmSse5l07Up0SR
         /k+RJrINsTxU/yQ/GR2ndSOC39R27jhqWNNwy3UIdfPNqNcvc1BVN6z2kSI9Kp4H0Wbg
         CR9xr1cVis0wVBYNXtmfcOXw4X+mIAE/4PWXlTCViR3rXe7zE8P2QPDXAbZw8spsoIIf
         8NMAFxfCkIilQoE8vRe6DbPPXLdArU8knCgFrEizHBK1mqHedQsONPOyeD18mLWXPZnk
         vpeZKfpOeimaHifQMle9YqNgolNAxvtouY1Q0s64cYw3GrIKMUhZNE6KiehZ7pOF1Yi9
         3OJQ==
X-Gm-Message-State: AOAM530v+V8PI6lYlnvaNLQ/1gc3YzhwGJNYPN4p3ykh6xVmh+dVfWJM
        p3xb1l1Qjon7l7Eqb7UFdlkJkvFNubTAzdZld6chlLe2+No=
X-Google-Smtp-Source: ABdhPJyiqE9IakbzQneBGNuzGvGuHxpa8WWLkfVKPOGRW8MOAq5iHcJmC3g27Zi0x0FKkVFnmFMnixrDJzHkYYv9n5M=
X-Received: by 2002:a02:c914:: with SMTP id t20mr30752056jao.117.1600440658951;
 Fri, 18 Sep 2020 07:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAHpGcMJqmUmCR_u3fxSVppzwBo8_6RJG5-WLrXAWXm+OQ6_3bA@mail.gmail.com>
 <20200918140236.GA1602321@nand.local> <CAHpGcML=EFRngwjgaXNE53OOPoEBz+4Qi1v354gAv_vHNYS_gQ@mail.gmail.com>
 <20200918141725.GA1606445@nand.local>
In-Reply-To: <20200918141725.GA1606445@nand.local>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Fri, 18 Sep 2020 16:50:47 +0200
Message-ID: <CAHpGcMJXZ++t0UtyCRSh=cB8uzy51hJTNxaF1Zd8Z-AQs4w+QQ@mail.gmail.com>
Subject: Re: Apply git bundle to source tree?
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Fr., 18. Sept. 2020 um 16:17 Uhr schrieb Taylor Blau <me@ttaylorr.com>:
> On Fri, Sep 18, 2020 at 04:12:09PM +0200, Andreas Gr=C3=BCnbacher wrote:
> > I was actually looking for a way to apply a bundle to an actual source
> > tree, not a git repository. Fetching stuff from a bundle into a
> > repository seems to be reasonably well documented.
>
> Unfortunately I don't think such a thing is possible, or at least if it
> is, I can't think of how to do it.

Yes, maybe someone familiar with the bundle file format can tell
whether it's at least theoretically possible. Is there a way to figure
out which hashes the original files are supposed to have? Am I right
in assuming that v5.8^{tree} isn't included in a v5.8..v5.9-rc1
bundle?

Thanks,
Andreas
