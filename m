Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1209BC433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 19:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E717D61285
	for <git@archiver.kernel.org>; Mon, 17 May 2021 19:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbhEQTpw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 15:45:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54450 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbhEQTpv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 15:45:51 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D330713355C;
        Mon, 17 May 2021 15:44:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WpHfxGehDqQT9B3YmfdRqsb2lBjoKHgRkHQr+2
        X0FJg=; b=GYfvmzLbf59HHLIMyaNzayOjwGu0vMHe5Rkbv1m7qbbHLJasunujk+
        NK4rMn9GhIRLL3ivvckBxfYFznvp/Z6acM3f2sE5puB3Y/I6h07mNBPxN9kUIlQl
        4fGWFI7BhF2zM1LxE5wEDRzHl++k42BlOtVTU7VzO4CxJCl9PshIg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CA18513355B;
        Mon, 17 May 2021 15:44:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0B90813355A;
        Mon, 17 May 2021 15:44:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH v5 8/9] dir: update stale description of treat_directory()
References: <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com>
        <pull.1020.v5.git.git.1620840502.gitgitgadget@gmail.com>
        <179f992edc9254803252ae10e5d692f3755a40f3.1620840502.git.gitgitgadget@gmail.com>
        <bac325b9-8370-601b-a348-a7270df8b824@gmail.com>
Date:   Tue, 18 May 2021 04:44:29 +0900
In-Reply-To: <bac325b9-8370-601b-a348-a7270df8b824@gmail.com> (Derrick
        Stolee's message of "Mon, 17 May 2021 13:20:56 -0400")
Message-ID: <xmqqa6ot6t7m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C4E4286-B748-11EB-B016-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 5/12/2021 1:28 PM, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <stolee@gmail.com>
>> 
>> The documentation comment for treat_directory() was originally written
>> in 095952 (Teach directory traversal about subprojects, 2007-04-11)
>> which was before the 'struct dir_struct' split its bitfield of named
>> options into a 'flags' enum in 7c4c97c0 (Turn the flags in struct
>> dir_struct into a single variable, 2009-02-16). When those flags
>> changed, the comment became stale, since members like
>> 'show_other_directories' transitioned into flags like
>> DIR_SHOW_OTHER_DIRECTORIES.
>> 
>> Update the comments for treat_directory() to use these flag names rather
>> than the old member names.
>> 
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> Reviewed-by: Elijah Newren <newren@gmail.com>
>
> I think you want the "Reviewed-by" before the "Signed-off-by",
> followed by your own sign-off.

Grabbing somebody else's signed-off patch, and forwarding it (with
or without tweaks and enhancements) with your own sign-off would be
a sufficient sign that you've inspected the patch deeply enough to
be confident that it is worth forwarding.  So I think you can even
lose the reviewed-by.

But as long as you are relaying somebody else's patch, DCO asks you
to sign it off yourself.

Thanks.
