Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C33FC25B0C
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 17:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236380AbiHKRNR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 13:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235934AbiHKRMx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 13:12:53 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0515743330
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 09:53:20 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AD4461BF941;
        Thu, 11 Aug 2022 12:53:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=to0LAqmmaRwTJ81J9OVW7ElbI5m/V1WSbXtxk+
        AGHu8=; b=rCLwFYgmeQLgDMpQ4TfqVb0+lTNyjF0SThoV6xzIIdhbhAgWwFk7Uw
        MO4Sfzyc762w52vJik14s38oj7JVSahn+4zz8W+p1Nth6vWtO8tkKM2om8QFz2Ab
        ThKqNJVius8qho9FLe3dnMRSwcXzCahLeN3bD7lR0P+TzgCTA7K90=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A66641BF940;
        Thu, 11 Aug 2022 12:53:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 54E7F1BF93F;
        Thu, 11 Aug 2022 12:53:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v2 2/2] fsmonitor.allowRemote now overrides default
 behavior
References: <pull.1317.git.1660067049965.gitgitgadget@gmail.com>
        <pull.1317.v2.git.1660233432.gitgitgadget@gmail.com>
        <7a071c9e6be68b58306582dbac5952a5b1bcbc6a.1660233432.git.gitgitgadget@gmail.com>
Date:   Thu, 11 Aug 2022 09:53:14 -0700
In-Reply-To: <7a071c9e6be68b58306582dbac5952a5b1bcbc6a.1660233432.git.gitgitgadget@gmail.com>
        (Eric DeCosta via GitGitGadget's message of "Thu, 11 Aug 2022 15:57:12
        +0000")
Message-ID: <xmqqtu6ig1s5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17CFBB78-1996-11ED-836E-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Eric DeCosta <edecosta@mathworks.com>
>
> Reworked the logic around fsmonitor.allowRemote such that if
> allowRemote is set it will determine if monitoring the remote
> worktree is allowed.
>
> Get remote protocoal information; if this fails report an error else
> print it if tracing is enabled.
>
> Fixed fomratting issues.

The end result (i.e. HEAD^{tree} of the branch you developed these
two patches on) may be good (I haven't checked), but it is not how
we fix problems in an earlier attempt in this project by keeping the
faulty commit(s) on the bottom and piling "oops, that was wrong, and
here is a fix-up" commit(s) on top.

Once you are happy with the end result, use "rebase -i" to clean-up
the history leading to that end result.  The goal is to pretend as
if you were a perfect human, more perfect than your actual self, who
came up with an ideal patch without making mistakes that need to be
corrected with "fix-up" commits.  In this particular case, you'd
most likely want to end up with a single commit, so squashing them
together and fixing up the log message might be all you need to do.
When you work on a more elaborate topic, you may also want to split
or reorder original commits to present a logical progression towards
the end result.  "rebase -i" is a good tool to help you do so.

I am not a user of GitGitGadget myself, but if I recall correctly,
you should be able to force-push the result of such a clean-up to
update the pull-request, to trigger a new iteration to be sent to
the list.

Thanks.
