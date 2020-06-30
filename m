Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E64CC433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19A3620663
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fE4FKi2V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389770AbgF3Pva (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:51:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58199 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389506AbgF3Pva (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 11:51:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 865D17A9DD;
        Tue, 30 Jun 2020 11:51:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1a8PE6A0gP7cQLjb7ldTZjWfA/Y=; b=fE4FKi
        2VJQyxI4ghvmJzZU5fAHIg2zVPExRR9wWUTvLTkAxwm0CKhezmuTt2D3cXHta31C
        v7D7rMNagG9WaJZvQJ5FYFeyl/V58RSQ4cnim5c2LGLvFRz/lQf4vhvUgmyN/opL
        Q4ddeq2eINjrsLZX7UKopD0i47donXN7USgrM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o0F08owWTUL6DbexsPxzrprmH6J7BL1b
        MrMi0lRdPTJwNa9YfFtt/HIf7NoG0M7dLLpVMx3Bl9VuGF+ycw43fb/Hta0FRoFo
        Ae6kEyEbDq/eGjvVJr6kcC2THkepnHSN8N+ZvoPrO2KGaDZpfxkqAfRD+uWqbg45
        c0AMjXRg4+Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D6D47A9DC;
        Tue, 30 Jun 2020 11:51:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 068907A9DB;
        Tue, 30 Jun 2020 11:51:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     sunlin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sunlin <sunlin7@yahoo.com>,
        "lin.sun" <lin.sun@zoom.us>
Subject: Re: [PATCH v3] Enable auto-merge for meld to follow the vim-diff beharior
References: <pull.781.v2.git.git.1591672753363.gitgitgadget@gmail.com>
        <pull.781.v3.git.git.1593414441313.gitgitgadget@gmail.com>
        <xmqqeepxfmdm.fsf@gitster.c.googlers.com>
        <20200630074204.GA2144485@gmail.com>
Date:   Tue, 30 Jun 2020 08:51:25 -0700
In-Reply-To: <20200630074204.GA2144485@gmail.com> (David Aguilar's message of
        "Tue, 30 Jun 2020 00:42:04 -0700")
Message-ID: <xmqq1rlwft6q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8DFB69C2-BAE9-11EA-AD3C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> On Mon, Jun 29, 2020 at 05:06:13PM -0700, Junio C Hamano wrote:
> ...
>> I guess what I am trying to get at is, if --auto-merge is an optional
>> and non-default behaviour for "meld" users, perhaps it is not a good
>> idea to change the behaviour on them only because the version of meld
>> they run happens to support the --auto-merge as an optional behaviour.
>> 
>> IOW, wouldn't it make more sense, and certainly make it safer
>> without surprises to existing users, if we made the logic to
>> 
>>     * If mergetool.meld.useAutoMerge is not set, do not pass
>>       --auto-merge whether "meld" supports the option or not.
>> 
>>     * If mergetool.meld.useAutoMerge is 'true', always pass it
>>       without checking.
>> 
>>     * If mergetool.meld.useAutoMerge is 'when-able' (or come up with
>>       a better name if you want, perhaps 'auto'), check if "meld"
>>       accepts "--auto-merge" and decide whether to pass it or not.
>> 
>> perhaps?
>
> I like the idea of having it be auto/true/false, and perhaps "auto"
> would be a sensible default if more users benefit from it than not.

The principle I've stuck to running this project for the past years
is to avoid hurting 1 user more than trying to please 10 others.  As
I do not use meld regularly myself, I do not know if there are use
cases that are helped by the fact that "--auto-merge" is not the
default behaviour among "meld" users (not limited to "users of
mergetool with meld backend").  And if there are, suddenly changing
the behaviour to those who have happily been using mergetool with
meld backend that does not "--auto-merge" can be disservice to our
users.  Until I hear something along the lines of "Even though meld
requires --auto-merge from users merely due to historical reasons,
these days everybody hates the fact that it is not the default", I'd
recommend against making 'auto' the default on our side, just to be
safe, even if our intuition is that majority of users may want the
"--auto-merge" behaviour.

But I am not a user of mergetool with meld backend, so...

Thanks.
