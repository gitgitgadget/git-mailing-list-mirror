Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BA6E1FAFB
	for <e@80x24.org>; Mon,  3 Apr 2017 16:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753573AbdDCQcx (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 12:32:53 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36248 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752556AbdDCQcw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 12:32:52 -0400
Received: by mail-pg0-f41.google.com with SMTP id g2so123848983pge.3
        for <git@vger.kernel.org>; Mon, 03 Apr 2017 09:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QsByGZTboNbcQnwEo0fXQ+tBl9PerG+18AkRHXMI8Ps=;
        b=k0PpBaAkFGI8Y7ruFXdGfSPFG6xrBwtX6uZT6aU7Zxp/xE8LnWmJtYcWObBbwcy4aT
         IsfDRkUSXi/r/bD4hgYePxNRGEFIgI9CC8B5rzZR4hxurhFAl2vSEKIx0JD2FL0wGRp2
         y/stbfnAp6OtXvkAhnbNHAsRvWfbzGI/L3S5IhihXxqd8R9eE/jw4SEAQ0HiX70Et1g/
         WrDWogDiRs6oxH3OEstBK5X+uRtGpqqlMsjwwP1fyzqPz8aqEW3jG3PwV91v9F67WFVR
         A0nhhU2fVHabUpha7gHY7V7B8yIQ4JBQeCmnFxpTESzmKD70CfrKSf+lnzrmSWMFhIS1
         5teQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QsByGZTboNbcQnwEo0fXQ+tBl9PerG+18AkRHXMI8Ps=;
        b=H5OMiEM0/N6ATYJfaWMCwp5K++2R/mWYrePOEzpQlsnk5T5SHPc4Qua4c7/C7h1EaX
         HspuQmGHZQzb3CIU0ZL+qIug39MrYvvXuDLeMIjByKncgLW8fEIJAuOgRAxSXFeXdB6D
         Y3HUBLdHfjQNFWxiRa9yB6huxd/Pb90u+FevGaL/w861jIEg4ZJ1cNoL2j4y39sEm0EH
         wlkXQJXYtIHs3MFlQpoabdsuWCZy5U4BDWbTx8AESTWn/r74UF8T0k+MXt8RlLvqnhST
         htvWd4AdH807GSik6wN6yceO+RDGanwLkrfX8HrDCJws6+0eY2ckXDRfJ7OcsGpEDbUQ
         t6yQ==
X-Gm-Message-State: AFeK/H3rbWecggIfII+s8wg5Jphfu4EjhRPzRdEXSaTw4TfOzF2K/tUahubZHTSkejUYQUQTkRkfYyCW5uHpExOk
X-Received: by 10.99.137.66 with SMTP id v63mr19066280pgd.183.1491237171349;
 Mon, 03 Apr 2017 09:32:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.186.196 with HTTP; Mon, 3 Apr 2017 09:32:50 -0700 (PDT)
In-Reply-To: <35343b75-0aa7-3477-888b-3af5024ae7dd@serato.com>
References: <35343b75-0aa7-3477-888b-3af5024ae7dd@serato.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 3 Apr 2017 09:32:50 -0700
Message-ID: <CAGZ79kYKfKcVcV9ddRHNc-aQ7RpN4ToDs9i=voqXcKTm79j3KA@mail.gmail.com>
Subject: Re: Bug? git submodule update --reference doesn't use the referenced repository
To:     Maxime Viargues <maxime.viargues@serato.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 2, 2017 at 8:13 PM, Maxime Viargues
<maxime.viargues@serato.com> wrote:
> Hi there,
>
> I have been trying to use the --reference option to clone a big repository
> using a local copy, but I can't manage to make it work using sub-module
> update. I believe this is a bug, unless I missed something.
> I am on Windows, Git 2.12.0

which is new enough, that the new --reference code is in. :)

>
> So the problem is as follow:
> - I have got a repository with multiple sub-modules, say
>     main
>         lib1
>             sub-module1.git
>         lib2
>             sub-module2.git
> - The original repositories are in GitHub, which makes it slow
> - I have done a normal git clone of the entire repository (not bare) and put
> it on a file server, say \\fileserver\ref_repo\
> (Note that the problem also happens with local copy)
>
> So if I do a clone to get the repo and all the submodules with...
> git clone --reference-if-able \\fileserver\ref-repo --recursive
> git@github.com:company/main
> ...then it all works, all the sub-modules get cloned and the it's fast.

great. :)

> Now in my case I am working with Jenkins jobs and I need to first do a
> clone, and then get the sub-modules, but if I do...
> git clone --reference-if-able \\fileserver\ref-repo
> git@github.com:company/main (so non-recursive)
> cd main
> git submodule update --init --reference \\fileserver\ref-repo
> ... then this takes ages, as it would normally do without the use of
> --reference. I suspect it's not actually using it.

So to confirm your suspicion, can you run

  GIT_TRACE=1 git clone ...
  cd main && GIT_TRACE=1 git submodule update ...

to see which child processes are spawned to deal with the submodules?
Also to confirm, it is the "submodule update" that is taking so long for you?

> The git clone documentation mentions that the reference is then passed to
> the sub-module clone commands, so I would expect "git clone --recursive" to
> work the same as "git submodule update", as far as --reference is concerned.

Oh, there we have an opportunity to improve the man page (or the code).

    git clone --reference --recursive ...

will set the config variables

    git config submodule.alternateLocation superproject
    git config submodule.alternateErrorStrategy die (or "info" for
--reference-if-able)

and the clone for the submodules (that are an independent process, just
run after the clone of the superproject is done) will pickup these
config variables
and act accordingly.

If you only run

    git clone --reference ...

then these variables are not set. Probably they should be set such
that the later
invocation of "git submodule update --int" will behave the same as the git-clone
of the superproject did.

So as a workaround for you to get up to speed again, you can just set
these config
variables yourself before running the "submodule update --init" and it
should work.

>
> I noticed for a single module, doing a...
> git submodule update --init --reference
> \\fileserver\ref-repo\lib1\sub-module1 -- lib1/sub-module1
> ...i.e. adding the sub-module path to the reference path, works. Which kind
> of make sense but then how do you do to apply it to all the sub-modules?
> (without writing a script to do that)

I think that functionality is broken as it takes the same reference
for all submodules,
such that you need to go through the submodules one by one and give the
submodule specific reference location.

>
> If someone can confirm the problem or explain me what I am dong wrong that
> would be great.
>
> Maxime

Stefan
