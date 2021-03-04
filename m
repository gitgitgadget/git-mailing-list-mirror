Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C6FC433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 02:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CE6964F9E
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 02:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhCDCJS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 21:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbhCDCJS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 21:09:18 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBFCC061574
        for <git@vger.kernel.org>; Wed,  3 Mar 2021 18:08:38 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id m25so15384310oie.12
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 18:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dd0NMjeXzRPRgRQmE9OOFjgQotcv7nhdhooPn2k8ppU=;
        b=SPkS92pjKol8MvRZzLYVxeTGFclz3ylJmuxyjoBM+duY+8k3H6cYAGQyTE/B1EAOVA
         WzIGJMjMJ5fqAR36Je227JDSh6PYLW4PfsfqigN2mt7fRTyu5pqpIMJoIinSoqnwygWp
         tXvx0CPDOo7vLv4r1gAaIPkTE2kTPO4rKtl+bFYNkeHF0P9tJaiq7I3gjFgEXDKe+l7A
         ypG7xRqJX0A2wmyQ4eNGI1lSKu2BflMLVTf4jB7nYHYpMFSFIAbXAvaRPf50n4n8kWvh
         qJh7OWDwnzaAHvwgxu6VaXTH1qvG6TjVnGLWsxumq1OrVCOzH6PA9uKBRAvC1pmjq7SK
         cEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dd0NMjeXzRPRgRQmE9OOFjgQotcv7nhdhooPn2k8ppU=;
        b=lcZHRxeshAo3WRhSnn6N13qVnTim8w6cdswqmViDY29/jWcejF3Lc5xdymzx/T6z39
         WgIcYURQd8DHOcG2ayVJu3LnD7PeI0L99dtiyRhFKJ0tQzBrmHy6krYbZcCY15+uHndI
         NpSZWQ/KIg0j2CEJBAhzganeBKDS4tQ2sJRPrHPoGgybGeGf8fVz5VXwGaSswAnTCflg
         YcUPqpeJS+b2N5L5kB04ctIu8jisFGLOt85teiRRTg30DXsLZZa/NweLlSMVR07oGHZN
         5gwcNQxMvCB8XPR2P1FC9qFNuuD3q4FlXSR1HKGnYxj0PZo111D8kMoHWOy9TUOuFd2o
         rDCQ==
X-Gm-Message-State: AOAM531KiO4wyp6bqEQ0xoWXwPcW4AQA/SwBXc+uFOHQuBavv8a8jrY2
        /RJqtfExqW8deBMfsTQ3tpEIJDnXuw/MFr63KTJCBUIJgxnZJ3VB
X-Google-Smtp-Source: ABdhPJygjZjJNWB55NyepJKbGtJQ4qKv3aWqQcyrwBcWFukysEdFwRHKMqECjaN6Je5axLAGXuLMoZd9qjwmsOGZtVM=
X-Received: by 2002:aca:d68e:: with SMTP id n136mr1448406oig.179.1614823717432;
 Wed, 03 Mar 2021 18:08:37 -0800 (PST)
MIME-Version: 1.0
References: <pull.885.git.1614269753194.gitgitgadget@gmail.com>
 <pull.885.v2.git.1614588030233.gitgitgadget@gmail.com> <YD9Qv/sTDmOE9jlq@generichostname>
 <xmqqpn0fg2ls.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqpn0fg2ls.fsf@gitster.c.googlers.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 4 Mar 2021 10:08:26 +0800
Message-ID: <CAOLTT8RdXC+KQNupU1TQdPh-tQO+syd6WJe85GzieE3uWt2ibA@mail.gmail.com>
Subject: Re: [PATCH v2] format-patch: allow a non-integral version numbers
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=884=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=888:54=E5=86=99=E9=81=93=EF=BC=9A
>
> Denton Liu <liu.denton@gmail.com> writes:
>
> > Hmm, others may disagree but I don't really like the idea of
> > `--previous-count`. It may be useful for populating "Range-diff vs <n>"
> > instead of just "Range-diff" but I don't think it's worth the cost of
> > maintaining this option.
>
> It really depends on the target audience.  As a reviewer who may be
> too busy to read every iteration of a series, I would probably find
> it useless if it gives just "range-diff" or "range-diff with last"
> without saying which exact round.  Obviously, if you are not doing
> range-diff, it will not be an issue.  If the patch requires (I
> didn't read the latest one) the previous-count to be given when
> range-diff or interdiff is not requested, it should probably be
> fixed.
>
> I am also OK with any design decision, as long as it will not close
> the door for the occasionally requested feature to carry over cover
> letter material from the previous round to the current one.
>
> Thanks.

What we are arguing now is whether it is necessary to add
"aginst v<previous_count>" to the patch when the non-integer version
number + rangediff/interdiff is required. Denton's point of view may be
similar to that of Eric before.

Here are my personal thoughts:

  Personally, I may use GGG more. When I see a title like "Range-diff vs v1=
:",
 I can know that this is a change from the previous v1, and it may be bette=
r
 than "Range-diff again v1" To be more specific, but if it is a small patch=
 such
 as "v1.2", we use previous_count to tell the reviewer that this is a
range-diff
change from "v1.1" or other versions.

Of course this `previous count` can be used in a very small range, but
I think it
 doesn't hurt to keep it, because even if you don't use it, `format
patch` will still
output "Range-diff", which will not break any known functions. It can
only be said
that `previous count` provides an option for submitters to know the
previous version
 for reviewers. In this regard, I agree with Junio's point of view.

Thanks.
