Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665AEC3DA78
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 02:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjANCsD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 21:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjANCsB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 21:48:01 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9747481407
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 18:48:00 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id x37so24274782ljq.1
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 18:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qx4u9tJ7ha1a4pwvspoDgW5lN/JGcV7YD5hkxMRl0XA=;
        b=n+oFQ1KIHWkyTHiB6ql9bUXa0phorh23TDe2Mg1DuEldIMljxh7NK8w5ePRC6wJVGv
         Y7xmnbx0wU7Fg6LiVawlObBeVGJTCY8okprHizjMGwbFQd2Mtw8WC5oCXWRjhbcb8bVh
         XbYtlnZEI5iUFLKpzX8UxJO3u1cpyl21KCk9dXmkgBFCcVZXPIu88BBdQTuzqqg6wB8s
         zh4FZHcwXzAEWD3GsE3/1fOzIRsFIyMaZZNCjRglSLFCeEYZlv+qMNydkJ+6iCNeqerT
         z0Jd/I9dUjqzt3HWzhmHCISTRmnGcZCn8WBGG1yjrtEIaL/d5yLx6UbAG5jvQLF+MDD6
         reGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qx4u9tJ7ha1a4pwvspoDgW5lN/JGcV7YD5hkxMRl0XA=;
        b=E2yPLUQO5gcs1R/5S8oPJf9dwIOVt5oq/s93vBBnodoe1DqVfNCI/wXlcgIz68nmIS
         CM+g4nPhVHZ1ebhL3NOozzLjUwkHdDN8nMWlwox79GLVC0gJBdQwWWMvRauZn7yzih/9
         /azpHpUBroBv5p49gzaNJvMg+mvjc9wp4pWUBwxu9FtT9hzGX5FMRG9kYs0f/LAY98sR
         VKHzABjv4mVypbsqPeST3T1LYNBFkcGE67VReYqbfcgA++cO0xKkDuVWhCybq+CxXM1n
         5MllkTP73j1l/mnIal9WL0qJlmCp0hY/eSJ6RfLMdgXkg72o9hnKyAk5uwp71wyCrMRW
         i0+A==
X-Gm-Message-State: AFqh2kq+M/pZucAhY4uQBwbJM1xfcqxsInTE5lm8dHsJOi4uG9Y6Dbah
        ekrL81nu5TrM84TTqM4oFu0e6NgDmNs4qiLrgBQ=
X-Google-Smtp-Source: AMrXdXsCRpTcxgaSWPjTRAbY21Z77osVChIgmeVnDVOOEuwhWsLw3dipLc4tPNHPygdcs8uODclBIPeT+S6oW0FNtcU=
X-Received: by 2002:a2e:700c:0:b0:287:4e8e:2139 with SMTP id
 l12-20020a2e700c000000b002874e8e2139mr1419995ljc.73.1673664478674; Fri, 13
 Jan 2023 18:47:58 -0800 (PST)
MIME-Version: 1.0
References: <pull.1460.git.1673519809510.gitgitgadget@gmail.com>
 <230112.86pmbk0vvj.gmgdl@evledraar.gmail.com> <CABPp-BFf4pbRAy+Oaghx5d8DZgBjY_OUM-rJZna+JyNwx9WB-Q@mail.gmail.com>
 <xmqqwn5q1960.fsf@gitster.g>
In-Reply-To: <xmqqwn5q1960.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 13 Jan 2023 18:47:45 -0800
Message-ID: <CABPp-BFcqXp2XL_4urbXRfdBs59F6cPkLYrdwZOWyQjzeZVRFg@mail.gmail.com>
Subject: Re: [PATCH] rebase -i: allow a comment after a "break" command
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 13, 2023 at 12:17 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Of course, the same applies to edit/squash/fixup/reword, though if I
> > could go back in time...(warning, long tangent coming)...I would make
> > it so those four directives did not accept any commit ID argument.
> > Only "pick" and "reset" would accept a commit ID.  Instead, today's
> > "edit X" would be two commands ("pick X" followed by either "break" or
> > "edit"), "fixup X" would be "pick X" + "fixup", and "reword X" would
> > be "pick X" + "reword".  That'd help users understand rebase state
> > much better (it's so easy for users to get confused by whether they
> > should be using `git commit --amend` vs. `git rebase --continue` and I
> > think this is partially to blame, though there's other changes we
> > could make to help with that dichotomy as well).  The separate
> > directives would also make it much easier to figure out how to both
> > fixup and edit a single commit in the same rebase (pick the commit,
> > then add a fixup directive, then an edit directive).
>
> Intriguing, and I feel sad that it probably is too late for all of
> the above X-<.

Yeah, I know.  One more thing for the "if we had a time machine" list...

> > In fact, "squash
> > X" could just be discarded as superfluous, since it's just "pick X" +
> > "fixup" + "reword" (or we could keep squash as an abbreviation for
> > both "fixup" + "reword").
>
> IIUC, your "fixup" is
>
>         git reset --soft HEAD^
>         git commit --amend --no-edit
>
> i.e. discard the log message from "fixup" and use only its tree, and
> your "reword" is
>
>         git commit --amend --edit
>
> so "pick X" + "fixup" + "reword" would not be quite usable as a
> replacement of our "squash X" (or your "pick X" + "squash"), I am
> afraid.  You'd want the log message from "X" as well as "X^" to
> edit the replacement of X^.

Oh, good point.  So, in that alternate world we'd still need a squash directive.
