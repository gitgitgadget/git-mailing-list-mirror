Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E790F20248
	for <e@80x24.org>; Tue, 26 Mar 2019 22:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732086AbfCZWHy (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 18:07:54 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39015 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731654AbfCZWHy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 18:07:54 -0400
Received: by mail-vs1-f68.google.com with SMTP id g127so8686231vsd.6
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 15:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TJE53U3UocFQD8It5iQORUd36x1i4TdPoGx8855u/NU=;
        b=HJVn/8EYgobNuZ0PLLoWEDtLcvatb36a9Wn/vRpflHBABuq6x8mPpAnSPsigFEQ92r
         M9DmusQmed2lgNxMtJ8stjCAaHQNJKy5dcIn6oUmzxDToDFixIUt9usGT40Epdy2wTnH
         s0CTDKeDBBqB4CLiBDA+rSfdUOTDKQkgsg4MHO2mXylN5zrfn13JEjkEZ+TPbGYF1N+r
         Xc5O9PCISWQiTXg4ISLEGIx+fmyK2J09jdKEWegENBRBOdtOmJ2h5VpykKF9RXKlssAG
         oK0xUWFDWMO+49Nk6j8nUvgG7Dyxlq3qCyNtg2AuKrZ+0p8X7EsV3ns5/bYDR2v7ltFr
         UyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TJE53U3UocFQD8It5iQORUd36x1i4TdPoGx8855u/NU=;
        b=BiO0RN8ONSVZmswuf302iycWQvF6wKsMZ7cp2yA8c7jFg6uSoI7JZm3t5iG7b5v13r
         yicu2OLu13RyGF1GOUtdw5DNewFiTJD4YrACC2hmkbUAH/RqCT1RZZBgy/DlN24lJ4Oh
         hHhdSTgLlx/iSmqNI6Aj33785omZNyDPjtmhQ7AYxbfcE2NcHsFBKu1Q58YcdA4hac1d
         pKgntydEdunupWhm/4r26KvZcoqtrWUz86fV09XuAdkF5OEKeXenCBY4vOFZ3EeUXDm/
         pCfi9DU0X40N63zLW7IweoHr6swA4KHZ+hDKY+gYnxorNGLIGmvCQUVj0GV7rCex5C9H
         qxSA==
X-Gm-Message-State: APjAAAX1wwglZ5Zq3u0TBXbO9uI7gQ3OjdSRiApgrUi0mJ2/9fbqNJa/
        rMdOuoff7ZoIP37Bgr1FkTSn3nBsd61ytY1fq9w=
X-Google-Smtp-Source: APXvYqziobV+P8Jjjc28Lbd3z2oY/YwncYAnAAR2fPY67beHI+UsKZyDnOfX2+nPixV5ONJoG0IFe92ALIobQwnx+3Y=
X-Received: by 2002:a67:df93:: with SMTP id x19mr20526707vsk.116.1553638073731;
 Tue, 26 Mar 2019 15:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <87efh0pdln.fsf@javad.com> <xmqqsh5gt9sm.fsf@gitster-ct.c.googlers.com>
 <8736nj2jcl.fsf@javad.com> <xmqqbm26xtum.fsf@gitster-ct.c.googlers.com>
 <87h8bra1z6.fsf@javad.com> <20190326163204.GC29627@sigill.intra.peff.net>
In-Reply-To: <20190326163204.GC29627@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 26 Mar 2019 15:07:42 -0700
Message-ID: <CABPp-BF7cd2+4jr=zGVP8x_QLdFbyOoGRWUgMtgiGDCdqZdjFA@mail.gmail.com>
Subject: Re: [PATCH] cherry-pick: do not error on non-merge commits when '-m
 1' is specified
To:     Jeff King <peff@peff.net>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 26, 2019 at 9:35 AM Jeff King <peff@peff.net> wrote:
>
> On Mon, Mar 25, 2019 at 09:43:09AM +0300, Sergey Organov wrote:
>
> > How about changing "git show -p M" to output "diff -p M^ M" rather than
> > "diff-tree --cc M" for merge commits? It's really surprising specifying
> > -p has no visible effect.
>
> That's because "-p" is already the default, and the format selection is
> orthogonal to the handling of merge commits. Providing "-m" would
> actually override the "--cc" default (though "--first-parent -m" is
> likely to be less noisy, per this discussion).
>
> As far as defaults go, I dunno. The idea is that "--cc" would give you a
> nice summary of what the merge _itself_ had to touch. I think that's
> valuable, too. If we were starting from scratch, I think there could be
> a discussion about whether one default is better than the other. But at
> this point I have a hard time finding one so much obviously better than
> the other to merit changing the behavior.

Indeed, some of us would view a first parent diff default for merges
as problematic.  However, I'd like to point out (or remind) that these
two options aren't the only ways you could view a merge.  Thomas
Rast's --remerge-diff[1] is another (even if not yet part of git.git).
Gerrit uses something similar-ish for its default way of showing a
merge.

[1] See e.g. https://bugs.chromium.org/p/git/issues/detail?id=12
