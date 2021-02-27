Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAC3C433E0
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 17:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA33064E84
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 17:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhB0Rw0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Feb 2021 12:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbhB0Rtu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Feb 2021 12:49:50 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DB1C061756
        for <git@vger.kernel.org>; Sat, 27 Feb 2021 09:49:08 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id m25so458469oie.12
        for <git@vger.kernel.org>; Sat, 27 Feb 2021 09:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bjL/B/yLRQJMbkrvTJPcfCHDIsgnmrK8gfhCqOh0Xd8=;
        b=s3hzkgLjw4UKgRYI8BRe4ZTxPCw2IpkxLHaA49gB98nTAuvRQrg/enUJ8E5TvpUNen
         C8JHGX37Pj6amQojCWqAfB4HPlsUCffPMOwgBvCS6+Xu5Hrtwo/mnFoBT37mAwIg4QZg
         TZeJ3PjaWQfWbiMqRy1NtVBWO4nVoR9yjBXQpWslzTjq95EK1rj6NThaGHfeooA/TpCd
         mz0OFDVHdaUqezVc2znwEAaICDZc7+aI9Dk15bRcf0mFifCPKAcq72FkBs8xJJMuSxiz
         Tw/zNoUAgFYewDjUioqkqU+URdZunr8JhSIWfTxkFHqBp8vnzScz63qHRbYWeNYHhVIM
         QQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bjL/B/yLRQJMbkrvTJPcfCHDIsgnmrK8gfhCqOh0Xd8=;
        b=KBO9eek15I+HQvlcIwzP4Jjee4HxXpjnufwsP30R/x2UYg+yh+9O3HcJPorlPkez3H
         kplPMDv9djxhIQwGGWtQdTagWYzkcwBrXAzd++6wsAAeFThxSbzK5oIflYwP4i6AZgNh
         QP7+lSxq2Kv6q4DKeXqZpwGhK76bZZHlacR5wokW7mnaKOdQVBFGodUbtFaJehzrQZxW
         582eXxiFpJtVf5ofu1eETmXg6lPCbtaK0DUcMgfJ8rr6VuCukqfy7NHdQt6P4aFqQHMJ
         4/+Vma9L1Ysp1YRRPqr9W2JwuhelduuIF518Fa2BOGI/MvaETBs9tq2bg4LpZAt8HsRd
         D6Eg==
X-Gm-Message-State: AOAM532gFRe5t2MGu56jv+XQ6vyWH5pm3omZ6Q1IHdBOhuIRWyozMAys
        qR7KVKSgbDpAQl2lPthmxa/LdqHHJBHJVvuJn/Q=
X-Google-Smtp-Source: ABdhPJzxiNmRkeJbNzJJttDUkY00IXG7dIekvoqfNEJaAivVs2MQZTTvrYXgUnCGx7YKXLpABBL0AhhyLPFDmpUaE4U=
X-Received: by 2002:aca:4e0f:: with SMTP id c15mr6105158oib.39.1614448148025;
 Sat, 27 Feb 2021 09:49:08 -0800 (PST)
MIME-Version: 1.0
References: <CAPkN8xK7JnhatkdurEb16bC0wb+=Khd=xJ51YQUXmf2H23YCGw@mail.gmail.com>
In-Reply-To: <CAPkN8xK7JnhatkdurEb16bC0wb+=Khd=xJ51YQUXmf2H23YCGw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 27 Feb 2021 09:48:56 -0800
Message-ID: <CABPp-BGDB6jj+Et44D6D22KXprB89dNpyS_AAu3E8vOCtVaW1A@mail.gmail.com>
Subject: Re: Round-tripping fast-export/import changes commit hashes
To:     anatoly techtonik <techtonik@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, Feb 27, 2021 at 4:37 AM anatoly techtonik <techtonik@gmail.com> wrote:
>
> Hi.
>
> I can't get the same commit hashes after fast-export and then fast-import of
> this repository without any edits https://github.com/simons-public/protonfixes
> I have no idea what causes this, and how to prevent it from happening. Are
> there any workarounds?

Your second commit is signed.  Fast-export strips any extended headers
on commits, such as GPG signatures, because there's no way to keep
them in general.  In the special case that you aren't making *any*
changes to the repository and will import it as-is, you could
theoretically keep the signatures, but you don't need fast-export in
such a case so no one ever bothered to implement commit signature
handling in fast-export and fast-import.  If you make any changes
whatsoever to the commits before the signature (including importing
them to a different system), then the signature would be invalid.

You probably don't want to hear this, but there are no workarounds.

There are also other things that will prevent a simple fast-export |
fast-import pipeline from preserving your history as-is besides signed
commits (most of these are noted in the "Inherited Limitations"
section over at
https://htmlpreview.github.io/?https://github.com/newren/git-filter-repo/blob/docs/html/git-filter-repo.html):

  * any other form of extended header; fast-export only looks for the
headers it knows and exports those
  * grafts and replace objects will just get rewritten (and if they
cause any cycles, those cycles and anything depending on them are
dropped)
  * commits without an author will be given one matching the committer
(hopefully you don't have these, but if you do...)
  * tags that are missing a tagger are also a problem (hopefully you
don't have these, but if you do...)
  * annotated or signed tags outside the refs/tags/ namespace will get
renamed weirdly
  * commits by default are re-encoded into UTF-8, though I notice you
did pass --reencode=no to handle this

Hope that at least explains things for you, even if it doesn't give
you a workaround or a solution.
