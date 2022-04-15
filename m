Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB93C433F5
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 18:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347153AbiDOSsy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 14:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346923AbiDOSsx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 14:48:53 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C128D66616
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 11:46:24 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id n134so4024259iod.5
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 11:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fSewBR1FgaKIvn5NF87tr88rVAW1SOImmCCuy7N95uo=;
        b=TEXIWstbWVoa2LveLWtqryTE4FztcALpuhlxlLLPLy6bhawLxoUiXcXHa7lrdI1hD5
         WcDXIf+dZJq0wUM0KodZWFTQv+80YT8i80SZjmbASXXT/RIixEugsD49YIM7+312bB73
         al39oJrR0Ol7h+LfG5sk2X+ZWcYCRURaNLSDN2hYhIR58iHLrV/lZuV125zc7a1b9yaD
         R6RUFXVx91YmB8+t6C0MObZemEhSsCbXLPGzVOeKX38fDuOC+my7BRDFoi415oEo6tli
         zAxG3n7KXwpiUWnvYuCy3sQ7dHEVjeIrqAtrhQeOB67xNCdiracJYy2JvquYxQR6ewSM
         /HuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fSewBR1FgaKIvn5NF87tr88rVAW1SOImmCCuy7N95uo=;
        b=387d3QY/vU/elt0csd28fvIYjIWRgk5pqr9QH5nM9vBOnnfLhRhTT1+3yAq8vObg3p
         9BMucsx906RwBYda1F6Ug8AFzQE7pB09ttUH7vbf8g8LWoXnovYy58R9W/2BpjBpO44B
         J+pRG7vIPL5wkRx5bvCneYDv2fwkObu/9UKnY6T8Xds6Vzphox5ZYuLx5b6KOiEeeQRW
         ZOphF5UwqZYiGecjjkAzCVM2Ww2S9cz8/kU8OJgkYERS/bykaQIcFQSa/uV03OiCO042
         UfeuQSyDyBTm7rRFopwCAOpUtYvI4Tps44udS+5ZCJ9roxJKxi/O/0hCdRFpa7rtSPkm
         tRHw==
X-Gm-Message-State: AOAM532aQT36av53HzbCGwH0zzEmcB8EOR+cqYjlh7GCjX/zKQzJOF/H
        ycJH78Q//PcmcDiZlbXSSiJsONrpySk4IHECh0I=
X-Google-Smtp-Source: ABdhPJwElt4P6HlTNqfBMHJou5Eg9e4WLyE8h8BP+SspKbXGo2vvcWCWegWMwe3SRoTbOHDh0/4UAya5Q5SzhPtK3p4=
X-Received: by 2002:a05:6638:3589:b0:326:4caf:7b64 with SMTP id
 v9-20020a056638358900b003264caf7b64mr237586jal.160.1650048383725; Fri, 15 Apr
 2022 11:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220413164336.101390-1-eantoranz@gmail.com> <xmqq4k2wap8g.fsf@gitster.g>
In-Reply-To: <xmqq4k2wap8g.fsf@gitster.g>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Fri, 15 Apr 2022 20:46:12 +0200
Message-ID: <CAOc6etYvOhqQn3icWj3Ny1m+J_60h7aiqW-gvm=dQyDLgG=6NA@mail.gmail.com>
Subject: Re: [RFC] introducing git replay
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 13, 2022 at 7:05 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>
> Also, if this _were_ to allow recreating the shape of the history,
> using updated tips of branches that were merged in the original
> history, perhaps taking hints from "Merge branch X into Y" in the
> original merge commit's log messages, that would be quite useful
> addition to the rebase mechanism, but this is not that.

Ok.... I have taken some time to read it through in calm and this part
is making my head scratch because it sounds like the stuff that I had
in mind in replay (or if we move  it into rebase or any other place).
So, to clarify what you are asking, when replaying _a given commit_:

- If a parent is included in the history of the _old_ base, you would
like to see it included as is (no changes) as a parent of the replayed
commit.
- If a parent is not included in the history of the _old base_, it
means it has been replayed and we need to take the equivalent replayed
commit of the parent.

So, coming back to the example:

git replay HEAD v2.35.0 v2.36.0-rc1

We would replay all commits that make up the range v2.35.0..v2.36.0-rc1

Now, for any given commit being replayed, if a parent is in that
range, it would use the replayed commit of the parent. If the parent
is not in that range (which means that it's part of the history of
v2.35.0, which is not being replayed) then we need to take it as-is
straight no changes which means that _the original_ parent commit will
be  linked in the resulting replayed commit that we are working on at
the time therefore linking the original history. (sorry if it sounds a
little bit reiterative).

Is that what you mean? Because, if that is the case, that is what
replay does as of this patch.

If you gave it a try like in the eample, you should end up with a
commit (the one reported at the end of the execution) that has the
_exact same_ history shape of v2.36.0-rc1 (even linking to  commits
that are part of the history of v2.35.0).

But I am probably wrong in terms of what I understand that you meant.
Can you expand a little bit, if you don't mind?
