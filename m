Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66040C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 20:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 371682076E
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 20:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fb6Ik6xQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgHUUl6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 16:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgHUUl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 16:41:56 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7621EC061573
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 13:41:56 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id h3so2623940oie.11
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 13:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jxml8qAE3MHBZIRvie/B2YrrFz4JBKkVf3QvlvRG24U=;
        b=Fb6Ik6xQCTh+AybvdCpJ0u3Q5GFk046SqzTojdXCgvNHjrJHULQiuVlW9KukrXnpjz
         wbD6e1KOn5dSkHV9q3AbUdtLxwyqXB+jtLQ+6gqTsOmy6BV9Pfmo8Iuim0hwDsi2UGq6
         r4P7czeKaeabWsNGtn2AXePAH6hhjKEyxiw9LI1cJZphDoB6IoIjltZsbX2jfKBz4WtT
         NeINs4JJTGwAyNE/XL+Bg172UyP+Y146aWJm2nD10YU53WCv2mtQTJvz6IadhwnvQy8F
         Gd9uMifO1rAlSit6FgIqN0z/XbjP10c+4HFRuG6NMac/Izy0GDgireAq6/85bvZJ/Tn2
         sm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxml8qAE3MHBZIRvie/B2YrrFz4JBKkVf3QvlvRG24U=;
        b=ig+YOvTcvW24aHMD5TVr/rVJNyaDWfXsC/jWWl5Ns5jriD3YgJRG42Kt8Uum8B0PK6
         Pl0C3K3yRjwSOaI5qDoVin7ybTXlKZPlf4eQJeSmn5NSYXHEvSlRT6XkE9FlQP+qua95
         0RusOvtvkBuLdSDwpqIWg3ErpNrVQr8kcojTovN7HuoOLeCTJk4MhcAuF5bbD8ZE82eb
         843AV/23D7Gy8DvAnMtGK7w33ybS55LmddygoElxY3hYxfKUOUDPjQaSapRD620riIVd
         ilsjTp6/5ijFqYAgQxgKtV2/UODvY8Uof3pzKMckWLVBmjIJYY20Qy6zykHctkafDoFI
         Le8Q==
X-Gm-Message-State: AOAM532lXDp3RA7D/HiRv1QHrdQ+QCiiYPH2tD5qjoMuN7hTExt0m/rh
        v2eG976a4rz9yu20OU48kb+d/YU5sYSH4w39FqFo7NjQ8bzzXg==
X-Google-Smtp-Source: ABdhPJxy3EOevExacKJ7AX0M80Iho1NbWbvP0DNclX0kcK6muqqxM/gNpgFJg62UoHQiNbYdJbKGSyM3RRTu+/9KSFo=
X-Received: by 2002:a54:4099:: with SMTP id i25mr3054852oii.39.1598042515416;
 Fri, 21 Aug 2020 13:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <b3095d97d8ee9d6576292731cc100492e7c64f13.1598035949.git.gitgitgadget@gmail.com>
 <20200821200121.GF1165@coredump.intra.peff.net>
In-Reply-To: <20200821200121.GF1165@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 21 Aug 2020 13:41:44 -0700
Message-ID: <CABPp-BGJK4C7U+-MB-+TUgFAuuFJKE-E7y17FFJDRTyFydVX2A@mail.gmail.com>
Subject: Re: [PATCH 4/5] strmap: add strdup_strings option
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 21, 2020 at 1:01 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, Aug 21, 2020 at 06:52:28PM +0000, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Just as it is sometimes useful for string_list to duplicate and take
> > ownership of memory management of the strings it contains, the same is
> > sometimes true for strmaps as well.  Add the same flag from string_list
> > to strmap.
>
> This is actually one of the ugliest parts of string_list, IMHO, and I'd
> prefer if we can avoid duplicating it. Yes, sometimes we can manage to
> avoid an extra copy of a string. But the resulting ownership and
> lifetime questions are often very error-prone. In other data structures
> we've moved towards just having the structure own its data (e.g.,
> strvec does so, and things like oidmap store their own oids). I've been
> happy with the simplicity of it.
>
> It also works if you use a flex-array for the key storage in the
> strmap_entry. :)

I can see how it's easier, but that worries me about the number of
extra copies for my usecase.  In order to minimize actual computation,
I track an awful lot of auxiliary data in merge-ort so that I know
when I can safely perform many different case-specific optimizations.
Among other things, this means 15 strmaps.  1 of those stores a
mapping from all paths that traverse_trees() walks over (file or
directory) to metadata about the content on the three different sides.
9 of the remaining 14 simply share the strings in the main strmap,
because I don't need extra copies of the paths in the repository.  I
could (and maybe should) extend that to 11 of the 14.  Only 3 actually
do need to store a copy of the paths (because they store data used
beyond the end of an inner recursive merge or can be used to
accelerate subsequent commits in a rebase or cherry-pick sequence).

So, in most my cases, I don't want to duplicate strings.  I actually
started my implementation using FLEX_ALLOC_STR(), as you suggested
earlier in this thread, but tossed it because of this same desire to
not duplicate strings but just share them between the strmaps.

Granted, I made that decision before I had a complete implementation,
so I didn't measure the actual costs.  It's possible that was a
premature optimization.
