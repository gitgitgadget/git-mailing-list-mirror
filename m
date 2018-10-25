Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDD141F453
	for <e@80x24.org>; Thu, 25 Oct 2018 20:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbeJZFDf (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 01:03:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42942 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeJZFDf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 01:03:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id i4-v6so4544069pgq.9
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 13:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ge422rROTIUNPiBm5U2DEKUTh3KFGCAAIFd317IHLCw=;
        b=Hw9rGGn7fsFs5VcEfHPMXhl66OMDTq9cywkdfj+vt9sDwyUGLEpY4P6j2YysX8eCjV
         boPj8hYsMb1S07afntRRBazWiIlAFkg86g4Wq4WGoL+T4mrxjJiQzoCNFS4R/SmVp2z8
         G5y+7yQLGDMMpiVMWCjMGlUIB78C3g6OR57lcT6ikPydzZPcdU0AgfwdL/gDUNGz4z2r
         xBumbIIh3Es9qPhxrr2oMKK0XDJdmXgchrf1cbjZxnL1TDlJZv+VF6axkR5w5wm2fmcv
         ckVLRrmcOG2mSkOkmSCjh9O4W7giiD7iE5zdVCmpTmsSDaMFcb5mU893J3LWy4S55y+M
         vK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Ge422rROTIUNPiBm5U2DEKUTh3KFGCAAIFd317IHLCw=;
        b=R/9aBYDWf7FyOE8qRbxsCiAK6lz35H3UzVnBS0/Z3D3ehBTyNVGBHwjDRG++1Y7Vkp
         SIv9EkfFAnwoj6OAO9LY25Cim29qYkKOICYCD0chEaQgf/rKia4t1hJGgnRZEMF3+Bhv
         Lm2ocU1UFpElnNpte9xaOslMsu18OiHEye2ERNKTzUJhCN9+2raQXjsVtD5KhoAfpITF
         XKONAgl2QXb+nWgC0lZQP2TxCvMMiJlLnwiYJZV3kTQUYFdDSavLUJBq8ButBuIVKEqX
         2m5RA/EDHPbrQmp1WNtm++RpbdQeUfxOBmvkQGkbYX5jDa1ZswzS6GOJ+KTvKyXIhxeR
         DqUw==
X-Gm-Message-State: AGRZ1gLhrA1zC2ULCui0Jq9HJ8XnaX4LC+b52DOPNdOH1eZjuzqZOzSQ
        qiOlw0PtRga3yWEs/0ZIg+u8PxphgV542A==
X-Google-Smtp-Source: AJdET5c670GFiBnxaqfW7V4sfzjY8IMX++gCdOeduyL5vkTZ9O+h3CahIOOKbs0//zVg8S6Jv911rg==
X-Received: by 2002:a62:571b:: with SMTP id l27-v6mr646741pfb.209.1540499361810;
        Thu, 25 Oct 2018 13:29:21 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id i4-v6sm10561638pgt.4.2018.10.25.13.29.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 13:29:20 -0700 (PDT)
Date:   Thu, 25 Oct 2018 13:29:15 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v3] archive: initialize archivers earlier
Message-ID: <20181025202915.GH233961@google.com>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        peff@peff.net
References: <bc6f20274dfe11f1451745e0accb065544cc59ca.1540244445.git.steadmon@google.com>
 <39a4e7bf8f3ebc5803393f357d1ee7dc9806252f.1540251936.git.steadmon@google.com>
 <xmqq4lddtibc.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4lddtibc.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.10.23 13:09, Junio C Hamano wrote:
> steadmon@google.com writes:
> 
> > diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> > index 2a97b27b0a..cfd5ca492f 100755
> > --- a/t/t5000-tar-tree.sh
> > +++ b/t/t5000-tar-tree.sh
> > @@ -39,6 +39,8 @@ test_lazy_prereq TAR_NEEDS_PAX_FALLBACK '
> >  
> >  test_lazy_prereq GZIP 'gzip --version'
> >  
> > +test_lazy_prereq ZIP 'zip --version'
> > +
> 
> There are a handful of zip implementations; Info-ZIP found on many
> Linux distros does support 'zip --version', but we may want to make
> sure this test covers different implementations of zip sufficiently.
> 
> Queuing this patch (or an update of it) on 'pu' and hoping those
> with zip from different origins to try it would not help very much,
> either, as zip implementations that do not react to "zip --version"
> would silently turn the prereq off without breaking anything.
> 
> In any case, please refrain from adding any ZIP prerequiste to t5000
> which is about tar; t5003-archive-zip may be a much better fit.  It
> has an already working machinery that validates the generated zip
> archive under UNZIP prerequisite, so we may not even have to invent
> our own ZIP prereq if we did so.

Ack. This has been removed in v4. V4 also has a test case in t5003 based
on Jeff's advice.

> > @@ -206,6 +208,19 @@ test_expect_success 'git archive with --output, override inferred format' '
> >  	test_cmp_bin b.tar d4.zip
> >  '
> >  
> > +test_expect_success GZIP 'git archive with --output and --remote creates .tgz' '
> > +	git archive --output=d5.tgz --remote=. HEAD &&
> > +	gzip -d -c < d5.tgz > d5.tar &&
> > +	test_cmp_bin b.tar d5.tar
> > +'
> 
> We try to write redirections without SP between redirection operator
> and target filename, i.e. "gzip -d -c <d5.tgz >d5.tar".

Fixed in v5.
