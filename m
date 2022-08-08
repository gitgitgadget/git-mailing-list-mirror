Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6F8C00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 17:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243067AbiHHRck (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 13:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiHHRcj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 13:32:39 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4100EC78
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 10:32:38 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id j66-20020a9d17c8000000b00636b0377a8cso5964371otj.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 10:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=D+vAzkw7qVZv4+9yb5BYHcoZD3Zzpfg2gx+q5gcvvD4=;
        b=fREdq7+ApMsuviXRpzuE2x/jNCPGPBdvxW54A3EgBn2DOsLSYPsrOgJuBn6w9ZHmpb
         abXO8glFbJoOrYLY8oUkU/W/pdeuBUHTDgvNvEgWGzRY/MD58PitcO50jSkJfitjSh15
         2W4+/0/mt5xxSUvnhNCtxvN+/oD9OQkX293k0EW7CtsoAzlJ9UZIriRG0KXWXapJdBnB
         swvAKo8P3mRmLTSaqSVfSWtvOLwBt6BYNTYFhHTAN9LxdMewI50jWHThMGJOrPObylZR
         jnHhqLqQNypIGtlfA4Ya13ZJxXaveBlhn48RuW2TVhRpjCYztTwVlcPNmMU9gaySpFfD
         CTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=D+vAzkw7qVZv4+9yb5BYHcoZD3Zzpfg2gx+q5gcvvD4=;
        b=wD3gg4vcnL9Aj4BmAojZQnaQ+zrfOTfdhqpKMmnhD0O9evNZL2ksDqEn4kJkSQSPXV
         2KO1hVreUywHsaXAqh8JduozZifFXS/j1H8+8eQrkZ2qt3QZ4H/EgqTGABs1A98lGcac
         +DOU4TUHiATL2WoZAz/35E4zb13RucB6RT2Wn9oJu6tWh7BYtcgOK+vLJ+c6kMDwTBDQ
         FG9ygQe6KDYtsX/F2AyhYGD6XTgk461l+fSAEWyZOqn1g/YR3AhbUPJBpi5F+ZRbMgz4
         CWImEcVoPJDjE+HAvgEGLa4Qov1IDhOppljnlT6TGZbR2jYI7md2zRAn78f/4RzP/yeA
         V0kw==
X-Gm-Message-State: ACgBeo0JS5KDV/JfHHb0oJIm6wWP0dPVc4thNwtWv81EkEIQFkNZuDr+
        6k5Fy7KONm4/bJainn0/H3N8rePT91r3nbSdX6BHJQ==
X-Google-Smtp-Source: AA6agR7bt9g7JDq7NdjJJuPvx9heREOTMI/cLjUsXTwsLqaUXm+JDtMRfCr36gozVcYGeXi//Lioe1ZYppYKUGOqdnE=
X-Received: by 2002:a9d:22a1:0:b0:61e:e511:5674 with SMTP id
 y30-20020a9d22a1000000b0061ee5115674mr7265591ota.56.1659979957254; Mon, 08
 Aug 2022 10:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220328191112.3092139-1-calvinwan@google.com>
 <20220502170904.2770649-1-calvinwan@google.com> <CAOLTT8Q-241cExFcbXSUfj42GontKH0uQpX1Voekf4RJ95hAVw@mail.gmail.com>
In-Reply-To: <CAOLTT8Q-241cExFcbXSUfj42GontKH0uQpX1Voekf4RJ95hAVw@mail.gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Mon, 8 Aug 2022 10:32:25 -0700
Message-ID: <CAFySSZCoykakjSrgUq0kcQeP_1WDoPgxBpyLeLYSBakCyuOJVg@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] cat-file: add --batch-command remote-object-info command
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Philip Oakley <philipoakley@iee.email>, johncai86@gmail.com,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I have to say I am very curious about this feature. Since the current
> git partial-clone interface supports only a few filters:
>
> blob:limit
> blob:none
> sparse:oid
> tree:0
>
> Though these filters reduce the number of objects downloaded each time,
> sometimes I just need *only* one blob object, git partial-clone will still
> download some additional commits and tree objects from the remote.
>
> This patch can get the remote-object-info by git cat-file, so can we go
> further to get the remote-object-content of the object?
>
> Something like:
>
> $ git cat-file --batch-command
> remote-object-content origin <oid>

I think this can be potentially future work. Part of my hesitation stems
from the fact that there is no need to print out any object info when
downloading an object. Therefore, it seems better suited to first be
implemented in git fetch (or added as a filter to partial-clone). And
then remote-object-content can be a combination of fetch +
remote-object-info.
