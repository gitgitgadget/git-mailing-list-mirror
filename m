Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E679F20282
	for <e@80x24.org>; Tue, 20 Jun 2017 18:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751040AbdFTSuE (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 14:50:04 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:33705 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbdFTSuD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 14:50:03 -0400
Received: by mail-wr0-f177.google.com with SMTP id r103so103028729wrb.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 11:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6Jqc5eiz9KBzxhAh6YpA0q1qttTDDRF8YP7KVSs+ZkY=;
        b=kCtAfjXrO7cDiFhPL1g916qzLzqegE7/ZZYyqCkyBkBvzauZdDOeyF4Ap8WXEat+jE
         jW6r3iwYlPM9zuEaftj6GEfjf5BrfBReSg/in59kOqXIDXUw12horgmbYoruXtLtBNf7
         5vnWvEyq3SA3YPLXH99QuHL03oMB7JB/rRkiE7ay/XBTT293iFxm0sfzQJcF8A54siVW
         /yqbvR6NoNnx0YwTeVEAFsXJZqXs+EOW9UJRnu3poFPmXAgQCFsnAV9pRL5g2OX5gfre
         pFlMG2mL4QmV+jYc0vpynPUsymYdbayTNAkuF4HGyuF19PpOdCi63Y78kvNwRoRfGlqs
         t6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=6Jqc5eiz9KBzxhAh6YpA0q1qttTDDRF8YP7KVSs+ZkY=;
        b=WB1bdTpVMBeNl0Vn5RTA/TRmVf9DX5jc2hpilytH1+VvlCis8GmNRBo2uLDWaQwODp
         mrTmLA1DmmWC3h/sDUurv/ObFBAuVTCShj8kGy+orQl0MrrfL3/cl+zmyPzqBl4kq1nr
         Ws5kr2RdEbw2J2Hr4df0znM4kKp0C2wOBrU82SJzJFHgXNuNtVsRx6AZb8GbGFsDilrz
         CmKS66Wvm5aT4KmVH8KEZ3KaWRS2qcaxjnr+592uiXm3A+Ar9HykUKINAqlzkap0kJdS
         x6heDqFajEplsvLw7Kh/gUrow1kL3HNk7rp5KD9jKCRSlNUh4aw87JjwZuXUw9Qa4TJE
         eFxQ==
X-Gm-Message-State: AKS2vOwfLrzw2UUc3mFfyyRDr0edEYTPj9/uWBzCluAWEXYJ4zQxx70Y
        WukUrOc8v4mBFtVoqwQ=
X-Received: by 10.80.214.89 with SMTP id c25mr6362796edj.13.1497984602254;
        Tue, 20 Jun 2017 11:50:02 -0700 (PDT)
Received: from snth ([92.109.130.42])
        by smtp.gmail.com with ESMTPSA id 51sm6529938edz.2.2017.06.20.11.50.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 11:50:01 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dNODv-000181-Tk; Tue, 20 Jun 2017 20:49:59 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH] die routine: change recursion limit from 1 to 1024
References: <20170619220036.22656-1-avarab@gmail.com> <20170620155459.a6e7pypxx6vpdbvs@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20170620155459.a6e7pypxx6vpdbvs@sigill.intra.peff.net>
Date:   Tue, 20 Jun 2017 20:49:59 +0200
Message-ID: <87lgom8pew.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 20 2017, Jeff King jotted:

> On Mon, Jun 19, 2017 at 10:00:36PM +0000, Ævar Arnfjörð Bjarmason wrote:
>
>> Change the recursion limit for the default die routine from a *very*
>> low 1 to 1024. This ensures that infinite recursions are broken, but
>> doesn't lose error messages.
>>
>> The intent of the existing code, as explained in commit
>> cd163d4b4e ("usage.c: detect recursion in die routines and bail out
>> immediately", 2012-11-14), is to break infinite recursion in cases
>> where the die routine itself dies.
>
> I agree that was the original intent, but I think it also does something
> else. Anytime die() recurses, even a single level, we're going to cover
> up the original failure with the one that happened inside die(), which
> is almost certainly the less interesting of the two.
>
> E.g., if I
>
>   die_errno("unable to open %s", filename);
>
> and then the die handler calls malloc() and fails, you'd much rather see
> that first message than "out of memory".
>
> To be fair, "die handler is recursing" is _also_ not helpful, but at
> least it's clear that this is a bug (and IMHO it should be marked with
> BUG()). Saying "out of memory" tells you about the second error, but it
> doesn't tell you that we've masked the first error. So it may lead to
> more confusion in the long run.
>
> I wonder if we can get the best of both, though. Can we make the logic
> more like:
>
>   if (!dying) {
> 	/* ok, normal */
> 	return 0;
>   } else if (dying < 1024) {
> 	/* only show the warning once */
> 	if (dying == 1)
> 		warning("I heard you liked errors, so I put a die() in your die()");
> 	return 0; /* don't bail yet */
>   } else {
> 	BUG("recursion detected in die handler");
>   }

If I understand you correctly this on top:

    diff --git a/usage.c b/usage.c
    index 1c198d4882..f6d5af2bb4 100644
    --- a/usage.c
    +++ b/usage.c
    @@ -46,7 +46,19 @@ static int die_is_recursing_builtin(void)
     	static int dying;
     	static int recursion_limit = 1024;

    -	return dying++ > recursion_limit;
    +	dying++;
    +
    +	if (!dying) {
    +		/* ok, normal */
    +		return 0;
    +	} else if (dying < recursion_limit) {
    +		/* only show the warning once */
    +		if (dying == 1)
    +			warning("die() called many times. Recursion error or racy threaded death!");
    +		return 0; /* don't bail yet */
    +	} else {
    +		return 1;
    +	}
     }

     /* If we are in a dlopen()ed .so write to a global variable would segfault

Will yield this over 1000 runs, i.e. mostly this works and we emit the
warning (although sometimes we miss it, and we might even emit it twice
or more due to an extra race condition we have now):

    $ (for i in {1..1000}; do ~/g/git/git-grep -P --threads=10 '(*LIMIT_RECURSION=1)(*LIMIT_MATCH=1)-?-?-?---$' 2>&1|perl -pe 's/^fatal: r.*/R/; s/^fatal: p.*/P/; s/^warning.*/W/' | tr '\n' ' '; echo; done)|sort|uniq -c|sort -nr|head -n 20
        245 W P P
        222 W P P P
        212 W P
         47 P W P
         36 W P P P P
         35 P P P
         35 P P
         30 P W P P
         16 P P W
         14 W W P P
         12 P P W P
         11 W W P P P
         11 P
          8 W P W P P
          8 P P P P
          7 W P P P P P
          7 P W P P P
          6 W P W P
          4 P W P W
          3 W W P P W

I think it makes sense to apply that on top, even though we could print
more than 1 warning here it makes sense to alert the user that we're in
the middle of some racy death, it explains the multiple lines of output
they'll probably (but not always!) get.

As you can see the third most common case is that we needlessly print
out the warning, i.e. we have only one error anyway, but we can't
guarantee that, so it probably makes sense to emit it.

To reply to your 20170620161514.ygbflanx4pldc7n7@sigill.intra.peff.net
downthread here (where you talk about setting up a custom die handler
for grep) yeah that would make sense, but as long as we're supplying
this default behavior (and not outlawing using it with pthreads) it
makes sense to get out of our own way with this recursion detection.

I think my patch (possibly with the fixup above, depending on what we
think about dupe warnings) is just fine to fix this. This is already a
super-rare edge case in grep, and to the extent that it would be a
problem for anyone it's because our paranoid recursion detector totally
hides the error, I don't think it's worth worrying about us printing a
few dupe error messages under threading for something that almost never
happens.

At least, that's starting to go beyond my bothering to hack on it :)

>> Now, git-grep could make use of the pluggable error facility added in
>> commit c19a490e37 ("usage: allow pluggable die-recursion checks",
>> 2013-04-16).
>
> Yeah, I think this is a bug in git-grep and should be fixed, independent
> of this commit. You should be able to use as a template the callbacks
> added by the child of c19a490e37:
>
>   1ece66bc9 (run-command: use thread-aware die_is_recursing routine,
>   2013-04-16)
>
> -Peff
