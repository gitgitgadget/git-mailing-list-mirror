Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA22C77B73
	for <git@archiver.kernel.org>; Tue,  2 May 2023 09:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbjEBJi5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 05:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjEBJiy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 05:38:54 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EC94C08
        for <git@vger.kernel.org>; Tue,  2 May 2023 02:38:53 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5083bd8e226so5436318a12.3
        for <git@vger.kernel.org>; Tue, 02 May 2023 02:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683020331; x=1685612331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nx+RIHZu+mefitefJiCIGeVXU4wTpy+RTLCJAQRmkso=;
        b=RRx8aiVl6nW9IXA3dGLX776+M11+uq4iITxHgi1T+FDeO7zYAFHgO097AAW/Fclnmi
         DFWT9tlcq2bt9O/Trz3uDntsHu0XT9H3OuutZtFM0bkAVxVXpN/XYaGAwAEfyVRFBcIP
         B7Tji/9bzlcFAYGJPIL7y5/fj8D4BctCSzAUbKoPV436+l8zHZuQqzHLk0QmQw/9oDqe
         jkn43jNJ6T/32DuqUiVR7SMS4/hnZq+lBTIWKg0iOlcQRCry+uU9E8VTMr3IVvHH/L5z
         UjsUT1DUpxcUXMmWOJ2WFb6xaoJIBcTpm4eX8DUQKsZBRSgEWturMDGPnirSo72O8SMx
         DwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683020331; x=1685612331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nx+RIHZu+mefitefJiCIGeVXU4wTpy+RTLCJAQRmkso=;
        b=SiDpieL1JDfQkRRtq9n3/k+lFBJDzc8lv5dFFa31t/6xqSRTyQAiQ4hXWo4z746fSX
         h6+COfxAJAEmQbb73zqvCFGWNrbtl8zB+k506p+vFLvgSDFNvLcdo6LIJNO+bWwHxjEn
         sLu5iAkbYt990mx86eVq9IUKnPJVT/0xzIgINwtd+1nxNi2SqwV/ECgXfRkxAzF53rG1
         +viRwN9cIdqeDoXq5J6CyRaEX71/HpyOF3kVscv+jiJGeZSWd+uC4pjohvjQsfVHn1mM
         5B+s9fG4PtBTtjqzcN2iPF8/O0F22ya/pekZjLGSf/TVp0urDAtgNqN1oZeM68ScPCSm
         tWHQ==
X-Gm-Message-State: AC+VfDxu932jjdxIxxfzm5zQGEZpAPAc5eOOX+jEwiwVH/DfxuIXJCPL
        D3vURHluqb655JZljdF+BtcONIVC/qn22weu8rM=
X-Google-Smtp-Source: ACHHUZ7g1JMPjK0pj4L5oqWsQajUjWIB8Ue2GFhUddnPV4t3+PZUs5RHsQSYfQfiKc08qXAsaXgduAXimZ27ibw2J4M=
X-Received: by 2002:aa7:cd86:0:b0:506:b228:7b08 with SMTP id
 x6-20020aa7cd86000000b00506b2287b08mr8846714edv.17.1683020331455; Tue, 02 May
 2023 02:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1477.git.git.1679729956620.gitgitgadget@gmail.com>
 <35e1ebe6-e15b-1712-f030-70ab708740db@gmx.de> <CAGJzqs=D8hmcxJKGCcz-NqEQ+QDYgi_aO02fj59kQoHZgiW3OQ@mail.gmail.com>
 <xmqqa5yn3d0k.fsf@gitster.g>
In-Reply-To: <xmqqa5yn3d0k.fsf@gitster.g>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Tue, 2 May 2023 10:38:15 +0100
Message-ID: <CAGJzqsm4LmpYE46v2=y4=A+Och44zaQyzTXQRteX-KNSzA_18g@mail.gmail.com>
Subject: Re: [PATCH] credential/wincred: store password_expiry_utc
To:     Junio C Hamano <gitster@pobox.com>
Cc:     M Hickford <mirth.hickford@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "Johannes Sixt [ ]" <j6t@kdbg.org>,
        "Harshil Jani [ ]" <harshiljani2002@gmail.com>,
        =?UTF-8?B?SmFrdWIgQmVyZcW8YcWEc2tp?= <kuba@berezanscy.pl>,
        Karsten Blees <blees@dcon.de>,
        Erik Faye-Lund <kusmabite@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 1 May 2023 at 23:25, Junio C Hamano <gitster@pobox.com> wrote:
>
> M Hickford <mirth.hickford@gmail.com> writes:
>
> > Thanks Johannes for the review and the fix. I'll include it in any patch v2.
> >
> >> But I have to wonder: why even bother with `git-wincred`? This credential
> >> helper is so ridiculously limited in its capabilities, it does not even
> >> support any host that is remotely close to safe (no 2FA, no OAuth, just
> >> passwords). So I would be just as happy if I weren't asked to spend my
> >> time to review changes to a credential helper I'd much rather see retired
> >> than actively worked on.
> >
> > git-credential-wincred has the same capabilities as popular helpers
> > git-credential-cache, git-credential-store, git-credential-osxkeychain
> > and git-credential-libsecret. Any of which can store OAuth credentials
> > generated by a helper such as git-credential-oauth [1]. This is
> > compatible with 2FA (any 2FA happens in browser). Example config:
> >
> >     [credential]
> >         helper = wincred
> >         helper = oauth
> >
> > This patch to store password_expiry_utc is necessary to avoid Git
> > trying to use OAuth credentials beyond expiry. See
> > https://github.com/git/git/commit/d208bfdfef97a1e8fb746763b5057e0ad91e283b
> > for background (I'll add to commit message v2).
>
> So, even though earlier Dscho sounded negative on extending wincred
> helper, are we now on track of enhancing its capabilities?  The v3
> is now queued in my tree and nobody who knows Windows seem to have
> made any comments on either v2 or v3---I am wondering if the lack
> of comments is a good news or no interest.
>
> Thanks.

Thanks to Johannes's fixes for v1, the latest patch should be correct,
but it would be prudent to wait for a Windows user to test.

The utility of storing password_expiry_utc is universal to all
credential helpers. The latest commit message references the
introduction of this attribute
(d208bfdfef97a1e8fb746763b5057e0ad91e283b) for background. I repeat
the arguments in [1], I hope they are persuasive.

[1] https://lore.kernel.org/git/CAGJzqs=D8hmcxJKGCcz-NqEQ+QDYgi_aO02fj59kQoHZgiW3OQ@mail.gmail.com/
