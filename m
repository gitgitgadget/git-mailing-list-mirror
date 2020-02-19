Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E03C34047
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 17:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D687D24656
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 17:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUWt7h91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgBSRVP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:21:15 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:43143 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgBSRVP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 12:21:15 -0500
Received: by mail-il1-f195.google.com with SMTP id p78so1366551ilb.10
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 09:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OJE+xGTU4s1IR7Vg5XjApndIqHMCQsw3CdUOPHlZ86o=;
        b=rUWt7h91AKoBfK+4Eqg/MTOo4hFZIpGNeOUSW34vINWqMgUdgu65+UwX7DTZhOAjNI
         g+BPUYrrTKlXLZZsYXhYPe0bCzwu6MsGbGTBSp3MV1PtQmrWXsR626C6XCMxR/6Ui8BZ
         xLtDVWKKLurW+tSQkioRd8FAIskTcLsdYi80S7Zwe/xMYOSkxpfsfx1mc2luyWlxSj8x
         fIyyPuyKa32u3bzcw+DHLZhnRGCUGkTOzX+MAL5IIY40FCXhBen9u4VSf3vvQVOWzIkX
         0QY3f5XHAWVEDJT+6Azp54LXfP2bmvk3NhAdECEbKRn9PQhCRs6txFVTy+KN5jsgDXSo
         Z2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OJE+xGTU4s1IR7Vg5XjApndIqHMCQsw3CdUOPHlZ86o=;
        b=F9dcIuzLCqjey9bxLrPuGo0McuwFnXnGpFFrgs6BuCQQAFQyqQ6yrlswOAlUYhPiSW
         PZNpYl3i+YdgHMKk5aEKRyKlG5+0ozpNz2PNXXiBtq8TJXAlJIbQo1ZXHpl3UpYIcxtL
         c2gJoTEG6B1fh3pbHEyWbRGo4q6vlrf18Tr0vx2RTmAxVJd6EMEHQJrLGgMNbpxR9CB8
         VG89r/Dk9kOFD36j3eFYuV/DfyA0kCgiv1kAoRdO5FIqkYjxpZA5xJehDWTDPmeGKdYm
         OjnFyNT6YMDI7VGPocCFvYOj29F+AyJKScoECHJ8cVZxoYkv0FhZecGYhkpOVR/mBNwK
         qQKQ==
X-Gm-Message-State: APjAAAXNSfNCamxzvdOK9wziW6+LqhR+9BbSoVVtltA/qwJEYAGwg6zx
        5pHZ0ejLozwChUX0LcfJ2YdC1qZ0CjDt5czr4cU=
X-Google-Smtp-Source: APXvYqyUaZDMl+DyETKCsmP5kEbwr5zW2AIkHK0HAB2ynwiUYlDccEsU6Q6W7N27x9ZNj9O+7HuM0d6enkBlIOdYkiU=
X-Received: by 2002:a92:ddcb:: with SMTP id d11mr24746792ilr.211.1582132874564;
 Wed, 19 Feb 2020 09:21:14 -0800 (PST)
MIME-Version: 1.0
References: <pull.539.v5.git.1581344060.gitgitgadget@gmail.com>
 <pull.539.v6.git.1582015420.gitgitgadget@gmail.com> <xmqqy2szip35.fsf@gitster-ct.c.googlers.com>
 <CAOw_e7abpAwTkb6qKZjbxxw7XrAWdhcANbjAWvRxi1_fT5vSDA@mail.gmail.com> <xmqq36b6h5o2.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36b6h5o2.fsf@gitster-ct.c.googlers.com>
From:   Han-Wen Nienhuys <hanwenn@gmail.com>
Date:   Wed, 19 Feb 2020 18:21:03 +0100
Message-ID: <CAOw_e7ZztSCzpmaCYg2c1iaZLWSsYz4dYegT0V0dHVaDy8A_uQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Reftable support git-core
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 19, 2020 at 6:02 PM Junio C Hamano <gitster@pobox.com> wrote:

> > your checker is tripping over code imported from zlib. I added a /*
> > clang-format off */ comment to avoid reformatting this code. What do
> > you suggest?
>
> Use zlib from the system instead?

uncompress2 is a 2016 addition to zlib. It doesn't pass on
gitgitgadget's CI, because it is using an older version of zlib.

-- 
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen
