Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA89C46467
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 15:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjAPPRN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 10:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjAPPQq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 10:16:46 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462E622A0C
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 07:06:11 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id z4-20020a17090a170400b00226d331390cso31312825pjd.5
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 07:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B6L7zBnHt6UlJxl4U+Vph+tMsfpRJsSymPrMNMUWpf4=;
        b=A8iEBNJhapjR9JpNHv8nsUW8+9lxZdPKI8Y0MNRNcaRZP9ZjDnwJDiLJ8hWgOV6k42
         g4h8qgkoSxhpH2OuyWT4kWE65/XTyFQFC6RTA97QTLIxM9zxGA4bLXzbgX+60mj17cMS
         CN+3tEj9PPUI72pIWa5y4FrjDsUPuJe8/7iigMUchPxhQ5M2Pc5IS2l1xNPG7adL5B4Q
         UOLoOnbQ+6wTTmsgNY4jgGhBXYuhZQhmZCGg17F3hoFTvJY7CrJb+HZjmQd/p7C6FtW8
         l1gHK2m1PvGKZvO7S8WQY2JE66EyB+udyFJNnYnwArg7Ow6VqCBgvxpjM8Yy1I9ZGsLE
         uiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B6L7zBnHt6UlJxl4U+Vph+tMsfpRJsSymPrMNMUWpf4=;
        b=u+ATIZijSnTUaWwrYdcI0k3nuuH5ZxIJ/r5CsY9n6fifjJgs/8SkjO2USWvVXzPz1v
         UyqdHIbrwg2UNY2J1NgLjkCwr82rc7EyaCBakxgGUVXA2f1xh1PPATNMKtnzKak1Lvtg
         Ptcw57+sH5WJ0nf6JcJF2leoncyB2ltslnxk3NkBJedYS5fVfOgPO7KoucFtEEnIXkfZ
         YxF0f8Su7+EnhyV922j+47qoTZDe0kXo600Lh3SPCg1uzXI3ajC8yY+a78b37Y+Rja5m
         W9iVKJQnXyYoau0Wu5x/qXI74MnAb0EzFky1Qf+7r9iHOviSSmjJZI5e1XvxhgM1sbaI
         WNqg==
X-Gm-Message-State: AFqh2kpyrJqCtSD9FjSYWEQniGnqGIB1rjscHFKCJ6kRw57yVv8SsQwr
        1ODlQuQWHdfh3xLB5UmqvGXLml811ZI=
X-Google-Smtp-Source: AMrXdXsDsduEDkkB7OrHUYHu8l5B/0qLrTQ1zsLvmb0WcMhVKoXfivUQ1Kt5wq/Y2vRAKVaoCIC0TQ==
X-Received: by 2002:a17:902:a50c:b0:189:e924:e279 with SMTP id s12-20020a170902a50c00b00189e924e279mr756plq.49.1673881570502;
        Mon, 16 Jan 2023 07:06:10 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id v18-20020a634812000000b00478162d9923sm3769652pga.13.2023.01.16.07.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 07:06:10 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Hans Petter Selasky <hps@selasky.org>
Cc:     rsbecker@nexbridge.com,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
References: <9c0fda42-67ab-f406-489b-38a2d9bbcfc2@selasky.org>
        <Y8NB21PExmifhyeQ@tapette.crustytoothpaste.net>
        <3b0af57c-a144-b0e4-d353-6028b3939291@selasky.org>
        <017901d929a6$ec180f50$c4482df0$@nexbridge.com>
        <85788356-14b1-6afb-c78c-0ab889bbbb59@selasky.org>
Date:   Mon, 16 Jan 2023 07:06:09 -0800
In-Reply-To: <85788356-14b1-6afb-c78c-0ab889bbbb59@selasky.org> (Hans Petter
        Selasky's message of "Mon, 16 Jan 2023 15:01:07 +0100")
Message-ID: <xmqqbkmyecym.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hans Petter Selasky <hps@selasky.org> writes:

> From what I've read the GPLv3 goes pretty far to also provide flashing
> rights for software, but what use is that, when flashing the unsigned
> software on your Samsung phone, for example, some fuse breaks in the
> hardware, and then you can no longer use certain apps on your phone?

It smells that you are conflating the signing of source material and
the sealing of tivoized hardware that use cryptographic signature to
tell what binaries are allowed to run on it.

The signing implemented by the software we the Git development
community build is not about the latter.  The source used to build
binaries for your tivoized hardware can come from a VCS that is
deliberately designed to allow object name collisions, and your
build would just be locked out the same unless you have the signing
key that pleases the hardware.  Use of Git there would not make the
story any different, I am afraid.


