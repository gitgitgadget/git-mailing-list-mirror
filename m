Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45AE51F42D
	for <e@80x24.org>; Sun, 27 May 2018 01:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032524AbeE0B16 (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 21:27:58 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:34543 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032485AbeE0B15 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 May 2018 21:27:57 -0400
Received: by mail-it0-f65.google.com with SMTP id c5-v6so23446945itj.1
        for <git@vger.kernel.org>; Sat, 26 May 2018 18:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ppd/ZQC50hTvVahyPNVww0bjtIeEi3/sk+Z5XfcpIc=;
        b=dfdyVW1hfSvl5B4lm4XwpgBV1MBuQaQnA/TdlP9QkTEZ+M5EHgl+Rcyr4ffUnAiWt3
         5W5VWVARUwYYpncYleEK0P86KOjRNt9xeYVs2oud5nfcIKUm+ywPoKrX4TlKMUZZxhTF
         9t5/c6p6yM+RV1gF1V4ANxX3h/KluaUALgub8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ppd/ZQC50hTvVahyPNVww0bjtIeEi3/sk+Z5XfcpIc=;
        b=Ycd0z9g3MOh2uUEjYIJ/TmeFAz3m0qsThLi9AtSnIVfzFI2TPUDhNoFkYxgZeIhzg/
         5835KwqmMaOQiAAuUXbCpLWJ459qRhq9nDFCrMO5arDGR6rG6gtQpc1ryoUMksJ1viGs
         6HffTFe5htVJj5Vza4D3w6wp6DbTSUkN4jgVC5E2fsdEy2nuS70dNGXSroWseS86Lrrs
         0zy/9RWqDHsrHuBRYCKbNbChoyboiL8/fA0rOr3Os1RoyU8llMhm5Hgt2LZzmAOJhl26
         OejlF1NR5GOcIQLBLreNwkiHHOkJTL3lcNJiGT/4hphS84lYsN0qrBaT3E7JUe2O1D+j
         ldvw==
X-Gm-Message-State: ALKqPweE5kajT2ov5q5l27Do0lyQ1L54gJRRnnNfH+H+bqHlI+Srq4pm
        9sQOogiX3txfJN20HniOh+kvtOPQVDBgaSGs7/w=
X-Google-Smtp-Source: AB8JxZqeosljlGHKzVDFKIprRv4Dslf5sL2tJrk2B6LPwCA26Bt9d3x2sOp+FOaVcCOSo7YfXJIuzY7SvWowCsPlEYA=
X-Received: by 2002:a24:21ca:: with SMTP id e193-v6mr6804295ita.108.1527384477058;
 Sat, 26 May 2018 18:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LFD.2.21.999.1805261449160.6211@i7.lan> <xmqqd0xim1tp.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0xim1tp.fsf@gitster-ct.c.googlers.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 26 May 2018 18:27:45 -0700
Message-ID: <CA+55aFycPQ9PTbAGXqL7i9QQPsx-AT8R3S5gTvC0Ue=ot2J9FQ@mail.gmail.com>
Subject: Re: [RFC] git gc "--prune=now" semantics considered harmful
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 26, 2018 at 4:31 PM Junio C Hamano <gitster@pobox.com> wrote:

> *That* is something I don't do.  After all, I am fully aware that I
> have started end-of-day ritual by that time, so I won't even look at
> a new patch (or a pull request for that matter).

Sounds like you're more organized about the end-of-day ritual than I am.
For me the gc is not quite so structured.

> I however have to wonder if there are opposite "oops" end-user
> operation we also need to worry about, i.e. we are doing a large-ish
> fetch, and get bored and run a gc fron another terminal.  Perhaps
> *that* is a bit too stupid to worry about?  Auto-gc deliberately
> does not use 'now' because it wants to leave a grace period to avoid
> exactly that kind of race.

For me, a "pull" never takes that long.  Sure, any manual merging and the
writing of the commit message might take a while, but it's "foreground"
activity for me, I'd not start a gc in the middle of it.

So at least to me, doing "git fsck --full" and "git gc --prune=now" are
somewhat special because they take a while and tend to be background things
that I "start and forget" about (the same way I sometimes start and forget
a kernel build).

Which is why that current "git gc --prune=now" behavior seems a bit
dangerous.

                Linus
