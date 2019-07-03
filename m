Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D05C41F461
	for <e@80x24.org>; Wed,  3 Jul 2019 20:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfGCU6C (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 16:58:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43267 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfGCU6C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 16:58:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id i189so1840880pfg.10
        for <git@vger.kernel.org>; Wed, 03 Jul 2019 13:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AVFeMXjAyjVG5ujePxgT4iNWkCtf5we93imgmrX9RGI=;
        b=YruNp8WEOqn/P/S8V2kWquZiSiOTCmvFGVaybzNJwq4Jy8GgY3LhfEibRcPmskJuCX
         twQ+6i1TsYxz5KlQhFmatFnV7dnG1Tcv+bMFLYmqf4hQncg2WRMpv7LTjPDMkusQWA46
         cDacysCwg/dq3jtK+mY+Ax0q4LTvvm7YE4FB3hYLv6ppDaibWdudDOJTQ42+sFbrVtlu
         CTuMrpuTLNqHu0nAQ91a3TKCiOSkte565tnO8yItQPb/YajYbOyKLU2IWRpC549FjAKu
         XoiL5ecbGtkk9uvtwOyVfgmpTawpb2Btxk7FYu1xa0yN1qfZVMcLOXZDFX/qq/dnOvja
         u4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AVFeMXjAyjVG5ujePxgT4iNWkCtf5we93imgmrX9RGI=;
        b=XHgxLVYWtdDtXEo0Xw78N3JNv5nSDEim/THNrNpDElMFAB2Z5Cz4Nj3rPVo1u7Z+sy
         M2rxfbVvyCEf1+e8NZguRO77mrtf7HFfhQ54oGfTfa4vEvYQs+uhaART0VPhJW7hPiKQ
         UoJwfHy7iZqbUB5YGpWun4F3NCXY4TD6PCulj0R1O4En9m3eHgKQt6GXhLeDwbuPPnsT
         7WuuqsMg7qiEXxzN8NuEhF86zYUKReXVP8j/YFPWLnTSQP7jqwCv4+Mpj+DuOVQjOZle
         Btq7BDVABrA7iwa0SGWiNydy+fBLHFg+p7HQ/LGEKopLIde6qRaUQDi85BtjByrUdl32
         I8rA==
X-Gm-Message-State: APjAAAVUOmUWm21Q6Y62kSY9Q9Mb1XeH49YnF20OIoabLAeJ7h+W07Ve
        k62HA4HXaz8c7W/rHHYGlDjo2NRzM9kqrQ==
X-Google-Smtp-Source: APXvYqyF2p6BIxnkbTSp73EnUXkN6UxuZREqZkFN9CmjZmeLD99CIPee2NtFGhGzkME6IgJo6ciKVQ==
X-Received: by 2002:a63:460c:: with SMTP id t12mr36203528pga.69.1562187481097;
        Wed, 03 Jul 2019 13:58:01 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id a3sm3246970pje.3.2019.07.03.13.58.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 13:58:00 -0700 (PDT)
Date:   Wed, 3 Jul 2019 13:57:55 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] transport-helper: enforce atomic in push_refs_with_push
Message-ID: <20190703205755.GF121233@google.com>
References: <20190702005340.66615-1-emilyshaffer@google.com>
 <nycvar.QRO.7.76.6.1907021540330.48@tvgsbejvaqbjf.bet>
 <20190703185535.GC121233@google.com>
 <nycvar.QRO.7.76.6.1907032137210.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1907032137210.44@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 03, 2019 at 09:41:46PM +0200, Johannes Schindelin wrote:
> Hi Emily,
> 
> On Wed, 3 Jul 2019, Emily Shaffer wrote:
> 
> > > > +	up="$HTTPD_URL"/smart/atomic-branches.git &&
> > > > +	test_commit atomic1 &&
> > > > +	test_commit atomic2 &&
> > > > +	git push "$up" master &&
> > >
> > > It would be more succinct to do a `git clone --bare . "$d"` here, instead
> > > of a `git init --bare` and a `git push` no?
> >
> > I'm not sure I would say "more succinct." This leaves the test with the
> > same number of lines,
> 
> No, it does not, as `git clone --bare . "$d"` does _both_ the initializing
> and the object transfer.
> 
> It only saves one line, of course, but do keep in mind that anybody
> running into any kind of regression with your test case needs to
> understand what it does. And from experience I can tell you that reading
> any test case longer than 5 lines is quite annoying when you actually
> only care about fixing the regression, and not so much about the wonderful
> story the test case tells.

I suppose I'm confused, then, as I understood you were asking me to
combine my three test cases into one, which naturally makes the test
itself more complex and longer to read. Which do you prefer?

> 
> So in a sense, I guess I would even suggest to move as much of the setup
> for your test cases outside, preferably into an initial `setup` test case
> that initializes the minimal scenario required by the regression test
> case.
> 
> Thanks,
> Dscho
