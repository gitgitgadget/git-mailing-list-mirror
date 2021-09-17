Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155FFC433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 20:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0D5460F21
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 20:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244125AbhIQUDy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 16:03:54 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62611 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbhIQUDt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 16:03:49 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9B716158346;
        Fri, 17 Sep 2021 16:02:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=CJtH/0QxKseK
        sKzdSNQ4XSSRZxG9VDNjdvGFy11bBNM=; b=pUEm1Dc0r3E1JtV9jNALyxcur3Ug
        DUsImjMoh6X+SJQgNmCCvax/Fl84YWZAlb/piKqq22kIbgURM5HGxGx2XLjNSMpc
        rvsjTyddYs/JAq0THdmPXM55ipF7Q5ifSx85raA9XNYW25YFGqGBwO/3L7ZlGVMO
        3ZrHcVJljJMEAtA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 945DA158345;
        Fri, 17 Sep 2021 16:02:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 05D61158344;
        Fri, 17 Sep 2021 16:02:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [QUESTION] How to add new configuration variable
References: <9f3cc3f0-36db-f7e5-de1d-2c8c9f246884@gmail.com>
        <20210917134318.scdqa6k4swzgo5k2@meerkat.local>
        <YUSyNqd51euzvt8N@danh.dev>
Date:   Fri, 17 Sep 2021 13:02:22 -0700
In-Reply-To: <YUSyNqd51euzvt8N@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcuG6p24g?=
 =?utf-8?B?Q8O0bmc=?= Danh"'s message of
        "Fri, 17 Sep 2021 22:20:43 +0700")
Message-ID: <xmqqilyzgecx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2CA83558-17F2-11EC-AE32-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> On 2021-09-17 09:43:18-0400, Konstantin Ryabitsev <konstantin@linuxfoun=
dation.org> wrote:
>> On Fri, Sep 17, 2021 at 05:44:42PM +0700, Bagas Sanjaya wrote:
>> > Supposed that I'm writing git-foobar script ("git-foobar.sh"), which=
 takes
>> > configuration variable "foobar.something" (string type).
>> >=20
>> > How can I add that configuration variable so that it can be used by =
the
>> > script?
>>=20
>> You can just add it. :) Git doesn't complain when it finds configurati=
on
>> parameters it doesn't know anything about, it just ignores them.
>>=20
>> E.g. in your .gitconfig or individual repository .git/config:
>>=20
>>     [foobar]
>>         something =3D yourvalue
>
> Or just:
>
> 	git config [--global] foobar.something yourvalue

In addition to that, unless it is a script for your throw-away use
that we do not have to worry about, consider if the users of "git
foobar" needs to override a configured value with --no-something or
--something=3Danothervalue from the command line, and if so, make sure
these command line options are available to them.
