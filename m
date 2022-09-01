Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFE2ECAAD3
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 19:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbiIATy1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 15:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiIATy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 15:54:26 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EC64DB51
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 12:54:25 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id t129so18456616pfb.6
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 12:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date;
        bh=n76UubAKzUdVmHa7a3ns7C9stwwwPnggHlW14/ArfqI=;
        b=SBJXyDgyFM+9ObA9oqXXIEGdkAd9vb6M7eH1YIMmHPOL+qPnSmDKk9hnWA8P+CtZbf
         W1iaHU56a+QB49C7rldcUp3k8wpkIg0xujZvJnObz4iXn8j+0nF33vrd+0npnJAT5+xO
         hWVNHu6t07MFdZ96G1wE8ZezTzpLkdHmoVzMpv7k/Jms7S3ogjAuDKFVUFWC4LYDAuXB
         Kx+dIBwyfLM3qAe/DMGokEJITAZEZiWfPgVMG6KGzYMQI0abYvjsOKOiG/r32qMXYd33
         2kUmyBGVwDW/E5qWsuF5H8UoA4/yUraD+c3JXFugMleLc0o4nrD5EfY7229VlE/En02g
         9bhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=n76UubAKzUdVmHa7a3ns7C9stwwwPnggHlW14/ArfqI=;
        b=xhuW1tj8dKar7jUx4xbJ21uqBWKkM6MJ6ms5GlIz0d2hK4I3Vu6Lb0/pSdNhH9vhyg
         Whr188x+vkozEM+mJ+NT9K8RWDbuVKjIuE9DIawud3VzB9+oPDdwacMNBQ4k/LGBeNuY
         iBatNuP4nLqbplOt4w/cXBPMVzoJ7dDB4dh1va6mHuZQfQr0F3iJ430IFXWz9z4iWkpm
         L1UocGdLiWaPYkX/oJtBnsWcIgfStDbAGd+XA+X8GcEm3ODCIh+dbce/N4fkuGeQVuFY
         WqWrVTXbE08EKul6WYftiCYNvPjXonhhHMiPhqkhkIrqeDYiKhM9sg6UzgmtDclbsybZ
         5RXQ==
X-Gm-Message-State: ACgBeo3p9DqLOfW9V8rvRpk7VzauTXUMVSAzIY3pMJWO654KZwj2wiRx
        qjzecOUATb9EP7J33z82gb4=
X-Google-Smtp-Source: AA6agR6WezorHByNw16kdAPAsb3H8pWIHWHtRUE25oQ4nYwMkPHR1k9c7ZvjExFE8tM+xI9NfeNpbA==
X-Received: by 2002:a63:dd51:0:b0:430:18d9:edf8 with SMTP id g17-20020a63dd51000000b0043018d9edf8mr8934220pgj.163.1662062064920;
        Thu, 01 Sep 2022 12:54:24 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id g194-20020a6252cb000000b00538505ff705sm8453722pfb.91.2022.09.01.12.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 12:54:22 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 0/3] Output fixes for --remerge-diff
References: <pull.1342.git.1661926908.gitgitgadget@gmail.com>
        <xmqqv8q7dhh4.fsf@gitster.g>
        <CABPp-BHULBGAbmY1r9fpRr+MrjqOp7j-devOgkfA25jpYBGY9g@mail.gmail.com>
        <xmqqo7vzce39.fsf@gitster.g>
        <220901.86tu5rhqtg.gmgdl@evledraar.gmail.com>
Date:   Thu, 01 Sep 2022 12:54:20 -0700
In-Reply-To: <220901.86tu5rhqtg.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 01 Sep 2022 20:46:44 +0200")
Message-ID: <xmqqa67ian0z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> We've discussed doing it that way before. I wouldn't be fundamentally
> opposed, but I do think we're far enough along the way to being
> leak-free that we'd want to mark more than just a "top-level" command as
> leak-free.

Two things.  Seeing the leak-check breakage quite often, I doubt how
much trust I can place in your "far enough along the way" statement.
Also, I do not think we thought the alternative was to mark only the
top-level.  The test could inspect the crash after the fact, and say
"ah, allocation made by xcalloc() called from this and that functions
are still known to be leaky, so do not stop and mark the CI job a
failure for this one", for example?
