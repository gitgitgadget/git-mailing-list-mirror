Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346F6C47091
	for <git@archiver.kernel.org>; Sun, 30 May 2021 16:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03B1061108
	for <git@archiver.kernel.org>; Sun, 30 May 2021 16:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhE3Q3m (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 12:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhE3Q3l (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 12:29:41 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B63C061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 09:28:02 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id z3so9901079oib.5
        for <git@vger.kernel.org>; Sun, 30 May 2021 09:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=JK3Yf7MzVI2ByqmZWRLfFxmgjmEQYdgAPGaPJBmTc2o=;
        b=VOkOYt+jgJEu/Zo4O4qO/vGnd07ZsQ6NC2WtCsnaz7L7UCBz0tJTa5a2E9IwGAwj9p
         ltd9zwbj16198BkpwIPIzaSbkSmNetp79u6GMrNiUHQC3gdW/v3lu6E/kh4aQjoruYFM
         eyWHbrg44xeJiSRvnVlNH0HwM1ofLOgEVyhevSOxLsWRyVLmeBxUIE644Tb3c5SlHThQ
         sGK/xwPL4gn4w65z1Aa4yelj8h7JlKu8PO9KbCKolS2s2IJmy8jn+LSc6WPCvpzBbcms
         tiy7ZPaNy78EYo5czrenur5hZNze+XzvJXBXdO6zOt5vUpCaG6dPHjrYXHCAlGt41Ups
         s2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=JK3Yf7MzVI2ByqmZWRLfFxmgjmEQYdgAPGaPJBmTc2o=;
        b=PIfzRz+wYMgcR/Z84x8L6IhiUJrnK8xcqCgCTGPBPfKSAAuFtsb61ie/Pc9dhYmeRL
         pq5ZiEExcKkUAJ9JQzYmk+kae3MtFbEuDYvVksohxO/I549FciqOnvN2Lb0GD2j9Hf7X
         2zq7SQdlpG6LFV5NHxOoE3asBQaaB3HG5vKcWp61CGtT5oZH3QgdvspD2Jx2dvTMerjy
         nS3we5LE1KhujkZCI+HPXgJw63CTbzTVmZ65NMkFMWijBPOFY4Ntjx/OSGxaf46x9bz9
         LNPhQMHE8YkxBOZlItFgmnLQ6CmJYke9kfWTnWber8uJxW831fUE8Cb27BtBp54DKh5y
         1FqA==
X-Gm-Message-State: AOAM530kQ8UpCbz2RdzeqM9UId5n1XucqHjC0Z9GJ4fpsKV7ifUDvV+e
        L9JqCLpYpjNFuK9nKLCzOp8=
X-Google-Smtp-Source: ABdhPJwjkfgN6tv0JXbQjlGl0bP95NNGEN5HNNlr75yUzaHp3WdpWiNr+oDh6LiBG9OWRKpnCVCw5Q==
X-Received: by 2002:a05:6808:10d:: with SMTP id b13mr1611476oie.15.1622392081921;
        Sun, 30 May 2021 09:28:01 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id f2sm2494476otp.77.2021.05.30.09.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 09:28:01 -0700 (PDT)
Date:   Sun, 30 May 2021 11:27:59 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60b3bd0fb6d4c_b937208dc@natae.notmuch>
In-Reply-To: <ad0751c3-654f-04d4-5ad1-c0aea91b46b8@iee.email>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
 <ad0751c3-654f-04d4-5ad1-c0aea91b46b8@iee.email>
Subject: Re: [PATCH v2 0/6] Unconvolutize push.default=simple
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley wrote:
> On 29/05/2021 08:11, Felipe Contreras wrote:
> > Tired of jumping through hoops trying to understand what the "simple"=

> > mode does, I decided to reorganize it up for good so it's crystal
> > clear.
> >
> > There are no functional changes.
> >
> > Basically the simple mode pushes the current branch with the same nam=
e
> > on the remote.
> >
> > Except... when there's no upstream branch configured with the same na=
me.
> >
> > Now the code and the documentation are clear.
> =

> Not your problem, but I do note, as a general point, that we don't
> explain the different variants of Triangular workflow anywhere [just tw=
o
> mentions in gitrevisions.txt] (e.g. patch flow versus server-side
> merges, etc.).=C2=A0

All my documentation improvements get stuck in tar, so somebody else
would need to do that.

If and when they do, it will become clear the big pit in functionality
there is.

-- =

Felipe Contreras=
