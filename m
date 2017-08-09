Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3F421F991
	for <e@80x24.org>; Wed,  9 Aug 2017 17:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbdHIReM (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 13:34:12 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:32983 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751443AbdHIReL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 13:34:11 -0400
Received: by mail-lf0-f51.google.com with SMTP id d17so31133238lfe.0
        for <git@vger.kernel.org>; Wed, 09 Aug 2017 10:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zPmcFKpRa5jerD25IAFnxb14sssTqD9ulrcqT4Yn5Wc=;
        b=YPAr5P/Ipkb11cc6qIYEhRpmiyGuf8hYvgzUyOGvPYD7M2+gYC77UPVvY8Ji24Qyzg
         24igGTJSIBECfML7frzOwUzbm042mQD48FiXPu6G/F03D0LMlIzrfCa66HCMBodutCQi
         dpN6dwMpEMdGUAiAcSqaXBZzM6eSeKWBgBq+7Vw8N7dc49WOkx11LHCmGOOuZ2bQYhhe
         O/oPAYyjGgf5S5CWwWd3ihzMRvVGCaXwMLfI+dtF4K+7mhwLJ+5dcuFK8z0rOMiraM25
         KQujoazIMVL2aOPM2hOyC+tIG8UboW1Fw4TjBSwcvEnRiuHxAOyh9ac/M9s+eK4ba9a3
         hm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zPmcFKpRa5jerD25IAFnxb14sssTqD9ulrcqT4Yn5Wc=;
        b=V8IwseqhREnKQ4/4PIrX17VjGLIt8pa/yMGQVbVA1a22O0kG+I+4z1fS8eUhRWZMgr
         bDtqqOVLa6p/IOQ1PUmPiLvlp2+EIf33xe99eNF2WVpiGQsaHT3zlWV7HODXLeSCgVZi
         q3Q+ymcZlloou2g0bPzOqunzD/fwA7mfQTAseQzrI3Rot4YpRT4PKCcV7JOsrDpx6RkM
         KWs+maLoC5nDNstHPG2iQhOP/jKW59FTFrYE6uPSsyAmZlr53kIqSb2WAuwtx2Z0JhVy
         KdVYLqjaULQgQlyUBKsUWpxxATFcBmDMDqzLHzdVqm9ln64GG8TvArQENI7q5108WPuY
         HjZA==
X-Gm-Message-State: AHYfb5gvNo0AQ8It7C5RGkvcMfFbTO+SIWWQaHaWu2SJ3H/X6OsHqgqZ
        /uEA6w/xSmIQ13ylcSyN9s9pJmMETnTY
X-Received: by 10.25.15.221 with SMTP id 90mr3132303lfp.220.1502300050405;
 Wed, 09 Aug 2017 10:34:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Wed, 9 Aug 2017 10:34:09 -0700 (PDT)
In-Reply-To: <20170809120201.2eagzkljervqeusx@sigill.intra.peff.net>
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net> <20170809120201.2eagzkljervqeusx@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 9 Aug 2017 10:34:09 -0700
Message-ID: <CAGZ79kZ-Ra6MCvvq-dqnsXowmykBt9ghqUgHgzSC_zt=Q1_=CA@mail.gmail.com>
Subject: Re: [PATCH 3/4] http: drop support for curl < 7.19.4
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 9, 2017 at 5:02 AM, Jeff King <peff@peff.net> wrote:
> Since v2.12.0, Git does not compile with versions of curl
> older than 7.19.4. That version of curl is about 8 years
> old. This means it may still be used in some distributions
> with long-running support periods. But the fact that we
> haven't received a single bug report about the compile-time
> breakage implies that nobody cares about building recent
> releases on such platforms.

I would not state it as bland, see how
https://public-inbox.org/git/20170806233850.14711-1-avarab@gmail.com/
came here to the mailing list.


> As discussed in the previous two commits, this cleans up the
> code and gives a more realistic signal to users about which
> versions of Git are actually tested (in particular, this
> moves us past the potential use-after-free issues with curl
> older than 7.17.0).

This is a good reason for this patch, though, so maybe just elide
the "nobody cares" part?

Thanks for these cleanups!
