Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65589C07E94
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 13:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 485DA613FF
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 13:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhFDNyh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 09:54:37 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:41493 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhFDNyf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 09:54:35 -0400
Received: by mail-oi1-f179.google.com with SMTP id c3so9785043oic.8
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 06:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=Rd09KujJO2/MCyqLeDFYsS2QSxPFiqaGI9KvedwSx38=;
        b=F3fExyCfbxHlHZRg+BigTlgCzzAuvAuG3u//tyomtQ8S4Fas6+h1wRQxSTynyrRDrd
         +0ZMYRxhV3jCtQ8zLNhwv85glwUFysxu2jxFbHjSC2u4Tekb6YU4XOO4rM+p89qDJM7S
         s4JHs0n5GByIHnPPpGA6FX9MaOtzppj7xo6zWuXXPoCUAL5Q647i4bs4mrWGCtM3KkZA
         s3on0lebGAi9d0URwVhJWIpQZsU/yYz+zfJa+nWsYi+AEu6k5SPFCsnlw+tr5ox/2Tym
         Qiy2pvWc5waNsVVQRHFmLGpiupfgeOFN52NS3r/Mw5qydczg7ayOTdapjwzZwJXrf49o
         3J8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=Rd09KujJO2/MCyqLeDFYsS2QSxPFiqaGI9KvedwSx38=;
        b=O4QHhDxjDvqgvUwDPOt6o7nmJC9cbG5K0NBFJphtBe12KtAms16d/X9ukGH0eTHkIH
         zdhe9XSp4GF+I1g0yfZw0tZYHOe1SRYhPzmnRjOdg2P/666NoIDdmAh1NFcm8msSv1MF
         xzpviZQmW/E5dW3iGQ6c8iAKnejFztBHwxF7Ku4dsTfKLRTUDYENPoVVZZH2ihBjAn13
         /3/7neBN2SPMmQFJD/197HOCzP+xYV0CLYrgm08i2TShMxFGuueYiaXQe+FuYTa7EQPg
         jr1+FeWj3A6iTEBBOLeNHudIYNQChyqiBkkYvL2FflibjVYCG62seD89qk9QT9hhWpI0
         RykQ==
X-Gm-Message-State: AOAM530pHsA6Xt1h3MIVpWcHRsuzbzwLsF2YLRLhgPUqHREKy4wyeyQ2
        lyPOn0Sz38lfVfy+dnFjLVU=
X-Google-Smtp-Source: ABdhPJy0PMdIWnBFZU65jgDezhqDfvYymC+50uevePfm1rAroBRganjGgS+rUjfX2JtQi2VH91Wbxw==
X-Received: by 2002:a05:6808:1142:: with SMTP id u2mr10690135oiu.101.1622814709287;
        Fri, 04 Jun 2021 06:51:49 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id 88sm478877otb.7.2021.06.04.06.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 06:51:48 -0700 (PDT)
Date:   Fri, 04 Jun 2021 08:51:47 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>,
        git@vger.kernel.org
Message-ID: <60ba2ff3cff23_f62a62081b@natae.notmuch>
In-Reply-To: <ca1da892-f8ad-d878-a516-de5b08a99698@suse.com>
References: <ca1da892-f8ad-d878-a516-de5b08a99698@suse.com>
Subject: RE: [RFC] imap-send: support oauth2
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicolas Morey-Chaisemartin wrote:
> 2FA/OAuth2 becoming a more and more regular thing these days (and a lot of SUSE devs being recently impacted by it), I've thrown together a quick patch
> to allow imap-send to support it.
> This uses https://github.com/jeffmahoney/oauth2-clientd. It can be used with Outlook365 or Gmail. It creates a file with a token to be used to authenticate.
> As libcurl supports this type of authentication, it is quite easy from there.

While trying to implement this is nice, it takes way more effort just to
get a client id and secret than it takes to setup an app password.

Plus I think this is abusing Google Cloud Platform. The point is to
register an application once, and that application can have thousands of
users, not thousands of users registering thousands of applications each
used by a single user.

If you have an email service with OAuth2 authentication that doesn't
require a client secret, then yeah; OAuth2 makes sense. I am not aware
of any popular one though.

Cheers.

-- 
Felipe Contreras
