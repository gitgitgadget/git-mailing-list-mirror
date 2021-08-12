Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69755C432BE
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 04:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 496B460F57
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 04:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbhHLE7R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 00:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbhHLE7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 00:59:16 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7D6C061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 21:58:52 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id b26so49082uam.13
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 21:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qj4USLU5J8iSQumGwqeIgGXtx+EqbQa0HV0Kdt/SReM=;
        b=Sq82DEARpVtwDxGsgLdsoenE1A7W98tVtwlUUebrgjFgwZNdRKXlonLR8gQayTxHCz
         LGuofTlf0PjSgamhyLHqDcztU1Emx2KCDeDT++5RIukFEAkk/9iO/DM18i7OLemW8jya
         CnW3lFmrd3QkLsnyKyk3kWiCexRJGdU5ho9g2mVGbw3Rp7fqiAeUP25XmwVt3f1o3SqS
         80wjdXd+X9sCCC8GZIN1AsXUzgm1zuKZ3HLj3tpMpo+xvbUBzkI8z5x+eAiPnGEMpdqH
         tycJrKpqPUsryLVQTdwAGPJpnzhsWHAystBdgungKsd4GZbnoJI/gqq/qdkWci2xaVjG
         LoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qj4USLU5J8iSQumGwqeIgGXtx+EqbQa0HV0Kdt/SReM=;
        b=oJ72SCSMvNKOJdQEPI/DQf3UkZzQGes2uDMMFSCRA5VpgBgAapWlP+0d5h9jVSm2lg
         i2llI5t2tmY4etRksS2yijcf7gpT17o42aZsWDAKCMSmEdfQ14CPywGXXUZdNAwLXnik
         3/X6oXlmuKvtPWT4d4PZ1Z7GrZIaCjhbdMwSHZ9Z5Ll+esHjhFG2p0ILVzYgDPY3yVby
         /2kdqFfeptXS/hU/PLQ2J2/Xvey7xUKCAw8EPomNsEPHB57tmUH1kM0c4E4PpKpDdBiC
         wQ2U72Fl04RaCjwkWzqqkW8O59CPrBdrh6ErOexxQ/lFUdAujjONB9IeC0Be5Lz9zqPU
         XLkQ==
X-Gm-Message-State: AOAM533kd/FCmOELD+lVdfb/zI26WUjR7N9MPVaAbGm7gXoTHXfYMdo1
        bNrZFRUlGmaEdCp8E2zitrWlA1IZHuyk7f2IkgI=
X-Google-Smtp-Source: ABdhPJzo6RUIWV1LoLT67x2WnSritiXIGWeZgwcKSzwvmcm92df8/AYGv2d+DyO6K5DeOd6snGfkYhUcQBWqJEhQhk0=
X-Received: by 2002:ab0:1e08:: with SMTP id m8mr827147uak.140.1628744330970;
 Wed, 11 Aug 2021 21:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <trinity-1ab86a7f-c1b8-4934-9b31-861a78e15889-1628689643260@3c-app-webde-bap05>
 <YRRJMexgc3TTTN2X@google.com>
In-Reply-To: <YRRJMexgc3TTTN2X@google.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 11 Aug 2021 21:58:40 -0700
Message-ID: <CAPUEspgQ6kq9qb4qiwA_UJqNWEohBv82_9U=tNvqdmFnr9_j1A@mail.gmail.com>
Subject: Re: Git GUI does not start
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Gerhard Buch <Gerhard.Buch@web.de>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 11, 2021 at 3:05 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> /usr/local/git/git-388133509.245/share/git-gui/lib/Git Gui.app/Contents/MacOS/Wish: cannot execute: No such file or directory

This looks like a broken deployment for whatever that
git-388133509.245 version might be coming from; `git gui` works for me
in macOS and the application builds/install fine when doing `make
install`.

that "missing" file should point to the system wish binary
(alternatively accessed through /usr/bin/wish) in:

  /System/Library/Frameworks/Tk.framework/Versions/8.5/Resources/Wish.app/Contents/MacOS/Wish

Carlo
