Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C6FA20D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 21:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751130AbdFAViO (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 17:38:14 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:32836 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbdFAViM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 17:38:12 -0400
Received: by mail-pf0-f170.google.com with SMTP id e193so38193817pfh.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 14:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=XXW2Jk8MDUfqT48afPbe/W7e4wGDaQxZF0dVHY0989w=;
        b=qzwQgJ1w7h195ncvts2yOGZzRtB2fR2y1m3xigO2ZP0J69sNXEqcuPNVdmzPpboPr1
         e3QXZmlpBGuS5ptnjEhzoOSdYKOn8TnslwUOW/08M0fwcstOAJdmLpWcA/YErWl5rKq8
         tfJXLpjFBid1bfwUw5kJEihx2N2/24B8HUp4zwWy1VzbM/A0edlQduHq44oyia84ckd4
         0vddQmiWHkEbP/ViOWQPZeymmQItjzg1BjBi7dpai8esm85uI335pqFisUdDcuFu/8rk
         nA66BTFmivLwvxk70GLBXIgGi8aqpNhLRJ+qxg8xFrZQYEymrqWnPUqvOElB4WbxtOqe
         mosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=XXW2Jk8MDUfqT48afPbe/W7e4wGDaQxZF0dVHY0989w=;
        b=enjiVEJWZYhbomtcLfHnQkQsgemDyhUKLU9mIkSQCvYYL1TnKP9OtYYdguHrQeWa1o
         +oXlK64SLng6Kh1C3EBnxOG8KeI3lIvxRToLw2DerV1uJRWJwgiHqQPu68ntHjnN+LO0
         wlW8kNq1UNeCPtJUVfLKNf0dpBlXWnNrQwTRLoEIQbHggTG2zHSgEH814Lr4WostwtXp
         7L/TvWxy5Fgxn/gXMUNf1CGSjmdaLBMUPL97Vvt13kL4yFp1gwPEPSBQuFjUEgKbETDw
         HOfgaBG313dBawQyW9G90B0nMEyfK404FtqYwLIQEaO0NgGrK9b+Uriy7RyeaTIuxHRa
         U3gA==
X-Gm-Message-State: AODbwcDJyymV/MR2g/eQLOh0zHreQ7iEe2FRRQ59Rq76p5BG79k1bY/y
        2rvbwdjFupERtw==
X-Received: by 10.98.197.133 with SMTP id j127mr3070622pfg.239.1496353091979;
        Thu, 01 Jun 2017 14:38:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9c1c:dca9:c6e3:133e])
        by smtp.gmail.com with ESMTPSA id e124sm31208346pgc.17.2017.06.01.14.38.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 14:38:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Anthony Sottile <asottile@umich.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: bug: `git log --grep ... --invert-grep --author=...` negates / ignores --author
References: <CA+dzEBn4EKzDqS0pCHHsPtGGJc1orf5weKKh0GN-GkE+fVYGcg@mail.gmail.com>
        <CACBZZX7OhdRM+Mhx4FVX-Upvq169ZLvArL5ZxcTgz8u=WRh3aw@mail.gmail.com>
        <20170531214019.bbhjdaejvgje3v6g@sigill.intra.peff.net>
        <CACBZZX5j=g=Lnv-X9F5Uaf0wW922R3N=LgrzRKPw853ECmoqYQ@mail.gmail.com>
Date:   Fri, 02 Jun 2017 06:38:10 +0900
In-Reply-To: <CACBZZX5j=g=Lnv-X9F5Uaf0wW922R3N=LgrzRKPw853ECmoqYQ@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 1 Jun
 2017 21:45:51
        +0200")
Message-ID: <xmqqshjj4ce5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Anyway, much of the above may be incorrect, I haven't dug deeply
> beyond just finding that something's funny going on and we definitely
> have *some* bugs here.

One thing that is very correct in what you said is that the
documentation of "--invert-grep" is wrong to mention only "--grep".
It probably is because the author of "--invert-grep" did not realize
that the "--author" thing internally is considered a part of "grep"
processing done in revision.c::commit_match() that chooses which
commit to show.

As you may have noticed, the integration to the grep infrastructure
with "git log" and friends does not expose the power of combination
(e.g. "--and", "--not", etc.), unlike "git grep", to the command
line.  This is purely a technical limitation (e.g. "--not" is taken
to mean a completely different thing in "git log" family) and there
is no fundamental reason why we shouldn't, but the fact that the end
user cannot combine the "--grep" like terms in a flexible way
remains from the beginning to this day.

Within that constraint, --grep and things like --author are defined
to interact in a certain hardcoded way (the former searches
substring in the body part of commit objects while the latter
searches substrings in the "header" part of them), simply because
defining them to be all ORed together does not give us a very useful
semantics.

In general, two or more of these searches always "OR" together,
e.g. "git log --grep=foo --grep=bar" finds commits that mention foo
or commits that mention bar.  However, searches in body and searches
in header "AND" together, e.g. "git log --author=Ævar --grep=foo"
finds commits that mention foo and written by you.  "git log
--author=Ævar --author=gitster@ --grep=foo --grep=bar" finds commits
that mention either foo or bar and written by either you or me.
IIRC, its parse tree would look like

    (AND (OR (author Ævar) (author gitster@))
         (OR (grep foo) (grep bar))

The "--invert-grep" merely adds (NOT ...) around it.

I vaguely recall there was impliations to "all match" when the
header search and the body search is used together.  Without header
search, the usual "git log --grep=foo --grep=bar" becomes

         (OR (grep foo) (grep bar))

and "--all-match" is applied to this "OR" (i.e. by the time the
matcher finishes a single commit's body, all of the terms ORed
together, i.e. (grep foo) and (grep bar), must have matched at least
once for the commit to be considered a match.  Obviously, a commit
can be authored and commited by only a single person, and applying
all-match naively to "git log --author=Ævar --author=gitster@" would
not make any sense (by definition the result would be an empty set),
and IIRC there is a code that copes with this to avoid requiring a
commit that is written by two people (or committed by two people)
when "--all-match" is in effect.

So taken all together, your example and its output makes all sense
to me.  As you mentioned, the examples by the OP was written a bit
too dense for me to grok quickly and I didn't look too carefully at
them to comment.
