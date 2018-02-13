Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 541E61F404
	for <e@80x24.org>; Tue, 13 Feb 2018 18:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965535AbeBMS6C (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 13:58:02 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46527 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965492AbeBMS6A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 13:58:00 -0500
Received: by mail-wr0-f196.google.com with SMTP id 34so9381407wre.13
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 10:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+gjaaljeWeNYiJM9OGNzam1sCUjfo6jjG3qiIwGzJfg=;
        b=ARFHgfur6NabJuyhk7AA3mVjZbfg4fiMRuhmG4FbvkSk04L4Q5AnmixQFe38SbnlbU
         6cigbU8epczdwoQxy6ZvQ9XbiLilsDJu1T4cPZ5fbbQNWTX/OTv1y/76VxOGccDESp1N
         eAyyFF6szNWrNnkf8WNrqf2h1w0DN1oavzZHm9yhCY4e/HTX4FCurrpmlJM+5cgenZnr
         YtLdHs9cKDEBH/o03nzfDIY5ZL3udPVXZd+iWY1trXo48xIVqv01q+Ho2imBg+JzekGP
         d/gBXnYm41JbLoKSaZSNkp172rsDeygUiWqe1jrzWAOBuK1GdMsjRFwPcATWHCCMgMl5
         i3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+gjaaljeWeNYiJM9OGNzam1sCUjfo6jjG3qiIwGzJfg=;
        b=EqsPmPb15XwnmW5+eDhw+R5p5vPWSIhIjRaflyvWyFqA1SIn3AZLlMGxB7v1QK9fKr
         q7ybDT0iERBBFgjUZTnfuSP2z/Yz4p+co7hTirW6+kBHm5DgECUZyVnoTeffEBPUQxIY
         3ikCGXVQ2IbduFrF+YvSkwqae58rBb/6bJvkPlPSI+4kghc/5Z5lk9keYRa4xB7jQ5Vd
         Zy6Dit3FS+8/EbbGgfzHiPJn/N28XSJWN1+ev+bSgnd8O2XZBYepRxUNHWTq3znvsAxh
         uSc8S1/7hFx1u4qm8LmjPn9KoKjmBxmYJnVY8j5BrD94Y7FhI8bv7+IKPz+7gNaJ8ywZ
         n3XQ==
X-Gm-Message-State: APf1xPA9+gbNcRMPzvMFf41QqnSvFbr5BaOOsbBg1mTM9mQxZ6VnHUtg
        w7T04dUXAbJn8xBRf3XMjY8=
X-Google-Smtp-Source: AH8x2246DOFJBJIck/TR1bvj8UAFY/J6HoBcLelJS4fnoWq8HIHLCc3lnsdeZ4RAKHl5gQH1YDc5Gw==
X-Received: by 10.223.197.200 with SMTP id v8mr2030729wrg.22.1518548279203;
        Tue, 13 Feb 2018 10:57:59 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p12sm9923151wre.83.2018.02.13.10.57.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Feb 2018 10:57:58 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 00/26] Moving global state into the repository object (part 1)
References: <20180213012241.187007-1-sbeller@google.com>
        <20180213114903.GA21015@ash>
        <CACsJy8C8+VnjrhEh3o36GUttZXmfiKxqjzS=2LzmfZKQjogojQ@mail.gmail.com>
        <CAGZ79kbmAkN5EpW1hzW-FFdR74c-qXJc5aKZX0ff9bU0gxMRqQ@mail.gmail.com>
Date:   Tue, 13 Feb 2018 10:57:57 -0800
In-Reply-To: <CAGZ79kbmAkN5EpW1hzW-FFdR74c-qXJc5aKZX0ff9bU0gxMRqQ@mail.gmail.com>
        (Stefan Beller's message of "Tue, 13 Feb 2018 09:47:38 -0800")
Message-ID: <xmqq7ergra2y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Oh, that is an interesting perspective. Here is how I arrived at the opposite
> conclusion initially: Searching for 'ignore_env' shows that we care about it
> as well for the index and graft paths, which are not the object store, hence
> it would be better kept in the repository. (The alternative would be to
> duplicate it into the raw object store, but I do not like data duplication)
>
> But maybe it is better to duplicate this one bit instead of passing through
> a larger scoped object.

If a larger scoped repository refers to a smaller scoped
object-store, is there still a need to duplicate that bit, instead
of referring to the bit the smaller scoped one has when asking about
the bit in the larger scoped one?

I am not sure if these "do not look at environment variables" is an
attribute of these entities---it sounds more like an attribute for
each invocation of an operation, i.e. "I want to learn where the
index is but would ignore GIT_INDEX environment for this particular
query." and "What's the value of this ref?  Please honor the
common-dir environment during this query".

So from that point of view, it may not matter where the "bit" lives,
among repository, object-store, or ref-store.

