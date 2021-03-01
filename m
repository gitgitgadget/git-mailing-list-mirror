Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0255DC433E0
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 19:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B661860C3D
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 19:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240278AbhCAT0X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 14:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240644AbhCATXt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 14:23:49 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55379C061788
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 11:23:09 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id c10so3858007ejx.9
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 11:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=47l/XLML2881K5Wcwa1B1IvSWkjRHI5DEXkkloF6MEw=;
        b=NsH90o+7hPcotoJ0zp/UV3049jbF6AGi9zZf1HB4W1Mlo9GYkpq5zVKxLufFu0UzOF
         z+bFaT9p53yMGgBkFQUfwKtrHGGrdqvajm80ND3tIQ5kxDMNpMKPPh/dVwDbjG6PNkLI
         tFDZeGx2gmen1gpIQZu4OXuWKh+miv/uQz8hlX1mg9sjmfxkSPoTfGkWvav0+NOdtPrF
         0Mimw7M907az7DWVR7XfJqEMnGy2ewT2Kv7pq+hkYgnXogsE6uaonyibFtzh8HURWbZs
         SUYFFYL94r1dNZEKBVyt3PpHGdzH4BzWeH02lDR5U16KpS975Ncz94/r72MDax5p2zsk
         0mCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=47l/XLML2881K5Wcwa1B1IvSWkjRHI5DEXkkloF6MEw=;
        b=kqIg+GeadjibM5xPClx/IMaOGiByhj2bKLnLkQeU9M+biIJPVepbQKG5e+SUrtG8Ej
         GOABiBs5muNXHq3wcV2xAMvEU0OrkmB7QZCPLVDocEVsrkads1qhnvbtry8sbMy0dele
         T5TCn0AXnbB5+cdwDZYaeNfMm+PgQigYmhZu/6UxP+LKj377r0140RYk4t4i4A7WbjuQ
         9DjF/r+5BxDHSPA5/ZR/P1PrbRoQ5ZJSPthGjGcsBBpk7swQyF6oKytG3wkfBqNsIKZ+
         3kow79ZonRNeZzTpP2wPmXhBdPJn2RSmzMhHnee14uWXNmQDw8UFkyBOEKznGUPLSEHX
         h1NQ==
X-Gm-Message-State: AOAM531XQ5yZCujlGh2WXvXkoHg03DL+nb5BYhWWZFDqz+Sv6oMQOhAy
        +n6C4fd5yDQE28Pq2sf2JxjT9QYAbvQwE6eeNny5p+mPWRs=
X-Google-Smtp-Source: ABdhPJw59xEejir2Qb5ezlPsOc4YWbCFWi455NiFIpV2UdXxXHkyj5I+PV8zcA4+kp3w6aIkt7si3s8OSwICqot0R7A=
X-Received: by 2002:a17:906:c455:: with SMTP id ck21mr17763106ejb.354.1614626588038;
 Mon, 01 Mar 2021 11:23:08 -0800 (PST)
MIME-Version: 1.0
References: <fd1ba192-b90c-ef20-0843-c0e47925c76a@gmail.com>
In-Reply-To: <fd1ba192-b90c-ef20-0843-c0e47925c76a@gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Mon, 1 Mar 2021 11:22:57 -0800
Message-ID: <CAGyf7-GJQU1s4H-pgVMEc_WB3C4ehppLieT2oiyxa5B8=yyjxA@mail.gmail.com>
Subject: Re: Argument list too long when fetching many missing objects from
 partial clone
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 1, 2021 at 5:20 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> I'm poking around with partial clone. On my local server on my computer
> I have full clone of Git (git.git) repo.
>
> I do partial clone from that server as remote (which is actually on the same
> computer):
>
>     git clone https://my-local-server.git/myself/git.git --filter=blob:none
>
> Inside the partial clone, I tried to convert it to full clone. First, I gather
> list of missing objects:
>
>     git rev-list --objects --all --missing=print | grep -oP '^\?\K\w+' > .git/missing.list
>
> Then I fetched those:
>
>     git fetch origin $(cat .git/missing.list)

Since you're on Git 2.30, instead of trying to place all the object
IDs on the `git fetch` command line, have you tried adding `--stdin`
and having it read from your `missing.list` directly? Something like
`git fetch --stdin origin <.git/missing.list` might do what you need.

>
> What did you expect to happen? (Expected behavior)
>
> All missing objects fetched successfully
>
> What happened instead? (Actual behavior)
>
> Git returned:
>
>      -bash: /opt/git/bin/git: Argument list too long
>
> What's different between what you expected and what actually happened?
>
> (nothing)
>
> Anything else you want to add:
>
> I think the problem lies on how to feed list of 110K+ objects to `git fetch`.
>
> Note: Both the local server and the computer use Git 2.30.1
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
> [System Info]
> git version:
> git version 2.30.1
> cpu: x86_64
> built from commit: 773e25afc41b1b6533fa9ae2cd825d0b4a697fad
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 5.10.11-kernelorg-upstream-generic #1 SMP Fri Jan 29 12:56:19 WIB 2021 x86_64
> compiler info: gnuc: 9.3
> libc info: glibc: 2.31
> $SHELL (typically, interactive shell): /bin/bash
>
> [Enabled Hooks]
> (none)
>
> --
> An old man doll... just what I always wanted! - Clara
