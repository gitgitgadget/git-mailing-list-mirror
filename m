Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D448E1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 21:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391573AbeIVDsO (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 23:48:14 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:35094 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391400AbeIVDsO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 23:48:14 -0400
Received: by mail-wm1-f54.google.com with SMTP id o18-v6so4751009wmc.0
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 14:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xXl3MZzWfJi38h6aUd7ch2zs6rBl5mDz76MnuKNwlN8=;
        b=JqVH0tMl3TzZjXt38tGSH5Ut9lPC37eAkHK305W466blWSmoulDwojFZyPUjpQ1z2o
         xoiJ9RzDYDu9nxPVa1gmCx+boK1yTVL05D5ou9/7W0Ahcg2ReuRBkQDtukwfCZ0nRnuC
         xpogvIITUGgcIdE+rSvmgrS71xGJkKhYxUUJ1XvwASX23E4TqiLJKcRSwxgdo7VF2wl8
         0x1u69aRgAtcL8ayyKeNGULidFBEQXb0mrDvJ60KQCDPvmfLUquA/Aj11Ws9V7gLOccr
         fnoNqvD4JVjgDeZxwbqKPUwYB0XhsC+tN9MpBJhfZ033D/KebmYvkZ0ZbETHLApr7HQs
         DvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xXl3MZzWfJi38h6aUd7ch2zs6rBl5mDz76MnuKNwlN8=;
        b=ZYlGuqSBkVw/NatP0erKQ7dJNjGlgJIQ8lbekc1Phkjt/ijjqRio+WpiEx64MiNq8T
         Ra0A5uAjoB8ttV5kYLSaMVuilXoLkOeyQTV7pzBvYTErKAtfOE0VJtLYfyJmgg7yYIbS
         8mT32kA6OLADBhl4/lWlQ/lkMwsno9xO42jq85MMMIir2LVLjGR1JjOPMZ6x6Gedvysl
         LARFH5Fo2ZfIY6zpRDQtp4laAI2VtFsO4wZbfgOvXVwpd4hecZm9VK6E6rchAvhvE3t3
         js8nwzXas8bXfbk24Hk2nMOCfLcU/RMjybJ91t08UHRSfEpnIWt/v2GcNgZLpqCoMTaq
         2+nw==
X-Gm-Message-State: APzg51DsdpYXXKpKFYGKVMBGzVhrG+wC9NhWk7CZn5rC0MfgKX3/G+rr
        n0mWhr8FkziRpukBtV47tCghEnnV
X-Google-Smtp-Source: ANB0VdbxZv3FgdADhI8+WQ4fCSNuDe6HtbQkj/W9HdDZUMVBkYbUubsVouTAgzVMnbinhONIk97aaA==
X-Received: by 2002:a1c:c14:: with SMTP id 20-v6mr9412976wmm.117.1537567045277;
        Fri, 21 Sep 2018 14:57:25 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z184-v6sm7791828wmz.0.2018.09.21.14.57.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 14:57:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/2] commit-graph write: add progress output
References: <20180904202729.13900-1-avarab@gmail.com>
        <20180907182954.2413-2-avarab@gmail.com>
        <60aae3d6-35b2-94fb-afd7-6978e935a4f7@gmail.com>
        <xmqq36u2v85q.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 21 Sep 2018 14:57:24 -0700
In-Reply-To: <xmqq36u2v85q.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 21 Sep 2018 14:43:13 -0700")
Message-ID: <xmqqy3butsxn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> The above prototype change seems to have created a semantic conflict
>> with ds/commit-graph-tests (859fdc "commit-graph: define
>> GIT_TEST_COMMIT_GRAPH") because when GIT_TEST_COMMIT_GRAPH is set, we
>> call write_commit_graph_reachable() but the final parameter was
>> resolved to be "1" instead of "0".
>
> Hmph.  That's unfortunate.
>
> Perhaps one of the topics should have yielded and waited until the
> other one passes through.

Nah, I see where things went wrong.  I'll queue a single-liner
"mismerge fix" to 'next', and then correct the seed for the evil
merge kept in merge-fix/ab/commit-graph-progress, and rebuild 'pu'.
Things will straighten out by themselves after that happens.

Thanks for noticing.
