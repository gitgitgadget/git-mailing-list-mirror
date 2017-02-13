Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDD771FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 20:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752552AbdBMUfy (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 15:35:54 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34240 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751578AbdBMUfx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 15:35:53 -0500
Received: by mail-oi0-f65.google.com with SMTP id w144so637409oiw.1
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 12:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=l6KkLScqu6iJ/SHg1QshqFRllF5oXsartuZY3P86Bv4=;
        b=C089lKf40YX7+R1iyUFGZytOenGu+VmL1jCTdjzl2r7VhoqvxaN3h0ww9ZcK9+2lTn
         3VDIWQgzHbffF1XuF0hQZKpfewu+n6wKEICZtrKbk2LZA1vbrTr4o5ohYs74sLiF1DKF
         owdui1m2S8YuJhBJCcLUOh3VxHxF10aujVL+d4psqL9LmPwXP7AICm8iBSt07hvB6xu3
         d4pjXCGu2jH/YbW5TcfSLT8rE2EothkwtaeqXOvYSZAxSBDcwj36p3LMZH0t+FOLttPe
         t5KQ1SFE3LA9jSksH6n24mdXcslNYe060VnuexRBmg4cwySIVdN/QhVf1hSU6sQUYUS2
         BbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=l6KkLScqu6iJ/SHg1QshqFRllF5oXsartuZY3P86Bv4=;
        b=t/twsvSLuyMPWSeCF/yaZOexTx2ZIImDsYWE79k7bjz1OTlbde/KuUBn0qdDrqtm9B
         II+tFr57nXNOmi4zlQehyh8nkUv2G1b9V6y0ciTwFh7DuUw52trYtBc8XEKQgLtRj7tz
         +G7/cSuY53zKCSBLaV88OUywYhE4SNRRLemcd7uByv+A2GHvtxKEpp0Pm1HIpHbNt+JG
         oUtqZ2ckwffNIfu01tEWUsCFpFuDYAR92PnmJm4bM98n6M5xyd2WnfFS4Nfcdm3XHXQK
         3ViabLFelz5k4C3Fdl9SFTJ3fobDOV3aE5Ok3S3/MQyIrdD7Sb87UZFnwztxw4dQM0LE
         aZUg==
X-Gm-Message-State: AMke39lFU4EVrP8mY/DlKsKaZzz0InFkm1jA9t3hNyGigSyX7BsLjNQlKcZqV4gBTMjtHg==
X-Received: by 10.84.233.136 with SMTP id l8mr32264499plk.169.1487018153016;
        Mon, 13 Feb 2017 12:35:53 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d0e0:42a7:601f:5154])
        by smtp.gmail.com with ESMTPSA id b75sm22529444pfb.90.2017.02.13.12.35.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Feb 2017 12:35:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     Istvan Pato <istvan.pato@gmail.com>, git@vger.kernel.org
Subject: Re: Bug in 'git describe' if I have two tags on the same commit.
References: <CAOcUJQwnCJOhUUU2RqJP2H5YxUr4qCEpyDj_XiiQSe4V6rcBmg@mail.gmail.com>
        <20170213154407.GA31568@alpha.ikke.info>
Date:   Mon, 13 Feb 2017 12:35:51 -0800
In-Reply-To: <20170213154407.GA31568@alpha.ikke.info> (Kevin Daudt's message
        of "Mon, 13 Feb 2017 16:44:07 +0100")
Message-ID: <xmqqo9y5de1k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <me@ikke.info> writes:

> On Sun, Feb 12, 2017 at 01:15:22PM +0100, Istvan Pato wrote:
>
>> (master) [1] % git show-ref --tag
>> 76c634390... refs/tags/1.0.0
>> b77c7cd17... refs/tags/1.1.0
>> b77c7cd17... refs/tags/1.2.0
>> 
>> (master) % git describe --tags --always
>> 1.1.0-1-ge9e9ced
>> 
>> ### Expected: 1.2.0
>> ...
>
> Are these lightweight tags? Only annotated tags have a date associated
> to them, which is where the rel-notes refers to. 

Good eyes.  The fact that the two points at the same object means
that even if they were both annotated tags, they have the same
tagger dates.

If the code that compares the candidates and picks better tag to
describe the object with knows the refnames of these "tags", I'd
imagine that we could use the versioncmp() logic as the final tie
breaker, but I do not offhand remember if the original refname we
took the tag (or commit) from is propagated that deep down the
callchain.  It probably does not, so some code refactoring may be
needed if somebody wants to go in that direction.





