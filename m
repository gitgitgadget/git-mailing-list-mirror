Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A65E81F453
	for <e@80x24.org>; Fri,  5 Oct 2018 08:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbeJEPNP (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 11:13:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42391 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbeJEPNO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 11:13:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id g15-v6so9956526wru.9
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 01:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=5rXNhZvDjWCPsaADNQLqAixb6Kz7hBi9+9BtWCnn9lg=;
        b=U2uLQ8vRZE7vnvZfpiYJx/tz/jdNC2JH2Qav3hehWpwb/H/ms5tj1ToTJwy3ZG1kXq
         /bZHbytjMSW1kSEUL7WlqgsV9zxjNYxJs3VvMHhv2cykEf+K07/Knvvk3ZtoDZGhnat4
         F/PG1lPynyOt3+kFWLAwn3RgmGObluF3iA9guxkDv+LCET/mBOEdp9/z+1CXEFT+FhaI
         wn7sMpShzxSqXf3J0pQtB4cJaINMlsuW4tKYQ1WtsyjFgLxgvGKnrKFHUsXdVuF747B+
         qQeeNxnnf2uHMPB4EXboYE4J6ilN+MPfF9oh5z2sRcCqhWCtTvDaCEDflu0Wbwhu1oQo
         gP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=5rXNhZvDjWCPsaADNQLqAixb6Kz7hBi9+9BtWCnn9lg=;
        b=PXijK4i5a9u8m6Sybo+ZxaiE4PV8y8bBzJCbMe+m69Vc6claOQFfGopomQ7jz+JnOf
         OWSeEl7Mv7Jdr5u8VqVpyxH1ZLqhwmeHUbddcWtkcllYYL0IhyZBEwj88nNdJ7co+dY7
         BKh0sf1c2nsiC8LBty5cMYuYeeCI+UzleVirbLhZR43KWaKy+co3bUncL1aeUBv9o6tZ
         l9RTCNdiVOr9V2FJ/Fn5wz+FE0IbPpSAZfpwbmxJ5s3m9jjCml+e3uvIdhLvkES93d60
         VvWNY7ABzGnQtioxxO41V9VWuDGrfaCXOhX0PdZyW83YQV4YEW65rtR0+A6SOfJbZ/Kx
         UsaQ==
X-Gm-Message-State: ABuFfojPoDMelHEw99yJejoPn6i7O9p6TIpgjDwTsETvgmojeAI7PV7H
        Ci1ZCzFRQbFd5m6vvTBdui8PmZpQPsI=
X-Google-Smtp-Source: ACcGV62dOdfUHc7SgZ8nXf9TsUYCuWREqnsA2iRgnznBLsiD8AXhvEy/JH9Odaxqt3XY9Lp3uYgEaQ==
X-Received: by 2002:adf:c793:: with SMTP id l19-v6mr7306653wrg.230.1538727337003;
        Fri, 05 Oct 2018 01:15:37 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x186-v6sm1651966wmx.24.2018.10.05.01.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 01:15:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] rebase -i: introduce the 'break' command
References: <pull.43.git.gitgitgadget@gmail.com>
        <b358178548bdc9134d4e4b83b1d0384ebb257a72.1538578818.git.gitgitgadget@gmail.com>
Date:   Fri, 05 Oct 2018 01:15:35 -0700
Message-ID: <xmqq1s9424ig.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The 'edit' command can be used to cherry-pick a commit and then
> immediately drop out of the interactive rebase, with exit code 0, to let
> the user amend the commit, or test it, or look around.
>
> Sometimes this functionality would come in handy *without*
> cherry-picking a commit, e.g. to interrupt the interactive rebase even
> before cherry-picking a commit, or immediately after an 'exec' or a
> 'merge'.
>
> This commit introduces that functionality, as the spanking new 'break' command.
>
> Suggested-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

If one wants to emulate this with the versions of Git that are
currently deployed, would it be sufficient to insert "exec false"
instead of "break"?

The reason I am asking is *not* to imply that we do not need this
new feature.  It is because I vaguely recall seeing a request to add
'pause' to the insn set and "exec false" was mentioned as a more
general alternative long time ago.  I am trying to see if this is a
recurring request/wish, because it would reinforce that this new
feature would be a good addition if that is the case.

I suspect that "exec false" would give a message that looks like a
complaint ("'false' failed so we are giving you control back to fix
things" or something like that), and having a dedicated way to pause
the execution without alarming the user is a good idea.

I think the earlier request asked for 'pause' (I didn't dig the list
archive very carefully, though), and 'stop' may also be a possible
verb, but I tend to agree with this patch that 'break' is probably
the best choice, simply because it begins with 'b' in the
abbreviated form, a letter that is not yet used by others (unlike
'pause' or 'stop' that would want 'p' and 's' that are already
taken)..

Here is a tangent, but I think the description of "-x <cmd>" in "git
rebase --continue" should mention that a failing command would
interrupt the sequencer.  That fact about "exec" command is given
much later in the last part of the "interactive mode" section of the
manual, so technically our docs are not being incomplete, but the
current description is not helpful to those who are looking for
substring "exec" from the beginning of the documentation to find out
if the exit status of the command affects the way commits are
replayed (which is what I was doing when imagining how users would
emulate this feature with deployed versions of Git).

Perhaps something as simple as this...

 Documentation/git-rebase.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 0e20a66e73..0fc5a851b5 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -420,7 +420,8 @@ idea unless you know what you are doing (see BUGS below).
 --exec <cmd>::
 	Append "exec <cmd>" after each line creating a commit in the
 	final history. <cmd> will be interpreted as one or more shell
-	commands.
+	commands, and interrupts the rebase session when it exits with
+	non-zero status.
 +
 You may execute several commands by either using one instance of `--exec`
 with several commands:


Also, it seems that this has some interaction with the topics in
flight; the added test does pass when queued on top of 'master', but
fails when merged to 'pu'.  I didn't look into the details as I am
not fully online yet.

Thanks.
