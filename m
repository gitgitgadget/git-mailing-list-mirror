Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33D8D20281
	for <e@80x24.org>; Mon,  6 Nov 2017 00:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751002AbdKFAiN (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 19:38:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57119 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750819AbdKFAiM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 19:38:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 534E4B3073;
        Sun,  5 Nov 2017 19:38:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=P0jzIilzNUeG
        yhk1ZMKa8bgwVkw=; b=LHZhV1YFuk2Cnwpakh7+B9Q1YUM/WgY1/3mJE5KOLHY1
        G/pBsr8KvjIo1F3HqDeZsqyLHm1Z1uT5NZqhM/HGNov4JqplDCO/kEQM1ZMq4uqw
        Rm0v8LYEoChsbP1/EgpJIdlZdmv6nGcy9zhvtEcByoDy0W/fhe/fmubXPlhF96w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ZlF9ws
        PvIPWGNgxaSa2BRVvfZh6i/J8Pj8S5eUYYfYkV/uektbTnVuUZDfg/Z1dvq9LXw1
        Lljv/mVtNWD4QzZ/ut85GbyPn0r1t2CyOrDVE6k7xLg4GqD4aJvz4ADUZuaxfipq
        gP1ZrQVbV3jPn05trAPk00dFWVm8zgzZ1fwRk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 49869B3072;
        Sun,  5 Nov 2017 19:38:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BDD5EB3071;
        Sun,  5 Nov 2017 19:38:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Antoine =?utf-8?Q?Beaupr=C3=A9?= <anarcat@debian.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 4/7] remote-mediawiki: skip virtual namespaces
References: <20171029160857.29460-2-anarcat@debian.org>
        <20171030025142.19421-1-anarcat@debian.org>
        <20171030025142.19421-5-anarcat@debian.org>
        <CAPig+cSRrXj9BdgM6Q2OdBZtYJOVOnfo4BaG30C-_ug3QunPfQ@mail.gmail.com>
        <87wp3a54nj.fsf@curie.anarc.at>
        <xmqqvaitsc9z.fsf@gitster.mtv.corp.google.com>
        <87375w5qdw.fsf@curie.anarc.at>
Date:   Mon, 06 Nov 2017 09:38:09 +0900
In-Reply-To: <87375w5qdw.fsf@curie.anarc.at> ("Antoine =?utf-8?Q?Beaupr?=
 =?utf-8?Q?=C3=A9=22's?= message of
        "Thu, 02 Nov 2017 17:20:43 -0400")
Message-ID: <xmqqh8u8kzri.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C40378AC-C28A-11E7-8010-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Antoine Beaupr=C3=A9 <anarcat@debian.org> writes:

> On 2017-11-02 10:24:40, Junio C Hamano wrote:
>> Antoine Beaupr=C3=A9 <anarcat@debian.org> writes:
>>
>>> It might still worth fixing this, but I'm not sure what the process i=
s
>>> here - in the latest "what's cooking" Junio said this patchset would =
be
>>> merged in "next". Should I reroll the patchset to fix this or not?
>>
>> The process is for you (the contributor of the topic) to yell at me,
>> "don't merge it yet, there still are updates to come".
>
> YELL! "don't merge it yet, there still are updates to come". :)

Thanks; heard you loud and clear.

>> That message _may_ come to late, in which case we may have to go
>> incremental, but I usually try to leave at least a few days between
>> the time I mark a topic as "will merge" and the time I actually do
>> the merge, for this exact reason.
>
> Awesome, thanks for the update.
>
> i'll roll a v4 with the last tweaks, hopefully that will be the last.

Thanks.
