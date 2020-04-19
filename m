Return-Path: <SRS0=ylBF=6D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924FDC38A30
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 12:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CC9621974
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 12:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="op4QMMUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgDSMac (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Apr 2020 08:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgDSMac (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Apr 2020 08:30:32 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B660EC061A0C
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 05:30:30 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id u12so2497930uau.10
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 05:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aD8Df3yv5nq0S0e26K8zZMahu+f394vmWILGnM9FupU=;
        b=op4QMMUSfqAl8AFGGEzXe6Z1fI09QKvjuXZ9kyhg3JSQpMM4eE/g7d7ZZ01TFotBy7
         0Uvh2qxmUy7+bICDIVkex41TXBxgq5mAMfJrMK5tsK1V/cVyWA1909oq2+k7P61wGFMz
         1vneWc5dtsF4zTrwhtfkbfR4P0etHVVdL8dhpv1fBXtRn1IwYhAuCYHJPSf0h1xMG9bo
         4MwCRg5BK+wB/1U4WKzdaqzXiVHio2jUmsqym+VY3rl6X1ehgdUWPhSoNbkh8uCEs5+v
         hIapbfbEoEijBEe4kl8nrO3VhnDqcKEAj3j0oSMcIo/tQ1jL3VdaYXcYCmj0nB/oARnG
         1+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aD8Df3yv5nq0S0e26K8zZMahu+f394vmWILGnM9FupU=;
        b=cfjDImXQLRGpUuIUxcLpEoP96y36c1Kn0cQQJFMRJM+y/BE9MUAJOMvc3JP9TlOZRO
         YNpM8FwvWcSqfp56xu6Ckh6SvV8Amxn4XV8WvgwiTDOoI8MRlNXCMLU/uBt56Ha9Gm12
         f1ltShCaulbHCfvPqXq3OLh2VHdninvGOdloZz68p+9/5uLhhPzYnvSul4QxU/M6SGY2
         UlgU8rQOie0e1QzynCEgAnqNQI2MwEN8mgFBMy4DI3O39QDFsdbyMdNcbq0wrJKFlIfD
         D/3nkotUpWE0oRU3Ssi5538f9tzDEF5LteQZA2Rl1jRIDiAOsrfZh8Q/1GnredZWwNI+
         RzUA==
X-Gm-Message-State: AGi0PuaX8y7YEcO/yaLmwHwN7AvoHR4aXfSjHTF9Q7xfxGcHaaJMpYE1
        VePuoOQCiTSNVIz+JtMRkjzEXERtvDufh6Yv+tpYxA==
X-Google-Smtp-Source: APiQypLzP+py/e9LO4Fd/ZwJXxw8P/7KhSYcuAN6dVg2MzCRix13XNVI7KcHCTb3oz5HF+Bs9kXqNG0wPZZ+fECGlN8=
X-Received: by 2002:a9f:21eb:: with SMTP id 98mr4601202uac.62.1587299429874;
 Sun, 19 Apr 2020 05:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200418035449.9450-1-congdanhqx@gmail.com> <cover.1587289680.git.congdanhqx@gmail.com>
 <cb96947b36b8ab314f5692daee6f627273ca66d3.1587289680.git.congdanhqx@gmail.com>
In-Reply-To: <cb96947b36b8ab314f5692daee6f627273ca66d3.1587289680.git.congdanhqx@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 19 Apr 2020 14:30:19 +0200
Message-ID: <CAN0heSpZR6HtntK80DhQxtRQZo21GBd3uAKrsJxz_opyun8n4g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mailinfo: disallow NUL character in mail's header
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 19 Apr 2020 at 13:05, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <c=
ongdanhqx@gmail.com> wrote:
> --- a/t/t4254-am-corrupt.sh
> +++ b/t/t4254-am-corrupt.sh
> @@ -69,9 +69,11 @@ test_expect_success "NUL in commit message's body" '
>         grep "a NUL byte in commit log message not allowed" err
>  '
>
> -test_expect_failure "NUL in commit message's header" '
> +test_expect_success "NUL in commit message's header" '
>         test_when_finished "git am --abort" &&
>         write_nul_patch subject >subject.patch &&
> +       test_must_fail git mailinfo msg patch <subject.patch 2>err &&
> +       grep "a NUL byte in Subject is not allowed" err &&
>         test_must_fail git am subject.patch 2>err &&
>         grep "a NUL byte in Subject is not allowed" err
>  '

We used to fail for some reason and it's sort of clear from the size
of the test what that reason is. Now that we flip "failure" to "success"
we can add some more stuff here that works. Makes sense. Of course,
somewhere is a line for stuffing too much into the test, i.e., you'll
reach a point where you should have separate tests, but I think this is
ok.


Martin
