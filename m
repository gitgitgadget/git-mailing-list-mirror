Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7EAC04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 16:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A30D61406
	for <git@archiver.kernel.org>; Mon, 24 May 2021 16:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbhEXQ5i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 12:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbhEXQ5h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 12:57:37 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1372AC061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 09:56:08 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id j75so27596990oih.10
        for <git@vger.kernel.org>; Mon, 24 May 2021 09:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=KA4RPrHW59LOCn5FZ2SIGDW6hFhFVLJytwp9t0JNbho=;
        b=vZaghsTcikTFiUR6lnNIX08INXdWZfL6dW7vUGUisSJkj5uAjqxhod0/afQrBwf8lN
         gaBF9KWvlEdwd8pa5a+qF/LJsDWzHTM0g/eXXN2kYGJOM3ATr9Du334T4oVYbWyRW3Lt
         iCX0LAKJO5pqjoyLvcefHQ3WiASzwDUP7hiv3MlIzPbK4EVr9gvPJFJXNsFEwY+QYr9n
         joP7OP09B/JhYG1NdF3ULe1cGyzp1vL8Mn8K8piH1sxfoQOB3qYa5smQQg7I7M9ocau/
         CGhw4iQQkmRJKqE1pph5JWJUOmMmDxsCnfoSnSXodhzqufr5kb4jr7SsHGZMiNwv4tPu
         cV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=KA4RPrHW59LOCn5FZ2SIGDW6hFhFVLJytwp9t0JNbho=;
        b=McYWYF1n13nXR8FBF5OpCDvodh5yJSSDqZwBPa+G6kSO1sm1vxm3Waw9jBHjHvHwPg
         FGXBNjdG9ykkrGSnD8J/GPH0SvunR4b5OPm1Kpizo4q0OK1+iPidbyBpl3J+4KbvWCre
         UHgKtDTxtPswey3MLm82fsnaPay+ttvzZw51eu/7xM9CQWXeWI9giNye1tPWCsYtm+0Y
         xRyl9x2/PPQ4CukZMATAvdpDhb2HT+3WFq+qe5tmVDCHMMD7wI2zEiC1uLOA26sOuXZA
         +AwyguP22tQ0vH0fv+QY0/V5j3LgM/E9XYEEBpBZiVrCDfMuyTVqSBrsCsYsDcfBcJjU
         uN5A==
X-Gm-Message-State: AOAM531ykCz8wIFwtAqZUJd02ykaWV1lneC8AqcmBbivUfG6dFvQDD7o
        6qrkbGZBWc07mp1lu163MHU=
X-Google-Smtp-Source: ABdhPJwPrGTTzBXtjgfClItZ7TuEzy3sw7Ca2+cviSaKV897iGhc0fTSgKEIP1inLe23sDazLJABxg==
X-Received: by 2002:a05:6808:619:: with SMTP id y25mr38288oih.75.1621875367464;
        Mon, 24 May 2021 09:56:07 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id b18sm3190215otk.62.2021.05.24.09.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 09:56:06 -0700 (PDT)
Date:   Mon, 24 May 2021 11:56:05 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Message-ID: <60abdaa5bae55_1b2092082c@natae.notmuch>
In-Reply-To: <7644ac29-2a65-e186-ff40-630dd500e160@gmail.com>
References: <20210523054454.1188757-1-felipe.contreras@gmail.com>
 <7644ac29-2a65-e186-ff40-630dd500e160@gmail.com>
Subject: Re: [PATCH v6] help: colorize man pages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood wrote:
> On 23/05/2021 06:44, Felipe Contreras wrote:

> > Suggested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
> > Phillip Wood <phillip.wood123@gmail.com>
> =

> This footer seems to have got broken between v5 and v6 - were you =

> intending to delete it (which is fine by me) as my comments were about =

> the approach of the last patch?

I was probably trying to put you in the Cc list.

> I'm still not convinced that git should be messing with the appearance =

> of man pages but I don't think we're ever going to agree on that.

That's your opinion, and it's fine, we all have opinions.

But the interesting thing for everyone else is *why*. Why aren't you
convinced?

I still haven't heard a convincing argument regarding what makes
`git help` fundamentally different from `git diff` _for the user_.

Cheers.

-- =

Felipe Contreras=
