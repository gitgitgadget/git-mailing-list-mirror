Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D492C433EF
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 08:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7631E60232
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 08:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240490AbhIFI5I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 04:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240525AbhIFI5H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 04:57:07 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BE2C061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 01:56:03 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id i23so4965619vsj.4
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 01:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4FSATLsJ31JvVMrSMXs3Vv9wHKXurIZ3yswd14mDh4o=;
        b=mmD6MGK4AFsj8q92nwT9oNrFpj9IO92PPX66374vdTtNeucht8ChhssZiCCBckCwvL
         gRbunVfuUBWhxxW/VbSzHn0qnBNc1/P5gQrQ6JVjiVnUPI50JmKzSdyGeVLlX90Ltgz9
         RKaHqqznRvjR3zY6e0mfDPfIQjlG+cbxSm2FT3web2lIhZuXt5sqakj+dcZ0a15Yrqg2
         +ksCI7WAZO+3Z0xz6ejzJkbQ0hjxg3o6Dv9gZgUw/Nw4jwb0TXQmOjEl2Vq7VLKPSotv
         0XIMvgi5TeZFkMU5/JFehw3zs54cV4IZhrBQz2VORJzHSUyP6RKW/ycgQOKVlMzlQx/0
         NS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4FSATLsJ31JvVMrSMXs3Vv9wHKXurIZ3yswd14mDh4o=;
        b=gfO1rj7jVk/5GTntQDWE+Pbc+xhWByTe0gryfccxmGHwNJaM0Ntz81uV2R2OcfgvsH
         uhROxGjq2Nj9MhfuLFAT4k0xqmnHoidP1eqVKDoOJDLxVppao1nJ5NrzSu18C++49vbt
         Cj44RFnj7/YdPUaXG63PJUNLAI/OYBFC9hO1j6A6yqp0ML9ik8zrVofThtzAEXceoMF4
         7TpN/BmVtZAGpBVMao4HJ5I5xdW6HQ4WNvV7W9EHitJ6zO+j/JJsJS4gv0UQ7c6uizwZ
         cZJQkTjBZKd50lBCm3s5xsiYyKXVb80xk8QIIbwqIIqgEjKocgaKxiLcpcabh21R8L84
         SuGg==
X-Gm-Message-State: AOAM532RGKN1EcwQGEHj/BX3rMng96UH+86qXDKr9y9w75HFAnCxAria
        6pw2meznKVfj5pZsd3YbmfLmWSXuATAGPP3WFA+1Kg7y
X-Google-Smtp-Source: ABdhPJwCO/6kizVw+qXmD7TGGKSI7pKOOuPExj0YZ2ySwuGUwJkG94rrszImZvmw7kOY5QJJSIZaCYiEOdRgavrQf40=
X-Received: by 2002:a67:fe0a:: with SMTP id l10mr4852059vsr.11.1630918562074;
 Mon, 06 Sep 2021 01:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq35qmiofp.fsf@gitster.g>
In-Reply-To: <xmqq35qmiofp.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 6 Sep 2021 01:55:50 -0700
Message-ID: <CAPUEspgnRFNRoFuEvP1hpY3iKukk3OnF4zk85wkdkmiVuPuRTw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2021, #01; Thu, 2)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * fs/ssh-signing (2021-08-29) 9 commits
>  - ssh signing: test that gpg fails for unknown keys
>  - ssh signing: tests for logs, tags & push certs
>  - ssh signing: duplicate t7510 tests for commits
>  - ssh signing: verify signatures using ssh-keygen
>  - ssh signing: provide a textual signing_key_id
>  - ssh signing: retrieve a default key from ssh-agent
>  - ssh signing: add ssh key format and signing code
>  - ssh signing: add test prereqs
>  - ssh signing: preliminary refactoring and clean-up
>
>  Use ssh public crypto for object and push-cert signing.
>
>  Will merge to 'next'.

This is causing ssh-keygen from OpenSSH 8.7 to segfault,
would it be reasonable to hold it until they get a chance to fix that?

Carlo

PS. provided them with a patch, and crash is reproducible with the tests
