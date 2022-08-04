Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05D1C19F2B
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 08:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239442AbiHDIK6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 04:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239439AbiHDIKy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 04:10:54 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1686F27B23
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 01:10:53 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id j8so10243530ejx.9
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 01:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=E1FAyIOYLHKcUoapSmeT3tHlx46yDhxOmKgpC495Jcg=;
        b=ZA54i+oQBJxCZLdb/Ckz+8LLniWeZZgGTZrSwE/3wnVbwHcY4nZ6EwmSdrJYSJ5Urd
         pbG1r5cEnAbVamy85lVnkOshrwVt1MMtKlpUUyoaPS+DQvBsNgXjMvLVMJpScuLQlx7+
         RdNSEI3l+/WM9ExxxxjML+Tk2octh8oQ+JfOkyPyO0G94YKfNK3KwHR9QiRNJdkDLvHd
         oNv4kSM3a2LpnkR7+Eluc83K5BGwnrYXpwDuBtZDF/3e9FYomd/k7vajwuJNfB6QuwZ/
         RXu8ON0QOU/osGgYxyxFwPxOK1EimW1CNoLbdyo17ShbQxrenbQK+tuSxYZ+zc+LivIm
         bMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=E1FAyIOYLHKcUoapSmeT3tHlx46yDhxOmKgpC495Jcg=;
        b=vDM+JQNFFXGKaJtFbP++6tuu9frqVHu8sShos7r+sEH/+WNQMhrgjkxMH4lHA+phgb
         5ZZoNThE4lVIOKNMYHNOhuQ0ouYcFCKRZLoHsDBFk4quWL9p8KrWLubWBWj++6W9I3C0
         aVHhQPVHCr+TwOM8ZULxAwgtDFkAc6lbWWZ2vJ3ksLY3ReilIuSjU2VUZZ/F1kcu2Chm
         1Q6rw9km27aNLv4kStNO3tfUM5Eo69qQOmQpJj3OUqvDRQduF966CJyEJmaLBJ0jnd+Q
         NAsexinb1jgc5yNVWvuoBmBHgLBRtFgEkmEanO+AN3TCHs5aRH+Bvkp5+hw9/z/n6jrh
         AdGA==
X-Gm-Message-State: ACgBeo26shgm4MGfiiFXhHLpEbiJSpWA0SONqY2ki2W32oPXWnsM9/lr
        LZ/LeDTls5YGTkaUZ83pi49ui0zwMEg=
X-Google-Smtp-Source: AA6agR40I62U0H6+96z5mbBmvA4LmbznJbYka8H31mMMJO3TWkzEfLKinAlB3qxliOGbOze72fLLCw==
X-Received: by 2002:a17:906:93fa:b0:72b:146f:71b7 with SMTP id yl26-20020a17090693fa00b0072b146f71b7mr534430ejb.413.1659600651212;
        Thu, 04 Aug 2022 01:10:51 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ky12-20020a170907778c00b0072af930cf97sm70051ejc.115.2022.08.04.01.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 01:10:50 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oJVwP-009gVB-2A;
        Thu, 04 Aug 2022 10:10:49 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Th=C3=A9o?= MAILLART via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Th=C3=A9o?= Maillart <tmaillart@gmail.com>
Subject: Re: [PATCH] rebase: introduce allow-inline-reword option
Date:   Thu, 04 Aug 2022 09:57:15 +0200
References: <pull.1228.git.git.1659422389830.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1228.git.git.1659422389830.gitgitgadget@gmail.com>
Message-ID: <220804.861qtwe8dy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 02 2022, Th=C3=A9o MAILLART via GitGitGadget wrote:

> From: =3D?UTF-8?q?Th=3DC3=3DA9o=3D20Maillart?=3D <tmaillart@gmail.com>
>
> This new option (false by default) for interactive rebase allows users
> to modify the subject of a commit directly in the todo list, when they
> select the "reword" action.
> If the option is enabled, "reword" is selected and the subject has not
> changed, then the default behaviour is used.
> It also introduces a test for this specific option, and a related
> function (set_inline_reword_editor) in the lib-rebase.sh to use a
> simpler custom fake editor to be able to modify the message part of the
> lines in a todo list (in the most simple cases).

I won't repeat what others have noted (e.g. reference to earlier
discussions).

Just an observation: When I use "git rebase -i" I use Emacs's
"git-rebase-mode.el" to view the resulting buffer, it has useful
shortcuts. E.g. M-p and M-n move a line up/down, "c" is pick", "r" is
reword etc.

Now that mode can mark the whole buffer read-only, there is a way to
insert into it, e.g. with "y" to insert a <rev>, or "x" to insert
"exec", but those bring up an interactive dialog.

But there's nothing that e.g. would warrant search/replacing the whole
buffer now.

It's no big deal for an Emacs mode to add it I'd think, just worth
considering what we're pushing to downstream UX's.

>     If the user only wants to modify the subject of a commit during
>     interactive rebase, now he can choose the "reword" command and change
>     the subject directly in the todo list. If "reword" is selected and the
>     subject has not changed, then we use the default behavior. Here is a
>     demo https://asciinema.org/a/T9tEmUjjl4dyDuaXalPzXNzo1
>=20=20=20=20=20
>     This is probably not the correct way to implement this new feature, or
>     perhaps it is not desirable, so I would like some feedback. Thank you

Wouldn't another implementation of this be to do:

	exec EDITOR=3D"..." git commit --amend

Where that "editor" is a sed one-liner to s/<first line>/replacement/?

I don't mind this feature per-se, but I will observe that since I
started using git-rebase-mode.el its keymap has gotten much more
cluttered over the years, as we've added more special modes (and it has
maps of its own).

I don't object to it, but wonder if we couldn't add something that's
more generic, and wouldn't require e.g. a
--allow-adding-a-new-paragraph-after-the-subject-that-is-already-there,
i.e. some users will want to reword the subject, others want to add a
signed-off-by.

For the SOB case we already have:

	git rebase -i -x 'git commit --no-edit --amend -s'

Perhaps we could/should have instead:

	git commit --amend-subject

Which would allow you to do:

	git rebase -i -x 'git commit --amend-subject -m"new subject here, does not=
 touch anything past the first \n\n"'

