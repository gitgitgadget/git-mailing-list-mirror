Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4765C46467
	for <git@archiver.kernel.org>; Sun,  8 Jan 2023 02:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjAHCI5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Jan 2023 21:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjAHCIz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2023 21:08:55 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBF913F91
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 18:08:55 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 36so3667484pgp.10
        for <git@vger.kernel.org>; Sat, 07 Jan 2023 18:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AwVLFpNiLgScirpFsT8Nm9FXddVa0qJrOMyVPNCh6JI=;
        b=PDw5DPLtPhxDX/0w2ArumiB71Vhg21wdtvuH2KrJQsnY7Dn9cgPlY4jK63c8rl3jHH
         7nYqJLbqcfJHk5nF/Ef73+RRJCllhIT/bKD/rMrIS/Q+NFxSNA+zzJ8+4gUiQ9+JJUnh
         7Bp1ARvGQQe9XjprQgZwSRxXNgEEx6o1pmzgCf7kjvwdQJp3Mn1I8sxfufNegYDaM80q
         n+U26aNrzuJTSeBWB9tzQay/HvDjWEg302aZU2+WFMn9plfPW0i9m6iO0/AAEWG8pqgD
         SHWAJGrJVD04lz7q7USL9cabGFVmJrcZ7SdkGuywWjj64ijBh0Y4SE8S4eXfGZxbRBs7
         eYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AwVLFpNiLgScirpFsT8Nm9FXddVa0qJrOMyVPNCh6JI=;
        b=ML++uKVHkkeqTZRVPTAOd2KRBlakz4JXkU+nF7afNgLSr0T2a8ACi1N4sRinEonLVo
         2WhN3im0XnPlRc6uMvC8qWI7LVi2U3VGazNrOuxB3a0Xzt8ysjGfbCpKHtBbrqMYnHcb
         xHc9i72j+oQW82uplC7V3h8WXuJV3rL0Em1wRPFP2RTEHMuGfPi8O8dG0YExSALYaOn9
         r5pyz8kVwfgdconIDWl9zHY2JBvHBQ9uP/vdGrho4MCjY1qWezgw9dYYI40g/xHc0qWF
         9EyUvijZNQEuNkf/90yBj8SN6cctFP5rjplEaKPtJEvOag5pAE2eJOFevTHazaTRh0c3
         FCAQ==
X-Gm-Message-State: AFqh2koud9T71xn4ZcQPsuJ+l2W9aS9LFHgVM15L67x/Vgea2I5TOx9n
        tDoQ2CqaL2c6ef4hOeqxq/Y=
X-Google-Smtp-Source: AMrXdXuxBMK50CbuGg9/L2ZLk4hg3pQ4s5RasI7EQmDo0TU2I/O/el1aqje8f6+mxfw+X0VOSx3VGQ==
X-Received: by 2002:a05:6a00:d73:b0:583:1a00:dcf5 with SMTP id n51-20020a056a000d7300b005831a00dcf5mr10697032pfv.15.1673143734620;
        Sat, 07 Jan 2023 18:08:54 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b29-20020a62a11d000000b00582f222f088sm3405417pff.47.2023.01.07.18.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 18:08:54 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Erik Cervin Edin <erik@cervined.in>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 4/5] revisions.txt: be explicit about commands writing
 'ORIG_HEAD'
References: <pull.1456.git.1673120359.gitgitgadget@gmail.com>
        <302b789a4869c2aa8a0de2f71a2725c6c567685f.1673120359.git.gitgitgadget@gmail.com>
Date:   Sun, 08 Jan 2023 11:08:54 +0900
In-Reply-To: <302b789a4869c2aa8a0de2f71a2725c6c567685f.1673120359.git.gitgitgadget@gmail.com>
        (Philippe Blain via GitGitGadget's message of "Sat, 07 Jan 2023
        19:39:18 +0000")
Message-ID: <xmqqcz7p22x5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -way, to record the position of the `HEAD` before their operation, so that
> +way (`git am`, `git merge`, `git rebase`, `git reset`),

Let's not commit that these four will forever stay to be the
commands that uses ORIG_HEAD.  Perhaps "(e.g. `git am`, ...)"?

> +to record the position of the `HEAD` before their operation, so that

