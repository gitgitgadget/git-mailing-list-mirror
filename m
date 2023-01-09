Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE220C54EBD
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 06:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjAIGap (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 01:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjAIGan (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 01:30:43 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8747AB39
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 22:30:30 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id jn22so8439948plb.13
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 22:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0LsypFAl6U57idq1m8GF52L5IpNRT4LDu8L41E03UY=;
        b=h+mdmafxZSufR/dJnlhoS+aM3NOksvVKxfhpsgtRK9IsWfeE4K68lEhE5wjYTcs9CU
         5n7MisJXjlyaFcRvHEbKOy4T15vcTWMxWJRZ+nyTwlzZg9stKMxG6mda5MkZsCiKPqDb
         z41OkTTUDpQFLkvuO1wMh9cpdCZ7T6av+IOSEDiLT5ZNwjn4cZG6FDhXZ1EYT/fXYNc9
         Br1B6CoVxS3q3J5XugqTjJR9qp2oXuDOyC7atrIkI6DlnTDmvy01nkxw62BMtEAQobAZ
         SIpdKQAazpquvb/CQhyxeKsLh7vjKZ1kgo5SMI2opCamz5GUGoMMOvGIW2c9Mz8OzaHK
         Co6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s0LsypFAl6U57idq1m8GF52L5IpNRT4LDu8L41E03UY=;
        b=1fPb5wyt8mjnmWVcOwrw2MCXEnKePrueJ7rm+dXdlQMVec5cnm/UZUpFSDQghpaMDv
         GK9KtunX6syA7bzcmSPORIJB3hbsI9LwlrHRdAG7mWbodTZAHKYgRQv2RmpYsmrn/503
         w1z3DdBCV+gjUSjP4W5lxXSLQkll7lLlwF2MUMSD9Dhx3jqYI8qJB3HpdffwI7WKFw4o
         wmQo3oikSMsqEAC9ZxIlPNnR8Z7baDgMgMFUtOZpqh7S7tvdi6s8usBSKqtMltAyBU2z
         canGAlXiO+jCRJUuNs6IQX6gY+OTbEknX4rADsdoFGc50RioNa2PvPTAIX3Lx/oNiuWM
         pdFw==
X-Gm-Message-State: AFqh2kq1QDVHUgQx2aD8k+ZkzYRvsqiiRVMNOK4rKM+jPtrIc9FNvcMD
        rza9g72USNGNII/+5/vHZ3s=
X-Google-Smtp-Source: AMrXdXu6FXL7RTezqTa2dr0tEgD/XHNs9IavaWE+kFheWroIsHM5bbf6HyGQrtnMus7K0IJiWQp9Hw==
X-Received: by 2002:a17:90a:558c:b0:226:1189:ad3e with SMTP id c12-20020a17090a558c00b002261189ad3emr42863151pji.27.1673245829813;
        Sun, 08 Jan 2023 22:30:29 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id p10-20020a17090a348a00b00218d894fac3sm6607966pjb.3.2023.01.08.22.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 22:30:28 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Yutaro Ohno via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Yutaro Ohno <yutaro.ono.418@gmail.com>
Subject: Re: [PATCH] doc: use "git switch -c" rather than "git checkout -b"
 consistently
References: <pull.1422.git.git.1673166241185.gitgitgadget@gmail.com>
        <xmqqbkn8wcqo.fsf@gitster.g>
        <CAPig+cQe_VMW2KV+ZyZwosFw07Q+hePryDVushRJ-jFfD4yzpw@mail.gmail.com>
Date:   Mon, 09 Jan 2023 15:30:28 +0900
In-Reply-To: <CAPig+cQe_VMW2KV+ZyZwosFw07Q+hePryDVushRJ-jFfD4yzpw@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 8 Jan 2023 23:48:46 -0500")
Message-ID: <xmqqk01wusmz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> touches is given merely as examples one might use, then I could see
> git-switch being prepended to the list rather than entirely replacing
> git-checkout. For instance:
>
>     If we have not yet moved away from commit `f`,
>     any of these will create a reference to it:
>
>     ------------
>     $ git switch -c foo     <1>
>     $ git checkout -b foo   <1>
>     $ git branch foo        <2>
>     $ git tag foo           <3>
>     ------------

That can invite "do we need to use checkout after doing switch?"
confusion.  I would understand if it were

	$ git checkout -b foo # or "git switch -c foo" <1>

or something that makes it clear either one, but not both, is used
there.

Thanks.

