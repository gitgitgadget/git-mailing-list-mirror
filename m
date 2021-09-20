Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A147C433FE
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76FD261050
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhIUC7Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348937AbhIUCZB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 22:25:01 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34271C0A889B
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 11:54:03 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id b15so19869557ils.10
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 11:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3Sc3z1krcCljI0TWv+Psu+xtDXchupZrXtzzBYgFI0s=;
        b=TS1/gAXFXFgj4B3tMVoL25KhetX4z2ParF1gA2q/0OJgwBa2GQmCR2HRSPe3x3KoKD
         AcaxPCbKsDXsByV1QHaItssYsgrnO5DE7j8UlXN2vE4ysVixJuQbSUov3m8B7uWrbeEm
         lqVRmaVnvBldsVkydTqxOlrhbqGYRx02C4usbtBZCQsIXhFXGgVANJoOaSk+LqQwKjmI
         LEn+in0hU/0waPBDePSne1y5QJofSnErlczq+nT2YpsLE/9DSLJhPlan3rov8WZb5+CL
         wQFZT+RuE9FU6kOj9S4xXwDsw0DQ62f5u/JRuzDRhAjBt+z4KcbXyPNtb8XaKGQVDIVu
         sGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Sc3z1krcCljI0TWv+Psu+xtDXchupZrXtzzBYgFI0s=;
        b=mEXBzQqkijq09ptzjuIEcD8hC4MSaorrfiMvkqimHa5pulPIMc15GWL2bGFjQWFZMf
         Scp2LdOo6tqOoSEofzQwAdX24pEreT/cJY2vGy1jlFWuxWw6w9JfAi3T8L3ZKhbLg7U1
         Nev2dSttYkoxDfanVV/UjYP4K8o6QZkk8xH5S8El3muNKS7CgaH3iqSQJmzOIvpOitRO
         ab2TD/dC1PoPbpA65pQYijdHPr0Y65D6ml+quJEo5M8gRVQowkSMan4R/WIK4OSnvq7r
         IpsifkLqRy7cLvN/01TfZJbVuRLo+SEoAwoeMnjq7YML7o3XicUbODDn35nE2rjKpxg6
         to7A==
X-Gm-Message-State: AOAM531R3390WnSzVbSvtfGKNeqY0HaVnb4z4NCEmAOYC/lmeGY0kI/j
        EkuFAQBWdOZwUHXiinN6zgjOswrfCVFH1A==
X-Google-Smtp-Source: ABdhPJxJdtIrp7qk6zFy5Ep4qr+Yl7CpoeU+6+NR+oyVm1iAlbeXgRXHefRr9xu3wOXTZawIb0+EAw==
X-Received: by 2002:a92:c5c9:: with SMTP id s9mr18506825ilt.56.1632164042687;
        Mon, 20 Sep 2021 11:54:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d10sm9782088ilu.54.2021.09.20.11.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 11:54:02 -0700 (PDT)
Date:   Mon, 20 Sep 2021 14:54:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, calbabreaker@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/3] sparse-checkout: clear patterns when switching modes
Message-ID: <YUjYyY+1IXOJYvgk@nand.local>
References: <pull.1043.git.1632160658.gitgitgadget@gmail.com>
 <450b90dad57c42e37a4edc52dac88caf98021fc6.1632160658.git.gitgitgadget@gmail.com>
 <YUjYZNqvvxVRctJQ@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUjYZNqvvxVRctJQ@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 02:52:20PM -0400, Taylor Blau wrote:
> See my message at [1] for some more details about a possible suggestion
> there.

OK, I see that in the third patch we do start complaining about adding
patterns in cone-mode when the existing sparse checkout configuration
does not form a cone.

So that may indicate that we expect users who wish to blow away their
configuration to just run "init --cone". I'd be OK with that (without an
additional warning step, although I think that doing that would be
better). But either way, we should document this behavior clearly.

> [1]: https://lore.kernel.org/git/YUi55%2F3L9nizTVyA@nand.local/

Thanks,
Taylor
