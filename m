Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18E4F1F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 18:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934297AbeGCSNR (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 14:13:17 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54842 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934229AbeGCSNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 14:13:16 -0400
Received: by mail-wm0-f68.google.com with SMTP id i139-v6so3277084wmf.4
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 11:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=L2/9HAEZ21oGs9U0xzcw1NmHNGI4MBre+09Z4hCeL7w=;
        b=aRnzlrzQtwv/M4fE3yAmBDIIFKyUmVN4HxhykaFc7xF2NTjgAASkoEwX5tjXhH+qpu
         wfnSa21DaPcovPkw/s0ZPCSo0HdLa13U17tGmk1504zGoAnKkyO72ix2wlMJWhWhzCnB
         YefOVMuxcEMt2763DuAn6MYic+HTNBo+SmUgzcCj/B+lA2Mhf0tLrrugRyErnNVPk7wj
         ICVhk7HenDySKIWmylKZVBQM7MzaatXjx+OJMIgKT7s0JWnQoqXkRuBxJR/7wSRRkH4S
         xFBAnu90tJ1teQc5ETd8PNrFpIJ6OmF8mJ7Rb52dsAxGvkx2QrOkfgZvCmdUYslKnhrF
         JXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=L2/9HAEZ21oGs9U0xzcw1NmHNGI4MBre+09Z4hCeL7w=;
        b=WF2af8VCcXEIZzvzRKemKhhvdWc0vYrndoZo0sjA465OiwAqmPREc8OAFwA4eMckOO
         wYvfghwaQyUYkLcABZuqTxeGFrGPqqwWAqhLXCqUYbU3Fyf+1Qks1mDWCwfCZFoRkiVp
         2mkKRMx3fOKNn/MgyGiAGpC18rODS/Y5DcF6l/snx8f1Snid8U3rYZnXt5NspCi6DzZc
         2JEaua+yKPPFMxBnCjWFcqxaIhD2c/xiEP4X+VtVl4Jqj5U6REHjOG58Typ9rrubAjLy
         ae9E03q0ByOhrDfOhdsBNZd5s+XG/i/rUZp80ap/eNwPfD6bOjDQk6hsL6SHGKUfMcNy
         62Kw==
X-Gm-Message-State: APt69E2JsOdvGIDHuobx4AKgZEra0E+Ji6ZFrn6TwnjfJ1GehtVFCmAv
        P1nQDkb04twEd8Q2rImirdIkLJOW
X-Google-Smtp-Source: AAOMgpcyhkn3Qd1G+BnqVnB83hTzu2bF3xIZutQ70xQrtRE5GFv3g8CcMvbqON52VX2GskjreqjnvA==
X-Received: by 2002:a1c:3b54:: with SMTP id i81-v6mr11957122wma.143.1530641594649;
        Tue, 03 Jul 2018 11:13:14 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 143-v6sm3266806wml.37.2018.07.03.11.13.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 11:13:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH v3 00/32] object-store: lookup_commit
References: <20180629012222.167426-1-sbeller@google.com>
        <xmqq8t6xv5kb.fsf@gitster-ct.c.googlers.com>
        <xmqq4lhlv5a8.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kb=W5_3FB6qSinPpcPzRgAe-qkuOCkXTjs6RLqUTjoboA@mail.gmail.com>
        <xmqqvaa1tme8.fsf@gitster-ct.c.googlers.com>
        <20180629222004.GA197765@google.com>
Date:   Tue, 03 Jul 2018 11:13:13 -0700
In-Reply-To: <20180629222004.GA197765@google.com> (Brandon Williams's message
        of "Fri, 29 Jun 2018 15:20:04 -0700")
Message-ID: <xmqq8t6srxvq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> I 100% think that we need to continue these refactorings with both the
> object store as well as with the_index (removing the index macros and
> removing the dependency on global state).  The whole compat macros most
> definitely was a failed experiment as we still haven't rid the code
> base of them yet.

These two are completely different things.  You can call the compat
macros a failed experiment only if two things hold true: (1) we want
to force all callsites to explicitly pass the_index even when they
always work on the primary in-core instance of istate and (2) they
were invented primarily in the hope that their presense will help us
achieve (1) sooner.  And neither is true.  The mechanism to allow
multiple in-core istate were of course helpful in places like branch
switching and merging, but we expected that the majority of
then-existing code would be required to work on the primary in-core
index, so s/foo_cache(/foo_index(&the_index/ conversion all over the
place were noisier than it was worth.  The compat macros were not
introduced as an experiment to help wean ourselves off of the
foo_cache API.  It was a total opposite---it was a consideration on
production code to help existing code keep working in backward
compatible way.  In short, they were neither failed nor experiment.

What you _could_ say about them, given that more code than before
would benefit by learning to work on istate instances other than the
default &the_index these days, is that they may have outlived their
usefulness, though.
