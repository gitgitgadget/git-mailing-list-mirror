Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2948BC433ED
	for <git@archiver.kernel.org>; Fri,  7 May 2021 14:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0C8361424
	for <git@archiver.kernel.org>; Fri,  7 May 2021 14:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237363AbhEGOEA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 10:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbhEGOEA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 10:04:00 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4AEC061574
        for <git@vger.kernel.org>; Fri,  7 May 2021 07:02:58 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x20so12924681lfu.6
        for <git@vger.kernel.org>; Fri, 07 May 2021 07:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=q8lThpELikp8ODUS4j45tCvhIkLiOfbuAGZKuAO0Lic=;
        b=urv7EI6U8jBta2J2b64avkRUfAYL/5+q1rADxnz3rOvTxbJ9dHsvZB7AxyRg2J5p4L
         yl0lNxlwwZfFd1IoId5f/3PPEu/BxI9iy8JjEH3bBLYP3ouQJdXXPlnpitW4KInnhdmB
         3CnVALqb74QJXW7X7/BWZeuIEoo1PkxfuEJDb3SdjxaXBm6qBUIKKVNqdZOYSLbYElam
         V5DMppBpP7s+oPBuvasA+PcpW1JSol3RPNhO+4UzUXoI4hBjS4bTPKSbqjf88hVzTpFw
         m7D1XLmhX2DARQ5FZKeT9MROJFSF7ff7nypjG/IG+9C8jkuF4WT+ODHEAkTo8axuXyDN
         G2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=q8lThpELikp8ODUS4j45tCvhIkLiOfbuAGZKuAO0Lic=;
        b=LZ6ASANvUGI9FuKwsm8JJBDYewZtajYCv04aDvCL3I6FU0om4PXLxpHef2De1UH9o8
         Xt2rww/oX4DITtKF1mtG6Y9+P2HeUjqCI6I1q7AF6MS5cVp37hB5LkfRWy2XJZ6NdhmB
         +KBRYqToZ8MFMne4rB7EcN8ePimX6BJhAbafZM+mLwL32ycDSdhIwDc1fVrplItnfUq8
         9YVcp8cqRtIAN76Nq7oKIUYWLG6J98kBkLsuJzX1r0nAy5xFbLEbuKaoZQ2uQDe9YH1H
         CTeThnQcb7PTtgSTrC3lqDU6me82Jz52n6m0T9Q8Cam4mCBZAiytt1aWvS+6snKTvwNw
         CARA==
X-Gm-Message-State: AOAM533nfgGlMWOJUnMNAkIRWxDQcEDqK1DQKRptVxJL6ZJ49+SJcJTE
        tpCT1O2fnOe9pi8I0MIOvwvuoIwzevo=
X-Google-Smtp-Source: ABdhPJwc8tK5f8V2znS+CeSTdGuP95Uj0Z9oKa01rohbMyfXVHu/w5pasQ/Me3TfvVbzenSXd5Agtw==
X-Received: by 2002:a05:6512:acc:: with SMTP id n12mr6744414lfu.9.1620396175794;
        Fri, 07 May 2021 07:02:55 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id x207sm1378483lff.234.2021.05.07.07.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 07:02:55 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Firmin Martin <firminmartin24@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v1 0/8] format-patch: introduce --confirm-overwrite
References: <20210506165102.123739-1-firminmartin24@gmail.com>
        <60949be8613c1_8c2220882@natae.notmuch>
Date:   Fri, 07 May 2021 17:02:54 +0300
In-Reply-To: <60949be8613c1_8c2220882@natae.notmuch> (Felipe Contreras's
        message of "Thu, 06 May 2021 20:46:16 -0500")
Message-ID: <87sg2ybq0h.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Firmin Martin wrote:
>> Currently, git-format-patch, along with the option --cover-letter,
>> unconditionally overwrites a cover letter with the same name (if
>> present). Although this is a desired behaviour for patches which are
>> auto-generated from Git commits log, it might not be the case for a
>> cover letter whose the content is meticulously written manually.
>
> This is one of the reasons I never use git format-patch directly, but I
> use a tool on top: git send-series[1].
>
> It would be nice if git format-patch grabbed the text of the body from
> somewhere,

It does already. I use:

  git format-patch --cover-letter --cover-from-description=auto

that takes both subject and text for cover letter from branch
description.

> and even better if git branch learned --edit-cover-letter.

It reads:

  git branch --edit-description

Works for me.

-- Sergey Organov
