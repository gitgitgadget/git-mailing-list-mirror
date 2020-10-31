Return-Path: <SRS0=d2Ax=EG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC73BC00A89
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 02:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD6F2064C
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 02:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mutual.io header.i=@mutual.io header.b="C22jY8VH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgJaCmk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 22:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgJaCmk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 22:42:40 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1ABC0613D5
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 19:42:39 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id o18so8628965edq.4
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 19:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mutual.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T5D95d0A47roqQy+FSIJuh7rV7As/5KvbHc20W74LsU=;
        b=C22jY8VHrNRe0hWOaE/xnBm+UUBfLPAbxJx1kCJFhgSHnoZdv+K3LUVkGjx44VXkMM
         /ntjL8SWJNvDFpynR6PmxMlzn8mVVuP94mf8qZBDao1AjQe1q1fWS4Yg4ZSMRs0qqfso
         7APG1rVlp7GDg/fNj8DirKDwMUTywtAE2LHQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T5D95d0A47roqQy+FSIJuh7rV7As/5KvbHc20W74LsU=;
        b=CvRwGPri7xdPoS0y0B91Iest4w7bULMpKHGuUN7I6Ro9Q37t0ZSgpPA2i+/puQtpVp
         OXv9oiwFYp0Ddg+OU2ggW0EW+DLlVSagcpuQgmnWVWe2kNlTXNEQfet1J5YR0hi46sRl
         bEruAhsM3jVT61CBZjSDn5kcYs4VquZcvgBFyz2fqJww5/khko6xH86iKtykp8zHPa5t
         wh1oZ7RQfO0aCbKd21cIdXb5cHI/TG7hUEW58094LjCyGftiJ5Z4gxCWCFaWVoeTxczv
         leIGM2uL/g7ZiJQkwuTaJaeR2IyCb/S2dipTE6IhLjdAu12pez7Sj648l3b42509u3KI
         PLvg==
X-Gm-Message-State: AOAM530y7vkLjYJvTD71s4K+XfZkbwUjRbSPmQ5DuDMMGxDfmUozaa2j
        OnJI+3mpM3VVMXi6scDUe83UJjmJpcz6TbTE3y/avc/+2uHOKLsJ
X-Google-Smtp-Source: ABdhPJwkpZkyx+Z8ttdh8xkwctBpbQjw/MuVKX8nDynhX5Qtz6KwiJ9HGVwhG/fPJkDZxD36zzUiC7SGWM8wFEWQhTw=
X-Received: by 2002:a50:eb0a:: with SMTP id y10mr5912369edp.342.1604112158146;
 Fri, 30 Oct 2020 19:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <1604022059-18527-1-git-send-email-dan@mutual.io>
 <20201030223504.45978-1-dan@mutual.io> <xmqqzh4346sb.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqzh4346sb.fsf@gitster.c.googlers.com>
From:   Daniel Duvall <dan@mutual.io>
Date:   Fri, 30 Oct 2020 19:42:27 -0700
Message-ID: <CANo+1guedZiZVbnANsSPCiYbKWpJ_tjJ7vc04Ap7EVZzzp869A@mail.gmail.com>
Subject: Re: [PATCH v2] upload-pack: allow stateless client EOF just prior to haves
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 30, 2020 at 4:45 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> >  t/t5705-upload-pack-stateless-shallow-eof.sh | 24 ++++++++++++++++++++
> >  upload-pack.c                                | 13 ++++++++++-
> >  2 files changed, 36 insertions(+), 1 deletion(-)
> >  create mode 100755 t/t5705-upload-pack-stateless-shallow-eof.sh
>
> I'd rather see it folded in an existing test, if it makes sense.

With v3 I've moved it into t/t5530-upload-pack-error.sh. That test
file seemed to mostly contain errant cases, but I thought it might be
close enough as this was previously an errant case. If there's a
better place for it I'm happy to move it again.
