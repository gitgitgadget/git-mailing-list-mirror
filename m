Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB84C636D4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 08:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbjBOIT4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 03:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbjBOITy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 03:19:54 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AE636469
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 00:19:27 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id br9so26625639lfb.4
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 00:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SndVgn9f2EVRdt0XkKR2CmIyowqxXFFdNRGCt9YXlOQ=;
        b=Ivlv3kLnBvowjshy8Wi0KhAbYMuRcDd28d3NJVkaVj4fkKPEOMHk0qfo31/DDCiP53
         RSYnOLD1822HycRvxL8crnvC4OpAJiLrmIQuAw2nLTsr/jhSHZGtkzZ3EOub8FYKc4dF
         8MAJy96cQ98KgRDZwMlopJjLXf6NDTMvbyzhygTrKHTVtqn5FIyxjXENFoi+lFwyLVl0
         5MzpznxxHSELqzjXuDrHiZusnQR64kbDzVX1A41+r6PFkYrMDEeXYW+VU8OzFy12r4GJ
         z7xL3RE2Sd7Dk5Q8YbXmjaKMgDrCOz3UaSIAaAz7PfnLwYMv4TaVzkjifKfoxkaaUwwX
         KqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SndVgn9f2EVRdt0XkKR2CmIyowqxXFFdNRGCt9YXlOQ=;
        b=081/k+nR7aw5SR6sRNIDpAcQT2QR5Vdab33T+rm+E9iEE6V7FIRMpUvgiU3dZ8Cu5N
         logP59BorP8vaIDMhAdb4zeSBz+PJf1Hzei0wMf1E6QiRlk7/IbiS53xoy8/arxi5D3/
         CnMSDwMl4X7Q2XvSx/aWxVZgCITfuMKMOId5I1wOnnw8vWr5m0gZ7o4oEt5JVz5utoHP
         HQn74jzvzQjddnR7id1QvDKpBVWv/ESAkY9+4oJrt02vIyU2TUW5MWH8kjcHo7ckN6tg
         rogeFA8IJzooDgz+3/IZbyWjzUq1MpkJMY1hk6zwsbi3IkrflOAX6U6r21YVAjca1Qp/
         FP+g==
X-Gm-Message-State: AO0yUKUSAZzLnY0Tf71Fhy+mya/cQ30ZB4b+ZQ7s8c60LmnmBYyOOCKe
        3N8b6xiwe45w6trTvyTSMQ5xjZyfn90lZiLhYNdpm774+3c=
X-Google-Smtp-Source: AK7set8OAbxJ7xalu5wGnivLYu9OHyg0lIVwozsiiupm640fmQRB7FsjCUdTtORYHgGRKoN2zLcNZ1yIlBmlOXtZWHI=
X-Received: by 2002:ac2:5296:0:b0:4d8:5037:6da0 with SMTP id
 q22-20020ac25296000000b004d850376da0mr283303lfm.8.1676449165549; Wed, 15 Feb
 2023 00:19:25 -0800 (PST)
MIME-Version: 1.0
References: <20230210171338.81906-1-vinayakdev.sci@gmail.com>
 <xmqq8rh5gox7.fsf@gitster.g> <CADE8NaqvP1JbLL89prOCu2Qo-ZVJTTN_CZjk7bJwzMctV9Z2Bw@mail.gmail.com>
 <CAPig+cT98gscoD=Fh-QzJxruxdZmjGKW3gy95cA3xAokV7J4rw@mail.gmail.com>
In-Reply-To: <CAPig+cT98gscoD=Fh-QzJxruxdZmjGKW3gy95cA3xAokV7J4rw@mail.gmail.com>
From:   Vinayak Dev <vinayakdev.sci@gmail.com>
Date:   Wed, 15 Feb 2023 13:49:13 +0530
Message-ID: <CADE8NaquOppesW5v9LMNE=TAu5J=bS9uCgkhkbu4QZ9JpoSLxg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] {apply,alias}: convert pre-processor macros to enums
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 15 Feb 2023 at 05:34, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Fri, Feb 10, 2023 at 11:00 PM Vinayak Dev <vinayakdev.sci@gmail.com> wrote:

> > Should I re-send [v2] after making corrections for this mistake?
> > That would make the corrections more obvious and the mistakes less.
>
> You should send a v3 which completely replaces v1 and v2.
>
> To prepare v3, use the "squash" (or "fixup") command of `git rebase
> -i` to squash all three patches from v2 into a single patch, so that
> v3 consists of just one patch. The squashed patch should contain only
> changes to "apply.c"; specifically, changing #define to `enum`, and
> changing the variable declarations from `int` to `enum`.
>
> You can also update the commit message of the squashed patch so that
> it explains the reason for the patch: specifically, the debugger will
> display the values symbolically rather than as mere numbers.
>
> Finally, proofread the commit message and the patch itself, and resubmit as v3.

Ok! I have absolutely understood your points. I will roll out v3 with
appropriate
changes, as you suggest.

Thanks a lot!
 Vinayak
