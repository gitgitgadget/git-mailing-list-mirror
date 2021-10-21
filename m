Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C3EC433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 23:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9680C61208
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 23:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhJUX1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 19:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhJUX1d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 19:27:33 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC7AC061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 16:25:16 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 204so765702ljf.9
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 16:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+2lobZC3UDl4FQRS5RmIfGiSaM++LMPQX4jIWgkZfQ0=;
        b=FLqBTIdznWychsnKLqzRRV3eGQGioled8yXI8gnWCMIDiIgDXQjiHGRXMm7/LqMluq
         w8rrYlIhXzq6ld5HUC7XC+msS19k6tdfaEuU/fh2VODo0ozkUt6a97zg1R28qMOUATmP
         ekXE4KtzmsANagYB9WGU+6p8AM21dpagINJlHtiwdXlPTz0cmgtCcz5KdCOqIM+B14u1
         SVvGewHygbmi98WKvv4n5ZyU5K10OBI9UayZTVfjdO4AX52zJUYNBbIFby4m+o6yaAwZ
         3UnrKRGkcHTzbP9OxS9pthyNGkODgFj50pPKQxo9QWBHZWCNwc+xbVkYRO2whkXJrASF
         458Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+2lobZC3UDl4FQRS5RmIfGiSaM++LMPQX4jIWgkZfQ0=;
        b=vVIfSIVXQdejjp3tJ0SeB6HkkHV24GOMwDTzcNBZO/ipgZ8MmBrGJlinroG+EkGMtJ
         divYrV1jaZaTzqeAZ+VUou+zv9ltYFyn01Tp4ssq8HKhyp4pE/HHcSiiEIu2962dhGIG
         WvM+m/W6M/+CAU1BEObXaYhoilcH6V+cnqZpF/TDDne5rRNZSCj9M9L9upy6zPjS6au7
         DCyLFgDmuhcWfE9QX9ryW1Db9Fb3+ca0nG4VkRqp0wbgAlhEFas3Y0l8j8MZZDLyFlDI
         nSNB9KDkw3DgatoxVXTzlKTblUmRNDWYjWH9abWPXPXzWiaLeVRt+6smV3AhKDqgBQaV
         Od8w==
X-Gm-Message-State: AOAM533jsrrTPO9EM3zQzBHYbFltp8swy03zvE/wtr6ceHWOXYyfuS90
        rgSRHcxU9tsxQvz2702Qc71pzA1s4TErR2bOeVepPJD0aJo=
X-Google-Smtp-Source: ABdhPJyrEaSXaAOCU/Ek+pl74GSpe+ubxtlaU+uPfmEYO5oZsWyjD5XtRLM9uNLrma5pO8aHRYvwLloaPOl5n+/dqB8=
X-Received: by 2002:a2e:960a:: with SMTP id v10mr9761532ljh.458.1634858714953;
 Thu, 21 Oct 2021 16:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <0101017ca3e30c39-f111f739-4db7-4c1e-aff2-3ee50f546591-000000@us-west-2.amazonses.com>
 <YXHdaQ98GJiFj0OK@camp.crustytoothpaste.net> <xmqqbl3ihu6l.fsf@gitster.g>
In-Reply-To: <xmqqbl3ihu6l.fsf@gitster.g>
From:   Matheus Tavares <matheus.bernardino@usp.br>
Date:   Thu, 21 Oct 2021 20:25:03 -0300
Message-ID: <CAHd-oW5PfygyNsRWGg4_W2pxR_HbePvguKRf-bK9RtY3cuAX9g@mail.gmail.com>
Subject: Re: Git submodule remove
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kalyan Sriram <kalyan@coderkalyan.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 21, 2021 at 7:47 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
> > On 2021-10-21 at 17:25:38, Kalyan Sriram wrote:
> >> Hello,
> >>
> >> I was curious why git-submodule does not have an `rm` command. Currently
> >> I have to manually delete it from .gitmodules, .git/config,
> >> .git/modules/, etc. See [0].
> >>
[...]
> I'd imagine that the happy-case implementation should be fairly
> straight-forward.  You would:
>
>  - ensure that the submodule is "absorbed" already;
>
>  - run "git rm -f" the submodule to remove the gitlink from the index
>    and remove the directory from the working tree; and
>
>  - remove the .gitmodules entry for the submodule.

I think "git rm <submodule>" already does these three steps, doesn't it?
