Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06F7C54EBD
	for <git@archiver.kernel.org>; Sat,  7 Jan 2023 00:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbjAGAAe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 19:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236720AbjAGAAR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 19:00:17 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01171BC8C
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 16:00:15 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d15so3368838pls.6
        for <git@vger.kernel.org>; Fri, 06 Jan 2023 16:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8Eds5GvjV8Pmmbt1uc6293qD7uSxkInwc6Y94Add1U=;
        b=AYw5QaGL3vSDgPYiwSgSs3XZCAPejhBAOeO2ze3vCQIj1xDJVUOqlQgeTAQkM9yfDH
         0iD3E00HrVyQpZ+mJiE0+FsuaLpXMBMiWnVWBdTHTW65blLDEGwaeXfqJNDcGngQ19rD
         xfK0rN3vn7VX64dwIjgr1Bkni2RczXepH4DvvZnb/v0KkW39LFi0CLgQxSiRVtnzdQx6
         Kc8C18Wmwpvl9hu9i+rLED3idgxGy10Ik407vn5UKZiFZqH5cWgP5rAY0fv5POAc35NL
         vMP1W7mOuODZbqHj2jQsoIgsDFIUJ1mxFlT8cdB0fvGK4dmQ5Qyp1n/U4e0CHqP4fZKm
         amfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g8Eds5GvjV8Pmmbt1uc6293qD7uSxkInwc6Y94Add1U=;
        b=XLbLh+3CGA4qVTC/5GG4JeOB5Gu7peu3pRSc9hk3zLa48ElUUSm7x/qVOdkvldD+3o
         /H3BDD5LNOCnrV8dQNz9ajHJzRfDJAFPz5FRHxa2Zx37hVb5SAJBAtFOuS97r+jSPQZY
         UOu7A4FTEsBqZHFvPBoIAnz12Aiw2xnCDEm59u9SUTFYI8yOuMA8iqSYopYS+z6XwVhG
         9YnCFgCTd/uuE4WGAQWZN09vTwXdjLwY4JJp3yAtbkUjtL+SR2jwvbwJddpdZoFb5FpZ
         hvr02ARDUu2AoVCCK0M1/9aT0G6j3lOCzEQQveIR/dF6FWcYTef93Em4jVfnP3LKQcNf
         8FpQ==
X-Gm-Message-State: AFqh2kpTy+qvvizL+mRmVhLdeKIkCbsTD7JnUjJlqshhyie6EQTnmKTn
        vu4W6EAaKE/wYSIV5OuX2+g=
X-Google-Smtp-Source: AMrXdXuoI9vVVZQ7PIzaMIhIUj/OL4ae/+J8eLp48lnXzSQOC/RJ0m3c9CCf7PzBnwYuV3WO0xFipQ==
X-Received: by 2002:a17:902:ed93:b0:192:ab25:45c2 with SMTP id e19-20020a170902ed9300b00192ab2545c2mr28446006plj.54.1673049615086;
        Fri, 06 Jan 2023 16:00:15 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902ce8500b00178b9c997e5sm1473350plg.138.2023.01.06.16.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 16:00:14 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/2] branch: description for orphan branch errors
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
        <dd86016b-3232-563b-940e-03bc36af917a@gmail.com>
        <xmqqy1qmhq8k.fsf@gitster.g>
        <18ca1e65-3e26-8352-cabd-daebdd0cf7f2@gmail.com>
        <xmqqr0wau6px.fsf@gitster.g>
        <db348ac3-571c-f6ba-c889-9f476f4ae04b@gmail.com>
Date:   Sat, 07 Jan 2023 09:00:14 +0900
In-Reply-To: <db348ac3-571c-f6ba-c889-9f476f4ae04b@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Sat, 7 Jan 2023 00:39:16 +0100")
Message-ID: <xmqq4jt3p629.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo <rjusto@gmail.com> writes:

> Considering 1/2 and 2/2, I think so. But if you're asking maybe
> you're realizing something...

No, I am trying to make sure that you have thought it through.
