Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 251651FAF4
	for <e@80x24.org>; Sat, 11 Feb 2017 16:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750841AbdBKQtr (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Feb 2017 11:49:47 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33773 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbdBKQtq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2017 11:49:46 -0500
Received: by mail-wm0-f67.google.com with SMTP id v77so11358062wmv.0
        for <git@vger.kernel.org>; Sat, 11 Feb 2017 08:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WbybNf8IlSBFrh/BVTgE5mWZCtxJTWvrxjOxjnuefLQ=;
        b=jEIgTsMLws8uLYo89Nshk3ZOvtihiUUzAN25CVmKfZxSQsqmn20tKMzlxb8lhoVI3R
         i9DbOltQ/dS/0Uuufc6ozlJFm1ITA7T1D3uvxCaChhMx7SoaDd7Uecm4SNWybYCHg/Sv
         F/q7FvFz67KtswuhDK4eyPSgBzDS2cP8pYkIleFMFwK5V2QwuutxyMlmTKYDpNq4WEM/
         iDSrMlmkopmZAg/KYis/eH94HIqUXPiNQj92O8m9csQ6cD95YRPNnBQ5slZt/QJwRKV4
         k69m4FW/DwR22C2RzyqmRv/ZWCrUriS+ddfz+Hkv5yV0oNPRL2gVVmkvIBYHBWrD+7Cc
         WLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WbybNf8IlSBFrh/BVTgE5mWZCtxJTWvrxjOxjnuefLQ=;
        b=lsj8UPyeWllPwyT8FhvIbFywhCEU3BVyNtxCdwbWSo5hHAYgbemVHq7/REYL3MrXxC
         cdcuNdthX6/HC7z/n5Oty2cW+IogcrCgYlRjgOPUrPp4Ro0p1i+5dASWggHdzvWvh2ka
         WcJP38pQvx8AjC8yn7fjOlT9hVAnnmGDIUn1GA8Dg/YCmg06M6HHd4Am1ruwlhyBfhVN
         GbwM1kON0yGdpD1MrGz6G/7WCu9QwG+ZUL/CEjy39QsxA/rJ0bo6MJtXO0D5kbJs8Hjg
         FAaZS9pH8QSPRkqOQyGTZYi3fFZcijJEWxMhB/8+RveXkotFDqoMpXv0F/vfFUO8KvMy
         0L5Q==
X-Gm-Message-State: AMke39lFQgwHDWsrdaeAvZS2pHMbrt4nKxmihBZYWzEP4h7k4lt47pPTkuVuseRNiaOqVA==
X-Received: by 10.28.19.207 with SMTP id 198mr11270238wmt.70.1486831784763;
        Sat, 11 Feb 2017 08:49:44 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id k18sm3819309wrd.62.2017.02.11.08.49.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Feb 2017 08:49:44 -0800 (PST)
Date:   Sat, 11 Feb 2017 16:50:17 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?Q?=D8yvind_A_=2E?= Holm <sunny@sunbase.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 5/5] stash: teach 'push' (and 'create') to honor
 pathspec
Message-ID: <20170211165017.GB23081@hank>
References: <20170129201604.30445-1-t.gummerer@gmail.com>
 <20170205202642.14216-1-t.gummerer@gmail.com>
 <20170205202642.14216-6-t.gummerer@gmail.com>
 <xmqqmvdz3ied.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmvdz3ied.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/05, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > @@ -72,6 +72,11 @@ create_stash () {
> >  			untracked="$1"
> >  			new_style=t
> >  			;;
> > +		--)
> > +			shift
> > +			new_style=t
> > +			break
> > +			;;
> >  		*)
> >  			if test -n "$new_style"
> >  			then
> > @@ -99,6 +104,10 @@ create_stash () {
> >  	if test -z "$new_style"
> >  	then
> >  		stash_msg="$*"
> > +		while test $# != 0
> > +		do
> > +			shift
> > +		done
> >  	fi
> 
> The intent is correct, but I would probaly empty the "$@" not with
> an iteration of shifts but with a single
> 
> 	set x && shift
> 
> ;-)

Thanks, I knew there had to be a better way, but I was unable to find
it.  I think I like Andreas suggestion of "shift $#" the best here.

> > @@ -134,7 +143,7 @@ create_stash () {
> >  		# Untracked files are stored by themselves in a parentless commit, for
> >  		# ease of unpacking later.
> >  		u_commit=$(
> > -			untracked_files | (
> > +			untracked_files "$@" | (
> 
> The above (and all other uses of "$@" was exactly what I had in mind
> when I gave you the "can we leave the '$@' the user gave us as-is?"
> comment during the review of the previous round.  
> 
> Looks much nicer.
> 
> > +test_expect_success 'stash push with $IFS character' '
> > +	>"foo	bar" &&
> 
> IIRC, a pathname with HT in it cannot be tested on MINGW.  For the
> purpose of this test, I think it is sufficient to use SP instead of
> HT here (and matching change below in the expectation, of course).

Will change.

> > +	>foo &&
> > +	>bar &&
> > +	git add foo* &&
> > +	git stash push --include-untracked -- foo* &&
> 
> While it is good that you are testing "foo*", you would also want
> another test to cover a pathspec with $IFS in it.  That is the case
> the code in the previous round had problems with.  Perhaps try
> something like
> 
> 	>foo && >bar && >"foo bar" && git add . &&
> 	echo modify foo >foo &&
> 	echo modify bar >bar &&
> 	echo modify "foo bar" >"foo bar" &&
> 	git stash push -- "foo b*"
> 
> which should result in the changes to "foo bar" in the resulting
> stash, while changes to "foo" and "bar" are not (and left in the
> working tree).  And make sure that is what happens?  I think with
> the code from the previous round, the above would instead stash
> changes to "foo" and "bar" without catching changes to "foo bar",
> because the single pathspec "foo b*" would have been mistakenly
> split into two, i.e. "foo" and "b*", and failed to match "foo bar"
> while matching the other two.

Thanks, I'll add a test for that.
