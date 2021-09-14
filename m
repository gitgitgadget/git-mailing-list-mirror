Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68CFC433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 01:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A68CF6112D
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 01:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhINBQX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 21:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhINBQW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 21:16:22 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113B4C061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 18:15:06 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id b10so14731084ioq.9
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 18:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Sprx5diJOtf7E+g06BpFBCUBwbGy6cZ7ejZ25cWt/Yc=;
        b=asu9So5xz9ZANGwitxRTsFTfgK2ZCMvvdxokX2kag8xY9Z/ZKM7l31BQ2/cqPhGncr
         5g1dK7SfqiMJ3YqwORT/Rdykp42xI/aTQjdUWkexPDIOwxF0rf0pFm2loqzEg8HqQrbH
         xT3bWdL6m9weIe56fwwt7oclYQAOfcfiudk/otSNwL4Nx9ciBUiz4BP2WDPpTcohKoGK
         43pyGWaBXLTJMGyOLoxUsWs9dyo3O8sADT4uQsZip4Y3zVDDVSkQp0ya3qiClCmwTlr4
         1rF945+mZvpY7kS6k+1xTrx2EWTXjB6hmJqyLKDi9qIEYDwYadYuputtv4uQ3apw1DqR
         hw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sprx5diJOtf7E+g06BpFBCUBwbGy6cZ7ejZ25cWt/Yc=;
        b=KZRblJ9UUHYd1gRNLKBxjyiFTCfon/gC2UxmlL8z0h81J5CfmU0AAP7QA+ZTK//Hsg
         ZrHVL8mcAFTHwM2+kAJFC2Ca3bVoNhrIXt7lHK1N74IvAJZyQsdLq+BnS7fu/4r1RGgG
         vlJRAmdoq9ZFvJSeIRCEhRjDw/kgURujv/KSjcgOGGi3+WZ0w1tGDs/psWAItOXbiWCy
         3d7tcI9PvGVA5r4M52tq5LqsXyxCED5jdCHRoJm2Y3apwIFyfiqbz5CuIoBABBoY37+m
         n3z5bYsc300+jwNr+TSoRJl3OhIXvGOxx1h/EOpitRrQFuS/Kx4neRrI5/6Yks69tgEA
         QLUw==
X-Gm-Message-State: AOAM532GYQsB0QaEt0FboOJNucrTdc697rbR/KKaSZhkYlR54Ik+9sIz
        iALCPIDe8mtX5HVf2/puG+Zd2Q==
X-Google-Smtp-Source: ABdhPJzMlXA5SkiZeN0/hBbT0ct5dpuKa88xyK1iqrULHY8myZSqZ+Rf3VX89IywosvOEVNdmlJWWg==
X-Received: by 2002:a05:6638:b10:: with SMTP id a16mr12591914jab.149.1631582105482;
        Mon, 13 Sep 2021 18:15:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s5sm5857126ilq.59.2021.09.13.18.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 18:15:05 -0700 (PDT)
Date:   Mon, 13 Sep 2021 21:15:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 3/4] midx.c: respect 'pack.writeBitmapHashcache' when
 writing bitmaps
Message-ID: <YT/3mEv9OnC/CH67@nand.local>
References: <cover.1631049462.git.me@ttaylorr.com>
 <be8f47e13c612f2fbe4d5f4f49794529b9424664.1631049462.git.me@ttaylorr.com>
 <xmqqee9tia2b.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqee9tia2b.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 12, 2021 at 05:38:36PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > +static int git_multi_pack_index_write_config(const char *var, const char *value,
> > +					     void *cb)
> > +{
> > +	if (!strcmp(var, "pack.writebitmaphashcache")) {
> > +		if (git_config_bool(var, value))
> > +			opts.flags |= MIDX_WRITE_BITMAP_HASH_CACHE;
> > +		else
> > +			opts.flags &= ~MIDX_WRITE_BITMAP_HASH_CACHE;
> > +	}
> > +
> > +	/*
> > +	 * No need to fall-back to 'git_default_config', since this was already
> > +	 * called in 'cmd_multi_pack_index()'.
> > +	 */
>
> It's probably not just "No need to", but calling default_config() or
> any "more generic" config this late is a wrong pattern [...]

Makes sense to me, will apply. Thanks!

Thanks,
Taylor
