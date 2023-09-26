Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA17E81810
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 02:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbjIZCvY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 22:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjIZCvX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 22:51:23 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8AB9F
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 19:51:16 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50335f6b48dso13292394e87.3
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 19:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695696675; x=1696301475; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jgM7tZivuHoue/Bmbp1yfU0eh5mp//PYs163eSwu2+Q=;
        b=kN3cQHJ94OnAJMCkKVLjcgE4L8oN0ffjgA6xbDUzCBoE4xKkYWXQfJcav4vog53Alf
         rZGXVDdL0Qs6a5LqJbsdAKRFZNH7gma+O+Ijq8ymczfVRFyE36YiZu4spXjp76dwLY6s
         WDVRVcyhm45nHeCZmntEPGYEjtwq8GDBcwm99JPnqcg+pe/Aq0reYOwuW+z8umVgRScB
         9kPhuOqeePx6O7cs0ao6HRyseBgc1BOnYoDep7lBW7KGzDUDdGvHuGxucIfJHMA5wFBB
         oZIikcc6eEFzMdSE+8vv6LRWPicUbmuTgle+5LK5kfxCuQGWBycKXvphxPoCOLbVoOVF
         pLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695696675; x=1696301475;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jgM7tZivuHoue/Bmbp1yfU0eh5mp//PYs163eSwu2+Q=;
        b=YACK3ZOXOSjWRG9I280RcuGlWj4PKG9rNstAoQqqgQWFjwS8+Osu0t+1aKIP0I+zkp
         J2omOnDcY8+Jvk2c/VZTK31vaZCgV5pCDQ0fQ7qes1Ae/b5jl5FjdgcBvT8DDjqRJVbT
         XeZH21wpri7HUbGRxhJo6gPdFmIAnyVQ5cW36VV3ddOK7NOWuEWh8SATWssT9cExdgwj
         U9bKio7SjP44eQik8SzdYGVWLmbRmJYW6SPD3hsEOrQHI4xfN6+V8X+epxsa5OidJbRk
         00lG0lrKukmRfqae3gFcCG5jilyLOxg9cAHeBzWlhd6hqK79ziWBScWLhpZ86rkXPfS0
         oAEg==
X-Gm-Message-State: AOJu0YwF/+LE0x/TwydbO7Z8MsRr9mWNRwHt21mACnITh7BB9tx8XOMS
        GPXv9yU7FBpkBk2diW4sgR94LS8tUQmNasLQxyk=
X-Google-Smtp-Source: AGHT+IHNSzbgb/EEDV3Mu152IUa/l0hm5ZjOVYy/f5fPzwPTWP6PWfAesCV5ukW4IFT9RjLY/msahw7id5l6tUfBELk=
X-Received: by 2002:a05:6512:a94:b0:501:bd6f:7c1e with SMTP id
 m20-20020a0565120a9400b00501bd6f7c1emr9378505lfu.33.1695696674868; Mon, 25
 Sep 2023 19:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <pull.950.git.1695391818917.gitgitgadget@gmail.com> <f3081838-ca50-4a7d-b2fc-6f0f1f1364a8@app.fastmail.com>
In-Reply-To: <f3081838-ca50-4a7d-b2fc-6f0f1f1364a8@app.fastmail.com>
From:   Josh Soref <jsoref@gmail.com>
Date:   Mon, 25 Sep 2023 22:51:03 -0400
Message-ID: <CACZqfqCfvWASMPMxRpRuAUQPcprcB4RHxxke_qTZ3bFGLf3T8Q@mail.gmail.com>
Subject: Re: [PATCH] pretty-formats.txt: fix whitespace
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     Josh Soref via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Josh Soref <jsoref@gmail.com>
> * two spaces after periods for sentences

Kristoffer Haugsbakk wrote:
> Where's the two-spacing convention documented? I didn't find it in
> `CodingGuidelines` or `SubmittingPatches`.

There appeared to be too many instances of two spaces after a period
in the file to be accidental. In some ways, it was an invitation for
people to indicate if they have a preference.

I personally do not have a preference between two spaces after and one
space after, but I do have a preference against a mix of two spaces
after and one space after.

As it (IMO) takes effort (admittedly trivial, and quite likely
habitual) to insert a second space, I assume that this was a desired
thing and the one space was the aberration, hence the patch went in
favor of two spaces.

I'd just as soon submit a patch the other way (and if people have an
opinion one way or the other, I'm happy to include a change to
CodingGuidelines/SubmittingPatches based on people's opinions).
