Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF6A720A78
	for <e@80x24.org>; Wed,  1 Feb 2017 23:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750984AbdBAXuy (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 18:50:54 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35891 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbdBAXux (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 18:50:53 -0500
Received: by mail-pg0-f66.google.com with SMTP id 75so35537601pgf.3
        for <git@vger.kernel.org>; Wed, 01 Feb 2017 15:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oS3n0td4gpaVOffogc083fzETD3aBpWXwhnR0eJC1i8=;
        b=bbcDRRJ92o+dr6IY8m6Qa5Ht//WUdTNZH5ZMWEZSAFWXK+UxyMlMjbqdofueJm9puN
         YoKiMJrrhpBMoyJ9hQqAhMd4rPZbwRWhTBPEF3nypQWhPCAV9yaudW1CqzSKIs5myTA7
         7v6mspNAOjJj23tDjsLCS0rq5qo3c7DGeSvcgWpb9O+fdZ8etUgbryfKdqgBsar+h/dD
         fxWWu8uhRmh5hC82FMyh0nH6vQ/0SHBW7yo7IG/mYZb8IqQVkJF7f8Fx/MTl9WpSimZM
         SEL3s0X0eg9RypXMIIdcw11PD5i4d9DjWf3aqo+m4nQJMDZOqU1bAY4MTHcbxWXGJHuu
         o3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oS3n0td4gpaVOffogc083fzETD3aBpWXwhnR0eJC1i8=;
        b=Orefe29Mn9k42kgeQQPsIK7XRXhoNKAHFqnDZ3C6oAmglDUAPZW2r7I0D38ywO4DKH
         qiauVME4nvs1pigHaZFCeLkDzWogWuG7OwWsVq38WdDSsdZDRdra5YQIs8Xz6RnnCv6l
         dIZLFoxhaPh8SGCG4TjYBjdDGykddVeOSLASQI37PbtcM3xhFdqHtNZUiWKBZMx0UE6k
         NgOa5gAi+Bglt7th6eJbeu9DtPaGsNnxQGYkrIwfYM99Dyem4bFNhrPCInXTFqKm4gUv
         nfDrFJ8Z/pupaJ4nuFXWnYRVfZxM26W3JKb8ua8Y2KkwebI0oDYw6F9l7ZpJEeMcb2s4
         AWGw==
X-Gm-Message-State: AIkVDXL2Dc/knCGzQ0LEpOo+rOYnVnBahyrVn7frSSl9FHBCKPpBBvZ3Y58r5q/vFgaarQ==
X-Received: by 10.99.124.75 with SMTP id l11mr7096857pgn.46.1485993053288;
        Wed, 01 Feb 2017 15:50:53 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:25a6:b4bd:905a:8303])
        by smtp.gmail.com with ESMTPSA id t6sm53009943pgt.8.2017.02.01.15.50.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Feb 2017 15:50:51 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Gumbel\, Matthew K" <matthew.k.gumbel@intel.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git commit results in many lstat()s
References: <DA0A42D68346B1469147552440A645039A9C56D4@ORSMSX115.amr.corp.intel.com>
        <xmqq8tppo92x.fsf@gitster.mtv.corp.google.com>
        <DA0A42D68346B1469147552440A645039A9C57D6@ORSMSX115.amr.corp.intel.com>
Date:   Wed, 01 Feb 2017 15:50:50 -0800
In-Reply-To: <DA0A42D68346B1469147552440A645039A9C57D6@ORSMSX115.amr.corp.intel.com>
        (Matthew K. Gumbel's message of "Wed, 1 Feb 2017 22:26:05 +0000")
Message-ID: <xmqq60ktmpwl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Gumbel, Matthew K" <matthew.k.gumbel@intel.com> writes:

> "Junio C Hamano" <jch2355@gmail.com> writes:
>> There probably are other things that can be optimized.
>
> Yes, I think that when the user passes --only flag to git-commit, then git does not
> need to call refresh_cache() in prepare_index() in builtin/commit.c.
>
> I may experiment with that. Do you see any downside or negative side-effects?

There may be other fallouts, but one that immediately comes to mind
is that it may break pre-commit hook.

When we get "--only", we prepare an temporary index to create the
commit out of, and give it to the pre-commit hook.  The hook expects
that the cached stat information is up-to-date, iow, it does not
have to do 'update-index --refresh' before using plumbing commands
like "diff-index" to do its own inspection of the working tree.
