Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED5FC636CC
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 04:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjBKEA5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 23:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjBKEAz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 23:00:55 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DA37FEF6
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 20:00:53 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b3so11358676lfv.2
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 20:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=phQocdMxgwIOHdqcve3e4YOx8iu8aVyTuOTooc2c6/I=;
        b=XInbWGRfNa3QXPm0femqqNX/d2KU0e1aH6Q1Gqx8px5bgKO8LKrEx/4CYJaovypwmz
         msU6Rvf6HdKG1NWUjonLqz8u5bcGO/lr6IJmfzZcla90HTh2ltBnTCP0CDNamU8VlRUL
         FGduqlOBFc9QcPD0QjT4vM/ejguvNSc8nZChKihOAsvPodEbmSUzQDJVfzc2qXyAT4+2
         As+sGJAys99U3IgCUmzgHDL4zYvSjGWNrvrEMxh8CyOTBildajbrVtB4OKCq7iwrXL6V
         SJEbifmTPGSyv8uLpqp+zSw+7sBMivJ0t9lo63Y2lTur0IzCk0DJn4jJTnLnQY8RWZBD
         QXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=phQocdMxgwIOHdqcve3e4YOx8iu8aVyTuOTooc2c6/I=;
        b=YfMjPA3BBPRUt/Deu6yDob/A/AtCKdbhCAa1Jbr9pVws/D8vvUhZ98q0NK+FFWD+VJ
         +nph8E//K9Bal0xFz7mtBrbCTjXHTtxmIp7ML555Glv+r7hA6uTcLmqUqCxPR6R8+0FT
         Ozq6oMuvKC1c5oJXaVNH1CBG98+GIN/bffbjG4uXwQKKA8fu5y4p90ICZ26cLLg8DvKT
         eoOGDlR7jkrdmR4FbOhcOG9A4fBe+D+z75yxYDXSnwjN+BaZeYqKOrZzj2PNwl2OmP5C
         bzdqoKbSNst2I5LKNC5oGoadNtvW7Z//q/NWn6QAR/FRgC6p1g1rydL5ZaCCR9L5LaV9
         Je7g==
X-Gm-Message-State: AO0yUKUAIcOKMuhcEne+s2eEVhAfFmuSUTwP+5NPe2LGYzR5iHjk/vFG
        6NOeO17y4FmW7T6A1IcrRRwbiOqcqRvgjdKsW4c6HhrJ9as=
X-Google-Smtp-Source: AK7set9/oe+pghUt2ifjFqt+cy574W7G4DnZhwSwGpRtZ/uEJGrNfHeNtaxSc/f+mwm0YSVHCMNMWputZdQ8u2GVSC8=
X-Received: by 2002:a05:6512:41a:b0:4db:2ac3:a51a with SMTP id
 u26-20020a056512041a00b004db2ac3a51amr567985lfk.29.1676088051493; Fri, 10 Feb
 2023 20:00:51 -0800 (PST)
MIME-Version: 1.0
References: <20230210171338.81906-1-vinayakdev.sci@gmail.com> <xmqq8rh5gox7.fsf@gitster.g>
In-Reply-To: <xmqq8rh5gox7.fsf@gitster.g>
From:   Vinayak Dev <vinayakdev.sci@gmail.com>
Date:   Sat, 11 Feb 2023 09:30:39 +0530
Message-ID: <CADE8NaqvP1JbLL89prOCu2Qo-ZVJTTN_CZjk7bJwzMctV9Z2Bw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] {apply,alias}: convert pre-processor macros to enums
To:     Junio C Hamano <gitster@pobox.com>
Cc:     sunshine@sunshineco.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 11 Feb 2023 at 03:31, Junio C Hamano <gitster@pobox.com> wrote:
>
> Vinayak Dev <vinayakdev.sci@gmail.com> writes:
>
> > Revert changes to alias.c, and change variable types in apply.c
>
> When you send out a rerolled series, you do not have to show your
> past mistakes.  This [v2] is structured as a three patch series
> whose first one makes a similar mess as what [v1] did, the second
> one and the third one then revert some parts of that earlier mess.
>
> That is not what you want to show your reviewers, and more
> importantly, that is not what we want to record in our history.
> Rerolling a series is your chance to pretend that you are much
> better programmer than you who wrote the [v1] patch.  The review
> exchange is to help you do that.  Please take advantage of that.
>
> You may find "git rebase -i" is a useful tool to help you pretend
> that you got to the ideal end result without these "I tried this
> first, which was wrong in these points, which I correct in a
> subsequent step" steps.
>
> Thanks.

OK, I will keep that in mind before sending subsequent patches.
Should I re-send [v2] after making corrections for this mistake?
That would make the corrections more obvious and the mistakes less.

Thanks a lot!
Vinayak
