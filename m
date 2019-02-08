Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D6F91F453
	for <e@80x24.org>; Fri,  8 Feb 2019 18:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfBHSXZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 13:23:25 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35727 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfBHSXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 13:23:25 -0500
Received: by mail-wm1-f68.google.com with SMTP id t200so4639483wmt.0
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 10:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=JOADqcGO/CJ0Lgd2cPe0Q46AUxgxpXi7WPVa9DQeOPA=;
        b=C1gNVpVXe2EbT6v5iCa405tEIgty9kiEmfd93T7n8eMC3LIYcHGC2HGUGNFFYuShmO
         yg7RfM4mIbAx5zv2QvrRvdruNa6SAtdZM+IxVlOJSmChrnf3jmkjvT1TbwyRTF/uaA/q
         BckpDqETKOqAYhGCKRMLEc6ptNAUF0pmVR1b88PPwZdMoD/azyMRP6PNA6Td5zP/88lM
         zcx8xoJNeMJju1BuUjBGOYGBnwIyVy8KNlVnHMmV/cs8yKC2cqzWyjgi8tUu4Ll+X6BN
         y7VCQgjdiHbdKhxsLix2RVtsj4ityj7HhiFza2Mg8xD0OJPjG5gg3E1keT+UF+kIFQaP
         U+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JOADqcGO/CJ0Lgd2cPe0Q46AUxgxpXi7WPVa9DQeOPA=;
        b=rwi9QImWkZ8I289ah+7eiBAsFQV2HwaKGE59fCY+SsbSI/AmS+dbgnpyg9qLmrSQPg
         0nxmCR3yWG3rc9IoOhvdaOwSva05zG7PzynGYnOWTolUtYlAAiyo9zF9IoWRrHCMiNOp
         0xeZ3e00leZFmUFMc50Avm1U5DhQyu+oKc2UvvbLaP7jt9ncP5fmp7fTmmZqVIz5TE9b
         oPswoz2ENQKeqbwG8u8nkdMTrdL1BFz/6YOdTL8i0wLGn2nls5s84PA+KT5Ccb+jVosZ
         Yw7bQRD+1OQWOOiiHLqSS0cCLCL33pFY1iokHNZ9a60wa8W9dJvXFgYfOgKEIBDuVA1I
         9qkA==
X-Gm-Message-State: AHQUAubEE1AdNyn+6ASJS5QQV0+Ze4PgYO79zg58lw5w8lH4BcpyceKU
        rhSSjxwWInqz5bzirSCbZlw=
X-Google-Smtp-Source: AHgI3Ia+nsYK6rsos9dADkIhDbLrSjqfpQFRL8uw8iG0PZIVnLuXFkx6Vr18R0KzE6gJFKTeLLLmeQ==
X-Received: by 2002:a1c:990c:: with SMTP id b12mr13092099wme.106.1549650202498;
        Fri, 08 Feb 2019 10:23:22 -0800 (PST)
Received: from szeder.dev (x4db62aaa.dyn.telefonica.de. [77.182.42.170])
        by smtp.gmail.com with ESMTPSA id b13sm3629582wrn.28.2019.02.08.10.23.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 10:23:21 -0800 (PST)
Date:   Fri, 8 Feb 2019 19:23:19 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: make '--stress' more bisect-friendly
Message-ID: <20190208182319.GY10587@szeder.dev>
References: <20190208115045.13256-1-szeder.dev@gmail.com>
 <20190208164732.GA23461@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190208164732.GA23461@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 08, 2019 at 11:47:33AM -0500, Jeff King wrote:
> On Fri, Feb 08, 2019 at 12:50:45PM +0100, SZEDER Gábor wrote:
> 
> >   - Make it exit with failure if a failure is found.
> > 
> >   - Add the '--stress-limit=<N>' option to repeat the test script
> >     at most N times in each of the parallel jobs, and exit with
> >     success when the limit is reached.
> > [...]
> > 
> > This is a case when an external stress script works better, as it can
> > easily check commits in the past...  if someone has such a script,
> > that is.
> 
> Heh, I literally just implemented this kind of max-count in my own
> "stress" script[1] to handle this recent t0025 testing. So certainly I
> think it is a good idea.
> 
> Picking an <N> is tough. Too low and you get a false negative, too high
> and you can wait forever, especially if the script is long. But I don't
> think there's any real way to auto-scale it, except by seeing a few of
> the failing cases and watching how long they take.

So far I've chosen <N> like this: run the test script with --stress
3-5 times to trigger the failure, take the highest repetition count
that was necessary for the failure, multiply it by 4-6 to get a round
number, and that's a good ballpark for <N>.  And once bisect came up
with the suspect commit, I double checked it by letting the test
script run with --stress on its parent commit for at least 5-10x <N>
repetitions.

Anyway, I doubt that auto-scaling <N> is worth the effort.

> >  t/README      |  5 +++++
> >  t/test-lib.sh | 18 ++++++++++++++++--
> >  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> Patch looks good. A few observations:
> 
> > @@ -237,8 +248,10 @@ then
> >  				exit 1
> >  			' TERM INT
> >  
> > -			cnt=0
> > -			while ! test -e "$stressfail"
> > +			cnt=1
> > +			while ! test -e "$stressfail" &&
> > +			      { test -z "$stress_limit" ||
> > +				test $cnt -le $stress_limit ; }
> >  			do
> >  				$TEST_SHELL_PATH "$0" "$@" >"$TEST_RESULTS_BASE.stress-$job_nr.out" 2>&1 &
> >  				test_pid=$!
> 
> You switch to 1-indexing the counts here. I think that makes sense,
> since otherwise --stress-limit=300 would end at "1.299", etc.

Yeah, that's exactly why I did it.

> 
> > @@ -261,6 +274,7 @@ then
> >  
> >  	if test -f "$stressfail"
> >  	then
> > +		stress_exit=1
> >  		echo "Log(s) of failed test run(s):"
> >  		for failed_job_nr in $(sort -n "$stressfail")
> >  		do
> 
> I think I'd argue that this missing stress_exit is a bug in the original
> script,

Well, yes, indeed.

Though being able to trigger an elusive test failure is a success in
my book ;)

> and somewhat orthogonal to the limit counter. But I don't think
> it's worth the trouble to split it out (and certainly the theme of "now
> you can run this via bisect" unifies the two changes).
> 
> -Peff
