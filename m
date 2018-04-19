Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0769C1F404
	for <e@80x24.org>; Thu, 19 Apr 2018 04:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752703AbeDSE3w (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 00:29:52 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:37751 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752649AbeDSE3u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 00:29:50 -0400
Received: by mail-wr0-f169.google.com with SMTP id f14-v6so10169079wre.4
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 21:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=7URh2HP0kZsriB2mZTZkBxtZFplfOApn2j5FEiaYhUU=;
        b=h0kVr6bA96WTLtfNQkb0SOUYLY7iRaRh6/ZOcI11n1OnqcMakoktj8ubxbyXIPn/oS
         +XfO8maBd/9YYxv8f5FcptPHnlx+aG76MNjNpe2dCbVLbRfHiVJIDfZ+iaeV0NJjkPJK
         yMgjv2sGQnUOVwpJkFTj7frIgLCp8LBEjScPKsjKlZ+N5BegYnme20WXxJgnZeOA/MYh
         v0Jq9nEuhstuekUL9KwwjbfxfFRc52/R8fUCApP7FGngvOfjVZq5iPUnsHGreHaklyXk
         XVMTfGgwlFaB0g39FRyEAmzxbD/QIDSXn16uWWIGlcBW0ufCSHl9CUSnCTWivb92W+lp
         et7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=7URh2HP0kZsriB2mZTZkBxtZFplfOApn2j5FEiaYhUU=;
        b=Ep9lULju2QaTpjbsaZczLsfPvjTTYQsPZH7Go5i+fKVuHFowLkyFda7YLE6Docbzx6
         5tHRZEHbx9fzdurTxmRKJzTQwWAPl1/PpB2XKV10DfNYNTRv31eyZ+Cq3ZH6+/A+maX9
         3QV2dFd+UFEVohzvQNzUjs6uPBtvnPR2XUx6pbc4jwdDruK1P58DKbdc6MyF4jjNTKTs
         FvxjeV81QI+5la3JRYRehrrAjK8lDaokWfk/5449TMbRmoBdBYhHQo94BTxIwHBUgMGU
         Surm1TYvxzcUFDgmV50d8GWdyp0SOb1SouJATfyPVB3lXjZsWlVVDdp/o0bbykI5Q4FB
         cQcQ==
X-Gm-Message-State: ALQs6tARwqtQ9MEyEUx8LxyoLUJ96mDg1rHh7eDcdddIjxSPi+da0aTJ
        wQnExrTrpEanYE31ePIMK6U=
X-Google-Smtp-Source: AIpwx4+wej1+2XIb1mPw388qSTHcK9+6PxHehT1jM8oBG8x7ysIQ3Q1K+NQUGAYLQXkzzJxpTsqpAw==
X-Received: by 2002:adf:d0ce:: with SMTP id z14-v6mr3481206wrh.157.1524112189362;
        Wed, 18 Apr 2018 21:29:49 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t6-v6sm2820642wre.32.2018.04.18.21.29.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Apr 2018 21:29:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Jeff King" <peff@peff.net>, Junio C Hamano <junio@pobox.com>,
        demerphq <demerphq@gmail.com>
Subject: Re: [RFC WIP PATCH] merge: implement -s theirs -X N
References: <87sh7sdtc1.fsf@evledraar.gmail.com>
Date:   Thu, 19 Apr 2018 13:29:48 +0900
In-Reply-To: <87sh7sdtc1.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 19 Apr 2018 00:48:30 +0200")
Message-ID: <xmqqy3hjes3n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Questions:
>
>  1. Should I be calling read-tree here with run_command_v_opt(), or is
>     there some internal API I should be using?

The internal is unpack_trees(), which is usabe as a library-ish API
reasonably cleanly and easily.  For a project large enough where the
perforce can become an issue, the overhead to spawn read-tree as an
external process would be dwarfed by the cost of real processing of
merging multiple trees into an in-core index, but it involves two
extra writing and reading the index file back and forth compared to
the approach to use unpack_trees() to do everything in core.  As
long as the "now make sure that the contents of the index file is
that of the tree of the N-th parent" code is cleanly isolated in the
implementation, it is probably better to refrain from premature
optimization.

>  2. Currently merge-ours is just a no-op since we take the current HEAD,
>     but maybe it would be cleaner to implement it in terms of this
>     thing, also to get immediate test coverage for all the -s ours
>     stuff. We'd be reading the tree redundantly into the index, but
>     maybe it's worth it for the coverage...

I doubt that it would be a sensible approach.  If anything, even if
we lived in an alternate universe where "-s ours" weren't invented
and "-s become-nth-tree -W $N" feature gets first introduced, I
would imagine that we would introduce a code to special case "-s
ours" (aka "take the current HEAD") as an obvious optimization for
the common and trivial case, essentially splitting the "unification"
you are suggesting here.

>  3. Is there a better name for this than -s theirs? Maybe `-s nth -X N`?

I tend to agree that "-s thiers -X N" is horrible; "-s ours -X N"
would slightly be a better choice as it does not have to introduce a
new option.  "-s nth -X N" does not sound all that bad.

"Does this feature make sense?" was not among the questions listed,
and I am not ready to answer to it yet anyway, so ...

