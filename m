Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969CCC00A89
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 17:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16F1F2076D
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 17:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q4acJs8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgJ3RoQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 13:44:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52632 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgJ3RoP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 13:44:15 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9609C87EF2;
        Fri, 30 Oct 2020 13:38:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VUGamEZBvDhlA7I+7Z06FCjBDiU=; b=Q4acJs
        8YX9nF3DYVCFKNzgnvG9X7MW/rmR10tNLCVXPBKNgQofCXJ2UYkHxX7L6y4OUC2K
        ygs6wpFndubE+QBrHjo1X7n9sTi/CAEeJHu7DnQ2BrNpkermIvba+1kphzbxibVI
        4Ml/WQd2uDCyf2GllJM6WyV7yMl6MZ4q64zKI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uKlwQ5/DUT9qN9hB0IR0rsu3c/emYd5s
        Gdp/DGG+u9kXwAZDsWphkBCyLgHsj+V74zeX1hqzpc5zqrHKapCCQO6wj+jMww4I
        DOxUHLpEYB40ElejQg17yzyGaqnLji589UfpdKgFG6+gQr62veqouH20SyC+97Yd
        9EeGWJc+uHg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B5FF87EF1;
        Fri, 30 Oct 2020 13:38:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1944187EF0;
        Fri, 30 Oct 2020 13:38:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Jeff Hostetler <git@jeffhostetler.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 01/19] convert: make convert_attrs() and convert
 structs public
References: <cover.1603937110.git.matheus.bernardino@usp.br>
        <dfc3e0fd62bcf0223dc51485521116e1aca2ee07.1603937110.git.matheus.bernardino@usp.br>
        <xmqq361w4n4x.fsf@gitster.c.googlers.com>
        <CAHd-oW44tFRnpDWsQfF80gZn42mvgwZ0rT-ocQZ92zBTrQL-ZA@mail.gmail.com>
Date:   Fri, 30 Oct 2020 10:38:37 -0700
In-Reply-To: <CAHd-oW44tFRnpDWsQfF80gZn42mvgwZ0rT-ocQZ92zBTrQL-ZA@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Fri, 30 Oct 2020 14:01:11
        -0300")
Message-ID: <xmqqd00z397m.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE32BE90-1AD6-11EB-B736-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

>> > +enum crlf_action {
>> > +     CRLF_UNDEFINED,
>> > +     CRLF_BINARY,
>> > +     CRLF_TEXT,
>> > +     CRLF_TEXT_INPUT,
>> > +     CRLF_TEXT_CRLF,
>> > +     CRLF_AUTO,
>> > +     CRLF_AUTO_INPUT,
>> > +     CRLF_AUTO_CRLF
>> > +};
>> > +
>> > +struct convert_driver;
>> > +
>> > +struct conv_attrs {
>> > +     struct convert_driver *drv;
>> ...
>> > +void convert_attrs(const struct index_state *istate,
>> > +                struct conv_attrs *ca, const char *path);
>> > +
>> >  /*
>> >   * Initialize the checkout metadata with the given values.  Any argument may be
>> >   * NULL if it is not applicable.  The treeish should be a commit if that is
>>
>> The new global symbols are reasonable, I would think, with a
>> possible exception of "crlf_action", which may want to also have
>> "conv" or "convert" somewhere in its name.
>
> OK. Maybe `enum crlf_conv_action`? In this case, should I also change

Either that, or "conv_crlf_action" (or even use the fully spelled
"convert_" as the prefix common to the global symbols from the
subsystem).

> In this case, should I also change
> the prefix of the enum values? I'm not sure if it's worth it, though,
> since there are about 52 occurrences of them.

At the use sites, these constants will be passed to, or compared
with values returned by, the API functions whose names make it clear
that they are from the "convert_" family, so I think it is OK to
leave the values as-is, as long as there is no unrelated symbol
whose name starts with "CRLF_" (and "git grep '^CRLF_'" tells me
that there is not any).

Thanks.
