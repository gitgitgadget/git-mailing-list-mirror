Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFE7C4363A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 486D920770
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfRawL4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766955AbgJYDkS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1766952AbgJYDkS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:40:18 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E8AC0613CE
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:40:17 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c194so7844359wme.2
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7QU3yNcJGNX+IDKmCtYovd+vhvG6yjXr68LB6IcKlM4=;
        b=JfRawL4FoI7dpywAB7Vzv6r1A6nxG+aczevVtE3R4voacCSX6zH3LZzYoNRK0TbPxZ
         l69NB/DwkzJiSn8zcANHidKl3MKC4jirTf7uslpAV37D2bb79xACIg0AuKpwAsAonBFc
         2w02d0I2e/Stu3IVDyfi4ieIXOt0jIohbnOsmBoMlMh+S6ujrtZn96gaRVR1gUg3HGNl
         OOTLsZSFeGR9z7DNzHSvUN04eoiO5CcKTM2yP+uWbA2+1aRp4DoA4jtmTwfcOe1XxliJ
         2cA9kTb3N7nCLM7adjm85CrjCveJ1B+MTTnA4yhaLJR+KBqrUJ3REsn82hpI94zp0Gft
         lU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7QU3yNcJGNX+IDKmCtYovd+vhvG6yjXr68LB6IcKlM4=;
        b=Iz5zIwVV5E9XjKQOTgRFBgV/nAYBPRFNDSZAN+S+EzeS2srYnBINPLYiwVxvij2kMe
         Zr3b2FfEZYZdk86rwHN/TULtV2ZoKctdq6EKSoWbh5uftuKCB374h7YmN0ppE94GDAzA
         pioypt4bxQqYq6bj/XnxHyVBGVe+cc8HUXL5WGd3Thgc9E5AtnZ7EVB4HhS67XSHpCNL
         J0DY1S1iEWKaVgtwSjKD+vbl57Fb7BWZtJnea707HfJ4M+jGlAp1wAmu7gOZe7a+hoNq
         SnhB66/9rhIXzameXo4noz5HUxrBS2dHSziCztWN6PgZhzS/QBzGa22f7fOnIK2kx8Z+
         zTbQ==
X-Gm-Message-State: AOAM533D01CurP8ec3Z5D1sPnY8UrEdNksiRtj3h9tBXKA5fgXeuFmuN
        DFDwqC9qQGcojeGQkX0Ym+Baettc2e+6T8cVrvM=
X-Google-Smtp-Source: ABdhPJyCSsCmz7wonnCSsOC1nMNyBdR9HrOkSnxZ2zg8tTYwZPPaXnGUXqZa4do9XhMEJAfkqHX+CMyykjWYx2lNpJs=
X-Received: by 2002:a1c:de8a:: with SMTP id v132mr9422328wmg.173.1603597216515;
 Sat, 24 Oct 2020 20:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.367.git.gitgitgadget@gmail.com> <pull.367.v2.git.gitgitgadget@gmail.com>
 <3f994f3b9a49c42bb8b605459817e54479327dc7.1570816467.git.gitgitgadget@gmail.com>
 <20191014234439.GT29845@szeder.dev>
In-Reply-To: <20191014234439.GT29845@szeder.dev>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sat, 24 Oct 2020 22:40:05 -0500
Message-ID: <CAMP44s3UA-eVGJ1fwYwQCaJEKaD4MzDWds311bhdNPb1WFy01A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] doc: Change zsh git completion file name
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Maxim Belsky via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>, Max Belsky <public.belsky@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 15, 2019 at 3:22 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:

> Instructing users to copy our completion script to
> '~/.zsh/git-completion.zsh' goes against this convention.
>
> More importantly, it appears that this is more than a mere convention,
> maybe a requirement even; at least renaming our zsh completion script
> to follow the convention (IOW following the current install
> instructions) makes it work all of a sudden:

It is a requirement. If the file is not named '_git' it will never be
autoloaded. The whole point of naming it that way is that it's loaded
after typing 'git<tab>'.

--=20
Felipe Contreras
