Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C1BC432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 11:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A5126054E
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 11:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244318AbhIBLKD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 07:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhIBLKC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 07:10:02 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88D2C061757
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 04:09:04 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n4so934893plh.9
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 04:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=efYpSssCL1d454FRTlVfSkq9zNhOwyMrFdaiOBWhwjg=;
        b=YFc15K+IefTpSlgBJRlVkTHsmwPaPqZqhrCJTI1S3O2Tc2uqZT6zFA3Ds6F5xf9h/9
         gCY476kkwSlnWd5hrPNkPEdrRpukSoM+N4LonwW38q7W6/y5CF28IvP+w3auL4CyBz9B
         sVpU9kBvO8zirh6Da81RNvyM1J/0/Zh8JXgxRXcr/Ve5rKJPWAd2Dqu+5GCqZP4Gu4TC
         P/T02GaA1fYjWAGP+kL86tCkdf4/iyPpBby9ph0ShmtTMrvQ+d63wX4R88Xhn51Z8zyr
         oHjRwP75c8QQ2jpBdLWCckkjkDvHkkM0kJbIybKjwTOUh9oyhGS1MIbVFogElmat2FxD
         beNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=efYpSssCL1d454FRTlVfSkq9zNhOwyMrFdaiOBWhwjg=;
        b=b2/o01LQJtNlSbFfVBmJYnY5BSCMLXKkxA3ZR/xGKbn+0w5fqdJ7gjLt1J5vajRGuF
         zKBQjRUIsWBzvqXbqVyAQNmndo4VwAfPi66QHfUk9KMgBGD/DnhuZFcpYoF8XOzuVeEp
         QvdhodJI4aSI0RUgzm7ideyuNgrwVCtXCbqxqQ9hH2R/Q1LhOl68cgsPl/uVGhkslNG4
         YXEpocO7FJn5nWSM3vGyBpTJ3y/cSwRv57Wvf+mKR80uvYTy7SLfFdtgy9vhIb+uUOo4
         0mRzxyoNXoXOUrJbS06SY7E6amBXyGt9HnsHjoxzsK0RWmHqwE9sBXEu5JDrlBO7PnKq
         ZerQ==
X-Gm-Message-State: AOAM531kCbbXcKXTf3x1mao3Gi+pXpX+s7LTWtxjPZbaBLOchyoAc5NO
        RGy/iXWoce41RAA1fi0zKMk=
X-Google-Smtp-Source: ABdhPJwU48nqRvWTrkY9d4pqapV/uOb1ScY/gbNaCVGkhHGvm8CGQIZk81vPyDqbTG5J2a+XdK3t6g==
X-Received: by 2002:a17:902:7145:b0:137:2e25:5bf0 with SMTP id u5-20020a170902714500b001372e255bf0mr2428408plm.10.1630580944260;
        Thu, 02 Sep 2021 04:09:04 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.145])
        by smtp.gmail.com with ESMTPSA id g37sm2480676pgl.94.2021.09.02.04.09.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Sep 2021 04:09:03 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        jonathantanmy@google.com
Subject: Re: [PATCH v5 02/14] Add new parameter "carry_data" for "show_object" function
Date:   Thu,  2 Sep 2021 19:08:55 +0800
Message-Id: <20210902110855.75687-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.456.g1a7c4c5894.dirty
In-Reply-To: <xmqqlf4oc4u1.fsf@gitster.g>
References: <xmqqlf4oc4u1.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Since this lacks <area>: prefix, "git shortlog" readers will have a
> hard time guessing which show_object() function this commit is
> about.


Sorry for the late reply.
Agree, it will be fixed in next patch.

> But it does not quite explain why we need another parameter to do
> so, which involves changing the function signature of many
> functions, instead of making show_data to point at a new structure
> type that holds the original data show_data used to carry plus
> another single void * member (or the set of members you'd be
> carrying into these functions using this new parameter).
> 
> I also find "carry_data" a meaningless name for the parameter.  All
> in-parameters into functions are used to carry some data into it
> after all.  The existing "show_data" at least makes a bit more
> sense; it contains data necessary for showing the object in these
> code paths.  If the purpose this new thing was introduced is to
> cache ownership relationship data, perhaps ownership_cache would be
> a more descriptive and understandable name (be it a new parameter to
> added to many functions, or a member to the new structure that
> replaces show_data).

Agree.

I think "show_data to point at a new structure" is a better idea. I will
follow the idea and optimize the related code. By the way, the naming
about "ownership_cache" will be introduced in the next patch too, unless I
can find a better one t(-_-t).

Thanks.
