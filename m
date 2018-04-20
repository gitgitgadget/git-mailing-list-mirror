Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAFF71F404
	for <e@80x24.org>; Fri, 20 Apr 2018 12:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754705AbeDTMO2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 08:14:28 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:41719 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754591AbeDTMO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 08:14:27 -0400
Received: by mail-wr0-f172.google.com with SMTP id v24-v6so22396651wra.8
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 05:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:user-agent:date:message-id:mime-version;
        bh=6YitmpqkB/QqS+b+/44P/6lF5Gy33w2CBrdELUttLqU=;
        b=nk9N0UX1XSxATnoLPs/GH3w5Jtlikr7yMSBccLCLn7FCSOprlSpkZCGT6mWSbQGgJQ
         VJp7Rt0KYEaS9wEfUdbiBS5ZjNWvdgyT/MyVmr6F/s/c/w+ayMu2iIkcPOL4ft+dIga7
         jUQFaLZtJUAuVjtoNl/6O/9eYVr8eDVZC9R/x4fSRLP3M+AwhmxdA+20kgdjkcoWmvM8
         lecwqECk36zx5xylWqFaLhbZRFJzb/CQxF8UU8YIwijXKL2XCFEpbo81mcng51Nf0khU
         Gyar1KTLsjaa8zFP/7fIE9sWcO8QEwbRuLO7dtwo/ntYIEzMGbU1hMLXIPuNYp9Y6hKs
         5XFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:user-agent:date:message-id
         :mime-version;
        bh=6YitmpqkB/QqS+b+/44P/6lF5Gy33w2CBrdELUttLqU=;
        b=QGMUtKU6hfdxsXKG8sTAefI0O3CB+tL++UyiilMfiWJrdEAVFKx+2Psu2o9j1DdYtg
         uNMQ0Gy94SIOmVT4+8cyt7v5NIgOUap5BeojslPng+2tPHsvbnc+d/KH7GaQZnqE3ouk
         CJ3Ue4svDJuBXK/+DIO6wgd4pNsBTGtAiKSBMdACsCkU5RuZdh91NqSL5DHUoJ/dWouP
         WswCi62ts5whNt00KnFkcv8/AW8lnjnHCEGWh442Lcesyv8O+9nYtMZeiVrx6qHcBZG1
         X88aeceUFsZme4cdPnpksR9USX/lsvQkbNzpgeGxFi+f9zFmAF+SXaAVTuMUeApqJoeH
         2Iqw==
X-Gm-Message-State: ALQs6tDk2CFgtsGxc41CYE1I83quunjFXdtbVHb2bzkYE4SMuQkJahx8
        NwPX0U/Zvb0kpyvrS7ldEg19cIWK
X-Google-Smtp-Source: AIpwx4/nB27Ovorz+RcFxx0ow+KaPmC/cqhNmpKX8vb/D2utRU/P1R8IQ65VBk9SlaPqiBA/RgknJQ==
X-Received: by 10.28.129.133 with SMTP id c127mr1722744wmd.7.1524226466189;
        Fri, 20 Apr 2018 05:14:26 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id n21sm1958736wmi.37.2018.04.20.05.14.24
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Apr 2018 05:14:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: RFC: How should we handle un-deleted remote branches?
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
Date:   Fri, 20 Apr 2018 14:14:24 +0200
Message-ID: <87in8mdqhr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I removed a remote and its refs persisted. At first I thought this was a
bug but looking at add_branch_for_removal()'s "don't delete a branch if
another remote also uses it" logic it's intentional.

This goes very wrong if you do e.g.:

    (
        rm -rf /tmp/git &&
        git clone --bare --mirror git@github.com:git/git.git /tmp/git &&
        cd /tmp/git &&
        git remote add avar  git@github.com:avar/git.git &&
        git fetch avar &&
        git remote remove avar &&
        git for-each-ref|grep -c refs/remotes/avar
    )

At this point you can't prune it since no remote config is left:

    $ git remote prune avar
    fatal: 'avar' does not appear to be a git repository
    fatal: Could not read from remote repository.

But this is a possible work-around:

    git init /tmp/empty.git
    git remote add avar file:///tmp/empty.git
    git remote prune avar
    git remote remove avar

Or use update-ref -d to remove them:

    for rr in $(git for-each-ref --format="%(refname)"|grep ^refs/remotes/avar/)
    do
        git update-ref -d $rr
    done

I started to patch this, but I'm not sure what to do here. we could do
some combination of:

 0. Just document the current behavior and leave it.

 1. Dig further down to see what other remotes reference these refs, and
    just ignore any refspecs that don't explicitly reference
    refs/remotes/<our_deleted_remote>/*.

    I.e. isn't the intention here to preserve a case where you have two
    URLs for the same effective remote, not whene you have something
    like a --mirror refspec? Unfortunately I can't ask the original
    author :(

 2. Warn about each ref we didn't delete, or at least warn saying
    there's undeleted refs under refs/remotes/<name>/*.

 3. Make 'git remote remove --force-deletion <name>' (or whatever the
    flag is called) be a thing. But unless we do the next item this
    won't be useful.

 4. Make 'git remote prune <name>' work in cases where we don't have a
    remote called <name> anymore, just falling back to deleting
    refs/remotes/<name>. In this case 'git remote remove
    --force-deletion <name>' would also do the same thing.

In any case, the current behavior where we just leave this crap behind
without any explanation or an obvious way to delete them (can't use
git-branch -d, need update-ref -d) isn't nice.

I encountered this in the wild because GitLab will add an "upstream" ref
if you clone a repo, but if you stop using the remote to update it in
combination with their "geo" remote (which has --mirror refspecs) it'll
leave behind all these dead refs.
