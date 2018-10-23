Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBF751F453
	for <e@80x24.org>; Tue, 23 Oct 2018 00:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbeJWIoL (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 04:44:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38036 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbeJWIoL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 04:44:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id f8-v6so19786664pgq.5
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 17:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FW2UFJx35ERjzuOahltuzPh/l+i4jtfQDSAcW9UjAfE=;
        b=oC7qamoHH5rHLcuPVcqbz38jo5u4wRQGnrunKWVw3Ve7hBnTa9FvOc39BLFRsMtIxY
         vQLLod+gsjfzKOvhUP5NUmNMBlDChg/YXYr+1X/uAT8p1rA8CtM6E1BrYPY7fdujtsxG
         wgMlHbuHdLzAI0IuHgytSB4y6rUAVsWUJd7XSfv4gTRuVEzmCsZd5xFOKoeIFlQmgngG
         0CrJjZPYPVjr5nHikzTomiVDIO54VhWtmnD9lmeQbt4pM7MA7DGAQeilUUuqlwXzebJG
         jEfl1pvxYb9PtZEPFMOZvqDFrvstZAdjvD9QZFLl5hmXFvbPFggEfDTqBq4aD9nImEBN
         iMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=FW2UFJx35ERjzuOahltuzPh/l+i4jtfQDSAcW9UjAfE=;
        b=ftJ2AxacEaB2RVTu0PkXERnH0mLAOPgsylHCysi6CKJgfGifJcUBObPT6a5ZnqO3Rq
         PPSiGsztUxD0kPAoqPZO8xYwTkJWDrc4vwa4SglglT9pU9ifALELCSpMgv72zjaw0LaS
         EU934x/gw798IDxNhR1GEF7UOYkIcKj8Xw1fzk60KSEgkc885hEZ7Jo4HBCn2afdi4Gx
         A++gH8o/zIW/mmqoKORmSpj/mboFvqMtQz8pQ+J1myNlXFo7CeR1DNQ2hVlqaFK182V3
         /fgBMR4I+LZUgyybitKUnir2BDTOi38+06syzMec74iXeoTGmjljAwsfaTMIjxGseHjb
         a/MQ==
X-Gm-Message-State: ABuFfoi6n6MreJLmFZNdFaZNt9Xe+dUYGKXxZkDx7Q3EMdS9RhAq8Me/
        Z/nh7sNQ/U+DJCvn5Gz2TAvd02qaNfu0Mg==
X-Google-Smtp-Source: ACcGV61Jn/DzQWz+XDjmtwyeoFjAOiRQa34BQB3AQxP/6cVsTnYyiS2TsvLWKf9xUPKuX+aRzgJkyA==
X-Received: by 2002:a65:4301:: with SMTP id j1-v6mr28674154pgq.279.1540254200610;
        Mon, 22 Oct 2018 17:23:20 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id p1-v6sm37488707pff.128.2018.10.22.17.23.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 17:23:18 -0700 (PDT)
Date:   Mon, 22 Oct 2018 17:23:13 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] archive: initialize archivers earlier
Message-ID: <20181023002313.GF233961@google.com>
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org,
        gitster@pobox.com
References: <cover.1539990488.git.steadmon@google.com>
 <bc6f20274dfe11f1451745e0accb065544cc59ca.1540244445.git.steadmon@google.com>
 <20181022223536.GB19019@sigill.intra.peff.net>
 <20181022235127.GE233961@google.com>
 <20181023000616.GA27393@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023000616.GA27393@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.10.22 20:06, Jeff King wrote:
> On Mon, Oct 22, 2018 at 04:51:27PM -0700, Josh Steadmon wrote:
> 
> > > > +test_expect_success GZIP 'git archive with --output and --remote uses expected format' '
> > > > +	git archive --output=d5.tgz --remote=. HEAD &&
> > > > +	gzip -d -c < d5.tgz > d5.tar &&
> > > > +	test_cmp_bin b.tar d5.tar
> > > > +'
> > > 
> > > This nicely tests the more-interesting tgz case. But unfortunately it
> > > won't run on machines without the GZIP prerequisite. I'd think that
> > > would really be _most_ machines, but is it worth having a separate zip
> > > test to cover machines without gzip? I guess that just creates the
> > > opposite problem: not everybody has ZIP.
> > 
> > Added a test to compare the file lists from the .zip file to the
> > reference .tar file. I'm not sure if this is the best way to do things,
> > but it at least verifies that a .zip is produced. However, it's brittle
> > if the output of "zip -sf" changes. Let me know if you have a better
> > idea.
> 
> I wonder if we could do something more black-box. What we really care
> about here is not the exact output, but rather that "-o foo.zip"
> produces the same output as "--format zip". Could we do that without
> even relying on ZIP?
> 
> I think it should follow even for tgz, because we use "-n" for a
> repeatable output. But there we are relying on an external gzip just to
> _create_ the file, so we'd still need the GZIP prereq.
> 
> Hmm. Looks like we already have a similar test in t5003. So maybe just:
> 
> diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
> index 55c7870997..cf19f56924 100755
> --- a/t/t5003-archive-zip.sh
> +++ b/t/t5003-archive-zip.sh
> @@ -158,11 +158,16 @@ test_expect_success 'git archive --format=zip with --output' \
>      'git archive --format=zip --output=d2.zip HEAD &&
>      test_cmp_bin d.zip d2.zip'
>  
> -test_expect_success 'git archive with --output, inferring format' '
> +test_expect_success 'git archive with --output, inferring format (local)' '
>  	git archive --output=d3.zip HEAD &&
>  	test_cmp_bin d.zip d3.zip
>  '
>  
> +test_expect_success 'git archive with --output, ferring format (remote)' '
> +	git archive --remote=. --output=d4.zip HEAD &&
> +	test_cmp_bin d.zip d4.zip
> +'
> +
>  test_expect_success \
>      'git archive --format=zip with prefix' \
>      'git archive --format=zip --prefix=prefix/ HEAD >e.zip'
> 
> which I think exposes the bug and can run everywhere?

Makes sense, thanks!
