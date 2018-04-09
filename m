Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 861701F404
	for <e@80x24.org>; Mon,  9 Apr 2018 21:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752781AbeDIVBa (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 17:01:30 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:44586 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751988AbeDIVB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 17:01:29 -0400
Received: by mail-yw0-f193.google.com with SMTP id z21so3292407ywg.11
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 14:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=elwDrHEMD5jLR2GyH+w4H1+vocssU4Z4jYnhzfNrNLA=;
        b=UgCOsG1aOPq6wHgxoAR9ozi00am1G4w/eMXwA4hSexyNgcgixQ4qyOEZDSoQEFHFOa
         ja27aJEFKMbHBHga+9gqM4s9X1dqSE9fJZkDM3/GU8KpeHgiTj3Nklf3tZYB1o+K6eYp
         8t5kaccUQKugQcJh5+R/xlo5EBiJy5UApleoBX5wjCgvIfnw8ay9qQDdkWQFvgC4kzMp
         0ShxcDcuwBz0YvWFz9adFvrUyedJwVONJbArzm3YuTsNPrZn5a+SosUlJgXvArgda/oL
         kWBEKFw5RLCno0EOkHftioTKqW+6bX8DBozarH4M7/rgmttJl5GaNhT7OO5bsRcfdfWg
         i4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=elwDrHEMD5jLR2GyH+w4H1+vocssU4Z4jYnhzfNrNLA=;
        b=Mdd4ow9EM71yQUYN2CieCc1e+GWSE2zD86vpNDKJsxnUrNxF3VyMJePhcVNXlFWNEv
         jNCxUGDVVL+BLJX7uI1XW7b7o2NCh4bldiR3OcUEZUXRfLHli+C6w709hESMS+kQKnEX
         d+htx7sXVtdi/cEW7k0AAvM88V/5Io/hfHSx6cczp8yU1YBRZTS62+Av+AvnyY/EGz92
         7lk940Q/Cx1rcDEsIyo/HvAtz/taC8w+AHJCazXy7CogYfhxHSUBUbWTJHX0uwlNaMx+
         iJcHCEYmz5mJfDP8UjbPo0Zi2/8v1i8kLw35r5JTf/5KuuUf7pBsAG4/GHHK5k992bFJ
         KZcQ==
X-Gm-Message-State: ALQs6tD8OmxHZTCD0Ch9HF6URGZ0rhQasH4DL8N8eXlAfbZD7els2lsf
        z0yZJzZX0sZa2jEpqXpddkDrLLTfVy8eyHWSM5FyDg==
X-Google-Smtp-Source: AIpwx49zuiSiRqG3eCSoZDm2tx9gr5KOnPBOEyIoSjMnzIjDvXFP/gVBl1PFYsESJyyckE33qqbcJJy0BUc/Uw/iFWg=
X-Received: by 10.129.86.5 with SMTP id k5mr12143014ywb.345.1523307688396;
 Mon, 09 Apr 2018 14:01:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Mon, 9 Apr 2018 14:01:27 -0700 (PDT)
In-Reply-To: <20180409204129.43537-9-mastahyeti@gmail.com>
References: <20180409204129.43537-1-mastahyeti@gmail.com> <20180409204129.43537-9-mastahyeti@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 9 Apr 2018 14:01:27 -0700
Message-ID: <CAGZ79kYQ0AO=Lp6hpsMfQK0PFt7veEwc+uK-0+JLrudAQ1iAXw@mail.gmail.com>
Subject: Re: [PATCH 8/8] gpg-interface: handle alternative signature types
To:     Ben Toews <mastahyeti@gmail.com>
Cc:     git <git@vger.kernel.org>, me@ttaylorr.com,
        Jeff King <peff@peff.net>, Ben Toews <btoews@github.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

On Mon, Apr 9, 2018 at 1:41 PM, Ben Toews <mastahyeti@gmail.com> wrote:
> From: Ben Toews <btoews@github.com>
>
> Currently you can only sign commits and tags using "gpg".
> You can _almost_ plug in a related tool like "gpgsm" (which
> uses S/MIME-style signatures instead of PGP) using
> gpg.program, as it has command-line compatibility. But there
> are a few rough edges:
>
>   1. gpgsm generates a slightly different PEM format than
>      gpg. It says:
>
>        -----BEGIN SIGNED MESSAGE-----
>
>      instead of:
>
>        -----BEGIN PGP SIGNATURE-----
>
>      This actually works OK for signed commits, where we
>      just dump the gpgsig header to gpg.program regardless.
>
>      But for tags, we actually have to parse out the
>      detached signature, and we fail to recognize the gpgsm
>      version.
>
>   2. You can't mix the two types of signatures easily, as
>      we'd send the output to whatever tool you've
>      configured. For verification, we'd ideally dispatch gpg
>      signatures to gpg, gpgsm ones to gpgsm, and so on. For
>      signing, you'd obviously have to pick a tool to use.
>
> This patch introduces a set of configuration options for
> defining a "signing tool", of which gpg may be just one.
> With this patch you can:
>
>   - define a new tool "foo" with signingtool.foo.program
>
>   - map PEM strings to it for verification using
>     signingtool.foo.pemtype
>
>   - set it as your default tool for creating signatures
>     using using signingtool.default
>
> This subsumes the existing gpg config, as we have baked-in
> config for signingtool.gpg that works just like the current
> hard-coded behavior. And setting gpg.program becomes an
> alias for signingtool.gpg.program.
>
> This is enough to plug in gpgsm like:
>
>   [signingtool "gpgsm"]
>   program = gpgsm
>   pemtype = "SIGNED MESSAGE"
>
> In the future, this config scheme gives us options for
> extending to other tools:
>
>   - the tools all have to accept gpg-like options for now,
>     but we could add signingtool.interface to meet other
>     standards
>
>   - we only match PEM headers now, but we could add other
>     config for matching non-PEM types
>
> The implementation is still in gpg-interface.c, and most of
> the code internally refers to this as "gpg". I've left it
> this way to keep the diff sane, and to make it clear that
> we're not breaking anything gpg-related. This is probably OK
> for now, as our tools must be gpg-like anyway. But renaming
> everything would be an obvious next-step refactoring if we
> want to offer support for more exotic tools (e.g., people
> have asked before on the list about using OpenBSD signify).

Please sign off your patch, see Documentation/SubmittingPatches

> ---
>  Documentation/config.txt |  40 +++++++++---
>  builtin/fmt-merge-msg.c  |   6 +-
>  builtin/receive-pack.c   |   7 +-
>  builtin/tag.c            |   2 +-
>  commit.c                 |   2 +-
>  gpg-interface.c          | 165 ++++++++++++++++++++++++++++++++++++++++++-----
>  gpg-interface.h          |  24 ++++++-
>  log-tree.c               |   7 +-
>  ref-filter.c             |   2 +-
>  t/lib-gpg.sh             |  26 ++++++++
>  t/t7510-signed-commit.sh |  32 ++++++++-
>  tag.c                    |   2 +-
>  12 files changed, 272 insertions(+), 43 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 4e0cff87f6..7906123a59 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1727,16 +1727,38 @@ grep.fallbackToNoIndex::
>         If set to true, fall back to git grep --no-index if git grep
>         is executed outside of a git repository.  Defaults to false.
>
> -gpg.program::
> -       Use this custom program instead of "`gpg`" found on `$PATH` when
> -       making or verifying a PGP signature. The program must support the
> -       same command-line interface as GPG, namely, to verify a detached
> -       signature, "`gpg --verify $file - <$signature`" is run, and the
> -       program is expected to signal a good signature by exiting with
> -       code 0, and to generate an ASCII-armored detached signature, the
> -       standard input of "`gpg -bsau $key`" is fed with the contents to be
> +signingtool.<name>.program::
> +       The name of the program on `$PATH` to execute when making or
> +       verifying a signature. This program will be used for making
> +       signatures if `<name>` is configured as `signingtool.default`.
> +       This program will be used for verifying signatures whose PEM
> +       block type matches `signingtool.<name>.pemtype` (see below). The
> +       program must support the same command-line interface as GPG.
> +       To verify a detached signature,
> +       "`gpg --verify $file - <$signature`" is run, and the program is
> +       expected to signal a good signature by exiting with code 0.
> +       To generate an ASCII-armored detached signature, the standard
> +       input of "`gpg -bsau $key`" is fed with the contents to be
>         signed, and the program is expected to send the result to its
> -       standard output.
> +       standard output. By default, `signingtool.gpg.program` is set to
> +       `gpg`.

I wonder if the mention of the default is best put at the pgp.program
instead of here, although the mention of it being an alias strongly suggest
we'd want to deprecate it eventually.

> +
> +signingtool.<name>.pemtype::
> +       The PEM block type associated with the signing tool named
> +       `<name>`. For example, the block type of a GPG signature
> +       starting with `-----BEGIN PGP SIGNATURE-----` is `PGP
> +       SIGNATURE`. When verifying a signature with this PEM block type
> +       the program specified in `signingtool.<name>.program` will be
> +       used. By default `signingtool.gpg.pemtype` contains `PGP
> +       SIGNATURE` and `PGP MESSAGE`.
> +
> +signingtool.default::
> +       The `<name>` of the signing tool to use when creating
> +       signatures (e.g., setting it to "foo" will use use the program
> +       specified by `signingtool.foo.program`). Defaults to `gpg`.
> +
> +gpg.program::
> +       Historical alias for `signingtool.gpg.program`.
>
>  gui.commitMsgWidth::
>         Defines how wide the commit message window is in the


> +/*
> + * Our default tool config is too complicated to specify as a constant
> + * initializer, so we lazily create it as needed.
> + */
> +static void init_signing_tool_defaults(void) {

Coding Style: please put the opening brace in a new
line when staring a function (but not for statements).
