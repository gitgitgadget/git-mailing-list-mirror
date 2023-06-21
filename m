Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66885EB64DC
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 06:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjFUG3H (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 02:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjFUG3B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 02:29:01 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB07A1FC6
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 23:28:38 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51a200fc3eeso7319374a12.3
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 23:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687328917; x=1689920917;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KjDPfLqfO61TssyBps8oudSg+XN5yZu2Vz0Kweokt/4=;
        b=OHfwWZIG+rxAnub4Df0HP2mqC3mn2mtjU99UBzTtzp2z+HuZd0Xq6pmzU62K6UDEgA
         dJMef0CE5WR4I40dHVpeq11oChm4lgK5dS5GBj+RmH2DiQqMOY0F8WXudBvLwhHZxgMW
         qLjOQRdyFVuN8PNPXxr1BbVZvDo4j0Q+4lRiNsrabLRW7YfgYPWI02b1s7v7bs9vNuH4
         ECsU4M+sB/kQSxcW9tFOLZNrysM0M6/9G5JI/n72XW63onOleeqb9WzIIYOBNtHVvEnV
         v35kzdJHv2TNC6olwr6m8VjDbFxNZHORsz1y/T4TGjDJaeFxaMukUSDcMyQK7xOgGXDk
         XEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687328917; x=1689920917;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KjDPfLqfO61TssyBps8oudSg+XN5yZu2Vz0Kweokt/4=;
        b=KpnlAUNPKDOGuK2pkGFYu/0FLegdLK98GWJ1F4gSWE43qev62kWnS6D5F5WZFx+Xmk
         sAod7JhoINUgFADrVC7Lx4eQupr0Aajg001s/8Uoe8JS5bE3oAW1iWt406ASQxXuKq9f
         M1lyO4RNPFYR9BvSdrLcE+uDWQ+teZUnvhcAMiVE7/XFUgVEiCJ5QkBEaulIsLISFUKk
         j1Yf12idRTy1OhvLA2pAhv7BCY42O59JChsI4gBNoutO4FfwW0OdsEHNieofkINqfVdL
         l5b64jPqVjXYQrlzQzz54YCvO1gUiEWePqgPyr2GomlOFOZwItvRi3FpkU2TPR9ayoVy
         RoJA==
X-Gm-Message-State: AC+VfDxupDNdcF5/F9+GTJD5BmP3Quo+c1SF9PzzjNDARih0rcTw6ZTr
        W06Gm9lqAOtP8siNWt3mK83+u8F4gdDx8yikQS8=
X-Google-Smtp-Source: ACHHUZ6dI36M1IfclRgV7RMgGsjd786Z2jvAhuhupyGS1eot1c0oJnlBZGtNdw7dTvxqnTHCLEBnVXMgvzsUUfawknM=
X-Received: by 2002:a50:fb03:0:b0:51a:2f22:6564 with SMTP id
 d3-20020a50fb03000000b0051a2f226564mr9269565edq.39.1687328916932; Tue, 20 Jun
 2023 23:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1538.git.1685303127237.gitgitgadget@gmail.com> <ZHPa27fbAoKL0uGj@tapette.crustytoothpaste.net>
In-Reply-To: <ZHPa27fbAoKL0uGj@tapette.crustytoothpaste.net>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Wed, 21 Jun 2023 07:28:01 +0100
Message-ID: <CAGJzqs=NbfCt78NtANCxTNJxWG+Oc4bLCjhSSQhrOgr0YWuucg@mail.gmail.com>
Subject: Re: [PATCH] doc: gitcredentials: introduce OAuth helpers
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, msuchanek@suse.de,
        lessleydennington@gmail.com, me@ttaylorr.com,
        mjcheetham@github.com, M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I expect, however, that functionally, that will be difficult to do,
> given the fact that OAuth typically requires registration with the
> remote system, and thus we'd intrinsically be prioritizing some
> well-known forges over less-known or personally-hosted forges, which
> we've traditionally tried not to do.  For example, your
> git-credential-oauth contains a hard-coded list of 11 forges

Forge diversity is my motivation! Consider the average Git user. They
contribute to several projects on GitHub. They are deterred from
contributing to worthy projects elsewhere by the setup cost of
configuring personal access tokens or SSH keys. To use five forges
from three machines, you have to generate 15 personal access tokens or
upload SSH keys 15 times. Whereas a git-credential-oauth user can
contribute to projects on many popular hosts without any setup. That's
progress surely.
