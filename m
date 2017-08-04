Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21BF12047F
	for <e@80x24.org>; Fri,  4 Aug 2017 17:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753124AbdHDRFR (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Aug 2017 13:05:17 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33929 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752617AbdHDRFR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2017 13:05:17 -0400
Received: by mail-pf0-f171.google.com with SMTP id o86so10139300pfj.1
        for <git@vger.kernel.org>; Fri, 04 Aug 2017 10:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yGUas0q2jzSDidLuwD6Mslz50kE2ZCf1k20qPMSpPG4=;
        b=JXAjDpSmSVxFHXSFpxq1I1dSRIDTDpbxB+15QCUibeC+6j4VbM70IjupE5K7YE1AWN
         6t4SUH0L6Rc68Z8A3pOgIQmEBA0I9vurARxGHIXjD6Tmw5lPhUAN3RZYw6g0vqZCvSzf
         WTRdahAZT39QkI6X77Q2fatXWrLlYrrOr7oHptqEhUTRQl34Pv1li2cAvsFOQidTRee/
         AOI2ZWi0amq88cSuItIYwQxVBwCchjbgCuVIvaaQaTFzqkGl3f2Toh+E+Y0YCVBy5SaW
         fZV0ZM6GfdBK+U155Dn+BWZCS7cyfGYNs1wKw28hGjLEKRAEiffHMuODZRqXoN/ky6de
         vH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yGUas0q2jzSDidLuwD6Mslz50kE2ZCf1k20qPMSpPG4=;
        b=QwLIY3tEWHi1gCVAjkxgc3+SOje+ORGYawGUuBmpHR59TbHi5PRXYP22cJbwWaggyF
         7bDcYW8VGxdWtxrpfsZm+CTrU7e83yHGF24Wp18u9yXOusxj7Hil1I9ThzI+SXb/xx51
         LyyDccLfxBIIq0WLXu3ZyaEurrkh/Fyy4DFIBX7sZfzcgbJaNCE2HMeDAqyfpKi6G/2l
         4Z/OVBFSyxpXDL7RtS7Bda9ngHMryulmf1Mj6WzFGnh3fd0PVyHaJOodIYE9c/BALoDZ
         zMqSLCEK0Rbwy3Bk6K+iz3iQ92ZU7E7Th2YDFs24GGIHi0vZHm5rIgJj+gUiTXevXdbt
         n0RQ==
X-Gm-Message-State: AIVw110cTNuXmwlpHewMCxiG9Ny84Vk0DKCS+EpvGudiKRtgsdoEivxN
        84rklR64swFjaL9s
X-Received: by 10.99.47.2 with SMTP id v2mr2941828pgv.203.1501866316259;
        Fri, 04 Aug 2017 10:05:16 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:12e:3e2a:b3e7:da91])
        by smtp.gmail.com with ESMTPSA id k81sm3826433pfb.152.2017.08.04.10.05.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 04 Aug 2017 10:05:15 -0700 (PDT)
Date:   Fri, 4 Aug 2017 10:05:13 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] clone: teach recursive clones to respect -q
Message-ID: <20170804170513.GA178896@google.com>
References: <20170803222544.17216-1-bmwill@google.com>
 <xmqqvam3uxif.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqvam3uxif.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/04, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > Teach 'git clone --recurse-submodules' to respect the '-q' option by
> > passing down the quiet flag to the process which handles cloning of
> > submodules.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  builtin/clone.c            | 3 +++
> >  t/t7400-submodule-basic.sh | 6 ++++++
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index 08b5cc433..f7e17d229 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -768,6 +768,9 @@ static int checkout(int submodule_progress)
> >  		if (submodule_progress)
> >  			argv_array_push(&args, "--progress");
> >  
> > +		if (option_verbosity < 0)
> > +			argv_array_push(&args, "--quiet");
> > +
> >  		err = run_command_v_opt(args.argv, RUN_GIT_CMD);
> >  		argv_array_clear(&args);
> >  	}
> 
> Good spotting.  Makes me wonder if there still are other options we
> might have missed, but we can incrementally improve as bug report
> comes in ;-)

Yeah I've noticed that the number one difficulty with doing submodule
operations in another process is making sure that the correct options
are passed down.

> 
> Will queue.  Thanks.

Thanks!

> 
> > diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> > index dcac364c5..e9c3335b7 100755
> > --- a/t/t7400-submodule-basic.sh
> > +++ b/t/t7400-submodule-basic.sh
> > @@ -1289,4 +1289,10 @@ test_expect_success 'init properly sets the config' '
> >  	test_must_fail git -C multisuper_clone config --get submodule.sub1.active
> >  '
> >  
> > +test_expect_success 'recursive clone respects -q' '
> > +	test_when_finished "rm -rf multisuper_clone" &&
> > +	git clone -q --recurse-submodules multisuper multisuper_clone >actual &&
> > +	test_must_be_empty actual
> > +'
> > +
> >  test_done

-- 
Brandon Williams
