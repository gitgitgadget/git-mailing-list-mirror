Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9AAC4332B
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 00:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2C0464E17
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 00:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbhAaAFy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 19:05:54 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57748 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbhA3Xst (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 18:48:49 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 74CA31117CC;
        Sat, 30 Jan 2021 18:48:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ILS8WJDHGqv6eiwXuYlpKn+TYvY=; b=aWF00C
        zs0VxZz4bYBGaltGvzCLHl833i4GihqkdEX9H257VPvoozVVl9p31XmZolNYWLgQ
        0u0J4u0AFkWZTn+uE7Kc4eRu+mNXM0JUul888P9MkgR5QPZvpuOY75xIXVE5PeiX
        KwSpnkvENvsDrLm7IlTXRHqHUneLqRf1ffRD0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WNaPrvvlC4/r/dKGyjp7CflMnGgwLmiu
        FPQSPXUQbOvQx7wKyvtNvt62Yi8CwUNGcZrQMOzFeeUX055GRCorplCQZr6aNRrp
        ZaAo/PxsfB8kGCw7aor6dKdbOJq8FyU7bFiXIdg7M3zGr35QTlVS6ibbdsGBmXRs
        vtqWgQ8kLws=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 586CA1117CB;
        Sat, 30 Jan 2021 18:48:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A07861117CA;
        Sat, 30 Jan 2021 18:48:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kyle J. McKay" <mackyle@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 1/2] t/t1417: test symbolic-ref effects on ref logs
References: <7c7e8679f2da7e1475606d698b2da8c@72481c9465c8b2c4aaff8b77ab5e23c>
        <fec7ef37962da584a89012234ae4a1a@72481c9465c8b2c4aaff8b77ab5e23c>
        <xmqqa6sqp827.fsf@gitster.c.googlers.com>
        <028152B6-DA5B-40F7-B944-FF4F31C2BC56@gmail.com>
Date:   Sat, 30 Jan 2021 15:48:01 -0800
In-Reply-To: <028152B6-DA5B-40F7-B944-FF4F31C2BC56@gmail.com> (Kyle J. McKay's
        message of "Sat, 30 Jan 2021 16:02:03 -0700")
Message-ID: <xmqqy2gang0e.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97E615DA-6355-11EB-812D-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kyle J. McKay" <mackyle@gmail.com> writes:

> On Jan 30, 2021, at 11:56, Junio C Hamano wrote:
>
>> The said commit came as part of this topic, ...
>>
>> https://lore.kernel.org/git/pull.669.v2.git.1594401593.gitgitgadget@gmail.com/
>>
>> ... so I've added the true author of it on the Cc: list.
>
> Out of curiosity, if Han-Wen Nienhuys is the true author of commit
> 523fa69c36744ae6 why is it that you are both the committer and author  
> of that commit in the commit's header?

See how the e-mail message was formatted in that thread.  I just ran
"am" on it (which makes me responsible for committing), and the
authorship comes from the "From:" that was in the body.  I suspect
he may have based the patch on some of the "how about doing it like
so" suggestions I made during an earlier discussion and wanted to
give me credit for the input, but I do not remember the context the
patch was originally written in X-<.



