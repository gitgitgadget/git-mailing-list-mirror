Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0594C433E0
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 17:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64F5D22B2C
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 17:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbhAJRZA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 12:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbhAJRZA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 12:25:00 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60B2C061786
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 09:24:19 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id p187so15293656iod.4
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 09:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=mtcgCnBnMA/dl4QAsVo3oHghR6H+6iefIP7W96v6dbs=;
        b=dx5JwRgFMKvvcaMrrusGsIHMMTiGvpb9n17tt0Q6h7oA+4YDPynd/n1QY0a4pU8T9W
         rQdLteYtJpQGZN0A05GvkiqJdj2Sq79f0/3nH3dtl2QGRZOhzgeLt9U69eX3UrzirCWP
         dVEfhYXOlNl2EZW7WHu72T3k4hfRQcHwb0lxBlF2IzMVkZF094PnMCwupJ2KmNz89HPt
         i6rxLaUDBrZcjUjiiufjaVjo0GOuZsW5wAZ80Ibct7Oorb7YxXCs/dxgrmLU0FMyQWvC
         9IZooGGOXgr/xrmhDvT2oSNUdzVUmVcOXUE/i166ZH1qsbUH2ArcfzSoOXVTrIEVhVXb
         hMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=mtcgCnBnMA/dl4QAsVo3oHghR6H+6iefIP7W96v6dbs=;
        b=s2IA4nlaL3VjTUp5dl/K9z/tH5mwo8eb4fGVnk1UcbvzXQFaUK6JfvIg5QTGZ67rC2
         oREKJOBMz3se4h4CL+aZXMM3qRqRRt+XIZy1L6I4swcLKUxxAXRpe5TLBVRt5IicOeOO
         njlFkIqdaFy2agA+AK6Ndwpr4m64A2iCIQAAYkyMFd9CNACzeCbeKY0mHHvNdAvA0hIA
         6SA2b0d9dHIKKBcKM8ZhJSTAup4Icn7p25RSh4vOElvaOhKke6DikG4EK4jIZrI5yQ3/
         yJW29BRdMpuNmFHPc/C01XbtKFr3iGCuK9CTxKXY/Kf4+Jz0bFtpVbVjCy/7z5oxO1jQ
         RfIg==
X-Gm-Message-State: AOAM53003OdJ8aBzqxHSBZFKlo2Wvo5O8PbgVTJh/Pq49O/JFl257NuK
        TCG5NIH6LRSIXRn5DumQjB39X59jkUbiV8740QxwhJoC
X-Google-Smtp-Source: ABdhPJw4xQIuNncqtijFaRsvOZ4jRTX1qjIRHmpQddrS27JJWVRlyc0sKhmBrzOIk6SHF3LaGTC7zRIcnoVPKU2UkLo=
X-Received: by 2002:a05:6638:c8:: with SMTP id w8mr11575253jao.75.1610299459336;
 Sun, 10 Jan 2021 09:24:19 -0800 (PST)
MIME-Version: 1.0
References: <CAH8yC8km6mHsrCD6sW+Z2ERpyO_X8Xp6fJbYKV+JF2gaqYakgQ@mail.gmail.com>
 <4d81f0f1-66eb-2aac-4eab-dc5508d161b1@mail.de>
In-Reply-To: <4d81f0f1-66eb-2aac-4eab-dc5508d161b1@mail.de>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sun, 10 Jan 2021 12:24:08 -0500
Message-ID: <CAH8yC8kdMhCU2WzvCU==dmm8n3+ci2+0Pg_DBF2Np-X+ZKTfgQ@mail.gmail.com>
Subject: Re: Git 2.30.0 and failed self tests
To:     Stefan Moch <stefanmoch@mail.de>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 10, 2021 at 12:09 PM Stefan Moch <stefanmoch@mail.de> wrote:
>
> Hi Jeff,
>
> Jeffrey Walton wrote:
> > I'm seeing some failed self tests with 2.30.0 on Fedora 33 x86_64
> > fully patched. They seem to be centered around email.
>
> I cannot confirm this on the same git version and platform:
>
>     # passed all 174 test(s)
>     1..174
>
> Christian's suggestion from your other thread about running the test
> with the options -i -v -x should also help here to give more
> detailed error messages:
>
> https://lore.kernel.org/git/CAP8UFD30et-kL8dFoWvh7aPf4AKbzGxSzTuA=B3YNHZL_1axFA@mail.gmail.com/
>
> >     *** t9001-send-email.sh ***
> >     ok 1 - prepare reference tree
> >     ok 2 - Setup helper tool
> >     ok 3 - Extract patches
> >     not ok 4 - No confirm with --suppress-cc
>
>
> Since the tests 1-3 do not call git send-email, but test 4 and most
> of the following do, I suspect the system is missing some dependency
> packages needed for git send-email, probably mail-related Perl modules.
>
> Installing Fedora's git-email package is probably enough to fix this:
>
>     dnf install git-email

Yeah, I think I yanked exim out of this machine a long time ago (or
whatever smtp mailer gets installed). It faces the internet and I did
not want the additional attack surface.

Let me run that test manually.

Jeff
