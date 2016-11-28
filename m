Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6BAC1FBB0
	for <e@80x24.org>; Mon, 28 Nov 2016 16:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932995AbcK1Q4L (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 11:56:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60068 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932406AbcK1Q4K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 11:56:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C121F53541;
        Mon, 28 Nov 2016 11:56:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NSFW7YrHEhcfAmx09GfQi5fPg7E=; b=JqqI6a
        /3TannaQUzYWry0ySljt1asAhrUUd0K0bnI6q/8S9qPzTTFFF/bIAA08DunFnnu1
        bZ0bkvcq3kHGonrBId33AwHSIzi1Qoj0Tl5mHm5xrjGD8qs3qQy5LxeqhV+m/mH+
        XdGdTPOIx2I2n2iRTwinQJ4k717jJYBmfCLmg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iyVqTK2YFvzD7WObTqaldKkeXbKI0Jax
        RqIsajQK2MoQ1SOB2nVFVWtTHovqyktIXI77/jt+LQLlt4i4ZmoHf6APsqo1V3/Y
        G7ndKT1Nv8wKtGwpC0h+Fcr2kIpz9HuMi9PFkMEz9EHLw1EI8NwtU9UEdlnDUCDS
        mb5Jzsg6xmU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B6B8653540;
        Mon, 28 Nov 2016 11:56:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 110E55353F;
        Mon, 28 Nov 2016 11:56:08 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v1 15/19] config: add git_config_get_date_string() from gc.c
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
        <20161023092648.12086-16-chriscool@tuxfamily.org>
        <xmqqziljngod.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD0iToVxU+maNL9BFXacp3sER+AfrqAnQXWf7EAwURKmdQ@mail.gmail.com>
        <xmqqlgwam76c.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD0Q4yTfnhLW6XbfqbxBvMc_QmZTEn4XJb-9fj6Uvq6hkw@mail.gmail.com>
Date:   Mon, 28 Nov 2016 08:56:06 -0800
In-Reply-To: <CAP8UFD0Q4yTfnhLW6XbfqbxBvMc_QmZTEn4XJb-9fj6Uvq6hkw@mail.gmail.com>
        (Christian Couder's message of "Mon, 28 Nov 2016 17:19:17 +0100")
Message-ID: <xmqqeg1vlf15.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8EB7B9FE-B58B-11E6-B47F-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> What about something like this then:
>
> /* This dies if the configured or default date is in the future */
> extern int git_config_get_expiry_or_die(const char *key, const char **output);
>
> Also git_config_get_int(), git_config_get_bool() and probably other
> such functions are indirectly calling git_config_int() which die()s is
> the value is not a number, so it feels a bit strange to have only one
> function with a name that ends with "_or_die" when many other
> functions could die(). In fact it could give a false sense of security
> to those who just read cache.h.

It is half-a-good-point that existing functions would die and I
agree with you that get_expiry_or_die can lose _or_die part.

But get_int() dying when it is fed something that is not "int" (or
something that cannot be returned in "int") is one thing; get_date()
being happy when it is fed a string that is a valid date 2015-01-01
but dying when fed another valid date 2018-01-01 is quite puzzling.

I think get_expiry() is OK.  

Q: What's expiry?  How is it different from date
A: A past timestamp that is speifies the cutoff time for the purpose
   of expiring old stuff.  You can say "now" to expire everything
   you have.

is more pleasant and understandable conversation than

Q: Why can I feed only past date to get_date()?  Otherwise it dies.
A: ...?  The people who named the function didn't know what "date" was?






