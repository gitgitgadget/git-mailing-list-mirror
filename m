Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C49A11F462
	for <e@80x24.org>; Fri, 31 May 2019 20:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfEaUxI (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 16:53:08 -0400
Received: from resqmta-po-07v.sys.comcast.net ([96.114.154.166]:56344 "EHLO
        resqmta-po-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727551AbfEaUxI (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 May 2019 16:53:08 -0400
Received: from resomta-po-19v.sys.comcast.net ([96.114.154.243])
        by resqmta-po-07v.sys.comcast.net with ESMTP
        id WoD2hvLw9oy4VWoWRh3Nvh; Fri, 31 May 2019 20:53:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1559335987;
        bh=C3YQyXvnv9PVBw/Orpas1yaLKygbakje/G6ROtYzQ1M=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=gYyDXR9j3Ky5PiJ7KTOqNMD3/9T6zHuW4AM65tERGsdjPUxJeCUd9WHtbBvgYpOFC
         EKEbn/2Obm4P7FUmzoCdiv2+nT5jiDYS6Rs6FP53UBduCwdaCjqHigTfmv+KJvGhRI
         WFqHVjTY169r99KgZl0hgVrBh7+Z8c4j5vycOhLLQCew3XZ2oqZorzJdKWVAYpXOMg
         6Bhx8pTQH4ye/0WjSuhUi6pCQUK1s/rzmp+K6V21d/xlJ1gSSyTi0Cqnf3xUNH4JzB
         eIUXFFyTmWsqP9VI8neFJySlnP8lDbvi5zrrjtiu6WGuZ4uxtiaRHoPW6DeHTpYVsB
         aTtZG68wW4Vjg==
Received: from comcast.net ([IPv6:2601:647:4b02:2491:a4f1:9a8c:7e29:36eb])
        by resomta-po-19v.sys.comcast.net with ESMTPSA
        id WoWPhPE4dmPHJWoWQhWeo6; Fri, 31 May 2019 20:53:07 +0000
X-Xfinity-VMeta: sc=0;st=legit
Date:   Fri, 31 May 2019 13:53:05 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthew DeVore <matvore@google.com>, jonathantanmy@google.com,
        jrn@google.com, git@vger.kernel.org, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com
Subject: Re: [PATCH v1 3/5] list-objects-filter: implement composite filters
Message-ID: <20190531205305.GD4641@comcast.net>
References: <cover.1558484115.git.matvore@google.com>
 <1f95597eedc4c651868601c0ff7c4a4d97ca4457.1558484115.git.matvore@google.com>
 <2b47d4b1-ea62-d59e-77e0-d95dfad084e0@jeffhostetler.com>
 <xmqqh89e31fg.fsf@gitster-ct.c.googlers.com>
 <20190529150228.GC4700@comcast.net>
 <9f1025ec-a3d7-c5f4-4a7a-15e4131f2b87@jeffhostetler.com>
 <20190529232746.GE4700@comcast.net>
 <0d8973e7-5b29-fb09-a435-3bf2ec23269f@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d8973e7-5b29-fb09-a435-3bf2ec23269f@jeffhostetler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 30, 2019 at 10:01:47AM -0400, Jeff Hostetler wrote:
> BTW, I don't think I've seen this mentioned anywhere and I don't
> remember if this got into the code or not.  But we discussed having
> a repo-local config setting to remember the filter-spec used by the
> partial clone that would be inherited by a subsequent (partial) fetch.
> Or would be set by the first partial fetch following a normal clone.
> Having a single composite filter spec would help with this.

Isn't that what the partial_clone_get_default_filter_spec function is for? I
forgot about that. Perhaps with Emily's suggestion to use parsing functions in
the C library and the other cleanups I've applied since the first roll-up, using
the URL encoding will seem nicer. Let me try that...
