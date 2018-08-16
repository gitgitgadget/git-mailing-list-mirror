Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47A081F404
	for <e@80x24.org>; Thu, 16 Aug 2018 02:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387655AbeHPF35 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 01:29:57 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45171 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbeHPF35 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 01:29:57 -0400
Received: by mail-pl0-f67.google.com with SMTP id j8-v6so1307392pll.12
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 19:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zDjd52iTM1Wp1/PuGr67inwdHCJ8QO7Ms0oVIrf+nsc=;
        b=IxvGCqcbRTzU3+icJtdfatGKVhN769niQN1FkQIngUr4XGc/sbLg4HKgCJmAuA4mYC
         ZasCNdna/4fhlvTYmU2GxjBmC8ednrumhXU/A1o3aD2s6gvK57eZwTi3ZEXgL5N1RMTV
         94STnYiDeUK9IV5H+o+0yp6nhn+R9XX1DdBoKYW1G2Jd8heuJvJF5BGuAcaWOm96Z5W/
         M3I9x4fgY6HNoH0M9W64InPEhEeRSdNQgFV88TbGpXEZOUjgfnT6fOuONFkTpoVV2a4U
         fDSJVNSwjcsFpZhCi7YVYk9qaCCkw+IHKnj4bCfdVW+O9bWCOxWWQktqUJqFQIPEO5KR
         6H6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zDjd52iTM1Wp1/PuGr67inwdHCJ8QO7Ms0oVIrf+nsc=;
        b=Mlpnvtrr9lxZLxgnS8ZE8ZopjAb0B7p2JGTYq2j40Mn0uJ5pZJEvjz68zHfWGPSoeH
         1cXfoHvgsbGcKaUuwM85d8nrNANzWnOAh03iOkpMW5HqhraZls33sOouzhtoh+rslVxg
         sb6JqIRkDaSZQ5he23T1T8a+qNfTckDW6lsMfipBRYFyBgwl/Jr9vlzwfHcGK20OsAe0
         lnm5H+VPw3OkWoc+kgrGjko92IbVkpubaI06RI5zQLK7w3lew330n4czucEIkLdGuK/L
         wtyxmfEmpNjw9MGu5LDoIHeKveCOq/zoD2MByW6oTsy5ohKUp5ezNndfPbWJd80oEf6S
         6OYA==
X-Gm-Message-State: AOUpUlFnjcwuYJyhJR0EGloWmD9FrLyeSC1Dq44v9ooh8REor5O6BCNy
        S/cEcU3ItJ3Pi7XiRRbcpEs=
X-Google-Smtp-Source: AA+uWPzJajNFNrAZel1B4uYBJd1Yf44f8rg39bvoWDM/sduY2Xr1+2Ej/6LT23jxjZtFxb3cb9Phdw==
X-Received: by 2002:a17:902:76c5:: with SMTP id j5-v6mr26692533plt.296.1534386888909;
        Wed, 15 Aug 2018 19:34:48 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 84-v6sm46584380pfj.33.2018.08.15.19.34.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 19:34:48 -0700 (PDT)
Date:   Wed, 15 Aug 2018 19:34:46 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>, Jeff King <peff@peff.net>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] submodule: munge paths to submodule git directories
Message-ID: <20180816023446.GA127655@aiede.svl.corp.google.com>
References: <20180807230637.247200-1-bmwill@google.com>
 <20180808223323.79989-1-bmwill@google.com>
 <20180808223323.79989-3-bmwill@google.com>
 <20180809212602.GA11342@sigill.intra.peff.net>
 <20180814180406.GA86804@google.com>
 <20180814185743.GE142615@aiede.svl.corp.google.com>
 <CAGZ79kZUq5jPqyb=B1ppEi1QhNGmhLXeV6vPn8ouR=YGEN32pg@mail.gmail.com>
 <20180814211211.GF142615@aiede.svl.corp.google.com>
 <CAGZ79kYfoK9hfXM2-VMAZLPpqBOFQYKtyYuYJb8twzz6Oz5ymQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kYfoK9hfXM2-VMAZLPpqBOFQYKtyYuYJb8twzz6Oz5ymQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi again,

Stefan Beller wrote:
> On Tue, Aug 14, 2018 at 2:12 PM Jonathan Nieder <jrnieder@gmail.com> wrote:

>> What if we forbid directory separator characters in the gitdirname?
>
> Fine with me, but ideally we'd want to allow sharding the
> submodules. When you have 1000 submodules
> we'd want them not all inside the toplevel "modules/" ?

That's a good reason to permit slashes in the gitdirname.

If I understood the rest of your reply correctly, your worry was about
dangerous gitdirname values in .gitmodules.  I never had any wish to
read them from there anyway, so this worry hopefully goes away.

[...]
>> In this proposal, it would only be read from config, not from
>> .gitmodules.
>
> Ah good point. That makes sense.
>
> Stepping back a bit regarding the config:
[...]
> Now that we have the submodule.active or even
> submodule.<name>.active flags, we do not need (b) any more.
> So the URL turns into a useless piece of cruft that just is unneeded
> and might confuse the user.
>
> So maybe I'd want to propose a patch that removes
> submodule.<name>.url from the config once it is cloned.
> (I just read up on "submodule sync" again, but that might not
> even need special care for this new world)
>
> And with all that said, I think if we can avoid having the submodules
> gitdir in the config, the config would look much cleaner, too.

Yes, I understand and agree with this.

I should further spell out my motivation with this gitdirname
suggestion.  The issue that some people have mentioned in this thread
is that urlencoding might not be perfect --- it's pretty close to
perfect, but it's likely we'll come up with some unanticipated needs
later (like sharding) that it doesn't solve.  Solving those all right
now would not necessarily be wise, since the thing about unanticipated
needs is that you never know in advance what they will be. ;-)

So it would be nice, for future-proofing, if we can change the naming
scheme later.

As a bonus, that would also make interoperability with other
implementations easier.  For example, suppose we mess up in JGit and
urlencode a different set of characters than Git does.  Then a mixed
Git + JGit installation would have this subtle bug of the submodule
.git directory not being reused when I switch to and from and branch
not containing that submodule, in some circumstances.  That sounds
difficult to support.

Whereas if we have a gitdirname configuration variable, then JGit and
libgit2 and go-git do not have to match the naming scheme Git chooses.
They can try, but if one gets it subtly wrong then that is okay
because the submodule's directory name is right there and easy to look
up.

All at the cost of recording a little configuration somewhere.  If we
want to decrease the configuration, we can avoid recording it there in
the easy cases (e.g. when name == gitdirname).  That's "just" an
optimization.

And then we have the ability later to handle all the edge cases we
haven't handled yet today:

- sharding when the number of submodules is too large
- case-insensitive filesystems
- path name length limits
- different sets of filesystem-special characters

Sane?

Thanks,
Jonathan
