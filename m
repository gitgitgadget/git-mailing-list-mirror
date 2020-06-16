Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A986C433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 20:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E0CF208D5
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 20:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXkedZze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbgFPUPf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 16:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729167AbgFPUPc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 16:15:32 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59196C061573
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 13:15:31 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id g5so16982806otg.6
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 13:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EDsKcFBsdFOYsW4IUO2esZUdl4g2WuhI7Pk6gH07rh8=;
        b=lXkedZze37s8KmPmSX+2f9E6AeLN5E4bwJrcbGP7h1H6QYQimrg2P2abu5g5Vof/y4
         3Up76Dfl4p2+sS1CT4I4hl+vMO0yUhFCcJ9EoaV84rCge0jW/PH7nmDab0Aq0QQhcXDJ
         ZMmedLrOvDp3HE/znHY6eNx5CQEiiygxEYuFIen2mMw447yMcOmZqQoxXty4YvHFR3GF
         443harSvYHalLxH+jtqSFLCguldgCdOIk90giwoTtYbgP2yRTnjAAi6DWC3DrThbUNLx
         DflwsmH+nMfFzGoGblEWD94BCR9NDOFK6ELGfyzP0Ne6BXr/frAxJJ9ErxdevtMG3HHT
         g2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EDsKcFBsdFOYsW4IUO2esZUdl4g2WuhI7Pk6gH07rh8=;
        b=R3dEWvnQOfTr0tlAc0EQRu7axdnf4f49hE3x5n8VBpbG2KDGH5o23gwnog8jkVMzep
         zqtbCQhC5Vqlm6uYdLISyWPSFfU4UwP+IAYQD5JJVs8B5DF2Tcm64eXOFVZdJaaLVfp4
         xqkvH1aQh/Oqe2T4abx9URULTJU4gRmgdp4UAzs+/VScga8Ch6So/IBk/l2CnUYVBrFK
         7GuFAObXAqK3RAPf4wmosudQQNsEh9xq8lZKrQ5gdPShXNOJ+RISPJ/cRvVAh/CYT6ud
         mJlM7G4MG1F96NzDHFSJsrGCV850uhE9MujaHRJWkWcssSViXTBKgh6B0gyy+BClFX/w
         H0nQ==
X-Gm-Message-State: AOAM53269Yyx0lv/jamap3f2GyehMXdg9+fXroEE/9c9q2/kfDXjBkAa
        MpPWZIyn71Pno77Akg4WbIvGejt+Rgo2ZBwWAg1tr6/1WAs=
X-Google-Smtp-Source: ABdhPJyx/FiqQArDABYqylO/6p6i/XExi9qOWYeGkKLfNJhJHZV//4Ha53Un/q1EbQQp8CzUxLFASB55edivesG75mM=
X-Received: by 2002:a9d:7606:: with SMTP id k6mr4130530otl.316.1592338529488;
 Tue, 16 Jun 2020 13:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAMWmj-w3Z4176kvNi3GQTfCSDBzMMay33ki4xmdPwC3sFqbdzA@mail.gmail.com>
In-Reply-To: <CAMWmj-w3Z4176kvNi3GQTfCSDBzMMay33ki4xmdPwC3sFqbdzA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 16 Jun 2020 13:15:18 -0700
Message-ID: <CABPp-BEGtYky=9JNu9ZTdqC6dCww6AkO5vn+vUohQP9MFnkfDg@mail.gmail.com>
Subject: Re: git-for-windows supporting public shaming and repressing
 community's opinion
To:     Kaue Doretto Grecchi <kauedg@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 12:30 PM Kaue Doretto Grecchi <kauedg@gmail.com> wrote:
>
> Recently I've been blocked from the git-for-windows Github repository
> because of this
> (https://github.com/git-for-windows/git/issues/2674#issuecomment-643795833)

Most your comment looks fine to me, but this part clearly was not:

    "So your argument is really dull and kind of childish."

I'm not part of git-for-windows, but I'd likely also start blocking
people when name calling starts, so I can't fault them for it.  I
don't know what their process is for unblocking people if they amend
their ways or after a cool-down period or whatever, so I can't really
comment further.

> comment. At the same time the following user was not blocked and his
> comment hasn't been marked "off-topic" until the issue was closed to
> "only collaborators" due to the high rate of people disagreeing with
> the motivations of the issue.
>
> (https://github.com/git-for-windows/git/issues/2674#issuecomment-642049938)
>
> > mlvzk 6 days ago
> >
> > Agreed. On a side note, GitHub should maintain a repository with a list of developers that still
> > use the master/slave terminology. Perhaps that'd be enough of an incentive for some to change - > name and shame!
> > We could also have an icon on their profile page that'd flag them as dangerous.

I agree with you that this comment looks like it should have been
marked off-topic earlier and seems problematic.  It does avoid being
directly disrespectful and thus might not technically violate the code
of conduct, but I am definitely not a fan of their trying to suggest
that other folks should violate it (their suggestion seems to be that
GitHub should do things that would not fit with using welcoming and
inclusive language, or being respectful of differing viewpoints and
experiences, or showing empathy to other community members, or assume
the best intentions, etc.).

> It is appalling that the repo's maintainers kept this comment and
> allowed the user to continue interacting, while suppressing and
> blocking users who were on-topic, having a civil, respectful
> discussion but happened to disagree with the issue's author (dscho -
> https://github.com/dscho) reasons.

Just my own guess here, but I think calling others' arguments "dull
and kind of childish" is not civil or respectful, and thus that you
missed the reasons for your being blocked.


Hope that helps,
Elijah
