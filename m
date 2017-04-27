Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B073207BD
	for <e@80x24.org>; Thu, 27 Apr 2017 00:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033253AbdD0AZh (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 20:25:37 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33137 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033250AbdD0AZg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 20:25:36 -0400
Received: by mail-pf0-f196.google.com with SMTP id c198so3973845pfc.0
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 17:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=abuMYK1fc9bhgkNbJxP6lpfJEruTM/2ojgetQp8pX6Y=;
        b=c4OhhuV7WMMRAJGfQ+Gm7W5jOaxeN9iLxa1iJ1LTGK4/S+ze4PbpdNM//GHSb+jCrs
         GB4Rqt/SFFey6FV/Q2TXkBO/ZqcIXT6kUk3oBClz7pbs7w6XTPmRC42e+URPFfOmkc2N
         RMlFfpaRKW9RBsatAfNSf3zd/FkVsu4AdJLUb75ObMDD1y96O7P1Q7p7FCuudxbm3Mxl
         wm49diTwVY+wgMiRZV4AQ+K1GDm9N117kUzsdwwPLewVYjJ6kWrrmrHgCwfUaifPEbMi
         C0IxeZUJduq9xcklUaAqDEr1a68gcu5LMPhF7sLaexThxuAoYNZ9RpCgiQHkqpYHOZrI
         DsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=abuMYK1fc9bhgkNbJxP6lpfJEruTM/2ojgetQp8pX6Y=;
        b=PmF8GdjhUR/UJgGdU0sctSnsKyG/T/+mPcQE/zItBFgOsT2yOg0fty7fnT4hw0bmpa
         Sv6hLrrP2YJdZdd1CwT7NdFquaupYZUlcbKKS6LkwtIzlHXe5auUIBFR0lV1/8eqbxZt
         Hw0imnW5MxeikmBGRRPZsCzEwSAJV4yU/Ha157T6q6suZnnhogOZ65PbIbq1IW8UbYkL
         SUnWq0fz7MmY6sSJ8wOkilsE/eVmObg1IB5NLlO7oGqz6k5RodBypjMduoAYoC9UC5C2
         MO1OEX8rnSvH/Rt8+T7G2TgBzaVCKAD1ICE2dmnI5frPu57FuKxvsjtmF9ihhwPNjtEl
         M8/A==
X-Gm-Message-State: AN3rC/7RqkbjcILDHXGyP7VfiGECGq8C4oxQXu+ZrurC5vlr7QVtAlWJ
        EIMAqagY8uAuNg==
X-Received: by 10.84.229.2 with SMTP id b2mr3384395plk.108.1493252735405;
        Wed, 26 Apr 2017 17:25:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d550:ca2:cfe6:6d97])
        by smtp.gmail.com with ESMTPSA id d82sm682180pfl.124.2017.04.26.17.25.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 17:25:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Philip Oakley <philipoakley@iee.org>, Jeff King <peff@peff.net>,
        Orgad Shaneh <orgads@gmail.com>,
        Dakota Hawkins <dakotahawkins@gmail.com>,
        git <git@vger.kernel.org>,
        Christoph Michelbach <michelbach94@gmail.com>
Subject: Re: Submodule/contents conflict
References: <CAGHpTBJCjNa8gQRkMah30ehESdsVVKNy+6CuLSf9hfDedR+tPA@mail.gmail.com>
        <CAGZ79kZ5440r1EHOVP3eXxe5u=u16y_jXTA0C4hLJA2kUkF-kg@mail.gmail.com>
        <4BF0A1BFFFFD421EB8C5F7E6FEF14357@PhilipOakley>
        <CAGZ79kZDzuSHw4siSkiekw73bBq9R8gg_R+a7NyNUG6bYxc2Og@mail.gmail.com>
        <C3A8A88B8DDD468095B7FD256330EEF7@PhilipOakley>
        <xmqqa873ubiw.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZEveo8jQodvd0n6fEXc1OXDVa26BCumM0etjst74F_Hw@mail.gmail.com>
Date:   Wed, 26 Apr 2017 17:25:33 -0700
In-Reply-To: <CAGZ79kZEveo8jQodvd0n6fEXc1OXDVa26BCumM0etjst74F_Hw@mail.gmail.com>
        (Stefan Beller's message of "Wed, 26 Apr 2017 10:41:11 -0700")
Message-ID: <xmqqmvb2r91e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> I assumed a use case like this:
>
>   A user may want to extract a file from a given tree-ish via
>   GIT_WORK_TREE=/tmp/place git checkout <tree> -- <file>
>   without modifying the repository (i.e. index) at all. For this
>   we'd need an option to modify the working tree only.

I somehow do not see that as a very useful use case.  It is not just
keeping the index, but it is depositing the file also out of the
working tree, and if you do not want to work with the resulting
<file> (actually, if it is a single file, "cat-file -t blob" is the
most natural thing to use for such an operation, so you should say
<pathspec> that may match multiple files and perhaps a collection of
directories) within the context of your working tree, I would think
that "archive | tar xf -" is a better choice.

The feature is more about in-tree case.  You clobber what you did in
your working tree by extracting a pristine copy out of some known
tree, which may not be HEAD.  And if the tree is not HEAD, you would
want "git diff <pathspec>" would give a useful preview of what would
happen when you do "git add" them.  As "checkout" adds to the index
before updating the working tree (which can be argued as an ancient
design mistake, given that we typically do worktree-only by default
and have "--index/--cached" to work with the index, e.g. "apply",
"grep"), the user needs to do "git diff HEAD <pathspec>" instead in
this case.

> I never realized this as a usual convention explicitly. Thanks for pointing
> it out.

I think it is somewhere in gitcli(7).

>> +       if (opts->no_index && !opts->source_tree)
>> +               die(_("'--working-tree-only' cannot be used without tree-ish"));
>
> double negation, maybe:
>
>   "--working-tree-only requires tree-ish"

Much more concise.  Thanks.

>> +test_expect_success 'working-tree-only option leaves checked out files unadded' '
>> +       git reset --hard &&
>> +       git checkout -b pu next &&
>> +       echo another >>file1 &&
>> +       echo exists >file3 &&
>> +       git add file3 &&
>> +       git commit -a -m another &&
>> +       git checkout next &&
>
> Up to here it is all preparation; I started to give an argument
> on why using "another" for both the commit message and the file content
> was suboptimal, but I was wrong. This seems to be best after some consideration.

It does add to the mental burden.  Will think of a pair of different
words and phrases.

> The next paragraph checks for
> 'working-tree-only option populates the working tree, but doesn't touch index'
>
>> +       ! grep another file1 &&
>> +       git checkout --working-tree-only pu file1 file3 &&
>> +       grep another file1 &&
>> +       test_must_fail git grep --cached another file1 &&
>
> but only for file1, whereas the next paragraph checks it for file3.
>
>> +       grep exists file3 &&
>> +       git ls-files file3 >actual &&
>> +       >expect &&
>> +       test_cmp expect actual

Yes.  This demonstrates that paths only in tree-ish is not added to
the index (i.e. ls-files does not show it, because HEAD and the
original index didn't have it).  If you did the same "grep --cached"
that expects a non-match, you cannot tell if we added the path with
the --intent-to-add or if we didn't add it at all, so it deliberately
checks different thing from the case for file1.
