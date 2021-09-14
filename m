Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4C2C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 22:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3496360F25
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 22:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhINWMz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 18:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhINWMw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 18:12:52 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E1AC061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 15:11:34 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id a22so739651iok.12
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 15:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FLf36WJky8xtjvBvYwLlM7glmxrjADF/8bH24vd0ZAs=;
        b=Jc/eIWf1zVEI0y2lRcJyznPDxD8tjsTYhj893SzfTZmbXBDRh6VoLJ91wgbYK9pYUH
         cUgdRG53/KyswjGb7vO59u3hg2MjIWx+UmFIknCrsIxhSXbbyr1VB1vwCFHdTzZdtulv
         3beE5iEGzE0indx7QHP3ENvjnexa2dYszYfrMOa/TDJwMVmTAe7PorYKzjafMMyjnyND
         IjAQ6lJIrJ4v7gBF1fl87nwQan7B95x0BzMYZYDJaiBPMElPIBRxW1wShuK7+cKQTuf+
         y0hdpTyYAd3QaQ7PlKAaXrF8la2piSK+YglrZ+CXJdIqvwyXp5u/BO6cjWgxEyLpTt+t
         MyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FLf36WJky8xtjvBvYwLlM7glmxrjADF/8bH24vd0ZAs=;
        b=UjD7TZl7mAvIi5IzQXEuciz8HmBPAio69wdHrNHsZcWIg0oOyRUOZu3HPK7a4rPmD2
         6Cbnxl8Ikm8n0p6Qdj/tDkp3DNVJA7PRLHyVaJCpwGq2gWbs88uhkkXHiU8C/lwvsNJE
         glvfe6TxNIuuGLHRHDG/ge7RvBclErMYAJJKYniLMZPtOF9/7AMK6a8+rUHSyKcqUnqY
         yYaTnuOwLJONJ5cJ1iraY0uElLGF5PWDrkmf2PQR5uwV+zhbQgvY89j1SHjqd/pqi78i
         RJp6tXdpfHybsIcVFt0SEdLiBgEsZ0se+RSif7L5HJU1U5Q6d2Hxn3f+4GoWkKj8dpHO
         IA2A==
X-Gm-Message-State: AOAM532FLGBJQPdn49e0iGAuIqVtM50X1GPFZ5JJeVsqLDZkD0CGa67e
        r57YP3m9t3B/lYwguLhXmgczSg==
X-Google-Smtp-Source: ABdhPJyAiGdFAjfPzx6n9JtlrESw9s6MxDONFFUmiUYrzUh3LXPY+kRXsMFmyWE0WdMydPR+vSZOww==
X-Received: by 2002:a05:6638:24d4:: with SMTP id y20mr9805jat.27.1631657493575;
        Tue, 14 Sep 2021 15:11:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z16sm7731718ile.72.2021.09.14.15.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 15:11:33 -0700 (PDT)
Date:   Tue, 14 Sep 2021 18:11:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 7/9] ls-refs: ignore very long ref-prefix counts
Message-ID: <YUEeFENv04Ht5zXd@nand.local>
References: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net>
 <YUDBokYvEBnzwsIN@coredump.intra.peff.net>
 <YUEdqRQ4qQdHuSV/@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUEdqRQ4qQdHuSV/@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 06:09:45PM -0400, Jeff King wrote:
> On Tue, Sep 14, 2021 at 11:37:06AM -0400, Jeff King wrote:
>
> > +test_expect_success 'ignore very large set of prefixes' '
> > +	# generate a large number of ref-prefixes that we expect
> > +	# to match nothing; the value here exceeds MAX_ALLOWED_PREFIXES
> > +	# from ls-refs.c.
> > +	{
> > +		echo command=ls-refs &&
> > +		echo object-format=$(test_oid algo)
> > +		echo 0001 &&
> > +		perl -le "print \"refs/heads/$_\" for (1..65536+1)" &&
> > +		echo 0000
> > +	} |
> > +	test-tool pkt-line pack >in &&
>
> Yuck. While double-checking some refactoring, I realized this test does
> not actually generate the correct input!
>
> It omits the "ref-prefix" header. _And_ it accidentally expands $_ in
> the shell rather than in perl.

Hah, nice find. You'd think that one of us would have caught it earlier
given that we both discussed it.

Thanks,
Taylor
