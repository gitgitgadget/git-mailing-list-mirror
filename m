Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEDDC2D0E4
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 02:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A94AC22403
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 02:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDq/qdgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgKUCyt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 21:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgKUCyt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 21:54:49 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDA1C0613CF
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 18:54:49 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id a16so15595982ejj.5
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 18:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MuO00fjnl5d9BHpIaMWY9hCaNpM3BxGwYcqvdYVPBtc=;
        b=JDq/qdgACJ9QNKy28KrkcIBRGoSz9F3asBy75br82FGjW4RYuwOzsJHp9ZG0M68jlL
         8eaa4CKFu1Kzdzl6i9051E2Lm4kpMJ3Y8zE3fn91QrZbS7Yen7OlcEtaYCr1XUa9xLYN
         gYAChwI5mhr0OXgwhLLSDUXA2xCW+cJgQkRimWmNg+Xz7zQMgOSjJj+EHwKbHrexnHs+
         1aBqiDh1XqnLfBAqqJq8FPQq/NYZUCeZKd1eTPrJoscGXD9CPhDE75xkiqmxsorwgVrb
         A560UoS86w6f64OkOtY3m8WYxSrqY0ko+768bldPAmt8HlvEoVsb5tPoI23UidCpV+oK
         RMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MuO00fjnl5d9BHpIaMWY9hCaNpM3BxGwYcqvdYVPBtc=;
        b=IqHhMqwxmocVLk67aXCn1TOUNjmDp8xSt3MZJJOPp7MTbE3zqOW0HlgkdZ8RDlzEJP
         nwmB37WnmsL4DVAmUlpL1CoYa2YJc3dJrv7X4uBLZwGfRqZPmNIm2RrXvn3LN7HJwC/l
         XJrJJtwea3gci7vIVIg42QfcoGq22UKmMjWraiuMIAQHpDUVgqpUBxNApP7dzUVUdrOI
         2tUJyo7WcyB/CUpyxTuamzR7IXcVmGd+nIZJvT6fLIbx3IkCmsP72+XBg8DFpiGF7kHm
         1zhr/g/Rzjtx/ShHFMH1ltEKOwoMkuUGC7Fi3Tq4W7RFh2OoHXH/gB8OaTebQTVyyM38
         l3yQ==
X-Gm-Message-State: AOAM530OstX/nblVPPJ99WnmdTbCvgf4DdsEkRk2msXSywNVSnPCC+UK
        cYNhlHOavS0o3MAb1K8eAn1kJx881EyLk+MU3t4=
X-Google-Smtp-Source: ABdhPJyvVTkAj52BnEMh6ZYtODDZLKG+4eWVU5ZVZVo1r85o3AwG3IuuBWeLEbJYLQ9tw39oBs8pgTBarboQE99wddw=
X-Received: by 2002:a17:906:57cc:: with SMTP id u12mr36403843ejr.163.1605927288020;
 Fri, 20 Nov 2020 18:54:48 -0800 (PST)
MIME-Version: 1.0
References: <xmqq3613vrtx.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq3613vrtx.fsf@gitster.c.googlers.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Date:   Fri, 20 Nov 2020 21:54:36 -0500
Message-ID: <CADtb9Dw6+g61vNAvhdWqecMwh_M=nW6Ot21Cwy1wyP9EtDkN7g@mail.gmail.com>
Subject: Re: [PATCH] myFirstContribition: answering questions is not the end
 of the story
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le ven. 20 nov. 2020, =C3=A0 21 h 50, Junio C Hamano <gitster@pobox.com> a =
=C3=A9crit :
>
> A review exchange may begin with a reviewer asking "what did you
> mean by this phrase in your log message (or here in the doc)?", the
> author answering what was meant, and then the reviewer saying "ah,
> that is what you meant---then the flow of the logic makes sense".
>
> But that is not the happy end of the story.  New contributors often
> forget that the material that has been reviewed in the above exchange
> is still unclear in the same way to the next person who reads it,
> until it gets updated.
>
> While we are in the vicinity, rephrase the verb "request" used to
> refer to comments by reviewers to "suggest"---this matches the
> contrast between "original" and "suggested" that appears later in
> the same paragraph, and more importantly makes it clearer that it is
> not like authors are to please reviewers' wishes but rather
> reviewers are merely helping authors to polish their commits.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

I think this is a nice addition. However the patch title should probably
be prefixed "MyFirstContribution" and not "myFirstContribition" ;)

Cheers!

Philippe.
