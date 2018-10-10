Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C81281F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 21:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbeJKFAm (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 01:00:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42168 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeJKFAm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 01:00:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id g15-v6so7325831wru.9
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 14:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2UfmCQ/2IHnjXb/SUSFA1Jk5i89gMb/vjJ2xnecGh38=;
        b=Y6GJcondkFTurqLpxR2pqE3QaJ0brLJFvCJ0Q4suo0WtLrF3n2HOk4cfkWZHmxUci8
         oZQQ+fJJfc34GlldSc1nnvrw1G6Yo0hK3/kubSUsmPDLvEn4kNvEcrh/KH0zz/yMmAuF
         Ddm7YoJV7moJPRhEN+TU9QrSgTYYtDUsgek/rQwwjDb/QGa8LDHhoMZ+B8tDyR5N5D89
         yn8XkRSfjQgiag/FZuZR/QvgxMyjKYQDrTfmA1jPlgLiPM+083J01d0YFRiz/Ma6/RW6
         hiSMDcdck1OiNEuCOiZDXBqW241GB0rM7PSpkn9HpNWLi9hScXg8rfJ3flX72x0EFdll
         ccOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2UfmCQ/2IHnjXb/SUSFA1Jk5i89gMb/vjJ2xnecGh38=;
        b=B9lrTr93azhKg6QdPG+FYl4LP0sIQjDbtHjeZdHEnCAu2RCOhv+WlAEoQ40TymmMb5
         iabm1N3n6ON+J2sNEjHdZAUT+UhwIVl1XibtUnMGb4oPNIX6R8aF5hnoX/Rah+kN3NRx
         wbRZOzatqCc3DBCy3tnD/PG41N6DxWyhC+5PO/9j7u2BToaGB1e+GJscJo46v5ceKfrd
         Q8ALLimOCA5uluPsgkOswxJcJO6bykIrP3wEQ8OJwp8R6C4wfSJEXQcNDvSBCSaKoMZh
         c7w89QGTfcl5cHm7nX9Gcf2ELRuuQ9ZZCTk5hde6oy+JNSTw+q2aTsud5PGhYL29lJlz
         G01Q==
X-Gm-Message-State: ABuFfogZ/Z6Kfb1PdQram4x6TFR0zG/dPbuMg7HPu24uAyy/OZt5CDxI
        ZMP0AOVCszX2B5yJSSHauNyhCYG9Ex4=
X-Google-Smtp-Source: ACcGV62oV8K3cmLE1zcDMGNeEIlQaegceASvi4v/Af7jXM7dMxDqwTexdThvw9nr4+WGwlzLUbtUQw==
X-Received: by 2002:a5d:4101:: with SMTP id l1-v6mr26755325wrp.45.1539207397466;
        Wed, 10 Oct 2018 14:36:37 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a205-v6sm14076043wmh.19.2018.10.10.14.36.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 14:36:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] gc: introduce an --auto-exit-code option for undoing 3029970275
References: <20181010174624.GC8786@sigill.intra.peff.net>
        <20181010192732.13918-1-avarab@gmail.com>
        <20181010205611.GA195252@aiede.svl.corp.google.com>
        <87sh1declw.fsf@evledraar.gmail.com>
        <20181010211428.GA231512@aiede.svl.corp.google.com>
Date:   Thu, 11 Oct 2018 06:36:35 +0900
In-Reply-To: <20181010211428.GA231512@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Wed, 10 Oct 2018 14:14:28 -0700")
Message-ID: <xmqqin29lc0s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Perhaps this reporting could also print the message from a previous
> run, so you could write:
>
> 	git gc --detached-status || exit
> 	git gc --auto; # perhaps also passing --detach
>
> (Names still open for bikeshedding.)

When the command is given --detached-exit-code/status option, what
does it do?  Does it perform the "did an earlier run left gc.log?"
and report the result and nothing else?  In other words, is it a
pure replacement for "test -e .git/gc.log"?  Or does it do some of
the "auto-gc" prep logic like guestimating loose object count and
have that also in its exit status (e.g. "from the gc.log left
behind, we know that we failed to reduce loose object count down
sufficiently after finding there are more than 6700 earlier, but now
we do not have that many loose object, so there is nothing to
complain about the presence of gc.log")?

I am bad at naming myself, but worse at guessing what others meant
with a new thing that was given a new name whose name is fuzzy,
so... ;-)
