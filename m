Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 633A8208E9
	for <e@80x24.org>; Wed, 18 Jul 2018 16:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731025AbeGRRAB (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 13:00:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36608 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbeGRRAB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 13:00:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9-v6so5295605wro.3
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 09:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Y67Rvju5lmB1gKH4s3fewD3DEVNQNkMpcDPH/EzIwAI=;
        b=dKcPlxD13mXyAJDEOMkGJBEEx+VN1QZ4q6Yyj2qU46WTGjNG2nNw4fXEsG4kcZ5B8u
         PSr84b2vnlzPgFcXQw70u1ISZQ85geOvquy6pqJV6LhJlmjkKJl9uXoFb5PStnAv8ky/
         EMMnmAS5ykXjg+TSeRTSKtH41Ht7xLI8tsdVnRyXQXqqr+QJnPrxNXRey43rj/A2sUJs
         hcWGvZtJr9nctGfyFOFi2uxEKD/nfv8Dxtse6iYTayYHdhDHZfgfP3NNti4DJ2RNYi8X
         9/D/c4ILEBXYpf47pAPGTeO/2YS9VLKWOswRDttem2FyicZ0qf7PTXZM5f6JGPyf2Ir2
         F+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Y67Rvju5lmB1gKH4s3fewD3DEVNQNkMpcDPH/EzIwAI=;
        b=OXTEv+CBES5U8aPIMXCyX6lbomcVXpUSTfToXp/L6fS2TpINDMdoX1PT5rai4uyw2w
         HmOFq9Kq8/p9G2e4p5ypNSUa6TqEFfAI2MTzfHSokwn5i8rE8ifg9PslJYZyZGEXO+3X
         3bZjOlFDIg2w8vn4U8ZTDii0hS5QrrchURr/bBLFMksd2opM+F7oUSDCaGcOeWbVKRCj
         K43n71f1hZ1CemL0b3NBbSARBT8nrI1tA1k1XDYx9XhIqV9a/ZzvOFfHCt0oOt2T1mDA
         AmWw0NEEPrAP+LTzAw5M9Ot8LGJr4OkNZgPhhHDCIURbnJrEeAqsVfV9vsNI2Fj+rH1I
         oKbg==
X-Gm-Message-State: AOUpUlFaH0aKgwKWZiktLMgGvlmQSLIS9swIeXfLtAhqB5o5C/2Aotoe
        MxmXyW0pK8uoBF3ke4w5WwEJG3WQ
X-Google-Smtp-Source: AAOMgpelxuNq9mMEbb42rVh0o3ycyrrvbfW0o+rU6usqYaZzgiFoOiRfO3UP4PuiMx9iwt+1MfjW3w==
X-Received: by 2002:adf:e78d:: with SMTP id n13-v6mr5002652wrm.136.1531930881076;
        Wed, 18 Jul 2018 09:21:21 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a14-v6sm1869281wmb.44.2018.07.18.09.21.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 09:21:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Andrii Dehtiarov <adehtiarov@google.com>
Subject: Re: [PATCH 3/3] gc: do not return error for prior errors in daemonized mode
References: <20180716172717.237373-1-jonathantanmy@google.com>
        <20180717065151.GA177907@aiede.svl.corp.google.com>
        <20180717065740.GD177907@aiede.svl.corp.google.com>
        <20180717201348.GD26218@sigill.intra.peff.net>
Date:   Wed, 18 Jul 2018 09:21:18 -0700
In-Reply-To: <20180717201348.GD26218@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 17 Jul 2018 16:13:49 -0400")
Message-ID: <xmqqk1psldkx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> There's nothing for the calling program to act on on the basis of that
>> error.  Use status 0 consistently instead, to indicate that we decided
>> not to run a gc (just like if no housekeeping was required).  This
>> way, repo and similar tools can get the benefit of the same behavior
>> as tools like "git fetch" that ignore the exit status from gc --auto.
>
> I think this is a good change.
>
> In theory it might be useful to propagate the original exit code (_not_
> "did we see a warning or an error", but the true original exit code. But
> as you note, it's not deterministic anyway (we'd miss that exit code on
> the first run, or even any simultaneous runs that exit early due to lock
> contention). So it's clear that callers can't really do anything robust
> based on the exit code of a daemonized "gc --auto".
>
> I still think that "repo" should probably stop respecting the exit code.
> But that's no excuse for Git not to have a sensible exit code in the
> first place.

I am not yet convinced that this last step to exit with 0 is a good
change, even though I can understand that it would be more
convenient, as there currently is no easy way for the calling script
to tell two error cases apart.

I think the "sensible exit code" you mention would be something like
"1 for hard error, 2 for 'I am punting as I see there were previous
errors---you may want to examine your repository'".  

If we did that from day one and documented that behaviour, nobody
would have complained, but adopting that suddenly is of course a
breaking change.

Perhaps we should exit with 2 (not 0) in that "previous error" case
by default, and then have a configuration knob to turn that 2 into 0
for those who cannot easily modify the calling script?  That way, we
by default will *not* break those who have been paying attention to
zero-ness of the exit status, we allow those who want to treat this
"prior error" case as if there were no error with just a knob, and
then those who are willing to update their script can tell two cases
by the exit status and act differently.



