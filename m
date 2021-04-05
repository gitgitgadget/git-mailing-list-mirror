Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067FEC433B4
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 17:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA38961399
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 17:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238800AbhDERoC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 13:44:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61864 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbhDERoC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 13:44:02 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 578B41229BA;
        Mon,  5 Apr 2021 13:43:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Elihsf2BFyVCe+jDQbJandfbUcU=; b=Ee0/03
        4v8a09+ykLD3wy+zAihssUIACUyOVL3HT4VD5u+8Sx9+9q9+ktFYpmZUi7d/Tu9B
        2dpfnw+zR0q5YK2HTnli7pBe7K5i9ctIswAqTTW8kBITZcoHY/E1KlMohfzpczVF
        /7v9LEo0doUQVeQocvCyGbGAZMP6sW0T3rsXo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ltFQtVlulf12w8n/ZG+HjWAJDjfXoInO
        0exQNS01YWCeu+X4OiAOqXmc/0ASxZVAvuyaC/OOK/wNi9PDb6QX/JXq55ChYzVX
        OZqAMtXYGDLDjWmN3DaUqOkAZAJZ5YHOLD/1v4xN3TDc3dPjEm2gGftktnnbsN5S
        61/gEOIpkXY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F7211229B9;
        Mon,  5 Apr 2021 13:43:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8251D1229B8;
        Mon,  5 Apr 2021 13:43:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Tom Saeger <tom.saeger@oracle.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/5] test-lib: use exact match for test_subcommand
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
        <2b74889c2a323f03be477ffdf9ff388405779c3b.1617627856.git.gitgitgadget@gmail.com>
        <CAPig+cRaysm=-UcqY4zY5cV0KzAwd+RwzxXN-ZMV0nz=L4_+DA@mail.gmail.com>
Date:   Mon, 05 Apr 2021 10:43:50 -0700
In-Reply-To: <CAPig+cRaysm=-UcqY4zY5cV0KzAwd+RwzxXN-ZMV0nz=L4_+DA@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 5 Apr 2021 13:31:42 -0400")
Message-ID: <xmqq4kgk7hk9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C76DEA6-9636-11EB-99C6-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Apr 5, 2021 at 9:04 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> The use of 'grep' inside test_subcommand uses general patterns, leading
>> to sometimes needing escape characters to avoid incorrect matches.
>> Further, some platforms interpret different glob characters differently.
>
> These are regular expression metacharacters, not glob characters. A
> more general way to say this might be:
>
>     Furthermore, it can be difficult to know which characters need
>     escaping since the actual regular expression language implemented
>     by various `grep`s differs between platforms; for instance, some
>     may employ pure BRE, whereas others a mix of BRE & ERE.
>
>     Sidestep this difficulty by using `grep -F`...
>
>> Use 'grep -F' to use an exact match. This requires removing escape
>> characters from existing callers. Luckily, this is only one test that
>> expects refspecs as part of the subcommand.
>>
>> Reported-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>
> The Reported-by: feels a bit unusual in this context. Perhaps
> Helped-by: would be more appropriate.
>
>> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
>> @@ -142,8 +142,8 @@ test_expect_success 'prefetch multiple remotes' '
>> -       test_subcommand git fetch remote1 $fetchargs +refs/heads/\\*:refs/prefetch/remote1/\\* <run-prefetch.txt &&
>> -       test_subcommand git fetch remote2 $fetchargs +refs/heads/\\*:refs/prefetch/remote2/\\* <run-prefetch.txt &&
>> +       test_subcommand git fetch remote1 $fetchargs +refs/heads/*:refs/prefetch/remote1/* <run-prefetch.txt &&
>> +       test_subcommand git fetch remote2 $fetchargs +refs/heads/*:refs/prefetch/remote2/* <run-prefetch.txt &&
>
> To be really robust and avoid accidental glob expansion (as unlikely
> as it is), you should quote any arguments which contain glob
> metacharacters such as "*" rather than supplying them bare like this.

Yup, just enclose the whole refspec inside dq-pair, like

	test_subcommand git fetch remote2 $fetchargs \
		"+refs/heads/*:refs/prefetch/remote2/*" <run-prefetch.txt &&

would be the easiest to read.

Thanks.
