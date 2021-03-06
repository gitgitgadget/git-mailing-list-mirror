Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C44C433E6
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 06:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63A9B65012
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 06:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhCFGME (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 01:12:04 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:35626 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhCFGL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 01:11:59 -0500
Received: by mail-ed1-f41.google.com with SMTP id p1so5851494edy.2
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 22:11:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4G8Pt6RIrQcYNFTP9/oNmCez2PRhi/WvvRtRcwZSfXs=;
        b=j6BNI6TZNSKxKopXoA9aVcEu/lcYDgcAI/bEEazoacW4vtLVpOrRMkGskvtTymQ2Lt
         CcnCRkAETztF297nwEQSpJpB615+qFdFxfO1NDK6Qo6sNQb2Qzq7Htsl4P1agLHRS0Q4
         g77Ygvauo140hw+dxQShz40PGYw4xsAPImfsJfffPW26/0hyYmoF7RXCFT9I4PifgA6B
         BgK4uB/2LiYYaL+XcJVdGK3TdaMPNpS53MwrKbzS+qeGCFdf2mQf44TJc5SeZpScHWVV
         AdqI3ud2PP7cl3LVw/TJkCYG/XhLfNXteAOwphiRL7EVVfgTG4nTki0XhjR3u/FPGsX1
         WyXQ==
X-Gm-Message-State: AOAM531n3jySY6gWNB2umtg8PkkL7OZMPoDb3sUDVtS8ZgyHHUbolVIJ
        bGWg7qYMNECuUrsn11ZSXgr2gToF2+bmNy6fOVA=
X-Google-Smtp-Source: ABdhPJzDK3zEndacaiqoNQTkniHg7LFf+LC0TZ6OFJmXJJ5auAozyws2rgGZxhyNvA3RcQUSMidDlAW3i3nbZ3rI3ss=
X-Received: by 2002:aa7:da14:: with SMTP id r20mr478841eds.181.1615011118255;
 Fri, 05 Mar 2021 22:11:58 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210301084512.27170-7-charvi077@gmail.com>
 <CAPig+cRvwvT7QrO0-aLZX-2vsBPJSq6WO-O7g5A0OjDMNAYmCQ@mail.gmail.com>
 <CAPSFM5c1zR6yz=gATGxih0wL-W18AWgCHQhL_SPno5SeTzGQGg@mail.gmail.com>
 <CAPig+cRiiQyavaMGzgBkXOoGFPhMBC7GbpB61ziFMrckReFbcQ@mail.gmail.com>
 <xmqqczwfg23t.fsf@gitster.c.googlers.com> <CAPSFM5cM4fdyWXD33PkT2bH6kM+3ixkxgAnhjUVYFtjUHgwU5g@mail.gmail.com>
 <xmqqpn0ed0m2.fsf@gitster.c.googlers.com> <CAPSFM5dM4NMeGqEG7hFLzyhJskqcrNtNqL9=MUCw9SEYYaFLoQ@mail.gmail.com>
 <xmqq4khpbgqk.fsf@gitster.c.googlers.com> <CAPSFM5dhxm9kuzyXj6wF7s3BoDNzCmZHpaDFhvOBVB1QWbM25w@mail.gmail.com>
In-Reply-To: <CAPSFM5dhxm9kuzyXj6wF7s3BoDNzCmZHpaDFhvOBVB1QWbM25w@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 6 Mar 2021 01:11:47 -0500
Message-ID: <CAPig+cQ-MaASh4pq1GyvGpFyQRUyw2RHg9HnPTAWe7fvaHOfxA@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] doc/git-commit: add documentation for
 fixup=[amend|reword] options
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 5, 2021 at 11:13 PM Charvi Mendiratta <charvi077@gmail.com> wrote:
> On Fri, 5 Mar 2021 at 23:55, Junio C Hamano <gitster@pobox.com> wrote:
> >  (1) to keep "--fixup=reword:<commit>"
> >
> >  (2) to keep "amend!" but not introduce "reword!" insn
> >
> >  (3) document "--fixup=reword:<commit>" can be thought of as a mere
> >      special-case short-hand for "--fixup=amend:<commit> --only",
> >      and
> >
> >  (4) make sure "fixup=amend:<commit> --only" is usable as a
> >      replacement for "--fixup=reword:<commit>".
>
> Okay, I agree that this method is more clear ...

This works for me too, especially the bit about improving the
documentation to be more clear that --fixup=reword: is a special-case
(or syntactic sugar) for --fixup=amend:.

My confusion all along was thinking that --fixup=amend: and
--fixup=reword: resulted in distinct "amend!" and "reword!" prefixes.
I don't know whether that confusion was due to me not reading the
commit messages or documentation carefully enough, or because the
behavior wasn't clearly documented or easily understood. (I did have
to re-read the documentation patch multiple times in an attempt to
understand what it was saying, so perhaps I can blame that. ;-) At any
rate, it will be good if we can get it clearly documented.

> > but if we are not doing (3) and (4), then it would also be OK to
> >
> >  (1) to keep "--fixup=reword:<commit>"
> >
> >  (2) to keep "amend!" and introduce "reword!" insn
>
> ... than this one and will update the patch in the above (former) suggested way.

This option would likely be less desirable since it could confuse
people into thinking that "reword!" would become "reword" in the
sequencer instruction sheet -- which isn't the case at all -- it
becomes "fixup -c" (or -C, I can't remember).
