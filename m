Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F830C433EF
	for <git@archiver.kernel.org>; Sat,  5 Mar 2022 00:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiCEA0w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 19:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiCEA0r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 19:26:47 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2269B12CC20
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 16:25:59 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 1-20020a630c41000000b00378d9d6bd91so5309671pgm.17
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 16:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=f73uy4WMgvLS3ix15n9iTsCf87dEHyjqS5j/upBqwDs=;
        b=d7ZQyrIyxF52/KSDnPiS2DOGEUsF9ANeKH38x6mJNCC2P9BeMf0nywzK3mK7+imoeU
         BgUZPffqg36lWsdnrcNgRY5bObSPS7NC6hF7w5xJogyKRYYp/BXgJ9gf8J45RHEJzhgZ
         a0OaWGWzUwK92wmdpuyJDFEhn0ZeZadJv3/+zCzcYjam+7l5vLCFx7GRYmJ6z4vETpqE
         l2hbscC3vqaduiB1tjlVzGOUHkEGdiES5HQ4L4QU4KxVJT7GMaUtCkN83L91nPONYTWC
         gusa0v53csDxsND88cIgGnxYJhZ70eDcz3dMG7NEidV7rUEKtPR0DqBlgcXKSvc9Mdgg
         lklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=f73uy4WMgvLS3ix15n9iTsCf87dEHyjqS5j/upBqwDs=;
        b=uHBIXxCzVSkjHkOAhYrl63/goMgXDololPRvf8x+MKeprayFoLwWmJVkPxbOxjE/e6
         BT7wMg49JT10J5rMtBsVH4kITCeNc2AAwoAsqkHiyVQbtt2iXEVziwv8VfW3kchSYqWp
         r38CmF9ruzoMCjG77VO5qdpDXEW7UpXG/ktyCE9ZINHZQb+yuBnwLnaOVhmTm0BL2cMQ
         wzS92dczRxJBZquiD0b3/g/o+zD6CXFU8VroLE4VSfShMuE2V5+VVMQZkaLpM1FjlIDb
         1cYDtWLacBZBEx/O82aM86JI0GKJ8tN4eXwzX3p8iE2aHTpyjjfaR5pN5tzxEVpj7ppk
         ygHg==
X-Gm-Message-State: AOAM530QNEYC+9KXHqwKdXOBXXPaLvKE7tzdrvXeE7n5wExLpIlF/w4B
        XnODzWBtYfSk3cKCoJnHJiOV8hOHBZeUpw==
X-Google-Smtp-Source: ABdhPJzFbc/ynF4U43yiZJ0ZAkp/NKWSLS19BwHUnyGPEm+ycqvzGAZovdZduhzVVUJvjC5pzgPPgB5RMCG7Hw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:7805:b0:151:b8ec:202b with SMTP
 id p5-20020a170902780500b00151b8ec202bmr900794pll.111.1646439958614; Fri, 04
 Mar 2022 16:25:58 -0800 (PST)
Date:   Fri, 04 Mar 2022 16:25:56 -0800
In-Reply-To: <xmqqv8wtwa6u.fsf@gitster.g>
Message-Id: <kl6l1qzh454b.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220304224156.637697-1-jonathantanmy@google.com> <xmqqv8wtwa6u.fsf@gitster.g>
Subject: Re: [PATCH v4 02/10] t5526: stop asserting on stderr literally
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> The check_ names still aren't changed (as I suggested in [1]) but
>> perhaps it's fine to leave it. It doesn't seem to bother the other
>> reviewers, and changing it would slightly disrupt the review in that
>> there will be extra changes in the range-diff.
>
> At least, please do not count my not mentioning it as such a vote.
> I didn't mention it because I saw you did.

Oh! Sorry, I intended to do this - I missed this and another suggestion
that you made re: test assertions [1]. Will incorporate this into the
next round.

[1] 20220304234622.647776-1-jonathantanmy@google.com
