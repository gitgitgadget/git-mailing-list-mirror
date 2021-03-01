Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCD7C433E6
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 07:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E64E564E3F
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 07:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbhCAHos (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 02:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbhCAHoo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 02:44:44 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76E8C061786
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 23:45:29 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id o16so13422770wmh.0
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 23:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z9GvJuB3JQrAKVt3eAT+K0a1BLN297VwRzEUiFtgvBk=;
        b=twhTJTSJA3th+z3GaEzGwgdNxrqqVlMtdBjRVvdgvQzR9c4oUwKf6QjzF9MFiPZ328
         s7AGAa/7oyIdp5dnLF5HLMiFlg44mmKJxvONSy/JN309PHhVvdxgYIbbZVkeYsdpStQr
         Klwpaj0S+Ke0/1TtDAN/s0dHUMhDPjWt5GSLNINFr0tQKv1QG8um6ffSPUlLBMvxvFsr
         jWEtjZx0e7Y+MhNX93dXm0523aXa187iwW9z8TXHdF4iVDQlhSeyo80u4mIlm/b291zw
         OsmNnkvWIsWZWRqRhe/Xb0b5zh/+hjRUfvUl+FUtpOZIdMMCbMk2Gjptt4LOQhyEbk4d
         wGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z9GvJuB3JQrAKVt3eAT+K0a1BLN297VwRzEUiFtgvBk=;
        b=P15OlPUy2U0FO4UlJgh2J6WSNsuMQWuKqdxB4Wr4HmOCqQnleCvVptTGFyaGl7mK6M
         Y4MfL0QrkBLKtYYXkBd0vTmmZRM5D1PlnzaqBIFGojRb8gjvjANZ1orDyKcfReBDd2HK
         GmbpNpp/s6VH2C/sVNvHXt3mvw+nFfjH5rliYk2SfTuMtWM8PdmQM86TG7OehWQ04iaJ
         d5+q+VJx1Js4HBGjOgcBnsZ88jr8gN+OKONUwwKxOxKj9N+SgLM+YCnaJ69BbChKCslO
         A/t/z0LTdrfExkN+D/XvsUIdn+etMqkD/T72j5kwm8+8vVerEcfXTDzQC7BQcNVGShSr
         c4RQ==
X-Gm-Message-State: AOAM531qQZlzBOq06mwTs+4rM0Mj2NQ6G/CqPCJK5B3Y1pV/0V8RYMCC
        aZdvVeLyhkLRbzf5mdCHPCxiVTCPB7zJy0kS7TvSMJc=
X-Google-Smtp-Source: ABdhPJyNpZIOrSNeJQ/aX6eaUXl987lLSMXkDcmWEvv9ECXR3ESyysUjoD3BoSVVWil4OJogNrKh6BMH2A1EAL0vI6g=
X-Received: by 2002:a1c:2cc4:: with SMTP id s187mr14847038wms.4.1614584727285;
 Sun, 28 Feb 2021 23:45:27 -0800 (PST)
MIME-Version: 1.0
References: <CANXojcx0TOP9SSr1NgXCddQ3PWze-wBLZA5SRO3YhczqO68u0Q@mail.gmail.com>
 <20210224204007.4937ee80121aa1ed553a2d91@eigenstate.org>
In-Reply-To: <20210224204007.4937ee80121aa1ed553a2d91@eigenstate.org>
From:   Stef Bon <stefbon@gmail.com>
Date:   Mon, 1 Mar 2021 08:45:16 +0100
Message-ID: <CANXojczH=r-mugP-zJgrATG5XQUqmoqfY3zUTiZTUDDhx59oJg@mail.gmail.com>
Subject: Re: FUSE fs for git.
To:     Ori Bernstein <ori@eigenstate.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks a lot Ori.

Especially the link to libgit2 and your own 9p based git filesystem I
appreciate.
What is 9p? Is it a name or something?

Stef Bon
the Netherlands
