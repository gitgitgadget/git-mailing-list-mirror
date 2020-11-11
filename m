Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E420C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 17:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB8832072C
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 17:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgKKRWq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 12:22:46 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:47123 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726625AbgKKRWq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 12:22:46 -0500
Received: from host-89-243-187-160.as13285.net ([89.243.187.160] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1kctpT-0005oT-3t; Wed, 11 Nov 2020 17:22:43 +0000
Subject: Re: [RFC 1/2] submodules: test for fetch of non-init subsub-repo
To:     =?UTF-8?Q?Peter_K=c3=a4stle?= <peter.kaestle@nokia.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>
References: <1604413399-63090-1-git-send-email-peter.kaestle@nokia.com>
 <1604910829-49109-1-git-send-email-peter.kaestle@nokia.com>
 <1604910829-49109-2-git-send-email-peter.kaestle@nokia.com>
 <xmqqk0uuct94.fsf@gitster.c.googlers.com>
 <c4741382-5662-ac15-24da-218b28ae9dee@nokia.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <4339e01e-d312-69ee-c810-2fbc65606b0d@iee.email>
Date:   Wed, 11 Nov 2020 17:22:43 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <c4741382-5662-ac15-24da-218b28ae9dee@nokia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

minor readability comment,

On 11/11/2020 12:45, Peter Kästle wrote:
> Here is my proposal for a new commit message of the test case:
>
> ----8<----
> A regression has been introduced by 'a62387b (submodule.c: fetch in
> submodules git directory instead of in worktree, 2018-11-28)'.
>
> The scenario in which it triggers is when one has a remote repository
> with a subrepository inside a subrepository like this:
> superproject/middle_repo/inner_repo
>
> Person A and B have both a clone of it, while Person B is not working
> with the inner_repo and thus does not have it initialized in his working
> copy.
>
> Now person A introduces a change to the inner_repo and propagates it
> through the middle_repo and the superproject.
> Once person A pushed the changes and person B wants to fetch them
> using "git fetch" on superproject level, git

It's not obviously obvious which person is doing this final 'git'
operation (it isn't attached to a particular person). Not sure if moving
the comma, or saying ", B's 'git fetch' will.." is the right choice. The
following sentences also feel as treating 'git' as person (trusted
friend;-).

> will return with error saying:
>
> Could not access submodule 'inner_repo'
> Errors during submodule fetch:
>         middle_repo
>
> Expectation is that in this case the inner submodule will be
> recognized as uninitialized subrepository and skipped by the git fetch
> command.
>
> This used to work correctly before 'a62387b (submodule.c: fetch in
> submodules git directory instead of in worktree, 2018-11-28)'.
>
> Starting with a62387b the code wants to evaluate "is_empty_dir()"
> inside .git/modules for a directory only existing in the worktree,
> delivering then of course wrong return value.
> ---->8----
--
Philip
