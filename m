Return-Path: <SRS0=gF6X=CV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B5BC43461
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 14:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 988E52087C
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 14:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRJdIvJ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgILOEP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Sep 2020 10:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgILOD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Sep 2020 10:03:27 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372AEC061573
        for <git@vger.kernel.org>; Sat, 12 Sep 2020 07:03:26 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id e2so2050913vsr.7
        for <git@vger.kernel.org>; Sat, 12 Sep 2020 07:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n4FdX3TfROGRwPC1+d0W0B1LSPde20xwvGs55q5S6UQ=;
        b=kRJdIvJ0jFbLsG2GhctiU0iSkSIiROdkOhAbG8pHrzkpZ104ZtvapBYVsA86O5bccQ
         wh6Mg8fE5I0U2VSY1CxSxTc5WudcXawQD1IGz5lnKHkLVIPQwfUILqiJltUhTqlCzOXE
         R9c28Y/yw3YMiHyAJBF2rVfdtS3u0lRt2FeJnTMihg7UcswmVWYv/SFMzhxJ3kKlFQdX
         hQHyX7rBzxseG76vTdLwQPem6NHlVea+sNDJ+ffo42KBKCwaL7Mq23/Z6m1lIdyl87fR
         cco8djSGlo7kK6LVd6QAAPql4E1KeSehprqRl8JuFbxA9lV1kekCnbfxg05s9Xy2GTIU
         xd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n4FdX3TfROGRwPC1+d0W0B1LSPde20xwvGs55q5S6UQ=;
        b=ZOp73d524rly0nOPhzfTjAdys48twYjzwX/fqCALecnt4pM/7OyRVoyxqsR6EHFjwP
         UHBrTwAZKLOCDWcxljRI8m3ZjVt+kgPfjHOu9ldYBIX/Jubm4ZXT3sDiDaX9LpeWZcph
         VBNXdaGLX5+aCi8yTuyoSdeClUDNTQ4GE6htfQdRnI3NdswHG4+5MB8W1J7PXJ/yXbQm
         0HKCmEA/NEaPmDMXQonzjpcxQV/J79UQO4FD7bIij/jxzAxOv94ITRfZM3PKW8P7Foka
         6bCSpEgFEQj5LZxp5VNd1WbFjTea4oQkFgKIk+WGxzJ64V1cHGSaDLEU2A8NZRnxA+YU
         Q3wA==
X-Gm-Message-State: AOAM531020IjSTt/j117GVbR5NmKiYzwrr3/8nfLzgrh0Ct9sOfHDyDP
        b0vhPBK5eIsdqvwnGY8wB2ulCoau9xUKy6VEbt8=
X-Google-Smtp-Source: ABdhPJykucxpkPwjPZn0T0QMmNXS0Ces1AAxg5IWPi8vhJQyVc0CCRzR2DpKu4WByPy7wfzV7MdDixH5Vq7gyBp37ec=
X-Received: by 2002:a67:7d52:: with SMTP id y79mr3666562vsc.34.1599919405508;
 Sat, 12 Sep 2020 07:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599762679.git.martin.agren@gmail.com> <20200912034901.GA4101@nand.local>
In-Reply-To: <20200912034901.GA4101@nand.local>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 12 Sep 2020 16:03:13 +0200
Message-ID: <CAN0heSp9Lk8nNVR7svGn-vCS_40bvWtChXBsZa9WPzbw9XqNEQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] various wt-status/worktree cleanups
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 12 Sep 2020 at 05:49, Taylor Blau <me@ttaylorr.com> wrote:
>
> On Thu, Sep 10, 2020 at 09:03:34PM +0200, Martin =C3=85gren wrote:
> > This merges pretty well with `seen` (`jc/quote-path-cleanup`) (and the
> > tests still pass). These patches are obviously low priority, nothing
> > revolutionary here.
>
> What revision is this series based on, again? [ ... ]

This is on top of current maint: 47ae905ffb ("Git 2.28", 2020-07-26)

> I didn't look deeply to figure out what exactly was going on here, but
> it would be good to know so that I can play with these patches a bit
> myself.

Ok, beware that there's at least one bug, so you're better off dropping
"worktree: drop useless call to strbuf_reset". I'll probably replace it
with something to remove that function and basically inline it into
its only caller.


Martin
