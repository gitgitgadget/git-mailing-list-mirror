Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC073EB64D7
	for <git@archiver.kernel.org>; Tue, 13 Jun 2023 19:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbjFMTVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jun 2023 15:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjFMTVh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 15:21:37 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFA7B8
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 12:21:36 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-66619138c1eso190114b3a.3
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 12:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686684096; x=1689276096;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E81GEklc22AHL2TVfEgD+uaKagDkI6f3/9mJJziUZA4=;
        b=meEdlDeCirC4a5znwyN5kjmtjns0Dvv+9qLbKzcHncVNknJy5verlFTT1mFbo6tKB9
         IB//Khh3S87y2XnmRA5d1mlEGo5iRaE/Ab+0kkzoTbkC4a0/2W22h7CU406ZE+ORcc3K
         wFwIqX9Jem6a5UeAbtmJVUjliNyfYDq4s4BtklkfOEIe9iMzWqUlEE8bzCroazszL1Ok
         pmPVQDVCoQ4SFh5J34DtxtBkE4rDlgwI89SbVlG0P4CJlSoacKdfXJ+FSL2P89mRSQc+
         Fk9ru6gJNBl7RRv5vVbb4kG0j8xsUlgi9KKSf1ZXBoy4SBEwWOWs5UGPFVtA19NfeEiI
         oprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686684096; x=1689276096;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E81GEklc22AHL2TVfEgD+uaKagDkI6f3/9mJJziUZA4=;
        b=LEaVuNmgBTR7CyyqcboUgWFVCDENPvnSB1/1fnvBPxIU3O0LXn9mMvW5R4YVCpqaJq
         CPic/lzOHWysawCIwobvRgSsUesAiOLhGHxoCPwG/dnPp8Svk0YK0NCDVK6eF8ywqIbP
         i7d5M9k871yW3gUEN0cp2Wu85VBI+wNi/FP6Aaf1aH6/D0ccp4mu+JMO7HEBox6ZaE6j
         M5OgrwixDCoAqdat8Q3ZTIsBou9bypWgDETg39FRZsGOPzIJ416cExMJduDed3Fja1Bu
         lhhGICpCTZ3ZgmVSZUzf/XwxvI0XTPHC0/cy+0ACmfypoL627O/ixUH/83D7LbWBEinm
         o+GA==
X-Gm-Message-State: AC+VfDwwdSwptaYkgbdfWME1xjsswh04osx8sxuu4TFpkBd/DEcD9bpk
        1aH69zybb0vVVGYJm8ymm28=
X-Google-Smtp-Source: ACHHUZ5Mz0UzbPrSnvii40LRgZ58tM0zuM1xs8LM6hIK6cUbBuo3nGNmcPBp/32t87Z9ahE0Dc8lXQ==
X-Received: by 2002:a05:6a21:6713:b0:106:c9b7:c93d with SMTP id wh19-20020a056a21671300b00106c9b7c93dmr11994185pzb.19.1686684095839;
        Tue, 13 Jun 2023 12:21:35 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id 4-20020a630204000000b0052c9d1533b6sm2131603pgc.56.2023.06.13.12.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 12:21:35 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v4 0/4] Changed path filter hash fix and version bump
References: <cover.1684790529.git.jonathantanmy@google.com>
        <cover.1686677910.git.jonathantanmy@google.com>
Date:   Tue, 13 Jun 2023 12:21:34 -0700
In-Reply-To: <cover.1686677910.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 13 Jun 2023 10:39:54 -0700")
Message-ID: <xmqq5y7r5fsx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Thanks Ramsay for spotting the errors and mentioning that I can use
> octal escapes. Here's an update taking into account their comments.

The changes look good.  Will queue.

Stolee, you had comments on an earlier round---how does this one
look?

Thanks.
