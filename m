Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85D4C4332D
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 23:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93083222F9
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 23:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbgL1Wzi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 17:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729352AbgL1T7y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 14:59:54 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E0CC0613D6
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 11:59:14 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id 4so6106238plk.5
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 11:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hc5eiVRLW4TcpHVr9lGupsl9xgYsje9dSgLKqauLEJE=;
        b=e9NKraalm0PVb9WcM1JgdXGMg3rdrIrJL7cJvM0oXYNquVT8LragVf9QmzU75j2WV6
         yoAziGJLGtqtZJBXOlzfyBWEA80JTr7Thmh3QyeTyof8rvwR3Zqg6Eo9kytMLt2mgynt
         5t9/pDfbXYiVLgMI/He4Uz1vzwqBQudhISWEiNJeR/taxFm4Qfs1XnyfE0JzkC28h468
         Qov4WALEZf+uUXPNCqNmexbNJDrcVgD8KQdAzXKGV9zjisz5eLZX+JbAvTKaacq7+x4Z
         +96Kx12QDkDH+lBtCB1J89w6X+4pDCw+/3/1706i8wj4zzmNASGVfYtkJnbtUf4iGL+t
         sENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hc5eiVRLW4TcpHVr9lGupsl9xgYsje9dSgLKqauLEJE=;
        b=AdNewlii8BkVUJx1KlYMGfC4tNkruXdaL9fZfru9gO6+2HB2/yge8vPQQOke3VD5jr
         tdyDGZO0Morh7HMmiLm1GoShxRgwKYbXWZZz+5EuBFaMaVSNhZEcSV6Wq0DjaPf8sQWU
         3Y3aIbtP94dTuYyrSCzJM7D22AQt39I5a/zkAocdpxNVjp0ovGfMPcLflr8Vh6047pKb
         ArzIIbFvfYVe0l/9B1gU+DbR0x9gsPfQ7POuwuvIel+DLbqXnBjqDWV74GwT7E0nKzLw
         +41E15/j6+ajLQBHu2E4TBko4zz9osltiEXBb55cqAezN6B71KSzDKireuQQSsA+M2fD
         ltEA==
X-Gm-Message-State: AOAM530LpQf48Dq9ndtDwUg8jHUrJHZb3Q6zvOtRgI7I9Cw2xK5LLk+q
        olplj6MLOyArbQenK75R7q99WbFSLOl2bQ==
X-Google-Smtp-Source: ABdhPJyHQGbEci9qbfWBXtY9eV50h2KmX/wRVTE/5as63Y3OHvLrScUz4WlyfraatTDGbRfuGvBzuA==
X-Received: by 2002:a17:90a:b110:: with SMTP id z16mr473014pjq.167.1609185553090;
        Mon, 28 Dec 2020 11:59:13 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id h17sm35295542pfo.220.2020.12.28.11.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 11:59:12 -0800 (PST)
Date:   Mon, 28 Dec 2020 11:59:07 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 00/17] use config-based hooks (config-based hooks part
 II)
Message-ID: <X+o5C78dAYWZhwhI@google.com>
References: <20201205014945.1502660-1-emilyshaffer@google.com>
 <20201222000435.1529768-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222000435.1529768-1-emilyshaffer@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 21, 2020 at 04:04:18PM -0800, Emily Shaffer wrote:
> 
> Another thing I wanted to do in this series but ended up not having time
> for before the holidays was to figure out a way to consolidate
> Documentation/githooks.txt and Documentation/git-hook.txt. My personal
> preference would be to remove githooks.txt's contents, move the "Hooks"
> header from there into git-hook.txt, and have 'git help githooks'/'git
> help hooks' redirect to git-hook.txt; I don't have a patch to share here
> because I ran out of time before vacation :) What do others envision the
> documentation looking like?

I could use some tips on this, actually. I don't see anywhere that we
make one document redirect to another, or else I don't know what to look
for. If I replace the contents of `githooks.txt` with
`include::git-hook.txt[]`, `generate-cmdlist.sh` chokes because there is
no name to grep for in `githooks.txt`. Is there a documented example of
a manpage redirecting to a different manpage?

 - Emily
