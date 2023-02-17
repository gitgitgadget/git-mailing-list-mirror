Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67A2C05027
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 21:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjBQV7g (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 16:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjBQV7g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 16:59:36 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09ACF59726
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 13:59:34 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 23so1247347pgg.8
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 13:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7OPZB/6nCuNh1l2cnIzSM2LXSLS6MCq4V7w844AOaBo=;
        b=PU+kHtquZ9+5aZbwLGVlGeOs4o77hBRl34AtqnjYy1+Lnrpmi3YrxN96cwOs4nbLQJ
         4wZfigqBHfjwToNCQ+E6JfZ7sXkgu62er0Bgy4kH25rtpOGhK1kuZ/ZG1a0TZHxXZLGo
         ss24IapnhbAay2O66jUhqO8tqXMBWMhOhe1saUbk4BWtaVLfoazB8csX/cD4mqJsrT4R
         +VMireK2do/jzXgaUDauFYqD3ThLQhDMjUyPLCniSXADvMxL3J+BhAPCCQVoLPXmREQC
         +Cpy3FaJBlbbZgbI3QgAY2wm0L7eDxosxG33AKvJcPDy8yUWdKx1d+7oPdaRsRFvauUX
         yENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7OPZB/6nCuNh1l2cnIzSM2LXSLS6MCq4V7w844AOaBo=;
        b=le70JxGPZejGaWdncaw1nha+uf+0W54AHP/Ltmk3ycdoM7bmwRMEQdclOhPOPSwa4g
         Uxd2eYmMB8CzVwPviVqNEJ2Y3BsLGOSZmKiXCjhBuwrWEcZCPYyuvNH41B0S606NZ1Jc
         meRGAEvRepYbqnvMEkkEvyyFfeGxWR5A2kJh9BmYmSsjqljVlkEu9bb8AvZbHD9YZeEC
         5rj6BAscZDYLhFLwVvKSx8C2ecErfRKMZ3rUHsLvHyTGQXhS3wuf4DVGVjOkI+IPoFER
         EmFszfZu4hTdMfTVBEJsU8kHUooJwCLYJ2Aa8E6TAktorypUGxQqKnmeiq0htIdRyfzK
         ieEw==
X-Gm-Message-State: AO0yUKUpBFlvUuByOFgV+9VsJ7xFfFSWf4M7x47/ZaeQHR4s9xPn3Uw3
        mJPeVVu9O/V2VoVvqsZ95w8=
X-Google-Smtp-Source: AK7set/BfimMvCBvPCCKl3+uZ4XcLLhhure1QBb5IDX1uaTZFiFvZ88E7X1N34s4imniR8fYCcGoTQ==
X-Received: by 2002:aa7:9424:0:b0:5a8:cf20:e35e with SMTP id y4-20020aa79424000000b005a8cf20e35emr2047481pfo.3.1676671173366;
        Fri, 17 Feb 2023 13:59:33 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id i13-20020aa787cd000000b005a8b882a239sm2443385pfo.109.2023.02.17.13.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 13:59:32 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Lessley Dennington <lessleydennington@gmail.com>
Cc:     M Hickford <mirth.hickford@gmail.com>,
        M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>, Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH v3] credential: new attribute password_expiry_utc
References: <pull.1443.v2.git.git.1675244392025.gitgitgadget@gmail.com>
        <pull.1443.v3.git.git.1675545372271.gitgitgadget@gmail.com>
        <xmqqmt5h80s8.fsf@gitster.g>
        <CAGJzqs=t7k2zRKKq9xN-Avbo2uXgqsg7i0Utfv-ee6yZ2CWNDA@mail.gmail.com>
        <85ab572a-cd00-f62a-97ab-f344e2b6f68e@gmail.com>
Date:   Fri, 17 Feb 2023 13:59:32 -0800
In-Reply-To: <85ab572a-cd00-f62a-97ab-f344e2b6f68e@gmail.com> (Lessley
        Dennington's message of "Fri, 17 Feb 2023 14:44:52 -0700")
Message-ID: <xmqqa61ckl6j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lessley Dennington <lessleydennington@gmail.com> writes:

> diff --git a/credential.c b/credential.c
> index d3e1bf7a67..b9a9a1d7b1 100644
> --- a/credential.c
> +++ b/credential.c
> @@ -236,6 +236,7 @@ int credential_read(struct credential *c, FILE *fp)
>                         free(c->path);
>                         c->path = xstrdup(value);
>                 } else if (!strcmp(key, "password_expiry_utc")) {
> +                       errno = 0;
>                         c->password_expiry_utc = parse_timestamp(value, NULL, 10);
>                         if (c->password_expiry_utc == 0 || errno)
>                                 c->password_expiry_utc = TIME_MAX;

Ah, that is quite understandable. Successful library function calls
would not _clera_ errno, so if there were a failure before the
control reaches this codepath, errno may have been set, and then
parse_timestamp() call, which would be a strto$some_integral_type() call,
may succeed and will leave errno as-is.  Your fix is absolutely correct
as long as we want to use "errno" after the call returns.

When strtoumax() etc. wants to report overflow or underflow, the
returned value must be UINTMAX_MAX/UINTMAX_MIN and errno would be
ERANGE, so it would probably want to check that errno is that value,
and/or what c->password_expiry_utc has these overflow/underflow
values.

> ... I have not confirmed on freebsd,
> though, as a heads up.

