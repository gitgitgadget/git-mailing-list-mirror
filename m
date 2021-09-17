Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB36C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 13:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3115B6113A
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 13:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240134AbhIQNop (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 09:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235488AbhIQNom (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 09:44:42 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1E1C061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 06:43:20 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id gs10so6375415qvb.13
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 06:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J9J9iuAQQNEbzE3ScjljWMYS9X8FCM77zJNnmPTYu48=;
        b=OZH5y7Q9fI6NmWC5T2nJT7DOKeN3BBwN1yqycIsnbAv7wgTSuGJCH4TdipiP7/J3t4
         AiO9105SPRVyqjmsrYKOaxUa+fKEK07apslCZELzDjTo/DwmFrmy08vhQ+LLz8MPlyAe
         piSsl8jnpYRXVcCBjSt7QTC5WmAAqmYIM4Zj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J9J9iuAQQNEbzE3ScjljWMYS9X8FCM77zJNnmPTYu48=;
        b=5UDU3OWcKlpfoSRy//h6A1ah3h2n5WwPNXCix3hKPN3t+TuTluX3GEElO0lrJjMAzk
         qHH1xkOAQcvCMtLMOymWY5zKvzZ9KtqFl8A5DQnAwMttzpz2wlRQ1s/aQvlEj4RaPNWe
         4/JX9idbOADR/oUckBa/czwUZjMhYzP3GHqFJ/dPHDzvvj+4lqIxs/jWW4hrBQK+wS6W
         0TL9tx33rRX0YYDHc+XRRvRZnDQQWfVyB3UYqxYAWKdJbJOvZ0xuEhWiycoiGtqgPQok
         Da+dYG/DXCjKsP2fDKH+e8rHjX4qGVSnbGDAn2vQO4SfFYuiiFB3CHfBemmpS129lvWH
         WkpQ==
X-Gm-Message-State: AOAM532f3mZk4HvNnffA1hemH7cNBdK3l+bJQrTE4eD3IGXd/5YKBpdP
        XUazlZ09Nq+T0/8+gJiSPRJvCQ==
X-Google-Smtp-Source: ABdhPJwnyPw02lc1mibBgnPICeBKayJYWNKB3MnRMo+MSvWRmVdcDBqBaAYPiEkTvUJMbHjZ2wJn2w==
X-Received: by 2002:ad4:47c9:: with SMTP id p9mr11069945qvw.25.1631886200108;
        Fri, 17 Sep 2021 06:43:20 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id y15sm4380892qko.78.2021.09.17.06.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 06:43:19 -0700 (PDT)
Date:   Fri, 17 Sep 2021 09:43:18 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: [QUESTION] How to add new configuration variable
Message-ID: <20210917134318.scdqa6k4swzgo5k2@meerkat.local>
References: <9f3cc3f0-36db-f7e5-de1d-2c8c9f246884@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9f3cc3f0-36db-f7e5-de1d-2c8c9f246884@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 17, 2021 at 05:44:42PM +0700, Bagas Sanjaya wrote:
> Supposed that I'm writing git-foobar script ("git-foobar.sh"), which takes
> configuration variable "foobar.something" (string type).
> 
> How can I add that configuration variable so that it can be used by the
> script?

You can just add it. :) Git doesn't complain when it finds configuration
parameters it doesn't know anything about, it just ignores them.

E.g. in your .gitconfig or individual repository .git/config:

    [foobar]
        something = yourvalue

-K
