Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47D27201B0
	for <e@80x24.org>; Mon, 20 Feb 2017 09:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751072AbdBTJM4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 04:12:56 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33630 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750907AbdBTJMz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 04:12:55 -0500
Received: by mail-pf0-f193.google.com with SMTP id p185so1304196pfb.0
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 01:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sDoAYFs+Mih0vjCN/bbAOv2fC539xvZ+ID8/b07dqIg=;
        b=ZD/eihyPF4swzCPuvnmxFknkAaFHDVUAt0sYLfwDrgnT3H2euflAhbImz6ARYix22d
         YVfXHR+dD07RqhiZGnN1HuJVwlk4YESgNWAl7ZXnzSyNFHjH7SERm0y8AQG0fGeGj3/5
         tGjJLAIm958O1aOV9qLDrRRh2dx8uzF5WQh4w4aDpTdVrTOkPmOoprFSKVdsRPwHGkWP
         ag9ZPb6DqbZKBYJEY27y/LTRzG2OHlNxETaZPTUwENExIvcJcMpxVzTz/4j7n7yNvvat
         vvwV+JkqiU1yTHEQOD02EFS2gv73C/6h7SePI72Jc7UX+FCa+LaMxI1jeWJYiB+tC4Mf
         NjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sDoAYFs+Mih0vjCN/bbAOv2fC539xvZ+ID8/b07dqIg=;
        b=A5a3hL4jRldAIAqF2MjJi4qUIvWnrl83Q3nW6scdz7cbNT36VQrC6Ji7xT6P6M5x2L
         5OmK81pt+XTZZqx2uO5aiNZf8JEi61ahvvm75y1LpfDFsY6h1OXWN6ph0QHE5GSt9fmv
         olG8X0qhWzt8vu9p8v7eYOogLZHyUJzlJPVIMuPICAy7IbTsbPKGVbyCKq7AY6wcJjj4
         yvoUwnakASTWfcGBDBma+gmjqZySrWACRnj0Qyrye+ci8/3oiNcbRhUEuNlA04GZXGFo
         DQPXUegnSNBGnsVeclcZtmL8aIi5MCZFIOObnIQRjzPc1Jgg5BlykvZ1zRlLYzE3uER/
         WIQA==
X-Gm-Message-State: AMke39lpXOB2wtnMfhCMOnXaVhuH7yCxv5Oh7qwxQUGb1ugvzzAH264XYzlEx1FYcPnvuA==
X-Received: by 10.99.1.87 with SMTP id 84mr26336834pgb.142.1487581355595;
        Mon, 20 Feb 2017 01:02:35 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:110e:6fae:3b03:324a])
        by smtp.gmail.com with ESMTPSA id s65sm33753658pgb.64.2017.02.20.01.02.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Feb 2017 01:02:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Alex Hoffman <spec@gal.ro>, Johannes Sixt <j6t@kdbg.org>,
        Stephan Beyer <s-beyer@gmx.net>, git <git@vger.kernel.org>
Subject: Re: Git bisect does not find commit introducing the bug
References: <CAMX8fZWe2HO78ySonHX0adtPUxVPbj5_vo-NUGrjwpb7gPdGrQ@mail.gmail.com>
        <d4991e4b-cbc4-da14-381a-88704e457a19@gmx.net>
        <3ff5ce3c-285f-cb9a-d1d4-46323524dab7@kdbg.org>
        <CAMX8fZVkBU6M8fkUcRr69V97_NTSOGGmPB1U-ObhmVv3i6wQhg@mail.gmail.com>
        <477d3533-d453-9499-e06e-72f45488d421@kdbg.org>
        <CAMX8fZW2y+iPRfSbXVcHufbM+CsqgekS_0WnCEJ++=njy_TvKg@mail.gmail.com>
        <CAP8UFD3ngMvVy2XLzYNn9OFbS+zQpWTW=pravpHhA-0PcDVhfg@mail.gmail.com>
Date:   Mon, 20 Feb 2017 01:02:33 -0800
In-Reply-To: <CAP8UFD3ngMvVy2XLzYNn9OFbS+zQpWTW=pravpHhA-0PcDVhfg@mail.gmail.com>
        (Christian Couder's message of "Sat, 18 Feb 2017 20:58:59 +0100")
Message-ID: <xmqqy3x1jkuu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> git bisect makes some assumptions that are true most of the time, so
> in practice it works well most of the time.

I think we need to clarify the documentation and ask you to stop
using such fuzzy phrases like "assumptions" and "most of the time"
;-).

For bisection to work, "git bisect" requires a very simple thing,
which is that your history is bisectable wrt one particular "trait",
i.e. what you are interested in (e.g. the trait may be "the commit
has this feature in a broken form").

What does it mean for a history to be "bisectable", then?

A bisectable history has commits with the "trait" and commits
without the "trait".  Given any commit with the "trait", all commits
that are decendant of such commit must have the "trait".  Also given
any commit without the "trait", all commits that are ancestor of
such a commit must not have the "trait".

And your goal is to find one commit with the "trait" whose direct
parent commits all lack the "trait".

If and only if you can formulate your problem into the above form,
"git bisect" can help you by not requiring you to check each and
every commit in the history.

Depending on the way you define the "trait", your history may not be
bisectable, but by formulating the "trait" carefully, many such
history can be made bisectable.  In the "Recently some commit broke
feature X.  Before then the feature used to work.  In an ancient
past, the feature did not even exist" example, if you set "trying to
use feature X breaks" as the "trait", your history is not bisectable
unless you ignore the ancient part that did not even have the
feature.  If you restate your "trait" to "feature X does not exist
in a broken form", however, the history becomes bisectable.

Historically, we called commits with "trait" BAD and others GOOD,
because bisection was used primarily to hunt for bugs.  It may be
easier to understand if the user thinks of commits without "trait"
as OLD (i.e. commits in the older part of the history are not yet
contaminated), and commits with "trait" as NEW (i.e. at some point,
there is an event to introduce the "trait" and newer part of the
history is contaminated by that event ever since).
