Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56B7C6FD19
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 19:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjCMTqb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 15:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCMTq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 15:46:29 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3776532A7
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 12:46:28 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id ja10so4546592plb.5
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 12:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678736788;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X02+1PcF1g9Na/H9Tf148Ept9i3JHLSErsTo/xUA9Vw=;
        b=eohHxytFKqgcnn57EoTJRqOiIvzcU4JtTrI26dzx2W/YJ60WLGodYae6Y5ze06lRGk
         Ogxs63G60GzmsYg9SluN2zlfVIgagFG6n4aXfzB+GqORGLRzOeplq8CriM2djX8UFAkA
         rRM2KKi+/h/xIAu2lA6U6gA7qaiZ/sVfRZqvu4JQoh48M4/83dr1wpORLzZ7JXtd+uyR
         Tsdzk/l2RKbzTncbwuOrit6lcmXOu8TTR3SIhbqivU3jh7T8Zd0lzhfJy4v3FeNnuh8P
         lNfencXJW6bc+5SrNGiq2f9GCljjXanopdlw9UMDLDBrA0ZdRiBYzgHGL2HQLrC4RlUE
         3vBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678736788;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X02+1PcF1g9Na/H9Tf148Ept9i3JHLSErsTo/xUA9Vw=;
        b=fw3NI1eEfmWNJbxDJcK72G8HDN+XSBFt4nL10JvN55Ez00l8f78Tz0gxJWVAn26exH
         50JzNXMpcfQGm7HxVD4MNxbKH+8bWS+m3PjDnHVEAhQGm2ixu2Pc+q+4WtlusLzm/BTg
         VoXgQj1VGSK+LWuiFgDToNvliLoNqrF2jTxjNo6nJVsJbB0uhgs+3/DCVHl1y5DZwbAN
         lU8ZPn12qOqCJ3o6uv9TL/G4TSf5z1Z53JOKhxMicC+5NA7WR7dCMNixWLBXuBloQEd6
         1Q5kIkz5udbuJy8M/bIpy1R/HEm+hB5jG0mcD5S2T/OJE5wl1eK2KRvBF8J/X6yvQih8
         1ibw==
X-Gm-Message-State: AO0yUKUJJL5x6+3cMssA6oyK+c0VR61dlykG80uvyXUBdVj0W9qi3acd
        fy8r4p06Pwk1Wnns11cGqOo=
X-Google-Smtp-Source: AK7set+7l5Okt15L3E7PGgrvld5SNMaH0WHoyG13psXi/I6AZ6NJPXPerE6vKMuRPnw7fbainpS+ew==
X-Received: by 2002:a17:902:c204:b0:19f:3e77:ab7 with SMTP id 4-20020a170902c20400b0019f3e770ab7mr5661518pll.57.1678736788417;
        Mon, 13 Mar 2023 12:46:28 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id o12-20020a1709026b0c00b0019a97f180fcsm256500plk.37.2023.03.13.12.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 12:46:27 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org, tao@klerks.biz,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com,
        Glen Choo <chooglen@google.com>,
        Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH v5 3/3] rebase: add a config option for --rebase-merges
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
        <20230225180325.796624-1-alexhenrie24@gmail.com>
        <20230225180325.796624-4-alexhenrie24@gmail.com>
        <1021e6d0-0cd0-d92c-4cb3-45dbf2f6626e@dunelm.org.uk>
        <CAMMLpeRfD+81fsEtvKFvVepPpwYm0_-AD=QHMwhoc+LtiXpavw@mail.gmail.com>
        <5551d67b-3021-8cfc-53b5-318f223ded6d@dunelm.org.uk>
        <CAMMLpeTUbG+b89acan-GXGS4H=J7aQupbK8zdxwNg__U_We2dw@mail.gmail.com>
Date:   Mon, 13 Mar 2023 12:46:27 -0700
In-Reply-To: <CAMMLpeTUbG+b89acan-GXGS4H=J7aQupbK8zdxwNg__U_We2dw@mail.gmail.com>
        (Alex Henrie's message of "Sun, 12 Mar 2023 14:57:28 -0600")
Message-ID: <xmqqa60gtox8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> What I really don't want is to paint ourselves into a corner. You're
> right that it's unlikely that the default will ever change from
> no-rebase-cousins to rebase-cousins; I was mistaken. However, Glen
> thinks that in the future we might have some kind of
> rebase-evil-merges mode as well, and that that might become the
> default. If we don't let the rebase.rebaseMerges config value control
> the default behavior of --rebase-merges without an argument on the
> command line, we would have to introduce a separate config option for
> the transition, which would be ugly.
>
> More voices would be helpful here. Does anyone else have an opinion on
> how likely it is that the default rebase-merges mode will change in
> the future? Or on whether rebase.rebaseMerges should be allowed to
> affect --rebase-merges in order to facilitate such a change?

Any such "opinion" about the future, or the belief that we can
somehow predict one, would be wrong anyway.  So I am not sure
soliciting more voices to look into crystal balls would help all
that much.  Having said that...

The default rebase-merges behaviour may be improved, but changing it
in a totally backward incompatible way _without_ a carefully prepared
transition strategy will be very unlikely, simply because existing
end users would not allow us to.  I do not offhand know if the
configuration variable(s) you propose would serve as a good mechanism
to help such transition.

Thanks.
