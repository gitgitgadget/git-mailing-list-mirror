Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9898B20248
	for <e@80x24.org>; Wed, 20 Mar 2019 00:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfCTAjC (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 20:39:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54644 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfCTAjC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 20:39:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id f3so18902469wmj.4
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 17:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3aqrulYg4098fwKzJtYQZkUja29bUAyyc47daiNZsno=;
        b=sY8ul4n8TNySjejlbfSVlWNHOLHkiNppBVnXMOlV6YM+U/Ashvwi5cHiuK9X9FaTHb
         vyYAdLf4cAV92XJiDUVXbwFvWKPBIucioubczZUHHrbaNPKhzoW7eY5F3GYJ7eVGr2q9
         2IqIyLpTMLllK+pJEWCKpD5p+x9uZY97t0ZUteplFfk/EUgqbQzHdRRTHDQEKXPLVNhP
         umEve053NbNMLzCTiSJlR+OSh/5z7Guaqp3VCtXjYcib5Vrpp/w6+1qomFQWtirxlr21
         7VX/9AalHR5oaXFDHBsR/OPIyhIWfOmYdlIfDt3l6jVqGOuR6+ZvxFVT8F/2cw+RUW/Y
         fixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3aqrulYg4098fwKzJtYQZkUja29bUAyyc47daiNZsno=;
        b=Yj+zDGjMt38E5ZHymPz2Us7qsbb00fzQpEts6BM5hbB1/96NwlEkSQXAzqb+Ytr+VS
         L8hjHZ0QYaPFLJzqOqQ1zx7ABc+Wp31OJWKxcXUz8U8bRubo3tr+SEJr6TB1OIS6mLdw
         E+XZ1Nz1sBWGt/sknxToMKdWuWLc9mUAfRDYHxqkLObql8XKfhOsPithHNMHyCmSrj4P
         +9f3ix6Oacm36jUYjyo3TboAusLJvMquOXGl5DPaNY6Fv037d2/nDJS49EXCxEX9TLkS
         iQTR0xWiDmjuku66vsBntosrmT1tWL9vkEoMqKoej9XosDeucUzkJWhuuhH7q3NeQQjR
         gc+g==
X-Gm-Message-State: APjAAAUCVvOeDfQ13heHpd7Sl4n2giMz+9Xqh/19yNO/vbFqmi+XsD6k
        BYIqdDr4U5liQjLUEtfg2Nw=
X-Google-Smtp-Source: APXvYqySpI428g7o6G99qflw3R88zdz+Y68wLBnIk9xnlT+Yz50oD7R6++5YGS5TWGhxMSiq6zcNCg==
X-Received: by 2002:a05:600c:21d3:: with SMTP id x19mr5774048wmj.2.1553042339604;
        Tue, 19 Mar 2019 17:38:59 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id g1sm474306wmc.25.2019.03.19.17.38.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 17:38:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] cherry-pick: do not error on non-merge commits when '-m 1' is specified
References: <87efh0pdln.fsf@javad.com>
        <xmqqsh5gt9sm.fsf@gitster-ct.c.googlers.com>
        <8736nj2jcl.fsf@javad.com>
Date:   Wed, 20 Mar 2019 09:38:57 +0900
In-Reply-To: <8736nj2jcl.fsf@javad.com> (Sergey Organov's message of "Tue, 19
        Mar 2019 14:29:14 +0300")
Message-ID: <xmqqbm26xtum.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> I think that "first-parent is special" is the way to go indeed for
> porcelain, as it does make many thing easier and more convenient[*].

Perhaps.  However ...

> [*] One example that immediately comes to mind is "git log -p" for a
> merge commit. I doesn't currently (as of v2.10) show the first-parent
> diff, for whatever reason. "git log -p -m --first-parent" is needed to
> get the answer to most "obvious" question: what (merge) commit did to my
> mainline? "git show" has its own issues.

... this is very much deliberate and will remain so.

A single ball of wax "diff M^ M" for a merge commit is not always
what you would want, especially while viewing "git log -p" (without
"--first-parent").  The reason why the user does not explicitly say
"--first-parent" is because the user wants to even see the details
of individual steps of what happened on side branches.

Incidentally, in such an "I am interested in what happened in each
individual step" mode, the primary change that a merge by itself
does is better shown with "diff --cc M^ M", not "diff -p M^ M".
That is why "show" defaults to "--cc".

"git log -p --first-parent" that requires "-m" to show the single
ball of wax diff for a merge is a separate matter.  When the user
explicitly says "log --first-parent", it is a clear indication that
the user does not want to see individual steps of how side branches
built what each merge brings into the mainline.  From that point of
view, ever sice I introduced "--first-parent" traversal, I've been
wondering what the true downside would be if we turned "-m" on
automatically when these two options are used without "-m".

But it has not disturbed me deeply enough to bother looking into it
further.
