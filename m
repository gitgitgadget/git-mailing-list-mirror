Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4606FC64E7B
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 22:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC0BE217A0
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 22:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgLBWPH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 17:15:07 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64905 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgLBWPH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 17:15:07 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 26406FE5E4;
        Wed,  2 Dec 2020 17:14:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rgR6WRFz6v80eOv6FnzOaSOEyVA=; b=s3mQGG
        Qi1sRApt6j9b5TAL8pSSm+T2Q5w/0CP9sAmKrAWQ0g/+ic1bOFPVpz4lks7OUyvP
        ffLKLxu/0HOf804al9aGTCzlVH5aMXVkEQvvbRZBxtPwkl0uL/w1Q2kKtFjYp7qQ
        fPczVhZpbLj3TNqqn8oqsNV56VjRNEt31TvMo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bJ5M8qHk+fac/5PhZJ/nT6r6E7IpUgDY
        2DSosmV5NDpBs/9Kt3ezxjhm7b87FMckwpsWk8RSrTe16U1ENd7dktPZdxjRYLG1
        9BMypPnrMCF/WTDiPBWWTlz1aoXQcr5nhWMkeqfB1aWyB/p2+DdwBduqwNTvRns2
        IliGpBUMUX4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1EF84FE5E3;
        Wed,  2 Dec 2020 17:14:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 66669FE5E2;
        Wed,  2 Dec 2020 17:14:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: ds/config-literal-value (was Re: What's cooking in git.git (Nov
 2020, #06; Mon, 30))
References: <xmqqtut6qf7q.fsf@gitster.c.googlers.com>
        <ee7a17a2-25a0-d8c9-f686-4ce3a22616e0@gmail.com>
Date:   Wed, 02 Dec 2020 14:14:20 -0800
In-Reply-To: <ee7a17a2-25a0-d8c9-f686-4ce3a22616e0@gmail.com> (Derrick
        Stolee's message of "Wed, 2 Dec 2020 08:22:58 -0500")
Message-ID: <xmqq5z5jn9dv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB01B6D4-34EB-11EB-8C42-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 12/1/2020 12:15 AM, Junio C Hamano wrote:
>> * ds/config-literal-value (2020-11-25) 8 commits
>>  - config doc: value-pattern is not necessarily a regexp
>>  - config: implement --fixed-value with --get*
>>  - config: plumb --fixed-value into config API
>>  - config: add --fixed-value option, un-implemented
>>  - t1300: add test for --replace-all with value-pattern
>>  - t1300: test "set all" mode with value-pattern
>>  - config: replace 'value_regex' with 'value_pattern'
>>  - config: convert multi_replace to flags
>>  (this branch is used by ds/maintenance-part-3.)
>> 
>>  Various subcommands of "git config" that takes value_regex
>>  learn the "--literal-value" option to take the value_regex option
>>  as a literal string.
>> 
>>  Expecting a (hopefully final) reroll.
>
> Hi Junio,
>
> Did this expectation of a reroll get updated since v3?

The comment is stale, patches are up-to-date.  Sorry for the mixup.

