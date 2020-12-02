Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13F7C64E7C
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 16:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72C05205CA
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 16:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbgLBQKu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 11:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgLBQKu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 11:10:50 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0174C0613CF
        for <git@vger.kernel.org>; Wed,  2 Dec 2020 08:10:03 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id l4so2109578oii.4
        for <git@vger.kernel.org>; Wed, 02 Dec 2020 08:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v8/GaEkdIKyYByGFW9BZ1FJZQl8i6whvDwzqXBpiY1Y=;
        b=pcHV2I3R38tfu4gIH6rbhanlCsSEYD5I121r89PCXrc1SZIeK+ZknZI45WXn7v3cDK
         IraiaxPX7h4djL+33hh+nwgnq32XWMtbH5o3hfFqV4p3kbA4kQMg1OWh2lsjv1BzX9ON
         Mxr3a7rzga8sNHDzqr7ChjtpywpDPwkayQG3b6JFohLmQ+nk09AG1SeGhqPUhRcFKS3i
         1C21riW3NcLXpqioJmvUYthLhtUqqI6yUHirwwKxnVhXDz7GXc4s1sBKVu+o2Mkurt1J
         5JfaoWixcdHJaT7rM6unVw4hh8Nugk3kPwhLYDnXOBk2lGwUNpAGLgEGQDr1sTR8wh1t
         hJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v8/GaEkdIKyYByGFW9BZ1FJZQl8i6whvDwzqXBpiY1Y=;
        b=r8G/E83rDV1KBmW8Eu2406a9xk8hlzdsyyEaZmayyK6Rba4pu1ikkpDp30tBnwWPqu
         /F2zGnnLsQWZxHl9hwoBHMdDgKAdcl/I9S79R7JBsc3U7thqYH9396n38uffIysj/fJq
         WE3PapdFNrsqiIt8u+C7gvXPJoqsPR/VDuD6uDsLH3gCZRWaH5NWAnFb9uSnX7kEuscQ
         5kzPQfAfmkml0Kbb2Rjqhxccnv6ykIf8j6yxABtkgbY7j5w7/HZtt1fbK6LCrgjdMLvc
         FHb9qIcAvNSP81QiK+wiRtW8kdVnCupWrHF8IVtfFILmC+Xl40UEFvghzYsLg9XA8OdH
         lVuA==
X-Gm-Message-State: AOAM533cAMURMJ2l1KcvvQXzMi/gA4ZIbVql0+Ijxg/HbLcwhcbYbegp
        4r3DWDGBbAhuN72py3In4732L/VQ+OPG9jZjYLw=
X-Google-Smtp-Source: ABdhPJzFLIVz/pkMtTvtQew+FRUJjxqZf9ktls2ccULyuk2bLQpyCXSLdCq2Uk2ehuzACINH72Cm3Tqfj9wCe1oN7Uw=
X-Received: by 2002:aca:49d5:: with SMTP id w204mr2056558oia.167.1606925403210;
 Wed, 02 Dec 2020 08:10:03 -0800 (PST)
MIME-Version: 1.0
References: <pull.919.git.git.1605891222.gitgitgadget@gmail.com>
 <pull.919.v2.git.git.1606861519.gitgitgadget@gmail.com> <1fa263cf3c3d1b0c20ad89e6454a7b903a07f193.1606861519.git.gitgitgadget@gmail.com>
 <xmqqr1o9m8on.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqr1o9m8on.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 2 Dec 2020 08:09:52 -0800
Message-ID: <CABPp-BGTkGO+19_AUrHFF4P8J8g_RnfbL6r4jHkxYvdE5_h8mw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] stash: remove unnecessary process forking
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <dstolee@microsoft.com>,
        Chris Torek <chris.torek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 1, 2020 at 3:02 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >     git diff-index --cached --name-only --diff-filter=A $CTREE >"$a"
> >     git read-tree --reset $CTREE
> >     git update-index --add --stdin <"$a"
> >     rm -f "$a"
>
> This is orthogonal to what this patch does, as this is supposed to
> be just bug-for-bug compatible rewrite.
>
> But I wonder if the above sequence, whether it is done as a series
> of plumbing invocations or subroutine calls, is a relic dating back
> in the days before i-t-a existed.  If we want to revert the changes
> to the index for working tree files for removed or modified ones, I
> do not offhand see a good reason why we would want to keep the
> contents to new paths---if i-t-a were available when the sequence
> was designed, I suspect we would just have added the path as i-t-a
> in order to keep track of the presence of the path but not
> necessarily the contents in it.

Yeah, I thought a little bit about the same thing, but wasn't sure if
there was some other reason for the current behavior or if there was
some workflow that might be relying upon it.  Rather than investigate
and try to switch it over to i-t-a (which could still be done later),
I more narrowly focused this series at just doing the "make the
changes be available in the working tree, but remove them from the
index unless it'd make it untracked" more carefully.
