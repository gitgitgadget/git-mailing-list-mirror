Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD07F1F461
	for <e@80x24.org>; Fri, 19 Jul 2019 19:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfGSTO5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 15:14:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60989 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbfGSTO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 15:14:56 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A116285A22;
        Fri, 19 Jul 2019 15:14:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pneghQJfxpPx
        RasJWw06JWGe7wY=; b=SlaA2ZNknGGl7OBtoxy33u42MWnSAT8khn5CUcBlPKWK
        SHjkcNS/kVePxzxqCDYJ1s4/GI/DSKvrTLc87mSmqsVucCLLRtoKcW30TM84FJzZ
        7GVv9VwSuYNAU5PmfXha5+8h8D1aj+4YAtCj4v/jyqlFfMSQnm+gOlWNNVb9uqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=GnNO3/
        VvahMixJfPRvHp0yDo7MEDR/r4xD0sSEgO8sHKUpzCFRzinVTEyMtNUdZLEe3yjM
        GcqlIoG0auKupjjBkjo+NMzbXbfVKFGXqs7DxdCkr7XeCYOcYLQ1dfklKSAknxl9
        C1PVTS0jjw3HL6tpT7SLpi7XO2sKmfae1oR4U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 990FB85A21;
        Fri, 19 Jul 2019 15:14:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BBF0B85A20;
        Fri, 19 Jul 2019 15:14:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [RFC WIP PATCH v8 00/13] learn --keep-base & more
References: <cover.1555832783.git.liu.denton@gmail.com>
        <20190508001252.15752-1-avarab@gmail.com>
        <xmqqa7fxionx.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 19 Jul 2019 12:14:49 -0700
In-Reply-To: <xmqqa7fxionx.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 08 May 2019 12:57:22 +0900")
Message-ID: <xmqq1rylx2dy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7BD4C01E-AA59-11E9-8F8C-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> This is a WIP series I have that I figured I'd send out as-is for
>> comment since Junio said he'd be merging dl/rebase-i-keep-base down.
>>
>> So I wanted to test it, and as seen early in this series in 3/13 and
>> 4/13 we had significant blindspots in our tests, i.e. there were no
>> tests for whether --no-ff bypassed the amended logic as it should.
>>
>> As seen from those tests we may have some bugs here, either existing
>> or new, needs more poking at it.
>
> Thanks.  I am actually OK to keep dl/rebase-i-keep-base out of
> 'next' to iron out the kinks.  It's not like we are in a hurry to
> deliber an important fix to our users---the topic is adding a new
> feature and attempting to fix a minor irritation (i.e. lost
> opportunity to fast-forward).

The 'next' branch has thinned down sufficiently that it may be a
good time to resurrect topics like this one that we postponed. If
there is (still) interest in them, that is, which I do not know ;-)

