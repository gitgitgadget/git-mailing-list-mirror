Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D880AC43466
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 20:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DF92208B6
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 20:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZW82Nzf3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgIQUXA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 16:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgIQUXA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 16:23:00 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A56C061351
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 12:26:32 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id 5so2041326vsu.5
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 12:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X2FlNCF8waxwgIDL5DeS8Ep4b5kGCNwladC9AAihcbQ=;
        b=ZW82Nzf3RM2vgPRkXItT1Hd2Rg1iDsrgou+i+3o2EcptYM6fOKaO8ElUQsNXEbMXa9
         G4GFeFzT4eAP1NpaRlJNsdzYXgR1sS6E47SbGlfSZR8GMgl8w+8/FaQhTn3LsUDGOUYp
         jFKtP0pW1wjKSNGFoVoZ210/ZnuF3RFz/AxdY4bUlPCJeocTF3b+GZDVzVaWNos7Pr1a
         A23a1bobxdus3uB/h/wufEB4LLcmXUYEjwS+Ie/eG7uyG+Dsw8lb5fE3CGwJZdWr8mb/
         5OXrQybRm3PC1+QfvaPG5zYu+zFQikcIkD5HIKcEb8bfqz/uq0E4e+B5nbn/jDSrwKkm
         ro7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X2FlNCF8waxwgIDL5DeS8Ep4b5kGCNwladC9AAihcbQ=;
        b=WBe8vx5/NL0YP3f9HIxVPpyKVytdvgD5HyWc45UFspUJlP70peiiwDNfdOIAlyRmDU
         ENk8k3jH1xHg2FSQ1rTtfnaWjP72QzvrSRdk8IuApkzalff/s0PkbAYm2GyFm2BOG6Sk
         W8XeIsUctWQC8cgChxn2VNjvlL8P3H7j895eMS+rDoKKPbl+EqzNRRISi+W690Se/XZv
         vjbECOO1ozBeGb8inwdqJZY1XPuNwZ/cdhtZQPqk2/eiPk2AYoaG1C8HPype8pGrgVc5
         M5QTKKas3RUfZDZubJhdFhaupvO7fFnr9USF8Vlqot07vKE6q+9yyfDTnrTNJZ5mN4Ue
         Hsjw==
X-Gm-Message-State: AOAM5303omLm55hM5PuNSl933UiMHXNVvSbee1D01V8q0GTf2w3szlxU
        vDZQ82vu6JVY16k3txXoAFFVzMWUDKfiwvKmzUQ=
X-Google-Smtp-Source: ABdhPJw/XboZf2hDuuahslJoGLd0ry2lNu+MTCGB7BiJ4h10k/bsnTn7tzR3xU1/4oxkat5dEzgS25p2sqtxaxzsv4k=
X-Received: by 2002:a67:c799:: with SMTP id t25mr9601207vsk.34.1600370791467;
 Thu, 17 Sep 2020 12:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200916234916.422553-1-jacob.e.keller@intel.com> <xmqqr1r1tfil.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqr1r1tfil.fsf@gitster.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 17 Sep 2020 12:26:20 -0700
Message-ID: <CA+P7+xrvbwVevFaCB=cm4mZB4=nFAL2rs4gFgYF85qSopq+dwg@mail.gmail.com>
Subject: Re: [PATCH] format-patch: cancel useAutoBase if base is invalid
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 16, 2020 at 5:26 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
> > Make get_base_commit detect when useAutoBase is set, and avoid failing
> > if the base commit is picked up automatically. We still attempt to fail
> > if --base=auto is explicitly requested on the command line.
>
> Makes sense.  I also think we should fail in such a broken base is
> chosen, when useAutoBase is set by configuration and is not
> overriden from the command line with an explicit use of --no-base
> option, because the end-user expects an appropriate base to be used
> that is computed automatically, but we are failing to find such a
> base---going ahead silently in such a case would be wrong.
>

I am not sure if I follow here. The whole point of this patch is that

git config format.useAutoBase true
git format-patch -1 <old id>

causes failure that is very unexpected, especially if it's been a long
time since you set useAutoBase.

I do want git format-patch --base=auto <old id> to fail, certainly.

I wonder if there's a way we can tell when the format patch revisions
in question make no sense with the automatic base. So.. rather than
looking at "is this base valid" think of it as "the base for this
branch is XYZ, is that valid for the set of requested commits?"

> > Unfortunately, at least with how --base is handled by the option parsing
> > now, if useAutoBase is true *and* --base=auto is provided, we'll still
> > cancel the base option instead of failing.
>
> If we are doing the usual "prime with configuration variables and
> then override from the commnad line option" thing, then you cannot
> tell these two cases apart, but I happen to think that it is better
> to fail (and not to ignore silently) consistently whether the
> "compute an appropriate base automatically" came from config or
> command line, so...
