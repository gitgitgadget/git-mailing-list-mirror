Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 348082013C
	for <e@80x24.org>; Wed, 15 Feb 2017 23:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932197AbdBOXe7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 18:34:59 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36859 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753673AbdBOXe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 18:34:58 -0500
Received: by mail-pg0-f66.google.com with SMTP id 75so134859pgf.3
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 15:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1X24K/Z05XmY/M8aN3oBCPNfNsKrqz0+OeBU1oY4i24=;
        b=ekuexo4vE48k3Obgnr3UQC9rHqWmYfNMA1OJwxh/y4xc1sLhhe7rnYXOGXkQELmTNA
         4ZmzansR4n3w+X4PIT+aK6HwNYxD1iwvW2ki3LIxEAjRR9Qivzgn7On43G2SA13+fn3l
         yn1n+naf6DLPTJcP50HZjGdxQfDstFUOvyfMWD9G4YwJ/1m+tByWaEwMs9pzMCnsXHd9
         BJ3yzGAD6zNNPs2nQ2agDxnabsrFmJJk2HfNfhTHvOg6MpMrZ8XtNh1MFaQPuOaduQ5K
         BGhoZd2RoGN1cF9luqQKqbzuu6a+TQfaDupt+ttcIpGlyXUNZ5JPg6CFupUt6fsOxJYR
         I9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1X24K/Z05XmY/M8aN3oBCPNfNsKrqz0+OeBU1oY4i24=;
        b=q6Q8BgyK3p9PzxbAjlHCQTmSVAElXUNBl7Uw8ffnVF0+lV3yKST3c7kvYFVwzlwYtW
         vsVbmj5MXiby2p7WFvW5YucgzCAhd7bKAERmWC/XDjVLXENB4cizjXcVLsLE26E1mkIy
         7fcF1dly8ldFaTclk6WCrsO+P44sD7K7p2HY1QWLlDO8aZwoqLCSFKrwtTnnlQSOq3t+
         dI4gn/BMolaxtT7Y4hTEy6bWsbDT8rH+zZpw47sJiRSyk4fPtUQrwXLQufBRLoLvuLpv
         C7dqNvdHkuY5adMo15hvpOOON3+dDKeflJF25pnpDMnwuE02kenqNnIBAA9qbAYuZNYO
         jQng==
X-Gm-Message-State: AMke39k6BSNDHXedeaJCmceXlIAvUao1HX1+1RVCYUU/2xjcID7/mtR0IHW05aTHKM7LaA==
X-Received: by 10.98.215.70 with SMTP id v6mr40492135pfl.141.1487201687381;
        Wed, 15 Feb 2017 15:34:47 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3551:31c7:1fe1:8b9b])
        by smtp.gmail.com with ESMTPSA id 75sm9371446pfw.103.2017.02.15.15.34.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 15:34:46 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] mingw: make stderr unbuffered again
References: <c88612da0a62bfcbc3e278296f9d3eb010057071.1487025228.git.johannes.schindelin@gmx.de>
        <xmqqlgt9btrv.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1702141545380.3496@virtualbox>
        <xmqq37fga9rn.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1702151332540.3496@virtualbox>
        <xmqqbmu32iyb.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 15 Feb 2017 15:34:45 -0800
In-Reply-To: <xmqqbmu32iyb.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 15 Feb 2017 14:22:04 -0800")
Message-ID: <xmqqlgt7110q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> FWIW I wish it were different, that git.git's `master` reflected more
>> closely what the current Git for Windows version has.
>
> Well, we two wishing the same thing together without doing anything
> else would make it happen.

ehh, would *not* make it happen, of course.

> As an experiment to see if our process can be improved, I've been
> meaning to suggest (which is what was behind my "question at a bit
> higher level" to Hannes [*1*]) asking you to throw me occasional
> pull requests for changes that are only about Windows specific
> issues, bypassing "patches on the list" for things like a hotfix to
> js/mingw-isatty [*2*] and use of OpenSSL SHA-1 on Windows [*3*],
> essentially treating Windows specific changes as "a sub-maintainer
> makes pull requests" we already do with Paul, Eric and Pat.

While this may ease the flow of upstreaming windows specific
changes, we need a separate thing to address the on-going issue you
raised in your message.  A Windows-less person would not know his
change to a generic code that is innocuous-looking has fallouts on
Windows (read this sentence with "Windows" replaced with any
specific platform name).  When somebody writes c == '/' that should
have been written as is_dir_sep(c), you or Hannes often finds it
during the review here, and after repeatedly seeing such reviews,
that (slowly) rubs off on other Window-less folks.  A new code may
still hit 'next' and 'master' with such an issue if it goes
unnoticed during the review.

The CI you are setting up [*1*] may certainly be a step in the good
direction.  Having more people like Hannes working off of upstream
may also be a great way to help the "forget 'next' and upstream in
general" issue.  Any other ideas?

