Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E190520248
	for <e@80x24.org>; Fri, 22 Mar 2019 03:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfCVDen (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 23:34:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37859 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfCVDen (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 23:34:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so766195wrm.4
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 20:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/hVw8/g1nR47okywlIIdmN3ZcdM0yj84qVivCqijtVA=;
        b=F1v/z+IMgWBt5z5E2We61IDOI5bW5Sd9mORXkLQ7vUKn6IGGhFEDmc+braZvfrU0he
         6IV4j+oDynDDxpEv9WAOR2rcyeLez63e+W/ASJf6IzD18m0AHltqFW2PLs+JjaspqF4U
         XD5W6w+k8QYTCKyQYTZgw4Jt+Sc5bVJrpG3MxzPsg5Xg38LCVdldCcFwZ3Wg54RcrXEl
         zIHtKWjW2b66JGe7doKhgSg6VMJRM7KoJDq6mW4CLxAIexLa+MHsePRl+7+UE3YS7HTU
         rCpfq9wL5wu/DMka/V4/IV/B4xuJDUjRk1ROualhfjItr+vqOQV3/E2dER/VB7+CMdld
         9LeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/hVw8/g1nR47okywlIIdmN3ZcdM0yj84qVivCqijtVA=;
        b=gAwRJbL+k3RSO2X75CO9rTlmBygkj7vODOnZYMU9bMMyNjR7tk7VyDZriz3Ajs1Cp+
         35ncDuwLs9eU+fEFbtR7CYP/RJXNLwxQEsGmRXe89SnTGyE+Fc3stBy2osh9yKzGJFoU
         v5FlY8g3rN0o5wgZcDg48H86UPN5WN/qDvKFuTaj5ArWXJ7KZcD2ZgyAt8a7PlP7s8+g
         3m2dan3JUyIw4kC2RcY94WoVHnY2bP254aCNhdb8wfdZne+C2PTi107sbySefDBoQxAR
         m8t3CFcgTUd85gOU7kUjWG0aQNvIQNV+qdgT06G+QB1oMlPAaXSjn8TJmEAkUy+v0gmq
         GO2A==
X-Gm-Message-State: APjAAAUZ9l0Xyz7vy6xoJds3SG970ZjFaPCVh5G1rrbLGrXsn3z6ZtUi
        J2mLzhKz+En8InF06ZIURW4or6rKEzk=
X-Google-Smtp-Source: APXvYqzJzHcIWAgHV/5RwwTxur3LQb1t9WWLozq8DTAGDIsjlujRwEjHAg1VbXnhSPRnB5P6iJTNjA==
X-Received: by 2002:adf:de8d:: with SMTP id w13mr4599765wrl.26.1553225681566;
        Thu, 21 Mar 2019 20:34:41 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id o127sm8513581wmo.20.2019.03.21.20.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 20:34:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH 08/11] rebase -i: use struct rebase_options to parse args
References: <20190319190317.6632-1-phillip.wood123@gmail.com>
        <20190319190317.6632-9-phillip.wood123@gmail.com>
        <xmqqwokssvq6.fsf@gitster-ct.c.googlers.com>
        <94fe6518-ca13-8eb8-d455-e2a6fcaeb1d6@gmail.com>
Date:   Fri, 22 Mar 2019 12:34:40 +0900
In-Reply-To: <94fe6518-ca13-8eb8-d455-e2a6fcaeb1d6@gmail.com> (Phillip Wood's
        message of "Thu, 21 Mar 2019 14:59:49 +0000")
Message-ID: <xmqqlg17r38v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Junio
>
> On 21/03/2019 04:21, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>
>>> +static struct replay_opts get_replay_opts(const struct rebase_options *opts)
>>> +{
>>> +	struct replay_opts replay = REPLAY_OPTS_INIT;
>>> +
>>> +	sequencer_init_config(&replay);
>>> +
>>> +	replay.action = REPLAY_INTERACTIVE_REBASE;
>>> +	replay.signoff = opts->signoff;
>>> +	replay.allow_ff = !(opts->flags & REBASE_FORCE);
>>> +	if (opts->allow_rerere_autoupdate)
>>> +		replay.allow_rerere_auto = opts->allow_rerere_autoupdate;
>>> +	replay.allow_empty = 1;
>>> +	replay.allow_empty_message = opts->allow_empty_message;
>>> +	replay.verbose = opts->flags & REBASE_VERBOSE;
>>> +	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
>>> +	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
>>> +	replay.strategy = opts->strategy;
>>> +
>>> +	return replay;
>>> +}
>>
>> This calls init_config() and then sets .action; does it revert to
>> what dl/merge-cleanup-scissors-fix wants to do, which flipped the
>> order to fix some bug?  It is a bit hard to tell.
>
> dl/merge-cleanup-scissors-fix changes sequencer_init_config() to
> depend on the value of action so action should to be set first. What
> is in pu at the moment in not quite right (though I'm not sure what
> the practical implications are as it looks like the rebase tests are
> passing[1]).
>
> [1] https://travis-ci.org/git/git/jobs/509332448

Yes, it actually is the reason why I left the seemingly-wrong merge
in 'pu' on purpose to see if we have enough test coverage.

> they'd both be in the same file. I think it would only need to share
> the definitions of struct rebase_options, enum rebase_action and the
> declaration of run_rebase_interactive(). Would you be happy with the
> addition of builtin/rebase.h (there don't seem to be another headers
> in that directory). We could leave rebase--interactive.c around until
> rebase--preserve-merges.sh is finally removed.

I think dl/merge-cleanup-scissors-fix is getting solid enough, so a
better alternative may be to base this on top of

	reset e902e9bcae ;# The second batch
	merge ag/sequencer-reduce-rewriting-todo
	merge dl/merge-cleanup-scissors-fix

instead of basing it only on ag/sequencer-reduce-rewriting-todo.

Thanks.
