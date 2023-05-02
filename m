Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B7CC7EE26
	for <git@archiver.kernel.org>; Tue,  2 May 2023 16:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbjEBP77 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 11:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbjEBP74 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 11:59:56 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F8B172B
        for <git@vger.kernel.org>; Tue,  2 May 2023 08:59:55 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2ab25e8a4a7so39406941fa.3
        for <git@vger.kernel.org>; Tue, 02 May 2023 08:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683043193; x=1685635193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKp8AUrHO58rntI23fXve+3eyPYceZUfFMQI6Mo3fAk=;
        b=epZ9s5ZWhBx2nMp6hS9yYy1GPDpj+T8xsTwMSL5m8PJNKw0MITtkmCfO/BUxS3u055
         5M7neA1/xGmB7UPrErg2pC7mf1aBsqoz5acrI3MlQ4l8ILvUNSDkf8vejoFw6/U43Aqq
         fPS3RBbr48Qh2UdueG1YxOdHFf/dcIn5oNsgTF+BX7o+qLTo+JItC8nEWR5WN74bi09Z
         hCvusiGj6Yh9UOwKoY9AC6FZ9ZEUwTmwLAJTP9LARhnh860aayX+B2MZhZyY1S9ylqHS
         G9ikJJXHvMxH+1ZNWmOG+s6+9lnK0AIBRjiTMcFeB3ne0Rz1QzPhUpojLvHHBczAHxxY
         9WtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683043193; x=1685635193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKp8AUrHO58rntI23fXve+3eyPYceZUfFMQI6Mo3fAk=;
        b=Qz4JLxR8pHTbjkqieV+pMYaNdIDYgrRGhNuzevBUvftewPsg0/yezJOfTaX3XpdJSe
         SnyfVptyPCyQ5kJfa3ybV0MD4ezzQXB4b2iIXLTlfXREZ2RxUZW5XppZvPcvCyhOu3J/
         vXIf7T03f+qO3d2fJepRDMz3FfYZqqeho5KwsE17bx9M5WH54uDJayj+tBrW/vMpoh/x
         UMkC0m/pN5k5TuBRFYWNX/yI51/f11ArwhbXRYymM734Ijuw8cna55X5ISbNcsJFY1xf
         u8NmOm7eq+ReJiAJiIWRS4iT1DvwJgoZUcGO9F5fGU93qla5VdX51pSpSD7fIPxaCKpx
         lpoA==
X-Gm-Message-State: AC+VfDxjzuXg6KM6B7PMg8HB5cOgrZLRzylarQfFmOiUd9Lu4TAPd2kj
        J6hrWjHKHO9tMcW+bTaSdwmNU8mu41BT9NSlFTwn0NGq
X-Google-Smtp-Source: ACHHUZ47XRPmDGLWmySgC9yOgedFqUegdnvhBsAZRvtNvA/rQvOA/AMHaKsK0pWXo7EdMCXTc9IxKFK+ZV50QBq6Djw=
X-Received: by 2002:ac2:4828:0:b0:4ef:ec96:f97 with SMTP id
 8-20020ac24828000000b004efec960f97mr115760lft.6.1683043193389; Tue, 02 May
 2023 08:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
 <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com> <7b55f82e62ecf761b804432c8d08dffabbb7605f.1682194651.git.gitgitgadget@gmail.com>
 <230501.86zg6ohuw7.gmgdl@evledraar.gmail.com> <CABPp-BEPy4R1R1X1o1oMs6sEECVjEoLeRXripEi7k8ZO-CrbuA@mail.gmail.com>
 <CABPp-BHymt9COEjnTRTbg_vHa4s6-CL7Bh+9q0PfoiE0SRcRrg@mail.gmail.com> <xmqqr0ry20d1.fsf@gitster.g>
In-Reply-To: <xmqqr0ry20d1.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 2 May 2023 08:59:40 -0700
Message-ID: <CABPp-BHUQQi6A3uvDBuefYkC3puyP7zjtKJ6kXWyCOj+yWGb=w@mail.gmail.com>
Subject: Re: [PATCH v2 12/22] tree-diff.c: move S_DIFFTREE_IFXMIN_NEQ define
 from cache.h
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 2, 2023 at 8:56=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Although maybe I'll have to do it in a follow-on series?  Junio merged
> > the series to next today, so...I guess I'll just add it to my "header
> > cleanups" notes.
>
> I am not =C3=86var, but it is so small a thing that is local to a single
> file, we can wait until the dust settles to avoid distraction.

Yup, sounds good to me.  :-)

I've got it on my todo list for continued cleanups.
