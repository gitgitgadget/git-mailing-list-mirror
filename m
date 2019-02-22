Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43FCE20248
	for <e@80x24.org>; Fri, 22 Feb 2019 18:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfBVSqS (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 13:46:18 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38418 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfBVSqR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 13:46:17 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so3467914wrw.5
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 10:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dnoghy0f/hlA5rEEANl2s0bsTTRFgKArSAeiGf3bTEs=;
        b=PMHtn3eqRwOR5S/v0mJscbsR+2zD5+MWuLkCB3MCDdEF8CKMW6XBIXGI7tZI0qcT11
         PpSt55SjLjRli1N3KXqGYmYhZSNUhpoeadLnlcRmdRqUeOSaeSUZSEvgt/w+CA6fRDo+
         DyjvPQYENL3C35UzvQS6fpeYV8d++E+it/rurr7aoHLLjALN8pNECLwPbiEicRixFxUP
         yayPvLi3bKhk4o2MRUNkou68AVLQsDvppABMII3ASbZ/aQZgPd3gOjbyiuvi1DhqV8OX
         zTuQWFXDZM9hwqb8zb5TO7Ev0akLf6eAkeGzNBPtSdZf8sJ/qjBjorDacLVrgnFRRzZe
         /1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dnoghy0f/hlA5rEEANl2s0bsTTRFgKArSAeiGf3bTEs=;
        b=oyhGTpzESQa0/l7KB9PAgF9FZppaNjP30D4dadG8AOFuWcQ0Nafd2skW+pBDOHZpnA
         9VvLkJXv1B0devFThuuz9mkCZWuO53zJrwDHa21ieQPthnluMPP2iJaH8jL/EYN8Ftjt
         NgR1A4lIKz/XwCvJmledKlF7VEabLW1WuZIJAPJBejtJKL/OkZ4oEyZqQ5HOTgtsDo8E
         RHSmrdI2rSFL/7TGzbtxqPMSx11gwlDhqyZA7ZyFzJ/7cRW0Dm16F8YO2YX95LPAhRKW
         UIXx0F0zAlJxtNvON7izDvSrFpRmYxYsOcjIiw/Aty2RWWYHWg1DnNuZijiqi8UNxgax
         m7TQ==
X-Gm-Message-State: AHQUAubd/5gGYvG4wYYyQNmXJL+tJa5BaQ+69Q1+f69cgjrSJri/PIo1
        3isG/Lr91k9GPiz/Worh/noBZ9GH
X-Google-Smtp-Source: AHgI3Ibkp5B0Ec6z2Pik+ZaeXsXutgmet1hzJY15cuY76ws3/QJ1YXUYGzHrR4VSrBF7L93vfDZFJw==
X-Received: by 2002:adf:e5c5:: with SMTP id a5mr3958841wrn.13.1550861175025;
        Fri, 22 Feb 2019 10:46:15 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w10sm2472370wru.5.2019.02.22.10.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 10:46:14 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        John Keeping <john@keeping.me.uk>,
        Pratik Karki <predatoramigo@gmail.com>
Subject: Re: [PATCH 1/2] rebase tests: test linear branch topology
References: <20190221151009.GA24309@sigill.intra.peff.net>
        <20190221214059.9195-2-avarab@gmail.com>
        <20190222145344.GA5090@sigill.intra.peff.net>
Date:   Fri, 22 Feb 2019 10:46:13 -0800
In-Reply-To: <20190222145344.GA5090@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 22 Feb 2019 09:53:44 -0500")
Message-ID: <xmqq7edrr79m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> While I'm at it add a --fork-point test, strictly speaking this is
>> redundant to the existing '' test, as no argument to rebase implies
>> --fork-point. But now it's easier to grep for tests that explicitly
>> stress --fork-point.
>
> That makes sense.
>
>> +test_expect_success 'setup branches and remote tracking' '
>> +	git tag -l >tags &&
>> +	for tag in $(cat tags)
>> +	do
>> +		git branch branch-$tag $tag || return 1
>> +	done &&
>
> I don't think we need this extra tmpfile and cat, do we? I.e.,
>
>   for tag in $(git tag -l)
>
> would work.

I think it is being (overly) defensive not to lose the exit status
of "git tag".

> We should probably avoid depending on the exact output of
> the porcelain "tag", though. Maybe:
>
>   git for-each-ref \
>     --format='create refs/heads/branch-%(refname:strip=2) %(objectname)' \
>     refs/tags |
>   git update-ref --stdin
>
> which has the added bonus of using a constant number of processes.

Much better ;-)
