Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EA5C433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 04:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEA7E60FA0
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 04:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhIOEdJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 00:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhIOEdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 00:33:09 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24150C061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 21:31:51 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id b15so1514795ils.10
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 21:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=np5hnsBNR5FDwP4Lp++bOZ88cmywfTQY03elNbBzU0M=;
        b=OL8cBkLN4HTTvngwOPalyDAMNkDVPZSAlSPng86ESB2ahSMJIxxvB7O5FqRcX3LaJh
         2DJR1F/I8BWjfKRXjuWlN7eLnKhygPkV9RWGqTLsfeOt+xTPm3l6qwP49N0TRweTu/j7
         folwwr9FeKnuSgAxuvjTbgjauY76kxi9+X78CfNaJ6+agHBCohw9SeHlB9spSuiid3aI
         JUyf6bpx4v4c/pdJkaBNa3zPTIx5w62kV8Ie/YjGmP+7h35J7yCz4A5ZJwNtIZrTVSAj
         FISMiNuKk3VOCYxFLOLGP5v2qGGER+fKAi0vWrqNJiJG4DKaTu6r8foFA4TCjRk74ao3
         rHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=np5hnsBNR5FDwP4Lp++bOZ88cmywfTQY03elNbBzU0M=;
        b=oQxMQ5VgXUA+qc5vqQEiTevJcp0UmPKVC6I3cMaFXTIIRvWUJeVSDDk8Li0DALoLt6
         EULl+0ZRStbUYAHp0rxmfLhHecrGEpoI/bLF10ZvnOigmlF5kwA5rTTRFVMpKI96FBV6
         ySfdwGNW3tKgpCVR5Fa4zLGh5NRTNSxRPFM5QY86K3k0RopDxVlu3r0Q+xS9NgVyET9W
         gLvpYkR+znoNjDJ3XfOrLB8bivSajSvK/ObudJxvwLkLUC0BUs2oGWpJzU7R/6LGeMvb
         LX62F5d+YIVkFNvXCK5xux8hVvm+nJ89+cQEV7qEIY12/l9wUJYVTqYXAqVskJ09QdwC
         jL9g==
X-Gm-Message-State: AOAM530SVol4XpkJTOyVf/h+yTTmEo/4tK3xl9bpjtT31P3IYGQdToH7
        h1APiUBj5WxRpz47k+oCvbRWAA==
X-Google-Smtp-Source: ABdhPJyfOCZ9TYqQy+oyllcEFRTarspnQXfM37lCz+TIzLPLeCQMfo34nlPn7Bt7qq/7Gdl8nhMYag==
X-Received: by 2002:a92:d852:: with SMTP id h18mr15532598ilq.211.1631680310465;
        Tue, 14 Sep 2021 21:31:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a11sm8397815ilm.36.2021.09.14.21.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 21:31:50 -0700 (PDT)
Date:   Wed, 15 Sep 2021 00:31:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 8/8] builtin/repack.c: pass `--refs-snapshot` when
 writing bitmaps
Message-ID: <YUF3NXcjo2dWtPOR@nand.local>
References: <cover.1631331139.git.me@ttaylorr.com>
 <6a1c52181e8c8c9fe2f0e2d7fbeb1057f68c1f3d.1631331139.git.me@ttaylorr.com>
 <871r5v9z3i.fsf@evledraar.gmail.com>
 <87sfyb8ihg.fsf@evledraar.gmail.com>
 <YTzejKyYvqZu4v16@nand.local>
 <YUDwB0W6IpWWcU81@coredump.intra.peff.net>
 <YUExaCwMwjfd5h7S@nand.local>
 <87a6keoglz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a6keoglz.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 15, 2021 at 01:56:00AM +0200, Ævar Arnfjörð Bjarmason wrote:
> The suggestion I had offhand was just meant as an offhand "interesting,
> maybe easier like...", i.e. if you found it easier to split on \t, or
> check the hash size in the loop or whatever.

:-). You did say "Just an idea", but I treated your suggestion as if you
were concerned about being able to extend the format in the future.

> I agree that this doesn't matter and should just be left to whatever
> you've got a taste for, thanks. This thread became more of a digression
> than I thought...

I think that all of the discussion was reasonable if I understood your
original opinion more clearly ;). It may help (me, at least) to say more
explicitly, "This may be easier like [...] but I don't have any concerns
about functionality" or similar.

Thanks,
Taylor
