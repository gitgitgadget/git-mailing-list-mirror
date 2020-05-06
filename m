Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDD4C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C72920B1F
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FWJSljvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgEFRTc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 13:19:32 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59890 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgEFRTc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 13:19:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3E5A0CECD6;
        Wed,  6 May 2020 13:19:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JE5rMKoloEhroU7vxq2asy9IeNY=; b=FWJSlj
        vCuX0BKLPksD02LnGziqoY0GNmv08aTZuTrnIUoP2kG+DXzd/8a7XVNf4mqmRyZt
        fI2ZHO9BKc+Q2mjF5NXQDR6isMZARfnYxPOqkXcs1jYYBM17jTBBGfZwS+FtpoN9
        AmIsElhh6bcDBwAhLk+i5uE2hEP2T7Yy2tX1A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O0MBfZFh5/QWMAXAw1e3OlCOJ+zoDX7b
        sB7op3cfLySvez0VBvkHlt67N9wJ1wtBEhUoBytnjdvVvKxJb+ca8vaCLXO1RYRP
        n47cNTci77P7k/9+g5IOYxN604Fy+0T7RQCpA2Sg55z7MEXF+WtkMprjOXRRTVkm
        t1IqNQT9YjM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 35F50CECD5;
        Wed,  6 May 2020 13:19:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6CEFDCECD4;
        Wed,  6 May 2020 13:19:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v6 4/4] gitfaq: fetching and pulling a repository
References: <20200506080023.12521-1-shouryashukla.oo@gmail.com>
        <20200506080023.12521-4-shouryashukla.oo@gmail.com>
        <CABPp-BHurMUPM=NVr7N4Fvx9UccNqi-nQrFH0_vM9a96MjFzog@mail.gmail.com>
Date:   Wed, 06 May 2020 10:19:25 -0700
In-Reply-To: <CABPp-BHurMUPM=NVr7N4Fvx9UccNqi-nQrFH0_vM9a96MjFzog@mail.gmail.com>
        (Elijah Newren's message of "Wed, 6 May 2020 09:20:02 -0700")
Message-ID: <xmqqh7wt6kwy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD3BCB5C-8FBD-11EA-9BF0-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Hi Shourya,
>
> On Wed, May 6, 2020 at 1:00 AM Shourya Shukla
> <shouryashukla.oo@gmail.com> wrote:
>>
>> Add an issue in 'Common Issues' section which addresses the confusion
>> between performing a 'fetch' and a 'pull'.
>>
>> Helped-by: Elijah Newren <newren@gmail.com>
>> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
>> ---
>>  Documentation/gitfaq.txt | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
>> index 5dfbb32089..53e3844374 100644
>> --- a/Documentation/gitfaq.txt
>> +++ b/Documentation/gitfaq.txt
>> @@ -255,6 +255,14 @@ way of cloning it in lesser space?::
>>         presumes that the user has an always-on network connection to the
>>         original repository).  See linkgit:partial-clone[1].
>>
>> +[[fetching-and-pulling]]
>> +How do I know if I want to do a fetch or a pull?::
>> +       A fetch stores a copy of the latest changes from the remote
>> +       repository, without modifying the working tree or current branch.
>> +       You can then at your leisure inspect, merge, rebase on top of, or
>> +       ignore the upstream changes.  A pull consists of a fetch followed
>> +       immediately     by either a merge or rebase.  See linkgit:git-pull[1].
>
> Looks like you have a tab instead of a space between 'immediately' and 'by'.

Good eyes.  Otherwise the contents of this new paragraph looks OK to
me.

There is no "git partial-clone" command, so the reference at the end
of the previous paragraph looks bogus, but that is not a fault of
this step.

Thanks.
