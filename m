Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746FDC433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 22:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbhKVWjO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 17:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbhKVWjO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 17:39:14 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B89C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 14:36:07 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id e12-20020aa7980c000000b0049fa3fc29d0so10570758pfl.10
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 14:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5tkSgewKLdRpynXqqY+38sAUE2w9vD42k4XODXH2vzM=;
        b=i9GPmEJOFGr4sLsLr9zPB/Xo0ZXF1sV3o9w40qkydl7FNnU+vCqAUTsNssWdBS+jtK
         6yNsWY26UbP/oIT+7kwNRYF3VBC3IPlbgySrmgMlWHstK78++WVoZAbXB5ua0V2wwrjX
         qybW4Y0+RLqkW/woxu6aSQcZ+6JD2NRYFHmC5gAz0OcY5BSRMbOXLpPLpGA8Hd9icRaF
         hwEX5lKuUoUALXVRM10hTbDhlcqAC7WyD7kVf8yulA5PL7m9z4A4aGEyLtG+iAFsy1YB
         TFwBdiOGf44fPR8ytmifefawubPbXRwuA8cJ5Dit2S5WRoltZ36eBex205afOZOkMpkY
         ECtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5tkSgewKLdRpynXqqY+38sAUE2w9vD42k4XODXH2vzM=;
        b=mzDM7zxAxlA2L9BtRNP5vfa29L3yzPdo1VW3ZkAndCd4zJjO7NJlx51f5thjJbYVXh
         X6rY2iPX6TF8YKjA2t/Q6dDJ8a0gsZ66M2w+lNMRMLSD47I79Bwmb17ASW01cb2wfOoH
         FKoBIxz/DmnQPC24Ep1xSJTTL3NNJ+f8lQFoui+Co/Kw648tF5HsbzIxKoHOQdHTMhTL
         dpltiZ28hmFVfWf5UBFAXKNpwQY57bxaFhosRblrv8fuW8ue6pZQHbKJ4iSOg9KogW/e
         Oc/ePAfiWXVYSfhnwwyl2xxvONkqTVj/uaUJmYAzemZS2aPByEUJGDSXCe7XPO6P/cHW
         xBpg==
X-Gm-Message-State: AOAM533IuIBxnXb4KT3zjBRV9lowLbFmvjtXnMWlLR1WF4xvCNX8ViwV
        g+Lr9TOXT9UpeqtgoQdPfAu+LaY4wjtUMg==
X-Google-Smtp-Source: ABdhPJxDFp+KFhmd1tq+qRnUbjirR/TzTONX9d2Z2BDSzgD3Bue83Xg6+jE3QhrdFF9GUj2vkzDQvDGw5ggQSA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:120e:b0:143:ca35:11f6 with SMTP
 id l14-20020a170903120e00b00143ca3511f6mr823237plh.76.1637620566412; Mon, 22
 Nov 2021 14:36:06 -0800 (PST)
Date:   Mon, 22 Nov 2021 14:36:04 -0800
In-Reply-To: <xmqqbl2cgj6v.fsf@gitster.g>
Message-Id: <kl6llf1frf6z.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <xmqqa6hznvz1.fsf@gitster.g> <kl6lr1b8qde3.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqbl2cgj6v.fsf@gitster.g>
Subject: Re: What's cooking in git.git (Nov 2021, #05; Fri, 19)
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> As I promised, I've been ignoring anything that won't be in 2.34.1
> until it goes out, so I do not know the answer to that question at
> this moment ;-)

Ah, thanks for the reminder :) Hopefully that goes smoothly.
