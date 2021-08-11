Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABF1C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 19:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD5C760560
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 19:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhHKTAu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 15:00:50 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57344 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhHKTAt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 15:00:49 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8C21E143018;
        Wed, 11 Aug 2021 15:00:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wPmBKkJvFrEhkSnXtRBXh6pfaaYJRDSOk/g2H7
        p2W1U=; b=XJVnOI7qD8J2PDnu5ODU4q6FK7YBJcXovcr6ZVqJzwTkVqnfA0QltR
        8NnDMXyGfqa48Hu+XVyvPmlHKwQ+AVRD9V/3vjJDg4lJDxrbuS9Z50R5+AKXDbPQ
        rKgPMBfTyru1db7AwGfJmxPPCaOzebOVZCOanVhznYiJolrCi2q6Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8403B143017;
        Wed, 11 Aug 2021 15:00:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CBFD3143016;
        Wed, 11 Aug 2021 15:00:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <novalis@novalis.org>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2021, #04; Tue, 10)
References: <xmqqh7fwbx86.fsf@gitster.g>
        <0C7D8DD1-C26A-4E04-BAAA-A63BF1017142@novalis.org>
Date:   Wed, 11 Aug 2021 12:00:20 -0700
In-Reply-To: <0C7D8DD1-C26A-4E04-BAAA-A63BF1017142@novalis.org> (David
        Turner's message of "Wed, 11 Aug 2021 13:49:08 -0400")
Message-ID: <xmqqk0kr958b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 615F1C3C-FAD6-11EB-A2A8-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <novalis@novalis.org> writes:

> On August 10, 2021 9:12:41 PM EDT, Junio C Hamano <gitster@pobox.com> wrote:
>>Here are the topics that have been cooking in my tree.  
>>...
>>* dt/submodule-diff-fixes (2021-08-02) 3 commits
>> - diff --submodule=diff: Don't print failure message twice
>> - diff --submodule=diff: do not fail on ever-initialied deleted submodules
>> - t4060: remove unused variable
>>
>> "git diff --submodule=diff" showed failure from run_command() when
>> trying to run diff inside a submodule, when the user manually
>> removes the submodule directory.
>>
>> Seems to break CI when merged to 'seen'
>> cf. https://github.com/git/git/runs/3259477809?check_suite_focus=true#step:4:2618
>
> That link says "Merge branch 'fs/ssh-signing' into seen" -- that's not my branch.

That one was for 913a4aa7e46 which had not just fs/ssh-signing but also
dt/submodule-diff-fixes; near its tip there are:

913a4aa7e4 Merge branch 'fs/ssh-signing' into seen
c9787deb45 Merge branch 'ab/only-single-progress-at-once' into seen
a3a4793406 Merge branch 'ab/lib-subtest' into seen
cb170c8941 Merge branch 'jh/builtin-fsmonitor' into seen
4eaca15257 Merge branch 'cf/fetch-set-upstream-while-detached' into seen
fc20552335 Merge branch 'tb/multi-pack-bitmaps' into seen
f6758f313b Merge branch 'dt/submodule-diff-fixes' into seen
c29c5aa324 Merge branch 'ab/make-tags-cleanup' into seen
ca277e7504 Merge branch 'ab/fsck-unexpected-type' into seen
a2c57f0aca Merge branch 'ab/config-based-hooks-base' into seen
f586246edb Merge branch 'ab/serve-cleanup' into seen
f55b1792d9 Merge branch 'es/superproject-aware-submodules' into seen
