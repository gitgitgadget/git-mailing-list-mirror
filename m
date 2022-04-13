Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7CAC433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 22:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238866AbiDMW60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 18:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236001AbiDMW6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 18:58:25 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626155B3CB
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 15:56:03 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id y6so3207709plg.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 15:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0+7TIlDDoHZIWBf7Ez4GE8Z2Ywn01B56f5trztXy7Xg=;
        b=dY9a/G+udFV82aB0SY930Maq99CdSPtzlo8ZOcstQHXD5FoKjzh+q1QbfIjgJdgHFh
         EeKvFFBquiGCpCOHwYMJh8P82e9mJQv8USVty9z3WfSDtEKmhuFkAU+2GxTuYwzyGgxu
         wsgpW22LI/Muw+ov2nkY9/gUSxXbrN5ma4/c7A30VBShl2Yk+4rhj4T9HdUE7BDzHH3f
         25V6x8KHcUau5Jc4C85XHAKZvJ8Vafw15JkcYk1MDYWO1/j8SyDFDlQi3Nj3j773u4IY
         jq/pd+DiUbnIMl1JzivMrNalVQa7zklwHmOVn/EJdqAOTA4j/wQTqE6mVgKqfRaCI5Np
         0y/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0+7TIlDDoHZIWBf7Ez4GE8Z2Ywn01B56f5trztXy7Xg=;
        b=yo3M8/65bwm7trAzKooIC5bqQ2jTBPIFkj71D8RCm5yptkp7MAbmnyzqUkDymUsre3
         YqIxJMyktyPeyXLABmfHLJ0oQQJdlQqulb4W7LsuCoa2AlA6MvQv/Xp4KkjPyk4k/Jlc
         WgL2Zu+sYQNm3M+Hyc7CktZsK7/+XLAH6wUCs23i8dN3uEqru8Kj9mu8vptpRwnJ17l8
         TUQNP8RQ0Xn0IATl+NGVWX+jbIepKk5IRw/8BgiNZJJ5Mi+IodKpahHMNlAU8bv5qpz7
         VwY70Vu0TGEP7q42QOMn+aXtgHeWgd5Se5GVg81sbR38qtewLdowfkTT7TpaIN73O/sE
         uYfA==
X-Gm-Message-State: AOAM530XO22D9043E51o3OvseKcWdRyCxpLiaazu9Px69pdKdQO1NzAP
        N2ebczQHb4vYahUoug+diS4MuNwXB1kttWM9c4+Fhk2+MJmJxg==
X-Google-Smtp-Source: ABdhPJyPCyQb33elYUwgAZOG7FjbrQQ4VFujJTJytrfDHxYXqlu/wItAWskvRzPp1ytX6chrMmQx+7bhbmN3g1oxjCM=
X-Received: by 2002:a17:902:9043:b0:14f:aa08:8497 with SMTP id
 w3-20020a170902904300b0014faa088497mr44533515plz.109.1649890562790; Wed, 13
 Apr 2022 15:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAGyf7-GYYA2DOnAVYW--=QEc2WjSHzUhp2OQyuyOr3EOtFDm6g@mail.gmail.com>
 <CAGyf7-GaoBarXD2xKG3KUXwGZgbhKgv-4Mz45achbr6G9ihTBQ@mail.gmail.com>
 <220413.86r161f3qp.gmgdl@evledraar.gmail.com> <xmqq4k2w92xo.fsf@gitster.g> <xmqqilrc61te.fsf@gitster.g>
In-Reply-To: <xmqqilrc61te.fsf@gitster.g>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Wed, 13 Apr 2022 15:55:51 -0700
Message-ID: <CAGyf7-FGdciG+QF8NA_yi=o4B0RVPNiZM4LJZ610cDZzd3AjyQ@mail.gmail.com>
Subject: Re: reference-transaction regression in 2.36.0-rc1
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Users <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 13, 2022 at 3:48 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> >
> >> This does look lik a series regression.
> >
> > Yes.
> >
> >> I haven't had time to bisect this, but I suspect that it'll come down =
to
> >> something in the 991b4d47f0a (Merge branch
> >> 'ps/avoid-unnecessary-hook-invocation-with-packed-refs', 2022-02-18)
> >> series.
> >
> > With the issue that /var/tmp/.git can cause trouble to those who
> > work in /var/tmp/$USER/playpen being taken reasonably good care of
> > already, it seems this is the issue with the highest priority at
> > this point.
> >
> >> I happen to know that Patrick is OoO until after the final v2.36.0 is
> >> scheduled (but I don't know for sure that we won't spot this thread &
> >> act on it before then).
>
> Reverting the merge 991b4d47f0a as a whole is an option.  It might
> be the safest thing to do, if we do not to want to extend the cycle
> and add a few more -rc releases before the final.

I'm reviewing the changes in the patch series, but while I understand
the visible behavior fairly well the internals of it aren't something
I've spent a lot of time in. Compounding that, I'm down to my final 3
days with Atlassian before I start a new job, so I'm juggling trying
to finish up all my work and/or hand things over to others.

Based on that, I definitely would not want work on 2.36 to hinge on me
getting a patch up. I would _love_ to (finally) contribute something
back to Git, and the community that has helped me so much over the
last 10 years, but I can't say exactly when I'd be able to post
something. There's another developer internally who is also looking at
this, but it's been a number of years since he worked in C.

I guess all that's a long-winded way of saying a revert might be the
more timely option, for decoupling resolving this issue from the 2.36
timeline. That would also mean Patrick would be able to review any fix
that was posted, which seems valuable since he did the original work.

>
> Thanks.
