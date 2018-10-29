Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B8611F453
	for <e@80x24.org>; Mon, 29 Oct 2018 03:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbeJ2Lwk (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 07:52:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38476 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729240AbeJ2Lwk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 07:52:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2-v6so948668wmh.3
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 20:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=th42rg76oTjeUEIQ4lKaNt21nsQ5LJxrVYzuDsk2R5M=;
        b=b0MQUUdYJzrV0NNtLUFKNGtaGP8duQGePoscH6QNc+4DwwFZTxWcDnEo9SnC80gwsy
         oBaNHMDOhZMpjcsapUf8CMnWL7OelMqYTBcqhdxSPspPNUgri2XoGNc4puE4nrsmQzKU
         pBNnvhl4xGH/i7uVvmjaw6sn+stzRpyq70I6OtOfQgsQhoiOXH1xtsOYp2zF5F+LumMK
         /5XYNjlljjg183MLloQoym1jc+gcf9siiTDkKzT9XXaGdEdFO6a7GXnvs5i1ymIhZ7DS
         phNQ627pk6AIQfuHjF5Oc05MDRacvPZZ0r7apCy1C21yXGfVI2ETHenCV42LDVzkUzk8
         wwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=th42rg76oTjeUEIQ4lKaNt21nsQ5LJxrVYzuDsk2R5M=;
        b=i6HdiXFbqij/0ZULwqAuKa52AD+vUKXQBhaDnUpIJvNJBc7wtuBFd8gNnHb78ngPQB
         rqx9/l6GooYkV659rdK/ytUvTYSZ58gr0Bb1tuvmhhIMFHudhGWVbmxsvcgvf4aqUPFW
         oMRqB5gSczxMw3PEYyPaN6zBh0cKlEBbyTHlYTi7eOdZ5PW0OVJIk2hvVqv4HUelonMP
         RZqQeSTtPI+p2PLG3dzcRMjpT26c43Le1ztsOyfkvrSLm4GXeut+5cXV321ibKs1dRCW
         oYnAeeF1Ingg0VVidVTEZyOVYoQMbrBEnxUDChv4t5smYYcOhoVeqHxbBE7Frq2W0HH0
         phIw==
X-Gm-Message-State: AGRZ1gK0zIjNlpIyvIU3ZbUOsVQuYDPZk4G46CsHncrt7BsAIW8+a5I7
        0SgnX1nH35ZDc+4HdnvLtTg=
X-Google-Smtp-Source: AJdET5dFlZa1ewq4rpIznyPDKwVc0TSqCqr+xDxy0FDecJIfc1rsSR1ssw4apiQtPlkN9XXwL7imIQ==
X-Received: by 2002:a1c:a850:: with SMTP id r77-v6mr8550867wme.105.1540782355153;
        Sun, 28 Oct 2018 20:05:55 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y21-v6sm2367801wma.36.2018.10.28.20.05.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 20:05:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [PATCH v2 00/16] sequencer: refactor functions working on a todo_list
References: <20181007195418.25752-1-alban.gruin@gmail.com>
        <20181027212930.9303-1-alban.gruin@gmail.com>
Date:   Mon, 29 Oct 2018 12:05:51 +0900
In-Reply-To: <20181027212930.9303-1-alban.gruin@gmail.com> (Alban Gruin's
        message of "Sat, 27 Oct 2018 23:29:14 +0200")
Message-ID: <xmqqd0rt8nao.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> At the center of the "interactive" part of the interactive rebase lies
> the todo list.  When the user starts an interactive rebase, a todo list
> is generated, presented to the user (who then edits it using a text
> editor), read back, and then is checked and processed before the actual
> rebase takes place.
>
> Some of this processing includes adding execs commands, reordering
> fixup! and squash! commits, and checking if no commits were accidentally
> dropped by the user.
>
> Before I converted the interactive rebase in C, these functions were
> called by git-rebase--interactive.sh through git-rebase--helper.  Since
> the only way to pass around a large amount of data between a shell
> script and a C program is to use a file (or any declination of a file),
> the functions that checked and processed the todo list were directly
> working on a file, the same file that the user edited.
>
> During the conversion, I did not address this issue, which lead to a
> complete_action() that reads the todo list file, does some computation
> based on its content, and writes it back to the disk, several times in
> the same function.
>
> As it is not an efficient way to handle a data structure, this patch
> series refactor the functions that processes the todo list to work on a
> todo_list structure instead of reading it from the disk.
>
> Some commits consists in modifying edit_todo_list() (initially used by
> --edit-todo) to handle the initial edition of the todo list, to increase
> code sharing.
>
> It is based onto ag/rebase-i-in-c (34b4731, "rebase -i: move
> rebase--helper modes to rebase--interactive").

As there are quite a lot of fixes to the sequencer machinery since
that topic forked from the mainline.  For example, [06/16] has
unpleasant merge conflicts with 1ace63bc ("rebase --exec: make it
work with --rebase-merges", 2018-08-09) that has been in master for
the past couple of months.  IOW, the tip of ag/rebase-i-in-c is a
bit too old a base to work on by now.  

I think I queued the previous round on the result of merging
ag/rebase-i-in-c into master, i.e. 61dc7b24 ("Merge branch
'ag/rebase-i-in-c' into ag/sequencer-reduce-rewriting-todo",
2018-10-09).  That may be a more reasonable place to start this
update on.

