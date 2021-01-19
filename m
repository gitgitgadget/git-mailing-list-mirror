Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23020C433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 08:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEEC423129
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 08:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbhASIbY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 03:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389141AbhASFYE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 00:24:04 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AD3C0613D3
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 21:23:19 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id kx7so1757777pjb.2
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 21:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:to:cc:subject:from:date
         :message-id;
        bh=0DOBlhPQda3U0/FgjcmBYW5+3/XNag9Pw8RBADq9RyY=;
        b=mQffzrnLg/Y4KcVrXRkgsp+6VPbwW0Df/xa+1l91QDDou/L7VnW3zK0wonPJcVZhIG
         EhlQl0t728eJKLtaeuoXH2JoR+xzoc2j+jrRo6Hxz8yU5oLw8mh2JxKU8e3mg9khS8ne
         ftDI8NmZ2pVdidtvvfj7mPQceqc3kMGckuSAsXJtT+FYwFUAtGNOFYdiSwHLlIkPTL6Q
         ooNHxZkwR6JcLFA0kiEPYcC+pKdAjzhIDQ8YaBIqnFhSE9LdVes4nWeQl3kLiD+wMuGi
         +6qsRtRp/XCMKhbKYMxZC1gV1ypOPLy3TdGa2ijVlY5RufPq6iUcgUBb4xqg3NH1j1Fx
         d8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:cc
         :subject:from:date:message-id;
        bh=0DOBlhPQda3U0/FgjcmBYW5+3/XNag9Pw8RBADq9RyY=;
        b=QYUDIy6DH8U+XdcdK/MzYRxie3i8hN590IBxkTWyIL7TVO/XLTwnHsaVrZamQaaFMd
         to377i+3UAWaSfgluRO0m5aFKaJPWLPd1btXf/gEAc+hsY5vWpBb3CSYGn11wpGdJD42
         Jarg9+U0zDAXQOCOFpXLXSTonH7ul4TMlmuf5Nz6LInrH2fjnV46Xew6kIttx9xKWmvR
         QlJe92lyF490pkQItKcB0pILeGpmXBpFtlIziej4e1ZanU3iGnqivVRkuiX92oWUVK6z
         mbPaypuC6uXs6hzqom1ikfUEbCykt+3vqPY8WAU5BnB8pihjPd4ltZvEYBEE7cCVxjVU
         Ni6A==
X-Gm-Message-State: AOAM532GeJvm0cjnKstiNM6zzBiapAsA1H1+VldAghTXpaF0ZsbDji45
        R30fxIA52WuijxsFnZO57nLqMTEwj37PvYOE
X-Google-Smtp-Source: ABdhPJxDzOEq5/dlfsIXBf93tJUhVWT3s4LPSf0qQwwOZxTVavHO6vycSZqVEHD7AEcNIBcKknShxw==
X-Received: by 2002:a17:90a:6643:: with SMTP id f3mr3355144pjm.33.1611033798475;
        Mon, 18 Jan 2021 21:23:18 -0800 (PST)
Received: from localhost ([193.37.32.27])
        by smtp.gmail.com with ESMTPSA id g30sm16558981pfr.152.2021.01.18.21.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 21:23:17 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
To:     "Derrick Stolee" <stolee@gmail.com>
Cc:     <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>,
        "Antonio Russo" <aerusso@aerusso.net>
Subject: Re: DEVEL: Help with feature implementation
From:   "Aiyee Bee" <shane.880088.supw@gmail.com>
Date:   Tue, 19 Jan 2021 05:20:26 +0000
Message-Id: <C8MVRAPKXPBQ.1W6AFAP98O91P@localhost>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Forwarded message from Aiyee Bee on Tue Jan 19, 2021 at 4:58 AM:
Hi Derrick and Junio!

Thanks for confirming my suspicions, that there isn't existing apparatus
for doing this, and a new bit can be added as a flag. Thanks for the
*pointers, I'll try working it out! With Antonio, in fact, since they'd
need the same thing for implementing the opposite feature.

As for the justification, to elaborate on what I said in the opening
mail:

This option would be pretty useful when used with diff options, to see
how
much two forks have diverged. I recently wanted to compare two
long-running
forks of a project and see how far they have diverged. I used the
options:
--simplufy-by-decoration --decorate-refs=3D"refs/remotes/*/main" -p

But currently with this history simplification, the diffs for both
divergent
histories will be created against the last "relevant" (decorated) commit
instead of the last common ancestor, which creates pretty useless diffs
with
a lot of intersection between them.

You're right that the option doesn't sound very useful when thought of
in
regards to history limiting by path, but IMO it's pretty useful in cases
like these, when you use simplify to get an 'overview' of the history.

Also sorry for the blank/duplicate emails everyone! My email client
seems to
be misbehaving, largely because I tried to tinker with it :P

- Aiyee Bee

