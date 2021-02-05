Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A55C433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 20:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 258AE64FBB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 20:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbhBES0b (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 13:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbhBESXp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 13:23:45 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF6AC06174A
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 12:05:54 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id n15so8166440qkh.8
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 12:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UAuHbCUq+l876enoEyDd0GydNd+uGcbGqzYvHHVbntM=;
        b=HreJEVzy/kRYkFheDXHDYsA0vi5Hec0zPO6pefRiFqqiW4uqPNLxIAFTRSkrkP7EIF
         R0aK5X0RWmGK0Wo9+btB1/0uFWbP6kxeeCeZ0T3NpWUTBOuEcOHy0GGqTZ47HJ5l10n6
         Y7c60THACSulVgUQastBADt7prgX9uEq0Fs/JOde15UTkEFSmQyyQy9DBSwQp4ujZ9sl
         p9Pq02pY2scBdhdAY0qg8qmSi8hQnnWZDgvkoba5YrGbP8oaq3cgb3kKxtddIUq39+1j
         0Q6b5hY93FGdmZWUvDlRIb9r5Bju97cqnKpQKdI9rKwXf8pgHfdNFALxIfxjP1YqXx8p
         iXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UAuHbCUq+l876enoEyDd0GydNd+uGcbGqzYvHHVbntM=;
        b=hmWO1xSqv4Y74WOTqO5Ter+wFlPCYMZBKc6SpP3k/nA+ciaXArzRLb2FaeItAuq/p+
         8HUHDONbCEei9NMK4+kBWaNUYjRHjz8rCp8wV+9FasIdTjN7l64vh2XH+DDV2SiVUO8W
         JcZ5rdt4tCoE8SCsnODrVo/j8D8ujDqvXEjKMd4G9EuuWV5KxRSHXowvX5eEvRB4+3Qf
         tVpH8mQ3y7ERSQJvKAKdefbWyyO8+ogsrb3fGv105YB9eJUCpIsTKFlJ7CO8a1UDM/Mj
         9QV12b261cxfkqSaDrhia3RhRUU4pdjDyUWCdSBxMHZ/dLJJlmlZUa/AmoY0vN5GvJ+Q
         +KNQ==
X-Gm-Message-State: AOAM533hEk1IUjpf++WMvwAexVVLarBWGZKLExXATYc7DYom7eyIhzbn
        blRhD1R7j2Et7WZZef4K1XSlzw==
X-Google-Smtp-Source: ABdhPJy2hn6m8493dXvTCtskGXuIPKrcUZImv6O5FUm7U21bDAvP+heMuPBpyqsjRuURPW5OOYvdaA==
X-Received: by 2002:a37:a802:: with SMTP id r2mr6107328qke.197.1612555554225;
        Fri, 05 Feb 2021 12:05:54 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:5271:ed06:5498:6bb0])
        by smtp.gmail.com with ESMTPSA id k8sm10410663qkk.79.2021.02.05.12.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 12:05:53 -0800 (PST)
Date:   Fri, 5 Feb 2021 15:05:50 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/6] Optionally restrict range-diff output to "left" or
 "right" range only
Message-ID: <YB2lHmLxe8ArFz0v@nand.local>
References: <pull.869.git.1612469275.gitgitgadget@gmail.com>
 <xmqqtuqr4frw.fsf@gitster.c.googlers.com>
 <YBx5rmVsg1LJhSKN@nand.local>
 <xmqqtuqr2uz3.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtuqr2uz3.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 04, 2021 at 04:56:16PM -0800, Junio C Hamano wrote:
> > I'd add an additional use-case, which is ignoring new commits from
> > upstream when displaying a range-diff in rerolled patch series.
> >
> > Oftentimes I'll find that the automatically-prepared range diff that
> > 'git format-patch --cover-letter --range-diff' generates will include
> > new commits from upstream, so these new options should help me ignore
> > those in the output.
>
> Do you mean that the new round is based on an updated upstream
> commit, while the old series was based on a bit older upstream?
> After rebasing your topic, "range-diff @{1}..." would find the
> updates in the base (made in the upstream) plus the new round of
> your work on the right hand side of the symmetric range, while the
> left hand side solely consists of your old round (unless the
> upstream rewound their work, which should not happen).  But that
> must not be it, I guess, because in such a case, among the commits
> in @{1}..HEAD, we cannot (eh, at least range-diff cannot) tell which
> one came from upstream and which one came from our fingers.
>
> So I am a bit puzzled there.

I'm talking about a situation where a later re-roll is based of of a
newer upstream. But your judgement is right: upstream's updates look
like "new" commits on the right-hand side.

I have some scripts built around this, but they all boil down to passing
'--range-diff=@{1}' (where @{1} is the tip of the previous reroll) to
format-patch. See:

    https://github.com/ttaylorr/dotfiles/blob/work-gh/bin/git-mail#L8-L10

for details.

IIUC this series, I think I'd also want to start passing '--left-only'
to ignore the new commits from upstream in a range-diff, no?

Thanks,
Taylor
