Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44DC820986
	for <e@80x24.org>; Thu, 29 Sep 2016 11:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755370AbcI2LqY (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 07:46:24 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35340 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754089AbcI2LqX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 07:46:23 -0400
Received: by mail-pa0-f66.google.com with SMTP id j3so3359465paj.2
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 04:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id
         :content-transfer-encoding:mime-version:date:cc;
        bh=alC1YogGkG0hF6obh+T7VntmuyKfGN3m6EuTNKyc+lw=;
        b=02vz2t/eRpYMekCfuEFs0TtG6YluWgIlj/MZS/JlqHF38qOOvY4euiJ/sPEXkgsAY7
         69Biv2/wTmzw9x+vVuicn/TP+G3+2dok1+gwK/0MoML4CI/ukasH/LS6de/eOdjPNUh+
         G3kCqFUBgPyHMDUEgr3uGkGmIDb5qQ0jabuyFMqelzcIOiOVDs/191xvCr8esAnGCSim
         7+U6BhQe0p2Q1aawD9gnbdvTdU+Cd/NpAEEY76OkWhPlQj/slaiJ4wepPReGaT9l+S79
         vhFbMmPB6Gaysc6z4EqC5974GXMVXWQkVhSE26qmRLv5a4SagbOqBPC2KgQjkuqyUCLj
         65og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:in-reply-to:subject:references
         :message-id:content-transfer-encoding:mime-version:date:cc;
        bh=alC1YogGkG0hF6obh+T7VntmuyKfGN3m6EuTNKyc+lw=;
        b=eLtWuh98a+HWarIJcUH6aFHr5G1gdIQ6RiQDkMZQuVqz+WG/Gs+DFwtG3f9Db3H2pm
         Hif6U+4uqh3tIPRjz650ChT/Esr9gqR1m1TlENhOZ9RIq2rG45jZpJ81jooHGwaBTLAh
         o7hYeCGIPk2TnubZ1tmvTG2u6Z0m42P/RtJrlvUaU1m3ErLbaOWLvR+Ad0bhRLFXL4bG
         EUj3ooaCGc+1WxhzQw56Z/3nuyxq6tbVD9WnPJ0OMhSpJ+bHJKum6cs69cFjwxs3NxZU
         w1hSxD7x4WXapzZkH1aWVVTznmq5T8jDuk483zaKRxuWhltWZIcIyd7v4N7ktLd8Bdqr
         gWhw==
X-Gm-Message-State: AA6/9RkGGnnnxaztJP25cJpyhw/NwdspypvBoyPFZ6890Zoau+VFwHdjoH/Dp1kVWxARoQ==
X-Received: by 10.66.173.47 with SMTP id bh15mr1702448pac.42.1475149581978;
        Thu, 29 Sep 2016 04:46:21 -0700 (PDT)
Received: from ?IPv6:2002:46b5:ad14::223:12ff:fe05:eebd? ([2002:46b5:ad14:0:223:12ff:fe05:eebd])
        by smtp.gmail.com with ESMTPSA id p5sm3996664pfp.7.2016.09.29.04.46.20
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 29 Sep 2016 04:46:21 -0700 (PDT)
From:   "Kyle J. McKay" <mackyle@gmail.com>
To:     Jeff King <peff@peff.net>
In-Reply-To: <20160926120036.mqs435a36njeihq6@sigill.intra.peff.net>
Subject: Re: [PATCH 10/10] get_short_sha1: list ambiguous objects on error
References: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net> <20160926120036.mqs435a36njeihq6@sigill.intra.peff.net>
Message-Id: <2242637D-4C3B-4AF2-8BE4-823B3E1745D5@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v936)
Date:   Thu, 29 Sep 2016 04:46:19 -0700
Cc:     Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sep 26, 2016, at 05:00, Jeff King wrote:

>  $ git rev-parse b2e1
>  error: short SHA1 b2e1 is ambiguous
>  hint: The candidates are:
>  hint:   b2e1196 tag v2.8.0-rc1
>  hint:   b2e11d1 tree
>  hint:   b2e1632 commit 2007-11-14 - Merge branch 'bs/maint-commit- 
> options'
>  hint:   b2e1759 blob
>  hint:   b2e18954 blob
>  hint:   b2e1895c blob
>  fatal: ambiguous argument 'b2e1': unknown revision or path not in  
> the working tree.
>  Use '--' to separate paths from revisions, like this:
>  'git <command> [<revision>...] -- [<file>...]'

This hint: information is excellent.  There needs to be a way to show  
it on demand.

$ git rev-parse --disambiguate=b2e1
b2e11962c5e6a9c81aa712c751c83a743fd4f384
b2e11d1bb40c5f81a2f4e37b9f9a60ec7474eeab
b2e163272c01aca4aee4684f5c683ba341c1953d
b2e18954c03ff502053cb74d142faab7d2a8dacb
b2e1895ca92ec2037349d88b945ba64ebf16d62d

Not nearly so helpful, but the operation of --disambiguate cannot be  
changed without breaking current scripts.

Can your excellent "hint:" output above be attached to the -- 
disambiguate option somehow, please.  Something like this perhaps:

$ git rev-parse --disambiguate-list=b2e1
b2e1196 tag v2.8.0-rc1
b2e11d1 tree
b2e1632 commit 2007-11-14 - Merge branch 'bs/maint-commit-options'
b2e1759 blob
b2e18954 blob
b2e1895c blob

Any option name will do, --disambiguate-verbose, --disambiguate- 
extended, --disambiguate-long, --disambiguate-log, --disambiguate- 
help, --disambiguate-show-me-something-useful-to-humans-not-scripts ...

--Kyle
