Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8DBC433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 16:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbhLHQpG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237153AbhLHQpG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 11:45:06 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705F9C061A32
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 08:41:34 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id l25so10265261eda.11
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 08:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FHUjyg5u6Zim6oUaOQoOpWKkZNuCxFUU85z/Myahz7Q=;
        b=HDVkWFlADoqu04H/Co8oqb3lSTQTT02RSLll/UODJt2wl0ajSzWtUtCavm21q/AjW3
         ODGXkcVy6C6tTHWm3PhBTtBW0oUqZes5wWpBru1lwD/RIFdau0bmUIbpq4BmTY3ch403
         o8e6sUa7/EIq3a4kzo7rK9Qcj7ugRKM9YNpDFKcrcOhdqSCqZ1T7z2LG0tnhxmFsJ4KM
         ZxgVQXkse4Av5gq+/lzh8VebHPu7bFnwSUz8r5hBHaihDq95D1hxhY1Hm4gkePavg504
         zwY3bW/wVRfEBv4r1Loffy82aENa4ZzeB0FRCmiREBD+ihYuhD6hWtrysFyKBWgzviwf
         7dfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FHUjyg5u6Zim6oUaOQoOpWKkZNuCxFUU85z/Myahz7Q=;
        b=sNFEKjVUbty+S1J7V+6LCyxaNCw39MoRVdnUy0XAx+qrgvKroWU1ebqrbyjRjYGXjo
         PITY6G7GDnoifrH+MGf3+CD6Gj4o0ko+74tZ1R4CEwrU5OAI+3oeYYzhpqAaaSCWuZhz
         TOCe9/eN3yR6SDQ5zp23LF7RTLoi9g8fpST0aVRkVOyjiM9xCjjHEQ5BTKIH78fAVlWA
         29VyuIEoOny44nsGtcWsthW6/8Fmiid+Qce5dCQN94RxGZ9XBlYD8a22hEwopCPlXAHt
         LuEX8coZWlsxfRXr7xQQ8NdEyINzAooi5njhLxW+chsMG1K7jDR2Fx9XOTSp7fgFfgcz
         2swQ==
X-Gm-Message-State: AOAM533pXTY9xA8K5h8wNmegRgGNi+yhE9dbDWHqWOByiwIg1AVNu7FO
        QbRJ4ydAHpwjseSteJ965OGb48p3fbUeXIuLEzY=
X-Google-Smtp-Source: ABdhPJwpjtKpLQa/IkyXmzhVyp7ekN/ZT8nmGaAjmbeHyhpSbS4UDuJlEiqOcCZpl8MPm4dSbBcLvVd6RVpqV75zNCA=
X-Received: by 2002:a05:6402:1014:: with SMTP id c20mr20791286edu.186.1638981692719;
 Wed, 08 Dec 2021 08:41:32 -0800 (PST)
MIME-Version: 1.0
References: <pull.1091.v2.git.1638750965.gitgitgadget@gmail.com> <pull.1091.v3.git.1638828305.gitgitgadget@gmail.com>
In-Reply-To: <pull.1091.v3.git.1638828305.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 8 Dec 2021 08:41:21 -0800
Message-ID: <CABPp-BEJbS=5i+d-Aa_fCH-WAjSOhX+nSZk5Q9Kb6RiizFg7ZQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] ns/tmp-objdir: add support for temporary writable databases
To:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Neeraj Singh <nksingh85@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 6, 2021 at 11:18 PM Neeraj K. Singh via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> V3 (hopefully final):
>
>  * Fix the commit description for patch [2/2] to reflect the fact that
>    disabling ref updates no longer depends on the_repository.
>  * Add a link to Jeff King's test case in patch [2/2]. The test relies on
>    remerge-diff, so it can't be directly included here.
>  * Adjust line spacing in update_relative_gitdir (gitster)
>  * Switch struct object_directory to use full-width integers rather than
>    flags (gitster)
>  * Fix typo s/protentially/potentially (neerajsi)

This version looks good to me:

Reviewed-by: Elijah Newren <newren@gmail.com>

For future reference, when splitting one of your series apart, copying
the relevant subset of the cc lines (e.g. from the description at
https://github.com/git/git/pull/1076 to the one at
https://github.com/gitgitgadget/git/pull/1091) would be helpful.
