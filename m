Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2249D1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 04:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbeJPMdl (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 08:33:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38779 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbeJPMdl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 08:33:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id a13-v6so23758404wrt.5
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 21:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SdNBmZDXd9YB1t1+bALOaTWjQCmpv5YZ4mii+SAn5cQ=;
        b=UCiXSHUsxbEiI/IBSzzO3PTo/6zGpmpYwVOCfoTkLBeIDP7XS5t+L00TaL3K9vpRiM
         Iy5EOcDu8fk6+X4yXEgkjU8ZEENu+QNV1jOaGaNHy3A6rKnntoIKh284KHPKKzPmRtmT
         NmRMLxieNinoPJJOj7h2R5wHySxBV/pRafNePWq9tjNApmWHimDTjN1DvvmTeoyrga8c
         uyMdNtT57PAszt4n8tGRTObP/xvmby01XqHPE6Beka9mtz4XmviIYVCUen4ir7lNIPET
         1prFLQsOo5ieTMexlz+oXCKj3NcotWOlA/EHneWY9QLWxTuswShkpB09K4l9zNKv5JL0
         hNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SdNBmZDXd9YB1t1+bALOaTWjQCmpv5YZ4mii+SAn5cQ=;
        b=MjvfNXTIVfl3F0A0muimbL1nlZTvAeM4rySoW0gDgPFkbs+hND4fEJ/5PjBJ2l/c07
         +9tsmeOA2fOc5T11My3J4tSlXGjdstHwgJWh2F6+dNFx3JXdqs6AQh102R2Zety/+NvM
         ONDMRMc5vfnposrpfFrTsYNmULAhgGRGipJyEJCEZckEqZNYO8NT494jD87mWgZVa+SR
         kb4bN6RSj5KBEmWfiG88XYp5vRyxMw6ppy4PYk3UQrlI6LKkS9eH2lFzLworySdPnFm5
         IBNvLUnNfqEx+Z1vIU4YArIZYVWoE/UXA8K33BdjwzWv5opwkkiKdzVy5mCV7uQQbA46
         B8Zw==
X-Gm-Message-State: ABuFfoh0ANtlXr9J7hfmIDn++cTWsvpXtfmukV8KQfGpZezBSZXPiZgQ
        jnqw2BfgOOlMBI6h0lMIy2E=
X-Google-Smtp-Source: ACcGV619CKviHj1O9o2m5yESPj9klTaU3p7Ecrt4IdwbSWonVc+EwIbZmWkBO/4OggUTBexam6xs5g==
X-Received: by 2002:adf:fb4b:: with SMTP id c11-v6mr16456533wrs.117.1539665108731;
        Mon, 15 Oct 2018 21:45:08 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u10-v6sm9595028wrt.59.2018.10.15.21.45.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 21:45:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 0/4] Bloom filter experiment
References: <a66afe22-0523-c785-91e6-bf545683c67d@gmail.com>
        <20181009193445.21908-1-szeder.dev@gmail.com>
        <61559c5b-546e-d61b-d2e1-68de692f5972@gmail.com>
Date:   Tue, 16 Oct 2018 13:45:06 +0900
In-Reply-To: <61559c5b-546e-d61b-d2e1-68de692f5972@gmail.com> (Derrick
        Stolee's message of "Mon, 15 Oct 2018 10:39:45 -0400")
Message-ID: <xmqqlg6y1ovh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> 2. The filters are sized according to the number of changes in each
> commit, with a minimum of one 64-bit word.
> ...
> 6. When we compute the Bloom filters, we don't store a filter for
> commits whose first-parent diff has more than 512 paths.

Just being curious but was 512 taken out of thin air or is there
some math behind it, e.g. to limit false positive rate down to
certain threshold?  With a wide-enough bitset, you could store
arbitrary large number of paths with low enough false positive, I
guess, but is there a point where there is too many paths in the
change that gives us diminishing returns and not worth having a
filter in the first place?

In a normal source-code-control context, the set of paths modified
by any single commit ought to be a small subset of the entire paths,
and whole-tree changes ought to be fairly rare.  In a project for
which that assumption does not hold, it might help to have a
negative bloom filter (i.e. "git log -- A" asks "does the commit
modify A?" and the filter would say "we know it does not, because we
threw all the paths that are not touched to the bloom filter"), but
I think that would optimize for a wrong case.

