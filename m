Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F639C4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 03:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 345E4238E2
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 03:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgLIDcC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 22:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgLIDcC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 22:32:02 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BA6C0613CF
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 19:31:16 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id d189so272352oig.11
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 19:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uy6fUGL+8zrfGGFW46zSjAaBIoPgw2Cz1wlWiyAyzSo=;
        b=GeX+3xIr4vzjQfxMsHHtrFOAhJ38qJJ7LrbOpYWN6PI7PPho55xQsXGxrwN37cPfx/
         kjUIm7WVLcqey+amQ5c+lRYAuz/1PagR9EXG3QXginDw5ALK4qCAZ9Ih3wh0tbk7KxTN
         Q6Y7R8Stq897G/vd9Xrs2grHsCcKLIy6If1oBsUuRZLN8Gss9lzv2IYAIwkjuUu58BjB
         3dXbL/GMDHxn5YMArDGF0f5JQiR8HpkUt4gKoUdMZ/z4QRRiZTeA+vUiUyQ6GdKlpumT
         bTmhzO5S/5mSJMV9Sh6gBvH+5Qv4iTmoegqro9G9dDOTc4L76wMbyYi6VmQpeyYxpO53
         TNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uy6fUGL+8zrfGGFW46zSjAaBIoPgw2Cz1wlWiyAyzSo=;
        b=pJCuYi5In+XEkiJMq8U9lGCMoHWlv8H+qhPhKKz79EG0uo2XzAoMtcqhnCDE89ABiV
         tKKlakh9oV0ZF6z+WSL9yXjEe4ztuSsZoxi2xIihGeQM8wi15EWJudv15mTVJAsBrrCf
         WfCPrvgK0SuCUD6j4lRKbvJ5V2Q+lfsuvWp6B4m16JHtaLs/k7SZC8xB5MulOrYtSf2k
         j8FQkAbXIgZwuOcnawAh/mNRYexZf6YhKG3CZgDfhPNWmPNbS5c+f7tsbwIOnBXPpMF4
         NWxLCwhu0neJ3CRCgNLgnWmh16zamUsKx8zYrUKOUn64Foxvvt4PE4VgoYti9drSSo11
         tRjw==
X-Gm-Message-State: AOAM533aEQe3GhpUdM3E0PczadtzJtRQFKyuGTzTic3NCJWHbFztVyv9
        3Z2hWOUGkV2E5tFsDkF0/x6aCJWCM5qJWxJjZXQ=
X-Google-Smtp-Source: ABdhPJxsurTEXlfOexVivQtGn6Sj+WmROw7T+6/t93MO2oWDSDPbBMCl9+iDwBwWcka1g6bO6Pkp/r1Ivx0ZROpUX7o=
X-Received: by 2002:aca:e083:: with SMTP id x125mr416801oig.31.1607484675540;
 Tue, 08 Dec 2020 19:31:15 -0800 (PST)
MIME-Version: 1.0
References: <20201101193330.24775-1-sorganov@gmail.com> <87y2i8dptj.fsf@osv.gnss.ru>
 <CABPp-BGuLX8Msghbo6L7vB2Wqys=Xg_uvV2Aui-1q4-+ijuNEw@mail.gmail.com>
 <87y2i8c4mr.fsf@osv.gnss.ru> <CABPp-BE3D7ifQx6MZCT_ntRnG0QZm1Ga10SJ=DN+6bpF6mX2GQ@mail.gmail.com>
 <xmqqtusv4w2g.fsf@gitster.c.googlers.com> <CABPp-BHCtrKAWR1v3OrUgX8iSfxvDwN8p+yiJy=G1BFfnSopjw@mail.gmail.com>
 <xmqq7dpr4qa0.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7dpr4qa0.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 8 Dec 2020 19:31:04 -0800
Message-ID: <CABPp-BHWhiUZ=wCSz1f0oxtHiRzAKCPVmoUYDf+mvvm63ykCEw@mail.gmail.com>
Subject: Re: [PATCH 00/26] git-log: implement new --diff-merge options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sergey Organov <sorganov@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 8, 2020 at 7:22 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > ...  As I said, I'm not sure why
> > anyone would ever want to see diffs for merges and not for normal
> > commits, the closest useful thing I can imagine is commit messages +
> > diffs for just merges, stripping the normal commits.
>
> If I can run "git log --some-options master..next" (or more
> realistically, over the range ko/next..next) to get individual
> commits (without patch) and merges (only when --cc gives some
> interesting nearby-changes), I would be very happy.  But is there a
> set of options that lets me do so?

So, you're saying you changed your mind since five years ago?[1]  Or
that what you said five years ago is still valid, but you'd appreciate
more/different options that allow this new thing?

[1] https://lore.kernel.org/git/1440110591-12941-1-git-send-email-gitster@pobox.com/

We got to this point in this thread because Sergey suggested reverting
the above change (as one option) in order to bring more consistency
between -m and -c/--cc.
