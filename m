Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59B812095B
	for <e@80x24.org>; Mon, 20 Mar 2017 17:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755745AbdCTRHP (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 13:07:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57133 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755598AbdCTRHK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 13:07:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 393727D314;
        Mon, 20 Mar 2017 13:07:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nT1v/ReShwS4
        3Q4TC+lEFX+45a0=; b=Y13HQcacpLL6ozAB2foGrS3abVEQyp8Es9Qfrmjazaud
        Z+PgD8sNsuUQ9+gvJqIybKTq0dDWskv/yQ1kHSVfEHEBUOx7YsWahR/3Gehjn3si
        WofugJAgdWie6XosUYq3z+RjUlx5XD/6yZO0Fbnn64GRwjbwFVBsNZ/V5t28HIY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=glQEdV
        TChn+3Qh2H6hoksdmgAgUfJjclXFpFlAChXoaRx/bTGwkY5TQfhXqWYPJa7FaBZO
        3Pp9GdOtekVoI1GmcCKa1veZURqyrh03m83dXza2q5adesSKCbsOSc1KhSgAixBe
        Yll5cZOEXCNfx7VvyShj5D8EBfs0A863eHL3c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B4F17D313;
        Mon, 20 Mar 2017 13:07:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 540D27D311;
        Mon, 20 Mar 2017 13:07:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCH 3/8] tag: Change  misleading --list <pattern> documentation
References: <20170318103256.27141-1-avarab@gmail.com>
        <20170318103256.27141-4-avarab@gmail.com>
        <xmqqmvci2zoc.fsf@gitster.mtv.corp.google.com>
        <20170320034443.wq2uf4yabsxh2nji@sigill.intra.peff.net>
        <xmqqinn4x7rz.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 20 Mar 2017 10:07:00 -0700
In-Reply-To: <xmqqinn4x7rz.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 20 Mar 2017 08:55:12 -0700")
Message-ID: <xmqqshm7x4gb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A2FF48DA-0D8F-11E7-B89B-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> I think it's expected to work under the usual last-one-wins option
>> parsing. A more subtle case is that:
>>
>>   git tag -l -d foo
>>
>> would override "-l" with "-d". That's reasonable under the same rule a=
s
>> long as the user knows that the two are mode-selectors. I don't think =
we
>> make that explicit in the documentation, though, so perhaps it isn't
>> something users should rely on.
>
> Yup, that is reasonable.

Oops.  I meant "two are mode-selectors and can override with the
usual last one wins rule" was reasonable.  As =C3=86var says, this is an
established practice and may already be documented sufficiently.

