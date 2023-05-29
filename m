Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1BBC7EE23
	for <git@archiver.kernel.org>; Mon, 29 May 2023 16:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjE2QCe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 May 2023 12:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjE2QCc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2023 12:02:32 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4E0C4
        for <git@vger.kernel.org>; Mon, 29 May 2023 09:02:30 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b04949e4e9so5061475ad.3
        for <git@vger.kernel.org>; Mon, 29 May 2023 09:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=myitcv.io; s=google; t=1685376149; x=1687968149;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=brSdykT3gXT/90sMGWMQmvfVauFUXMZkAIpuhvpSjuo=;
        b=gYOzwfFzbHFMMHCw0muC4B8VAnAizv/QdLiL+SgdltSb4nOLDGw3tavTiveOR4bt4H
         P+nNQbx7B6uie0WHv3Yq45gMPzOfP8rANL22NZCLS2DpIJbZ0U+sbSjiDY7O8mHuSyiV
         eQuBR8z0smtNmmi2j7QInENaK5yi9sXBwvJ3A8OPq7RUl6AZYoXw2nmGXcLFDxek6UAF
         WP/crfjMjO80fzag14LEUvABIISNMQ1esLL6s/mbYM9KbamV/Jqol/9h8ifhGMHtShly
         oAWgHztdUXngNqvP2ilmFGFk+eccvN1A8RjxBhrZWmDA5FO33GEXO7etTzudSqk1bGtG
         Y0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685376149; x=1687968149;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=brSdykT3gXT/90sMGWMQmvfVauFUXMZkAIpuhvpSjuo=;
        b=FxkRhqEbApWmCOvLRGUavQr4JkC4vdPC3JhN2Fa1JTeb0u7+3FQ8LZLKDUlNwpBLiM
         mmarRGg3qNPiHOMkMtn3W/hWo1QsjH/xnZt7CchU3eaHVmNHLcQbO9zHkIup5DhuAKCF
         YSU8fa022z/awcuM78Yx8RigJlZNoU/Ga23MH54uKSjZShPikwBCrY/JdjHi5CsKGyFW
         XYw3BkwKetG5YehfE0g3jQ6IdmLsuWwC/Pq4QawDL0aUeYgB+dc2ikx5EZ7/wpFnCnOh
         DvxLZBjjJm26AnNjS/tE0uV8v8TQR3ozN26LMgCfKNR9UIp8/FE0C5o/gtrmUx64wMME
         3dIA==
X-Gm-Message-State: AC+VfDwxhZ+1GgDDeC+LLFmHTm2UHSqKmZz/SZ7pGq9Zfo2hj33v882r
        fUbsaU2EWQ0iOeGTZLDwh5SfcIMdAEfzyH7NFfVIf4DJf1y/8xvUSfP1RQ==
X-Google-Smtp-Source: ACHHUZ4mXt0Sz70K/pZXROTWGgBuFWBa31mIJH9cLCH7XSygmgec5itriI7ArxJG+bUNfnnr9iiqel846snJ5Q8eT9s=
X-Received: by 2002:a17:903:32ca:b0:1a2:9ce6:6483 with SMTP id
 i10-20020a17090332ca00b001a29ce66483mr14673244plr.64.1685376149597; Mon, 29
 May 2023 09:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <CACoUkn7TmZ=trtDKcQm0SG5qCqK=-+YxrDV-7xYnLH_XK7K7og@mail.gmail.com>
In-Reply-To: <CACoUkn7TmZ=trtDKcQm0SG5qCqK=-+YxrDV-7xYnLH_XK7K7og@mail.gmail.com>
From:   Paul Jolly <paul@myitcv.io>
Date:   Mon, 29 May 2023 17:02:18 +0100
Message-ID: <CACoUkn6F_=JR5SYBWL2sVDxDVAZbxcV5Ruif6wLba-_q_QNiZg@mail.gmail.com>
Subject: Re: Automatically re-running commands during an interactive rebase or
 post commit
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I would appreciate some advice on the best way to solve the following problem.

Replying to self with some updates based on further investigations.

The lack of pre-commit like hook during a rebase is documented in a
few places (https://adamj.eu/tech/2022/11/07/pre-commit-run-hooks-rebase/
to list one). The -x flag provides a means by which I can
retrospectively amend the "previous" commit if that is not clean. Not
ideal, but a solution of sorts.

However, the main problem appears to be the lack of "hook" to do
something when git rebase detects conflicts.

Ideally, I would like to have a hook be called when git rebase detects
a conflict, a hook in which I could attempt to "recover" the
situation. If that hook failed to fully recover the situation, git
rebase would fail as it currently does. Otherwise, it would be able to
continue as normal.

My use of git is pretty basic, so part of me feels like I can't be the
first person to run into this problem!

As ever, any pointers are greatly appreciated.
