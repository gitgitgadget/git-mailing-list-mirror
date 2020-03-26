Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9991DC43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 06:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3AD20714
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 06:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDmbn7iG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgCZGcn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 02:32:43 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:36484 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgCZGcn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 02:32:43 -0400
Received: by mail-oi1-f179.google.com with SMTP id k18so4593171oib.3
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 23:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8bAWs1QxaJVa/3Z1ZCKHwHxNQWYFRY0Q66HjWfMscPo=;
        b=oDmbn7iGPibwisdT1+xObghtyWT2nkpk33OB2J/IfQCS0D+86m/oOHEJj/Aqo8RF2a
         aMW1mgA+K/000wb4IW7oQIVAyOhvVdC+bInIc7QIombgnXo0B9d++b7etLJCoeCfKn60
         kfd8eM0m9bFcUyZRR47d/DxolkByzNRfbBWITuE+zPe6RNFUr0yKg1nZcWCwPrLTKJMc
         P5icBg8I4JiBuVrS+4xruqUXJqMM6UpMyRy3RUMyd849IAeQc8BZdyqBl0InrME0qzGj
         Fu/vjnJ0nkLLg3VIADHvQHX2TQc9/QHTUon5pEJEJX1bHzAHX5jORlGEAa1Qkl6QW4+8
         6Fsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8bAWs1QxaJVa/3Z1ZCKHwHxNQWYFRY0Q66HjWfMscPo=;
        b=tSLyy4xBWO7ZsrWxKa5Ee87pdNjdix4mvyOR7B3z/PNIKpVSKYmMtlKs2JvkDROxX7
         PtWI2ZFWT4wjph8oygdxsUtlmcqyvMDXRIABoq0o6NAMGMY9InR3+jhriAWqeKBpgUNy
         G8IFIUU9EfLK6pJIj9ePtvm60l2/kd9L01ES+odC796dyxZNtlJSenLJTWPInMEWtEew
         PINIsnxrmOSFufchVxSGeovrabVtz1Hr6eULFzEp+eVkUq/FUaWwKZAOAwoyR9LMGWpR
         HTUsV6kqA485R3PcwlidZaGV4uOoHeIMMNMh0WLF/8FtJ0UfDpfS0QfgE4ZR5fIDcNGA
         rJbQ==
X-Gm-Message-State: ANhLgQ1SpJ7pTwzGEx+4ykYzWLHiK4GBlmuaO1FtVUz4PqbwcaQ5zbla
        7pvZTlGZqoLxERP/yg+AoC7dFOnQiwkBHGMsnOg=
X-Google-Smtp-Source: ADFU+vuMV5Uc/LxH1MBits6RGZ2xOUL69SjBgbl4EWXwBzBz7/JiDYFuljQt2xcS/FnqppHxatXGB5BXlwqArN0Kus0=
X-Received: by 2002:aca:dc45:: with SMTP id t66mr832892oig.39.1585204362255;
 Wed, 25 Mar 2020 23:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAM+g_Nuu2jGuNwUMS3j8=EjOrthYzfVTrUzOxQJ=aYcoBAL3Tg@mail.gmail.com>
 <20200325053908.GC651138@coredump.intra.peff.net> <CABPp-BF9LDfaw8=S4yqtuZ5U70Jcj_yZHq17Y7SUa17DwRqMSA@mail.gmail.com>
 <CAM+g_NtHC5ukU3jchVfud_H_m_h29UQ8vmwQoND8s_Q9Hv70Fg@mail.gmail.com>
 <CAM+g_Nvt3X4d5cjKajzDOcoDgNS4bVkj3a0KvVm4yDEW-J7v2w@mail.gmail.com>
 <CAM+g_NsUfw6zDRj8H1VNdheKFSHgC9gz7nVy0vbtpTKkYzjjtA@mail.gmail.com> <CABPp-BHMMw+L6fgfdVEEXnhH0w0aK6KfKA9Aq+aSuzWD0Cgr8g@mail.gmail.com>
In-Reply-To: <CABPp-BHMMw+L6fgfdVEEXnhH0w0aK6KfKA9Aq+aSuzWD0Cgr8g@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 25 Mar 2020 23:32:31 -0700
Message-ID: <CABPp-BFMN+pnOjEe2tZZJp3_Noojn5j1ip3dh8Xz9hCZoKJbxw@mail.gmail.com>
Subject: Re: "git rebase" behavior change in 2.26.0
To:     Norbert Kiesel <nkiesel@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 25, 2020 at 8:37 PM Elijah Newren <newren@gmail.com> wrote:
> Now, when I try to duplicate, just for fun I added some 'die("You ran
> a merge!")' and 'die("You ran a rebase!")' lines early in
> builtin/{merge,rebase}.c, just so I could verify what was run.  Then I
> tried to use a command line similar to yours:
>
> $ git -c rebase.backend=merge -c pull.rebase=false -c
> branch.master.rebase=true pull
> remote: Enumerating objects: 5, done.
> remote: Counting objects: 100% (5/5), done.
> remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
> Unpacking objects: 100% (3/3), 250 bytes | 250.00 KiB/s, done.
> From /home/newren/floss/git/testing/pull-rebase-orig-head/repo
>    c911eef..2ccdb90  master     -> origin/master
> fatal: You ran a merge!
> fatal: You ran a rebase!
>
>
> Say, WAT?!?  This attempted to run both a merge and a rebase?  That
> appears to be yet another bug.

From git-pull.c:

    ...
        if (is_descendant_of(merge_head, list)) {
            /* we can fast-forward this without invoking rebase */
            opt_ff = "--ff-only";
            ret = run_merge();
        }
    }
    ret = run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);

Perhaps that comment should read:

   /* we can fast-forward this using merge and avoid rebase...but then
run rebase afterward anyway! */

Whoops.  Perhaps fixing this is a good micro-project candidate?  Too small?
