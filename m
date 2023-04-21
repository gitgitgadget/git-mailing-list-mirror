Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0F7C7618E
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 16:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjDUQ6M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 12:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjDUQ6K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 12:58:10 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2C915A0D
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 09:57:40 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1a66b9bd893so22160975ad.1
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 09:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682096213; x=1684688213;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wCXFlJHUsqGuc/UtWj1thfK4lEvDOJRwktDxKbbXML8=;
        b=Am4VoalTuZDE4rbnsd5xtMYXEDqAk+x+5x0h/xX9EF6qLZQu0lDWk2Wt2PhQn8x+5e
         gAyStkLu5Xlj/xE1ssMzEJH8yXp9FOjLw4rIoRFoIqyWe8gcoQ4TOxvm8QGj0EJ6FSEO
         0iF/Nj0uGhNOsJkYo/POXlgN5M3f1In6hPbQTiJBwe2WH1FnKzkupcxu0CP5Boc0/ky0
         vB36ggSE71mdelh8j5bxaB+Wt1bcNyUh8m9myDjI7WQdW4RfKOytKG6NDPPw5hc60Kaa
         lVBNRrirJ1twvIo3niVUw8gRjqj0nDTR6cUlrEn4/xgfWiSSDy2RkAG6zRf79RGkEyzG
         owwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682096213; x=1684688213;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wCXFlJHUsqGuc/UtWj1thfK4lEvDOJRwktDxKbbXML8=;
        b=l7+7SMgPYFTkrBrOioEwHMXMkFWMOfVYCTC6KCBPK4m9yAOkHwuWcU/cMJpW5xUv7h
         B4EIPZPHObhHlqis1iiKnOlpJxe3CQgINdstnrDNzcLWCJbpzlM4X7CxlTkXTF1LzPf0
         kB46A4k3qACDj3WSxhV0hBoM0yWdd6cx+MfWL6zhGhGctWZr5ogk6Vf8FNqiJJtYskop
         wt3Iqna/J0LeR9JfXQ2+2/9mnujC6jjLC74rPUSGZR8UUVOecvlmchek0AQTekvwUeoJ
         2vpfbJI03N+isZzpzSCgipbPmlCAPirPXgGlu8eKNJWafZ8Za8Z8hq0txOugKqJV7Kke
         BQnA==
X-Gm-Message-State: AAQBX9fH0Ag2mhX3i1+m7QsQLUbOcZ02Q72HJMl/4jiWG+w5bjcOE9rC
        t/Pze88wJda6hc0DCax6X9HdcZR01Rs=
X-Google-Smtp-Source: AKy350a1wj8r+YEEzxl5WSHUW4wKMSeCBUbo4Z8X5H1St2U4KVk1Tq+HokJpG6fKGlM3Y/51+U/uAQ==
X-Received: by 2002:a17:903:24e:b0:1a6:4a64:4d27 with SMTP id j14-20020a170903024e00b001a64a644d27mr6826134plh.40.1682096213266;
        Fri, 21 Apr 2023 09:56:53 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id bj5-20020a170902850500b0019719f752c5sm2940546plb.59.2023.04.21.09.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 09:56:52 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/6] rebase -i: impove handling of failed commands
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
        <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
Date:   Fri, 21 Apr 2023 09:56:52 -0700
In-Reply-To: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com> (Phillip
        Wood via GitGitGadget's message of "Fri, 21 Apr 2023 14:57:48 +0000")
Message-ID: <xmqqcz3xkwbv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series fixes several bugs in the way we handle a commit cannot be
> picked because it would overwrite an untracked file.
>
>  * after a failed pick "git rebase --continue" will happily commit any
>    staged changes even though no commit was picked.
>
>  * the commit of the failed pick is recorded as rewritten even though no
>    commit was picked.
>
>  * the "done" file used by "git status" to show the recently executed
>    commands contains an incorrect entry.
>
> Thanks for the comments on V1, this series has now grown somewhat.
> Previously I was worried that refactoring would change the behavior, but
> having thought about it the current behavior is wrong and should be changed.

So much has changed since the original one, I did not even recognise
this was a redoing of the "rescheduled step" topic (which I do not
think I have kept in 'seen').  Building on top of the more recent
'master' like you did here is very much appreciated.
