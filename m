Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A545B1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 15:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933271AbeGFPCu (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 11:02:50 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54266 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932725AbeGFPCT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 11:02:19 -0400
Received: by mail-wm0-f68.google.com with SMTP id b188-v6so15214968wme.3
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 08:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DXoFvSfbhUpV6qLcPBTziGnox3jzvzliz2T9FbHwjs0=;
        b=pgBNJJbUY7OhOboPCuZdSHkLSdwCsM6QNb/7vJkbTxI7UMgOmheZypnq9G95GiMyh/
         Kg39GtRvxWNZpIz8hyylUalEfkuvuP8jcAN+YZj0Ky065JgRm07M3eR2FO/GKnTLl8zB
         Ud1J102cdIZIqfIScAFi5V0wFJMZgKd7oPVOY2BvNt6xAQGW0SlhRvUmYS0IgKnjs6Jo
         musJ0FZNZs/meX13diyyluf/uFGnpaloIHipRIS0QC9GEdav/Weq6Mx2zy5sKUh5Ru1L
         vPOdg3kOPI104J5n0+t8pzHqYupI5h3E7ZOt3aYfvJhMFELXwc983/qq2YIipjtdXnNy
         ZPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DXoFvSfbhUpV6qLcPBTziGnox3jzvzliz2T9FbHwjs0=;
        b=Ejk6f0F/KVvCQvgcZ+cxi12G7/AzGSLpbaLQPNVeWe8NPvObpDjzqfQi7iwUhyxMiE
         vNHzYqmm1bPWi2gZXqitmjLyy6Rpv5/T0X0D7T8EzlsXsq1dmr80KxyOUpe+8rRDsbpS
         AiX6cWOi8RnOqSqytt2+Oi7jYRyIH6R0grIx2VufyhDpVbw4/6RwtoQWmXkW1rna4pbt
         vWUD4GhxkYGW4Yl4B4w56ydSAKKGQrw82YryeMDgebI13blGEDREXeWrbJy9QmA5HPmt
         chtuP6auXlj+onPq/bZKwMcPy0guSelbR31yCjM2UYY3zr0z9Z3UiXaAA8mfY6O/0VIR
         u3Tg==
X-Gm-Message-State: APt69E1SlO9gmDT/nTLbWcco6RAKr2dr+grBEUkf5kObONc6crPCTR3+
        naATrGCr4K/pJxnhiblFkcY=
X-Google-Smtp-Source: AAOMgpdaDYDk4QTlutNfhmEYm2NxI0c0rt6eoR402B/0qFzV25NwKrnlBxQa21pL4mrDgscjaP9CAw==
X-Received: by 2002:a1c:9ec5:: with SMTP id h188-v6mr7276417wme.76.1530889338218;
        Fri, 06 Jul 2018 08:02:18 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i12-v6sm8443166wrn.48.2018.07.06.08.02.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 08:02:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v2 6/7] rebase -i: rewrite setup_reflog_action() in C
References: <20180702105717.26386-1-alban.gruin@gmail.com>
        <20180702105717.26386-7-alban.gruin@gmail.com>
        <xmqq8t6soy2f.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807061457250.75@tvgsbejvaqbjf.bet>
Date:   Fri, 06 Jul 2018 08:02:13 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1807061457250.75@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 6 Jul 2018 14:58:32 +0200 (DST)")
Message-ID: <xmqqy3eommq2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I thought we made this into
>> 
>> 	if verbose
>> 		return run_command
>> 	else
>> 		return run_command_silently
>> 
>> to help readers in the previous round already.
>
> FWIW we had quite a couple of reviews in the recent years which pointed
> out "unnecessary else" after returning or die()ing. Maybe we should make
> up our minds, and set a consistent rule to follow.

FWIW the pattern you are referring to is

	do something;
	if (error detected) {
		return error(...);
	} else {
		perform
		remaining
		actions
		the function needs
		to complete
	        its task;
	}

and those reviewers (including me) are absolutely right that such an
"else" is not just unnecessary but actively harms readability of the
flow of logic.

I am also absolutely right when I say what is quoted at the top
makes 100% more sense than

	if (verbose)
        	return run_command();
	return run_command_silently();

as these two are about doing the same thing a bit differently.  

The way to think about the latter is that we won't have this "if
(verbose)" if there were a variant of run_command() that took a set
of option bits among which is a verbose bit, but instead would have
a single call to that function that returns..  So it's not like "in
an exceptional case, return after calling this function; otherwise
keep going, which happens to only return after calling another".  It
is more like "here we need to return after spawning a command, but
depending on this bit, we spawn the command using a different
function".

Good programers recognize the difference between these two patterns
without being told, and mentors should teach and GSoC student should
learn that an overly simplified rule like "when 'if' block ends with
return, do not write 'else'" is harmful.
