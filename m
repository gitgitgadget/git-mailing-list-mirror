Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B60BC433E6
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FF9064EDF
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239571AbhCCGlo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 01:41:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50999 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448775AbhCCGfu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 01:35:50 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6857FB8E45;
        Wed,  3 Mar 2021 01:35:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FkFuCBawnLS1
        cAHRTzR6lS0+hY8=; b=al5GaxVo3weaftsRSwpI0OSZm3uQCNMBOPiFNpoirruA
        /HQMBgckhjP1VIr7Vyi+2LyIi+NBB3SIExyJqiA/ZLufy9I8DWMQ430H98WQAm/n
        GFj9mPGEcfwAHhEuJ1PAx+YDWs/c90EOZOA8ohqwPL+jWWj3HEkrD7vnxDFgXFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=A9HSlb
        dkC3mHZTieluKfqvbOmc/xhA9dWsHI0RHYpzGD66rms+sD3zhFmgym3DnAp4crTM
        /y5zHxDK1tXDUTEh34dlUXcI9nFsnptLTS9n9oMmucjUY3DuEV93fQnXNbgK98kp
        I5JkxFb73lTIJg16e2ooqlv32SEWInrljL7qY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D445B8E43;
        Wed,  3 Mar 2021 01:35:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1B2C2B8E42;
        Wed,  3 Mar 2021 01:35:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Benno Evers <benno@bmevers.de>, Jean Privat <jean@pryen.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 04/10] test-lib functions: add an --annotated-tag option
 to "test_commit"
References: <20200223125102.6697-1-benno@bmevers.de>
        <20210228195414.21372-5-avarab@gmail.com>
        <xmqqr1kyo8l8.fsf@gitster.c.googlers.com>
        <87czwhkif6.fsf@evledraar.gmail.com>
Date:   Tue, 02 Mar 2021 22:35:06 -0800
In-Reply-To: <87czwhkif6.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 02 Mar 2021 10:34:53 +0100")
Message-ID: <xmqqmtvklp7p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 983B0F56-7BEA-11EB-9BAE-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Yeah, as noted in the last paragraph of the commit message:
>    =20
>     The placement of --annotated-tag after "notick" in the case of the
>     documentation, and then after "no_tag" in the case of the code is
>     slightly inconsistent. It's to evade a merge conflict with two othe=
r
>     commits adding a --printf option, and another one adding documentat=
ion
>     for --no-tag.
>
> So the existing patch + not doing a bigger refactoring is because I
> didn't want to cause conflicts for you to solve with other in-flight
> topics. It would be easier with ab/pickaxe-pcre2 merged down :)

As things that are not yet in 'master' will not be merged down for a
few weeks anyway, the conflicts don't matter that much---it is a
valid choice not to accept new topics that conflicts with topics
cooking in 'next' after all.  That way, the number of topics that
folks have to look at will not increase, which gives more opportunity
for topics that are already in 'seen' to get reviewed ;-)

