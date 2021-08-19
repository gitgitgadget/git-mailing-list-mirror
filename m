Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDBAC4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 09:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19B7B61028
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 09:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbhHSJDd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 05:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhHSJDb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 05:03:31 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82F2C061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 02:02:55 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id s19so3571539vsl.11
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 02:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GpncwjnJWF62rjo91kXGlWNl0PoOUVLD3DGqfrYo9KY=;
        b=jFhzBUgSLYQD8fI+NgR8VORdEbWFe8BiKsEp5RH6TXJpxf4jZvwF84C3jgNke2Ox0c
         TOiOLzRCxSm9W0hWaHfreeNLEV1ELROz9b1ZmI2xWMP9xYuDla4QZ0Mkc7uAtlTn8Fvb
         TTie04KGYtTOXCJJyStjJHMLqCXLa+iJ02aAsQ4Rl/Ow8SFiL1p5jmet71U26If4Nyeg
         +n+UEdsYZhnISguQUpTdxWxG36Qsyy7mg95H8aa8tjxtfuzRk23v9AOooPDA3H2QKnm7
         MVtG6ZGYa3fDQQBrp8dBmvoZxeU2nmEb8Y84/mg9NLVjpNuBd/V1jehzZqMmQT1nxfAD
         FXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GpncwjnJWF62rjo91kXGlWNl0PoOUVLD3DGqfrYo9KY=;
        b=qVzxY4oN11eBaxTjucpY6dlAk/UZFLy0H4ryw0EbnSo6qPO2/aWUkxKlajpU1/qD+g
         f8iH6/qwn+P4wJdHnRW6Xcx41U/14OeSuj/11R3XsqXa568XxyP3OC76u66OTyYJ/qu4
         uzvJv+4I4cYTNJ7np08kk0Q0N3VPJT5Lb65HavVziXLhUoQW5u8SotyIa7IdWz4kkaFP
         d/UVgiadW2KGCXRjiEW+4g2YkRUkuJqb/cdpYOpi5Z9pPOin3uv/sO1sxZ33jSJqePO+
         KjTF3N3Db1janvFCwcmTqPDmmgVcmtvxq2788sP6rRXmivM1hZbIbCXOmSgnJ9622rL5
         Ssmw==
X-Gm-Message-State: AOAM5321gZtFsaNxPVh89UlZQNw5Eg6XnStuB0Yww2YB9aAVkrtc1EF9
        NBRNPoBkuSMi52GBbJYq5F47L4aCXxqgzEiGqTc=
X-Google-Smtp-Source: ABdhPJwWAHGr4aR0KmB2DSfHCcUWSdJEVr7Ga6PggSg05lHQu1qZT7rC5V3kR2qM+tNGQLpz3zTTqExp5g+CeTFxBh0=
X-Received: by 2002:a67:fa0b:: with SMTP id i11mr11665546vsq.44.1629363774728;
 Thu, 19 Aug 2021 02:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <40BE2EF2-0AF3-45BA-9880-8A6011B38D03@slight.dev> <bc7eda4ed8d52072b929a4af6e4e4ed7478ef9d6.1629361733.git.congdanhqx@gmail.com>
In-Reply-To: <bc7eda4ed8d52072b929a4af6e4e4ed7478ef9d6.1629361733.git.congdanhqx@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 19 Aug 2021 02:02:43 -0700
Message-ID: <CAPUEspg+LUP59DJ+Z-AqKW0hfz=AbMfvOTFLe1rT5g5auV7gdA@mail.gmail.com>
Subject: Re: [PATCH] diff-lib: ignore all outsider if --relative asked
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Thomas De Zeeuw <thomas@slight.dev>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Awesome work, and this not only fixes the crash but a bug in
--relative that has been going for a while, after all the
documentation clearly says that --relative should filter out entries
outside the tree and it does unless in this crashing scenario, which
as pointed out was also showing the wrong paths for the diff chunks
outside of the directory.

My only concern is that it seems this has been broken for a while
(couldn't bisect, but AFAIK the first implementation did filter like
this one does), so some people might be expecting the broken
behaviour.

got my Tested-by or Reviewed-by and gratitude.

Carlo
