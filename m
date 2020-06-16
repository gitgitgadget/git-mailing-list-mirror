Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5672C433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 02:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8512020707
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 02:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abdAs64h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgFPCWn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 22:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgFPCWm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 22:22:42 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A49DC061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 19:22:42 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id b5so7558283pgm.8
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 19:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1ju62vorDqGFaryMU/JUDtql/qTL+2xi901yI/GJMbg=;
        b=abdAs64h+tZD56NPeLLjof5/90sXJrAv+frInCxDS3JMnY4bDTWVNxrOMFe+/AkVTM
         BXg0B9PyAboMCuPZ9X653E3KoMLoerSyVAPAKO8W6Ym7U/2N5dSr09d6NMixx0B0j+EA
         gAzpzyJgxv2AiOHj6zN6Z6Q1ZGZa1bay7qD71U3aKsEneg/Dy1eJKYfatX5Xz3ORh3I0
         RpD9HeIYB+TYXOWXTxnbZpDlAwKNMjtjFXctr/5oH9TvDh4sJAXZpOX8MuSqUlRpZe96
         t2Mu6OR3M4QBcS48lzn+dDXVBYsEs23NcVCo77+KWwE7HolixrRnBUq5JRKvtKwk3Qux
         mugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1ju62vorDqGFaryMU/JUDtql/qTL+2xi901yI/GJMbg=;
        b=h+jjBdWddstJHVsWCk7mjkCKMn+7LQH/ebdj5bZ82J6f0YbSaIefZF4fZtALeBPebg
         2yqw0E3BKNSLAVP+a6+rAu4SNomYVxbi8nIq070lIdJrZ1R/gfATRQ/RfPWOOBrAJTzc
         1hkuMKHqD3TFOlc3t5msDqF8KcxemUhgd3B3GgVNusSr7urKXFy5VYNRQHBE2YfOvG3/
         TRpzPSFS24my/jGk3oydAETy/dQy0rnuUDCJVPQDPtAuek4d8bbMv/XtJ03lcjp6wBB+
         9QA7EH3u2tppsazkogeW395a7gQxNddpR6Xt++sthr6kLi/JCYX6KAZ3Nzons6Rb9oqO
         SoqA==
X-Gm-Message-State: AOAM531Izfkv1jtpk2ssf0rweXzfI8XM6NSj10uUbynECTvVqW4mpmfW
        QpjM//eCZNxMWyW3dGS0BVDKa+4o
X-Google-Smtp-Source: ABdhPJzQlxDrpVs/5A5MZ5yZGzD7ofg5iHxLXoTx6CxR9xfUR06kkvD6ToIV06TatIDRBGeKl6uaIA==
X-Received: by 2002:a63:ff51:: with SMTP id s17mr348169pgk.300.1592274161602;
        Mon, 15 Jun 2020 19:22:41 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id b7sm14671994pfo.202.2020.06.15.19.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 19:22:41 -0700 (PDT)
Date:   Mon, 15 Jun 2020 19:22:39 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Nomen Nescio <nobody@dizum.com>
Cc:     git@vger.kernel.org
Subject: Re: Consensus on a new default branch name
Message-ID: <20200616022239.GD164606@google.com>
References: <6b6f161981a07070871633fe02c4c3f9@dizum.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b6f161981a07070871633fe02c4c3f9@dizum.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Nomen,

Nomen Nescio wrote:

> Taylor, how do you propose to build this consensus you're talking about
> on the name change?

I'm glad you're interested in learning more about the Git development
process!

There are some open source projects that function (mostly) as a
democracy --- they build the features that those voting request.  A
famous example of this would be PHP[1].  There is something admirable
about that approach, but it is not always easy to get right.  Many
other projects have their own approaches to governance.

In Git, we make most decisions by a rough consensus of active
contributors, as judged by the maintainer.  There are times that
consensus may go in a direction that is unworkable, and the maintainer
has the ability to make a different decision during those times.  If
decision making ever goes off the rails (perhaps you've judged this to
be such a moment!), users of Git have the recourse of forking the
code; such moments have happened in some open source projects in the
past, for the better, such as the EGCS fork of GCC that was widely
used by distributors and eventually became the standard version of
GCC.

If you are looking to have more influence in the Git project, my
advice would be to become a respected contributor, by providing
patches, well thought out reviews, documentation improvements, advice
to bug reporters, or other contributions.  As others learn to trust
your feedback, you will have more influence on consensus.  Even
better, you get the immediate benefit of your own work as soon as you
do it.

I believe Taylor was also interested in another kind of consensus,
between hosting providers, but that would be likely to coincide with
what the Git project does so the difference is a bit academic.

[...]
> slacktivism

This is a very weird way to describe the people who are spending their
time to maintain Git.

Thanks and hope that helps,
Jonathan

[1] https://lwn.net/Articles/821821/
