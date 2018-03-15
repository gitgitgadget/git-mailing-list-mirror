Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 792131FAE3
	for <e@80x24.org>; Thu, 15 Mar 2018 16:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751673AbeCOQwI (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 12:52:08 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33066 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeCOQwH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 12:52:07 -0400
Received: by mail-wm0-f65.google.com with SMTP id s206so23979391wme.0
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 09:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=8jle3xmJ5Eg0lhqHnCEbsTe4VgXju3J9c2ed9rQW3rs=;
        b=uSlugctIw19lS00ARR8G79CUmLHG1dfSHZNbRE6hXEP5amCNeynC+p2bsocQYgZedk
         nyDqij1ZqcW571qt6GMdEGtjDGAOrymS7LYWqs2C6T2tTakyQc+Q8JysGNoPbytxSIf0
         +kJJSnV1Cvvdt/ZeQp5Nm7muQuiv5niPR8MliNKOjVo6oG5LGkW4w/WvhaQny8ekLCiU
         pyOZ+n8D7J2NqvHZ70aq1oTl6dA0SoOx30PH83yn+GpVxLjRbhWBempCZrmnBDYdASRz
         VA49l5ABzLJN7OC74oOaEQSt1BLih/OUG6dpckfwQGiISmPBy3jYf2kKDHzSjk/bdwH2
         jkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=8jle3xmJ5Eg0lhqHnCEbsTe4VgXju3J9c2ed9rQW3rs=;
        b=hhOdOU8faE+EnxCEQ6K5ghxlL2VcnXqxWRKUVsztCPxOLqM1JOrpCAqzrzXwQnMA76
         GhyQ5Fz6NKdekKenAFcv/c+3DSXvc4q1wtIJJcHj+ULWq0AQ9tuwS6hlcI1OrlmlsOrU
         v8jj7oKMyF5tMqARsy9s4+C8iSVvmoiSXmVXeTDYhWmymvZgjL8dbS9Pumhff9qWZkLj
         ZAkOLVnexMsOZJenXogDdisEHLJerGOSSe1D+sCly1zU8/6SRodVk4wPtbjI6cqNJHK5
         ne/inQchMwSt+IAC6fGDEWdr8g6h5f8r7gu2AJrelBbufFMzOocFm6iwHq/vZMFomPtV
         0pHw==
X-Gm-Message-State: AElRT7EiHz0RqEA6FBSEQlBi29f3+DrJ5WMrNohtWNYFQaOzpCpe/UU/
        T4PD6AdUHAE50jDts4nmF3At3tAW
X-Google-Smtp-Source: AG47ELuPMtsjYXvGI3y+dNmP3Fzh7RNFgfq+u8VMaxTuolka5YFvTiD6df7q80uSbC57WQbpbmdbxg==
X-Received: by 10.28.150.14 with SMTP id y14mr5712650wmd.5.1521132725859;
        Thu, 15 Mar 2018 09:52:05 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y68sm8075828wrb.73.2018.03.15.09.52.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Mar 2018 09:52:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jake Stine <jake.stine@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [bug] git stash push {dir-pathspec} wipes untracked files
References: <CABWk7R9xNDHJbbsMZbOyhcYXq-bD6Krvbw_mKDBJFALALS3AHA@mail.gmail.com>
Date:   Thu, 15 Mar 2018 09:52:04 -0700
In-Reply-To: <CABWk7R9xNDHJbbsMZbOyhcYXq-bD6Krvbw_mKDBJFALALS3AHA@mail.gmail.com>
        (Jake Stine's message of "Thu, 15 Mar 2018 09:40:38 -0700")
Message-ID: <xmqq1sgl703v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jake Stine <jake.stine@gmail.com> writes:

> Hi, I ran into what I believe is a bug today.  I’m using primarily Git
> for Windows 2.16.2 and also reproduced the behavior on Git for Windows
> 2.15.1 and Git 2.14.1 on Ubuntu:
>
> Given any repository with at least one subdirectory:
>
> 1.       Create some untracked files in the subdir
> 2.       Modify a tracked file in the subdir
> 3.       Execute `git stash push subdir`
> 4.       The untracked files will be removed, without warning.
>
> `git stash push` behaves as-expcted and does not touch untracked
> files.  It’s only when a directory tree is specified as [pathspec]
> that the problem occurs.

I wonder if this is the same as the topic on this thread.

  https://public-inbox.org/git/CA+HNv10i7AvWXjrQjxxy1LNJTmhr7LE4TwxhHUYBiWtmJCOf_A@mail.gmail.com/

What is curious is that the fix bba067d2 ("stash: don't delete
untracked files that match pathspec", 2018-01-06) appeared first in
2.16.2, on which Windows 2.16.2 is supposed to be built upon.

> Here's the precise reproduction case executed on a linux box:

This does not reproduce for me with v2.16.2-17-g38e79b1fda (the tip
of 'maint'); I do not have an  install of vanilla v2.16.2 handy, but
I suspect v2.16.2 would work just fine, too.

> jake@jake-VirtualBox:~/woot$ git --version
> git version 2.14.1
> ...
> The expected result is that when I do `ls subdir` the file
> "untracked.txt" still exists.  Alternatively, git stash should warn me
> before destroying my untracked files, and require I specify --force or
> similar to invoke destructive behavior.
>
>
> Thanks!
> Jake Stine
