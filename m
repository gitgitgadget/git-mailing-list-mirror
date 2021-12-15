Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54B6C433F5
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 20:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbhLOUYb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 15:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbhLOUYa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 15:24:30 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4603C061574
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 12:24:30 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id 132so21261829qkj.11
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 12:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=veF+ZsW8c6KAB82L1DReZUAiJg7UPfQlzaWTvURmHJ4=;
        b=RhNJiaxiQwjgWXv20YrOX/9fuUZ3s5Q+vaDLWvXdVUf7L3pPTLtmWtfhIBuHYJt48s
         a0clheNjEFM/7gkYHiKITh/KTWjBVqQ0PtSZj32XI0SWn7rPfCiHgCH2ZfPs94vxCQvr
         uxZ17vMCHimENaAAq/rm+uUXsheUJ+HvX5rqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=veF+ZsW8c6KAB82L1DReZUAiJg7UPfQlzaWTvURmHJ4=;
        b=ES7sgJTgr/a1F3SPB/Z4EuRviNTRlpcUVhj2m2JV32KgN+YJvyr37DP9b7ZAOQ0bIW
         56Nwq2vMCAoK6DOyCxoI5jJCWvMKRABifhYMO1fPyN7Sk0Mv3NwUpNjaPRVP5RFKtywV
         YyxyKbOSu50DM3cBIryx/Zj7vxMrm7rdFlZvyGb4ZhUTQeQVVKQJ3pU+/EaGC+OQ1u3J
         ZYJaaXN+MOIq/jlMIbuxpKyUwlL1oiBSH+BrAs7wAOGLWGNiJAXdkR4caKXNOVTVmAEl
         8FdujfyMteQ7BDXrPlOpJiYrG4YoLTsCx9a8e5GczgbyA00rN0i2cGDktXlsmCCfNvmJ
         R33g==
X-Gm-Message-State: AOAM530P7HGjFrYRDk23HGSGnh9mYurv2TGujiFwELaZ1nEgjv6u27cr
        Oidfk87kR9j/vH5ewcD49hie8o64++fv5dcWN5bing==
X-Google-Smtp-Source: ABdhPJwYdHuhmNdp/tafHONu1eKeiLIQ8FcTV31XSCTpv47VvDT35gUW8cTzhAMenJW2/m0gPhtdwyjI4Ao+dWtN/9o=
X-Received: by 2002:a05:620a:2486:: with SMTP id i6mr10290921qkn.331.1639599869757;
 Wed, 15 Dec 2021 12:24:29 -0800 (PST)
MIME-Version: 1.0
References: <YbizfdGq+RSu9BGe@coredump.intra.peff.net> <20211214194626.33814-1-jacob@gitlab.com>
 <20211214194626.33814-2-jacob@gitlab.com> <xmqqa6h16414.fsf@gitster.g> <003001d7f1ee$48c88410$da598c30$@nexbridge.com>
In-Reply-To: <003001d7f1ee$48c88410$da598c30$@nexbridge.com>
From:   Jacob Vosmaer <jacob@gitlab.com>
Date:   Wed, 15 Dec 2021 21:24:19 +0100
Message-ID: <CADMWQoPUEMGvhg-gqZHvsModKGomTYOP7h0SGv=9CaLMJdEm0g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] upload-pack.c: increase output buffer size
To:     rsbecker@nexbridge.com
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        avarab@gmail.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 15, 2021 at 8:59 PM <rsbecker@nexbridge.com> wrote:

> This is likely to break NonStop as our sideband packet size is less than
> 64K.

Could you elaborate on what you expect to break?
