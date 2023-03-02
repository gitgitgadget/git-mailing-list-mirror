Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46D6C678D4
	for <git@archiver.kernel.org>; Thu,  2 Mar 2023 05:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjCBFKi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 00:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjCBFKg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 00:10:36 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134283D087
        for <git@vger.kernel.org>; Wed,  1 Mar 2023 21:10:36 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1763e201bb4so2025620fac.1
        for <git@vger.kernel.org>; Wed, 01 Mar 2023 21:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677733834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjuYUR3F7vDLPE5ur4063wPIg3w+fA5cCFm6b3FEFgk=;
        b=aiY3KONu9E+pmXDsUuGdnqJSfoLAGpRMIsoGtKYZdyOpBg40UqydT3m5oov62YqJhN
         AstX88NZCRiDdlzXKlcQqKkcha7gBOQ5GJ3IJokRm34kfPlDnvQ9kNbf3eEYXYhH7iZs
         qJSU61GrQUMQjcR9u1HskEyoWXuiDwYb1yyvAq3PvbM7pkNbm5g0sHN3kNVp/w1AsJaD
         gXMLpEszN2d0iWj7RkLBiy597Z3jwLeqsG6JeD2YXSiZ5vb6L3FY4pn6HwagX8doZdtI
         ljhxtziABgGe+Z9ruogd5LRTUJFAuQMXc63Z7k7Tcv+pt6agLQy3QM/2Y6d6bvSY6Lzb
         hxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677733834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjuYUR3F7vDLPE5ur4063wPIg3w+fA5cCFm6b3FEFgk=;
        b=7KgUDH30kBY6XkQXAgFu/zpSFL+N0PhcPMUgNIPFX5iejvGzMjHKJzMME/qP7QKwh5
         n45VyJCk375vvjqqX3Ybjvb7VR+qUf80WW+rbZ+DmBxhu31D4Lj9hxQ3aL8FshCpiPPB
         cSxxvu1qFefYztR/bMmR2IAJOn4iVyMW/soRJWwXTm+AasRvSqNkqCz8EYXK7EMxuV8V
         RC1T5vloIhXDGFb13e+k8lZUZbLwfRhxRboXYSReMISAF5IQdYWB5aUjBrRjvN3QycHC
         c0E6XvsLS1A/EE3kfD3Rhjk3GtPNeDprmd8g6al6XCs46TDSMeCAtLaV/wQ5n40SO4rU
         hnng==
X-Gm-Message-State: AO0yUKVW26g1iuGHhrqUzF4RM762/AzcuJYeqjdkQ4uVnsbG656dmAIx
        hQ6A7NTo41oC4bGZvFz2uRHmN8XXzUqjDIXLgXzKgcHR
X-Google-Smtp-Source: AK7set9c0D0fwl9JLM1XvkAgZdnQnMJHAg874FZaPJEjY+OitbHydSVROL9hLNenZz1JpF2gN2viUDTEZNxmtOcctQo=
X-Received: by 2002:a05:6871:b18a:b0:16a:1d37:78dd with SMTP id
 an10-20020a056871b18a00b0016a1d3778ddmr2107814oac.5.1677733834634; Wed, 01
 Mar 2023 21:10:34 -0800 (PST)
MIME-Version: 1.0
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
 <20230225180325.796624-1-alexhenrie24@gmail.com> <kl6lwn403vyn.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CAMMLpeRioQUag7THDKACKhS3VS+DsxzZSaFrJ8L5=1+1s=qxAA@mail.gmail.com>
In-Reply-To: <CAMMLpeRioQUag7THDKACKhS3VS+DsxzZSaFrJ8L5=1+1s=qxAA@mail.gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Wed, 1 Mar 2023 22:09:58 -0700
Message-ID: <CAMMLpeQ9AvFsPcr=LwRGr_ShxEKwtt+vAcs7MYPi3KchXSKs2g@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] rebase: add a config option for --rebase-merges
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 1, 2023 at 10:02=E2=80=AFPM Alex Henrie <alexhenrie24@gmail.com=
> wrote:
>
> Hi Glenn,

Typo: Glen. No matter how much I proofread, I seem to always notice
typos right after I send the email...
