Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B35F1F406
	for <e@80x24.org>; Sat, 12 May 2018 03:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751096AbeELDVI (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 23:21:08 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44991 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbeELDVI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 23:21:08 -0400
Received: by mail-pl0-f68.google.com with SMTP id e6-v6so4273654plt.11
        for <git@vger.kernel.org>; Fri, 11 May 2018 20:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0+JMwQFqiMP8IHu427L+5a/8p+GwyMAsbs0vrTeCBSg=;
        b=PrwjfaXY9Ax5Woge3SEsfSeTvdmu4FrxHkndodE++ZEk4Y+36guVB4Q6UvOWMfZvhM
         XBIXAj6lfpAUeAocwKJNGV7RtZvOQHKANZ22GbVtbwnpV11N8vdaOnGtGmfbT9myXmL1
         +wSD2NVa31jcrJodej+fPpkyoxxboeM/lOygKlvSJ0gMkHTkMC0wDdKxLJ5d3Rft06Ip
         2sobckZKEMlqEwZ3NyEfWo2em9/NqUKel3dnOUbGosUCmgpBNNTk8K8h5d6nGKpmsVQC
         rypd0kFi+ph8rMuv0V/rxjWsa6RSRsTwAFdkU+oqXAKhzOYKrTuTxjE5unFwAHWz0J4D
         tSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0+JMwQFqiMP8IHu427L+5a/8p+GwyMAsbs0vrTeCBSg=;
        b=lF+0pKXiY9ZyK6FIByWVixdj7j7Tsjg3YLcC91p7T+kSxHkGkjHs4kS+qnqu6SK6L+
         Wfk7/96qmaE/10iLCRYcxfUx9avJs4i45LIdCzl18iS6cWRCqbukr/ev+pVp28HC7Jgc
         k7S9bDdGKMaPuqV0Uv1c5mf25tZEwAEbd1k/rMXUJP+kLKwp53oP56JiCf3Pbou2O4ta
         Ts74V2cjpvxPy4d77QZIYCiMZzZCVlHmDM41G9eQt5f3LUPx95HGnw5rt4ijnO/4GB+E
         LTp+t8JLMvFrqhHqsF5LhFQ1j5h0+kWx2wu8ddk1IwiyTsRLrQe8COg20CD5tUtwYrsT
         nUXA==
X-Gm-Message-State: ALKqPwfw7E9UiIBHQokxN3ckZEWvQWXZQ2Zs9DSIeBKcPBqTU4TZgrJr
        3XGhMBcLWO+YD7EwdYEHk5yRQEqKHh0=
X-Google-Smtp-Source: AB8JxZqh9ZbK5Hw8axCR5KCn7r9Tz+hnbE6d6LFjV1xNqGlfEsFjk6953QXj4iYolodMeaXnH7VyIA==
X-Received: by 2002:a17:902:bd46:: with SMTP id b6-v6mr763307plx.170.1526095266744;
        Fri, 11 May 2018 20:21:06 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:81b:33bd:f4a4:78cd])
        by smtp.gmail.com with ESMTPSA id p1-v6sm8616246pfp.137.2018.05.11.20.21.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 May 2018 20:21:04 -0700 (PDT)
Date:   Fri, 11 May 2018 20:21:03 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, avarab@gmail.com, peff@peff.net,
        gitster@pobox.com
Subject: [PATCH v2 0/2] builtin/grep.c: teach '-o', '--only-matching'
Message-ID: <cover.1526094978.git.me@ttaylorr.com>
References: <cover.1525492696.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1525492696.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Attached is the second re-roll of my series to add GNU grep's
'--only-matching' to git-grep.

The main thing that has changed since last time is our handling of
-{A,B,C}<N>. Previously, as Peff points out in [1], we handle this in a
buggy way different than GNU.

I agree that although 'git grep -C<N> -o ...' is an unusual invocation,
it is useful to (1) maintain as much consistency as reasonably makes
sense, and (2) to at least not be buggy.

I have also responded to Eric's suggestions in [2], and [3].

Thanks as always for your kind review :-).


Thanks,
Taylor

[1]: https://public-inbox.org/git/20180510064014.GA31779@sigill.intra.peff.net
[2]: https://public-inbox.org/git/CAPig+cSRJWW4-7vj6wK8aOfNB20bqUCSOOySjdPci1r5Vb83Uw@mail.gmail.com
[3]: https://public-inbox.org/git/CAPig+cRbBZ+QTqGiW_wQ9E-gROA-Wtevp1vcRqmJ5YQJ8tYEVQ@mail.gmail.com

Taylor Blau (2):
  grep.c: extract show_line_header()
  builtin/grep.c: teach '-o', '--only-matching' to 'git-grep'

 Documentation/git-grep.txt |  6 ++-
 builtin/grep.c             |  1 +
 grep.c                     | 78 +++++++++++++++++++++++++++-----------
 grep.h                     |  1 +
 t/t7810-grep.sh            | 69 +++++++++++++++++++++++++++++++++
 5 files changed, 132 insertions(+), 23 deletions(-)

--
2.17.0
