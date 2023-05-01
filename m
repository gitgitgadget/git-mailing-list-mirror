Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32308C77B73
	for <git@archiver.kernel.org>; Mon,  1 May 2023 15:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjEAPYh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 11:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjEAPYe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 11:24:34 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972C0172B
        for <git@vger.kernel.org>; Mon,  1 May 2023 08:24:26 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b4bf2d74aso1785767b3a.2
        for <git@vger.kernel.org>; Mon, 01 May 2023 08:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682954666; x=1685546666;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xL+hr8v2Qo5xUFPfx3YTCYJEnXcItO0p5bsPXD8Zuv0=;
        b=GFnke5+KQHNuXQ16113p3/OzDhSrlgYYDXR1x+UOoBstlmpsq7RgFhP5yx8MHffwtQ
         sZ5IWMa6G7c7JIqsWsxN9bwLxahYJpfJbSZrldEV6C3biusy4knFQN6J+Ul56Bp6gWs3
         FRct1p1BiUPYUPDCq/bkqI3R6uFjdDLfIEDMc0AAVcA9R8VbQXqKaD/hDzN1APPSKL2u
         pHSmsi4yl/NRLocU7pE3BJRES1AN/OI3BOU1bT/Pge5VX6srAGdN305xRNZeB+NNo7ZN
         YEdgOd/S+ESfKtGLFvwudrDkb6rX/cbJZ1HNRHiiVzN16rerYKX59xUoPWGtDAHMzgtp
         FUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682954666; x=1685546666;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xL+hr8v2Qo5xUFPfx3YTCYJEnXcItO0p5bsPXD8Zuv0=;
        b=HTlDUA6PzUYHgFowGaslZrt/CK4+CcXy7XtUa3HwdV07qhkapbu2BxUg3A23sHKVCV
         zlZ+SHLHGQhQI7LfucXgvklWCzXRmH2OSfgTuiZvT5HJcm+uLQ8HOBDj7XWUZzNNTv6M
         ExXCfo3SrGRl2qOjTYb51Gh1qgm6kiE1PzAZvX0NO3OiOlwKhn07OWX7coEfK9TRO10C
         eL7YvHgQn17Ta/cufnyBnS9D05xOREDyS6ZOb6U/B+mjZE2mSr16vjEjV6W8VtiOGI5E
         /DuvMFe7G5Fi7bTIPJZXIpEfIaYPOg8W74VlXTGN/TqjsEJzwJ1Tz9ism1suDM3fyuQ9
         IGPA==
X-Gm-Message-State: AC+VfDy0Y3mVhya3BGMPh6e/p+WIP+GcScML+faWTLZcSLrNDRLdGPf9
        sy7alUggXidYF0pQegR3Q7N7DUg0An4=
X-Google-Smtp-Source: ACHHUZ5WX/ST9ojAABKw5Xq0pP385GZOxNS0CPlhXD3oCr8kqUUzlPy9uwXthvUZHf8LyO670Aa0gA==
X-Received: by 2002:a05:6a00:1884:b0:63b:8a38:b1bb with SMTP id x4-20020a056a00188400b0063b8a38b1bbmr21352634pfh.7.1682954665977;
        Mon, 01 May 2023 08:24:25 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id 188-20020a6219c5000000b00640e01dfba0sm13641388pfz.175.2023.05.01.08.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 08:24:25 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t/t3501-revert-cherry-pick.sh: clarify scope of the file
References: <20230430100034.1889796-1-oswald.buddenhagen@gmx.de>
Date:   Mon, 01 May 2023 08:24:25 -0700
In-Reply-To: <20230430100034.1889796-1-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Sun, 30 Apr 2023 12:00:34 +0200")
Message-ID: <xmqqa5yo847q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> The file started out as a test for picks and reverts with renames, but
> has been subsequently populated will all kinds of basic tests, in
> accordance with its generic name. Adjust the description to reflect
> that.
>
> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> ---

> -test_description='test cherry-pick and revert with renames
> ...
> +test_description='miscellaneous basic tests for cherry-pick and revert'

Looks good.

Will queue.

Thanks.
