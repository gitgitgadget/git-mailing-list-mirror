Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB445C48BE6
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 09:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B91566023F
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 09:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbhFNJNb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 05:13:31 -0400
Received: from mail-ej1-f41.google.com ([209.85.218.41]:46988 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbhFNJNa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 05:13:30 -0400
Received: by mail-ej1-f41.google.com with SMTP id he7so15256310ejc.13
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 02:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=TvGafeeTNTuY+EO3XKqsEVqzRJ/atQ6aAOjY7O6hsEo=;
        b=QBzZLphHJvhd47E6k/BC5VDXMN3CxZWNYsG1/UgHut7p32E0pVBpx8tV+MmVpUkTg1
         Eadjls595U67JuK0XGqX583kKhdFZLLsaL+BPvxf5oKgxfCIRZ0P2XNOzfSBTIA/oWiZ
         dKkhZRLN+0KhinHQ9SzGLLVhotZN7fEtC/3QZWudwWHgvVmikVTb7GAKroj4D62NBJbj
         X17eki5URYMzGcKbfXcxYNW1BZCwhwENCDWpzxG2pGr4sVdsKgskDHR8JadQrlj6g6kP
         GA2QdzcTWhFAvk+vsg++eE+vjHaY8PR7YjcZS2yMVqiuYe4dw+a+9Fx4rGCymnYGD+0h
         rpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=TvGafeeTNTuY+EO3XKqsEVqzRJ/atQ6aAOjY7O6hsEo=;
        b=gxYq9Xgde06GyA3JVQhl5vNGZurXtNQ59o5mJf9NkVHVr+k8y/Q368IQGduyEjn7Pf
         juOMphfvqNoDTSGKJULNAspBUuv+2Iwu9n24tFsPeuxmdi6jRRWQ28ZY/cLBM3xjN1YB
         +2fYEP04FK84Gmb2/CKnUhuTZr7Xse0gKKk6LFPUlGCQhQi+kD6HNicYdjPi0g4xu4fP
         4RIYU3sISrkNYWgxue33Am09N8kY+rfC2GgS8xInH6lU4MCK0LQPFd36Qqd5FJlwUZ5u
         J+IFZOJX8A+r7KoVMsetaJzqRH4TnkD+KreNslFWb5041EFFD6JzOkdgwYZfa3sPY9Wx
         RTgg==
X-Gm-Message-State: AOAM531SAZQvmX5lC/d5fdJ0S8Gi+alus2nmEYgTkSPsnTBLKFZgeWY/
        3jw526Uo/K3q0LIm++EhOkE=
X-Google-Smtp-Source: ABdhPJzSDbkDUIEQAhlsomlGTcoNcD1GcDg2VcIqmobHwUaUqxYoTJa0HfHxH4Ozi5jgpvq5XfikIg==
X-Received: by 2002:a17:906:1f90:: with SMTP id t16mr14347302ejr.297.1623661818129;
        Mon, 14 Jun 2021 02:10:18 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id cf26sm6857694ejb.38.2021.06.14.02.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 02:10:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v9 31/37] post-update: use hook.h library
Date:   Mon, 14 Jun 2021 11:09:21 +0200
References: <20210527000856.695702-1-emilyshaffer@google.com>
 <20210527000856.695702-32-emilyshaffer@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210527000856.695702-32-emilyshaffer@google.com>
Message-ID: <875yyg24na.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 26 2021, Emily Shaffer wrote:

> By using run_hooks() instead of run_hook_le(), 'post-update' hooks can
> be specified in the config as well as the hookdir.

But even though we delete run_hook_le() in a later commit this is not
one of the users of that API, it's doing its own start_command(). This
is exposed in my alternate restart series where I removed that API
before this commit.

Spotted while rephrasing the commit message for a re-roll of that, just
leaving a note here...
