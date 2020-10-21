Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA81C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 06:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 305B822251
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 06:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NS5wwsI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436752AbgJUGbR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 02:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436747AbgJUGbR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 02:31:17 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DF5C0613CE
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 23:31:16 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id p15so1692094ioh.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 23:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=BUDnj1+1m40KooMsjAf4h2yhOHCOhLEZ4JpWn4lfkeY=;
        b=NS5wwsI4gZ3BRrpd+It9UTPfBlD/Bo5w+0JZPHNd8k6UeL3N8fJfn4l78aeaHvvXCZ
         Iw4M8w4QDeFLZOvhBHFLhgr72AcPzfjuS/TtJVQEK6cgDbSXAmTyS0HeKqJOeaIoZf+I
         QixvRJAQfWZwiDuabO58TZyf5I9oiZqSBi79L0LFDAyse1ouwV2Okdz4kPnydKSbfTJS
         cdLkg4UJjIEEKW2kWS9McNV7BY0RVdglXJc3UGxCuqzaOgEha7TwHAzRs/6NIVvQFFC/
         MxehY3ZovlkWRoNBYR7xsowXot88sSXla7PxOE+W82mj5BAxI+cU05vGcRIdWEsXZtOU
         nm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=BUDnj1+1m40KooMsjAf4h2yhOHCOhLEZ4JpWn4lfkeY=;
        b=oxb9Kpe6zqfbA1gjB/x2n2gq8bLG+0J2BjUn12JzwWrcbcwj+u1iX9d5n1FUy2+Ktf
         VrNVyntsGzDh2YM8XRqhMmEi9xcJB/S6joWmk/C9T0csHcuFpB3b3W1A/8qC9+BG+EZu
         0Lv4ERTp6+OkQEipGtlz72JZifpsvzPPbL93q3Ee8KqlZGLOLBmDjPKtz6kRdpW2Tfjw
         0KhdEBbbyP0NDesCbqWNvP+foC2nLay0Tpx8REcvx2YZ20ZuBteuPOAvRgT0jO2jbkDK
         5bCSriMhFWLz4sUAR2l5QFPUKU2J3AHgzMV4Iu/ZfRlR0kD82JZaELKLNgvjEaT1ZrwH
         RTfg==
X-Gm-Message-State: AOAM531tbOuNNWBQapo12OZWd6hqfyCMXRlCKrVtRKteSlrZKcBzOtlZ
        njrfdbdi2q5XWHsFujDN4HXJZrO4DgZ5rEM0gBjcM4mrZHAgNl8e
X-Google-Smtp-Source: ABdhPJwfLgryV3huU+7kEXFN2gz2S7F3R/+Dj6wipekspDGIl0MvQjUoS77NK2lb2e/QyNCCUF57okJWcdCt5HqEjrw=
X-Received: by 2002:a05:6638:2412:: with SMTP id z18mr1624277jat.56.1603261876133;
 Tue, 20 Oct 2020 23:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201021062430.2029566-1-eantoranz@gmail.com>
In-Reply-To: <20201021062430.2029566-1-eantoranz@gmail.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Wed, 21 Oct 2020 00:31:05 -0600
Message-ID: <CAOc6eta3xMMH_m3+Apiy7uY94MECLRGiV2y=kNmCzwh0MS=36g@mail.gmail.com>
Subject: Re: [RFC] sequencer: allow metadata to be saved if using cherry-pick --no-commit
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 21, 2020 at 12:24 AM Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
>
>
> With this patch, we allow sequencer to save the metadata from the original
> cherry-pick operation so that 'git cherry-pick --continue' can be called.
>
I would expect 'git cherry-pick --no-commit' to save the metadata from
the revision cherry-picked if the operation is successful so to allow
running 'git cherry-pick --continue' afterwards, however that's not
the case. I was wondering if this is done on purpose. The patch in the
RFC is not in any way my final proposal (or even a real proposal) but
just a little first step so that I can gather information so that I
can adjust the code accordingly from all the feedback... _if_ an
adjustment is needed, of course. I don't know how --no-commit would
have to play out if multiple revisions are asked to be processed by
sequencer, for example.
