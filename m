Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC5DC10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 10:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6C820746
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 10:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odQria0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgCMK47 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:56:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32827 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgCMK47 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 06:56:59 -0400
Received: by mail-lj1-f194.google.com with SMTP id f13so10015906ljp.0
        for <git@vger.kernel.org>; Fri, 13 Mar 2020 03:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=6Gq3bozPcmSkz4fdG5QcimjGC+njwlQsnRR30h/Tmaw=;
        b=odQria0Kf8x1LP7kIyS4jhTHFB0XM8ifbcP0ft5ocIT77ODJOy2UTCgJYIte7l84Cl
         AmxpT9rSZoSKqBExWVeNz9A7mNj/adV3WsuHY79n/6WowqZy3PSNpv+d9JOK95q4qKbt
         5Vu0+WL1t9ZbyspXfi0xwoHGWroHY4IqYCnI6GrAT0eF2CT8p6DkC6qGPziZnZYzJpFg
         aosrD3b1lmZ6CuRZnMsE5ZzPkS8SRH9OMB1gAjPe0RhNzE2X7ofxjFp8QOih2HRC8Zsd
         v1Ui1r/Jo+K0TG8ZlU147a4BA06FG+H95z1SZTqvb9zb26Sjo9uJxpacU4q/+2ylNLZ2
         8fNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=6Gq3bozPcmSkz4fdG5QcimjGC+njwlQsnRR30h/Tmaw=;
        b=lJY/fKK9itSG75Z6dHHLTINbivFlYzk2VFz8H5C81iEfRuszvPMy5DHbW/nHVr/PCU
         vmCrvh59lnZmK7S3AJT2FD5TXqraxQWceB0MSG8z2x6IbrV30951cXABJ0Vd+pdWESa5
         cr6Z4Ur4qlPCjAtHjfq6F85REgU/2BUKJFc0FKThmjlBKTFgjSN9PnBsSCuUnWDyWA80
         zWqyjp2QPssiIwYkK4oDrTZzl8Jn2l3Etj3VMX3wNZCBWzFPMjk2JywdYPquuvwck20Z
         hlvsWgXFK3Z/GupzcVe1+pQyrjYemBY02TMIVqJQSFSxShMDXFuhI/kchfBuTMcPZnNq
         cnpg==
X-Gm-Message-State: ANhLgQ1WCOiH5JWGWxAtdC3vpiqC2PIVDQxk65Haojo+p3NBFwLowAoq
        dYqdqGW/ZhufVR2hxQHOoFo=
X-Google-Smtp-Source: ADFU+vvtZzVqLVtDKlzJ36cJrF/nyZPHCveDxly9BjNaUkw+b2iJ798Xlp1Ser2eRxO7WcW6AdSB8g==
X-Received: by 2002:a05:651c:2007:: with SMTP id s7mr8082569ljo.214.1584097016660;
        Fri, 13 Mar 2020 03:56:56 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id u6sm21017686lff.35.2020.03.13.03.56.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 03:56:55 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Heba Waly <heba.waly@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [RFC] Possible idea for GSoC 2020
References: <86mu8o8dsf.fsf@gmail.com>
        <xmqqo8t2hfxj.fsf@gitster.c.googlers.com>
Date:   Fri, 13 Mar 2020 11:56:51 +0100
In-Reply-To: <xmqqo8t2hfxj.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 11 Mar 2020 12:03:52 -0700")
Message-ID: <86tv2s34lo.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cc: Stolee, Heba, Jonathan T., Emily Shaffer.=20

Junio C Hamano <gitster@pobox.com> writes:
> Jakub Narebski <jnareb@gmail.com> writes:
>
>> A few questions:
>> - is it too late to propose a new project idea for GSoC 2020?
>> - is it too difficult of a project for GSoC?
>> ...
>> ### Graph labelling for speeding up git commands
>>
>>  - Language: C
>>  - Difficulty: hard / difficult
>>  - Possible mentors: Jakub Nar=C4=99bski
>
> I am not running the GSoC or participating in it in any way other
> than just being a reviewer-maintainer of the project, but I would
> appreciate a well-thought-out write-up very much.

I have prepared slides for "Graph operations in Git version control
system" (PDF), mainly describing what was already done to improve their
performance, but they also include a few thoughts about the future (like
additional graph reachability labelings)... unfortunately the slides are
in Polish, not in English.

If there is interest, I could translate them, and put the result
somewhere accessible.

Or I could try to make this information into blog post -- this topic
would really gain from using images (like Derrick Stolee series of
articles on commit-graph).

>> Git uses various clever methods for making operations on very large
>> repositories faster, from bitmap indices for git-fetch[1], to generation
>> numbers (also known as topological levels) in the commit-graph file for
>> commit graph traversal operations like `git log --graph`[2].
>>
>> One possible improvement that can make Git even faster is using min-post
>> intervals labelling.  The basis of this labelling is post-visit order of
>> a depth-first search traversal tree of a commit graph, let's call it
>> 'post(v)'.
>>
>> If for each commit 'v' we would compute and store in the commit-graph
>> file two numbers: 'post(v)' and the minimum of 'post(u)' for all commits
>> reachable from 'v', let's call the latter 'min_graph(v)', then the
>> following condition is true:
>>
>>   if 'v' can reach 'u', then min_graph(v) <=3D post(u) <=3D post(v)
>>
>> If for each commit 'v' we would compute and store in the commit-graph
>> file two numbers: 'post(v)' and the minimum of 'post(u)' for commits
>> that were visited during the part of depth-first search that started
>> from 'v' (which is the minimum of post-order number for subtree of a
>> spanning tree that starts at 'v').  Let's call the later 'min_tree(v)'.
>> Then the following condition is true:
>>
>>   if min_tree(v) <=3D post(u) <=3D post(v), then 'v' can reach 'u'
>>
>> The task would be to implement computing such labelling (or a more
>> involved variant of it[3][4]), storing it in commit-graph file, and
>> using it for speeding up git commands (starting from a single chosen
>> command) such as:
>>
>>  - git merge-base --is-ancestor A B
>>  - git branch --contains A
>>  - git tag --contains A
>>  - git branch --merged A
>>  - git tag --merged A
>>  - git merge-base --all A B
>>  - git log --topo-sort
>>
>> References:
>>
>> 1. <http://githubengineering.com/counting-objects/>
>> 2. <https://devblogs.microsoft.com/devops/supercharging-the-git-commit-g=
raph-iii-generations/>
>> 3. <https://arxiv.org/abs/1404.4465>
>> 4. <https://github.com/steps/Ferrari>
>>
>> See also discussion in:
>>
>> <https://public-inbox.org/git/86tvl0zhos.fsf@gmail.com/t/>

P.S. A bit more expanded writeup now available
at https://git.github.io/SoC-2020-Ideas/

Best,
--=20
Jakub Nar=C4=99bski
