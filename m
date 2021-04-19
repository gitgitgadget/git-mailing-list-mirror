Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D46C433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 13:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E3E6113C
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 13:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbhDSNDh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 09:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbhDSNDf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 09:03:35 -0400
X-Greylist: delayed 378 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 19 Apr 2021 06:03:05 PDT
Received: from pug.qqx.org (pug.qqx.org [IPv6:2600:3c02:e000:5::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533B1C06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 06:03:04 -0700 (PDT)
Received: by pug.qqx.org (Postfix, from userid 1000)
        id E52741DBBB; Mon, 19 Apr 2021 08:56:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schrab.com; s=mail;
        t=1618837003; bh=r9mBgRXQ7uzSdOKNRvlYpjdYaRcTevMsqRYLK1tBT0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=emXy1PhWRDknGkq0dOfxJkPjBeMYifD9RxfGsVHwJPzkVPzHdkLuph1TmXyOBWx8c
         7d3ukdN/EHvd91878awckCflkFgt3wzmbpNvyu+jSiSQq+s+quSQ0pILNmNc+M1oHt
         LPCc8Cojbtr0WUwopRjZI2esPDj+6a70egwfuHSo000NmkGSYON63JcpEVsL1JOW0C
         XIz5wUjqlGzxt9gig6yJyqo9TjIlPn+TxHsgzaftGU8XNlwK2dZbq30Y/Nr5IGQR7g
         +9f6DpXt5ASqRnHgxK+J/dsACWGFkKPYveYNNKYkJ0ZB2O64unH9Ra5iy3Fr1rXOp4
         Z1MjLrNg949Tw==
Date:   Mon, 19 Apr 2021 08:56:43 -0400
From:   Aaron Schrab <aaron@schrab.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, jrnieder@gmail.com,
        albertcui@google.com, gitster@pobox.com, matheus.bernardino@usp.br
Subject: Re: RFC/Discussion - Submodule UX Improvements
Message-ID: <YH1+C47AErrCUkHI@pug.qqx.org>
Mail-Followup-To: Emily Shaffer <emilyshaffer@google.com>,
        git@vger.kernel.org, avarab@gmail.com, jrnieder@gmail.com,
        albertcui@google.com, gitster@pobox.com, matheus.bernardino@usp.br
References: <YHofmWcIAidkvJiD@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YHofmWcIAidkvJiD@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At 16:36 -0700 16 Apr 2021, Emily Shaffer <emilyshaffer@google.com> wrote:
>- git switch / git checkout

(snip)

>4. A new branch with the same name is created on each submodule.
>  a. If there is a naming conflict, we could prompt the user to resolve it, or
>     we could just check out the branch by that name and print a warning to the
>     user with advice on how to solve it (cd submodule && git switch -c
>     different-branch-name HEAD@{1}). Maybe we could skip the warning/advice if
>     the tree is identical to the tree we would have used as the start point
>     (that is, the user switched branches in the submodule, then said "oh crap"
>     and went back and switched branches in the superproject).
>  b. Tracking info is set appropriately on each new branch to the upstream of
>     the branch referenced by the parent of the new superproject commit, OR to
>     the default branch's upstream.
>5. The new branch is checked out on each of the submodules.

In many cases the branch name for the superproject isn't going to be 
appropriate for submodules.

This seems likely to create a LOT of junk branches. Do you also have a 
proposal for cleaning those up?
