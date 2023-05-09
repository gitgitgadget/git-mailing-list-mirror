Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCDAC77B75
	for <git@archiver.kernel.org>; Tue,  9 May 2023 17:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbjEIRzp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 13:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbjEIRzN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 13:55:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508364C3E
        for <git@vger.kernel.org>; Tue,  9 May 2023 10:54:56 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba22ced2f40so7639967276.1
        for <git@vger.kernel.org>; Tue, 09 May 2023 10:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683654888; x=1686246888;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/FQ/FvA2vzRZbrRB4sikcFyhqxQbUpaPbm4VI1dZNds=;
        b=tJopHxMFlCBoJhTgt7eLNVX6kqz7rTvmUk7i5Xu7EAZQcb3tHfSsrp5GIZYytazU+l
         U6LFp9LdK4k/DoQGq+5o2fZ2XHCNeVuZXhk4OatjDXBr2ETToG1ALKyztqWYgO1kTM49
         fdXreZUnjSiLsqnts7VzUdhyL6+Tx/1uTg6RbFIQWJsCRbs3rmdAVKRdmy2FCWO4sVh5
         XuEvA7JtFB4hQ/1PXDuiICIc5jxxfM9kBzzd1YQttfCILj330MXTfzy1J8RHkKEnXCP7
         FWmQNztObAYyjTLLKLhGgcQHNw1EtvLs09nXxonKb8gj7oL8UrRRh4GAHsZYdS+IbAO9
         bHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683654888; x=1686246888;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/FQ/FvA2vzRZbrRB4sikcFyhqxQbUpaPbm4VI1dZNds=;
        b=CG+EGky1jYD+G9xVjyJNy1YSV3uaJN3NuT9gi62uUn6FAzfjScsosWsU01E/u/uMy7
         0WcVxe1tWukjm73Fn7b3/JpMdQ7iy4mJyQR59ZW9XxIQRKXEjnbN16VrWyYk0uSKdGzx
         CKg607SRzpdg0LTRu6llcA5RHOkWGWfxsDL7vtsVzeh9IgiqRXrxwYU6mcnARLuVgV9k
         y9EBCqxFoEZCyYjcxuWGjo02Z2K5JQF4BzCrgzTJ01C4FacgbZl8AlhRfH6Al74nV2+m
         hV4JPKixauqC35VDjy+JtOwbET0j/ewD6primmXiiwny0IZ7X/hptZQtypPv9b0TR6RW
         Ipxw==
X-Gm-Message-State: AC+VfDyhrCt2WJsmgSyoz17CVqJMPfoh6BhvFmqE8Dc/ctuoiiyHLl8Z
        RLtsdfTPoIaaoaQAEpQq7AkAalBC15mlWw==
X-Google-Smtp-Source: ACHHUZ5hlg4RfQA4LLJlgBm3STNeTN4OUd9dHHurAGBVj9rK0c9CMpZaXYAvxWibwoYat2WmCcqcGw6wtSp7UQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6902:154f:b0:b78:8bd8:6e77 with SMTP
 id r15-20020a056902154f00b00b788bd86e77mr9723712ybu.8.1683654888157; Tue, 09
 May 2023 10:54:48 -0700 (PDT)
Date:   Tue, 09 May 2023 10:54:46 -0700
In-Reply-To: <230501.86h6swjp3r.gmgdl@evledraar.gmail.com>
Mime-Version: 1.0
References: <pull.1495.git.git.1681329955.gitgitgadget@gmail.com>
 <pull.1495.v2.git.git.1682634143.gitgitgadget@gmail.com> <4a8b8a2a6745e791e35296e34f530b5f40f51c27.1682634143.git.gitgitgadget@gmail.com>
 <230501.86h6swjp3r.gmgdl@evledraar.gmail.com>
Message-ID: <kl6l8rdx1jbt.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 1/2] cocci: add headings to and reword README
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        "SZEDER =?utf-8?Q?G=C3=A1bor?=" <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Apr 27 2023, Glen Choo via GitGitGadget wrote:
>
> Re subject: I don't per-se mind the "add headings" formatting change,
> but doesn't it have headings already? I.e.:
>
>> -Git-specific tips & things to know about how we run "spatch":
>> +=3D=3D Git-specific tips & things to know about how we run "spatch":
>> =20
>>   * The "make coccicheck" will piggy-back on
>>     "COMPUTE_HEADER_DEPENDENCIES". If you've built a given object file
>
> I think it was clear before that that was a "heading", at least in the
> sense that it summarized what the indented part that followed was
> discussing.

As Junio guessed downthread, I was primarily aiming to heading-ify the
other parts of the doc.

> I think what this is really doing is converting this part of the doc to
> asciidoc, but is anything actually rendering it as asciidoc?

And as Felipe mentioned downthread, I chose to author it as asciidoc
because I also find structured docs easier to read, and asciidoc seems
to be the closest thing to a standardized format we have. You're right
that nothing renders this as asciidoc.

Thanks, all :)

> If we are converting it to asciidoc shouldn't the bullet-points be
> un-indented too? (I'm not sure, but couldn't find a part of our build
> that actually feeds this through asciidoc, so spot-checking that wasn't
> trivial...)

Thanks Felipe for checking.
