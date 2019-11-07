Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 629751F454
	for <e@80x24.org>; Thu,  7 Nov 2019 13:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbfKGN50 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 08:57:26 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:47146 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbfKGN50 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 08:57:26 -0500
Received: from [92.30.121.54] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iSiHr-0007RZ-B3; Thu, 07 Nov 2019 13:57:23 +0000
Subject: Re: GIT_COMMITTER_* and reflog
To:     Luke Dashjr <luke@dashjr.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
References: <201910252149.23787.luke@dashjr.org>
 <20191026022039.GE39574@google.com> <201910260243.23627.luke@dashjr.org>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <3d6e0a08-673d-e83d-d18d-8153840d185d@iee.email>
Date:   Thu, 7 Nov 2019 13:57:24 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <201910260243.23627.luke@dashjr.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

copying Dscho,

On 26/10/2019 03:43, Luke Dashjr wrote:
> On Saturday 26 October 2019 02:20:39 Jonathan Nieder wrote:
>> Luke Dashjr wrote:
>>> It appears the reflog currently allows its log data (name and date) to be
>>> overridden by the GIT_COMMITTER_* environment variables. At least for my
>>> workflow, this kinda breaks the reflog (as I regularly set
>>> GIT_COMMITTER_DATE to produce deterministic commit objects).
>> Can you say more about this?  What is the workflow this is part of?  Can
>> you describe a sequence of steps and how you are affected during those
>> steps?
> I maintain a bleeding-edge variant of a more stable project, which is
> constantly being rebased on the latest stable version.
This looks to have a strong similarity to the Git-for-Windows patches 
which are regularly rebased on top of this here upstream Git.

Dscho uses the `garden shears` script [1] to help update the patch set, 
in conjunction with the 'updated' --rebase-merges option (replaces the 
deprecated --preserve-merges).

> To make this easier, I
> use a Perl script to generate the bleeding-edge version's git branches:
>      https://github.com/bitcoinknots/assemble-deriv
> It uses GIT_COMMITTER_DATE to ensure that I can repeatedly generate the branch
> until everything merges successfully, without polluting the repository with
> hundreds of merge commits each attempt. (Which would be annoying, since I
> literally never prune.)
>
> Because git's reflog also uses GIT_COMMITTER_DATE, my reflogs (HEAD in
> particular) get polluted with incorrect timestamps during this process.
>
>>> Is there a need to support this override for the reflog?
>> Yes.
>>
>>> Is there any reason it can't be changed to use GIT_REFLOG_* instead?
>> Would a new GIT_REFLOG_* set of envvars that overrides GIT_COMMITTER_*
>> work for you?  If I understand correctly, you could set
>> GIT_REFLOG_NAME and GIT_REFLOG_EMAIL to an appropriate identity, but
>> you wouldn't have a good value to put in GIT_REFLOG_DATE.
>>
>> If GIT_COMMITTER_{NAME,EMAIL} were used when writing reflogs but
>> GIT_COMMITTER_DATE weren't, would that help with your workflow?
> Yes, it's really only GIT_COMMITTER_DATE that's messing me up personally.
> I never use GIT_COMMITTER_{NAME,EMAIL}.

-- 
Philip

[1] https://github.com/git-for-windows/build-extra/blob/master/shears.sh

