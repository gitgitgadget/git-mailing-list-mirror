Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2681C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 18:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245646AbhLJS5o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 13:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245641AbhLJS5n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 13:57:43 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE138C061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 10:54:07 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id v1so33228341edx.2
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 10:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qqQhZ+k1OoEBYbWfBG0/KwLeKM7aDYL+iNEYeoDyZOo=;
        b=Ayxiccsq0HUZy6/eIcDRKPsVSTFeV02gm/AKCkkxQATZMZ/zaRn7jZFU2WO4ZtLMFG
         TIrALrVZIRMeaexuS1L9DeFD+fC87icZWoB2QisjZBz72MbsC/UcvmNpluphLH3a2gIQ
         cw3XTF2Yt2cV8TzZS3RYMSsXJSgSD/kfmws4jcDIHZEph8EKu7HY/7wJJo74zDng0CB7
         OvEgOqgn6CzJ6A/qHjAyMGwvew9ChA9m2tX6yDUzVye7s1Wv3FF4afAMHIuevrwhJyae
         iLlZ8NkbCP/2Xiys0KIGf9hVgenEDc7LprmEZwvuyk1MQ0alpN/V+5ApXEM724uyP3+3
         chEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qqQhZ+k1OoEBYbWfBG0/KwLeKM7aDYL+iNEYeoDyZOo=;
        b=1lm5qkdWveF+Zv/WMvcgVM9pUOGZZsXilXKWzQ7qAcZ7Qd9l2KYQsLfVpYa8MQrb4V
         0YkkgcNoyfiZP8n0TrIAwj2uch//g9CDIsHbm+GSyvR5VO0DsJNUuYEnM0NikmPjdBIy
         ffnq4eXzS8jH3GzcwaDBsFOm68YRNB7++iW4e6FVqaIR9g9I413gkjNY8DQCYexbtzyq
         R73IWlX3ziMnz8HMMKINhOnzniGZth47CsnfLF50jEXJeBfuPUuVIGY5vXfbloH77SPK
         cppmaqeeai8MkyAHv8Os+9SFrNTzscD5xwRHLWBZx5vpb3rxNTksdhUpUKDe+bzEfpZo
         J0Vw==
X-Gm-Message-State: AOAM532fe9pJg854hEd6e8z4eRkoEyuS2STEpdS5/MJHhdC09r5RGuoV
        IuwxpWKxvyCOcBBYBT9UH7j/a1HxXOfE8mtF008w+7+BKcE=
X-Google-Smtp-Source: ABdhPJw8rYO/wFkiLrRFdZzMbJcJJeA37FsrP3Z6i2aLYygexDRuaWfC0/70n72fLVOq7/48+Kzhvf8GJPbPXGcG+tI=
X-Received: by 2002:a17:907:3fa0:: with SMTP id hr32mr25984878ejc.443.1639162446207;
 Fri, 10 Dec 2021 10:54:06 -0800 (PST)
MIME-Version: 1.0
References: <pull.1080.v2.git.1638992395.gitgitgadget@gmail.com> <pull.1080.v3.git.1639149192.gitgitgadget@gmail.com>
In-Reply-To: <pull.1080.v3.git.1639149192.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 10 Dec 2021 10:53:55 -0800
Message-ID: <CABPp-BEs5gnX+HfPNMRBqtMdhVfkk5oKDT8sN4fJiPG87JDjcw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Sparse index: fetch, pull, ls-files
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 10, 2021 at 7:13 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This is based on ld/sparse-index-blame (merged with 'master' due to an
> unrelated build issue).
>
> Here are two relatively-simple patches that further the sparse index
> integrations.
>
> Did you know that 'fetch' and 'pull' read the index? I didn't, or this wo=
uld
> have been an integration much earlier in the cycle. They read the index t=
o
> look for the .gitmodules file in case there are submodules that need to b=
e
> fetched. Since looking for a file by name is already protected, we only n=
eed
> to disable 'command_requires_full_index' and we are done.
>
> The 'ls-files' builtin is useful when debugging the index, and some scrip=
ts
> use it, too. We are not changing the default behavior which expands a spa=
rse
> index in order to show all of the cached blobs. Instead, we add a '--spar=
se'
> option that allows us to see the sparse directory entries upon request.
> Combined with --debug, we can see a lot of index details, such as:
>
> $ git ls-files --debug --sparse
> LICENSE
>   ctime: 1634910503:287405820
>   mtime: 1634910503:287405820
>   dev: 16777220 ino: 119325319
>   uid: 501  gid: 20
>   size: 1098    flags: 200000
> README.md
>   ctime: 1634910503:288090279
>   mtime: 1634910503:288090279
>   dev: 16777220 ino: 119325320
>   uid: 501  gid: 20
>   size: 934 flags: 200000
> bin/index.js
>   ctime: 1634910767:828434033
>   mtime: 1634910767:828434033
>   dev: 16777220 ino: 119325520
>   uid: 501  gid: 20
>   size: 7292    flags: 200000
> examples/
>   ctime: 0:0
>   mtime: 0:0
>   dev: 0    ino: 0
>   uid: 0    gid: 0
>   size: 0   flags: 40004000
> package.json
>   ctime: 1634910503:288676330
>   mtime: 1634910503:288676330
>   dev: 16777220 ino: 119325321
>   uid: 501  gid: 20
>   size: 680 flags: 200000
>
>
> (In this example, the 'examples/' directory is sparse.)
>
> Thanks!
>
>
> Updates in v2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  * Rebased onto latest ld/sparse-index-blame without issue.
>  * Updated the test to use diff-of-diffs instead of a sequence of greps.
>  * Added patches that remove the use of 'test-tool read-cache --table' an=
d
>    its implementation.
>
>
> Updates in v3
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  * Fixed typo in commit message.
>  * Added comments around doing strange things in an ls-files test.
>  * Fixed adjacent typo in a test comment.

Thanks, this round addresses all my previous feedback.  However, there
are two things =C3=86var has brought up that I think are important:
   * cannot rely on `diff -u` for portability reasons[1] (his
suggestion of git diff --no-index sounds good, or you can use comm(1))
   * have documentation mention the trailing slash that sparse
directory entries are mentioned with[2]

[1] https://lore.kernel.org/git/211210.86zgp8bi48.gmgdl@evledraar.gmail.com=
/
[2] https://lore.kernel.org/git/211210.86v8zwbev9.gmgdl@evledraar.gmail.com=
/
