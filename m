Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C6EC64ED8
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 23:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjBWXmF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 18:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBWXmD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 18:42:03 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BF32D179
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 15:42:02 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id s22so15731399lfi.9
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 15:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PtVCLMbp+nxF+jl3T2NO5n4kS29lMnwgVK7hespEkWY=;
        b=hDWXtKKJnvMIrPv//uwrqIKl0JzSZGj7/SCgOKrbpNxy10L+Wblu4PiVQyKJGH5k1G
         0XO5hpx72F0iowS/1K/Ua98uBbNaNjik/SgDTLAUuRZMa20CzkNd9ywgqSLwCwnYuyz7
         B9b5jmoHqL8j1adJ4yjafn5dpvvmbkUXhW/CP2rhJWoRhR56NWTM1sHJHj54f1xC1KOr
         +Jn7yVopw5AcyIHL+HMpmWgq1PtEKDXjGSy8JNIaa2j6HQu+abyxPsEpNSMKis5Oh5x3
         8pMAepFlJpW8pR2DmznnH5FaisD0Zh6euMvBtlhwJd6WXw5rgMxcUIko4fb6O+bggmsR
         I0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtVCLMbp+nxF+jl3T2NO5n4kS29lMnwgVK7hespEkWY=;
        b=LS/CmjNwDrAtrWgLeGSBcQ/nCy+kewTo0o5eFmUoSAbN9fWdmttK2C4rk9plve4ABo
         Blj565RRZVhjfkT/i+qhawmekansSlcx/6XW4qgDPFMh6Zf4ixRbUyyQwofTTla15cwN
         Vd3pHEjf60gleO98x6HF6MDScavuU9RNsREWT2PJzRDwnHHt8bijuH3N00qa/5o2kelN
         bXp/iOXv/WnGeY66SaBCOH5F0hmHLBkzDiKquWegf2yt+9N61bk8piyGfXGAhlZtHSiO
         l/o/lUS6JyULy6fQlV1mpsSFTwglLg6m6NCqRnIS7MDreINnILTg0zbQq0umZWGnwpFB
         NclQ==
X-Gm-Message-State: AO0yUKXQ9sbBAIM1RGvOzyc/xf4dSW18lubIBmXhSl74x62Cf8J2cwX7
        DrkWmBAl75DutpP9CCx5D4nNIZ/cexUeUKN4KpI=
X-Google-Smtp-Source: AK7set+9x3+4eU83TAd1Q4f5SFuOUAZim6ruYGzeRCZuqmJMC344kKnb2gxKWUN/wXkN2Vc8ycO2kIqJxArSNiZYwIM=
X-Received: by 2002:ac2:54b0:0:b0:4db:266c:4339 with SMTP id
 w16-20020ac254b0000000b004db266c4339mr4384131lfk.2.1677195720384; Thu, 23 Feb
 2023 15:42:00 -0800 (PST)
MIME-Version: 1.0
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
 <adafa655432dd13d1c727522377ac9a4b515b76a.1677139521.git.gitgitgadget@gmail.com>
 <xmqq1qmg899v.fsf@gitster.g> <CABPp-BHizCj2e454w3vtHrDNip3Rm-gUMT0oJiAsbkAvr_QvVA@mail.gmail.com>
 <xmqqbklk6nnt.fsf@gitster.g>
In-Reply-To: <xmqqbklk6nnt.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 23 Feb 2023 15:41:48 -0800
Message-ID: <CABPp-BEAeHtVzp2V0fXrSHNx_q8Jd4+Bd=Cj54cNs0wqGZkUqA@mail.gmail.com>
Subject: Re: [PATCH 02/16] treewide: remove unnecessary git-compat-util.h
 includes in headers
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2023 at 2:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > I think for sanity we should do one of the following:
> >
> > (a) make C and header files both depend upon everything they need
> > (b) consistently exclude git-compat-util.h from headers and require it
> > be the first include in C files
> >
> > I think things get really messy if we let half the headers follow (a)
> > and the other half are forced to do (b).  I was pushed towards (b)
> > before, but now that I've worked on this series, I think there is even
> > more reason to go this direction: this work I did during this series
> > shows that if we allow a mixture of (a) and (b), then empirically we
> > end up with C files that don't include git-compat-util.h directly, and
> > those same C files likely include some headers that don't include
> > git-compat-util.h at all, and if the other headers are included before
> > the indirect inclusion of git-compat-util.h then there are risks that
> > things will break in very subtle ways (as pointed out by Peff in the
> > above-linked emails).  So, I'm inclined to go towards (b).
>
> Perfect.  Can some of that reasoning be captured in the proposed log
> message of [02/16] to help future developers?

Yep, will do.
