Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C739EB64D0
	for <git@archiver.kernel.org>; Tue, 13 Jun 2023 18:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbjFMSQe convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 13 Jun 2023 14:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbjFMSQa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 14:16:30 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD52C1BEE
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 11:16:27 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-75d57fdb014so121705285a.0
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 11:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686680187; x=1689272187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3TaPBjmR1g5aMoWevA/rVEi5PrscPFnndodbK7tyQQ=;
        b=Ze7Tg2rSPWMneYd0X7zhPvHArbkgnr1tzsybADOOR/yxkCbRWktX/C5ErxAtexv6fb
         tojAfqvpnSI/bzaw5kG4a8xlbeTjXNA9XVjyF5C0cwoGSsf4fRVBOGLBnjSuGcdtJifX
         GdjxSRYbLgBVF2ZaN8T2kO2+R2iHFwXV7s91B2OooeJyK4EC6I4JnpQTwfNbF9DDpEpA
         sKVXg09FRR/IIQwcvUKut8Wue+G+4Eg03TNqWgGiJzPE+J9EIB2zAcesRyOgp3naHUhE
         v5h7W0R9713WulJuroQRpz1eFEKztI4EbhuR0mfDsYo6/1ygtZdfeNShM5Uh4UNsuEFJ
         96rQ==
X-Gm-Message-State: AC+VfDzbC8qk+ojlLRtc5fYqC99I/4IOwjZUbKKxeXm0LkgFWPpP8Acw
        iQx9PbzlZ220DAxHbs2GT1kPEL8vU+2mXmYjpiGMyyqa
X-Google-Smtp-Source: ACHHUZ7bzF/Eq5gNEiZBuPQ0BKBwL+JTCBxcXJOdYtf3KnM0aCh96d45vbZxCcBmVN1fmTEEXILd2lIcDDSwH8ywGVA=
X-Received: by 2002:a05:6214:19e9:b0:626:16a7:6e41 with SMTP id
 q9-20020a05621419e900b0062616a76e41mr15096266qvc.63.1686680186809; Tue, 13
 Jun 2023 11:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230613171634.15985-1-jonathantanmy@google.com> <20230613172927.19019-1-jonathantanmy@google.com>
In-Reply-To: <20230613172927.19019-1-jonathantanmy@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 13 Jun 2023 14:16:15 -0400
Message-ID: <CAPig+cRS=cpV1e4QoSy5uypA+-hECyPe2rEg3scV8LVBfzZ5hA@mail.gmail.com>
Subject: Re: [PATCH] CodingGuidelines: use octal escapes, not hex
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2023 at 1:44 PM Jonathan Tan <jonathantanmy@google.com> wrote:
> Hexadecimal escapes in shell scripts are not portable across shells (in
> particular, "dash" does not support them). Write in the CodingGuidelines
> document that we should be using octal escapes instead.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> @@ -188,6 +188,9 @@ For shell scripts specifically (not exhaustive):
> + - Use octal escape sequences (e.g. "\302\242"), not hexadecimal (e.g.
> +   "\xc2\xa2"), as the latter is not portable.

The shell itself doesn't interpret these sequences, so this
description feels too generic. Perhaps it would make more sense to
cite specific tools for which octal sequences are needed for
portability reasons, such as `printf`, `sed`, `tr`, etc.
