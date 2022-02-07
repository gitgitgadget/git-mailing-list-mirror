Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE590C4707A
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 15:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344595AbiBGPoE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 10:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384398AbiBGPb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 10:31:57 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C382AC0401CB
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 07:31:55 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 192so14878235ybd.10
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 07:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+EyPQtI0UT1mIDVl8OUcZsHi6I/b0utVTalaQtIekp8=;
        b=meRggsIuQ/eTXnUiaK4AAjvVzie6sEZ9hzCIsShKYM8PreGqgmUcarL0T4bTHZ9X/2
         kYvSPvZR8XwHoQEncY9cLWNT93RG3ElBdwpYTUUuDYXcsqg3AL+7N1B70xB0MmrnUKb9
         nqwO2Ddns4PAR9UIaPCpW+L6GSaAByRKBOaSEPmFjmSj/qrHFo2wng3oxjecRBiMfXwk
         nYXpjSO01j/0Rb7ZLyib9i7yM82V7K+2JiETipYwa6tfOUU5fftte1by7GyY8XoSMDOc
         KzmwBbsUQGW+sVBOJsSnnNZJ+eaxylQzqH29oSY6bZCxhyIjg0QkC+oB3oYeK+1h50Nv
         YEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+EyPQtI0UT1mIDVl8OUcZsHi6I/b0utVTalaQtIekp8=;
        b=QTSZzGhowvqw3fp0pFRKK3SzW5RnanNBo+3mjdV3nYhBsIa67jRohM1nX7ZJQRm7mh
         DtkwyCdFBUW7gaN5u1trlFS0BEZWRmz8QMXggpt+K10e4vJaQoh5XsXcBUFKj4JF6VWA
         hWYFi7DxQ84Ge67H9zRAAMoeTpR1TifA0nPcuxWFOsi97BOcJyMaPLDVqUKxyCBQFHPQ
         oFzBYUHKZaUgIJnbfpJXBksM32PzvRwKesrtNJ4kpDNMzLXM4i6WyuL959gG4/pvnBEU
         7npcLxH5ClveJOYofwFb2LxNaJlVr9rJqEZOr8rouKX6adH/Bx2hA9zxKxHFfjQKKy8h
         Ey8g==
X-Gm-Message-State: AOAM531sHuhLo9z+PsZwdaiaYYI25mlOnL0ThhJOxSo7RwgCY053SSUA
        RVWmSKftS/xKi19cLyElPTcV0kWCupKvF5I+opw=
X-Google-Smtp-Source: ABdhPJxRfKs5cKtu0jrf/NIQmOlehSUcoT/46Q5UC4JDmQayjkgEn2i65I0D41VQMVgfPFqyqwV5tCBVdpsqzCDgAf8=
X-Received: by 2002:a81:998c:: with SMTP id q134mr314144ywg.29.1644247914844;
 Mon, 07 Feb 2022 07:31:54 -0800 (PST)
MIME-Version: 1.0
References: <CAPQu=HaH+E5-t4A671GFFLMbiHo=LWP=pucxBG=tT6QjhUXv=w@mail.gmail.com>
 <CAPQu=HZu0bq0fdnhDN-r5xeQ_caEfSBe5_xAp52LA4sFGXqbQw@mail.gmail.com>
In-Reply-To: <CAPQu=HZu0bq0fdnhDN-r5xeQ_caEfSBe5_xAp52LA4sFGXqbQw@mail.gmail.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Mon, 7 Feb 2022 10:31:44 -0500
Message-ID: <CAOjrSZtfE+SyZAXkyvb3eJ+ZNvkxzqyDmuTRd5WTq4JgcmKiRA@mail.gmail.com>
Subject: Re: feature request: add a way to debug ssh connection
To:     Paolo Benvenuto <paolobenve@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Welcome to the git mailing list!

Have you tried doing something like using

`GIT_SSH_COMAND="<whatever your ssh program is> -v" git push"

as recommended in this thread[1]?

[1]: https://stackoverflow.com/q/25388499/7869583
