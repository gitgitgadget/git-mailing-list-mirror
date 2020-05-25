Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C11C433DF
	for <git@archiver.kernel.org>; Mon, 25 May 2020 16:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61EB220776
	for <git@archiver.kernel.org>; Mon, 25 May 2020 16:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="M+GXtYDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbgEYQWh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 12:22:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55669 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731228AbgEYQWh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 12:22:37 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E61DA65E37;
        Mon, 25 May 2020 12:22:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iU2ji3VQguueVWMpLey4Si3JtZs=; b=M+GXtY
        DFNP7Ex33lKZQJrdIIJBURHPWoBsomuNCiiSS4SNOJ8YRMg+kMmAKeOBdeZPgHvj
        Tj73t7URaCFRPG1NnE3GsNAvmpTZ5OXMa/7sLydYk6+2ZZjyJL4fL4m4Fw/t99Ww
        YRUAHJW8Om4WXnrNOcVn8Xv4vTOOEusGQK8GE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xO0WCpZbcPgnqNT71zgSB9tMzjdYfBGZ
        Bm44cMXRYa7H/PmNlXVx8pDZv+WI5zINpFOa2NGRNxuAMN+MLLZqf6npslob+BEC
        ET1veCo08oHvpdBgIpTzzuGAVLtHU9Twna/9EluLEJrAgP9ctfZtYcScGEbXYke8
        pWLJXGPO08k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D7E1265E36;
        Mon, 25 May 2020 12:22:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 46B2365E35;
        Mon, 25 May 2020 12:22:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (May 2020, #08; Sun, 24)
References: <xmqqh7w4pulj.fsf@gitster.c.googlers.com>
        <CABPp-BHxeDQS5QXd5Sf6Ws_58-aze_mes3xRvGZYQNWw3Et3VA@mail.gmail.com>
Date:   Mon, 25 May 2020 09:22:33 -0700
In-Reply-To: <CABPp-BHxeDQS5QXd5Sf6Ws_58-aze_mes3xRvGZYQNWw3Et3VA@mail.gmail.com>
        (Elijah Newren's message of "Mon, 25 May 2020 07:55:48 -0700")
Message-ID: <xmqqd06sougm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F0AEAF46-9EA3-11EA-8F68-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Sun, May 24, 2020 at 8:35 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Here are the topics that have been cooking.  Commits prefixed with
>> '-' are only in 'pu' (proposed updates) while commits prefixed with
>> '+' are in 'next'.  The ones marked with '.' do not appear in any of
>> the integration branches, but I am still holding onto them.
>>
>> Git 2.27-rc2 will be tagged soon, but most of the topics planned for
>> it are already in 'master'.
>>
>> You can find the changes described here in the integration branches
>> of the repositories listed at
>>
>>     http://git-blame.blogspot.com/p/git-public-repositories.html
>
> Looks like the scissors docfix at
> https://lore.kernel.org/git/20200522142611.1217757-1-newren@gmail.com/
> may have fallen through the cracks.  It's not important for 2.27, but
> could that be picked up at least for pu?

Indeed, as I do not necessarily scan through messages all the way to
the end, when it is clear that patches are discussed and polished by
capable hands.  I'd simply wait for the next round before jumping in
in such a case, and shift the focus to other topics and/or tasks.

I haven't read the documentation patch yet, and I do not see anybody
else reading it, either, so it probably is outside the scope for the
upcoming release.

Thanks for pinging.
