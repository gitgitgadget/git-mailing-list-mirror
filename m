Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3C1820A17
	for <e@80x24.org>; Mon, 23 Jan 2017 18:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750945AbdAWSxn (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 13:53:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50009 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750705AbdAWSxm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 13:53:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3660C625B9;
        Mon, 23 Jan 2017 13:53:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9nPupYxSerX5QMSXNBQynmoPvMA=; b=FeQpbv
        N6NjA5laTp/UE9oKil0ONigPJsgr0HSnEOszo2nhJCMSnKV4BEGG9dxavY4Qc/RQ
        JZYoBYK191fZxMAmoAdSlaqnyrm55wjqQErz5Uf6KoSWX1n/Li3Rut2JArAvG8+m
        U0GknqthpdN/mTqXTs1mft+Rbs0AbiNjcz5hw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aXE+FVtCUHL2zJRSW7zaIxfUd+fNqNuF
        4WLY/NdzSWbDEw/NYr2XYvV0a8vcj1MWFkjmcsafLJPWmqd5wqcy8mW1wWHcyuAQ
        waAqJoC0RBdV4m7qA+BMBZPjvOH6dnFldTuwGzcPraIj7mg7qGdAGwrPDY0pbvbm
        gXtjOcnm8Qw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2AF29625B7;
        Mon, 23 Jan 2017 13:53:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5A124625A9;
        Mon, 23 Jan 2017 13:53:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 14/21] read-cache: touch shared index files when used
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
        <20161226102222.17150-15-chriscool@tuxfamily.org>
        <xmqqa8bhb32x.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD1EgOxcPi=tpiosKkYMcCZe+b6gwW0CKt2sE1NZ7gQv=A@mail.gmail.com>
        <xmqqo9zi35n6.fsf@gitster.mtv.corp.google.com>
        <CACsJy8AR6yNr0y+_JZDkW-HO_yHPkUx_6zbLGoviKQBOVcSg5A@mail.gmail.com>
        <xmqqvatouwsh.fsf@gitster.mtv.corp.google.com>
        <CACsJy8B_xe6RtszPrncvDdSYosNUQxvhcEQ3DO_WO0sepXqvvQ@mail.gmail.com>
        <xmqqlgu627uj.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD2LWGtNtdhtQTZXqsACBvK=jD25vt8M4HzBRBVS1sJ+=Q@mail.gmail.com>
Date:   Mon, 23 Jan 2017 10:53:39 -0800
In-Reply-To: <CAP8UFD2LWGtNtdhtQTZXqsACBvK=jD25vt8M4HzBRBVS1sJ+=Q@mail.gmail.com>
        (Christian Couder's message of "Mon, 23 Jan 2017 19:14:11 +0100")
Message-ID: <xmqqefztsj4c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 415932DA-E19D-11E6-B678-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Also in general the split-index mode is useful when you often write
> new indexes, and in this case shared index files that are used will
> often be freshened, so the risk of deleting interesting shared index
> files should be low.
> ...
>> Not that I think freshening would actually fail in a repository
>> where you can actually write into to update the index or its refs to
>> make a difference (iow, even if we make it die() loudly when shared
>> index cannot be "touched" because we are paranoid, no real life
>> usage will trigger that die(), and if a repository does trigger the
>> die(), I think you would really want to know about it).
>
> As I wrote above, I think if we can actually write the shared index
> file but its freshening fails, it probably means that the shared index
> file has been removed behind us, and this case is equivalent as when
> loose files have been removed behind us.

OK, so it is unlikely to happen, and when it happens it leads to a
catastrophic failure---do we just ignore or do we report an error?
