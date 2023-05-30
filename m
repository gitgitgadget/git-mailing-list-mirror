Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22FFC7EE24
	for <git@archiver.kernel.org>; Tue, 30 May 2023 17:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbjE3RaR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 May 2023 13:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbjE3RaA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2023 13:30:00 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA4F123
        for <git@vger.kernel.org>; Tue, 30 May 2023 10:29:36 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba802c775caso9299468276.2
        for <git@vger.kernel.org>; Tue, 30 May 2023 10:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685467775; x=1688059775;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BEjTGuICnvtsZ+bX3gVUCaqxm8/bRuO9kTiH9hfwe2I=;
        b=dvsHE6iNIM1sivP2wGGB4Wrfr0fFYIaJ7zVRGXkotpby9iL89XC6Yo8BSOwv5KkpPM
         xM9UMIlmWC0BsaOVHtuArxBvDPg23ZMq9nk0m3v5+mU8BH5nhO+m1Z2S0YT3qqKm1Dkk
         a519sfGzGRbTskaHgdXCr/0ygonXLGwl9TKNzA0UH++jleGkaRpCtvAxA7IS2h9sgww4
         HfICMwovuKkJbnjDe9J0LBEZub9tvYDNTNTD651ZRrG9aqBrs/JGHv6pGrmVdEvcx0cC
         z0l+IQfm6e6lZIelGeTxbQhZuI4QMIdnxiFUtTtZToxid5bVcgYm1iv/nN9x6QhL/frf
         HabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685467775; x=1688059775;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BEjTGuICnvtsZ+bX3gVUCaqxm8/bRuO9kTiH9hfwe2I=;
        b=cOHRDgCG1kPJvlBi4UiGTReuE/7szTRmqDZd6XWyB375wpzg5sKx06SMbYO322MCCJ
         5fosNrTJdEMfKal6qjYVtRObJFAJR2Z6FfRZW5b81LsitU52uJ3cTWHyc7gYPwI/vSIw
         Wy0Tgz554lE26hluFLGKV658xIjvuK0UHplc+Ge8RYPy39pbrDI5ibkG3lyp7KSnySAc
         WhuxFQkvk+IBb/8BkyTU9PAFBNIPupFX5V20sdLde3tQ2w6e66/moowmFH+47kyvx8Mn
         fi1E72dHFO0Znb5sveQ1eqYcch/CEefR9qRfbH8HEse5AROni0VmvRvst6eVvVcHq3kj
         qfig==
X-Gm-Message-State: AC+VfDwCMtkfX5RdcnUchIJ66TbVcKn83YJLvrSZMlrat+IjEonfB2B0
        uCMlAOpXDtnDdX0BgZW8sncBnYw35j+y7Lw8j1CC
X-Google-Smtp-Source: ACHHUZ4/QX4fmmIAl3VOE6pIqwBTyhMnfrchFb2tdoS0GCOpEDXRs2ExOmC+yVqLwdWuDEjTPTsRel6g/JvUly9U8voQ
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:45c4:f45e:f82a:5d18])
 (user=jonathantanmy job=sendgmr) by 2002:a25:bb4c:0:b0:bad:99d:f088 with SMTP
 id b12-20020a25bb4c000000b00bad099df088mr1852283ybk.11.1685467775439; Tue, 30
 May 2023 10:29:35 -0700 (PDT)
Date:   Tue, 30 May 2023 10:29:33 -0700
In-Reply-To: <4d29e5d4-6ce3-c099-15a7-e89ad787780d@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230530172933.2781693-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 3/7] sane-ctype.h: move sane-ctype macros from git-compat-util.h
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:
> > Any specific reason for the "sane-" prefix? I think it would make more
> > sense if it was just named ctype.h: see below.
> 
> I don't have a strong opinion either way but "sane-ctype.h" makes it 
> clearer why we're doing something different to the standard library.

Ah...that's true.

> >> -extern const signed char hexval_table[256];
> > 
> > And this one has nothing to do with ctypes or sanity, but rather, what's
> > considered to be a hex character. I think we need another patch to move
> > this to hex.h.
> 
> Isn't "what's considered  to be a hex character" related to ctypes and 
> sanity though as it is used by the "sane" definition of isxdigit().
> 
> >> -#define isxdigit(x) (hexval_table[(unsigned char)(x)] != -1)
> > 
> > Same for this one.
> 
> I'd much rather keep all of our "sane" ctype replacements in one place 
> as Calvin is proposing. isxdigit() is defined in <ctype.h> so it should 
> be in our "sane" version of that header.

Good point. 
