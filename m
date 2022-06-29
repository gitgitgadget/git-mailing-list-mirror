Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B03C43334
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 22:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiF2WzL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 18:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiF2Wyj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 18:54:39 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E8C403D0
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 15:54:09 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id a19-20020a17090abe1300b001ecae1011fcso387291pjs.0
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 15:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=MYWLUBmFECq5B1KkiZVMY6UMF9xcpiYCHSPfiTg7QX4=;
        b=IJ/w2QfzWP0IkUPwEO5ayhKwLh8aHO7F3xSlbsZfJi56cU8hHtmk+wzoeW3R8vfPuY
         CxXHFrFpxoSfTjHkfuyCjvZslV5b4GzxWhVfbPAlZOzWG8/w92XolUOY2mGxdGeUGVNS
         TITivWlmC38tf3p+SGzRtrDp1qh2ZbqPFJs/8qeP3AdIXUm6XVkgOBtHfGC1V1EUC62N
         RtsJ3tnDGuL0sChOpCyOzZuU3jkc5ppQoj3X0HXIOeFwBLcVtAMlUVdTFPbeC9oNmjxr
         vfAtJXzoJuJJhLckNtZFqJHSyTdgd40X5kkMqfZ3RW65VQ2bR+oV0csy0yIS3S2eiTIS
         hrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=MYWLUBmFECq5B1KkiZVMY6UMF9xcpiYCHSPfiTg7QX4=;
        b=6/q3nTRdJrh7gBVmj73LX+Y8jntenscCjmS/AyBnfWdVskwbugFI1wy913v+j9dPWU
         bTWCv+CFF7SYjcSKXSJLBYjptUOUb8bUXBdputAdijXnE6FAtFeXPMZprX1Ng3fOT+nO
         c16bN0iMsXRNVBmkdKFy7hfJgTjzpe31IcoAdJDnFS9neh8Mh+DQ/jMmxI7Zz525yDqg
         cT4vUdlwyain/6v+wHmespkSV/Uy5W4RCe3vHiaLrbIEREkzfok1MpYVMyS4wl9YeI/9
         dG4BMsNtUmxXMwjXvkCm1E9hBBxtXHaToA2vbBcBpFE1W+zun7mTySBPTksZ/oqX1K5l
         QdUg==
X-Gm-Message-State: AJIora/lR4v5OF1iSrPFn97jPyXFj7dOIlkHZoj/2wsF+euRXDF/9olM
        v7nuVUaiGWUGRXRKAi7HXSiGOSGD1duONVVvDWC0
X-Google-Smtp-Source: AGRyM1s4fWDOlu6KoXDTGgUWSF+PTSGvOCx8FJv0sYw51XOm1xgNGWttOoIC7IxR4wRduTZBedQfYxSQTy5cDri+G3NY
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:d586:b0:16a:24de:1964 with
 SMTP id k6-20020a170902d58600b0016a24de1964mr11211320plh.4.1656543248641;
 Wed, 29 Jun 2022 15:54:08 -0700 (PDT)
Date:   Wed, 29 Jun 2022 15:54:04 -0700
In-Reply-To: <cover.1656528343.git.me@ttaylorr.com>
Message-Id: <20220629225405.1864460-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: Re: [RFC PATCH 0/4] move pruned objects to a separate repository
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        derrickstolee@github.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> This series is an RFC for now since I'm interested in discussing whether
> or not this is a feature that people would actually want to use or not.
> But if it is, I'm happy to polish this up and turn it into a
> non-RFC-quality series ;-).
> 
> In the meantime, thanks for your review!

Thanks for this patch set. I can see this being used by, say, someone
who wants to preserve a repo that rewinds branches all the time (the
refs would need to be backed-up separately, but at least this provides a
way for objects to be stored efficiently, in that reachable objects are
still stored in the main repo and unreachable objects are stored in the
backup with no overlap between them).

I think there is at least one more alternative that should be
considered, though: since the cruft pack is unlikely to have its objects
"resurrected" (since the reason why they're there is because they are
unreachable), it is likely that the objects that are pruned are exactly
the same as those in the craft pack. So it would be more efficient to
just unconditionally rename the cruft pack to the backup destination.

Having said that, if there is a compelling use case for repacking even
when we're moving from cruft pack to backup, the design of this patch
set looks good overall. There are some minor points (e.g. the naming of
the parameter "out" in patch 1), but I understand that this is an RFC
and I'll wait for a non-RFC patch set before looking more closely at
these things.
