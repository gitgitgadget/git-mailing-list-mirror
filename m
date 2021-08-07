Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC02C4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 18:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C58F61052
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 18:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhHGSIs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 14:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhHGSIs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 14:08:48 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCF7C0613CF
        for <git@vger.kernel.org>; Sat,  7 Aug 2021 11:08:30 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so18725976pjn.4
        for <git@vger.kernel.org>; Sat, 07 Aug 2021 11:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZMidvCWSYbBcoGpdLt2287Pclnrjo7GS5kqd/H810Lg=;
        b=IfcR4u86qMi05PQXk5bgVGnOMhLrtYwXRRBziw9gtIqMwWLjyUPUZ+l8NlfVsikVcK
         18aln7+b+NwbgI3zPxTQz4X3aBISXNQaurkJ8K/GSvz12P8j5h+Q14nSt4+OqUo73pf2
         EXu9c7yf8IyESaLbmh2CzgotFEUGsLgJeEyhZSIuRaUP3Xd9xCxDrnyvLOo4lyL/9OT+
         5qKW3gXL1/kEjb8XFYqQkVG9P+nRNsbynffW4yvnpvLd8CP6uN/0hcaLFBtb+w6tGbG2
         PmalvRz14WcKDO/XUBahYY3ZDnLp8INMGGwDJj/sb/9HWuREbx0yb1JRMF1I7YIydXI3
         h4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZMidvCWSYbBcoGpdLt2287Pclnrjo7GS5kqd/H810Lg=;
        b=k2NXgOCGVNEuu4TiUKw47qXldtI80YwKgehfYkJSD7MBNwDU0oQ/nUbdeRHb4LL4PN
         pR5DlSplDS7UZ8VlFbm2UAQGc/EX/kp4vCI5vI+6oJpDQyZ5HmF2RKmr8tYvWS9VEqNC
         VGnabRdFWMZAx8F5sfT7zGaKn4fPza/8z0mTYGprTVZDya/S34tZypxSMGlT9hsIMhv/
         k9Dsz9QspC1NcgHPoSYR0hAY7IOdV2nkFjdqo/k/6imW4LtlvdrvDbK/mOaos4W4hY1O
         my7ACrFW44PhM+oIBTjfvMHT6YzD85gqXMB9uA7RjLZiEL0ySp5U15cfGRbzaq8/hsdR
         Dvrw==
X-Gm-Message-State: AOAM5319DbwG5FhGDwTn1o5tjOB59A4MxNadMEko+TIvZ1RB4kCibNjB
        BlfyZYKunqWqb3gq6QCctZs=
X-Google-Smtp-Source: ABdhPJwlU2laS0Fv0Vj86ynCuHLzR8hIsJ0G6LOHcb5glyHqSaKGYXPQ1oszMXQTgCpT1P22+GPf2Q==
X-Received: by 2002:a05:6a00:1311:b029:3b2:87fe:a598 with SMTP id j17-20020a056a001311b02903b287fea598mr10927001pfu.74.1628359709933;
        Sat, 07 Aug 2021 11:08:29 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:7578:9c9b:8fe8:cece])
        by smtp.gmail.com with ESMTPSA id p23sm14964042pff.158.2021.08.07.11.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 11:08:29 -0700 (PDT)
Date:   Sat, 7 Aug 2021 11:08:26 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Sergey Organov <sorganov@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Hudson Ayers <hudsonayers@google.com>,
        Taylor Yu <tlyu@mit.edu>, Joshua Nelson <jyn514@gmail.com>
Subject: Re: [PATCH] Revert 'diff-merges: let "-m" imply "-p"'
Message-ID: <YQ7MGoNswyZJHjkZ@google.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210520214703.27323-1-sorganov@gmail.com>
 <20210520214703.27323-11-sorganov@gmail.com>
 <YQtYEftByY8cNMml@google.com>
 <YQyUM2uZdFBX8G0r@google.com>
 <xmqqh7g2ij5q.fsf@gitster.g>
 <YQ3n9Z2nH35429mC@google.com>
 <035b4e99-e708-f31b-2f13-e255d99dea33@kdbg.org>
 <YQ6P0OWPPksWG5Hf@google.com>
 <xmqqv94hi3zw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv94hi3zw.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:

> But I didn't see how you think your Rust thing is not a typo, and I
> still don't.  Unless you think Rust folks expected "-m" to do what
> "-m" was not designed to do, that is, and I do not think that
> "people thought it did something entirely differently, when it was a
> no-op, so we shouldn't suddenly make it not a no-op" is a good
> rationale that affects how we choose the evolution path for our
> tools.

Please don't treat this as an attempt to be argumentative: as you've
said, there's plenty of other reason for us to know in retrospect that
making "-m" imply "-p" is problematic for scripts.  Since you asked, I
think it's still worth describing my logic about the Rust example.

I believe the Rust folks expected "-m" to do something that it is
designed to do.  They _also_ overlooked a different subtlety about the
interaction between diff generation and path limiting.  It's good that
Rust's bootstrap.py is fixed now to be more straightforward (by now
it's even using the plumbing command); but it is very easy for another
script author to have had the same confusion, which I might add was a
harmless confusion until this change.  If we changed the behavior to
match their expectation _better_ then it would be a perfectly fine
compatibility break that would be expected to improve the behavior of
more scripts than it hurts.  This change was not in that category.

1. When I add "-m --first-parent" to my "git log -p" invocation, it
   changes what diff it generates.  Until 9ab89a24390 (log: enable
   "-m" automatically with "--first-parent", 2020-07-29), the diff
   shown for a merge with --first-parent was simply "no diff".  A
   script written before mid-2020 that wants to operate on the
   --first-parent diff is highly likely to pass -m.

2. The -m only affects diff generation and does not affect path
   limiting.  So when no diff is being generated it is in fact a
   no-op.  This point is fairly subtle, though, and because it is not
   documented, script authors _in practice_ would only discover it by
   experimentation.

3. A script using -m with the intent of affecting path limiting
   doesn't get any feedback via experimentation that they've made a
   mistake because path limiting with --first-parent already does what
   the script author was hoping for.

What's relevant is not whether the script author was in the wrong or
in the right: it's whether we expect there to be a significant number
of scripts negatively affected by the change.  Because of (1) to (3)
above, I do.

Jonathan
