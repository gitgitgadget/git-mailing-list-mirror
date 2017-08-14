Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48F8B20899
	for <e@80x24.org>; Mon, 14 Aug 2017 17:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751482AbdHNRAL (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 13:00:11 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:33074 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751427AbdHNRAK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 13:00:10 -0400
Received: by mail-yw0-f173.google.com with SMTP id p68so58543823ywg.0
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 10:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nnoMdt0CmzxHMRfJj6Au9sRy3WmLahHm1GL33VtEigw=;
        b=v4Cv3EXlV5Y7Tv8x6xevsP2hs1pXnTHKiTLY/R/i3mq839lrAGYGm2c4wtCnwLANbG
         soCpApE/wUjnYJeEO/MQOnwwdDCXXrWeFFLW+xGnJNB4tlrd8v8+VmrRJiyED+G0qq2q
         gdWgzV9/bjiTnzWmh0+tf4KUJYqotGbj/ymGf2DbL9wnRZbLSwBLZ1bda47quwtpE2oe
         YxY8cREE4A3aCGpOnIPozrhGupwkDEoVi1AM3xLE/liaHjSW735uMl73QEsCXrkVoKnQ
         BD39jXoYNM1igjweL6/Qk6bu/PKb2EFfi1NYzkww78mgJnODGKnnM4CmBrt457Wy6qYl
         CTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nnoMdt0CmzxHMRfJj6Au9sRy3WmLahHm1GL33VtEigw=;
        b=lqpwXaa3P94kBsEX6kBrb/cnNLlXbE1R53BZr1TBCat2nz2FJKWrfZGfxDLSzxZ5br
         my2S2U9ZlMN8Q571j1HQ2AMgr42X+j2TNoIxjkIU+2Ylfe073joDAaqXqMy6EfSGZu00
         8EeF6YFIRDEe+1W1w7tvc0l64vYiwpG3fKkdwNKpY5DFaZ8i/BqUJEinJe5LdhaAWxuY
         MzAZTsXP8g6aSBgd5q+qh2snlp42RfY6j48VFsmocmtypagEVo9pZr7iOHh43JQH88lv
         zqLonV+DR16j62Rrjl1IwxNLDZgrRWRER2737m+IMnHCI9+mL3qQgMPGn+gIL7I30zPq
         2ggg==
X-Gm-Message-State: AHYfb5hOKKesqCJlLXSr7fGdFfckKqC7UHSGtb6yyTz8Nh1Vca/BzH4r
        Rs2zlARAeuFBn6HilDEu6TkM5gZWDJepmocM/g==
X-Received: by 10.13.206.132 with SMTP id q126mr20569059ywd.337.1502730009660;
 Mon, 14 Aug 2017 10:00:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.75.3 with HTTP; Mon, 14 Aug 2017 10:00:09 -0700 (PDT)
In-Reply-To: <20170813193611.4233-1-richard.maw@gmail.com>
References: <20170813193611.4233-1-richard.maw@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 14 Aug 2017 10:00:09 -0700
Message-ID: <CAGZ79kZz16kwwMOxoi+6UksT2CaPBU5O+r3QzxfrUBf8c3whhg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Implement ref namespaces as a ref storage backend
To:     Richard Maw <richard.maw@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Technical description
> =====================
>
> This patch series adds a new refs backend, stacking on top of the files backend,
> based on whether `core.namespace` is set in git config.

Currently there is another Big Thing getting started in in the refs backend.
https://public-inbox.org/git/CAJo=hJtg0PAVHT1phbArdra8+4LfnEEuaj3fBid==BXkZghi8g@mail.gmail.com/
Maybe it is worth looking into that as well? Reftables solve
the problem of scaling (i.e. a repo containing a million refs works
just fine, and fast(!) for reading/writing refs, which is not the case
for packed refs)
