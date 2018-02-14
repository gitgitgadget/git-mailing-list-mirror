Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85B871F404
	for <e@80x24.org>; Wed, 14 Feb 2018 00:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966224AbeBNAa4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 19:30:56 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33621 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966180AbeBNAaz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 19:30:55 -0500
Received: by mail-wm0-f65.google.com with SMTP id x4so15429234wmc.0
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 16:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0MWu3jtxQ9+o5gVRmcld5Z4P8/KysleiluBHCFuKo/8=;
        b=dbnRT8QdsQqzkM9PHWzleMkVWerB+MvXqNeRT6FEmYng40S62SreM6H2wq4DNin02o
         j6YH0THaCv2dnJeAVPw7Rzh8a9QAARC5rsq/KxKyRjzOxYUfeQKPSjQ1VMbYaZ3eaF7e
         wteEDiRub8XG4EID0kcNYDdv9EGppmONscJotnwAh5Ktj+lE3w0/wvGU8ksAO2zkfhXX
         7+975BCBHlJGQguermnnkBn/zC1wh6iA7d5wWQIYhkF+klkaQuwv/26hPNscBArjxyl5
         Qudt5s+BjeKWiknqRVw4qVaiSJUJPgcLQSN9TCKeCv97k/ZtAPp6CU5tOLLCrXvsiqy8
         sxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0MWu3jtxQ9+o5gVRmcld5Z4P8/KysleiluBHCFuKo/8=;
        b=GQz5/XqRQ6maBG9IVH5fmcnUXzso1Ykk2tAuinUPKgjDywBe1IL1TMvPBaqZW0WARq
         Z9ZK+ZFPv2tSOPC9ISQkWHB7ePt76loPScAfo2/ENQMdwM8+S0+EmrvOk1fR15tIjgWC
         WTr+31ttXtYrQwksM4FjHQJiL8oa5ILFpbZLj8A74FVRZdtOYKoVfFnwvcx+Qw11cibi
         hN8XpDoK6MTkzj7NOU+nRF6eWjr13Tme6jvLzOEfYcvlIzTm2QemLr58+6tEX1GUcdeY
         EcSezJzGCSNYBHs/86PHsXtp8FvHwcH046CAR1VrSN+95YF6hfqyjPtILB1JElFM9n+b
         +OXw==
X-Gm-Message-State: APf1xPC0AKuLnVZiMpqimN5vY3IEt/T0j6pzdT86W5vZ2ofJa6I+BGDM
        OEubDC0OjPKV5PZVHSv+lLs=
X-Google-Smtp-Source: AH8x225T8q3fx7THTRI9vCJSWkUVXRZ4AHmLEBHmrIS/rLVg+yvbeYR0JvPtEmHcrMquRr4TrLDkJg==
X-Received: by 10.28.68.4 with SMTP id r4mr2776947wma.94.1518568254098;
        Tue, 13 Feb 2018 16:30:54 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r70sm10204643wmg.30.2018.02.13.16.30.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Feb 2018 16:30:53 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 00/26] Moving global state into the repository object (part 1)
References: <20180213012241.187007-1-sbeller@google.com>
        <20180213114903.GA21015@ash>
        <CACsJy8C8+VnjrhEh3o36GUttZXmfiKxqjzS=2LzmfZKQjogojQ@mail.gmail.com>
        <CAGZ79kbmAkN5EpW1hzW-FFdR74c-qXJc5aKZX0ff9bU0gxMRqQ@mail.gmail.com>
        <xmqq7ergra2y.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kZOq+_NOOabBUtPJ_zKNb_vdais70F6VzVFoSn5B5A4fQ@mail.gmail.com>
        <xmqqzi4cptsa.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kY4bFHAYeVn_8jBKp+kNzCs+juaa0Lp=Tx=SZK_HtDQHg@mail.gmail.com>
Date:   Tue, 13 Feb 2018 16:30:52 -0800
In-Reply-To: <CAGZ79kY4bFHAYeVn_8jBKp+kNzCs+juaa0Lp=Tx=SZK_HtDQHg@mail.gmail.com>
        (Stefan Beller's message of "Tue, 13 Feb 2018 11:43:04 -0800")
Message-ID: <xmqqmv0cpg3n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Which is why I'd strongly consider having it only in the repository
> object as that is the largest-scoped thing we'd want. e.g. submodules
> should care about environment variables differently:
>
>     GIT_WORK_TREE=~/mysuperproject git checkout \
>             --recurse-submodules master
>
>  So with such a command in mind, the environment variable would
> only apply to the superproject and the nested submodules should
> ignore the env, but compute their paths off the superproject, i.e.
> the superproject repository, not its object store?

In the longer term endgame state, what is in the repository object
cannot just be a simple "do we honor environment variable" bit
anymore.  

It will be more like "we may (or may not) look at environment when
we create a repository object", i.e. a bit passed to repo_init()
constructor, and from then on, the repository object knows where the
object store and its alternates are, where the top of the working
tree is, where the repository (i.e. the directory that has "refs/"
in it) is, what "worktree" of the repository we are talking about by
itself.  There is no need for a bit "do we or do we not look at
environment?" that needs to be consulted at runtime, which is quite
a round-about thing.

In your example, the repository object that represents the
superproject will pay attention to GIT_WORK_TREE environment when it
is consturcted, and repository objects dynamically constructed while
the command "recurse-submodules" through them will be constructed
with their "where is the top of my working tree?" set appropriately.
They won't be storing "when figuring out where my working tree is,
do not pay attention to GIT_WORK_TREE environment variable" bit.

