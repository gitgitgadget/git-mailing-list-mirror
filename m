Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182DEC433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 22:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA32760FC1
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 22:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243646AbhJHW2y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 18:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbhJHW2x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 18:28:53 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B7AC061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 15:26:57 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id i11so10404272ila.12
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 15:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tvYAM0P1X0RAznQ8sNwGkcFEJWxjIAxfFCJnboIAVCI=;
        b=QAIddhsCRJheUXCf/XJkehoNePTt+RLXGhAEQpcsXJX1nj2Z98XONHBBNJm3vl0oK2
         GFcSlgClKcZdWc/E03XHD/el2LcZVaLOtFBLlDDBZpS2VK7LAWV96VmFapMjpgzLw7V4
         hmaoIME7g0UdM06HFDrAdq7mLGJRjWxopxdpmwoRZ+kd73pjz2L+EXQt/xnRwAivWz2E
         72jBtuXSZXUy7gHOA+Pc3IYFWWAeO4P+UkFHmk/jVv1qMhyoEJMDpQeBlmLXJshpyhOK
         0vwTFm711X+9OtQPAUGB8EbitVF6X4rvJIubAw8Rka5ehqvhN8qywf7G0q7ERLRxDcpx
         KUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tvYAM0P1X0RAznQ8sNwGkcFEJWxjIAxfFCJnboIAVCI=;
        b=bWn0Yr1rVkFvVJEXYghqPlb36n/dngdIhx24kow5EpHjcH+id5OJ/yjzOxe6Ouln0L
         nB96Fi+G+NPDizqKntsaBMqL8lW0s0lzc2k3cip0U/SwNr5N1yPDswbDeL+BBVyu29+s
         lzOWxL6kyRej366SvX/jD3w9rC6VoqxzHHywyc+fV11flWtyuHLXF3iSSYa2CPP3jvH+
         DI892L4QOFYnslcShHcM40oaTnYqBgi2+tqYAowfOfOdftNfBPZNuXHyd2+8GjYdWbFQ
         nU5Xgi21drgQ9JWK5vxVEywvpLWdSB9ZmJ0/UBngHWlO68ZI0sDsWYjJ30eU/KD32Oao
         dDjA==
X-Gm-Message-State: AOAM532jVNhCB7Z8E22sPXFF5+kZDyLBakvJG7euLFiE33H1yB80wCTe
        OwynHX0Ib0OTLW1tzl/JWZBAxJfnRgD3K04+sCo=
X-Google-Smtp-Source: ABdhPJzfGEvTnWUAbectiuYc4AJRObWHvzV0a24iHjZbNTno+PpURQKOaGW+7fkdADiPnr76Qwu+RFZGvGoUnqyx2Jw=
X-Received: by 2002:a05:6e02:1bef:: with SMTP id y15mr10309645ilv.295.1633732016985;
 Fri, 08 Oct 2021 15:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1096.git.git.1633642772432.gitgitgadget@gmail.com>
 <xmqqbl3zjl5y.fsf@gitster.g> <CAMmwyQpP0m6dTdC-L9abZqk9nJkcYy=j4_s0+EdGDr__pykeXQ@mail.gmail.com>
 <xmqqh7dri2m1.fsf@gitster.g>
In-Reply-To: <xmqqh7dri2m1.fsf@gitster.g>
From:   Robert Estelle <robertestelle@gmail.com>
Date:   Fri, 8 Oct 2021 15:26:30 -0700
Message-ID: <CAMmwyQp7ChC7RZAZX4Y3UyAghOAmvHA7e3BBJonGYJNoSc+nFA@mail.gmail.com>
Subject: Re: [PATCH] completion: fix incorrect bash/zsh string equality check
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Robert Estelle via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The choice between the two does not affect correctness, it's purely
stylistic here. It only would affect correctness for unquoted
arguments or extended comparison operators. Those *are* in use
elsewhere in this script and force the use of `[[` in those places.

Keep in mind also that this is an autocomplete script. Although it's
sourced by both bash and zsh, it does not make sense to attempt to
make it work for bare POSIX sh.

On Fri, Oct 8, 2021 at 3:16 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Robert Estelle <robertestelle@gmail.com> writes:
>
> > On Fri, Oct 8, 2021 at 1:50 PM Junio C Hamano <gitster@pobox.com> wrote:
> >> Would it be equally a valid fix to use "=" instead of "==", or would
> >> that change the meaning? This is a bash-only piece of code, so use
> >> of [[ ... ]] is not technically incorrect, but if the basic [] works
> >> well enough with "=", we should prefer that.
> >
> > Yes, `[` is preferable for portability and they'd behave the same in
> > this case. I consciously chose to use `[[` because that's what all the
> > other comparisons in that script use. (I think I noted that in the
> > commit message, maybe). I think there's value in consistency, and not
> > enough value of `[` over `[[` to justify changing all the other lines.
>
> I do not know if we mind eventual consistency using [] not [[]], but
> this topic is certainly not about aiming for consistency.
>
> If the difference affects correctness, as brian mentioned, that is a
> different matter.  We should use [ x = y ] in this patch while
> leaving the existing uses of [[ x == y ]].
>
> Later in a separate patch series, we may need to examine other uses
> of [[ x == y ]] and correct the ones that do not need/want the
> pattern matching semantics to use [ x = y ].
>
