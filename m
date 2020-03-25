Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A7BC1975A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 06:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFA820719
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 06:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuF3Ev5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgCYGYE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 02:24:04 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45689 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCYGYE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 02:24:04 -0400
Received: by mail-vs1-f67.google.com with SMTP id x82so806205vsc.12
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 23:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QY++2ldG6GRRo9R31rshLAiVR+/FC4gNmXiqRTn3Bsc=;
        b=MuF3Ev5xICAfIzWesThAEa46cjlsK+48Z8nm73y+TAEeuctpeRyPTQog+tMJvJ8zaF
         KGIjhqlm/ubJSbMMqfRDt//QH4sTnJ0Yb4f85kCIi5ern++92HJjCGhqG1WSMqJiJn7i
         I5V1ypg6L1bObzSYpsOuyTsUyvJvas0Bw4rf7olRehXvJ/EPaFcedgNJKqf+QbvBqfgW
         MScjaHVCGUds5bM+A4mRfd0m2bmDn79++Kn7peP8lF8yxQm3jhZzVRXIVCuVoDnSTf1e
         SRk9WVpb3axFwsGKhAGYlRd1t4ZKSgG/xrp0VDuEEY9Akl64bnF8QOC6BA1ptegv9ATa
         0MbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QY++2ldG6GRRo9R31rshLAiVR+/FC4gNmXiqRTn3Bsc=;
        b=Bm0BxxDeWROiG5/D4POjJ1dkT5oY2j7QfOXJt1Hi5R6oNbkFtFHUQsjKzem9/V7/tu
         McfDqhMocoy7C/4qWZMKhSeCwxvVGWa0Hu2NymAmutKwSM8p+iaFib6hrYg6eVjtgX/g
         UJ7ydlG51PA+j54fL0zrI27g8u+5+WA7BTQ5EurXX3uYTLZq+57D15O3pQ0hqhW3xsHC
         nLIgSN1mRabnDt31uAzWK3bg+0HFTZdc5c27HfweVDYjLQ+E/bliZNfm9BWaog9//NSc
         q6/LLi+/NYH+GiJsPp5rRdaJ+42/7c1vGMpuhVb37RC9eOmPseItmdZr59dYYbZ4BazV
         XduQ==
X-Gm-Message-State: ANhLgQ3MUpOVQQzp9DVmWDb2mrfXHhLmfeTeC5vYqkOirYtN69b65klr
        Q9OGpbzGwXkYyVW50mSzP0AxVeXFJDYAxSXzA5ZktbYY
X-Google-Smtp-Source: ADFU+vvq7VUi8jJ7TAMiK/ErpduR1nrI57VvF8hvT0TfXxKL0NdlwJji2s6ts/xslBYUatETOGxSydxK5Vu4PEzNaI0=
X-Received: by 2002:a67:6e41:: with SMTP id j62mr1323984vsc.79.1585117442742;
 Tue, 24 Mar 2020 23:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200325013434.219775-1-sandals@crustytoothpaste.net> <20200325013434.219775-2-sandals@crustytoothpaste.net>
In-Reply-To: <20200325013434.219775-2-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 25 Mar 2020 07:23:49 +0100
Message-ID: <CAN0heSofpxFW81=sB+4ukx9S0JOJo_XuKDTBSkTy_-QK+jDz0Q@mail.gmail.com>
Subject: Re: [PATCH v2] docs: add a FAQ
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 25 Mar 2020 at 02:37, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Note that the long lines for certain questions are required, since
> Asciidoctor does not permit broken lines there.
> ---

Missing sign-off.

[Snipping lots of very well-written Q&As...]

> +You can also just enter your password when prompted, or you can place the
> +password (which must be percent-encoded) in the URL.  The latter option is not
> +particularly secure and can lead to accidental exposure of credentials, so it is
> +not recommended.

So should we even mention it? Or should we use the "it is sometimes
(erroneously) suggested" construct?

> +[[multiple-accounts-ssh]]
> +How do I use multiple accounts with the same hosting provider using SSH?::
> +       With most hosting providers that support SSH, a single key pair uniquely
> +       identifies a user.  Therefore, to use multiple accounts, it's necessary
> +       to create a key pair for each account.  If you're using a reasonably
> +       modern OpenSSH version, you can create a new key pair with something
> +       like `ssh-keygen -t ed25519 -f ~/.ssh/id_committer`.  You can then
> +       register the public key (in this case, `~/.ssh/id_committer.pub`; note
> +       the `.pub`) with the hosting provider.
> ++
> +Most hosting providers use a single SSH account for pushing; that is, all users
> +push to the `git` account (e.g., `git@git.example.org`).  If that's the case for
> +your provider, you can set up multiple aliases in SSH to make it clear which key
> +pair to use.  For example, you could write something like the following,
> +substituting the proper private key file:

Would this be in `~/.ssh/config`?

> ++
> +----
> +# This is the account for author on git.example.org.
> +Host example_author
> +       HostName git.example.org
> +       User git
> +       # This is the key pair registered for author with git.example.org.
> +       IdentityFile ~/.ssh/id_author
> +       IdentitiesOnly yes
> +# This is the committer for author on git.example.org.

Looks like you did s/account/committer/ instead of s/author/committer/?

> +Host example_committer
> +       HostName git.example.org
> +       User git
> +       # This is the key pair registered for committer with git.example.org.
> +       IdentityFile ~/.ssh/id_committer
> +       IdentitiesOnly yes
> +----

> +
> +[[last-commit-amend]]
> +I've made a mistake in the last commit.  How do I change it?::
> +       You can make the appropriate change to your working tree, run `git add
> +       <file>` or `git rm <file>`, as approrpiate, to stage it, and then `git

typoed "appropriate"

> +[[restrict-with-hooks]]
> +How do I prevent users from making certain changes with hooks?::

I read this as:

  How do I prevent users from making "certain changes with hooks"?

As opposed to your intended meaning:

  How do I (with hooks) prevent users from making certain changes?

I'm not suggesting the latter as a "fix" for this "problem" though,
since it's a bit clumsy. How about adding a comma:

  How do I prevent users from making certain changes, with hooks?

Or maybe just dropping those last two words.

Please trust your judgement on whether this is a problem, and if so, how
to go about addressing it -- I know you have lots of such judgement.

> +Cross-Platform Issues
> +~~~~~~~~~~~~~~~~~~~~~

I think you meant to use "--" as everywhere else instead of "~~". This
is not a subsection of "Hooks".

> +To do so, you can specify a linkgit:gitattributes[5] pattern with with the

"with with"

> +`working-tree-encoding` attribute.  For example, the following pattern sets all
> +C files to use UTF-16LE-BOM, which is a common encoding on Windows:

> +[[windows-diff-control-m]]
> +I'm on Windows and git diff shows my files as having a `^M` at the end.::
> +       By default, Git expects files to be stored with Unix line endings.  As
> +       such, the carriage return (`^M`) that is part of a Windows line ending
> +       results is show because it is considered to be trailing whitespace.  Git

"results is show"? "is shown"? Perhaps with a comma after "shown" for
better reading flow (IMVHO).

> +       defaults to showing trailing whitespace only on new lines, not existing
> +       ones.

> +We also recommend setting a link:gitattributes[5] file to explicitly mark which

s/link:/linkgit:/

Thanks a lot. This is really well-written, and I think the selection of
questions makes a lot of sense.

Martin
