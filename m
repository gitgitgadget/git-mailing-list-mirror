Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E923AC433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 09:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C41EA61157
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 09:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbhI0JeM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 05:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbhI0JeM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 05:34:12 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58583C061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 02:32:34 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ee50so66639087edb.13
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 02:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=utXtqkBaIkHCX3ZPmlNjkyYvj9hOSpWILcbIcW8GCZI=;
        b=vVZQfQOj3iOy5Flddv4W7aCtOh3HTGnITPMWfCdLqddR10l0gWFj2yFaJfzE+mXRMj
         AubjAcAwJZ1akCxj7imgnk6JQ4OiiRjEAEbWI2wfU3+M1j1ljy6YehCvoJVF0zG/WkR8
         mpUH9Pjm7NxtJMOj9sEAu/6r4VUnY6VTKSnebeJxda72o3aLhzfLhyMz6mc71CNr9FB3
         ReSU1ctp3EFTUwjiurS3h4tdBpoaPq9vVuhpZq+uqG9qJ6pBSHx+zV0npPe6JZCUYjHQ
         LSwamrybT7TcZrm/lGTTSKyb3LiX5gCD1j6ovziLCWxeiYCpIM8An7pwPN1OZ3/ORWR5
         rWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=utXtqkBaIkHCX3ZPmlNjkyYvj9hOSpWILcbIcW8GCZI=;
        b=SxNQSrohVBR3feLRk6NBbX7/45qTqgA2gs+4xwKnxASENy4wAv3hYzYAAnKN79KyLe
         rapB61PLTfSIZ2L98eqgifvhqn5Nz0WYsfqSizfkBbxh24xFrFxGVaubyy17btL6hbCG
         4Q74atUMQk9SpFdv0sUs5gz1nJRNEH/1ELKfV25DDt/pcQpHYBVKIY5CL2v6ys4ELuVz
         Dh8LHPcKLsqT038Mo/U+S/V86k739oaMvhGyQvRz/1QQ2OHm04bm8rje8uwOK7v2zOg+
         8+NOW05r1OcbATR9qOhXYh5Clnn2fnTfeOB7x31H07N6LCcYVyRQf9xEtebnh6TKqrD/
         qTKQ==
X-Gm-Message-State: AOAM532V54+hKGdr5NBw/Yqh1pYCS8pW79yk00D2rYhbhonrTl4gcYVd
        Vuqq1suFoos7tS1plgsSLRkbn/e7rvb1WC89yFqpKKrIHS38WQ==
X-Google-Smtp-Source: ABdhPJyCV7JW0vHb1clMd1WIxQznnz5n8x9KBzt+1n+Zq3JAcXuawfDBe8P8laytIDLE8fVoBLWyyUgCSwDP2v1U9gw=
X-Received: by 2002:a50:9d8a:: with SMTP id w10mr18419233ede.163.1632735152813;
 Mon, 27 Sep 2021 02:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpoj-oiD1yDHx6WS_1uiPOXMLj7FcfBPZm-q4vO30kpE_ow@mail.gmail.com>
In-Reply-To: <CAPMMpoj-oiD1yDHx6WS_1uiPOXMLj7FcfBPZm-q4vO30kpE_ow@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Mon, 27 Sep 2021 11:32:22 +0200
Message-ID: <CAPMMpoic0Dt=5Z7GB7BG7CqwxAs49SPPDkdasUPvasvsPhr-tg@mail.gmail.com>
Subject: Re: New built-in fsmonitor: messages accidentally on stdout?
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

I did track down where that message was being issued onto stdout in
git-for-windows
(https://github.com/git-for-windows/git/blob/main/builtin/fsmonitor--daemon.c),
and I see that in the the latest version of the patch series it was
already switched to stderr
(https://github.com/jeffhostetler/git/blob/f08a63e197a0efe4d8f0452893238b0d3156e669/builtin/fsmonitor--daemon.c).

The only remaining thing I can ask for, I guess, is that the next Git
for Windows release ideally include this change/fix, even though the
built-in fsmonitor is not in "regular git" at all yet?

Thanks,
Tao


On Fri, Sep 24, 2021 at 8:02 PM Tao Klerks <tao@klerks.biz> wrote:
>
> Hi folks,
>
> I've been testing the new "core.usebuiltinfsmonitor=true" capability
> in Git for Windows 2.33.0.windows.2, and came across something today
> that threw off my scripting:
>
> In general, git "informational" messages are always output on stderr;
> this caught me out initially, but is a godsend for scripting.
>
> However, with this new functionality, the "starting fsmonitor-daemon
> in 'C:/whatever" message is being output on stdout!
>
> This interferes with scripting around things like "git status --porcelain".
>
> I understand this fsmonitor stuff is still somewhat in-flux (patched
> into the windows port but not yet "regular" git releases?), and this
> issue may already have been reported and addressed in the latest set
> of patches - my apologies if that is the case!
>
> Best regards,
> Tao
