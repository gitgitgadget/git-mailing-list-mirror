Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15622C433F5
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 13:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF5C1611F0
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 13:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhISN32 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 09:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhISN31 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 09:29:27 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437A7C061574
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 06:28:02 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c22so49779699edn.12
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 06:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=j51dF5w/S5/9/IVNJGGmfW29jkheEHC6PTE0mNOmswI=;
        b=nNuBK/8olXi9yRTLZ153UQCTKmj/a3alqjr2TdGZm52d9L+6X/Pcbj2DKnObTQSmP4
         3MwZ3qs1CheCQlx1mvg+mbF5KrQFp+5cmMBkxhib45beoveCEE+PQE8iWi9nVPWNFKRW
         +yO0Shqq6jiw6uMInuLjECjcOXVUL+N9kaa9pcf5rysbHUK2sFWJoZKwL4+voF4gX1IV
         1j6ShULIk40dh2jAmfWApI6JqN3O3C0jYSdP0BO5ZqFNK/vbZzeS+R3CcBp1vabIxQqf
         Xb19zkRW+cZx9tDl2Nge6B48GZAcl5nbitcsAmU3Jm6XDk4nybJl9cEG4Rb6NraR7t9b
         3jgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=j51dF5w/S5/9/IVNJGGmfW29jkheEHC6PTE0mNOmswI=;
        b=B3XeHkmRLBNWONu+iVeTHCHbTzG/3fDpO3RLm+LAcQUYzJmMQ6B/Pgs4yPqWXKqgAb
         OCO0e++qRUf5uzYH7jBP4hYV5PWdRqG1JrLBFBXaN1Wld8PqUsR44cJ+KWLMbNozFAmC
         7KV0S2nvJhHUCdDI7PNz1LXwwAA7XCna1O4/RYO3PBO7OLZK1V5ZNSMiSSF58T2z5nF6
         Laew35ptVpsdSfP2OI8fDSGc7rujIuRHmPyMztMfb41Y69vK+g5+W2KBAWPd8DpjimqE
         5w9c08FoZ5P6lUBBXHGZNofzLsMHqzJU0nZAKhpsQgPz32KSxitGb7+FflH4G3YxG4Em
         jbdQ==
X-Gm-Message-State: AOAM533n4FRr8Ejwj0mnwRl5uznwAvf2kc1riHqJ00Zo6k13rACJJe88
        j/RXxzGv9bhBAGUHnqHpetQ=
X-Google-Smtp-Source: ABdhPJzyu7RQsOSrjXu1IKT416DApJDnAVkyrYy1deFhnyeYWYytzkiujee0HHlGvcCgN1N3MkDc/g==
X-Received: by 2002:a50:9d83:: with SMTP id w3mr11117201ede.305.1632058080631;
        Sun, 19 Sep 2021 06:28:00 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c21sm4855690ejz.69.2021.09.19.06.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 06:28:00 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alan Blotz <work@blotz.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH 1/4] t7800-difftool: cleanup temporary repositories used
 by tests
Date:   Sun, 19 Sep 2021 15:25:24 +0200
References: <20210919015729.98323-1-davvid@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210919015729.98323-1-davvid@gmail.com>
Message-ID: <875yuwd7a8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Sep 18 2021, David Aguilar wrote:

> The "dirlinks" and "growing" repositories should not outlive the
> tests that use them.

Why not? The pattern of not bothering to clean up the work scratch are
is fine as long as it doesn't leave crap around for other tests. See the
referenec to "repo" at[1].

I.e. is this needed for later tests that change in this series, or just
cleanup in case a future test ever cares that there's an untracked
"dirlinks" and "growing" directory at the top-level?

1. https://lore.kernel.org/git/87y27veeyj.fsf@evledraar.gmail.com/
