Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE3EEB64D7
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 00:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbjFNA2l (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jun 2023 20:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjFNA2k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 20:28:40 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899141707
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 17:28:39 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-652699e72f7so4734753b3a.3
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 17:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686702519; x=1689294519;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OuRQzDUlUJCmatpWSm783xSdfFvj3fW2FnPLLocT3MU=;
        b=hqp8PvvHd9tusbb364BVGjrZPDVAfn0fF/35Zvg22RbsMQpSJbgJ9ZhIOpBLipyRe5
         GXrLYnuZHd7oY8+b6tMbX2XYpUa1suxDAToLzsV2fEAV8nasna+uTBds+aOM9RSCXyDy
         4DeN9PUXi3miiBdP2aVrG/zCIir8VaGm2v+3OXXHT3uW76Wxc/m0p06Lxz7ns1NHOH7m
         6ZVQ8f8JTRtR9I3KjCb/eVVIBcYPG8Jpc8tIEnWiiut9UXnpwOZYwggDGKFF2fSnUVjA
         s6k6sbaifo3slyYz0mdtNTn4R898JnK0OE8VwQd9wqJSolf/yXqusxv8/8fmSwzVk68O
         If2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686702519; x=1689294519;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OuRQzDUlUJCmatpWSm783xSdfFvj3fW2FnPLLocT3MU=;
        b=ifx8xc5RqpjbDwNSkQMuyu222U4nxZfAJr73Zhjf1y31uF6fy1EfU0E7UOuF77r1g3
         5cukWnWlZCB2ZOwQQoNoRQaP+JrS1QBXlaj5CC59WhsLnbVVdDGgknbdHXRhJ/8JjyV/
         2SdpktUW4LMjGC2SGI/GySSx8I+VQ6vtbxz6bzx51KawJMI6j+jsgdKFs6n5dNmsrDzb
         pSgQ+Pea15B/kgdAZ64K7I+sz+Dohz5Y51Czv5RvIxev+7yAoCEOHqXWYHJx1wEpUG87
         s6AeN9PlFyLZm5y9USV1KKtMK7YGYj0FGdRoh0JiNmUPn6iUfdJrycCR7+cUOaWEuHb9
         IYUA==
X-Gm-Message-State: AC+VfDxnCMqV/8a+0xv8ZcIy0LHBU9tFDYRfKAeEfK9H4MN4ti0S3XK3
        HmTlGKcWqDwyBvOfp8Nr60A=
X-Google-Smtp-Source: ACHHUZ7TpSSGglcHS1oCuws/P/bzsROHzqTsqzLhFFrt1vN0gc0eoRzCNG8OrxVBI9D8KgXk9phu3g==
X-Received: by 2002:a05:6a20:9382:b0:10b:a464:a662 with SMTP id x2-20020a056a20938200b0010ba464a662mr250567pzh.30.1686702518911;
        Tue, 13 Jun 2023 17:28:38 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id s8-20020aa78288000000b006328ee1e56csm9140917pfm.2.2023.06.13.17.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 17:28:38 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com
Subject: Re: [PATCH v2] CodingGuidelines: use octal escapes, not hex
References: <20230614001558.277755-1-jonathantanmy@google.com>
Date:   Tue, 13 Jun 2023 17:28:38 -0700
In-Reply-To: <20230614001558.277755-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 13 Jun 2023 17:15:58 -0700")
Message-ID: <xmqqy1km28g9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Extend the shell-scripting section of CodingGuidelines to suggest octal
> escape sequences (e.g. "\302\242") over hexadecimal (e.g. "\xc2\xa2")
> since the latter can be a source of portability problems.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> I've used Eric's suggestion for the commit message and limited the scope
> of the documentation change to printf.
>
> Version 1 was here:
> https://lore.kernel.org/git/20230613172927.19019-1-jonathantanmy@google.com/
> ---
>  Documentation/CodingGuidelines | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 003393ed16..30ac7d2d3f 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -188,6 +188,10 @@ For shell scripts specifically (not exhaustive):
>     hopefully nobody starts using "local" before they are reimplemented
>     in C ;-)
>  
> + - Use octal escape sequences (e.g. "\302\242"), not hexadecimal (e.g.
> +   "\xc2\xa2"), since the latter is not portable across commands like
> +   "printf".

I'd say

    - Use octal ... not hex..., in printf format string.

not "commands LIKE".

Thanks.

