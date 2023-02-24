Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A812C6FA8E
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 18:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjBXSIf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 13:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjBXSIe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 13:08:34 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A46C7A8B
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 10:08:33 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id ko13so278202plb.13
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 10:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J1oKSmw7aTANMxpm389XKDI5BTiGtxZLRb2uslPiJEY=;
        b=VBKVZxtAvSmsZHnLd5YQSGIOVGlL3C/2OfqwnFHrTvTX5+jZoHCyV3b0oJ+Sxxk9F1
         YShIqwQnKAxFzPWtJrpFG56inMpPeW/qIhLFO7v/MWbRYGVwIZm8Ich02ye5v33NOUDo
         DF8TP9RLk0SMV8VxHEZVDpy7yGjx2MIarntc99lwYqoRJcJeiLuh7z5J+n+nnEvsLxwJ
         DwC3xOV12kcjfKlQEGIqZz6XLyj4aWvV07AMqW0WdS4dY8uHqGZydG8fH5xEt/K8lVJl
         lZ3PqMtYreqj23JuXIPWR21wovui9Si9OlwiInz+gwDj3PFr8J6RP44/aULKdJ03rreX
         l1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J1oKSmw7aTANMxpm389XKDI5BTiGtxZLRb2uslPiJEY=;
        b=VV7ussTKQMSOUIGslwFtVcEyJbeaSCO40EFpTNqnWxQ7VxFWsCGO9LRrUUhflJiJRr
         kt5UtdhJABiRAHDHuS1nyJD7S5l8ZBqhC/Xtp7FBD1gm8l4lRi+8U7RNk2lgewF1Fmql
         uW6fUtnWoJll70i/2rssLO0BK3FcmDp3FRcGTyeMOS2FvthVWu7vipcFHhOftd/6Pj0x
         qafQ/teE4tDwyx1Fhy4EX1b3AmLjj64cNN0ZHJtVtHihWoc8YSUOj73yQltk9PXHXd3o
         O+6eD/8dKUGo2FzFckyePogr/URqkeY2UldcXQD8cpsy4Zgmb0orDIulyfyThM5ECqrO
         4/8g==
X-Gm-Message-State: AO0yUKUvFQZahnP1x2TMdk321dsvBCCE97IeedEMVJ4ITa3gfW1MOo6S
        DkVErcdmsT8vkgONtm306w36FvczbCw=
X-Google-Smtp-Source: AK7set+hjFcScTkX2g5Q6Whp4V0s7hApRKtk663YNhz2TEbNZtaBURdodHEVeYGUPwAyXKMhwplDgg==
X-Received: by 2002:a17:903:2347:b0:19b:64bb:d546 with SMTP id c7-20020a170903234700b0019b64bbd546mr410106plh.18.1677262112894;
        Fri, 24 Feb 2023 10:08:32 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id o4-20020a170902bcc400b0019c901b35ecsm7665494pls.106.2023.02.24.10.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 10:08:32 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, tao@klerks.biz, newren@gmail.com,
        phillip.wood123@gmail.com, sorganov@gmail.com
Subject: Re: [PATCH v4 2/3] rebase: stop accepting --rebase-merges=""
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
        <20230223053410.644503-2-alexhenrie24@gmail.com>
        <b4be9cb3-c24b-4377-bab3-5d53035efdf8@gmx.de>
        <xmqqy1on0yla.fsf@gitster.g>
        <CAMMLpeQKJeZn4rcTJzFR-ixQXKQMT7t-BKvJqXV4o_4VM=tHYg@mail.gmail.com>
Date:   Fri, 24 Feb 2023 10:08:32 -0800
In-Reply-To: <CAMMLpeQKJeZn4rcTJzFR-ixQXKQMT7t-BKvJqXV4o_4VM=tHYg@mail.gmail.com>
        (Alex Henrie's message of "Fri, 24 Feb 2023 10:50:23 -0700")
Message-ID: <xmqqcz5z0wdb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> As Johannes pointed out, it's going to be confusing if
> rebase.merges="" does not mean rebase.merges=false. It's also going to
> be confusing if rebase.merges="" does not mean --rebase-merges="". The
> only sane option I see is to drop --rebase-merges="", or to add a
> deprecation warning now and drop it later.

If we were doing anything, then I think the only sensible way
forward is to warn and then drop long after everybody forgets about
it.

But does it really need to be changed?  I am perfectly happy to
declare that those who wants to set rebase.merges to say false
should set it to false (or no or 0), not an empty string.

Also, "[rebase] merges = " in the configuration files does not have
to mean the same thing as "--rebase-merges=" from the command line.
Can't we just reserve that strange "--rebase-merges=" given from the
command line to those who are already using it, without even
advertising it in the documentation, document and encourage the
longhand "--rebase-merges=no-rebase-cousins" from the command line
and take only the  form that corresponds to it in the configuration
file, i.e. "[rebase] merges = no-rebase-cousins".  We could even
error out "[rebase] merges = " in the configuration file, as nobody
is using such a configuration variable today.
