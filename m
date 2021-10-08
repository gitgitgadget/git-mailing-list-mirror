Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BEEC433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 20:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA07861019
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 20:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242175AbhJHUZT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 16:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbhJHUZT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 16:25:19 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83278C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 13:23:23 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id o10-20020a65614a000000b002850cb8c434so2188365pgv.13
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 13:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CqPkcIN3U0dQInZPkiv1GX5+1l9mWxpwsj2V+UyXrEs=;
        b=Pq0gznsuNA8kKvQ/NvWZUl/0zLLtLAWQLxu5cErWnQ/znPbMqNOX4Lu+y0y/WzQStk
         tlSlYIuc8JgEHvv5ffhNNg/u5WvqG3zYmUh7z3O4aFg2dM8knNUB3dYp+MRrTgNwT/Hj
         3OZKOqCptIgK4G1nkgcy28Vya+ZGaJllMtPsz2xl26imyzGf5pLr9xtZ054vk2N16slc
         YgohyVHRdbLLJZNt20cUbasE7tn2rgNLYYKCV/7BMJb6dK6S/u3Vn9Bzw2dccUhRFOpS
         D3MPmnchmuAxmFO6dR/FbOLFmMAH+ykqNLYiwln//KRa36SqF3z5pF3BXZXPucukg+pC
         1B1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CqPkcIN3U0dQInZPkiv1GX5+1l9mWxpwsj2V+UyXrEs=;
        b=EGGbldWUyxKbg6d46L6nJpMCTBDX6mhTXFT0j4KbGIQdKnZ5eWkSMmh6ERcBcDfM1c
         7lvAn0p+Ge2YbLed0pc5P4vk3jRoZuEGFSRpqjiZI+QXv2ICAFErdWjpaVGXaWJjyHZY
         TXchyTg4c0Hm5U2JmhAL+E6FobyvYeB45pYkipUzcV28EeN6L0D7J0Hbeou9v7OAuj+Y
         5rpb7tEhhV8tQ1MDdJCFMlilEfEyzEEQqp4Nf9MJis6bonoDfh1PkeoBpoHVB4vNLP6A
         M4jg/KHiwxr4JL4WRU32PrUnZye9CZ0wMQUI5LFZp1hn/w3pgjcDFH894IxYR+Dn/fHG
         h4EQ==
X-Gm-Message-State: AOAM533YxARZs2rlmb7/GTTo3sC3+bbSFE1DUwSa3SaIXBlhP8R2R1YK
        TnZ7KsphlNaAvW35/U9ZN4yGGN/BFWah9I2av8Dl
X-Google-Smtp-Source: ABdhPJyibHrOnV8HY4IQtps9uL38JKt1hzGsjmZv6HPTn8hzkreioZZK+QR/QEY9Y/UXfxH7z8LuxRS/3NQ32vTw47IJ
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:d251:: with SMTP id
 t17mr6385173pgi.68.1633724602991; Fri, 08 Oct 2021 13:23:22 -0700 (PDT)
Date:   Fri,  8 Oct 2021 13:23:21 -0700
In-Reply-To: <YV89ybxIomWjSkFG@google.com>
Message-Id: <20211008202321.1326876-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YV89ybxIomWjSkFG@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: Re: [PATCH v3 7/7] submodule: trace adding submodule ODB as alternate
From:   Jonathan Tan <jonathantanmy@google.com>
To:     steadmon@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On 2021.09.29 16:06, Jonathan Tan wrote:
> > Submodule ODBs are never added as alternates during the execution of the
> > test suite, but there may be a rare interaction that the test suite does
> > not have coverage of. Add a trace message when this happens, so that
> > users who trace their commands can notice such occurrences.
> > 
> > Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> > ---
> >  submodule.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/submodule.c b/submodule.c
> > index 4bf552b0e5..61575e5a56 100644
> > --- a/submodule.c
> > +++ b/submodule.c
> > @@ -201,6 +201,8 @@ int register_all_submodule_odb_as_alternates(void)
> >  		add_to_alternates_memory(added_submodule_odb_paths.items[i].string);
> >  	if (ret) {
> >  		string_list_clear(&added_submodule_odb_paths, 0);
> > +		trace2_data_intmax("submodule", the_repository,
> > +				   "register_all_submodule_odb_as_alternates/registered", ret);
> >  		if (git_env_bool("GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB", 0))
> >  			BUG("register_all_submodule_odb_as_alternates() called");
> >  	}
> > -- 
> > 2.33.0.685.g46640cef36-goog
> > 
> 
> Can you also update the GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB note in
> t/README about tracing in this case?

Good catch - I'll do that.
