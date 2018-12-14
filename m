Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58B6620A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 02:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbeLNCgx (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 21:36:53 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54797 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbeLNCgx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 21:36:53 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so4268060wmh.4
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 18:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0k6H/MkkUJqkkeXuN6L9XPZkY7X2tRkwo48TZyK2pvw=;
        b=ej271pvNhpslNj8rN/8mkXG3jEdamH/A7R261dy/QLjaAj5zFIhOMgB2wFFGiH8P99
         fSRLHJfj8UoUYcaD1kkVHZhGwaEacUiHAqkNH6RW5F7B7tLaXIOVfImymeo2uKrBhApX
         Q9Lq6leyaUGi+rFz0Knmlima7eVqDD6Ug4muip1LpMD0xuZBYyweWzCIOMyDwLK+euuX
         4FoMvNkbHdPxm5tVkh1BsZOxy67O+MHHGGKO/SRCxSRFhXSsyRtUD0sxXqBJ/gPTZn/h
         L62DhPV86svjBfCZt7e0SuOqjCEwZKMHwUcExDYpZQPQ9GHp7OhRLSYLJn+cRGcTpCBE
         mYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0k6H/MkkUJqkkeXuN6L9XPZkY7X2tRkwo48TZyK2pvw=;
        b=jE1jY6jwlURx1wwSjwHAjyRfU0oX5eqsVoKd3hezWHnFmeycxkVaWz6zR85DLFSdjo
         U/oIpZnKaMobh9wMgt3K//Dn1Jl1u/7NVKRhAdlmCp4qBcc2Af8mTANFoiIn+araeehd
         prB4dhtffgY8IpAN3gFY06m8kewNdhVQjOx2pAwHEKEruxKfCDCT0pA36/ol5fewLf6c
         FUMkIG3QmuYrh8IsEz8aijLOZ9WYVLlLIaYbSXziGp83nEX11Pdc1Vb0PlttH8B57eTd
         1OHzzAFTyW6Ztx+GLfbR5cvi4U3anLcD73paAwAbOsmWjEtt3FzBmadPWHLk1k+mJWBU
         siqg==
X-Gm-Message-State: AA+aEWaDhaU1ZjeW+HTI9s86EVEilbu/U5AKYlL/zf1n4kbmQy2njrNj
        qOWXA+qg2TtHi/dzPd1HZu0=
X-Google-Smtp-Source: AFSGD/VTPEWO8tO8r+bepiRNwJxu1EdGtqInAgmF5o5t+faVbHIKELvM2lur186CYrAz6Atj0aTg6w==
X-Received: by 2002:a1c:1a43:: with SMTP id a64mr1537463wma.136.1544755010191;
        Thu, 13 Dec 2018 18:36:50 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y34sm8446977wrd.68.2018.12.13.18.36.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 18:36:49 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] cherry-pick: do not error on non-merge commits when '-m 1' is specified
References: <87efh0pdln.fsf@javad.com>
        <xmqqsh5gt9sm.fsf@gitster-ct.c.googlers.com>
        <871s6n5mtd.fsf@javad.com>
        <xmqqo99qf46q.fsf@gitster-ct.c.googlers.com>
        <87o99qylv5.fsf@javad.com> <878t0twibw.fsf@javad.com>
Date:   Fri, 14 Dec 2018 11:36:48 +0900
In-Reply-To: <878t0twibw.fsf@javad.com> (Sergey Organov's message of "Thu, 13
        Dec 2018 18:35:15 +0300")
Message-ID: <xmqq5zvwesvz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> I came up with the following as a preparatory change. Looks acceptable?
>
> -- 8< --
>
>     t3510: stop using '-m 1' to force failure mid-sequence of cherry-picks
>     
>     We are going to allow 'git cherry-pick -m 1' for non-merge commits, so
>     this method to force failure will stop to work.
>     
>     Use '-m 4' instead as it's very unlikely we will ever have such an
>     octopus in this test setup.

Yeah, that is a good approach.  Thanks for coming up with it.

I agree that it also is a good idea to use a variable to avoid
repeating "4" (and risking the two uses of the constant drifting
apart), but I find a single letter variable 'm' a bit too bland and
not descriptive enough.  Perhaps spell it out as mainline=4,
possibly with a comment why that is not a more-commonly-seen number
like "1"?

	# to make sure that the session to cherry-pick a sequence
	# gets interrupted, use a high-enough number that is larger
	# than the number of parents of any commit
	mainline=4 &&

or something.

> 	Modified   t/t3510-cherry-pick-sequence.sh
> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
> index c84eeef..a873cf4 100755
> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -61,7 +61,8 @@ test_expect_success 'cherry-pick mid-cherry-pick-sequence' '
>  
>  test_expect_success 'cherry-pick persists opts correctly' '
>  	pristine_detach initial &&
> -	test_expect_code 128 git cherry-pick -s -m 1 --strategy=recursive -X patience -X ours initial..anotherpick &&
> +	m=4 &&
> +	test_expect_code 128 git cherry-pick -s -m $m --strategy=recursive -X patience -X ours initial..anotherpick &&
>  	test_path_is_dir .git/sequencer &&
>  	test_path_is_file .git/sequencer/head &&
>  	test_path_is_file .git/sequencer/todo &&
> @@ -69,7 +70,7 @@ test_expect_success 'cherry-pick persists opts correctly' '
>  	echo "true" >expect &&
>  	git config --file=.git/sequencer/opts --get-all options.signoff >actual &&
>  	test_cmp expect actual &&
> -	echo "1" >expect &&
> +	echo "$m" >expect &&
>  	git config --file=.git/sequencer/opts --get-all options.mainline >actual &&
>  	test_cmp expect actual &&
>  	echo "recursive" >expect &&
>
> -- 8< --
