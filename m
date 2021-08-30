Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC740C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 22:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CF2F60FED
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 22:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238896AbhH3WeQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 18:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238820AbhH3WeO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 18:34:14 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B359C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 15:33:20 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id m11so13872825ioo.6
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 15:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O26cvwpJPB25tGFD+YiWHGAtMM5Av0oN5C2ji+z00MY=;
        b=zdjm7SW33yTvCKwEbunky5W240jnpFLAKIncJW5Dg+EY1ggtIU85JuucGZ7qjYQGjg
         2/yQSRTOD99FEj9dAYOe8nEuNzAPCs7NVQkZ510GCL2CXohvDZCcTaxwLhlFpeEUFk0M
         x1kykXP8REXjrW8HEJYYfqYC+2pzEhsDWbE0IohU7jy8bGSoOEfRXBFk4fRMyGTjY1an
         9hGApYD/B0Aq8Womlk43z0i/c5O+9FaqCzBMIFq3KRQqVbLn01thymbSh7fIBxWGgmFP
         LoMKnLEty9JzILHokxBVBi6H0j5x8BN/XjqTjEeWb2n4ZRKvXaumMHnRdGZ3IVpBoHQn
         D+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O26cvwpJPB25tGFD+YiWHGAtMM5Av0oN5C2ji+z00MY=;
        b=sKG7p60HVX2INIyU4/P5l91CdK92P4eoNr61GEEgfRKj0JeP5W3dFAEplXvR9BqbmN
         Iu6sMu/xs7s9QJh4bl2ZIMqz0o/7AxtZxoJwI5bAJLETi88nI64av1A16tQtyJEiXgb/
         Sj15NwyiAkcfDuAixSn5MdRTyZ+X4nv0wnKBQx9/xJ1+30nv+yrfbyIOLZe1Mu7+Hq0/
         veBydkKM27zw7EeNq4Fc9DzlF28d5m5HxsxYL8eBLxGo8wbG9mpcZV7VBtFmtkFba7MJ
         rpWJdEvz4dNtp0U21TXR+FyifzRoGebuAQn6RgD3CMkKObLrsJDDYQKjnD5t1HOL8t8+
         KdKQ==
X-Gm-Message-State: AOAM533wtEP8E3ncPmgu2KDbH4UG9SoW+TQkhV7YDHMgsT/YVKWsCDle
        RatUrdlG5ws+s6b7FzY2b24bCA==
X-Google-Smtp-Source: ABdhPJynrOBJ1FaznrWd1Uigh2Qt6M+1EudZ74tCixket9sUt7SEUZhG1cJN3AUDzCt3BnsDt6bbJA==
X-Received: by 2002:a6b:ec0b:: with SMTP id c11mr19550662ioh.207.1630362799627;
        Mon, 30 Aug 2021 15:33:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p19sm9206785ilj.58.2021.08.30.15.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 15:33:19 -0700 (PDT)
Date:   Mon, 30 Aug 2021 18:33:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        peff@peff.net, dstolee@microsoft.com, jonathantanmy@google.com
Subject: Re: [PATCH v4 05/25] midx: clear auxiliary .rev after replacing the
 MIDX
Message-ID: <YS1croR3etCfMQhR@nand.local>
References: <xmqqy28qlcow.fsf@gitster.g>
 <YSVuUYFh7lmhNlEy@nand.local>
 <xmqqo89jbf49.fsf@gitster.g>
 <YSko4OwwPb7MwEMa@nand.local>
 <xmqq4kb797xc.fsf@gitster.g>
 <YSwhNxqAS8JajA7p@nand.local>
 <xmqqfsur7otx.fsf@gitster.g>
 <YSwpsp/hQsPFnj+I@nand.local>
 <YS1XOMtj94BcI9HM@camp.crustytoothpaste.net>
 <xmqqmtoy1s9s.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmtoy1s9s.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 03:28:47PM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
> > Yeah, this is a possible problem.  You can also see it when using git
> > index-pack outside of a repository with an incorrect --object-format
> > option.
> >
> > I'm not sure how folks want to deal with that; I'm just fine saying,
> > "Well, don't do that," but other folks may have different opinions.
>
> OK, so if we go back to the original breakage of the test script
> that triggered this discussion, the right solution would be to make
> sure both test repositories/object stores are prepared with the
> algorithm specified with GIT_TEST_DEFAULT_HASH?

Just to make sure do you still see this as a separate issue from running
the midx builtin outside of a repository?

I.e., if we require the midx builtin to be run in a repository, it
side-steps this issue (but presumably not completely, and so we should
deal with both eventually). I want to make sure that I'm on the same
page before I drop 25+ emails on the list.

Thanks,
Taylor
