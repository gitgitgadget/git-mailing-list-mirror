Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5018C433F5
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 18:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbhLLSiA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 13:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhLLSiA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 13:38:00 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA670C061714
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 10:37:59 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id t5so45143857edd.0
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 10:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=fmZ7VPUvxR72NQxbikhVRHd0F1nhePu2TnKgkDtvmEg=;
        b=Lf2+7P4WwqjTMu6E7Fwqo5vPBfH83gFhRBzqAbjg2iD7OmYYCXVra5D9onXB5ibD1p
         ds10nWGcE5wH9ipOmeteNd/3zTgpioe1+bzmv/4JuCEmID8wH4eSduGsa6a+Zlc8EJrm
         BU6ng+dgL+cinFGhYJgdpPpXfK7mWu4Kfq5wYEtsHaO/eNEP+bZFi2sZ26RfpW4VDPwL
         iq3JGo7yHRSlBFEmNV8RpUN20UBdl9DpcCpYASkAH0oRw9fyjhXkwnWtOQdBAgws8JF3
         PFqn2adV8C1gULGfvBAK4MW54MZC8Ak0TLPICwjWNgqG7Th6kqn8XsbeBnI9crTxwSBL
         Uq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=fmZ7VPUvxR72NQxbikhVRHd0F1nhePu2TnKgkDtvmEg=;
        b=mbeJei37VdRMhGcB1iKi3jpjXrMlLnWYptFW4X59pdpeW0/D8zFEr9cP6NwmWbmNat
         eK+cFsRdBM6d3yAB+a6sqoZ8k7hu2zO5nZL2YoMxwizTXDXvUTgwgyTdOzrZEEJ0DbrT
         wdNhCgLpIh9uicm4ITEYw0I6gTRvXvtfEF0AqtXtrYfHFRzeSsD5RDqFMeSii7Qk32O4
         BLQPc0LN6ydRkVM+hVBvDfSa1jV/UrcfPPrfqK5dDBFeYACmxyxeFZbl0IzCiuMAnUYm
         tdLcHXYw/ZyaBA1x9usVEkmG/vY4yyDGLBztBcOvwaz/XdxbmpEeVWm5/AmFSlxWmiiI
         ij/g==
X-Gm-Message-State: AOAM530SeM5QkKi3FBk/Gu1JGF2kPQCpvkPavtEDBWXA1psP3UY77nkP
        F226T+F/vXlpow+2ofUu1AHXPI/QjFc=
X-Google-Smtp-Source: ABdhPJwqk4D/Lv+rPE3DYgTmcjuL4wzkR7VFgQs0DKOdvgxfE7xRHBME1khsRTk1be6Cg2buHc609Q==
X-Received: by 2002:a17:907:a04b:: with SMTP id gz11mr9743689ejc.68.1639334278249;
        Sun, 12 Dec 2021 10:37:58 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id og14sm4577910ejc.107.2021.12.12.10.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 10:37:57 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mwTjR-000ZcJ-Ap;
        Sun, 12 Dec 2021 19:37:57 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/common-main-cleanup (was: What's cooking in git.git (Dec 2021,
 #03; Fri, 10))
Date:   Sun, 12 Dec 2021 19:37:17 +0100
References: <xmqqilvvluoa.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqilvvluoa.fsf@gitster.g>
Message-ID: <211212.86wnk9acu2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 10 2021, Junio C Hamano wrote:

> * ab/common-main-cleanup (2021-12-07) 1 commit
>  - common-main.c: call exit(), don't return
>
>  Code clean-up.
>
>  Will merge to 'next'?
>  source: <patch-v2-1.1-4f52ecc94ba-20211207T101207Z-avarab@gmail.com>

That would be nice. The much smaller v2 addresses the comments you had,
and the change itself is relatively straightforward.
