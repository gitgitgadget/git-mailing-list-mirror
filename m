Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E83C43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 18:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4EEB206FC
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 18:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyrTkX2d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgIRSAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 14:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgIRSAo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 14:00:44 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68BEC0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 11:00:43 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id w11so7088542lfn.2
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 11:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RAQsl/ZMkusqx12fpUDKV4sDDSquWEJAm7AxLRadfjI=;
        b=RyrTkX2dUxcac09CfvryUoNffTFM0XihSoiJCGkOYMOxnDqZKxedeVvfS7cI+L2zQe
         Sp6P+M4FLyiFY3f4uXyDiBzUM7QfyOlwsWqzglaucsgQN1bK0j/+6zKx+SQGbmYP/9ut
         l3JcAUHX4c7ourg7Wo6aUMSPOhjZZLQ1cMTJo7SWWjmw3vGbVXdtb5UVroPxl/LJ7/7i
         02UceIn4gHEisyx4+u11DDW3MU0mCleQYLb3Wt8vL9xQZ7+MDhybzS0+3eAMN8UUlT2X
         V6807fWfxo/tf4MX9ixMwco5B6PcuQwzI0NXVpvQop//sjyywbtMIL2BKuqOvewmAFCe
         Yavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RAQsl/ZMkusqx12fpUDKV4sDDSquWEJAm7AxLRadfjI=;
        b=oM0Qm5R7JrIRV8yQlHtwUnHiqH3m4dEEZl5uACD9JhA2eja8ZnXhmeKrkozz+OXa3W
         AzhFdWAhw7lHiCEY6u00n5e+CHIhcw3MGV5uyMNQ1AAWFvXPcUo+27yKbNpeZ4DXsUy5
         J5LqENC6zVLfOvzdRYzR51TGXCEdszwuzkRp86zmqTm098GYFoCUCpeshBwiWXi5a6MG
         ZFq69ZSSb6s674cuwR+zv9J650DRJY/LGbUrefAIVGqvNitEL/Lk67xHbVscX2gZYc+o
         DIL8qBFdzxQ74FBqhVeWcSFkM5r6C/CCMZEdyjXMFJs0QpVqRgA5zEniIakDvIi6p1Jd
         0QGw==
X-Gm-Message-State: AOAM531yNsrIKhfu0qdoOu1/nVGxdr7VsKy6T6CqkFz3mnuXEnpaCEiu
        uR1u++ZB1frYgQRd92bHff/6fAug7hD+SjDqgQA=
X-Google-Smtp-Source: ABdhPJy+KGGeVwOqXLC1iO6oHcYHjE+Eiz+nzXzNAikn4HAn8km7IEnBNtpaBCQ0bxtEHL87dKc0O43uoJpeAtshbdA=
X-Received: by 2002:a19:8209:: with SMTP id e9mr10433135lfd.254.1600452042142;
 Fri, 18 Sep 2020 11:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200918113256.8699-1-tguyot@gmail.com> <20200918113256.8699-2-tguyot@gmail.com>
 <20200918144651.GA1612043@nand.local> <CALqVohfQZu=itUyfU7nubJpgBETh2q7W1TVx=c2E32ey2cFZkA@mail.gmail.com>
 <20200918173739.GE183026@coredump.intra.peff.net>
In-Reply-To: <20200918173739.GE183026@coredump.intra.peff.net>
From:   Thomas Guyot-Sionnest <tguyot@gmail.com>
Date:   Fri, 18 Sep 2020 14:00:30 -0400
Message-ID: <CALqVohefFm-AjVh9-VvUcOO94fEhivZAv=vptQw+tT4E7wsCbw@mail.gmail.com>
Subject: Re: [PATCH 1/2] diff: Fix modified lines stats with --stat and --numstat
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Thomas Guyot-Sionnest <dermoth@aei.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 18 Sep 2020 at 13:37, Jeff King <peff@peff.net> wrote:
> On Fri, Sep 18, 2020 at 11:10:45AM -0400, Thomas Guyot-Sionnest wrote:
>
>   if (one->size == two->size &&
>       !memcmp(one->data, two->data, one->size))
>
> is what you'd want.
>

I think the other approach has its merits too - AFAIK if you run this
from a git repo and one of the files is tracked by it (or even both if
you compare two files within the repo) the oid will be readily
available and usable if the file hasn't been modified. If there is no
big objection I could stick with the hybrid approach, using memcmp of
course. - it's also the easiest fix.

--
Thomas
