Return-Path: <SRS0=euRE=EN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882F3C388F9
	for <git@archiver.kernel.org>; Sat,  7 Nov 2020 15:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C83C207C3
	for <git@archiver.kernel.org>; Sat,  7 Nov 2020 15:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ic3iG7wi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgKGPCk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Nov 2020 10:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgKGPCj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Nov 2020 10:02:39 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A94C0613CF
        for <git@vger.kernel.org>; Sat,  7 Nov 2020 07:02:39 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id j7so4842218oie.12
        for <git@vger.kernel.org>; Sat, 07 Nov 2020 07:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rKuhExLHW1sso0T/zMWuZwoz/gCuuGfjjZ4E4oDcsPI=;
        b=ic3iG7wigC71bkHK06kY/dYkXBSBgG0wUb8KDxWvOCoLcpzbcAeOE2H/AL1KiZ3zw/
         26IWaXgWUL+zgFy60iIHyGHC2hITh/9LXhkN/G/lbWFTMWeEwUAg50RYKvbnTU4miaB3
         9nrVgsG8o32q7OT3whrdhu7A8dnX6WXAr5gbRCnduAuvsu/bO42kCJegWLO7HJkCqgl5
         lPdqA9/RdfC3HJBADTUrbstQiQ4g+cLY0GQpbv1kAEojCEhTK7LsQCX3Ox0dsos1LeLq
         FpOaTAZyMgP0tewYqBqDmBP2w8puZdE5pPEYAeG9lij3RBBKawV0wPBe1WjoGdfVwP+d
         DQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rKuhExLHW1sso0T/zMWuZwoz/gCuuGfjjZ4E4oDcsPI=;
        b=OMz1VFABX4N1pt57AKF9Hk+xJVRSMZrFT9oqiE7LZWxLKC7s0MBb2KJArox7QHhNGL
         bmkbyK05c0+aGq77RIwfknLAUGB797Ae1kaLXFeAsVIkw+mDoXhvdV7BlzLy6BXLfV0V
         lmdAPqT1zMWRCYrBIF1PA8Ungbk16lNNW9FcxehA31PYJb/nXuAFVqIUVLA4mcCLlWCn
         Kjbgot9LDUD3f96FiMzDgAk6O8tPQxfFBz/jU/DAL2INUpgLR9Z5U3chai8i+C3o0ugI
         +T0RIUTpA0pNxQYfXcwOnbSY+VyccoOtXkHYKvBkrO7h3M0jkbJkeZUiuWC7c9PjbLnJ
         XTsA==
X-Gm-Message-State: AOAM531zVu2LiDI+ZqjNRB1jik8oO3E0iQ0AbhN1Bneh4jr5XGm4K3Ra
        7Wpd7N0sSqQzTfzjg2ZdQJ8jiVPQfheT4w==
X-Google-Smtp-Source: ABdhPJziDAz2fIAap1G73SxDDYyPuKxhbw4U0JOQ+9HFDZ14HuH7nE0L1mtvYs97+hHDpwv0CeF/Eg==
X-Received: by 2002:aca:4ccc:: with SMTP id z195mr4089710oia.124.1604761357481;
        Sat, 07 Nov 2020 07:02:37 -0800 (PST)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:f594:492d:8ff8:3649])
        by smtp.gmail.com with ESMTPSA id y62sm1103983oia.23.2020.11.07.07.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2020 07:02:35 -0800 (PST)
Subject: Re: [PATCH v2 00/20] fundamentals of merge-ort implementation
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <20201102204344.342633-1-newren@gmail.com>
 <0197d698-e966-f0bb-4d77-0183e93d9bef@gmail.com>
 <CABPp-BESfpqjrskz-UQikEfk_rV_QpQybo_hStVw=K8jXHYmfA@mail.gmail.com>
 <CABPp-BGvgdK8vEu5+mHjy9=GPg-aVtforC4-AAYgs3RWkBwQJA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ca61acbf-1757-5ddc-49f7-6da0cba4a647@gmail.com>
Date:   Sat, 7 Nov 2020 10:02:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <CABPp-BGvgdK8vEu5+mHjy9=GPg-aVtforC4-AAYgs3RWkBwQJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/7/20 1:06 AM, Elijah Newren wrote:
> Hi Derrick,
> 
> On Tue, Nov 3, 2020 at 8:36 AM Elijah Newren <newren@gmail.com> wrote:
>> All that said, for testing either branch you just need to first set
>> pull.twohead=ort in your git config (see
>> https://lore.kernel.org/git/61217a83bd7ff0ce9016eb4df9ded4fdf29a506c.1604360734.git.gitgitgadget@gmail.com/),
>> or, if running regression tests, set GIT_TEST_MERGE_ALGORITHM=ort.
> 
> I probably also should have mentioned that merge-ort does not (yet?)
> heed merge.renames configuration setting; it always detects renames.
> I know you run with merge.renames=false, so you won't quite get an
> apples-to-apples comparison.  However, part of my point was I wanted
> to make renames fast enough that they could be left turned on, even
> for the large scale repos, so I'm very interested in your experience.
> If you need an escape hatch, though, just put a "return 1" at the top
> of detect_and_process_renames() to turn it off.
> 
> Oh, and I went through and re-merged all the merge commits in the
> linux kernel and found a bug in merge-ort while doing that (causing it
> to die, not to merge badly).  I'm kind of surprised that none of my
> testcases triggered that failure earlier; if you're testing it out,
> you might want to update to get the fix (commit 067e5c1a38,
> "merge-ort: fix bug with cached_target_names not being initialized in
> redos", 2020-11-06).

I did manage to do some testing to see what happens with
a large repo under a small sparse-checkout. And using
trace2, I was able to see that your code is being exercised.
Unfortunately, I didn't see any performance improvement, and
that is likely due to needing to expand the index entirely
when checking out the merge commit.

Is there a command to construct a merge commit without
actually checking it out? That would reduce the time spent
expanding the index, which would allow your algorithm to
really show its benefits!

Thanks,
-Stolee
