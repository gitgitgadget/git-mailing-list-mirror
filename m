Return-Path: <SRS0=UM1m=AW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1607C433E0
	for <git@archiver.kernel.org>; Sat, 11 Jul 2020 00:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82A66207D0
	for <git@archiver.kernel.org>; Sat, 11 Jul 2020 00:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lERGC0wl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgGKAhS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 20:37:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57580 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbgGKAhS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 20:37:18 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 01AB06D229;
        Fri, 10 Jul 2020 20:37:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WsBEG74d3eFeEPuSaV7Hm7P6X6Q=; b=lERGC0
        wlHNA88YpsqkvdUm3+8ybY4SormT+/2y7n4uIFayxrtoieKk6F0rU+0AmE73EP0k
        eiCMvSbd0zwBxqZtgGGwAT1C35e3wxkJvim0TVhgLxprLSEl1kP58JFbHbvjOcBh
        N5S4Qoy4vanbwXrGkz8zgCPSEPpyFPEb6duqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KlU/qR4MwL3Fz5E08qQzJMnphsrfkX7u
        R5jO0/OFyKUiQY4GXhsRTA7Eto/vIgY7li7Qw2haPZgz7RIQ2+RES2ah8L+t70W0
        MMrIUluXjWJhqxyN3zUfmiSXiCzV34JxhODT86wKRYY5j+THd5uZj0aLcgVCXkvM
        ZpCQ+2IVb/4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DE06C6D228;
        Fri, 10 Jul 2020 20:37:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 537126D227;
        Fri, 10 Jul 2020 20:37:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 00/38] SHA-256, part 3/3
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
        <68cc8fe8-3400-501a-ead5-a9c008605e74@gmail.com>
        <20200710195507.GK9782@camp.crustytoothpaste.net>
Date:   Fri, 10 Jul 2020 17:37:14 -0700
In-Reply-To: <20200710195507.GK9782@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 10 Jul 2020 19:55:07 +0000")
Message-ID: <xmqqr1tirio5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AAF8C8E4-C30E-11EA-9621-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2020-07-10 at 15:14:37, Derrick Stolee wrote:
>> On 7/9/2020 10:46 PM, brian m. carlson wrote:
>> > This is the final part required for the stage 4 implementation of
>> > SHA-256.
>> 
>> WOOHOO! What a milestone!
>
> I'm also excited about this.  It's been a lot of work, but we're finally
> here.

This topic sits at the tip of 'seen' (formerly known as 'pu'), and

    https://travis-ci.org/github/git/git/jobs/707050671

shows that t7063 is broken at the tip of 'seen'.

 - At the tip of this topic, t7063 passes.
 - There is no other topic that touches t7063 in flight.
 - seen^1, i.e. everything other than this topic merged, passes t7063.

Ahh, this is an easy one.  It is an interaction between this one and
the dl/test-must-fail-fixes-6 topic.

There are a few hunks like this in this topic.

-	test_cmp ../expect ../actual
+	test_might_fail test_cmp ../expect ../actual

and the other series tightens test_must/might_fail so that these
test helpers can only be used on "git" (other users should just use
"! cmd" or "cmd || :" instead).

I do not think it was an explicit objective for Denton's series to
catch the use of test_might_fail with test_cmp specifically, but I
offhand do not think of a good use case for saying "expect and
actual may sometimes be the same, but they may be different", so in
that sense, it contributed to find a nonsensical code.  I haven't
read thru all the 38 patches of this series, so there may be an
obvious reason why we may want to have such a thing expressed that I
am missing, though...

Thanks.
