Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B5DC4167B
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 04:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CE7522D2A
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 04:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgLFEIB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 23:08:01 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33809 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgLFEH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 23:07:56 -0500
Received: by mail-oi1-f194.google.com with SMTP id s75so8304303oih.1
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 20:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s3YTBBwvqt9rdMcVLGMBvex+0rZKuFQcDok0Aj/bI04=;
        b=TEia7EA7SASkBgGS132cUWiJ7seVFyx+aoyB/FxQmkllcHSHWp6WJoWd0JEOTXpz1C
         xd0qsIOwwiwhR+AmOdiKpyxRNeSsuTfesE5xAsS3of085+tjU73qM5IWaQQDaupb3m00
         IVwHP1ekHLyIwC3C2rj/RsepJMTN4WKWeQEzjM+0B4uIYyRunqJ0z+8FZZ9/fKmUA4XE
         to+5DMRVUdVNxI1ovG5wDfm6O2ogvsTqBj9+cBdkK5muZsp1jpoDYIYyRaWDPgyY7qnK
         uDJ/TxmwW6pzGGM34yMe90iN6rdlaAlL/9/v0zToROIErz1NkW0OHGVLIqpecTIHVdxi
         DXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s3YTBBwvqt9rdMcVLGMBvex+0rZKuFQcDok0Aj/bI04=;
        b=FO4kY0flWV2SScbUGhVK7OXa9AZE0ZgNYQk0jbBWqrFon7Suwji8P0d0bxf+cRjoZn
         u40DI98ETtfnWuVq6JDfpUVZyMdyRb4B/4puAnJF771zfQQGAWs0hdlLOhNNFdYy+447
         jEh4UrLsvmzQfD2FuhHG0wysFNk2uuZo3nEbDgEHyfO3XcI7FCiKnZbGf2ULEeYe/Acz
         xF5JhxpzaukZEeI/sQ5DasVMkDDpnZwI1HL3wP3GjgeklonqZa9EFHHMzmez7Ryl/E3V
         N3b+jRP1k/aIZRrN7lIR+K8fd0TLbB/p0ek5DRBefdoHhf9W0rOgWn4sq0StSYPVPnZD
         R+sQ==
X-Gm-Message-State: AOAM5337oOdD9ilYjVN62sIgGENZ+BV3McWR8Po5zC0HoIou/DXRlQ53
        81KJUrZ/cm0qyKy/MlDQ20N0aVq0o/dtU5Mnpu14tI0M1LQ=
X-Google-Smtp-Source: ABdhPJwlsHnwwnnH7QkC92fHFHyB61rq0zKUgBtFrGQKty4+majI0T5ez8aYV0/fj4U0AbifgLkKYI5yWjoR/GpYhV0=
X-Received: by 2002:a54:480b:: with SMTP id j11mr8160511oij.31.1607223723912;
 Sat, 05 Dec 2020 19:02:03 -0800 (PST)
MIME-Version: 1.0
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 5 Dec 2020 19:01:52 -0800
Message-ID: <CABPp-BEEzW1U1p=+XGd7pz_jRpph5PjYShsqd5ZuFiKkryATNQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] diffcore-rename improvements
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Sangeeta NB <sangunb09@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian, Kaartic, and Sangeeta,

On Sat, Dec 5, 2020 at 6:54 PM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This patch series include 4 small code cleanups, 1 small bug fix (or perhaps
> just a UI improvement -- it's a very minor issue either way), and 2
> performance improvements. The first 6 patches are relatively easy to review,
> while the last one...is a bit more involved (but provided the biggest
> performance boost).

If I've heard correctly, you three are now interested in rename
detection and thus diffcore-rename.c.  You might find this patch
series interesting; even if you don't want to review the details, just
looking over some of the commit messages might help orient you to the
codebase that you'll be working with in the upcoming months.
