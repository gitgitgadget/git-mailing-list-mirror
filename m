Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5205DC2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 18:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2454B61409
	for <git@archiver.kernel.org>; Tue, 25 May 2021 18:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhEYSon (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 14:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhEYSom (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 14:44:42 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC06C061574
        for <git@vger.kernel.org>; Tue, 25 May 2021 11:43:11 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id s19so31203846oic.7
        for <git@vger.kernel.org>; Tue, 25 May 2021 11:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=kGjujsyBR35/mQygbmvOEA2sDNBSxpIzDTthMytaFS0=;
        b=Es/R29OYScJAINBgp5A7HSIillSlwXHoiCYpcRvQ50b1NiFKqTGhnQ7NIgDdm3bVnc
         ip3TlvgAVt8stUBalDuXizc7/SGjtToovlfVQFt8yLt5p3W3Ca8xIyaaXVCrfsZB1frz
         VF0Hrt+Sopzx9X38uSfsxaGn0RK7NSybZabH74fordkXfoSIFeE6zAiMtOzpC6dEY0O+
         fhUD4elOMYGmTKpeiT68x8bEGIDOFKnCMMT94QRpZmOiBjzGJT//73+LPVxoKmCwRqQ1
         3kxYbRWSlhI7/VOyFCyJ/dw4DJscB9KN8EfpyUaHkzdkCi4Hs+zxR/dEWX0Y8dSuC3q/
         J5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=kGjujsyBR35/mQygbmvOEA2sDNBSxpIzDTthMytaFS0=;
        b=FEN16eTl4gEUiNK7pzRhUJ3GBt8I5ezkfkI/vKt1Csd3zFI1D6y5cGvII5B2QW/q3H
         elTfsnzDhu/GnmAZNxy8+rAnXJIwP08yHVvnTqIqs2ix8BuhmI1LwoQi4oQ5pzUgsu7G
         KiKvblUWSrC2TRuD1HyJJZ9iVqL4V5YbEipUOMROLBZw28iRAuSN7ugdAarf5IRxUr42
         GiVDx6ePwAE2FHsXVkrvk+eFygFa5jeSLtJxv1rBvZQlJC5WUIjXX0YTBA+ZKMRv+S7v
         suzjHadXbs4cQUPAKIEw3EQ7ZqO6bL72MMXsTOmR2ywSoJdy+xuEEXS6XT7AyuqJwFyy
         97tQ==
X-Gm-Message-State: AOAM530vK+YFlR5dRvV6KNEUnZ6kCLo/OlCIoFf3Ed4ZFgunFM3URCxi
        9Aa3h7PzzjbbWMdhqzbkKYY=
X-Google-Smtp-Source: ABdhPJwscEWyNlheF8AAGO3GgNqhzOAl3qAnEmxvtyzvTqDIXWDR0hw111UvzmTvuIExg95SRa2K9Q==
X-Received: by 2002:a05:6808:a87:: with SMTP id q7mr14980236oij.38.1621968191011;
        Tue, 25 May 2021 11:43:11 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id x9sm3614056oto.79.2021.05.25.11.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 11:43:10 -0700 (PDT)
Date:   Tue, 25 May 2021 13:43:09 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Josh Steadmon <steadmon@google.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Message-ID: <60ad453d2153e_2901820821@natae.notmuch>
In-Reply-To: <CAMMLpeR5S3Ps4C2V4QuTxrCRB_iRsUKyCNOJ4G7Fy7jGe98ZbA@mail.gmail.com>
References: <YKWggLGDhTOY+lcy@google.com>
 <60a5afeeb13b4_1d8f2208a5@natae.notmuch>
 <CAMMLpeScunGg5WM4N90vG+yN3tOATqhsL2iRLsJ43ksNyTx_wQ@mail.gmail.com>
 <7f0c9ab8-c1ca-171b-8247-6d921702f3bc@iee.email>
 <60a97550287b3_857e9208b8@natae.notmuch>
 <CAMMLpeR5S3Ps4C2V4QuTxrCRB_iRsUKyCNOJ4G7Fy7jGe98ZbA@mail.gmail.com>
Subject: Re: RFC: error codes on exit
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie wrote:
> On Sat, May 22, 2021 at 3:19 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:

> > > Though abnormal and atypical often have different implications ;-)
> >
> > Or USUAL.
> 
> The words "typical" and "usual" have the same problem of making it
> sound like there was no error.

Not to me. "Usual" is typically an adjective, which makes me think: usual
what? (something is missing). Although both can be used as nouns ("the
usual", "the new normal") in this context "usual" is much less confusing
(I don't recall hearing "the command returned usual status").

-- 
Felipe Contreras
