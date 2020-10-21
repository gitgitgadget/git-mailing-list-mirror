Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD50C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 23:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BF942225F
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 23:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xzbd1ZEp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507105AbgJUXXG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 19:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507081AbgJUXXF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 19:23:05 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CBDC0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 16:23:05 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id m11so3435054otk.13
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 16:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MUfXUwRvAM+NOILWjYofJT4GC+FOU4yQy5ZkxA9G1es=;
        b=Xzbd1ZEpCndb6dojd25yFctazK6fznqsDCtZNjq2aLhTub0tNCs/MguzP2/C46vf+Z
         tx5Lo3tOPpngL3gl3hd/z6CuOHg+PU48F7a2E3FSAjUVJkRGNiWD9gCcYlA8A+LTYsfp
         QzkEd5knsZhES9j527yAgv3oTg7bsg98FSpbsyQe5O0JEcYvUNA3Sk4DwMMC4/uFt6ED
         fRvTVAvb9xFV8T51Ucr5lKhPGL+E+jjezEx3RpzWmwRTalcPiwk3mg6V0OBqVJ2NCG2h
         crWnOay8QDoO7pdv4TjFnil4QJK2PvWYMH87nYJm7MANZmAI1DlRNYBFQa2rd1Q30/IA
         J3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MUfXUwRvAM+NOILWjYofJT4GC+FOU4yQy5ZkxA9G1es=;
        b=J/P+9gT3TBLnVMyw1jruUgjU7qbRzv2wFH9+mg7/5o2oOWaZvx6uG2KQVeyoJukJ5y
         CKe0IqTGVr92dEl0RX5nL11FtuMxbKmXw1rDETOicJwyUCbDjdDkLaJD2+Ul7JujGfGN
         7yPybGlJIOpBi7ILwBAE1ez+apULTLA1m2/i2r95XKDpPNuOXOzv+YMqKW3/68ahZO9X
         gHrMDhtXnXjmdIAKsGtdapx4ImHB6Q93fOZoS5DnjPM1QXELzVgWGZU/NUF2cknstEc6
         rXfCABH8bTB5fEOvNVGulCThjbm/6DCHsQR6e1g0+D2V0FyG6VmL7sbnde/wgz3SMazT
         j5AQ==
X-Gm-Message-State: AOAM532kz7EchTIN50IkCeEA8w5T/z+vdBJ2xozphdgoTCRUWwWFxoNX
        1Gm2Gc28PtktZNzuFE2VINVKhxQZtc3w0NqmCA8=
X-Google-Smtp-Source: ABdhPJz4X5Yu9z6AjBCm7lEJepq2vaDljgtgjvV7sx/7Mh/8bN1z2tue4KMLP8hP8GE9L+SAz2o6v4zSa70FdW1yEEA=
X-Received: by 2002:a05:6830:2092:: with SMTP id y18mr4333681otq.19.1603322584898;
 Wed, 21 Oct 2020 16:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <pull.767.git.1603303474.gitgitgadget@gmail.com>
 <049989652cefb90304e711dbfe354b55a5a71f41.1603303474.git.gitgitgadget@gmail.com>
 <20201021205537.GB1270359@nand.local>
In-Reply-To: <20201021205537.GB1270359@nand.local>
From:   Nipunn Koorapati <nipunn1313@gmail.com>
Date:   Thu, 22 Oct 2020 00:22:54 +0100
Message-ID: <CAN8Z4-WY8Q-VCujRJFmEpDwX8OYfRYFAgam0CFbQVwDTRU+DKw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fsmonitor: stop inline'ing mark_fsmonitor_valid / _invalid
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Alex Vandiver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Alex Vandiver <alexmv@dropbox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Letting the compiler inline these is fine, but...
>
> Any reason that these need to be externed explicitly? Note that these
> functions are already externed by default since you haven't said
> otherwise (and for no other reason than this'd be the only explicitly
> externed function in fsmonitor.h).

Did not have a reason or strong opinion here. It was this way, because this was
the way alexmv used it originally - but it does compile in either manner. The
thread Junio linked does seem to indicate preference for extern to avoid
confusion.

--Nipunn
