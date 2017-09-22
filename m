Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEE0B20A26
	for <e@80x24.org>; Fri, 22 Sep 2017 22:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752307AbdIVWwi (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 18:52:38 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:51918 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752158AbdIVWwh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 18:52:37 -0400
Received: by mail-pf0-f177.google.com with SMTP id b70so1204600pfl.8
        for <git@vger.kernel.org>; Fri, 22 Sep 2017 15:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JFq52XKH/zFqkGhYpo5mOvPpHX0K+to10QtD6WkHftA=;
        b=B+rZ3K1mbcawPX7nJ7G7erlSXkJEpvxCpiBrXxj3AdOakATj3cZE+1PyFBcmx5crU+
         ALjwUNC79N2QZeRmZ7X9rkfxEK+Ox6PXGEJAY8lGOCYpC94Bu9lEjpkrgDHlP+GpEBBy
         GCa3pCd0lPvOkUXf6goDMaalIwZWx//w+vlgS5cXyThNujWJxtCjj9b5MtQRviCt1nG+
         XwYAAaHlh5a69RW1jSMXkJrSrUaOjmRqwA7heq6iuYM2hm5IxuFB/P0bDo3Gpjp+NW9N
         rzRUeYrIuczUzKAAvFAp0r3K+bxy8IlIN3WQZbJcTrDwIu70tRJ5cc1Mm2U50H2ycIgy
         yxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JFq52XKH/zFqkGhYpo5mOvPpHX0K+to10QtD6WkHftA=;
        b=Gf9n08LXP5OKspKLODEEuz5Q2oAIWQFlf5C68y2buqS8qAiWPcvzqzUuzKvjBGQqgs
         B+KD00uxv2+7OqorGQnKnjNqj5/+Ff9hh7M52lQ7Z/pcR4CjW00Jhxv+zCwuZYl94Kbi
         5u7OOwXucnJ5VsPKP2gQgGV5GkGuRrJ0wbdlH1sNdm6PSqFtJkeT2xd98MKDE55uUZlW
         ieRa/8emIVY4b7DIgxDbfQITnyriHVr7MRZLcxwYJFTvMNRF2EBHq0mqUUfg/iwT5rxK
         CNsmMD1SEkpoCM0eTdVQKVr9pnlSkXs69aOxMB9vXqdukHb+0ttLbcOSYGMRfX33dQxU
         iRRQ==
X-Gm-Message-State: AHPjjUibVty++aUz/fXFHPqmg7XVCfZS+xDU0zx2fo4q7s8kO53JMyuW
        ivKTeFOXC6H6nCS5/O/IEPxI+A==
X-Google-Smtp-Source: AOwi7QDOdRYhWM4iA9ymLxEGZqLsWOQZz10VlgFOmXidXxpDqvPWi0F+pY20uZ9dvWCYTmexiAp0Bw==
X-Received: by 10.84.134.164 with SMTP id 33mr517136plh.323.1506120756770;
        Fri, 22 Sep 2017 15:52:36 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:840f:cadd:b54e:2e8c])
        by smtp.gmail.com with ESMTPSA id o5sm1010197pfh.67.2017.09.22.15.52.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Sep 2017 15:52:36 -0700 (PDT)
Date:   Fri, 22 Sep 2017 15:52:35 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, peartben@gmail.com,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: RFC: Design and code of partial clones (now, missing commits
 and trees OK) (part 2/3)
Message-Id: <20170922155235.7b50de91f0370d9101cc4faa@google.com>
In-Reply-To: <5b251b02-fe00-3d99-8ae2-d6df0193ebe0@jeffhostetler.com>
References: <20170915134343.3814dc38@twelve2.svl.corp.google.com>
        <5d295ab3-310e-321e-6e88-69484eb9ce8a@jeffhostetler.com>
        <20170921155150.1d57d89e@twelve2.svl.corp.google.com>
        <5b251b02-fe00-3d99-8ae2-d6df0193ebe0@jeffhostetler.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 22 Sep 2017 17:19:50 -0400
Jeff Hostetler <git@jeffhostetler.com> wrote:

> > In your specific example, how would rev-list know, on the client, to
> > include (or exclude) a large blob in its output if it does not have it,
> > and thus does not know its size?
> > 
> 
> The client doesn't have the size. It just knows it is missing and it
> needs it. It doesn't matter why it is missing.  (But I guess the client
> could assume it is because it is large.)

Ah, OK.

> So rev-list on the client could filter the objects it has by size.

My issue is that if the purpose of this feature in rev-list is to do
prefetching, the only criterion we need to check for is absence from the
local repo right? (Or is filtering by size on the client useful for
other reasons?)

> FYI I just posted my RFC this afternoon.
> https://public-inbox.org/git/20170922204211.GA24036@google.com/T/

Thanks, I'll take a look.
