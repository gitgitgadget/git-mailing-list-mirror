Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D146AC433F5
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 22:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5258610A4
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 22:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240404AbhIRWhN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 18:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbhIRWhM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 18:37:12 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD29C061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 15:35:48 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id b6so14393801ilv.0
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 15:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KAjaXfnblvqe7qUGDND123wDp+79LUAHzCMf7/3XnM4=;
        b=FctRkZKSyejWFeTE3HxNmILLc0ChwuEVmO1G/dgtwdvXjXdt7vAqLqEw29XvPdMuY8
         T0nV7pPhW/Jsg8AI45AZeesS82nfAJF5rdbeL5lujfJJVe6kPgnvsvASlZURnv1XyQTp
         fxP1/hBxQsCHAUfwlstoZO5UtK8jXArdW1H4R5sHRwrt6eT9Y7Dy1S7h/lpdIhdCuaHI
         4TZf0KC4VRLhNv4hyJacPtDWQKtVWPBNZkLDK1pdkWeUPMiCMb8EdYdZtjubzVQrDdof
         iLXOXmHD3c99qWEvhgU/S9fZMmlQZxvElHgeYXt/9qfsrxLCKbfqoJLZSAZsvPfb/ty1
         XOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KAjaXfnblvqe7qUGDND123wDp+79LUAHzCMf7/3XnM4=;
        b=N3ghsVjehI4DpDiQHqpQxoO3tjUNdlzWXRmg8kb/0KlGqqZMT27i7MM7svPKh7cUKu
         Wask30r045bGT5fUjkjovObvrb/fjwBNRi9mMvFnlZwBTofJ556+CjuDk6Jxzer+e7OG
         nBhnFof+ZDZErxMgRUv/IAcgB8w26KhRBzU1n6I3OQuIzZvd9XvFWGVzDt3oGpj3Mg2I
         DGR6phlV1YhdS3S5M7SsnRWzeBG+SQPuOiOFRGk+N26nB8zcvZUvV5bkZ5RrpO6OixXh
         5iDlJJnLujXytHRkf+cgHURXPJI5i4qWgCIjAaZ3aGa3t8NZ9fN6NXCEzmJldxSTyHk9
         Qxfg==
X-Gm-Message-State: AOAM5338CegbwoosyToJuOfETq7yEEjJ6gQI31f52ozsEDHcmVb853t7
        A7jDmbmzU99S1gwOJw+LeUcweg==
X-Google-Smtp-Source: ABdhPJzW5ujE/Yx01FTWf79mi0tSWsBpdgX9hry2hlVClowyNhDCEteiUQUo3Lr1/u7i4BTcgFueQg==
X-Received: by 2002:a05:6e02:eaf:: with SMTP id u15mr12780988ilj.313.1632004547368;
        Sat, 18 Sep 2021 15:35:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c20sm5851682ili.42.2021.09.18.15.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 15:35:46 -0700 (PDT)
Date:   Sat, 18 Sep 2021 18:35:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Andrzej Hunt <andrzej@ahunt.org>
Subject: Re: [PATCH] connect: also update offset for features without values
Message-ID: <YUZpwi2HhflICd4Z@nand.local>
References: <pull.1091.git.git.1631970872884.gitgitgadget@gmail.com>
 <YUYLXKN8U9AMa5ke@nand.local>
 <YUZinXsGdL19l/tQ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUZinXsGdL19l/tQ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 18, 2021 at 06:05:17PM -0400, Jeff King wrote:
> On Sat, Sep 18, 2021 at 11:53:00AM -0400, Taylor Blau wrote:
>
> > > +test_expect_success 'bogus symref in v0 capabilities' '
> > > +	test_commit foo &&
> > > +	oid=$(git rev-parse HEAD) &&
> > > +	{
> > > +		printf "%s HEAD\0symref object-format=%s\n" "$oid" "$GIT_DEFAULT_HASH" |
> > > +			test-tool pkt-line pack-raw-stdin &&
> >
> > I'm actually really happy with this modification to add the non-empty
> > object-format after the broken "symref" part, since it ensures that your
> > offset calculation is right (and that we can continue to parse features
> > with or without values after a value-less one).
>
> I don't think it quite does that, though. If I understand the parsing
> code correctly, it walks through the list looking for entries for a
> _particular_ capability. I.e., it will look for any "symref" entries,
> advancing the offset counter. And then separately it will start again
> looking for any object-format entries, with a brand-new offset counter
> starting at 0.

Ah; you're absolutely right. We call next_server_feature_value from
annotate_refs_with_symref_info() and server_supports_hash(), each of
which initializes their own offset from zero.

> So if you want to confirm that the parsing continues after the
> unexpected entry, you'd want a second symref entry, and then to make
> sure it was correctly parsed.  Perhaps something like this:
>
> [...]

Yeah, I agree that would exercise it, and I also agree that it isn't
hugely important. But this patch does make an effort to handle that
case, so it's probably worth testing.

Thanks,
Taylor
