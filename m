Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1534E1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 18:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbeGQT1j (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 15:27:39 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:45676 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbeGQT1i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 15:27:38 -0400
Received: by mail-yw0-f195.google.com with SMTP id 139-v6so766846ywg.12
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 11:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DKs4QMzWk2hdsC6ICv4v6e+zqPRGf8q/8LPDIe3u8WM=;
        b=Yz9d79AG80ljeb/gf1R3RMPM7FqfrJJu7codsxdolzYk8EH44LSwKX68gPuna1UkRb
         jqtHfB2UZwvxtuCLbRL+TRXmxUhnhoF5TDyoti5LNcb+RF/SkgJatBtRW8KxAFOnqw7U
         EHr7cWpVQDtTh6nl9F3XNI37lDDYs9EXr1sE/hlKn9xPBCVL+1ByXVkGkhYMjJSL645Y
         rGfj1FfosIKogxzRVaNilvV39zZmkLShj+Hn9VqbE/lDeqDTQc/yuJc7UNMGCdTse/cn
         pR1782ojtrXY3mGLH/vLbpbEbKSmwZWxBhxk30P6laalHgIvKPDFwXgLmXmogRhIIe//
         Pb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DKs4QMzWk2hdsC6ICv4v6e+zqPRGf8q/8LPDIe3u8WM=;
        b=o/sBt5rIRWP+T4+bQqI9vRA92arG6nog9NYx6uIeDyFGQbvz+kq2MZKCI8AZ/PJrd6
         dVCIyMZM7xQiagiHSlnsVjNDWn0k5ncQw3CUu9EgmljzqZYblnNyBbb0LQGwclJho7hQ
         dSgzxgQLKI0PQviPO2edkA/G9ESXaFl/nvJt8OiO63lXC6fZb3gHSu7pwN0vTN77mYgE
         PzOOhUFNmTfb9LktruE/izk3wBRYWtweTbtJrEL8nYNKXuGr1gpLGfrHbiGVntphGXD2
         ncAVttp8wNgxGQs93Lg4EZsl7ANTPYrzwfQNW8k7KTgpFCUXIG1vAt2YtMZ0hlF+fXCD
         ja6Q==
X-Gm-Message-State: AOUpUlEcYYKZPJNJ6naFAkpnzXV6pwks7fEFf0SB8TlsjYwiE82VQvO9
        G4Sgiwfev9dJTjKFP2r9Nu94KSJYIupFpsmdDDqNDQ==
X-Google-Smtp-Source: AAOMgpcIfWVGfYLokLKkepkirpHP1sum49+FOlNTyv6Ia1mAFOxIRTkf6bB6r+gGQA7f8T30kcuwOZA9DmaUfIYIZAk=
X-Received: by 2002:a81:ae41:: with SMTP id g1-v6mr1459794ywk.345.1531853620506;
 Tue, 17 Jul 2018 11:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180717002654.120375-1-sbeller@google.com> <xmqqmuupogei.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqmuupogei.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 17 Jul 2018 11:53:29 -0700
Message-ID: <CAGZ79kZtrmjODGi1j-HRbchZYuALHnms22=wWBV1AF+zUBru_g@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] git-submodule.sh: convert part of cmd_update to C
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> A tangent.
>
> Because this "-- " is a conventional signature separator, MUAs like
> Emacs message-mode seems to omit everything below it from the quote
> while responding, making it cumbersome to comment on the tbdiff.
>
> Something to think about if somebody is contemplating on adding more
> to format-patch's cover letter.

+cc Eric who needs to think about this tangent, then.
https://public-inbox.org/git/20180530080325.37520-1-sunshine@sunshineco.com/

>
> >> 2.18.0.203.gfac676dfb9-goog
> >>
> >> 1:  d4e1ec45740 ! 1:  bbc8697a8ca git-submodule.sh: align error reporting for update mode to use path
> >>     @@ -6,7 +6,6 @@
> >>          on its path, so let's do that for invalid update modes, too.
> >>
> >>          Signed-off-by: Stefan Beller <sbeller@google.com>
> >>     -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
> >>
> >>      diff --git a/git-submodule.sh b/git-submodule.sh
> >>      --- a/git-submodule.sh
>
> This is quite unfortunate.  I wonder if it is easy to tell
> range-diff that certain differences in the log message are to be
> ignored so that we can show that the first patch is unchanged in a
> case like this.  This series has 4 really changed ones with 2
> otherwise unchanged ones shown all as changed, which is not too bad,
> but for a series like sb/diff-colro-move-more reroll that has 9
> patches, out of only two have real updated patches, showing
> otherwise unchanged 7 as changed like this hunk does would make the
> cover letter useless.  It is a shame that adding range-diff to the
> cover does have so much potential.

Actually I thought it was really cool, i.e. when using your queued branch
instead of my last sent branch, I can see any edits *you* did
(including fixing up typos or applying at slightly different bases).

The sign offs are a bit unfortunate as they are repetitive.
I have two conflicting points of view on that:

(A) This sign off is inherent to the workflow. So we could
change the workflow, i.e. you pull series instead of applying them.
I think this "more in git, less in email" workflow would find supporters,
such as DScho (cc'd).

The downside is that (1) you'd have to change your
workflow, i.e. instead of applying the patches at the base you think is
best for maintenance you'd have to tell the author "please rebase to $X";
but that also has upsides, such as "If you want to have your series integrated
please merge with $Y and $Z" (looking at the object store stuff).

The other (2) downside is that everyone else (authors, reviewers) have
to adapt as well. For authors this might be easy to adapt (push instead
of sending email sounds like a win). For reviewers we'd need to have
an easy way to review things "stored in git" and not exposed via email,
which is not obvious how to do.

(B) The other point of view that I can offer is that we teach range-diff
to ignore certain patterns. Maybe in combination with interpret-trailers
this can be an easy configurable thing, or even a default to ignore
all sign offs?

Thanks,
Stefan
