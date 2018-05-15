Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A7C11F406
	for <e@80x24.org>; Tue, 15 May 2018 04:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeEOEJn (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 00:09:43 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37504 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752139AbeEOEJl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 00:09:41 -0400
Received: by mail-wm0-f65.google.com with SMTP id l1-v6so18823147wmb.2
        for <git@vger.kernel.org>; Mon, 14 May 2018 21:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JYn1YpCDb1I+u9oBXwKhg2nUAm3qMz2z3IbexBs8LE0=;
        b=ZCVW98RwPfQ2tbL/Shqt6FXRHjJ5A6BRpU4Gea2IsdfUx9Jtc7XQND+DBX33XSDFcw
         5YzF33TunOUK+tLZeyjKlSbGGUV9ERM7rXoDCKVglLlcgeouEL9sRJA4PO2Jc2HaLRI9
         /XsHoM2it/jPI9a+e/mGqUIdCLl6dMRPH+5QponlobwqH705oOOy5/5jDtRskpsVwzp3
         EEuFzxmzRqRKuwsrbmfzLA3AdwD84KTsxl3LicHxc81OjnXcx+Fl0UV2PxXjCzzq3rYI
         1pp3sekVTuptgOm+YueA+iQSmS67yWnCMkmGgoGHZ4gQ5EDWsW4r7yj5NuHdeaBHsyie
         aj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JYn1YpCDb1I+u9oBXwKhg2nUAm3qMz2z3IbexBs8LE0=;
        b=ZmF3uvCeHAAjHw60TsM/+oRikqofniWCsg+HL7Y3zrIeU0HSTMfoj9/ITWEsPOvrp9
         hIUJEpC4tuzv8D4AwF7qlnIfLzs1v+e6kzb04EaU62YQ7fHZ8LRwxlysFMM/RJoAfwpD
         95qyD0veTMILpmORYeOs+9Zp51CXGNgkzm2Jk+XnS8lY+9D+TPprNdmTlfK9+o7xVq9d
         SGua+GayqY4S0BIM7sQwPM9VIEsdFkbihP1WH18c9RcN5fWlYV1QupkgHa0DkLR7PNsR
         5sl8DlNxPfKc5q7kjO4TfxgM2hQEiv2tjq0X3qZB0onPt22ALKkjIirgdYUVCA78drHk
         A3LQ==
X-Gm-Message-State: ALKqPwe+UT2joLweJ64w9odv0BcFTaB/VBJEIvt2eIBHvIVLtYlNn5q6
        7h8/AbbAzIOdhnl1A/EVSA3viBZu
X-Google-Smtp-Source: AB8JxZqVs193oqIuM6kgjijfla+En0TFF0gQ0bjtQfBpDSPfcSqXJWLxRZyg3HBkfaJYsRSpM7LGIA==
X-Received: by 2002:a1c:2348:: with SMTP id j69-v6mr6546424wmj.45.1526357380207;
        Mon, 14 May 2018 21:09:40 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b185-v6sm11373526wmb.25.2018.05.14.21.09.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 May 2018 21:09:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Daniel =?utf-8?Q?Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 00/10] Make submodules work if .gitmodules is not checked out
References: <20180514105823.8378-1-ao2@ao2.it>
Date:   Tue, 15 May 2018 13:09:39 +0900
In-Reply-To: <20180514105823.8378-1-ao2@ao2.it> (Antonio Ospite's message of
        "Mon, 14 May 2018 12:58:13 +0200")
Message-ID: <xmqq4lj9a7b0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Antonio Ospite <ao2@ao2.it> writes:

>   - my git terminology may still be a little off: do "work tree" and
>     "work directory" mean the same thing?

Just on this tangent.  

When we talk about the current working directory of a process
returned by getcwd((3) call, we typically spell that word fully (or
say $cwd).

We lived without the modern "git worktree" layout for a long time,
but there was a hack in contrib/ called "git-new-workdir".  This
creates something similar (in spirit, not in implementation) to
"worktree" in modern Git lingo, but because not many people use the
contrib feature (at least there is only few who get confused by it
and ask questions publicly, anyway), we do not hear "workdir" very
often.

Since very early days of Git, we had "working tree" that is the
directory hierarchy that corresponds to what you place in the index,
and "Git repository" which is the ".git" directory that has that
index.  Even though most everybody else was calling it the "working
tree", primarily because I was young(er) and (more) stupid, I often
called the same thing "work tree", and made things worse by
introducing GIT_WORK_TREE environment variable etc.  But "working
tree" is the official terminology to denote a directory hierarchy
that corresponds to (and controlled by) a single index file as
opposed to what is in ".git/" directory..

The official term "worktree" came much later, with "git worktree"
command.  This allow multiple working trees to be associated with a
single ".git/" directory.  Most of the time "worktree" and "working
tree" can be used interchangeably, but we tend to say "working tree"
when we have more emphasis on the non-bareness of the repository and
talking about checked-out files, and say "worktree" when we are
mostly interested in the layout that have more than one working trees
associated to a single Git repository.  What you get by "git clone",
for example, is just a single repository with a single working tree,
and nobody sane (other than young(er) and (more) stupid version of
me 10 years ago) would call the latter a "worktree" these days, as
there is not yet a secondary worktree to contrast it with.

