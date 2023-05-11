Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4380C7EE24
	for <git@archiver.kernel.org>; Thu, 11 May 2023 23:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239557AbjEKXja (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 19:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239473AbjEKXj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 19:39:28 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5616F170D
        for <git@vger.kernel.org>; Thu, 11 May 2023 16:39:27 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1aaebed5bd6so66724995ad.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 16:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683848367; x=1686440367;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AEhh2lWz/RdB+DtiqsIfPfmlilf0arNf+kbIADrWJps=;
        b=hZQzghEgypdtCNi65ju4yMTSDl5k7xSA8PKcOhjsBps/dUKEhz8QqXIz807PCXzIbA
         gU//295j2OR7j/JTitdOJEx0Lswx0NVRV+W2knUwvqCat6rnKD9xngOIEnNLB4gqv4NG
         NdDcRbU6yUs8fgvdaTygyABiawLkRdls0IN0vVNFbfEowLngZuCV0WkpZAJ2d/Hn14Oy
         kAPteFj1O54CwE+w5xYLeBYHGHSIsxn4vi9O0ky/3dWWCrzM8N8jjrz5UvsnaIRcMBa4
         wcFqsBH/hDsTggRPlfTjkbCvLOaQpT2Q3OTeutAU02lwgGGWiPC4zTiK7hSWMAJN58c6
         vazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683848367; x=1686440367;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AEhh2lWz/RdB+DtiqsIfPfmlilf0arNf+kbIADrWJps=;
        b=OPmiY0IGy6mDmJ01GasQgCGG5lsLOyrYLwhV4rVKVjbf6ffcP2OuMUmAcf0N9l9O4X
         CwTWzk/jT+3Qk5OKgx7/mhomSs376q3rBwx1EsAbRplGVYbNA+ebUpEtDNnJu61Hby0A
         jWBlygXJ4iVDdK4q9GoGVlZAXIjPkqEKV50FKYv4rb5GtJ2YWZfQiGDxV9OyhX9JyQpG
         +vUHouTM3D6fDAjEL4WhvzZ0eSCvw4qLJlBu6llCQP4WX81g7TgsOS9kQ5VuYrtaIdhR
         gvV+Z9hfmsdeatOWHHZC4yfh4f7wvnLktCcQo9lqXibw25n1hJxvV5PkhjkxzuOGcJFT
         +8bg==
X-Gm-Message-State: AC+VfDwhFtooSlW5SGI9GIrE5EaqXEbHKpkds5NZwkOoT49rR/tLD3Yv
        GdGmFBqBYN4EUTBaEoYkVzw=
X-Google-Smtp-Source: ACHHUZ77AYiX3R38LI9TgY+I+qzXspWQCyF4uUehKOtn2NDr9xZJtHnBuuG26jYmoNFjDdNORv/F+Q==
X-Received: by 2002:a17:903:1c6:b0:1ac:946e:468e with SMTP id e6-20020a17090301c600b001ac946e468emr14243621plh.57.1683848366767;
        Thu, 11 May 2023 16:39:26 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902e74400b001aafe56ea70sm6532110plf.5.2023.05.11.16.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 16:39:26 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 0/2] pack-objects: introduce
 `pack.extraRecentObjectsHook`
References: <cover.1683847221.git.me@ttaylorr.com>
Date:   Thu, 11 May 2023 16:39:26 -0700
In-Reply-To: <cover.1683847221.git.me@ttaylorr.com> (Taylor Blau's message of
        "Thu, 11 May 2023 19:20:31 -0400")
Message-ID: <xmqqttwisaj5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Here is a reworked version of the patch which introduced a new
> configuration `pack.extraCruftTips` to keep additional objects from
> pruning during a cruft pack-generating GC.
>
> The third round was significantly more complicated than necessary, and I

Hopefully you just meant "the previous round"; in a follow-up you
mention that this is v4 and not v3, which is also a good explanation
for that "third round was too complex".

>   - The new code does not change the existing cruft pack implementation
>     whatsoever. This is nice, since cruft packs will be the default in
>     the next release, so changing that implementation carries additional
>     risk.
>
>   - The new code is also not specific to cruft packs, meaning that you
>     can do things like:
>
>         $ git -c pack.extraRecentObjectsHook=... \
>           repack -Ad --unpack-unreachable=1.hour.ago
>
>     and have it write out loose copies of any object(s) mentioned by one
>     or more of the configured hooks.

OK.

> I am hopeful that others think this version is in a good spot. As in
> earlier rounds, I would appreciate an extra careful review on this
> topic, because of the changing default I mentioned earlier.
>
> Thanks in advance for your review.

Thanks for working on it.  I am in the process of pushing out
today's integration cycle already, so this topic will have to wait
until tomorrow's, though.



