Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 484E21F516
	for <e@80x24.org>; Wed, 27 Jun 2018 18:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965689AbeF0SSN (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 14:18:13 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46492 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965557AbeF0SSM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 14:18:12 -0400
Received: by mail-pf0-f196.google.com with SMTP id q1-v6so1341651pff.13
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 11:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YTNOLDgdLkOer9tw7oOlKvcHbSJaW45oSgB+fDRD4O4=;
        b=cZUyVEaWHX2xOc4P2rI+/1mTBFC8bKtPaNfcYRX4Aik+y9WT4FQH+XUGlJ/P80RqSx
         pZGHsHSg5xI54BOCb7BHA3tpqCAKhAJCtpCYeB0fW8R8IDmebRyzZshfpTogGoz8pII4
         481lsZzUztz9mDHhTOIGhR0Osf3yyraQ7q/BPxLeQVyvLOiHirwT5nLU+xbclAS9YR0n
         QrKbjUS0WxNS4vROvzxkSad/4JnDq/M8VW6C2Itm027j/7fvOcJZo/FV76x6SiuiQoX/
         wY4yce3+0gNgQUDx7Tz2hE5VqM/+kbTIJ4C0A+niGV24M5Il+RsFaMJ6CWUOShhA5Nm4
         jGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YTNOLDgdLkOer9tw7oOlKvcHbSJaW45oSgB+fDRD4O4=;
        b=ZSzpxT0Rn4dBZrLLdXBxLYD8/DXRCmr9BSwJqmk3xUGPpiMCmoPC9mMGcKJz9RtsDY
         MSfiFmY5z1exONdnSIIEytnNxOLBYw0LIg9iL/Az4ZF1eQt2P7T71PyLZx723qlMTus+
         d0jFT19mEH2FGSdlg23hBie1LYAdUXvS7RQa+6oUO3Wdy23HMN8gExsyQlVqD9gQtv22
         +y+IosKQKxOrNtr7Chr/AAvts6mlL4R2z5yfWIlaJzFXulKRmvsHaRfYmA6H+kpZ9sma
         AwXQJygYhEVfTKFl8LXFHgrLisU2rkbFsT43UCL/yXOuNy9kWQXt1mlsKb3JLG2+d63R
         heiw==
X-Gm-Message-State: APt69E1DKdExIMXCM1zEnLCNFptIcnLqX/TxJTRQAfGh35oEygtQEI/i
        cXaQHHDDyk4seet9DG2XhN+6sA==
X-Google-Smtp-Source: ADUXVKL8eXIVWUypvMHCpZw4nzHUy3PcSrOTInh9qmmtm3J2FitUgmtoobXBrfZQ8aQ3p6i4BaDv2A==
X-Received: by 2002:a63:41c6:: with SMTP id o189-v6mr6264450pga.323.1530123491469;
        Wed, 27 Jun 2018 11:18:11 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id z19-v6sm7056119pfm.187.2018.06.27.11.18.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 11:18:10 -0700 (PDT)
Date:   Wed, 27 Jun 2018 11:18:09 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v5 8/8] fetch-pack: implement ref-in-want
Message-ID: <20180627181809.GJ19910@google.com>
References: <20180626205438.110764-9-bmwill@google.com>
 <20180627180943.35472-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627180943.35472-1-jonathantanmy@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/27, Jonathan Tan wrote:
> > +test_expect_success 'setup repos for change-while-negotiating test' '
> 
> The tests that follow are basic ref-in-want tests, not tests on a repo
> that changes during negotiation - this would be just "setup repos for
> fetch tests".

That looks like a copy-paste error.

> 
> > +test_expect_success 'fetching with exact OID' '
> > +	rm -rf local &&
> > +	cp -r "$LOCAL_PRISTINE" local &&
> > +	git -C local fetch origin $(git -C "$REPO" rev-parse d):refs/heads/actual &&
> > +
> > +	git -C "$REPO" rev-parse "d" >expected &&
> > +	git -C local rev-parse refs/heads/actual >actual &&
> > +	test_cmp expected actual
> > +'
> 
> Also verify that "want-ref refs/tags/d" is being sent over the wire, and
> not any "want ...". (If not we can't distinguish these from the usual
> non-want-ref behavior.) Same comment for the other tests.

I think your mistaken on how what this test is looking for.  no want-ref
line is going to be sent because we're requesting an exact OID here, not
a ref.  But I can add checks for want-ref in the tests that should be
sending want-ref.

> 
> Other than that (and my other comments), this patch series looks good.

-- 
Brandon Williams
