Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4054720A26
	for <e@80x24.org>; Wed, 27 Sep 2017 21:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbdI0VXD (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 17:23:03 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:47729 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbdI0VXC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 17:23:02 -0400
Received: by mail-pg0-f47.google.com with SMTP id d8so8468848pgt.4
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 14:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mlH5hTPbYt9/3HVnkMshKsoGkK9iTP3JTXObTJpH7zA=;
        b=U+G8FDkLaFgVJp/Py7h4gagVbNqWKouLK0wqdA9O3Yl6lRXjgKE1YD3S0AHrgzGIQN
         /dfO3vijhJpEaYxkRQ0mKrajJZwQtmhYL5ojeA4JHo/JtWsEwXCmihLg5F2CKdXkquH4
         eb53gX85diGbeuGEPto5/7lRdFJ+unULpZi3i6byMA74FFcuFfcpcqJo21xfe7E61NAc
         h6ECxv2O0zdzSybi4hLEodvzqyo5IphubT35Lzyq5lGGOAMAajFvPBG758xnmAHggVtE
         aJNxrWLlSMbfRONTe4H2ctbIVGLs7hQovyi1fcVAK2j0DFDv7J078rL4rx0q7BI13ZdW
         j4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mlH5hTPbYt9/3HVnkMshKsoGkK9iTP3JTXObTJpH7zA=;
        b=dtk1t22spGW+2hzLO3bq34QEcLqFCCiOoOuOWPgpgRU5gO7S/OTt8JSfdW1T4XZqij
         h7xrOMn7gqQJJd6PgWrAFPtEv/8wLOa1qWxGKVfeZumRRn/4a+9uBl8fYPvUsRw3XnkV
         Fi/YhyiFHMZDEiUCBqFGFPpeZ3Yu5JUFW+dLsblzij0YG/mHB1ejKsmZ9rfDzUKnce7S
         MiNQMDUzRMzip1sTH7qEY8PSKjQKghRmMlw7+Z7jUbDVxRNsi3LD8iNA+4QlQk0JJCwz
         Ap4oKRhKuQ3baul5hQPijFYi9XtZC3HS8kafmMCkv6CRVq/HjWU0a49Ke1+4cLm2zkwZ
         4G9w==
X-Gm-Message-State: AHPjjUh0fW3dqdTQKERQKU2739sSQG5cTKBbbVbUK+dS/bIyiCr4pXi4
        SYf8nfNVgy/CTfOFiS6BTHBu2w==
X-Google-Smtp-Source: AOwi7QBi4+8FWmsQgLsrqyJx5csrNKfNa0Dztd8UqM8y4rEsXYy7GeaY3KoZ9QIaKMf+lu8B8oBjpQ==
X-Received: by 10.84.196.131 with SMTP id l3mr2181595pld.195.1506547381357;
        Wed, 27 Sep 2017 14:23:01 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:880:967f:fa0a:fc13])
        by smtp.gmail.com with ESMTPSA id w82sm22470764pfa.69.2017.09.27.14.22.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 27 Sep 2017 14:23:00 -0700 (PDT)
Date:   Wed, 27 Sep 2017 14:22:58 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v2 4/9] daemon: recognize hidden request arguments
Message-ID: <20170927212258.GA68699@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
 <20170926235627.79606-1-bmwill@google.com>
 <20170926235627.79606-5-bmwill@google.com>
 <xmqqzi9g67kl.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzi9g67kl.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/27, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > A normal request to git-daemon is structured as
> > "command path/to/repo\0host=..\0" and due to a bug in an old version of
> > git-daemon 73bb33a94 (daemon: Strictly parse the "extra arg" part of the
> > command, 2009-06-04) we aren't able to place any extra args (separated
> > by NULs) besides the host.
> 
> It's a bit unclear if that commit _introduced_ a bug, or just
> noticed an old bug and documented it in its log message.  How does
> that commit impact the versons of Git that the updated code is
> capable of interracting with?

You're right, after reading it again it isn't clear.  I'll change this
to indicate that the commit is a fix to a bug and that the fix doesn't
allow us to place any additional args.

> 
> > +static void parse_extra_args(struct hostinfo *hi, struct argv_array *env,
> > +			     char *extra_args, int buflen)
> > +{
> > +	const char *end = extra_args + buflen;
> > +	struct strbuf git_protocol = STRBUF_INIT;
> > +
> > +	/* First look for the host argument */
> > +	extra_args = parse_host_arg(hi, extra_args, buflen);
> > +
> > +	/* Look for additional arguments places after a second NUL byte */
> > +	for (; extra_args < end; extra_args += strlen(extra_args) + 1) {
> > +		const char *arg = extra_args;
> > +
> > +		/*
> > +		 * Parse the extra arguments, adding most to 'git_protocol'
> > +		 * which will be used to set the 'GIT_PROTOCOL' envvar in the
> > +		 * service that will be run.
> > +		 *
> > +		 * If there ends up being a particular arg in the future that
> > +		 * git-daemon needs to parse specificly (like the 'host' arg)
> > +		 * then it can be parsed here and not added to 'git_protocol'.
> > +		 */
> > +		if (*arg) {
> > +			if (git_protocol.len > 0)
> > +				strbuf_addch(&git_protocol, ':');
> > +			strbuf_addstr(&git_protocol, arg);
> > +		}
> > +	}
> > +
> > +	if (git_protocol.len > 0)
> > +		argv_array_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=%s",
> > +				 git_protocol.buf);
> > +	strbuf_release(&git_protocol);
> >  }

-- 
Brandon Williams
