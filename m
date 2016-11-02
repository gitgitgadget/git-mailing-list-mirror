Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CB5620229
	for <e@80x24.org>; Wed,  2 Nov 2016 01:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754155AbcKBBhl (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 21:37:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56235 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751260AbcKBBhk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 21:37:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 77B1D4C45D;
        Tue,  1 Nov 2016 21:37:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KYswXUYUKZxD8yv3PNU9EJNSBCM=; b=n2nNu1
        TKTiMXpVGnkuc7OqwCXJM8S6J2/Ffzt8dGj8cZqw24gBbUpt8aiCXrImt2yio/R9
        IJk27QnNXDzTZ3jRiARfr6VXrOP18HmsOmjPgszcrqdPkEEJlfqTNSfZ0OOYm/em
        SXO42sb97bxn0sO6Og4IR3umgkpPAzaJyVj6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cR1rmaqc+YSPxphUf0yUsl6h9hnfZwPp
        ywDT65wfD1PPu5X3QLKhsx0GDvLa4pYl31yEpQyqpJunsbuaPIcaveZYfYSlERTj
        SRtag6GqUmRaa0ES524Uk2MLKoKm968OnEUIRc2kK1omQ526fQ91ulYdMeTxujT0
        nEkJhhQuwis=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E7BA4C45C;
        Tue,  1 Nov 2016 21:37:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C85654C45B;
        Tue,  1 Nov 2016 21:37:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v1 05/19] update-index: warn in case of split-index incoherency
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
        <20161023092648.12086-6-chriscool@tuxfamily.org>
        <CACsJy8Br2q0aadTFjkNgb=oN8nSzbkWJEK7bCCgr7v-oOZtrSA@mail.gmail.com>
        <xmqqlgx3owbg.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD18gcMJY7zjXw+ry6Kq2Foug9r0e=OVgZ_hcFkEVfnChA@mail.gmail.com>
Date:   Tue, 01 Nov 2016 18:37:37 -0700
In-Reply-To: <CAP8UFD18gcMJY7zjXw+ry6Kq2Foug9r0e=OVgZ_hcFkEVfnChA@mail.gmail.com>
        (Christian Couder's message of "Wed, 2 Nov 2016 00:00:48 +0100")
Message-ID: <xmqqins6mzku.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F057A290-A09C-11E6-9735-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>>> Wrap this string and the one below with _() so they can be translated.
>>
>> True.
>>
>> I further wonder if a natural reaction from users after seeing this
>> message is "I do want to--what else would I use that option to run
>> you for?  Just do as you are told, instead of telling me what to
>> do!".  Is this warning really a good idea, or shouldn't these places
>> be setting the configuration?
>
> In 435ec090ec (config: add core.untrackedCache, 2016-01-27) we decided
> to just use warning() after discussing if we should instead set the
> configuration.

Yeah that seems to be the version that was committed.  I then wonder
if the users would naturally have a similar raction to that warning
as well.
