Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9934420954
	for <e@80x24.org>; Tue,  5 Dec 2017 00:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751754AbdLEAJF (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 19:09:05 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:44146 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbdLEAJF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 19:09:05 -0500
Received: by mail-pg0-f41.google.com with SMTP id j9so9399606pgc.11
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 16:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tZl7tiDcT1PVhFCjm0GL8Fa5WoaW/S/Sm+GsZOOPxig=;
        b=DPSNBlnBeL/em8I/9KzdHW2HoRl2s+O/kA9WY9HHdxUz2z04QCXFGv6/3lfdFr7t6K
         Xt4LdfMBmhGEDvxfXEbxhrydZjPphJ33nRJZvs0UtBg/+7lf8Lh1f+NmFS6lnkX2woU3
         H6hMzLppLo4LdzI7kLVMrPu+CqPuGbF85V2bqhiotu8Th03kE4GuzNaHGhlo7zcoPglS
         zP0gbLdm0bpMUxQB057gROP/w8vG4Q/cCujtB74GbvD5+HCayBK/QTjkjxjge/nJtLaQ
         HhuVvBmAvy2hSaesK+z1VTDKqPlnasfYBXZwmKVhsXV7wpJNrMDMMOuGLklXTdMecest
         evkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tZl7tiDcT1PVhFCjm0GL8Fa5WoaW/S/Sm+GsZOOPxig=;
        b=glzRq4q8FpqznQOtIcec2IQgiq8ceK3syRvYtAbmmQYDn5QrYji+bzauIeYqG6LLpM
         g5mejl8ij9qotT89pa3BE4iTn3jKd6RPIReyTir50Zv3IWvHuIl0+YhHXfWtBQT92M3P
         CgYdBpXAl971UPDaJ51snbfykQfd8vlyBp1C4gIvH9U71O75KacPl/jjksg55FxoiwaG
         KEjChuPvCgnF28LrVjCwvOwYJyyPGdaRhO8YxTGQD/k9J3CDdei/kCqZeqFeOOxsBKVy
         +7d88oO6tLFJXqQ/eMwxhPxGmvtELjzYKNqLWmUZGd3N5uCFHZD2HwnGWalzwa0fZytZ
         HlxQ==
X-Gm-Message-State: AJaThX5jAIp+FB+gOjwwdPk6SVCx8QTWBDCAuP1t0nrW1CInz0SOfBYF
        jyr8f0ToJ8hFRMjxwnRr8I/wOw==
X-Google-Smtp-Source: AGs4zMb3RAfAFEBPxQK6yl47DsMkfHMKqc9A7jnMjZGFuMBLitD/mf0R+rwwzh2F2AZBnD9oapngIQ==
X-Received: by 10.101.67.140 with SMTP id m12mr15157310pgp.51.1512432543765;
        Mon, 04 Dec 2017 16:09:03 -0800 (PST)
Received: from google.com ([2620:0:100e:422:f83a:9bb:41ed:d5e6])
        by smtp.gmail.com with ESMTPSA id n24sm27053583pfi.33.2017.12.04.16.09.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 16:09:02 -0800 (PST)
Date:   Mon, 4 Dec 2017 16:09:01 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH] pathspec: only match across submodule boundaries when
 requested
Message-ID: <20171205000901.GB52452@google.com>
References: <alpine.DEB.2.21.1.1711260210060.6482@virtualbox>
 <20171128232237.54453-1-bmwill@google.com>
 <alpine.DEB.2.21.1.1711292221060.6482@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1711292221060.6482@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/29, Johannes Schindelin wrote:
> Hi Brandon,
> 
> On Tue, 28 Nov 2017, Brandon Williams wrote:
> 
> > Commit 74ed43711fd (grep: enable recurse-submodules to work on <tree>
> > objects, 2016-12-16) taught 'tree_entry_interesting()' to be able to
> > match across submodule boundaries in the presence of wildcards.  This is
> > done by performing literal matching up to the first wildcard and then
> > punting to the submodule itself to perform more accurate pattern
> > matching.  Instead of introducing a new flag to request this behavior,
> > commit 74ed43711fd overloaded the already existing 'recursive' flag in
> > 'struct pathspec' to request this behavior.
> > 
> > This leads to a bug where whenever any other caller has the 'recursive'
> > flag set as well as a pathspec with wildcards that all submodules will
> > be indicated as matches.  One simple example of this is:
> > 
> > 	git init repo
> > 	cd repo
> > 
> > 	git init submodule
> > 	git -C submodule commit -m initial --allow-empty
> > 
> > 	touch "[bracket]"
> > 	git add "[bracket]"
> > 	git commit -m bracket
> > 	git add submodule
> > 	git commit -m submodule
> > 
> > 	git rev-list HEAD -- "[bracket]"
> > 
> > Fix this by introducing the new flag 'recurse_submodules' in 'struct
> > pathspec' and using this flag to determine if matches should be allowed
> > to cross submodule boundaries.
> > 
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> 
> Could you also add something like
> 
> 	This fixes https://github.com/git-for-windows/git/issues/1371
> 
> at the end of the commit message, to keep a reference to the original bug
> report?

Yep! I can do that.

> 
> >  4 files changed, 22 insertions(+), 2 deletions(-)
> 
> Phew. That was much smaller than I expected.
> 
> > +test_expect_success 'tree_entry_interesting does not match past submodule boundaries' '
> > +	test_when_finished "rm -rf repo submodule" &&
> > +	git init submodule &&
> > +	test_commit -C submodule initial &&
> > +	git init repo &&
> > +	>"repo/[bracket]" &&
> > +	git -C repo add "[bracket]" &&
> > +	git -C repo commit -m bracket &&
> > +	git -C repo rev-list HEAD -- "[bracket]" >expect &&
> > +
> > +	git -C repo submodule add ../submodule &&
> > +	git -C repo commit -m submodule &&
> > +
> > +	git -C repo rev-list HEAD -- "[bracket]" >actual &&
> > +	test_cmp expect actual
> > +'
> 
> Nicely prepared for a new hash function, too (no explicit SHA-1).
> 
> I wonder, however, why we can't `git checkout -b bracket` and
> `test_when_finished "git checkout master"` and void those many `-C repo`
> options. But then, it is actually one of the shorter test cases, and
> pretty easy to understand.
> 
> However, I would still like to see `test_tick`s before those `git commit`
> calls, to make the commit names reproducible.

In v2 I added the calls to test_tick.  I've never used the function
myself so hopefully I used it correctly! :)

> 
> Thanks,
> Dscho

-- 
Brandon Williams
