Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 661E320248
	for <e@80x24.org>; Fri,  1 Mar 2019 02:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732389AbfCACwp (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 21:52:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40014 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfCACwo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 21:52:44 -0500
Received: by mail-wr1-f67.google.com with SMTP id q1so24226601wrp.7
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 18:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=nau/ctXYG9S1S+NaT73dkdUWxdCimgW1f82QkCiERzI=;
        b=CYWo0d5DwXFcS/Dqk2kFLKmlKgqwmmvkNAY1UIQg/t7Gb//q5fjuvcYvLgjXCPTsSl
         V0hsbpK/iR9WoajlT465GjXpneCYFsXAqLQd/S0iRANCES6xLfZFXd1yvOrWmEqc6UFK
         yk0cM1FFLWHjKGpsaw/yGh7dwmJbBF9XtfFfmZNeV1aLRE6zGlv2ncfijWgPd4e0u+6e
         +zQnrDlX25IUXhv3WHC6nD3iVXrHQdmICEgm/QPBV5Kxbms08dBbsk1torcih2wjfKfu
         80RRbDNJcXJ+FAnvFPXtre1Q2NXvpnKykfA9EWFnCRQtIFqHtUeis7Rs31R3ZzmCJIxW
         O/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=nau/ctXYG9S1S+NaT73dkdUWxdCimgW1f82QkCiERzI=;
        b=Dar+B57NeHMZy1fbBdiby3b13YB20PfnZUJmKI45wel+3fIeBuNTWNExwg9tdJnqmG
         8MzsqZ0pmHTQ8yJiOE5jTDU1EqVLIqfY8Np3R3k0vp3fKdRbr2+4p4nwrnurccuesw/5
         KxqjJy6PWlCP/vMjjEskcgosiaH3o/oOxm3rmEZuD+9EpjiPHC1OM0IYQ68zb+iGE0RZ
         3er2wq1IIb6EoteAe9mhsFMzZJeb2Ws3iPei5FjF/qg/SgSrENK/XWoT0WrM15yWwwmI
         4CeE20352kk11uBXaZqgDcWWFDzmLDeeGbvfTqIvWPDNQXy2UlQVTV8gfSDsjAloJYwx
         aT+g==
X-Gm-Message-State: APjAAAXeK9nN3sTUSgAbVW8ZphlhdJNJTD6i7nh3gXLmcZlTA7SBa1eP
        yUZikx3CzI+dqpO59bhkFIs=
X-Google-Smtp-Source: APXvYqxImlvpkHx++lSEKqJ3RypKEnJlAZ0VHfhkjQAkaU+YEp2FQvoPyRajMveOdufQpMifDbrHuw==
X-Received: by 2002:adf:9e0c:: with SMTP id u12mr1600296wre.216.1551408762623;
        Thu, 28 Feb 2019 18:52:42 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x17sm37212005wrd.95.2019.02.28.18.52.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 18:52:41 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Linus Nilsson <Linus.Nilsson@trimma.se>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] All files in folder are moved when cherry-picking commit that moves fewer files
References: <67C5CE5D6EC13D4DB8FC51E2F9BD262F022B8B3151@Triton.ad.trimma.se>
        <512993fe-51da-745d-031b-37ea162499fb@gmail.com>
        <CABPp-BGbrWrS0622yfTRUqRzWzNsZ_v9cAWW6ucXBYXqD26qHA@mail.gmail.com>
        <20190227164056.GA2062@sigill.intra.peff.net>
        <CABPp-BGOqQ0P8ywCK_sybPOeASxPnkTq7NXW8678f=345=68-Q@mail.gmail.com>
Date:   Fri, 01 Mar 2019 11:52:41 +0900
Message-ID: <xmqq7edj9uh2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As you know that I've always been skeptical to this rename-directory
business, this probably won't come as a surprise, but I seriously
think directory renames should be made opt-in, and as a separate
option, making the option three-way.  I.e.

 - do we do any renames (yes/no)?

 - if we do do renames, do we base the decision only on the contents
   of the thing along, or do we allow neighbouring files affect the
   decision?
 
That is, in addition to the traditional --renames or -M, we'd have a
separate bool --allow-directory-renames that is by default off and
is a no-op if the former is off.

We had to fix a breakage recently for 3-way fallback case, and we
explained the fix as needed because the case lacks the full
information, but I think even with the full information at hand, the
rename-directory heurisitcs is inherently riskier than the content
based rename detection.

Suppose you had F1, F2, ... in directory D1, and moved them all to
D1/D2.  In the meantime, somebody else adds Fn to directory D1.  It
may be likely that some variant of Fn would want to go to D1/D2, but
it also is very likely that there should be a difference between
D1/Fn somebody else had, and the contents of D1/D2/Fn in the merge
result.  Perhaps D1/F1 in your preimage used to refer to another
path in the top-level directory as "../top", but the reference would
have been rewritten to "../../top" when you moved D1/F1 to D1/D2/F1,
and the person doing the merge should at least check if D1/Fn that
comes from the other party needs a similar adjustment while merged.

In the above scenario, if there were D1/Fn in _your_ preimage and
all the other party did was to make in-place modification, the story
is vastly different.  Most likely you would have made most of, if
not all, the adjustment necessary for D1/Fn to sit in its new
location, while the other party kept the relative reference to other
places intact, so we can say that both parties have say in the
contents of the auto-merged result.  The "since neighgours moved,
this must also want to move the same way" heuristics does not give a
chance to the party that is not aware of the move to prepare the
contents appropriate for the new location, by definition, so the
onus is on the person who merges to adjust the contents.

Thanks.

[jch: I am still mostly offline til the next week, but I had a
chance to sit in front of my mailbox long enough, so...]
