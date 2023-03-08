Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA90BC678D5
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 18:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjCHSOn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 13:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjCHSOd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 13:14:33 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8585DCAF
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 10:14:06 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so3328720pjb.1
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 10:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678299244;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CxppcWceW9mteTvG/fDN1kx5k0OCe5utm8bcFJcDw9s=;
        b=Bk1dAEkBjMDG9CNP9g7IzI0EDL11gQSEfl/hIaHifAG4rXme8IiK4S/pHAuIdWTMap
         g5Nl3YECVzUrKD38zvzeE4ldpaKhkoVhFklF13JoizMA0idHJW8jAnCh4CrzNwOddcPh
         x6siOZ4N5y+SqBd5vgFI52JWiFyI8y45t9DjV3FQojtnBF+Ji5IwTDm+Mq4QGAVGKkVb
         8t/yEfQs8WG/g8n1PCjgOFpMRJJ9kN5170CPS/jAWrWLedKSCnX6fUNtTyV0ARdcLCB2
         xc28Dt+AqWzcJudW/Lztq5Jh8wLSF45uCmiDx0jCkNXky+tlpBhZRSJJL+QI5060r6dL
         sbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678299244;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CxppcWceW9mteTvG/fDN1kx5k0OCe5utm8bcFJcDw9s=;
        b=fsldSrrh0H8srkAGbuGZVsnvuK5RAjPV+L4hvr9ubaLUMSGKyJ+JexDKfM8uhQm8OZ
         vygdhd6sYGUfo64S14Men4vjrEs1TtQuwyxrDKbemwAfbEszSjcizepR9ehpRKfv7xmM
         3AJq86Mt59em2okq/lrCWLgzlpldIjtGSQPfIrIrxggMmguSTtY2gmaTxo1Ltr4wWqG9
         e49KgvIRvBTbxorXzJVVhiMgBe46Tb2h2EUbDcIgJaQGWXS2vlX7DYhsTZVuwaNsSkYT
         HZ/8/B5gW/HM2rlFD7lzSGt/k8EUPJO9Te6/QnnpPKoGRNHr9fX+Il56Z6AHYY97v7Lj
         v8Yg==
X-Gm-Message-State: AO0yUKUPzxIOB1DgCBXvr+scYT9yczTXOQJ1+n6M9plLW2ZdcCTw6hg+
        qhWyx6flCp1Q9UC/TgBo164=
X-Google-Smtp-Source: AK7set9FsoZEqH9KCfFo7eeYcuSySID/rSu3XYqFLylbASZ4Qh+SyyPwlvgArNGxhpAw78DsA/MQ7g==
X-Received: by 2002:a17:90b:17ca:b0:234:2213:e2d4 with SMTP id me10-20020a17090b17ca00b002342213e2d4mr19644768pjb.15.1678299244586;
        Wed, 08 Mar 2023 10:14:04 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id w9-20020a17090a780900b002372107fc3dsm32244pjk.49.2023.03.08.10.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 10:14:04 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "William Sprent via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        William Sprent <williams@unity3d.com>
Subject: Re: [PATCH 1/2] builtin/sparse-checkout: remove NEED_WORK_TREE flag
References: <pull.1488.git.1678283349.gitgitgadget@gmail.com>
        <4b231e9beb43e4fac6457b9bf86e4c1db39c4238.1678283349.git.gitgitgadget@gmail.com>
Date:   Wed, 08 Mar 2023 10:14:04 -0800
In-Reply-To: <4b231e9beb43e4fac6457b9bf86e4c1db39c4238.1678283349.git.gitgitgadget@gmail.com>
        (William Sprent via GitGitGadget's message of "Wed, 08 Mar 2023
        13:49:08 +0000")
Message-ID: <xmqqmt4nt8k3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"William Sprent via GitGitGadget" <gitgitgadget@gmail.com> writes:

> In preparation for adding a sub-command to 'sparse-checkout' that can be
> run in a bare repository, remove the 'NEED_WORK_TREE' flag from its
> entry in the 'commands' array of 'git.c'.

Given that "sparse-checkout" is about affecting which part of the
directory hierarchies are to be materialized in the working tree,
the idea to add a subcommand that does not require a working tree to
the command by itself smells very iffy, and the changes necessary to
protect the existing commands from the breakage caused by the
decision to drop NEED_WORK_TREE bit, i.e. sprinkling many
setup_work_tree() calls, somehow looks like they are solving a
problem that did not have to get created in the first place.

But you did not find a place the feature you wanted to add with
[2/2] would fit better, perhaps, in which case, somebody else may be
able to suggest an alternative in their reviews of that step,
hopefully.


