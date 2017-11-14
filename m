Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 042FD201C2
	for <e@80x24.org>; Tue, 14 Nov 2017 06:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751605AbdKNGRB (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 01:17:01 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59972 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750790AbdKNGRA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 01:17:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A4513AF274;
        Tue, 14 Nov 2017 01:16:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8877T+7cdsU24Ds6rBEHPgDHU8Y=; b=cmXfQr
        lOXz4ZL1hCrYdue+JQvHuHQ92/sf+XTzclXvzaqTOJLg8l2ZnHb8Hj+0vW79kjfc
        j3CU8LAiJpVcDZRYIeNG8D4p5IBAk6XiW8jyANE4hjmbGfvkUJ6I04ayzABZDeY3
        qjvmTemCMDbr6Nmah0RDs/9ZWuN5AwyYkX0nw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A+mjc4r4JA5XVbZBOtyU/GW0i1gQBJkI
        G3qDLPY95T0Ns2Wv98QlnvsVjPVRJzeJE0heGP0znkR9PVTWeC8IPTHDaorGe4Fg
        N+D3lBFH1oq/xC20sXcxN34lpikpt09vQXvOYXFa7rNTo19q1VkCePtPdDhl1V19
        DphxdNPWKbc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9AF26AF273;
        Tue, 14 Nov 2017 01:16:59 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 20083AF271;
        Tue, 14 Nov 2017 01:16:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2017, #04; Tue, 14)
References: <xmqqo9o55xny.fsf@gitster.mtv.corp.google.com>
        <5fce2d3b-c8a9-765f-46e6-a2bebcac875e@gmail.com>
Date:   Tue, 14 Nov 2017 15:16:58 +0900
In-Reply-To: <5fce2d3b-c8a9-765f-46e6-a2bebcac875e@gmail.com> (Kaartic
        Sivaraam's message of "Tue, 14 Nov 2017 11:12:51 +0530")
Message-ID: <xmqq375h4c6d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6BF5E800-C903-11E7-BA9C-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

>> * jc/branch-name-sanity (2017-10-14) 3 commits
>>  - branch: forbid refs/heads/HEAD
>>  - branch: split validate_new_branchname() into two
>>  - branch: streamline "attr_only" handling in validate_new_branchname()
>>
>>  "git branch" and "git checkout -b" are now forbidden from creating
>>  a branch whose name is "HEAD".
>>
>>  Reported to cause problems when renaming HEAD during a rebase.
>>  cf. <49563f7c-354e-334e-03a6-c3a40884b6d0@gmail.com>
>
>
> Just wanted to note this explicitly. As I'm not aware how the problem
> with above series is going to be resolved, I've decided to stall the
> v4 of my series that tries to improve error messages shown when
> renaming the branch[1] until this problem gets resolved. I'm doing
> this as this series and my series touch the same code
> paths. Furthermore, I based my v3 off of 'next' when this series was
> in there.
>
> I'm not sure if the resolution to the problem might introduce
> conflicts with my series. Hence the stall.

It is not like the original author of a series _owns_ the code; it
is open source after all.  So if you are inclined to, you are
welcome to fix it up or rewrite it, if somebody else's series that
is not actively being worked on needs updating before you can
continue your work.

