Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 367011FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 17:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933313AbdCaRS3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 13:18:29 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34096 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933153AbdCaRS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 13:18:28 -0400
Received: by mail-pg0-f54.google.com with SMTP id 21so77030992pgg.1
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 10:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qaMILxsJXtMWDIK2VhDZ/qYf7BKUcfqPthhpndM6t0U=;
        b=G/i0ZnKYzCrx1+aZVRiM3RNCb+4nezBYpiBWQ284/dnwLyaAEY8WV4dzWLxSae36hb
         C84qTuWkn77DQDzC91rSuLA8ylXQdufbjueX+rsjP8ldM66/Pom6ya0jDPfRTk/iciK8
         zJWoqsaSuSscgKJ5LuY4aEDHVn7/0LkvYRCsm+acXUvB4KBGnMqZ7qLQySqX/7GKTOXX
         eO6UwmkQbymReKuxeowWXyD5a5nt1Q9TGUeqkBaTIE9wd2lseHACi/YihkSZkNxgZDHo
         aE1TLzMgQhfEuJM3+jwDb2+wBsuq/8zZ3I29TLEEFvhcGLok8Is/OUHNLbr1hFbiNciI
         RTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qaMILxsJXtMWDIK2VhDZ/qYf7BKUcfqPthhpndM6t0U=;
        b=j3ZmxuJwzlOPZiCAi4D0WiaE86/6M9weqd6baO+HVO36k17Tic9p+d/2Mnj3xc63k5
         fWNlwLYnLNGhI/hZXU79B4Wph7WDadAkUDx/V4V7JXpQBN491JK/QHrU3FC0R8+i1p7Z
         vIQF5wYgSwvtcKY8sFRobcAX9GacPkBxYRRqVfnQQX4cX2SZ0A/OcH3uLrJ0vsC+/KA0
         YYCrf7Y4vmOaXZ3raIB8d8Y5ZiDyV1TahXiGUw7oyPpT4R2z3zGMXZ1v5yPr+jS5d6bg
         sUZGG+BLTQDPAqpjdgjLMJvV/AKDo58kirXTZN53e9CwFSW/WanfRKtQYw5Io3oA9g01
         jniw==
X-Gm-Message-State: AFeK/H17xdty7+8V64vr0d4uePSFv2aYcsgrho6Bi+ofr3eo0WPgUbPYJwV6mN8ak9NhP7xyGTPZIB626Itzb2Er
X-Received: by 10.98.72.66 with SMTP id v63mr3837435pfa.8.1490980706859; Fri,
 31 Mar 2017 10:18:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.186.196 with HTTP; Fri, 31 Mar 2017 10:18:26 -0700 (PDT)
In-Reply-To: <53e0eed5e13a04f502dcaeda83b2cbb3035f1396.1490966385.git.mhagger@alum.mit.edu>
References: <cover.1490966385.git.mhagger@alum.mit.edu> <53e0eed5e13a04f502dcaeda83b2cbb3035f1396.1490966385.git.mhagger@alum.mit.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 31 Mar 2017 10:18:26 -0700
Message-ID: <CAGZ79kZ9uGjhN5n8YAdUh2xqDMxTmmfsa7rCEWMk-Bsp5uxncg@mail.gmail.com>
Subject: Re: [PATCH v2 01/20] get_ref_dir(): don't call read_loose_refs() for "refs/bisect"
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 31, 2017 at 7:10 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Since references under "refs/bisect/" are per-worktree, they have to
> be sought in the worktree rather than in the main repository. But
> since loose references are found by traversing directories, the
> reference iterator won't even get the idea to look for a
> "refs/bisect/" directory in the worktree if there is not a directory
> with that name in the main repository. Thus `get_ref_dir()` manually
> inserts a dir_entry for "refs/bisect/" whenever it reads the entry for
> "refs/".
>
> The current code then immediately calls `read_loose_refs()` on that
> directory. But since the dir_entry is created with its `incomplete`
> flag set, any traversal that gets to this point will read the
> directory automatically. So there is no need to call
> `read_loose_refs()` explicitly; the lazy mechanism suffices.
>
> And in fact, the attempt to `read_loose_refs()` was broken anyway.
> That function needs its `dirname` argument to have a trailing `/`
> character, but the invocation here was passing it "refs/bisect"
> without a trailing slash. So `read_loose_refs()` would read
> `$GIT_DIR/refs/bisect" correctly, but if it found an entry "foo" in
> that directory, it would try to read "$GIT_DIR/refs/bisectfoo".
> Normally it wouldn't find anything at that path, but the failure was
> canceled out because `get_ref_dir()` *also* forgot to reset the
> `REF_INCOMPLETE` bit on the dir_entry. So the read was attempted again
> when it was accessed, via the lazy mechanism, and this time the read
> was done correctly.

With all this retry logic going on, it is hard to add a test demonstrating
this is correct now. The description makes sense though.

Thanks,
Stefan
