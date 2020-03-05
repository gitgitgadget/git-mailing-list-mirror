Return-Path: <SRS0=Mgdg=4W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D81C3F2D1
	for <git@archiver.kernel.org>; Thu,  5 Mar 2020 15:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74077208CD
	for <git@archiver.kernel.org>; Thu,  5 Mar 2020 15:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Am/t7M5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgCEPRu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:17:50 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:41455 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgCEPRu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Mar 2020 10:17:50 -0500
Received: by mail-ed1-f49.google.com with SMTP id m25so7208544edq.8
        for <git@vger.kernel.org>; Thu, 05 Mar 2020 07:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ZFv07HD3cCKaH5FklXdoyiFm4Qoh1w/MFcG4AKYO5Y=;
        b=Am/t7M5Cg1MDu6beK33USLeltqv4Ibz03+enmVmlR4iQ5q2VYLPyiv04QM11G3lD9N
         ang4iF/7/2o5vkAYlpPgj29DauFFgbR50/mQXvQKbFcyMoslpudMpkxhMtQK/Jt6pQsc
         yWodJEUEJ27K9o3WbcZtDth+IvdM7GcpY/2jMebKF3G5oXw2Wn/aGDIDX9M9SIqYdWw4
         0BFHMPlZts30jjzxvv/CkmiuD0I0/3+vo8xueILsQjcSxNT6uXuqb73Eo7zBdxQh2FMd
         AEvjoDJqJHB1OtTozXCGME0oC2mD0pT9syvQGsTUd1avkGd10J7SMW9dsxJyxuDkL0oI
         3vvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ZFv07HD3cCKaH5FklXdoyiFm4Qoh1w/MFcG4AKYO5Y=;
        b=m+fTy5tgCKpGK68Y9t15DvNz8R+Xgqk/cxpEiIcKQs6D+OtDGxt06m9Py2m0nWh/W5
         ZcnsYKlpWLZ4VcMFFUKjvpzgAe5O+VIXakCh1LUxmMtzC8FA85dGPkqCYMSadkppUvUM
         tZIpxWg55/une2EasNzZRWpbO62o4GBxi3+t6W2pDQdRWcpsVNzbjMpNsv3dG2IcEoRT
         ln1B4bMLrVV6O0X+zLv8x3C/elmZxPsq59wpuXc9JohhBrYbp5aD33nKXd5ZKfKnmCbt
         g68UcqoUVD6G1CFxTrVvde2/tov3I91VhiS5hnAdw2gKk5hZveCQRrwpRwPiwvPBZcTn
         yjXg==
X-Gm-Message-State: ANhLgQ2xpRJ8KERywtgrD/2TO9ge+s8VyM3IuCewapcpXqBJDhcPgJO5
        eWUOQh+fERpvkrebn5JHJiXS3EQvH+dQBrczWkw=
X-Google-Smtp-Source: ADFU+vt4X7bGEFUfB/997rkqFMXnNdPVj6qwzojubRy2mh/dRM2TsUBw1+wEHkrlycXwFlsEs9Cw8o4UtGFXnUOmtkk=
X-Received: by 2002:aa7:c244:: with SMTP id y4mr9412129edo.8.1583421468650;
 Thu, 05 Mar 2020 07:17:48 -0800 (PST)
MIME-Version: 1.0
References: <xmqqimjl6pvn.fsf@gitster-ct.c.googlers.com> <CACg5j262bzzwifXXC3tGu-bbNtojKQe-j1=byaAbrSNo=WtWgg@mail.gmail.com>
 <xmqqpnds5c1v.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpnds5c1v.fsf@gitster-ct.c.googlers.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Fri, 6 Mar 2020 04:17:36 +1300
Message-ID: <CACg5j26uLyyHRx0ouVhUbJ8P20uJgvN4WCqunP5OoXhGyxuadA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2020, #01; Tue, 3)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 5, 2020 at 5:18 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Heba Waly <heba.waly@gmail.com> writes:
>
> >> * hw/advise-ng (2020-03-02) 5 commits
> >>  - tag: use new advice API to check visibility
> >>  - SQUASH???
> >
> > A local change that needs to be squashed?
>
> I often leave these changes that are based on what I suggested in my
> review (or what somebody else suggested and I found sensible) as a
> separate "SQUASH???" patch while queuing, when I can foresee myself
> changing minds later (on the other hand, trivial typofixes etc. are
> often squashed directly into the patches as I queue), so that these
> can be removed easily.
>
> As such, if the original author agrees with the suggestion, it is OK
> to include it in the next round (when the suggested change is small
> enough, don't bother with "Helped-by").  It is OK to drop it from
> the next round when the original author does not agree with the
> suggestion, too, but it would be good to say why somewhere in the
> discussion.
>

Got it, thanks Junio and Jonathan for your replies.

Heba
