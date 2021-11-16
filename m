Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FFCC433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF57661B29
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbhKPJl0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 04:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbhKPJlX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 04:41:23 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD6EC061766
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 01:38:26 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id p2so41010737uad.11
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 01:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cZLZViPqV4T8sMLCYubGi1K+DuhO31+6WLWQ5ILDrs4=;
        b=gQ1L+H8wdk1gEEdAhkwwLp0PPeLJbI3iDtcBHPXtNXm4hHIgjywMviGO/q/JK8UXln
         sbH2pXugG3EdGhIcIuTQigi9Ephkt/dSUMYQxlwgIRc9kUFK8v8gRT/1WrQdT5PAa9B6
         lXLsBxkJfOW5mxWdWnSFFm+TEhm5hqN1QgNPBA4FQ7us9tmVhjkGSVrSJ9nzEMYZ0OoT
         n6lS3hz4tcPM32WOViFM6M99ZliuZj1qxCS8lEXE0ChLNuDE7QqOGhUAN7RBNYBrCzK3
         v+/8fiYPwFq9ke5F8jlj46gmVXg137t5tHH91Jo/zrqYEPbxrNQJD6YTrz2QDAkLfCca
         CnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cZLZViPqV4T8sMLCYubGi1K+DuhO31+6WLWQ5ILDrs4=;
        b=kR19QdzPUG76hlIlRkI/DkTXXzvlpMDScGgdViCAK7OXSy6jJzqt3zKufQkYW9em6Z
         5MOrKKcFeS3vttqj9RBvjbWZYjgvM6Xd4w+iRZNKgbrLvKOmldH454KXOmb9y643s615
         dySETMUif0HekY22MvEMmHFPSwCKJSXLcX+8wHCg302v2FDZu7FYmh2QJUy2XFcCyjoz
         EeHpTOYckRuKRT2Hd6Rp33alpRJSgiYTZbA/gZHqy6Mscqn2pkEKo+94GkEnOICy4a7f
         3cFq6oSqeA92Q+M9ScRQsVEqlDZO1ZTGUvN34DKx5CuoTt+IIfWc3cj4fB7KllT4HD+7
         PCvQ==
X-Gm-Message-State: AOAM533OZp4bSz+89qIpAPNyCfD91pwjlTUo3Nes/FTt6Xn4OPf5uZBs
        N5KcGB+4HjkJ/tviaN7dhQbfF0aj/CMYaA60XI0=
X-Google-Smtp-Source: ABdhPJyzR7G2qrynfw1OrxQaxpIbaKoPMjxuvbJfSPpFLLaYo34gKtGKGDFH/1Shg6p7KV3Zd32zqpTBaTKNbdoGdwU=
X-Received: by 2002:a67:3382:: with SMTP id z124mr9619090vsz.57.1637055505896;
 Tue, 16 Nov 2021 01:38:25 -0800 (PST)
MIME-Version: 1.0
References: <20211015161356.3372-1-someguy@effective-light.com>
 <20211015161356.3372-3-someguy@effective-light.com> <877dd9i1zj.fsf@igel.home>
 <211115.86fsrxqbvp.gmgdl@evledraar.gmail.com> <87o86kv6fh.fsf@igel.home>
 <CAPUEspi=r9EsG8KPvdiD-HM7Drq8ho1yjkN_c_T1e+ZeR4eejg@mail.gmail.com> <87fsrwv46h.fsf@igel.home>
In-Reply-To: <87fsrwv46h.fsf@igel.home>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 16 Nov 2021 01:38:13 -0800
Message-ID: <CAPUEspg8ZUdn+KFz35yG1k9bbfVTe1b+7=+WdMknRS1zu8VcDQ@mail.gmail.com>
Subject: Re: [PATCH v13 3/3] grep/pcre2: fix an edge case concerning ascii
 patterns and UTF-8 data
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Hamza Mahfooz <someguy@effective-light.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 16, 2021 at 1:30 AM Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> expecting success of 7812.13 'PCRE v2: grep ASCII from invalid UTF-8 data':
>         git grep -h "var" invalid-0x80 >actual &&
>         test_cmp expected actual &&
>         git grep -h "(*NO_JIT)var" invalid-0x80 >actual &&
>         test_cmp expected actual
>
> ++ git grep -h var invalid-0x80
> ++ test_cmp expected actual
> ++ test 2 -ne 2
> ++ eval 'diff -u' '"$@"'
> +++ diff -u expected actual
> ++ git grep -h '(*NO_JIT)var' invalid-0x80
> fatal: pcre2_match failed with error code -22: UTF-8 error: isolated byte with 0x80 bit set

That is exactly what I was worried about, this is not failing one
test, but making `git grep` unusable in any repository that has any
binary files that might be reachable by it, and it is likely affecting
anyone using PCRE older than 10.34

Reverting this specific commit might fix it and is unlikely to
introduce other issues, did you try it?

Carlo
