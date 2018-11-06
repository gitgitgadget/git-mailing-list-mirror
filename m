Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73A111F453
	for <e@80x24.org>; Tue,  6 Nov 2018 13:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388358AbeKFXZJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 18:25:09 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:38746 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388048AbeKFXZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 18:25:09 -0500
Received: by mail-wr1-f49.google.com with SMTP id d10-v6so13621428wrs.5
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 05:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=zuNKKEbtJY7gCFWbUbLu2KGxe1L4D4J9OJci+MLmN6Q=;
        b=ZA43dM++KPezyBRog3ThN2oiIkD4URxXZ7MOU/T8hPAHZQQtlj10ofCbKv4T/oF0vT
         VwMgpnYZeALzqPku0DbDa7liaMHXRynVPhTbVgxbzGoFMoRjLjiBpIoZ4RYbZe+8KCrq
         jIty8tv9VLpGXC7uLFUSeD1KK4+gsThByGH0Fu1JLFgW+CRXk/3X+8Y2tLE7iYYcRQdM
         ekZA6b5dubF18PMzfWehtFmeQIVxSU7xNXnRPWsdRXU++xuHZ5wxPOd9sopI21Dx/nfz
         K+r+S5q5rtytGPFM2Gu1RxS4gF/LFeJDH6o4XmREL7j/buy4E0N9tmEDr2VF6amDZhbM
         QA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=zuNKKEbtJY7gCFWbUbLu2KGxe1L4D4J9OJci+MLmN6Q=;
        b=oKsj0QV5sHpAx7yHwAlFGQobzobI2Z2/+foYuuBXcdMORA3el9i2XjnjMH1mVEM8M6
         /2MjkYYGJ6m9d93xoFcLfwgA3UW4pUwWZGUh/fcr+ElT+3fchJz9HrbuBMXWEkQZnYQb
         ZbEag/Rom0WFHUM5a9ZIJFjq3mPLCNwKlsl8B9FZ7osgsr0I3lVlxHPFFmNwZ4dFnJ0r
         fM66OamcSAdSqge3crkwxYtSS2Xwf4pdBkcdhsNQRFQsX2fAdQo+QsAgmbh6dfKBF025
         6BmgxhvRKSeyB+92GzI/wNY5jeIyDyiuMV9eJ8zOL7ArvGrKPyN4nMrMJLau1qpi+wpJ
         BF2g==
X-Gm-Message-State: AGRZ1gKmATsDbf3qikCqA9QsXl8R8/OfxtjNghpiMp6snM++s5V7xqAR
        YrkZT/H0s9aSXQel0IAXenwmwPej3tQ=
X-Google-Smtp-Source: AJdET5fCGMkaWiU9/iE/jo87FzY8ZFioXkoDGgQ4CJTkskciYML94ZBmA/Rye6XcQW4NfdLCvNnshw==
X-Received: by 2002:adf:9d1f:: with SMTP id k31-v6mr25122914wre.18.1541512785656;
        Tue, 06 Nov 2018 05:59:45 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id f67-v6sm1856505wme.22.2018.11.06.05.59.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 05:59:44 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Pratik Karki <predatoramigo@gmail.com>
Subject: Regression in rebase-in-C with rebase.autoStash=true
References: <pull.56.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <pull.56.git.gitgitgadget@gmail.com>
Date:   Tue, 06 Nov 2018 14:59:43 +0100
Message-ID: <878t2671dc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 23 2018, Johannes Schindelin via GitGitGadget wrote:

> Johannes Schindelin (2):
>   rebase --autostash: demonstrate a problem with dirty submodules
>   rebase --autostash: fix issue with dirty submodules
>
>  builtin/rebase.c            |  2 +-
>  t/t3420-rebase-autostash.sh | 10 ++++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)

There's another bug with rebase.autoStash in master (and next/pu) but
not v2.19.0. I tried to bisect bit it just comes down to 5541bd5b8f
("rebase: default to using the builtin rebase", 2018-08-08).

Credit to a co-worker of mine who wishes to remain anonymous for
discovering this. I narrowed down his test-case to (any repo will do):
    
    (
        rm -rf /tmp/todo &&
        git clone --single-branch --no-tags --branch=todo https://github.com/git/git.git /tmp/todo &&
        cd /tmp/todo &&
        rm Make &&
        git rev-parse --abbrev-ref HEAD &&
        git -c rebase.autoStash=true -c pull.rebase=true pull &&
        if test $(git rev-parse --abbrev-ref HEAD) != 'todo'
        then
            echo 'On detached head!' &&
            git status &&
            exit 1
        else
            echo 'We are still on our todo branch!'
        fi
    )
