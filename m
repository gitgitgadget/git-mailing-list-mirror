Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CC5C433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 09:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiK1JoD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 04:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiK1JoC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 04:44:02 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D8418E31
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 01:44:01 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-142b72a728fso12296525fac.9
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 01:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/oJn/PttIIA0VjGbetBluNEGmQpHJguamid9nXqIlP8=;
        b=XyODy/eerj4e8GablGWD+65fsQiHs6raPzyhj4G+7fY8vFbFcybtE4wcHVKSvyZID6
         RoNhnpyfecNIbZnPAgcan/3nVtb8i/fEi9sNT2cNt2v7JO4E4JQSEwHaF1mx0xoP4GgP
         97gFqnuhN0+LKMAOq/HVr8AaGt3UmO/dd3V3by2EMc20etaDKGbJawy0HdV092PpOLAD
         Q9ZDz5HkdCFVXqXapHJPuNDrA3zBmFbdLNmm+nZ+npyQldipwGeJu3AUeonPyN3dhlDa
         LepVDuKv1ZEi+8zPGKD0QgHn9a0xbtKax0/0XvM1ZW7liljj+AvCwsBWUPmlAWLuJbVT
         KIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/oJn/PttIIA0VjGbetBluNEGmQpHJguamid9nXqIlP8=;
        b=NNxwwQfbXlgGlu7p2BsNkD9EnISv+hlaQyucgOWrYUNdKP6n59JCA46BqiJ4xmVnN/
         5TNgnrCsI56osXUAiFxW4wBxq5pPi+hvjuLE5AREJeA6ZZMRcFAgwEzH92x1sGaWy7vW
         t0S7HGHbfShobpQ6s9gP6jnhXa137lYdg8kAKh2ZDDdAVKPP8TiKb3lyZ5J2W74k+F43
         mS2FPbOvNI+5+GSqvfWW1KwkHAVip96lP0CbklT8N4I03mPhWfjzZNyheK8haqN1m1Ez
         ow05FrF/ZXjoBa5qY2qmV/lmV+omz/v622jNEPCIdoLcwQSKMvSv3+K+GrUbr4DPskb1
         dzCg==
X-Gm-Message-State: ANoB5pnPv8MjCI/DclmBFyq+ei1wfglQ9b2Pk3HRbcG3jFV6qvqpQfKE
        5lvjIvBryTqn8T6xr09SxJHPRDnfjfBr0wQN6JA=
X-Google-Smtp-Source: AA0mqf5Dnz94N5Wkc+sueTwOv5mjsZcEkGxQfG1sxUxJ7LESxBHFCsPgn52fazfYIYXsmTevLVbw2j/5XQUgteSrYoc=
X-Received: by 2002:a05:6871:b2a:b0:143:824a:f05b with SMTP id
 fq42-20020a0568710b2a00b00143824af05bmr6174834oab.80.1669628640745; Mon, 28
 Nov 2022 01:44:00 -0800 (PST)
MIME-Version: 1.0
References: <20221127145130.16155-1-worldhello.net@gmail.com>
 <20221127145130.16155-3-worldhello.net@gmail.com> <xmqq35a390ek.fsf@gitster.g>
In-Reply-To: <xmqq35a390ek.fsf@gitster.g>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 28 Nov 2022 17:43:49 +0800
Message-ID: <CANYiYbGwHQiDh7qf-LTtuUM7eC3AEpkuXoejOBkJs-VGZTA14A@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] t1301: wrap the statements in the for loop
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Heikki Orsila <heikki.orsila@iki.fi>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 28, 2022 at 12:19 PM Junio C Hamano <gitster@pobox.com> wrote:
> Now you have three separate tests in an interation of the loop.  If
> you skipped the first one in the iteration (by mistake) and let the
> other two run, they will run with a wrong configuration and values
> of $x and $y variables, either unset or leftover from the previous
> round.
>
> So I am not sure how this patch can be an improvement.

I agree that this patch is not that necessary as the other 3 patches
and will remove it in next reroll.

>
> If you wrapped the setting of $x, $y, $u and the config into a
> helper shell function, e.g.
>
>         prepare_perm_test_variables () {
>                 u=$1
>                 x=...
>                 y=...
>                 u=...
>                 git config core.sharedrepository "$u"
>         }
>
> before and outside the loop, and make these two tests in the loop to
> call it upfront, then your users can skip each test and iteration
> independently while ensuring that the necessary setup is always done
> correctly, though.
>
