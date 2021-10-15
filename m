Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40D8C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F4D961040
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhJOJtj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 05:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbhJOJti (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 05:49:38 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8F8C061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:47:32 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id u8-20020a05600c440800b0030d90076dabso1294131wmn.1
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ODY2FcAQb5MMFDhVbmNjgT3MXzFYN+226soG37jiltE=;
        b=QVDdVij3NaiyVzbEdU/oiTrJZdgrAt+zyULkOb2JwPzSXJ8U07r/4mUXGfiZU1XXbQ
         wA75mLHf1qJe591HxwkMN7d4GQRwLXHrVmUkJ8zZiURATUbF3M/ZpZ2B/y4IrcyWC8JB
         PglzoX9cBorwDGIoS/Y9c0qB9yUcJtSOSyNaakq/6DpMtTdi8bJwlVaLDh1tASsIAXtl
         C25tzwscmVlt7pCdOp7AF2bb3lh8hWxYCCdaA9PyHfVkJhotJlkD/HhP1jztB2CLOsag
         MCGN6AOuX1ykDMwk9WY72uG8H6ul4zecanG2w53s99tnqZwMbPu7KZf8PlLlXCZJ/mWX
         yqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ODY2FcAQb5MMFDhVbmNjgT3MXzFYN+226soG37jiltE=;
        b=wo4RihRqwCvh+rE/Jk8sbaN68jWjSUt/1wL0kxw1qiNZGfoDLhV0r9Hr1UtSMt6U6l
         SFJzIkHUeoA6FahHPE49R7ZZ7BXlna0RpKx8VhwvgoC8sN752QUtMndLIQh1lvyYTmfr
         5wMricEgbDgmj7/YVXenFoufFbQ8hbJqy/t5sLRV4Y7KlP+3L7hhjFlYfxJeiAgnmIAo
         uezXfGCuzYKabC/qIRAyRnGO2v2AylGysWOmbMdLMBCue8ArsNz3CVw6Lk6TVwhxuKZ1
         Z/ZA+Q+c5mkjYJci1UcRth1Qm4VaFEmmduxBoqIiL9O6S/JZPh3GxxWaKDSwt2nzgl76
         aOLQ==
X-Gm-Message-State: AOAM533myyZp/mkNHoW6dRnMubfXM7U0WnTQHgnzqsqQR2q+q7hR44S1
        ZozUBAQraSrsKF4xVZQsF+oeLzAcRn5XKA==
X-Google-Smtp-Source: ABdhPJzZvDBTVFOfx0uN1Q91gwUSWtqx9od8J8jEZnpkVwaI6qPMVtCCdgbT3dEnsKWe+ELXSZNG+w==
X-Received: by 2002:a1c:e90a:: with SMTP id q10mr11466967wmc.108.1634291250821;
        Fri, 15 Oct 2021 02:47:30 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p17sm4372737wro.34.2021.10.15.02.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 02:47:30 -0700 (PDT)
Received: from avar by evledraar with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mbJoI-0001lH-32;
        Fri, 15 Oct 2021 11:47:30 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/test-cleanly-recreate-trash-directory
Date:   Fri, 15 Oct 2021 11:46:19 +0200
References: <xmqqwnmf9lnv.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqwnmf9lnv.fsf@gitster.g>
Message-ID: <87tuhiei19.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 14 2021, Junio C Hamano wrote:

> * ab/test-cleanly-recreate-trash-directory (2021-10-11) 2 commits
>  - SQUASH???
>  - test-lib.sh: try to re-chmod & retry on failed trash removal
>
>  Improve test framework around unwritable directories.
>
>  Will merge to 'next' after squashing the fixlet in?

Thanks, that looks good to me, sorry about the syntax nit, and adding
"r" to chmod makes sense. I can re-roll, but looks like you've got that
squash queued up, and it's less on-list noise, so...
