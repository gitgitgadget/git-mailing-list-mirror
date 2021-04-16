Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B46DC433ED
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 13:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F1A1610FA
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 13:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244113AbhDPNjF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 09:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbhDPNjE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 09:39:04 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9A1C061574
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 06:38:40 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q10so19227242pgj.2
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 06:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uSHiSD10N7P5DdvRwC9TnACoA3N+WQZzNi7bMEhKG98=;
        b=mmo7AMacuBPHW9HJRIrePWObau5EsE//ErMHVHdVI5xJ6GEoR+c+glUV2y4m1VvkSn
         jXi3sjaW9ROEZDA5TBevadD3m5YO/gjtCaz4lByy75hAnr96lakU6VFJu5HnSOnqODvZ
         jTBrn0rv/09NNhSjNHy3Q+LZcHza3q/J4d+YGJWex09PtNYJqAOH9JPuYAyQnkaGU2LR
         fZQDhWMJD3br+fifCPCscGlimAsRQjyXyp2u4bLvtc4mjCz0xhwqjqu1rLcaMrCLBzCn
         vG92vdERbS8rIASFZR4yu2lSW28WoKZPIeoMFcpLFi5xwBU8vMUd2Gwu+vUt8cvzdSpx
         nmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uSHiSD10N7P5DdvRwC9TnACoA3N+WQZzNi7bMEhKG98=;
        b=UpzeWTOZOFkev/lSUM0g+/g+8l4k7lrecG1CaZ/efE2KPkenMv2vS2gQCmOMOK5mmW
         yfBkEw5izwvKZoUcLG7xSqAveGzEGB2GHyOlB4YV4zrrvvDuXtMGcJYmvD1sMAPZS9Ld
         LTzERYpiaPLIufTulvW15YrBXnPfIVzMZw2onYG4hINxSzAffkjdck/PbnAcnxha8yWJ
         XAXLC2jqa+OpbW8VQaQ4phjcNbhrirH3yN4ASvA/lsu6kJ6YJGJW0jmr9CW93JYN2yDF
         wldsx4CFCNr1byyjI/QaknWOkbqwPePK8/kbRTAAAVCUPb/qj5D3DJ3Uep7H0RNjAn72
         t4fw==
X-Gm-Message-State: AOAM531RciR1pADabobzpOziN0QVSAIIAiHZksvYlnwARaTmnr6ZEbWA
        07gYcRojCCED9K24COlZ/hfvPvdsmaBYEFBR+G65imELzJE=
X-Google-Smtp-Source: ABdhPJyfL2VD4IqVBQkC41a6gx7N541XXHNv6q24BUOo9QBDdT5lE4ZA6r501kniU7ETCDZhexoS4ohC4V1fvxMMtJo=
X-Received: by 2002:a65:4986:: with SMTP id r6mr8410378pgs.392.1618580319657;
 Fri, 16 Apr 2021 06:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210415123353.14686-1-oystwa@gmail.com> <CAPig+cSGDULOmqqpxe4b+r0ML-dMqjzgOjqgk++9E2oW-pz+9A@mail.gmail.com>
In-Reply-To: <CAPig+cSGDULOmqqpxe4b+r0ML-dMqjzgOjqgk++9E2oW-pz+9A@mail.gmail.com>
From:   =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
Date:   Fri, 16 Apr 2021 15:38:03 +0200
Message-ID: <CAFaJEqvL4xaXZOxS_4vXf_0gqTXBMbEO_k7ozsioTmqEMs09kA@mail.gmail.com>
Subject: Re: [PATCH] transport: respect verbosity when setting upstream
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 15 Apr 2021 at 17:29, Eric Sunshine <sunshine@sunshineco.com> wrote=
:

> I wondered why you used `tee` here since it adds no value (as far as I
> can tell), but I see that you copied it from the test preceding this
> one. So... [intentionally left blank]

Indeed, I wondered about that too; it seems a plain redirection will do
the trick. But a mix of laziness and not second-guessing others' work made
me leave it as it is.

=C3=98sse
