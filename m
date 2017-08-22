Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E35C31F667
	for <e@80x24.org>; Tue, 22 Aug 2017 18:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752549AbdHVSzr (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 14:55:47 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33556 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752517AbdHVSzq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 14:55:46 -0400
Received: by mail-pg0-f41.google.com with SMTP id t3so90284805pgt.0
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 11:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2MUPlC01gBJp3xy+hTYiEo0HIM598kyPMllrJm+10U0=;
        b=lUstYGmEWJKqZ49vt6cB1zuZuPLoxS839tVu8CG45J5Uh+4tuY+uyhDXVh0aPDp/pC
         TedwTIwfFMH9GY+zi7nW77Q+RQLSdijHBAM1nIkscIbgpD8NIeNtlZR+WAONc+P917xn
         v0kUgBBO+tPf+yzkOsT3DGnnaO+DAc9UES0JOa4rwu8vzFvGv8J5UfgM/NkxgBuK6qUb
         3k2I+iXSnFatH64N+1gyTIb7MdyI5RpEt5BG2/itYflcoynWIuihmWng8N3jWDsdLfng
         hdzRbh+EScaqNlFyM9pUJLoM0Wf8G1KyyNyZ9PppS4O9RjKrejgTi7tinet0DGpk5496
         QgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2MUPlC01gBJp3xy+hTYiEo0HIM598kyPMllrJm+10U0=;
        b=H1vRFZL3l18FgK6fYJ/5rCzz/qzq9u6pxbpmK3AkGp3M4sVPLhcftrM8QalP/hirq+
         3AaTJH8Qwr69sMUyaqnV2n7Z9B2RNEMDKKQaLPsepkVakeMNTISP19EGI61LlWI2sokN
         OZrzVqUntfWdhWxVOPyF6XsEIxPlEaCTbHrCdGAmqo3j1+8TYOAlv1wG2/oBYSIkzUOY
         2H7qYy+u8FEIibFVMJzd/bJTH1s9wwOYI0COpXMf2/NYsKr086LrZhwUxJ8pIGvzBcWp
         RrFVG/y4Jvuqjb2Ahgska4vFlyyf9t/rD0sfjkSVy6XI3om+8w82BYNw3EMaklEC7yX2
         N93A==
X-Gm-Message-State: AHYfb5hrZWP8JUl0/HimUOVXqdgJ8zKHwnmXPU/Xug8N5jgZJnsKoEPM
        +qM7qrwzgZ04QDW7
X-Received: by 10.84.140.3 with SMTP id 3mr155324pls.374.1503428145432;
        Tue, 22 Aug 2017 11:55:45 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6828:9c55:c66a:8e44])
        by smtp.gmail.com with ESMTPSA id a86sm31184468pfe.181.2017.08.22.11.55.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Aug 2017 11:55:44 -0700 (PDT)
Date:   Tue, 22 Aug 2017 11:55:43 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] pull: respect submodule update configuration
Message-ID: <20170822185543.GA114773@google.com>
References: <xmqqpobsbsk1.fsf@gitster.mtv.corp.google.com>
 <20170818220431.22157-1-sbeller@google.com>
 <xmqqvalk9is0.fsf@gitster.mtv.corp.google.com>
 <20170821162056.GB1618@book.hvoigt.net>
 <CAGZ79ka1jyxmATQbrjPHAv3227UJNcN0nw9AY-RZXnNahepoGQ@mail.gmail.com>
 <85ED93BC-1E27-4B8D-856D-090C6860BAB0@gmail.com>
 <CAGZ79kZMjGNOn0FnJGtO5gRY3rF0Eiow8n0uppTZsCUAHY+m3A@mail.gmail.com>
 <20170821182110.GA156514@google.com>
 <D44F6340-9011-4D41-B103-4A61E7248806@gmail.com>
 <CAGZ79kbpf-a_ZinPLuPh2Vq629=cQknuLVF-QVwOeae1ZGS2Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbpf-a_ZinPLuPh2Vq629=cQknuLVF-QVwOeae1ZGS2Cw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/22, Stefan Beller wrote:
> On Tue, Aug 22, 2017 at 7:50 AM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
> >
> > OK. I change my scripts to use ".active" and it seems to work nicely.
> >
> > I noticed one oddity, though:
> >
> > If I clone a repo using `git clone --recursive <url>` then the local
> > Git config of the repo gets the following entry:
> >
> > [submodule]
> >         active = .
> 
> bb62e0a99f (clone: teach --recurse-submodules to optionally take a
> pathspec, 2017-03-17) makes it clear that this is intentional for
> --recurse-submodules, but doesn't exactly state that --recurse will
> behave the same. The idea here is that at clone time you can already
> give
> 
>     git clone --recurse=:(exclude)sub0 <url> <path>
> 
> and have your desired set of submodules there.
> Combined with the changes in the attr system, b0db704652
> (pathspec: allow querying for attributes, 2017-03-13)
> you could make up things like this:
> 
>   $ cat .gitattributes
>   /sub0 label0
>   /sub1
>   /sub2 label1 label2
>   /sub3 label1
>   /platform-specifc-subs/* label1 label2
> 
> and then get a clone via
> 
>     git clone --recurse=:(attr:label2). <url> <path>
> 
> for example. The labeling via the attributes allows for
> complex patterns, but a relatively easy command line, that you
> can share with coworkers.
> 
> > Is this intentional? Something in the git/git test harness seems to prevent
> > that. I was not able to write a test to replicate the issue.
> >
> > Any idea?
> 
> I do not seem to understand the perceived bug?
> The setting of submodule.active=<pathspec> seems intentional to me,
> but how would you not reproduce it? Maybe Brandon has an idea.
> 

When adding '.active' we wanted it to be as flexible as possible.  So
you can either use a pathspec with 'submodule.active' to catch multiple
submodules as being active or you can turn on/off individual submodules
with 'submodule.<name>.active' (this has precedent over the more general
'submodule.active' config).

The intent was if a user supplies --recurse-submodules (I believe i
removed the docs for --recursive in order to make the CLI more consistent
with other commands, so --recursive is just a synonym for
--recurse-submodules) then they clearly wanted all the submodules cloned
and checked out.  With the '.active' config the way to specify this
is to make 'submodule.active = .'.  In the old world every submodule
would need to have its URL copied into the config.  This way the config
is kept cleaner as it only has a single entry added.

As stefan mentioned you can specify a value for 'submodule.active' to
take as an arg to --recurse-submodules (the default being '.' or all
submodules) so you can do clever things like group submodules using
attributes, you can even repeat the flag to provided a more complex
pathspec.

Hopefully that answers your question :D

-- 
Brandon Williams
