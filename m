Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10334C80D20
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A0824718
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C4gteJ3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfLMTCv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 14:02:51 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52734 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbfLMTCv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 14:02:51 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6DE85A777A;
        Fri, 13 Dec 2019 14:02:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GN3eb7tNE5xHn73l84d+aGb20+k=; b=C4gteJ
        3qporUwbyaRE67U1qkshHutUh3kFpvtPBxGmJrAShJE8F7okuytZxD+OQxb3OTef
        a3QkAnFxVM2S5pXaUPidSgnIvr+BhDNSKwFxMyZVOnwyQs5tHjhK8qY1zsX7sc6I
        1fg7bW/YR9evqC08ihebMWlDZQZx6TjvBdU1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iTGT87OR2fXDkE06QVRvYDl6f+WUty02
        6nSORvV/dTfHm4jR+EFWlmpSzEa/AfH2cy7KrweXJ4h2MAr2I+VnVHebWDAp+Q7E
        FkartEoC+5D1shRFQyXUnGN4WxHsUyp5kkEr4buq0h8lwEHcfFEpPu3V2Ow1TW4x
        zOCjbcBxj5g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 65676A7779;
        Fri, 13 Dec 2019 14:02:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 853DFA7777;
        Fri, 13 Dec 2019 14:02:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ed Maste <emaste@freebsd.org>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2019, #01; Mon, 2)
References: <xmqqpnh6yfrl.fsf@gitster-ct.c.googlers.com>
        <CAPyFy2At-OjdKusxr9FaZmncjrBKWrVjs5REV0PeHtQFcYy8Ew@mail.gmail.com>
        <CAPyFy2BuWJJzC7F=H2KGgwANYdMNjisJ0ozK6VNqXui3=-=bBw@mail.gmail.com>
Date:   Fri, 13 Dec 2019 11:02:44 -0800
In-Reply-To: <CAPyFy2BuWJJzC7F=H2KGgwANYdMNjisJ0ozK6VNqXui3=-=bBw@mail.gmail.com>
        (Ed Maste's message of "Fri, 13 Dec 2019 08:58:34 -0500")
Message-ID: <xmqq1rt8kq0b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2649782E-1DDB-11EA-89C0-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ed Maste <emaste@freebsd.org> writes:

> On Fri, 13 Dec 2019 at 08:38, Ed Maste <emaste@freebsd.org> wrote:
>>
>> On Mon, 2 Dec 2019 at 09:16, Junio C Hamano <gitster@pobox.com> wrote:
>> >
>> > * ln/userdiff-elixir (2019-11-10) 1 commit
>> >   (merged to 'next' on 2019-11-19 at 6318918ba8)
>> >  + userdiff: add Elixir to supported userdiff languages
>>
>> t4018-diff-funcname.sh is failing on FreeBSD with this change,
>> fatal: invalid regular expression:
>> |[@:]?[a-zA-Z0-9@_?!]+|[-+]?0[xob][0-9a-fA-F]+|[-+]?[0-9][0-9_.]*([eE][-+]?[0-9_]+)?|:?(\+\+|--|\.\.|~~~|<>|\^\^\^|<?\|>|<<<?|>?>>|<<?~|~>?>|<~>|<=|>=|===?|!==?|=~|&&&?|\|\|\|?|=>|<-|\\\\|->)|:?%[A-Za-z0-9_.]\{\}?|[^[:space:]]|[<C0>-<FF>][<80>-<BF>]+
>
> There was an empty subexpression in the first regex; just sent a patch
> to fix it.

Thanks.

