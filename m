Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C169C4743E
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 01:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0533360698
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 01:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhFGBDE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Jun 2021 21:03:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61284 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhFGBDE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jun 2021 21:03:04 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B668CBA2E;
        Sun,  6 Jun 2021 21:01:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vX6dA8sUrRb6
        DWj4DMLChe69B4+SL7anHY8Hz4kduFQ=; b=DJksBf0qhRQHYtW0/hqy2kfCua8i
        nJ17z1vGyuvea+gxIdxwL35P9LTFsObHtC6YBcTh9MYmTbg2wPR61jdAfqkmYeHK
        mLqCEOzFKYbne1xZZ7U8DMUdLYZ5copo5xMnu0KLKB5rO/2xpY0O/55akyAQ+kIM
        LZXoauVld5Jd7XY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 51B19CBA2D;
        Sun,  6 Jun 2021 21:01:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C1FCDCBA2C;
        Sun,  6 Jun 2021 21:01:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <ttaylorr@github.com>,
        Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3] t: use pre-defined utf-8 locale for testing svn
References: <20210602114646.17463-1-congdanhqx@gmail.com>
        <20210607004838.15235-1-congdanhqx@gmail.com>
Date:   Mon, 07 Jun 2021 10:01:12 +0900
In-Reply-To: <20210607004838.15235-1-congdanhqx@gmail.com> (=?utf-8?B?IsSQ?=
 =?utf-8?B?b8OgbiBUcuG6p24gQ8O0bmc=?=
        Danh"'s message of "Mon, 7 Jun 2021 07:48:38 +0700")
Message-ID: <xmqqk0n6wkrr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DA7D480C-C72B-11EB-A429-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> Subject: Re: [PATCH v3] t: use pre-defined utf-8 locale for testing svn

That certainly is better than "user-specific", but a lot worse than
"user-specified".  "pre-defined" leaves it open to question "who
defines it?", and it is a reasonable interpretation that the locale
may be hardcoded in the makefile, but that is not what this patch
does.  Saying "user-specified" would not have such a problem.

>> I kind of wonder if trying "C.UTF-8" would be a reasonable fallback so
>> that people don't even have to set this extra Makefile knob. But I'm n=
ot
>> sure if we have a good way of testing if that locale works (if we can'=
t
>> find the "locale" binary).
>
> I also think we should fallback to "C.UTF-8" instead of not testing tho=
se
> tests.  However, I don't know if there're any systems that not have "C.=
UTF-8"
> locale.

I do share the feeling, but have a hunch that systems lacking
"locale -a" may be either superset of, or has at least large overlap
with, those lacking "C.UTF-8", and the new mechanism introduced here
will cover both of them, so I think it is OK to stop here, at least
for now.

Thanks.
