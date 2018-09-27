Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB4331F453
	for <e@80x24.org>; Thu, 27 Sep 2018 18:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbeI1A45 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 20:56:57 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:37543 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbeI1A45 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 20:56:57 -0400
Received: by mail-io1-f74.google.com with SMTP id r18-v6so4004235ioj.4
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 11:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9zzASNn0UB8SMMU/QL52HI2DlHfkvPau9lrDnePKAv4=;
        b=W5polPkAoul3ZGbYlcqd0PqLfgDSP3QfX2WdSyemkjKP2pYzA3/ebzIs6exF1Oxr1N
         hr4Lj98o2h+u46Ujrph8qToouzEe2G1Rs65p8VW3ok86rzSbXNhcNP2kcC1RoJqDNgQ2
         fobkQ73Gtdr8m5ZO5Nrbz6MoCLSvI/EUtcaADycz/9M7jzGSS8c1jhi7qonjR9Ur9N/2
         I7ZlyZqN3zWtAWFMmBA33qTGKs8k7+91t5jH8xDszC9Eu7p5MxLyW6CEiI5I9JalCt6q
         w5lS1eNcClsAEa4SuX1z48eajIcU1pP/VMQeRVfsEqtvtR8DC64yx2NxvCaT9CK/CcDG
         j1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9zzASNn0UB8SMMU/QL52HI2DlHfkvPau9lrDnePKAv4=;
        b=OkIiKLlYKPHAxTzWVTv2kApq6EkpNxhX/6+eR41kYqrAu9A+URe2WKCsnRErhgDxzv
         CWNkVjTr17XK3hcwIaiHI7s71LhpSsdCt/PZ835p3LE29RcO1I75AYVCOmSCAoTVQrP8
         29v1o8161m9udfgKeRaYEeNu6Xkll26Lfs0aGs6yfwXCNseBn98YDh+puVLBIY+yBhxw
         zh6jpoJysswBYLCqM5UOA6wOtzmz6mW+n65FxsKZXYGrAwbIT9K2iMPRw5dQV5r7m7Jx
         ixw69IUVOhPoW1GwaT+c4QTU7wwOhgbPeySBi2snQODvZ/h4nPZxChX2VrLCBT+BXa3s
         wL0Q==
X-Gm-Message-State: ABuFfojXqHM7VxwfJJwTbao8Eozygwz9LGPT07T6O7P29Xi1E5+hNa0z
        lvNloP8yiM/xZfnUYxJNV+WNK0DI11mamT6v43Td
X-Google-Smtp-Source: ACcGV60YhM1Lb+m7VWZD2OjUVNtico+7DPWvYG588mirkcV5pj0QE5MCCKUpPcbjNdgQvFtJXj6gF3XnokEzCQ+QYw2N
X-Received: by 2002:a24:4245:: with SMTP id i66-v6mr7790161itb.5.1538073441821;
 Thu, 27 Sep 2018 11:37:21 -0700 (PDT)
Date:   Thu, 27 Sep 2018 11:37:18 -0700
In-Reply-To: <xmqqh8idns9i.fsf@gitster-ct.c.googlers.com>
Message-Id: <20180927183718.89804-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqh8idns9i.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: Re: [PATCH] fetch-pack: approximate no_dependents with filter
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> It is very clear how you are churning the code, but it is utterly
> unclear from the description what you perceived as a problem and why
> this change is a good (if not the best) solution for that problem,
> at least to me.

Firstly, thanks for your comments and questions - it's sometimes hard
for me to think of the questions someone else would ask when reading one
of my patches. I have tried to rewrite the commit message (you can see
it at the end of this e-mail) following your questions.

The new paragraph 1 addresses what I perceive as a problem, and the new
paragraph 2 addresses the ideal and partial solution.

> After reading the above description, I cannot shake the feeling that
> this is tied too strongly to the tree:0 use case?  Does it help
> other use cases (e.g. would it be useful or harmful if a lazy clone
> was done to exclude blobs that are larger than certain threshold, or
> objects of all types that are not referenced by commits younger than
> certain threshold)?

Yes, it is solely for the tree:0 use case. But it doesn't hurt other use
cases, as I have explained in new paragraph 3.

I have retained old paragraph 3 as new paragraph 4, and removed old
paragraph 2 as it mostly duplicates the comments in the code. New commit
message follows:

[start commit message]

fetch-pack: exclude blobs when lazy-fetching trees

A partial clone with missing trees can be obtained using "git clone
--filter=tree:none <repo>". In such a repository, when a tree needs to
be lazily fetched, any tree or blob it directly or indirectly references
is fetched as well, regardless of whether the original command required
those objects, or if the local repository already had some of them.

This is because the fetch protocol, which the lazy fetch uses, does not
allow clients to request that only the wanted objects be sent, which
would be the ideal solution. This patch implements a partial solution:
specify the "blob:none" filter, somewhat reducing the fetch payload.

This change has no effect when lazily fetching blobs (due to how filters
work). And if lazily fetching a commit (such repositories are difficult
to construct and is not a use case we support very well, but it is
possible), referenced commits and trees are still fetched - only the
blobs are not fetched.

The necessary code change is done in fetch_pack() instead of somewhere
closer to where the "filter" instruction is written to the wire so that
only one part of the code needs to be changed in order for users of all
protocol versions to benefit from this optimization.

[end commit message]
