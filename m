Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B1EC6FD1D
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 18:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjC0S3r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 14:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjC0S3p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 14:29:45 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B04271D
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 11:29:45 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so9870400pjt.5
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 11:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679941784;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jtp0xeEopJbKk/kdf99iiD5Ji3BtDtf85oJ8sDXQnrY=;
        b=WdULwDnLRrnPp6kQr3J2Fj9o6kmUWdhTbGO3xdNE9UPtaeLkm+lBG8PBjuaLDDU52P
         DaTseEyKtf+gvo5OygbJ6VUTNteQmqjBA5Fo3VDzRpZOWUSDbs2sFuZ+iwlCV9fp9oL4
         KxTsqMmPp4UIpt3ehjofFL1TalkMKIng3JEyQ4NoS2pnu/3ovi92N+cOg8t7qeYhW7aE
         A7EsP4Gv57RkpHhJUsWf/hj/yrfdQaH5czJ8L2e4xwYpBlmQF2p34boe8xa9UACibv4x
         BghyT40oB/LzKAoDCTQsC3328yZro9yifDlqQl2aRN4Or6Q1nV+x7EGZGp+zauri6VjF
         e9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679941784;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jtp0xeEopJbKk/kdf99iiD5Ji3BtDtf85oJ8sDXQnrY=;
        b=32+03b2YaQj3iTdmhH7jAk4aBk2jEIAQ7u8EcD5rOSTs7Ld5IyEmjkkE5CAN6hgyYy
         AzxO7HhUDxRGS42QuEmIyA8oUmQcWwMWC6+UzdHUP4ynaapnRI+M6Ozm3LLE4aPPMA3O
         Yi5frBpfcYRA1ap5ob1wgxasylMLkh47DtPuyx0VNsGVc0Gpn+LQ210d6YkJZ8QNKsTf
         WJ/kSiuMLvwm80cu0svZ98TuH+iKFIO2oGK5yPzfKnXe17pFDTixW3Wu536llni2a1N4
         WVDJpE+EOvPXA43rRMhaWolRsDjxDpY7b3hDab3VhRX+jLyXLDBfMzp8fiWuZcpG9p8s
         C0Eg==
X-Gm-Message-State: AAQBX9fXZsalyKR5Ky+Y6yRQd0+2grfs7NeZQ8QFgRidMivsP0RTdd5z
        xi2pFfhe+R/Dh3tgcYVPd3Q=
X-Google-Smtp-Source: AKy350Y7QC2Y8HpnQrJ6GoNMSWls7tm2BaV1XrHqcqsFQdtoqK9nPFQFcCA3N+iH7kG/CKF9S4xdtg==
X-Received: by 2002:a17:90b:4f48:b0:23a:87cf:de93 with SMTP id pj8-20020a17090b4f4800b0023a87cfde93mr14278616pjb.15.1679941784124;
        Mon, 27 Mar 2023 11:29:44 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id d6-20020a17090ad3c600b0023f786a64ebsm4705242pjw.57.2023.03.27.11.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 11:29:43 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2] attr: teach "--attr-source=<tree>" global option to
 "git"
References: <pull.1470.git.git.1679109928556.gitgitgadget@gmail.com>
        <pull.1470.v2.git.git.1679936543320.gitgitgadget@gmail.com>
Date:   Mon, 27 Mar 2023 11:29:43 -0700
In-Reply-To: <pull.1470.v2.git.git.1679936543320.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Mon, 27 Mar 2023 17:02:22 +0000")
Message-ID: <xmqqcz4u9hew.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     This version is the same as v1. Just changed the author to Junio as he
>     contributed most of the code.

Heh, I do not need an extra credit.  The most important missing
piece I punted (i.e. the environment passing and receiving) was done
by you that is a larger contribution anyway ;-)

I am kind-a surprised that we haven't queued the earlier one.  Is
this ready to ship?

Thanks.
