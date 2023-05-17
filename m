Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6186AC77B7A
	for <git@archiver.kernel.org>; Wed, 17 May 2023 17:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjEQR1X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 13:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjEQR1G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 13:27:06 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2AE9EF3
        for <git@vger.kernel.org>; Wed, 17 May 2023 10:26:50 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-4d9b2045e1cso404a12.1
        for <git@vger.kernel.org>; Wed, 17 May 2023 10:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684344406; x=1686936406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B22VdvhjSZjNBnPMULEEL38aGhBL2m9EOLHzrnrD49E=;
        b=ePQe7uW2M3l5P6+dSuk6C8UXlvQX4c3ist4Ma8iVkJNsHRc4xfjP4g4cOXktYLSUE4
         x2kcbEbtBtfiL8aksVQfoLFzwTGOq6ZTMED8NHAzLQXLvknVw41I1DVLUQ8fiIALJqYS
         aNzFK7/q+BBWArBUV6vuktC9cVFr6Ju3al8MR8Q27BVs2u70reLO3U43ZEtLWAQDJl/J
         vH/ri+wIW2OwDDV9Rfz6S6UqYjAvBw2ce+4wJcobC7748VfQ6agoN7dSHpo5WF+iK5LJ
         wlk2NCD00PFBKs4qt/o3y7TmWmxlHQuIn8xmaUS+gSVu7rLVKHDDY3LnciglgwQuq7hy
         OsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684344406; x=1686936406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B22VdvhjSZjNBnPMULEEL38aGhBL2m9EOLHzrnrD49E=;
        b=YsT6Bojz4oX+YGMdR0IHxvTmkIMSINYEg4OhT74b1GNgLkEeSqG/febEnV3Vh+mDU0
         xMDtIfLDtv5oM9pUUk4qK1Or5DfJeQPj6Xx5jaV/AaAV+fN9Aj3Vg2p73jXvHWKmRSu6
         dIFOR5YQiruBhCzhcj4qUwJ1MR5g96yeHwh9tERcqzf71UVoeVZ95s7t502sdR4yE7Dr
         sXtT6XDfJIF9zlqJ/A8W1vb5s2P3sWmZaIicZ9/COYDhrhr76TcPZfa2J+59jDyjS1Ox
         MJPmhWiCBhuZnW3U3m0XIstzskJvbeOfFoRG5wnHQe2KWFOZk3dYh3VkC+H/zSsu2YTf
         BVlA==
X-Gm-Message-State: AC+VfDzFBq7MaXo0TFsfW/3rMPgDfXZPMRsNMcaQhOpaALdZtTeBOaeU
        tT9VRptnA0e4Jdh/ar+4QmzX3oqyWjwbNi+268gd2mTr80yV3vV7kI0=
X-Google-Smtp-Source: ACHHUZ4k77XABdPxzPw4ajdBbYjQeFbFgKz4mk7UpjhuN3RKUB1tEPCj6ySwvb9hNBkUQhoMOTrRGRfNosYnDjpueLI=
X-Received: by 2002:a50:ab19:0:b0:506:9116:dcc8 with SMTP id
 s25-20020a50ab19000000b005069116dcc8mr126826edc.7.1684344406122; Wed, 17 May
 2023 10:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230516170932.1358685-1-calvinwan@google.com>
 <20230516170932.1358685-4-calvinwan@google.com> <xmqqwn17sydw.fsf@gitster.g>
In-Reply-To: <xmqqwn17sydw.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 17 May 2023 10:26:34 -0700
Message-ID: <CAFySSZDXYbW2ZUQuaufZr8JSq+HEOgoeqYHRUxnKr0G6ya9znw@mail.gmail.com>
Subject: Re: [PATCH 3/6] common.h: move non-compat specific macros and
 functions from git-compat-util.h
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> At some level I am more or less indifferent, in the sense that both
> compat-util and common need to be included by a .c file anyway,
> whether it is _our_ source, or in a future third-party source that
> wants to link with the libified part of Git, so it does notreally
> make much of a difference if ARRAY_SIZE() is defined in which one of
> these two headers.  But presumably such a future third-party source
> may arrange their own system support using their own counterpart to
> compat-util without using ours, and if that is what motivates this
> change, I could understand why a more-or-less git-agnostic common.h
> could be a good idea.

Also, a later patch moves ALLOC_GROW and other macros from alloc.h to
common.h. I thought it would make more sense to have a common file for
these macros to be moved to rather than adding to git-compat-util for
the sake of only removing the alloc.h dependency from certain files.

> Everything, other than sane-ctype macros, does look like a generally
> useful git-agnostic helper functions.  If we were to move in this
> direction, I probably would prefer to separate sane-ctype macros in
> a separate header, simply because they are _designed_ to override
> system supplied ones and some third-party source may not want to use
> such a "feature".

Ah that makes sense that they would belong in a separate file like
ctype.h -- I can split those macros out.
