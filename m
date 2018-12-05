Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E386211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 10:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbeLEKe7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 05:34:59 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37581 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbeLEKe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 05:34:59 -0500
Received: by mail-wm1-f68.google.com with SMTP id g67so12272922wmd.2
        for <git@vger.kernel.org>; Wed, 05 Dec 2018 02:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=T1GAdf6YLJDBoWRh9Oe3X2GJJ2Pcp934tdzPfnnanr8=;
        b=tPOQjKUiG25qQcBszpcobmyamrdewtx3h3+klkvKH+T9rtXH8fNn/TTmYkxAMFG5YS
         1hsRHc5dmK7x4z5GO69DDLR2ZPOd6GO1uu5Aub1+WAIFk+xepF5YlGLjjcOuPIT3XCJx
         1eTyfnuQ3FchBdxKmShfEyXN+4lLonkOMTwaQ0l1UhRpNW6vG7WEf8MJe6R0Y8qQ6t5z
         yOKMq8PqkgI7fNGOv9ZcZ2npNEnUyXSECfrodLGWVn0LmyMF/y934OS3k0ARilvHkvQM
         bPH1oiq5mN4G51YIgWdBgG2Nm8oDNa8W11XkzMwhNTnx5yQu+3CflZPfU4fB8DCwIkZ/
         Kw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=T1GAdf6YLJDBoWRh9Oe3X2GJJ2Pcp934tdzPfnnanr8=;
        b=P6NVsikOvRF82J7yIGHwAGF7hQV47SW9Gbz64ZAgy6mdlDYZUz3jZtoxV5hs0Wb/xO
         Fz780l8ka1Hfbqh7aMkDb/tDMoP3VqCuhTY6aSR6BVwRcCW126qYZ0N7yKWYsAppcqFt
         G4UyO+eUztFEBLjl26VVQcY/BLbhMC+ZDKJ8K6awEoUiHjiHC/o2hugBGUJ4wH8ozS0z
         kHof6z2kn9A7Cb+rYfJmMaft2pBLMOdkKxRDh49N0FWGUBYvkhZS2uqc3NKfSqU02BI0
         4BLN7++nSM76ixmLmQRz+mt9WpgIHAPKeykOeFztQqLp7xQdhJqxMmQyPOSLg5n1T9ZM
         jONQ==
X-Gm-Message-State: AA+aEWa6eKSFgVAcnORnNpI1zm7sgMxpDi4NGNkeqBIBn+RsgJuXWCwl
        oFw90j8rpXGKamN0P721QinZ+9uH8UM=
X-Google-Smtp-Source: AFSGD/U5AsS+hPwKAfp800eIm607SlHAx21uh/It3FQWZ0kQVrbmGaIKahA4eqPcjCHlSOH2hWsDpw==
X-Received: by 2002:a1c:b607:: with SMTP id g7mr16108184wmf.97.1544006097745;
        Wed, 05 Dec 2018 02:34:57 -0800 (PST)
Received: from szeder.dev (x4dbd715c.dyn.telefonica.de. [77.189.113.92])
        by smtp.gmail.com with ESMTPSA id a18sm25901255wrp.13.2018.12.05.02.34.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 02:34:56 -0800 (PST)
Date:   Wed, 5 Dec 2018 11:34:54 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] test-lib: add the '--stress' option to run a
 test repeatedly under load
Message-ID: <20181205103454.GJ30222@szeder.dev>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
 <20181204163457.15717-4-szeder.dev@gmail.com>
 <20181205054408.GE12284@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181205054408.GE12284@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Just a quick reply to this one point for now:

On Wed, Dec 05, 2018 at 12:44:09AM -0500, Jeff King wrote:
> On Tue, Dec 04, 2018 at 05:34:57PM +0100, SZEDER Gábor wrote:
> > +	job_nr=0
> > +	while test $job_nr -lt "$job_count"
> > +	do
> > +		wait
> > +		job_nr=$(($job_nr + 1))
> > +	done
> 
> Do we need to loop? Calling "wait" with no arguments should wait for all
> children.

It should, but in dash, ksh, ksh93, Bash v4.2 or older it doesn't seem
to do so, at least not on my machine, and I get back my shell prompt
right after hitting ctrl-C or the first failed test, and then get the
progress output from the remaining jobs later.

Bash 4.3 or later are strange: I get back the shell prompt immediately
after ctrl-C as well, so it doesn't appear to be waiting for all
remaining jobs to finish either, but! I don't get any of the progress
output from those jobs to mess up my next command.

And mksh and zsh can't run our tests, and I don't have any more shells
at hand to try.

