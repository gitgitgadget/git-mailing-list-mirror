Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A9BE1F731
	for <e@80x24.org>; Thu,  1 Aug 2019 18:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732904AbfHASIh (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 14:08:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38464 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731642AbfHASIh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 14:08:37 -0400
Received: by mail-pl1-f194.google.com with SMTP id az7so32533758plb.5
        for <git@vger.kernel.org>; Thu, 01 Aug 2019 11:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Eq50hWfd8wNpVHe9Iq4DtBkEzBretBb/M3FA4cAqXYk=;
        b=T8DgNroNYyFyVo8OFvBqeJnvWclHRgAjqH4D5bXn5znMa4Pyb3v2X25FkvWY+kB5w2
         F/zYrdDAL/s/eoi8uh4fclc9/QhI2k54whvmF3tQ+HWmiG4Wl/lzFdBi+Up1v9XdamoR
         D/PBhOMjxbkhpd1wlAT7o40XUx47TmnUIWknVVcu6Q2O2v4aq1pMYV8/5k07Jpe0AVlI
         QNB6ssGuZAOPI/Ctmcgre2xuvmKbEdq6VUpAbeob53K2lnPqfUTjphZCC19EFdM86vQR
         IuVcGFgwY8Kb0yQxY7dm8BdojsHyfjnHx1YX9NV16x23VIBAsaxMJ0IjKD3plz0YmSn9
         Aaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Eq50hWfd8wNpVHe9Iq4DtBkEzBretBb/M3FA4cAqXYk=;
        b=m3kAfyt7eDo7Mc/4XigmdvaavifbtwNZQOSX1+ZQqZ7qW+AkpKX5WKwEqHjtUxNcO7
         Lghflgm6yBZnJsemvj9ghWbmXwfhIU/S2g8T085GfKu7lCK8B2OVivK18mOvvYf4BGck
         Oy+CglXlroVmC8OtNFrhPR61H6qxxxtYb7wYjkU0m/jr3UgF3u7oYzaQiCOe68oKPAls
         Dy/s5BQ8oLxUEkqqn6LbUKsJdE2uUVfMbrE0ZFzonRvCElQyf0fI7KT3+2LVSWxFJvf5
         w4C6KWMhtHtCAttHA1euk+1wkjBq9Lq+1s3ETdz9udETwMOVV/7OozKVrpF2xJjQoD0z
         fEBA==
X-Gm-Message-State: APjAAAWoXbW98zIs0c1PDDLJNS5Ecxw9yr4gG77AJr5cqV5qOIulL6Ul
        Si9Ss11sTQOwqlqY6b23vIP+fw==
X-Google-Smtp-Source: APXvYqwT/DOPQu8cNooZaBm51v7J3KcTRdTzO8RNjRQZmm0C8JsiVtCA9NZADQDP0MOG+Jh1btXNKA==
X-Received: by 2002:a17:902:be03:: with SMTP id r3mr128850222pls.156.1564682915721;
        Thu, 01 Aug 2019 11:08:35 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4264:e2f7:27a:8bb2])
        by smtp.gmail.com with ESMTPSA id s5sm55024460pfm.97.2019.08.01.11.08.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 11:08:34 -0700 (PDT)
Date:   Thu, 1 Aug 2019 11:08:29 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, git@jeffhostetler.com,
        avarab@gmail.com, peff@peff.net, jnareb@gmail.com
Subject: Re: [PATCH v3 0/3] Add a JSON Schema for trace2 events
Message-ID: <20190801180829.GP43313@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, git@jeffhostetler.com,
        avarab@gmail.com, peff@peff.net, jnareb@gmail.com
References: <cover.1560295286.git.steadmon@google.com>
 <cover.1564009259.git.steadmon@google.com>
 <20190725234229.GM20404@szeder.dev>
 <nycvar.QRO.7.76.6.1907261333390.21907@tvgsbejvaqbjf.bet>
 <20190726220348.GF43313@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726220348.GF43313@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.07.26 15:03, Josh Steadmon wrote:
[snip]
> [ajv-cli] can validate the full 1.7M line trace output in just over a
> minute. Moreover, it has helpful output when validation fails. So I
> would be happy to re-implement this using ajv-cli.

Unfortunately, ajv on Travis is much slower than on my work machine. It
still takes over 10 minutes to complete, and is killed by Travis since
it doesn't provide any progress indicator while it's running.

How would people feel about validating a sample of the "make test"
output? In the short term we could just use command-line tools to sample
the trace file; for the long-term, we could add a sampling config option
for trace2 (I've been considering adding this for other reasons anyway).

Ideally we would want the sample to be deterministic for any given
commit, so that we don't end up with flaky tests if changes are made to
trace2 while neglecting to update the schema.

Since there have been some suggestions to build a standalone test and
verify its trace output, let me reiterate why I feel it's useful to use
"make test" instead: I do not feel that I can create a standalone test
that exercises a wide enough selection of code paths to get sufficient
coverage of all potential trace2 output. Trying to make a standalone
test that also anticipates future development is practically impossible.
Using "make test" means that I can rely on the whole community to
identify important code paths, both now and in the future.

As always, I am open to other approaches to make sure the schema stays
up-to-date.
