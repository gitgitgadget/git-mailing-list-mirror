Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56221200B9
	for <e@80x24.org>; Sun,  6 May 2018 18:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbeEFSKx (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 14:10:53 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35175 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbeEFSKw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 14:10:52 -0400
Received: by mail-pf0-f170.google.com with SMTP id x9so1888308pfm.2
        for <git@vger.kernel.org>; Sun, 06 May 2018 11:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=OsqXbFMA/Rawwm6Lzt1jpNpgh58swsZo3ADPzT7YVI0=;
        b=ZkFRpn65flVGsN0uo557PnuYGW2W2jj7lsdsXFznJwOhjddeuOPGhRtRBQi/R9sQxT
         ds8u9ekSR8Iq3s4++uzEoffUB/AhoRW7FAmYGeWwg3Fgpmn+eBTnmA9gxq8LzeIRhd0M
         Nn/iNts5aQ3yC1Vnlwb26aMkhyp86VQbqzjKdKy6vwNLJ4tOOrvlmpMC2wXKs+tDdMkT
         mWsY2PSoAxf8P+VtGN2MLXfvSTBoi2Xeja9tj9XsLMISqCBoUhExhW/FI4oNxmpxkzOc
         94sY/jtpp4rUc7zIr7nd1/c1QWA7CLnIaOqlJxlkvLfYMXCF7Z+zp/1PokmT4Fgvboq9
         DwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=OsqXbFMA/Rawwm6Lzt1jpNpgh58swsZo3ADPzT7YVI0=;
        b=b+QTNdFPBMdlTQe+t5kc+nk6nEmP0GBOW8s66obQ/pkv7TiNlv7KyWPNsktfutYyD+
         7OsAy4KDV1QtRiOhS4rC4nfzfA/zP9pRf5BPY9wdYenPx01qCHbIN89YQPtc0kIhnH0O
         hPfEE1eQj84FbonNkJhs4+pdHSR09aS1rAEy3Hzx0Y8KFfBNbs8FHuOPOTVxxsmls7RO
         zFT/5wDBdqNDAUvf/ZVZHxT4RGL6d3dad1hHWGGak4YpdqrTlC4I1/PFCZF88VxbkMpS
         siP7rU2OGkUxoLuRxjc2PXQRuu02CaRVGBFjXuyFsrCA6mdTbUmLwvB46y1zVTfS2efD
         5EJA==
X-Gm-Message-State: ALQs6tDifLGvIh9t0GFuglxEnTo4b07OytK3GG23EoC81GFrauqdVNVH
        h0HsVf0Qzp6BSWnbLVRRQNMWeweS
X-Google-Smtp-Source: AB8JxZqWA0ez/XxiCW6mlSzvLDelSSClV2dFyO3HqUQQkvEBsOSMAHlPU5dSGJRuWPEF5Z9YwTdU1Q==
X-Received: by 10.98.218.23 with SMTP id c23mr26401948pfh.128.1525630251448;
        Sun, 06 May 2018 11:10:51 -0700 (PDT)
Received: from unique-pc ([117.202.251.178])
        by smtp.gmail.com with ESMTPSA id l12-v6sm3737236pgr.82.2018.05.06.11.10.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 May 2018 11:10:50 -0700 (PDT)
Message-ID: <1525630243.15782.4.camel@gmail.com>
Subject: Weak option parsing in `git submodule`
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git Mailing list <git@vger.kernel.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset="UTF-8"
Date:   Sun, 06 May 2018 23:40:43 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently faced the consequence of the weak option parsing done by in
`git submodule`. Initially tried to add a new submodule using the `git
submodule add` sub-command in the following way,

    $ git submodule add ./foo/bar

This cloned the submodule into a new directory named 'bar' in the
present directory. This was initially confusing as I expected `git
submodule` to use the actual directory itself as it resides inside a
sub-directory the main project and thus avoiding the creation of a new
clone. Then I came to know that `git submodule` wasn't smart enough yet
to identify this, by reading the documentation. Then, after realizing
that I would have to specify the path in the command to avoid the
redundant clone, I corrected the command without consulting the
documentation (thoroughly) to,

    $ git submodule add ./foo/bar --path ./foo/bar

expecting that the path needs to be specified after an argument. This
is what triggered the weird consequence of weak option parsing. The
output I got for the above command was:

    The following path is ignored by one of your .gitignore files:
    --path
    Use -f if you really want to add it.

That really confused me pretty much (being a person who doesn't know
much about how `git submodule` works). Instead of complaining about an
inexistent option '--path', it considers '--path' to be the <path>
argument which seems to be bad. It doesn't even complain about the
extra argument. I also dug to find the reason behind this totally weird
message. It seems to be a consequence of the following lousy check
($sm_path is the normalized <path> argument):

    if test -z "$force" &&
            ! git add --dry-run --ignore-missing --no-warn-embedded-repo "$sm_path" > /dev/null 2>&1
    then
            eval_gettextln "The following path is ignored by one of your .gitignore files:
    \$sm_path
    Use -f if you really want to add it." >&2
            exit 1
    fi

    The lack of checking for the reason behind why `git add` fails seems to
    be the reason behind that weird message.

    Ways to fix this:

    1. Fix this particular issue by adding a '--' after the '--no-warn-
    embedded-repo' option in the above check. But that would also
    require that we allow other parts of the script to accept weird
    paths such as '--path'. Not so useful/helpful.

    2. Check for the actual return value of `git add` in the check and
    act accordingly. Also, check if there are unnecessary arguments for
    `submodule add`.

    3. Tighten option parsing in the `git-submodule` script to ensure
    this doesn't happen in the long term and helps users to get more
    relevant error messages.

    I find 3 to be a long term solution but not sure if it's worth trying
    as there are efforts towards porting `git submodule` to C. So, I guess
    we should at least do 2 as a short-term solution.

    Thoughts??

    -- 
    Sivaraam

    QUOTE:

    “The most valuable person on any team is the person who makes everyone
    else on the team more valuable, not the person who knows the most.”

          - Joel Spolsky


    Sivaraam?

    You possibly might have noticed that my signature recently changed from
    'Kaartic' to 'Sivaraam' both of which are parts of my name. I find the
    new signature to be better for several reasons one of which is that the
    former signature has a lot of ambiguities as it is a common name (NOTE:
    it's not a common spelling, just a common name). So, I switched
    signatures before it's too late.

    That said, I won't mind you calling me 'Kaartic' if you like it [of
    course ;-)]. You can always call me using either of the names.


    KIND NOTE TO THE NATIVE ENGLISH SPEAKER:

    As I'm not a native English speaker myself, there might be mistaeks in
    my usage of English. I apologise for any mistakes that I make.

    It would be "helpful" if you take the time to point out the mistakes.

    It would be "super helpful" if you could provide suggestions about how
    to correct those mistakes.

    Thanks in advance!
