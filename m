Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935B5C43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 20:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CD392311A
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 20:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600460317;
	bh=rsYBDPf8KDWTbfT4ByC8axa3Tct0D9ndR83TBm22+aw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CdFVBy59KB5qLAi21yWtVTyHDtN+lj9wSoTLzkX5bkTZbcq1uPAc9k8cPClYy3UPn
	 59OexiNFQf58iN776wHgEFv609N9v2K7VfW97QoN79939rnZXjYdKMzS1q5KiuTQOf
	 KqpmNpmiH7dA40mApOrIx+W851Rwc1gYifdfP35k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgIRUSg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 16:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgIRUSg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 16:18:36 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAC5C0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 13:18:35 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 16so7652903qkf.4
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 13:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ilqyFZd1rL67JttRSFlSqP8Fg4nzlyuLjhI1+Dpc5mM=;
        b=cu1srs2DzHsvcrYOf05QEeIc7Vr5jDwtrjOAbY9+SWKbLN2NMoOdObWkeA6Kh+jmPe
         Mx7LpN4sCD/laQGpiHdfV/BYVSA/ZzvNp/BZYXL5OMeENRbqgXg9Uzb182kpn9/IOIhc
         GirbnE3RzuFTAiqrzygrSDlyHGVJr+o3oNEgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ilqyFZd1rL67JttRSFlSqP8Fg4nzlyuLjhI1+Dpc5mM=;
        b=OYgEjXAGky5WysDhFp5hZR9H/eBS3biAvYx6qcxwvTfccHnMVcPr9RMv8Hmu6qkWs2
         UVz+y0ey4QXa8/MwQI2XXp+SHi6FBPQPJEHsIkj1gRMr41k39HnO3+2VNAPrIAvu+1m3
         Q+zh6LrL2kzVNaffzWNZboCxjx4hlL3j9vd8HnpN+E9shvUWx85/A8P1oMN+bmc3WcTC
         RGrh9lEgT8dldQ/YkrZ9oeIPg1+CkKouZLHMttw+/N1Gs+AS50KL2uVQKhqHT6KmHfrN
         xp22qa3VzD4nMKQb6FrcTbSEMNhbIrg60soPeQ0YHFT7TOF5iKyWiz8j3WduCtwuemgo
         cIVg==
X-Gm-Message-State: AOAM531u4GBpQ1Qga+CMXHKXogpJixKmWwoCbkzf70kVQRenN1Uj+/N3
        RMoHqce3szzSuXPGUIr+CyPpJGRONurs3T4m2sHE3MJeKMbd1DFd
X-Google-Smtp-Source: ABdhPJzos7BFwQg9NfuOiQj3I+6Bj/PL1WvDyJRNf21J6oR42dvE8mWe8qjMmpksoFNsE04pWLcOJTGZ3Ylm4fKY1bw=
X-Received: by 2002:a37:6387:: with SMTP id x129mr33948553qkb.208.1600460315059;
 Fri, 18 Sep 2020 13:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAHpGcMJqmUmCR_u3fxSVppzwBo8_6RJG5-WLrXAWXm+OQ6_3bA@mail.gmail.com>
In-Reply-To: <CAHpGcMJqmUmCR_u3fxSVppzwBo8_6RJG5-WLrXAWXm+OQ6_3bA@mail.gmail.com>
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date:   Fri, 18 Sep 2020 16:18:24 -0400
Message-ID: <CAMwyc-RCiEREpPsTb76LjhLc43Zr2qw-uxYVVPfuznexTTB+Tg@mail.gmail.com>
Subject: Re: Apply git bundle to source tree?
To:     =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 18 Sep 2020 at 07:14, Andreas Gr=C3=BCnbacher
<andreas.gruenbacher@gmail.com> wrote:
>
> Hi,
>
> I'm wondering if there's a way to apply a particular head in a bundle
> to a source tree, for example:
>
>   $ git bundle create v5.9-rc1.bundle v5.8..v5.9-rc1
>   $ cd linux-5.8
>   $ git bundle APPLY ../5.9-rc1.bundle v5.9-rc1

I know this is not what you are asking, but since you used the kernel
as your example, you can use the following to achieve the result
you're looking for:
curl --header 'Accept-Encoding: gzip' -L
https://git.kernel.org/torvalds/p/v5.9-rc1/v5.8 | gunzip - | git apply

-K
