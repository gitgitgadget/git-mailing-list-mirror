Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D023A1FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 18:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753572AbdFSSvw (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 14:51:52 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34114 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753768AbdFSSvu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 14:51:50 -0400
Received: by mail-pg0-f67.google.com with SMTP id j186so17601463pge.1
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 11:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EQp5YKg6OsAZGGG545rgF6jlrQsRpBOMSfIZRkB/gAw=;
        b=gX8qW5nJ//JBOMHEBzbE09GRTtgrQ1P7wGCtku/Fjg/ityDCJIT6mVWt9Nz208p5Te
         TsWRN5TjoPCxzKS3fvjQKEdFi5tGt11MLdQSgKcyvXN6xyCaVTitHwFXVEWX//1jQ5Ij
         Y9hJHmMyzUpFMczyhyuDDopMtxHOnvWfWDlCmRwNEXFdoXghdXIaofXXN+QU+auAo7AM
         fD1YsqTepfuQACE3O2ubzf64VhpcSl5NerDvjMWtE1I2Pc+1F8PI0ti7wrU9zrbmo/j4
         4S+DR6a1HzlDCWDjDOQgVmQfwhIRO69F6QVYyw7o8xitNRmDP9FMl2LQSklHj3XoRSg4
         wi+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EQp5YKg6OsAZGGG545rgF6jlrQsRpBOMSfIZRkB/gAw=;
        b=FagyYHCjqT+pDoCky6WgkJUFkOO/WFyI4vzRjZYWXkttcMgMtWTYj4x2kW9ywJptM4
         AIiXj3KUDxTtvx0Vr7x/o/IK1hxNlWB8Q7JVCde1+vyJMq2Ce0uMvgzFadM4azjSgtLe
         o4czZ76mbGA9705hVayjV/6o+FaeXVQ7LHRi7OoLaXzyCY7+KrCxl3gre+nTdobHfnLK
         BcC9wBQ4WvYwTJydLU+jmLT+vy7d7YjWC8HZhMAWEXyFUw6HPIYuSSm8dtMmgw+frv9D
         zj5BOod3+Uw/wxIHyaovTLVnLoebFjqDLR+JGkV9g/ZU0ylJ7R2aE6ZvqRxYzgdBbiMW
         NYxw==
X-Gm-Message-State: AKS2vOzccMG5mhTz4cYTAi42UIg6gUHGkbiW/Ij60UpHW6YqNJ96mMyN
        h/VNDDk3C0h3Vg==
X-Received: by 10.99.247.83 with SMTP id f19mr27875934pgk.190.1497898301444;
        Mon, 19 Jun 2017 11:51:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:7466:3d2b:4ee9:fc7])
        by smtp.gmail.com with ESMTPSA id z69sm24773115pff.0.2017.06.19.11.51.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 11:51:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 00/28] Create a reference backend for packed refs
References: <cover.1497534157.git.mhagger@alum.mit.edu>
Date:   Mon, 19 Jun 2017 11:51:39 -0700
In-Reply-To: <cover.1497534157.git.mhagger@alum.mit.edu> (Michael Haggerty's
        message of "Thu, 15 Jun 2017 16:47:05 +0200")
Message-ID: <xmqqzid3stdw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I've developed these patches on top of master plus the following
> patches, which are followups to mh/packed-refs-store-prep:
>
> * lock_packed_refs(): fix cache validity check
> * for_each_bisect_ref(): don't trim refnames
>
> The patches can also be obtained from my GitHub fork [2] as branch
> "packed-ref-store".
>
> Michael
>
> [1] http://public-inbox.org/git/cover.1490026594.git.mhagger@alum.mit.edu/
> [2] https://github.com/mhagger/git

Thanks.

Both in the version I queued and a fresh fetching of c13b2fad
("read_packed_refs(): die if `packed-refs` contains bogus data",
2017-06-12) from your https://github.com/mhagger/git repository
seems to exhibit an annoying error message in my local repository I
use for the primary work:

    $ git fetch https://github.com/mhagger/git packed-ref-store
    $ git checkout FETCH_HEAD
    $ make
    $ ./git describe next
    error: refs/notes/amlog does not point to a valid object!
    v2.13.1-611-g7e3b11ae1b
    $ grep refs/notes/amlog .git/packed-refs
    ed07e83cff8e407464fb2f5e84bd311da9c87565 refs/notes/amlog
    $ git rev-parse refs/notes/amlog
    b3079212325398e406078585c785c892d6e572f0
    $ git cat-file -t ed07e83cff8e407464fb2f5e84bd311da9c87565
    fatal: git cat-file: could not get object info
    $ git cat-file -t b3079212325398e406078585c785c892d6e572f0
    commit

Is the iterator over packed-refs correctly skipping over what are
covered by loose refs?  The entries in the packed-refs file that are
superseded by loose refs should be allowed to point at an already
expired object.
