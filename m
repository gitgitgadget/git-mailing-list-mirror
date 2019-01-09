Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E947A1F803
	for <e@80x24.org>; Wed,  9 Jan 2019 17:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfAIRoe (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 12:44:34 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37985 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfAIRoe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 12:44:34 -0500
Received: by mail-lf1-f65.google.com with SMTP id a8so6285001lfk.5
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 09:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KRCJQWQhaZpukT+pgdHYEddQb5FYFfcagB1a5twDnNI=;
        b=FU8o+8xWDaG8AnErUvi8JKo7VCSbgdsbCcx121JtIpSLM9f3yl939d+8tEs6fZw2g6
         NBBnnQqFxRctxZGBXUHMwj9iw9YFFbNWJ8+NyzPBeWCr1GU4aOeXeXvQ3claAuezCPlr
         y8BfNe1mXSTd7/fOoeHWyheiXbQq3kdd4TpoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KRCJQWQhaZpukT+pgdHYEddQb5FYFfcagB1a5twDnNI=;
        b=E2ONtqsu5ZWLT//7YDZNAWaCQj9WCrwwhWudDGVzfFFcr5Qlb22Ce98JEytuxjsqL8
         t2Mwgj7Crc/QfBG6eb/KgXCfA9qUDBxrDYuBboJXId8T2hh6Nn2x6zI3d0yEu/wO95Kg
         ly91GRqYtz0dmbRkgoX6XqWOeYC59IICh0s12TSWptJ7s2co/jiQKUIKYCWXVF9VHETJ
         7LNxBZXaQdV0zFz3Fps66YITaEleL4WObB7XU+EyHFX3vu9bssDngmLbT7t27tgmxEZG
         qIg/cLfIVpfD5tst2pNtoMoP1j4Cx27PG2ysLYpuzT2Vq4p/zsI/z7Tn9ZQ1Dwdn+9rq
         yeIw==
X-Gm-Message-State: AJcUukeG1rIVUis5mee0bMDyZXSewbpd6St8c7b/qsIwM+TP3JI51j0o
        IpogTU8eE5qhxUUr6m5J1Dmfww3bIaw=
X-Google-Smtp-Source: ALg8bN7NTCcS3NriSbk906N4TB2Vv8rjYyPhbwJ9ydBsfoUkvFymyifVUCQGzyO4ZXtQu+tM9lkjzA==
X-Received: by 2002:a19:1bd2:: with SMTP id b201mr3818175lfb.136.1547055871802;
        Wed, 09 Jan 2019 09:44:31 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id q10-v6sm16040382ljh.72.2019.01.09.09.44.30
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 09:44:31 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id c19-v6so7231181lja.5
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 09:44:30 -0800 (PST)
X-Received: by 2002:a2e:9c7:: with SMTP id 190-v6mr3539127ljj.120.1547055870504;
 Wed, 09 Jan 2019 09:44:30 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wg0NUNFjZumgC-9f=kmU3L4T+qOAgXwiDAfPaNtuFfvFg@mail.gmail.com>
 <CAGZ79kaOcoVSRgTR+k9ENoDz6FHh27MzpZ9D-MeFArN2vgBK0w@mail.gmail.com>
In-Reply-To: <CAGZ79kaOcoVSRgTR+k9ENoDz6FHh27MzpZ9D-MeFArN2vgBK0w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Jan 2019 09:44:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjip45uqONG=Qzevd0HoT47t7NatSpr+N3ifMZehr2M0Q@mail.gmail.com>
Message-ID: <CAHk-=wjip45uqONG=Qzevd0HoT47t7NatSpr+N3ifMZehr2M0Q@mail.gmail.com>
Subject: Re: Make "git log --count" work like "git rev-list"
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio Hamano C <gitster@pobox.com>,
        Git List Mailing <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 9, 2019 at 9:21 AM Stefan Beller <sbeller@google.com> wrote:
>
> Sounds reasonable to me to have such functionality,
> as I tend to use
>   git log --oneline origin/master..origin/next --no-merges |wc -l
> for such queries, which I always assume to be doing useless
> work as I'd be interested in *only* the count, and not the
> intermediate oneline output, but that is the best output
> that wc works on.

Right. I've been known to do that too, but because I grew up with "git
rev-list", I know about --count and tend to use it.

In fact, I've occasionally used it with "git log" already (before my
patch), and it would silently accept the parameter (because it's
parsed by the generic revision parsing), it just wouldn't work.

> So maybe the --count option would want to suppress
> other output if given (or we'd want to have another option
> for no output)?

It already does so in my patch, exactly because it uses the same logic
as "git rev-list --count" does.

Which is to simply react to the "--count" thing early in
log_tree_commit(), and do the counting and then say "I showed this"
(without showing anything).

So you can do silly things like this:

    [torvalds@i7 linux]$ git log --count -10
    10
    [torvalds@i7 linux]$

and it just works. Nonsensical, but logical.

              Linus
