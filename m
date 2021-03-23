Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D63C433C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 17:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DD216188B
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 17:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCWRND (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 13:13:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58145 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhCWRMh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 13:12:37 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 91828B58CE;
        Tue, 23 Mar 2021 13:12:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UUXBxnzdnuDY
        ggY1u9diitMwTrU=; b=NB0ETdw4sdGdvdMyW9TIi3Wmp0A2bXJxWBzyL1euBPIz
        xXYG4goHnlH/kYFjJFiKDfGrz+Ds51JxeeKkh+Tj4YVNIoa11kFoY2PDG043hMi8
        8wJOT45zJimv7+2UPb8Z9Q+vVgq6jOjsY3yEbra7iVyCJB1QaToXKZ4Z2n2jKl4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=S2HXG5
        +7+Nfmyh1nu5sq5D/5Z09ZO25Qedeu/p8d2l2ttzZveaK1Lj8wf1UvYY1M0BeG0X
        xZZORwbt9/bFKqfL41F6jzxg3XD5LGB5Zx+4SDz4C6cgU9mEVpPp4UIEnTM+wsCj
        Ga6z5Susl8db8c8O9/kccBHidc75RfDvdE2LM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 87AACB58CD;
        Tue, 23 Mar 2021 13:12:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0DF08B58CB;
        Tue, 23 Mar 2021 13:12:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7Ru?= =?utf-8?B?Zw==?= Danh 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v13] [GSOC] commit: add --trailer option
References: <pull.901.v12.git.1616247681211.gitgitgadget@gmail.com>
        <pull.901.v13.git.1616387093662.gitgitgadget@gmail.com>
        <CAP8UFD0rtX0m+fGcvGFtsFFKZ2LVyxHx8dptYFvM9kWnbxEwFA@mail.gmail.com>
        <CAOLTT8Ty5kabU6ivX946=FDWJ4SEXBzPinq2aG5t7Rp9jCCEPA@mail.gmail.com>
        <CAP8UFD3fYTc8=y+kru-mN5KmTsnqc6X8mf14VtyWf1Nj9CJ1EQ@mail.gmail.com>
        <xmqqv99i4ck2.fsf@gitster.g>
        <CAOLTT8TKqDWnu3k1Xz=qBhmdZYFhM452WzVGG=OArgJL3z0yGQ@mail.gmail.com>
Date:   Tue, 23 Mar 2021 10:12:35 -0700
In-Reply-To: <CAOLTT8TKqDWnu3k1Xz=qBhmdZYFhM452WzVGG=OArgJL3z0yGQ@mail.gmail.com>
        (ZheNing Hu's message of "Tue, 23 Mar 2021 18:35:04 +0800")
Message-ID: <xmqqa6qt4wvw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F6A0FC66-8BFA-11EB-8100-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8823=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=882:19=E5=86=99=E9=81=93=EF=BC=9A
>>
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>> > If you want nothing to happen when $ARG isn't set, you can change th=
e
>> > config option to something like:
>> >
>> > $ git config trailer.sign.command "NAME=3D'\$ARG'; test -n \"\$NAME\=
" &&
>> > git log --author=3D\"\$NAME\" -1 --format=3D'format:%aN <%aE>' || tr=
ue"
>> >
>> > (This is because it looks like $ARG is replaced only once with the
>> > actual value, which is perhaps a bug. Otherwise something like the
>> > following might work:
>>
>> I do not know the origin of that code in trailers.c but it feels
>> quite confused and error prone to use textual replacement with
>> strbuf_replace().  Why doesn't the code, which knows it will use
>> shell to execute the command line given by the end user in the
>> configuration, to just export ARG as an environment variable and
>> be done with it?  It would also avoid quoting problem etc.
>>
>
> Maybe like this?

Code is not an important part.  We should think through
ramifications of making (and not making) such a change first.
