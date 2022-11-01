Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0566FA3740
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 00:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiKAA7Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 20:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiKAA7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 20:59:24 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8910EE0C
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 17:59:23 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id p184so11180309iof.11
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 17:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9jPe239tutxJAwPUEzBRYpUwHN4ZUJdrFjWYiw63+Io=;
        b=vm+es5WMkwSHRmyeekLxbyg9I1h8O11eFFedrBIR27y2r24UrLwX7JJxw05WgPj4RM
         EyfLooe7U0emFhjBAOdPv4/SEgHcHibrheNQi4G3V42yn6MZB+y1inYa+GXyf6L+cW8n
         ls+NcH2BYuKPlABBHehCKL9mdSSmQ4ZCunyfP15zXjlpPO7C4OgJfQakks5QeelQYkJK
         KEMpaXXGnXxVsFqXKxJQbyOFps49Rvm1IVV4Ryrg4DX6Bpt6MtToj2bCjZfOxByk1P5f
         FLU8EJWUODQKy9buUgw+r1fhkMNTJL1VGhWA9AVSnRt0vlMzk7nsGnKG2UN/GGU88KKY
         qS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jPe239tutxJAwPUEzBRYpUwHN4ZUJdrFjWYiw63+Io=;
        b=LpysvpkVPwqcwb+mKywmmxYrFrMSimbj5KJzySVT3csL6lxb6/KrWyfJ0z+feglgDk
         hQB7BkpVo0MOqNVLKZYRBW0xjyaFAfO20T5A3JI8phlS11SnsOF5z9d6oJQx81TRaIMP
         2K1GORvbgm32b3ThrM0AnFiOlbXh1idrEDh+hjG4IsTzB14J+bdLHaCMYBEGOVdkGm/K
         TSXpYMbxp4cSLP2soNytiScyWFlfKLMEa0voOY7k9GAz16X4LlN1O9PkDX+8HfyaAHZ/
         drXGAfFDOaZwrsTOlpCT2RomCAbpTnEMVqVjmZxehbW+fAw7ET9F6sXuwGi4lRTvRmhi
         MxFg==
X-Gm-Message-State: ACrzQf0CsvXiq3M7trUyE9sNGr5EFtkpeLek5nNiK7N0vcUpTL82kUNc
        u4D4ajiOpUvE8NhPzjlz8jSpAA==
X-Google-Smtp-Source: AMsMyM6U9Cey2nRSPZfaUJdEJNBdCM6QSNv46ClQ2g2GG+o4MgLurpd5SHORGZ+F0V+hsUVy4Pl2VA==
X-Received: by 2002:a05:6638:2384:b0:375:2a77:5188 with SMTP id q4-20020a056638238400b003752a775188mr9570180jat.39.1667264363043;
        Mon, 31 Oct 2022 17:59:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q14-20020a056e02078e00b002ff36cb0a62sm3055224ils.27.2022.10.31.17.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 17:59:22 -0700 (PDT)
Date:   Mon, 31 Oct 2022 20:59:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] t5516/t5601: avoid using `localhost` for failing
 HTTPS requests
Message-ID: <Y2BvaXN2C325YUsz@nand.local>
References: <pull.1399.git.1667245638.gitgitgadget@gmail.com>
 <25cc0f6d91a9d23eb1b755e1463d672e4958a4e9.1667245639.git.gitgitgadget@gmail.com>
 <Y2BYKxxkG57XAV/1@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2BYKxxkG57XAV/1@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2022 at 07:20:11PM -0400, Jeff King wrote:
> > Let's instead use an IPv4 address that is guaranteed never to offer a
> > web server: 224.0.0.1 (which is part of the IP multicast range).
>
> This feels pretty magical. I think it would be pretty unlikely for it to
> have a web server, but I wouldn't be surprised if there are systems
> where we get similar IP-routing hangs.
>
> Is there a reason not to move all of these tests into t5550 or t5551,
> where we have a real http server? That would be less magical, and then
> this first test:
>
> >  test_expect_success LIBCURL 'fetch warns or fails when using username:password' '
> > -	message="URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" &&
> > -	test_must_fail git -c transfer.credentialsInUrl=allow fetch https://username:password@localhost 2>err &&
> > +	message="URL '\''https://username:<redacted>@224.0.0.1/'\'' uses plaintext credentials" &&
> > +	test_must_fail git -c transfer.credentialsInUrl=allow fetch https://username:password@224.0.0.1 2>err &&
> >  	! grep "$message" err &&
>
> could be more robust. It would actually check that we succeeded in using
> the URL.

It is magical, indeed. If it's significantly more difficult to move
these into t5550 or t5551, then I'm OK with this in the meantime (since
GitHub Actions really is our primary CI target that we care about this
not hanging on).

But assuming that moving these around isn't that difficult, I would be
slightly happier to see these tests in one of the aforementioned spots.

Thanks,
Taylor
