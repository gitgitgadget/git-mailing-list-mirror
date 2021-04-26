Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7799C433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 19:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F19361359
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 19:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241650AbhDZTuP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 15:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241238AbhDZTuP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 15:50:15 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C49CC061756
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 12:49:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v63-20020a252f420000b02904ecfc17c803so23524100ybv.18
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 12:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Jm7tXBVa7R4ER6xP4ydVPMzphImzKmBZRZJjjOjdFI8=;
        b=YNRfVhkkWMBqcZBg8BxfWQBBKqxpVwdsabys0EM9K3GXE10dKC+iHkzJji5d2LZ4QJ
         Vjrq3W/3sKEaJ7/Itu3b04MsIQDgxAJod0TFRB3kNjRlb4I0e7jIOcWFmBYf4LgWJ88H
         ZMb+3uNM8eNeQ2H5zHaoDo33IR986piLkl2cBcUGlB6oknFLgALJJnJJs313Q5oo68w3
         U9kkglDgRsie/iGzatjn/66ip2Y0kJ4MKUqu/T0HAA+EE9FP0YUQb2EPP6Nv0TR7M/1p
         336AFn2J5r1S2GGN/BnUBxipgF64eQoHXd017w6YBSEU7HGz53GlY5vTkq5vscpOM13T
         qZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Jm7tXBVa7R4ER6xP4ydVPMzphImzKmBZRZJjjOjdFI8=;
        b=V++zH5ShJqOoI2BBMNj2c6ZoXDBqiXUos8ihVhxugAtNDwGVamWBFAJ9jJJq9xsqb8
         AWmV4xKHKWIYQNdXYxi99GCu6HuZ+bfo7L5q7z2xGPDizs99BLKiRB1ycCsmnjQgEGIO
         B6MqwhfhClmEKEWuch3nanQHt3S/eESoR20HTlBSTs6FWohWsRyfN9H9hW+DBF0V0pm7
         ZzDM/OF1Qa3l+Rjwmp4fNdZsNgU9yD0G1EBEl2ziBErdSGurzdr9kk+Y95dMHt2HgrqG
         tISLurzd/EU4OcZuzBgC1X8gJnsA+0rv3fqsCklvEshO8RHqb3vvsCwAQiN9fUTbGsTb
         Ql+A==
X-Gm-Message-State: AOAM531QNHBvO2ThFeL4U6xYnT6GK2hw8c8aLFPU6Fse++CgjhFE7pBy
        N5bfopjyannY4oU1WECuaX/yXUuzVw7vDMFVLg06
X-Google-Smtp-Source: ABdhPJxTbRMq0Xtzl4BlGgHycocQFwifWFaapaYAfoM+BS2rtzK73ZKG/uR2jFEOFTNHsGvAbaQy2fuFUptFTV6GHyP1
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:d390:: with SMTP id
 e138mr18632851ybf.142.1619466572392; Mon, 26 Apr 2021 12:49:32 -0700 (PDT)
Date:   Mon, 26 Apr 2021 12:49:28 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2104231409500.54@tvgsbejvaqbjf.bet>
Message-Id: <20210426194928.326338-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <nycvar.QRO.7.76.6.2104231409500.54@tvgsbejvaqbjf.bet>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: Re: [PATCH] cache-tree: avoid needless promisor object fetch
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Johannes.Schindelin@gmx.de
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > In update_one() (used only by cache_tree_update()), there is an object
> > existence check that, if it fails, will automatically trigger a lazy
> > fetch in a partial clone. But the fetch is not necessary - the object is
> > not actually being used.
> 
> I find it curious, though, that the `ce_missing_ok` variable is defined
> thusly (sadly, the context of your diff is too small to show it):
> 
>                 ce_missing_ok = mode == S_IFGITLINK || missing_ok ||
>                         (has_promisor_remote() &&
>                          ce_skip_worktree(ce));
> 
> Which means that the `has_object_file()` function is only called if the
> entry is not marked with the `skip-worktree` bit, i.e. if it is _not_
> excluded from the sparse checkout.
> 
> Wouldn't that mean that the object _should_ be there?

In a partial clone, probably not?

> I guess what I am saying is that while the commit message focuses on the
> "What?" of the patch, I would love to hear more about the "Why?". And
> maybe the "When?" as in: when does this actually matter?

In this case, that's something I'd like help in figuring out too.
Normally this code path (unpack_trees()) prefetches everything through a
call to check_updates(), but the update flag is somehow not set so there
is no prefetching happening.

> And since the bug was critical enough for you to spend time on crafting
> it, maybe it would make sense to add a regression test to ensure that this
> bug does not creep in again?

OK.

> > Replace that check with two checks: an object existence check that does
> > not fetch, and then a check that that object is a promisor object.
> 
> This essentially repeats what the diff says, but it might make more sense
> to explain why the post-image of this diff is more correct (and maybe
> discuss performance implications).

OK - I think this is the "why" and "when" you described above.

> > Doing this avoids multiple lazy fetches when merging two trees in a
> > partial clone, as noticed at $DAYJOB.
> 
> Ah. But where are those trees fetched, then?
> 
> Maybe lead with the description of the bug?

This was a partial clone excluding blobs only. I'll update the commit
message to mention this detail.

> > Another alternative is to think about whether the object existence check
> > here is needed in the first place.
> >
> > There might also be other places we can make a similar change in
> > update_one(), but I limited myself to what's needed to solve the
> > specific case we discovered at $DAYJOB.
> 
> I only see another `has_object_file()` call site at the very beginning,
> and I think this needs to fetch. Or maybe it is more efficient to
> construct the cache tree from scratch than fetch it?

Good point - if we can construct it, we probably shouldn't fetch it.

> There is also `cache_tree_fully_valid_1()`, where I think the same
> handling could potentially make sense. (Or, if you target `seen`,
> `cache_tree_fully_valid()`.

True.
