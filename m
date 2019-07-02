Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5C5A1F461
	for <e@80x24.org>; Tue,  2 Jul 2019 17:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfGBRX4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 13:23:56 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59329 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGBRX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 13:23:56 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A643973AEE;
        Tue,  2 Jul 2019 13:23:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JQ00i5mP4BUbErzL3w9+RkZsBXE=; b=HxfDk8
        GJLmWwrhu7yKxOmjbU5eqA8DkFGFkcaGAFx97QRl4S3M/3PQbFmOUxbKMiREi3NZ
        ZhTcxTmWSEg2KK8npzhcL1dsDuizw7gXyDJ4ZIWZsZHjdE2YX32/uxq3h501YBKX
        imjvfwPoVjv4vhvISAKPv1VIcJWlOms7fZRJU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lf9cuV9HJdc/11jfhrRnfNab5q1JMFMc
        DSqHDiS41lv4hG9UCbrr1TO2TtbR0TykA9TWirBSySRA9DGXockpbYtX+KIhTt6r
        qMHG1F6zHDlAGBUBTK2uKLCHgUx36m0TpzP8LX4/3RTVYOSjSLEfaAJl9XHKz2bY
        KpHArff1rXc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9E31D73AED;
        Tue,  2 Jul 2019 13:23:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C9D0973AEB;
        Tue,  2 Jul 2019 13:23:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/1] t3420: remove progress lines before comparing output
References: <pull.276.git.gitgitgadget@gmail.com>
        <52501623f6b47447ce5da283ec11e378413899b7.1561986710.git.gitgitgadget@gmail.com>
        <xmqqimsl5v1u.fsf@gitster-ct.c.googlers.com>
        <2a0a968e-6929-71eb-77cf-ec3ee28fd734@gmail.com>
Date:   Tue, 02 Jul 2019 10:23:49 -0700
In-Reply-To: <2a0a968e-6929-71eb-77cf-ec3ee28fd734@gmail.com> (Phillip Wood's
        message of "Tue, 2 Jul 2019 16:54:08 +0100")
Message-ID: <xmqqmuhw4afu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 292C4490-9CEE-11E9-AC2D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> As long as sed implementation used here does not do anything funny
>> to CR, I think the approach to strip everything before the last CR
>> on the line is sensible.  As I am not familiar with how Windows port
>> of sed wants to treat a CR byte in the pattern, I am not sure about
>> the precondition of the above statement, though.
>
> I wondered about that too, but it passes the CI tests under windows.

Hopefully Git for Windows, MinGW, and CygWin would all behave
similarly.

>> I also have to wonder if we can/want to do this without an extra
>> printf process every time we sanitize the output, though I do not
>> think I care too deeply about it.
>
> I could add 're="$(printf ...)"' to the setup at the top of the file
> if you want

As I do not care too deeply about it, we recently saw a lot about
reducing number of processes in the tests, so apparently some folks
care and I presume they want to see something like that to happen.
I do not think $re is a good name for such a variable, though ;-)
