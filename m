Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EAEC433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 16:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B73192070B
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 16:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="Nu4Xh5kz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgFJQXD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbgFJQXC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 12:23:02 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92087C03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 09:23:02 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id n24so3208684lji.10
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 09:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GXn6uL8SiXlgNzwZ/D/a+rWFCuSh1Aw+oV7iYZk07Ig=;
        b=Nu4Xh5kztZJO8Hq4rzEAPRME/g+TKQapZsmb9tpo/vl6Rw3jId4btkK8P1KJeFuxLD
         5ealtPAuoYsxwi7o8wOtwp+pcba1QtsaXR2jwo1KmCxfcKzKZTVPVVlSRMyfPgYFSv+P
         bhSo3MF0gPvdoO96VdIy+8I5e0K4yFpC11yz2nb06LZ7L1dEwGbZcQ+aNgE+rogC/aHa
         TQqV1rP3tcyteA+u1Nd/f5slhwnaYJr8qW4NFOb7cSdbqWj/TKFxtp0DpNTto9ELj2KV
         LARGROlbBPZa55r0sumyQZ0L5BbJgxAioC1OZ3WwYOzdd5EAIJqiQb/ogYKVGlQTS2tb
         d7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GXn6uL8SiXlgNzwZ/D/a+rWFCuSh1Aw+oV7iYZk07Ig=;
        b=McO3i62uCTy/YB7EroackgZ8wPjm9mMIAZHEcqoa1uRUU+Ij9Xj4yh5L7iPTLI3Dp3
         KfM0PiTfZb4sU/y4m0eYQ4xRDzYKD3JGqkDb2boNMiVAQE5FIvaeBtNpynADzsjvaLTr
         YB9BGSOrBkn7YBKX+6C935OQu1Wuzu3NUid5RFR8hCrNRdtRYlnP87uHmVnfj5QnQ2Iv
         W/MBYobBCS/F10CkC6j8MIWJM2kyBuoRItRiVF62Vf83IKtEn1my9KXXGDbZ2aybFKaJ
         VVN1iRsk6VG7kbkmmTSaHwCaUCygJUCKn+KkLGZKqeLU9WmpW4QGCSrrMr3K4S13R/kh
         i8bw==
X-Gm-Message-State: AOAM533AoNGCk7oPAVUwSu5WeInhJI3CTp6XsOP/juUnqQ2vG/rPysBX
        fdi/CXGiZBsBjkkuQK/FL8/5f+zo9f9LukmtOqPnfQ==
X-Google-Smtp-Source: ABdhPJxsPyY0ZN+WJY2uXCdgmXzf1hhsne4IYzupni4/WKRrLwyJ3N5aUT8jJ7rll1irj44jDCmrZbr/exOkkrtWR4U=
X-Received: by 2002:a2e:959a:: with SMTP id w26mr2056429ljh.74.1591806181044;
 Wed, 10 Jun 2020 09:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW7_6+Jv+SQG3qh8eRjwJmqnRJKs=_bAV3WaC4-SKkoywg@mail.gmail.com>
 <20200522142611.1217757-1-newren@gmail.com> <562542d2-2a90-8683-a7fa-cbffb2e26bff@gmail.com>
In-Reply-To: <562542d2-2a90-8683-a7fa-cbffb2e26bff@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 10 Jun 2020 13:22:49 -0300
Message-ID: <CAHd-oW7BXWzaWsvsh0dQt7NgeBcz0HSbcwKVYA7sPjUinarsng@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] grep: honor sparse checkout patterns
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 10, 2020 at 8:41 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 5/22/2020 10:26 AM, Elijah Newren wrote:
> > +This may mean that even if your sparsity patterns include or exclude
> > +submodules, until you manually initialize or deinitialize them, commands
> > +like grep that work on tracked files in the working copy will ignore "not
> > +yet initialized" submodules and pay attention to "left behind" ones.
>
> I don't think that "left behind" is a good phrase here. It feels like
> they've been _dropped_ instead of _persisted despite sparse-checkout
> changes_.
>
> Perhaps:
>
>   commands like `git grep` that work on tracked files in the working copy
>   will pay attention only to initialized submodules, regardless of the
>   sparse-checkout definition.

Hmm, I'm a little confused by the "regardless of the sparse-checkout
definition". The plan we discussed for grep was to not recurse into
submodules if they have the SKIP_WORKTREE bit set [1], wasn't it?

[1]: https://lore.kernel.org/git/CABPp-BE6M9ATDYuQh8f_r3S00dM2Cv9vM3T5j5W_odbVzhC-5A@mail.gmail.com/
