Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D2D51F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 18:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfACSJX (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 13:09:23 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33177 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfACSJX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 13:09:23 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so34465025wrr.0
        for <git@vger.kernel.org>; Thu, 03 Jan 2019 10:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Mu3KJqryflewK/d3svTKzaQF7WYO328pQnSsbJAvqxc=;
        b=GIx/LBcgGhvr2kEGCJoVFA3RxZoWOU5mzk4WFNOika7yvEdByQpooLZyU7yni4nYQF
         o52Yg3CR9Y2CP0Zmbnmx3anUPAar+g6RJmJ/8XdrBG8Iu2/v4hnX3H6oUXG8ZGKKJN4g
         d+kPBKZyzmKDjQTMpSudyIOTXn4SH6Jk4p3cbMCLV960/XjSgx5Y1vSvktubKipPyB5W
         HlsRm/t+icylL6NOXEKJEhUTNYJmmL8ufk/5waKBdmsCTy/dQSnoB7j5R6qc5UnTtPai
         iqjBI0aggd2Mx3KDVP+t5TpoO0SWZYot5mEiSrm2TgiyESuSkrtkaQxMbQBkiASptsC5
         dH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Mu3KJqryflewK/d3svTKzaQF7WYO328pQnSsbJAvqxc=;
        b=qFNfd6gCOXF4AAIM86IClfQGa2LIhiKhiU5J4stNZ3wp/A3ZsaGV0nMvosn4oLav/F
         Ivnx+c1vqEGX/G0ZQk3J/j5Cl6o6iEcC16jWM7p94d0XcHD43MAto3U7Iz6+UtERAoOG
         +qJ/TSXLxJ/Hi1W0dswqrPy2J471Z8YN88xMBJM0dksyFp6uoBcM02vF8FFBHqTi8Otu
         DnMbhI2bD27jix+CAhbRP56raF17zU8CozECY3B2nifnE4SMnWQtX6I949zeA+L4qwYe
         GJGVZDyBsDvUN63s1/fRm4va2k+SB48hZ9FXJP1v/jYCwQF4EFwdoo4/SkjWWKPK2uMw
         +PDA==
X-Gm-Message-State: AJcUukfcwEtOPIXF7HfxmDvlPhF/tfgBhMMO66kM58UGu39kXD/gq2tc
        8M0VeRFjxefpA8jWS2PKQYg=
X-Google-Smtp-Source: ALg8bN6E+QELp6gAA2eF0nebpAvEqHtFbYVSkbEagqWKc+8/gSwyNtjp7PF+KfDqSrY40WdPeuWrpg==
X-Received: by 2002:adf:b502:: with SMTP id a2mr44913508wrd.54.1546538961188;
        Thu, 03 Jan 2019 10:09:21 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n11sm476518wrw.60.2019.01.03.10.09.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 10:09:19 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Erin Dahlgren <eedahlgren@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3] Simplify handling of setup_git_directory_gently() failure cases.
References: <1544922308-740-1-git-send-email-eedahlgren@gmail.com>
        <1545953789-15040-1-git-send-email-eedahlgren@gmail.com>
        <20190103051432.GE20047@sigill.intra.peff.net>
Date:   Thu, 03 Jan 2019 10:09:18 -0800
In-Reply-To: <20190103051432.GE20047@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 3 Jan 2019 00:14:33 -0500")
Message-ID: <xmqqy381haup.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


>Subject: Re: [PATCH v3] Simplify handling of setup_git_directory_gently() failure cases.

Perhaps

	Subject: setup: simplify setup_git_directory_gently() failure cases

to clarify which part of the entire world this patch is touching.

Jeff King <peff@peff.net> writes:

> This patch isn't _too_ big, so I don't think it's worth the effort at
> this point for this particular case, but just something to think about
> for the future. A series around this topic would probably be something
> like:
>
>   1: drop the useless chdir and fold setup_nongit() into the main
>      function
>
>   2: stop doing the early return from HIT_MOUNT_POINT, and treat it just
>      like HIT_CEILING (and drop the useless strbuf release)
>
>   3: treat GIT_DIR_NONE as a BUG
>
>   4: rearrange the nongit logic at the end of the function for clarity

Yeah, that organization does make sense.  And I agree with your rule
of thumb to use the length and complexity of the log message to
judge if a single step is getting too big.

> We usually avoid "//" comments, even for single lines (though that is
> perhaps superstition at this point, as we've started to embrace several
> other C99-isms). IMHO this particular comment is not even really
> necessary, as the whole conditional is suitably short and obvious after
> your refactor.

FWIW "git grep" for // seems to show that we reserve use of //
inside commented out code samples.

I also agree the comments behind // in this patch are probably
unneeded.

>
>> @@ -1132,7 +1142,10 @@ const char *setup_git_directory_gently(int *nongit_ok)
>>  	 * the user has set GIT_DIR.  It may be beneficial to disallow bogus
>>  	 * GIT_DIR values at some point in the future.
>>  	 */
>> -	if (startup_info->have_repository || getenv(GIT_DIR_ENVIRONMENT)) {
>> +	if (// GIT_DIR_EXPLICIT, GIT_DIR_DISCOVERED, GIT_DIR_BARE
>> +	    startup_info->have_repository ||
>> +	    // GIT_DIR_EXPLICIT
>> +	    getenv(GIT_DIR_ENVIRONMENT)) {
>
> Same "//" style issue as above. I'm not sure how much value there is in
> repeating the GIT_DIR_* cases here, as they're likely to grow out of
> sync with the switch() statement above.

It is unclear to me if the original code is doing the right thing
under one condition, and this patch does not seem to change the
behaviour.

What happens if GIT_DIR environment is set to an invalid path and
nongit_ok is non-NULL?  setup_explicit_git_dir() would have assigned
1 to *nongit_ok, so have_repository is false at this point.

We enter the if() statement in such a case, and end up calling
setup_git_env(gitdir) using the bogus path that is not pointing at a
repository.  We leave have_repository to be false but the paths
recorded in the_repository by setup_git_env() would all point at
bogus places.

> At first I thought this could all be folded into the "else" clause of
> the conditional above (which would make the logic much easier to
> follow), but that wouldn't cover the case of GIT_DIR=/bogus, which is
> what that getenv() is trying to handle here.

Yes, but should GIT_DIR=/bogus even be touching the_repository?  

It is a separate clean-up and does not affect the validity of this
simplification patchd, so I agreee with ...

> So I think this is the best we can do for now.

Thanks.
