Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D17220248
	for <e@80x24.org>; Fri, 22 Feb 2019 20:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfBVUrq (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 15:47:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56025 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfBVUrp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 15:47:45 -0500
Received: by mail-wm1-f68.google.com with SMTP id q187so3120957wme.5
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 12:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Oz5xX8nQjAs33zA3PT+lN53z56+uvFllD9Q/mHuFBgY=;
        b=pPxDn5B4AYbULb7AxfR1srdV8Z+qpqVgPQtblc5l24QsUL4jfrRT+o8NdUed+deh+0
         tqkkaWbIxvw4lfg41nvkkj4T/kVxPRzACIKhPjp8qM9YxRpoe6QleLkAtqTo90N6H03K
         sDeRsi4aov4cTzP26ImEsjbjrMmYrnLvyMddUjnKzFSAfuS6KHYGge6Hwr3XGqh2tpYQ
         Aciqy2oYyqvYU/PF49snOm7Jb6N8gNU2Lky3PdyLDwDZOGL0BhBUbnsBaLXxGZD7ts2n
         wYmJ2HGrR7MgRc0VAse5oNf+TDkQ33dsi+MIFRl28r1iQX5CyGRUp5oFEl5eYqoMICOX
         dLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Oz5xX8nQjAs33zA3PT+lN53z56+uvFllD9Q/mHuFBgY=;
        b=fxTob8vjv0XPvUWhBVZnMh0B49LnuO9ng+ba5fL8AoCh60QHzO+f1SRoSopRvb1MQa
         dsXUsdAiow+s4wl3uCZUa/u/1Qa369EbvSmMAhtag32kP0xyBWwJVu4tW3BlOB2Et3Q9
         wJKbZiGhfaOyrzb/YL2CZMvSVs9tRus3l+hE6x6WQSIlZUDpVu6qQjEVGNhO3uy8EMpK
         dA4N99+y0AKveGi4qRckZsZiCuJlozwu/oqrd/9s9zgzOlt2C3gn/z6UWbGPoVmq1kP9
         vAc56tfyLAC6xRqtqmKdFQk6d5zArD86qLyAkTpyBWNIAouEsmpZu66qLyfkcWfPLsmJ
         BvcA==
X-Gm-Message-State: AHQUAua+9g1Mzwpk0zMafRjs6IfhnWFgJA2Tm68kENmFvAha37K1oWSZ
        HBI1gt1EDm5B+T5jc2DrN54xYkIv
X-Google-Smtp-Source: AHgI3IYPySwYNKvcu0tdkTrkOPyPvX/Sm+qJBKJcpKJkt3ZfL4qe3TAo+EW3uMHMbemRkNSbE2lmOg==
X-Received: by 2002:a1c:6589:: with SMTP id z131mr3532496wmb.120.1550868463696;
        Fri, 22 Feb 2019 12:47:43 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k20sm1775247wre.41.2019.02.22.12.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 12:47:42 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        steadmon@google.com
Subject: Re: [PATCH 2/8] tests: always test fetch of unreachable with v0
References: <20190211203011.GB9072@sigill.intra.peff.net>
        <20190214195825.125751-1-jonathantanmy@google.com>
        <20190221134954.GC21406@sigill.intra.peff.net>
Date:   Fri, 22 Feb 2019 12:47:42 -0800
In-Reply-To: <20190221134954.GC21406@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 21 Feb 2019 08:49:54 -0500")
Message-ID: <xmqqimxbpn2p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Feb 14, 2019 at 11:58:25AM -0800, Jonathan Tan wrote:
>
>> > On Tue, Feb 05, 2019 at 04:21:16PM -0800, Jonathan Tan wrote:
>> > 
>> > > Some tests check that fetching an unreachable object fails, but protocol
>> > > v2 allows such fetches. Unset GIT_TEST_PROTOCOL_VERSION so that these
>> > > tests are always run using protocol v0.
>> > 
>> > I think this is reasonable, but just musing on a few things:
>> > 
>> >   1. Are we sure going forward that we want to retain this behavior? I
>> >      feel like we discussed this on the list recently with no real
>> >      conclusion, but I'm having trouble digging it up in the archive.
>> 
>> One such discussion is here:
>> https://public-inbox.org/git/20181214101232.GC13465@sigill.intra.peff.net/
>
> Thanks, that was what I was thinking of, though there doesn't seem to
> have been much discussion in response. :)
>
>> >   2. If it does change, is there any way we could automatically find
>> >      spots like this that would then need to be undone? I cannot think
>> >      of a good solution, and I don't think it's a show-stopper not to
>> >      have one, but I thought I'd put it forward as a concept.
>> 
>> We can do so now either by "blaming" one and finding the originating
>> commit, or by searching for "support fetching unadvertised objects" (I
>> used the same comment everywhere in the commit [1] so that people can do
>> this), but I don't know how to enforce this for future work. (We can add
>> a special variable, but I think it's unnecessary and we can't enforce
>> that people use that new special variable instead of
>> GIT_TEST_PROTOCOL_VERSION anyway.)
>
> Yeah, I think we can find them once we know they need fixing. I was more
> wondering whether we would remember to do so. I.e., is there a way the
> test suite could remind us when our assumptions change. I can't think of
> an easy way to do so, though.

Perhaps looking it a different way may help.  Instead of saying "v2
will not protect unreachable objects, so this test must be run with
v0", think of it like "Git ought to protect unreachable objects, so
test with different versions of protocols to make sure all satisfy
the requirement---for now, v2 is known to be broken, so write it
with test_expect_failure".  IOW, have one test for each version,
some of them may document a known breakage.


