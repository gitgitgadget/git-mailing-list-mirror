Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CE061FAF4
	for <e@80x24.org>; Thu,  9 Feb 2017 05:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751318AbdBIFOU (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 00:14:20 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33087 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbdBIFOT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 00:14:19 -0500
Received: by mail-pg0-f67.google.com with SMTP id 194so16847840pgd.0
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 21:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+LAHBMq4GxclVp9KDVYnryTInqFwc+BFwWbNjl5Nb64=;
        b=DncYNtiWRu1S10MgzT/vQPrrZK+1vLjdGHl/QVrsTMGBRgslRT1/pBNXU07YeDiIEq
         XER3p3yXGCqtby8fNoN43mMtrfijMiZYZpRtIl5NlLCluhCdiaOyVo6AKhjq3u32ZOFf
         46y16+mX5zawzBTrywA0rDKTKQa8wATqkDgUlZR+FsTSwETiPtcne06SbMGEbWVvrJAo
         0rGFcg9E2zVHw2boYf2ALeMTfI5JTI3WfHE3Ak0vrwr8hbxx4dvBleXLq10gFF5ypBzY
         k+IyjLgYOm3kjfS0s7LO1jvd/560CV0TZkRrdPqFADOScuh4rT+KscEh2n9TYNmUyGQs
         dTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+LAHBMq4GxclVp9KDVYnryTInqFwc+BFwWbNjl5Nb64=;
        b=of7x1Wa94+bDVclGK8RT1y9NBPwI194TO3HNZ1bDZvAz77hZEVbrC7rbVP447U6Zu4
         6jJkMz4MVY6oHqiCTqNxw2Gz9EsIDopUOdiJPc73xNd4EvBSRjXg2JLTn6PFBJ2v4b7T
         FcRD2I/l0GaMUKRnBuRtFExvyMQ3ocrDHjR3gKe5FrkhMn18aXK+h3AV+MNAcFS2Ms9Z
         CZjytll+F+9MAZvCJgzQX9055JZsock/bQq9cNXvWmkqUK/gvZEGqRSXpFTsKOz1PvE9
         rVrGvwtsEh80T2j6NW/ZjGAAhPLs1ftaHCyo23KQV4b53hLoJ0cgFVq348paGjZer933
         KHeQ==
X-Gm-Message-State: AMke39mpQSV19RAAKxY/y7jGp9hYEY5ggcgyB8+7w41mbdAOUCyGohQQkVsQeHFmPwbyug==
X-Received: by 10.99.8.4 with SMTP id 4mr1698393pgi.204.1486617258897;
        Wed, 08 Feb 2017 21:14:18 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:7c20:fa7c:46cb:2209])
        by smtp.gmail.com with ESMTPSA id p15sm24482282pfk.58.2017.02.08.21.14.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Feb 2017 21:14:17 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] grep: use '/' delimiter for paths
References: <20170120171126.16269-1-stefanha@redhat.com>
        <20170120171126.16269-3-stefanha@redhat.com>
        <xmqqpojhwf2r.fsf@gitster.mtv.corp.google.com>
        <20170120235133.GA146274@google.com>
        <20170207150414.GD8583@stefanha-x1.localdomain>
        <xmqq8tphzr41.fsf@gitster.mtv.corp.google.com>
        <20170209035839.wqsh6ibgnmxyjusi@sigill.intra.peff.net>
Date:   Wed, 08 Feb 2017 21:14:17 -0800
In-Reply-To: <20170209035839.wqsh6ibgnmxyjusi@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 8 Feb 2017 22:58:39 -0500")
Message-ID: <xmqqtw84rlna.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>   master:a:a:a:a:a:a:a:a:a:a:a
>
> I think there are 2^(n-1) possible paths (each colon can be a real colon
> or a slash). Though I guess if you walk the trees as you go, you only
> have to examine at most "n" paths to find the first-level tree, and then
> at most "n-1" paths at the second level, and so on.
>
> Unless you really do have ambiguous trees, in which case you have to
> walk down multiple paths.
>
> It certainly would not be the first combinatoric explosion you can
> convince Git to perform. But it does seem like a lot of complication for
> something as simple as path lookups.

That is true, and we may want to avoid the implementation complexity
of the backtracking name resolution.  If you are on the other hand
worried about the runtime cost, it will be an issue to begin with
only for those who do "git grep -e pattern HEAD:t/perf", which is an
unnatural way to do "git grep -e pattern HEAD -- t/perf", and the
output from the latter won't have such an issue, so...


