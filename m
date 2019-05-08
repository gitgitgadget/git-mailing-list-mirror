Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D9BA1F45F
	for <e@80x24.org>; Wed,  8 May 2019 01:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfEHBpp (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 21:45:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65252 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfEHBpp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 21:45:45 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 04C8414E365;
        Tue,  7 May 2019 21:45:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=daNQatKGQj56
        WJiVPZT2odyx55s=; b=Rupng42gC331sc0wZaTLncoHdpzhhhnkGzBApjHAlayp
        z27I7f9bZtpqiZkDoT2z6DR6s4icGyyJuV80j0nQYDmHKqlB2zL4VSqYuAM/RzaH
        nG6GFMTvW3Dme7HpfJN+aaA3J/6v/pxLbFbF8Wv/ApAuw29nnApH7dXRyR6EjFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=lDsaQ0
        xad2mmE7M9rY/fjMlqee/kAwM2RcX/hMJE4CCw/DKgP25yUXbHlSo7G0aMNwes57
        PKpjVRGYZ+Oec0rF+jJwAU5ImGy9EX1xQPbcdVmPj0K+vhOm36aWBmm3aui2VuTO
        qChVuUJ9ntOHHiZRV541ZqdPLVBGm7ATPZh0E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EF50C14E364;
        Tue,  7 May 2019 21:45:42 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 625F014E363;
        Tue,  7 May 2019 21:45:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/7] teach branch-specific options for format-patch
References: <cover.1557072929.git.liu.denton@gmail.com>
        <xmqq4l66myn3.fsf@gitster-ct.c.googlers.com>
        <20190507141942.GA359@archbookpro.localdomain>
        <xmqq36lql2yg.fsf@gitster-ct.c.googlers.com>
        <20190507152118.GA12057@archbookpro.localdomain>
        <87tve6gtcp.fsf@evledraar.gmail.com>
Date:   Wed, 08 May 2019 10:45:41 +0900
In-Reply-To: <87tve6gtcp.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 07 May 2019 17:46:46 +0200")
Message-ID: <xmqqh8a5k9bu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FD575A3A-7132-11E9-BC9F-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> This may just be more insanity to implement right now, but perhaps in
> addition to "gitdir:" etc. in the IncludeIf config syntax we'd want to
> aim for "HEADref" (or some saner name). I.e. allowing to include/enable
> arbitrary config based on the ref name.
>
> Chicken & egg problems though...

The saner name might be

    [IncludeIf "onBranch:my-topic"] path =3D ...

Would we discard the section when "branch -d my-topic" is done, or
would we keep it for the next creation of the branch with the same
name?
