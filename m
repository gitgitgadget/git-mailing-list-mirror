Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51830C61DB3
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 22:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbjAFWpq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 17:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjAFWpp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 17:45:45 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8534285CBA
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 14:45:44 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id 124so2162298pfy.0
        for <git@vger.kernel.org>; Fri, 06 Jan 2023 14:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rMIsizCQ/KqH0buZhI4QBf228kYVNLd43uS5MqEF6lI=;
        b=pzmECajWTIo8ASIC+orHZm0p7wplsSmc+Wph2VUfmDXP5a6FdTx7wvLVY7e6qHLNIn
         D4WCZ6kzmloCPq3NkYFNTjzPYASvlfuAFKhcPZDkoEid/VFNNQKA5wSYfpIoALBNhYJR
         RvjIZjM13/NqxPqgqLnhmxFLy30fPvjRGFABKEfsHh43xfqH5whr5Oz3ve8CFZzprF1t
         fRsEKnDBZYckg//qsFKx09WJHksIB8wCuUEA3STVYX4MiRengQcq+ZI4uvunRmllpbyk
         oxoMwvPsP0TwmYTQpkOWbo2qq9AU33liLsdJvL9KWowpRku0fgtmj+Luo7shh5IVlueo
         XugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rMIsizCQ/KqH0buZhI4QBf228kYVNLd43uS5MqEF6lI=;
        b=dRoER0ag511bMXZ7nsNO+Y8ZwC1plNUvfVgNuAGIrRunuFVczAoXgsVLl/iwYVXjJl
         NHeAvqwyxAMfca3PdW+TXNQfKjDaOqDUSLl/eZFtHZ/oKM4OlGa4y3D0EPaMQk/MxYZF
         f72X0QqAoBVNR5qA03Y8B5G8pKI76zv33QhZc/hEA65DMz6GvFwbXnMHZohso8H9tTjY
         wnFUACGcqU1nUhgZJ9IsmNpZDaXARXzRORUoJuaAbKev7gQ4UNUrRnO2xZ2UHB6TITnQ
         L1/8jDCjSu82BKsSHGWBh2CuxbWvcvzrQCD1HP5SHh44Cl2oHin5CNCRo1rB1wGXkQXp
         a7nA==
X-Gm-Message-State: AFqh2krL+QOfrZIhHEDN0QcexGRDwYtGUz7R0t0GDMDbncbPvR3ueRHw
        uHhFTc2VPlvIa7KQDrstGXg=
X-Google-Smtp-Source: AMrXdXvvwBzM+vaiwwIT7uzaKSFTbd3e9M6NeeMKXFsyG2RkSa7WSlMuD4w3B8lASBEsbJvjWa6sbQ==
X-Received: by 2002:a62:1d96:0:b0:575:e8c5:eb14 with SMTP id d144-20020a621d96000000b00575e8c5eb14mr55678125pfd.18.1673045143828;
        Fri, 06 Jan 2023 14:45:43 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 2-20020a620502000000b00580cf1be16csm1570952pff.137.2023.01.06.14.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 14:45:43 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com, newren@gmail.com,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v4 0/4] Optionally skip hashing index on write
References: <pull.1439.v3.git.1671116820.gitgitgadget@gmail.com>
        <pull.1439.v4.git.1671204678.gitgitgadget@gmail.com>
        <221216.86sfhf1gbc.gmgdl@evledraar.gmail.com>
        <b2164be2-72e9-cee5-26db-3e4fbfec3051@github.com>
Date:   Sat, 07 Jan 2023 07:45:43 +0900
In-Reply-To: <b2164be2-72e9-cee5-26db-3e4fbfec3051@github.com> (Derrick
        Stolee's message of "Fri, 6 Jan 2023 10:33:09 -0500")
Message-ID: <xmqqmt6vqo2w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> After investigating some of the failures from creating a BUG() statement
> when istate->repo is NULL I see several problems, and they are not related
> to submodules for the most part.
>
> The first issues I've found are due to code paths that operate on the_index
> without actually initializing it with a do_read_index(), or otherwise
> initialize an index using a memset() instead of a common initializer. This
> looks to be a frequent enough problem that solving it would require a
> significant effort. It's not a quick fix.

Thanks.  It is not entirely unexpected X-<, considering how the
connection from the in-core repository and the in-core index has
been developed and evolved.  So in short, istate->repo is not yet
ready to be used, until the problems you identified are resolved?

We probably should start paying down such technical debts.  We've
punted on them too many times, saying "yes this is klunky but what
we have is good enough for adding this feature", I suspect?

Thanks.
