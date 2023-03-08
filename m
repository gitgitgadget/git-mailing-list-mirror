Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7621C6FD1C
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 18:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjCHSIF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 13:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjCHSID (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 13:08:03 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3113C1B
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 10:07:59 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id i3so18469243plg.6
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 10:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678298878;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nE6qYiOMT6otCsZXhyj6d+P1ypNkANVJN+Mx/iVt4h0=;
        b=kPQG/NFzFC0VmT0Z7X9fKDEYroOake9XXO9IKHPRMYoMIIEzcIVcLVexvm3bu2Z72K
         zseK08TUniHfQR2gtyP6G+U4oayQakaQdRfjcG7UrOUAvGFMxE/ckoNore6nZC8HrN9j
         Dv7M0k7QdhUJYwHXrkc5yP+pUlPwBy4yqj45c1n75F4ASTmqla6tJIa48HWs2wRPEKLk
         wGD3HygF9p5JbBGs+0De7j8UuG9ifDFF+pL1VFF5rrXC5K9bxmC5BIJIP2Hly/mj1pbQ
         +TNv6gQbLvTd7tKqGfyCjhwdz00B0hbla0aHJAnRNrTKO51a7UIzSGECa5gVMm0n7r5N
         JXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678298878;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nE6qYiOMT6otCsZXhyj6d+P1ypNkANVJN+Mx/iVt4h0=;
        b=Ay6vlUzVioBo48Egz2NBq01ur23jk0rTPmM+jKO6AHoh8vW8BiNuRM+yeP6WGBM3YT
         2M/0vCuLmUuuAmPgK5ncL8Nla786CUvyMfptUSY7Bb8nKqr87IPvQ+xY53Cq4yAikbf/
         +iasi9ULS/KQJsYjjjZ8Tdu3xF7jKr53XXkmmy7Rpp5/8Dja4953LXOmNgRZZlTGgATE
         UQthFvi2OALjO5L56spKDSfRY/mV2AldgNstQsUH5qfKstn7YVBpKIpcspUIcANbhQB+
         3TFPa3sAvg5LFCwlc5RDoWBM2GVfruhOmWAS9nr6LdqgdO9NFxOJAH0MoiGM6RM9O7OA
         AFKA==
X-Gm-Message-State: AO0yUKUPAz8dE+WzwrL5RjSBuLw9RnQsNUzOVKUbjQNglC6qXBEXQh/N
        UCIdJJkcQYUi3fDY2PUePX4=
X-Google-Smtp-Source: AK7set9r0eKE5Klmywg6v91czKIh7HR36kT4M+j/hspTz2lfGK4KeAzM81Nel7VDVFNrGZhcd5mjew==
X-Received: by 2002:a17:902:b282:b0:19a:b151:bf68 with SMTP id u2-20020a170902b28200b0019ab151bf68mr18950714plr.38.1678298878405;
        Wed, 08 Mar 2023 10:07:58 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id ki13-20020a170903068d00b00194d2f14ef0sm10090981plb.23.2023.03.08.10.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 10:07:57 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 4/6] config.c: plumb the_reader through callbacks
References: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com>
        <74a63fed7054da8049d4a32ecdb582726368c5a8.1677631097.git.gitgitgadget@gmail.com>
        <230308.86356fzhbd.gmgdl@evledraar.gmail.com>
        <kl6lttyvgm24.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Wed, 08 Mar 2023 10:07:57 -0800
In-Reply-To: <kl6lttyvgm24.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Wed, 08 Mar 2023 10:00:51 -0800")
Message-ID: <xmqqsfeft8ua.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> As an aside, I found "struct config_source cf" to be a bit of an eyesore
> too. It's an unfortunate holdover from before 4d8dd1494e (config: make
> parsing stack struct independent from actual data source, 2013-07-12)
> when the struct was called "config_file".

Ah, thanks for digging---I was wondering why it was called cf
myself.

