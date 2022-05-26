Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4C3C433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 09:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243635AbiEZJzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 05:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiEZJzp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 05:55:45 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38EBC9657
        for <git@vger.kernel.org>; Thu, 26 May 2022 02:55:44 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id m20so1937707ejj.10
        for <git@vger.kernel.org>; Thu, 26 May 2022 02:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=7LKDPlVXybnPY2qbLEEEaJls5wejK8DIBui0BRk8F1M=;
        b=MAjXbJMOV2h/5rkerKYUUppQyLDoO9DC6VFkphLHukx0ncE06lWJaeWt90u1k0TGno
         Pvhm8D2CgdvKqSGTDuTMLHsGn04BntYgUWL2+ZHT53LX1fkOOGNDA7h0NFcAy4VTpSUq
         lLUOlmpzM7MKBqswqomzRmFKVThotXUUYqQPWTdMpzFLchu08lzOfHdRZu5K63wuhWE2
         LZ8H9T43IoHH5nFqFk1ri6qgSfXgVDFJVlcJzAevZ8+clHfrhwPMgSKzfBEfwOVomgXb
         AWdSs9ILVnci/fgyrJp05nJiUYOMCxAqEReCM99yQTPlPfsdAwYhZDfDEBYrz6Ej4T4C
         GIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=7LKDPlVXybnPY2qbLEEEaJls5wejK8DIBui0BRk8F1M=;
        b=ieFpSIe5nzGMayPvnLkCYoQJf2Jf/yybAxWON4OsAtNPDlzMT5UVGVrxRH25GShEtF
         IXJQlRQErrTrxYolF+1uN/Qe/nwRJuo7W+G/lXUtjbEi5+L7PcO/B3nu3i4jMSSPvA1l
         t6GAfsxZNLVzhKoc4BRHCeUXe+gWYpZezvDauXgQ6jx4kczTaxaJpVrhnbrXcgqg1rEJ
         cjxr4naifgIRDbYsftTwOlbV8CgdSS9GyzwQXS9nOX5Fyf1OivX/W+XFl3RW7Ucvk0oL
         eefqMUPdze2HtaMeaL4tp9ylvSsDKM49pFnVjQq72UTpCwPqRbhfj8S4mvRdpBrCcEs4
         OQow==
X-Gm-Message-State: AOAM533r8r4WeAtoAXpxrFf5DFfOUvfG60O21UmHSYwHIQ1u0GkCtKHL
        DsoyaSn5he7j+CMJEUhipPU=
X-Google-Smtp-Source: ABdhPJxkVjMaFhTqnoqdGy9fBs2y+j8f+ifY+3dErjBxswUqshS+8FxWM+TzZ43WT+KFMrvnkIPE9g==
X-Received: by 2002:a17:907:6e15:b0:6fe:f8e8:69de with SMTP id sd21-20020a1709076e1500b006fef8e869demr14930960ejc.512.1653558943213;
        Thu, 26 May 2022 02:55:43 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id a64-20020a509ec6000000b0042bd2875f86sm598498edf.7.2022.05.26.02.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 02:55:42 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nuADW-000BL7-4T;
        Thu, 26 May 2022 11:55:42 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 0/3] Die preserve ggg
Date:   Thu, 26 May 2022 11:54:59 +0200
References: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
Message-ID: <220526.86y1yo62jl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 26 2022, Philip Oakley via GitGitGadget wrote:

> This short series is a follow up to GitGitGadget "Update the die()
> preserve-merges messages to help some users (PR #1155)" [1].
>
> The first patch is a tidy up of the --preserve option to highlight that it
> is now Deleted, rather than Deprecated.
>
> In response to Avar's comments that the former error message merely
> 'tantilised without telling' the user what to do, it became obvious that the
> underling problem was that the user was unable to git rebase --abort which
> was also fatal, when a preserve-rebase was in progress.

Thanks a lot for following up on this, this all looks OK to me. I had
some minor comments about maybe tweaking this & that, but as far as I'm
concerned this could go in as-is, depending on whether you think it
needs a re-roll in response to my comments + others.
