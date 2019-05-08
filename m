Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 140E31F45F
	for <e@80x24.org>; Wed,  8 May 2019 05:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfEHFth (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 01:49:37 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60055 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbfEHFth (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 01:49:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 745AF598C3;
        Wed,  8 May 2019 01:49:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ve0oWul/p0yvoPlQbJnF502gpIo=; b=UVV2mI
        JxbrPLqjpqW7QhPOu9kTDmf2AEbxWRV/xbwixHF7TXb754BydU/VTUhz/LELU5YW
        kJvp+9Hmnx1SMYwOgITmAj/3oZDNDhb+FmOzsVq44a68H0AkMFxBNrPGDg2R2QmU
        eDTuBdYP2peZcK5OwWFHx0OmjOp3aeGL6PRZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JRyDlOZeB6NIvRb8/z8eCEwiZfGEP1GT
        PP5/Nym5bTFbgoImRsVKD7rg37e5ShByAD9wjqfCGmUoinZ0R8D2ykc2KpCSMNgK
        VasUH575ahA/A4o9vu5v3cI8K1HnwHLK8yxFsKejW2LEvdvLIFaKwF/4NcrYX3yC
        N25LPb2VxGU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 611AF598C2;
        Wed,  8 May 2019 01:49:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 835C75989A;
        Wed,  8 May 2019 01:49:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "LI\, BO XUAN" <liboxuan@connect.hku.hk>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com
Subject: Re: [PATCH v2] t4253-am-keep-cr-dos: avoid using pipes
References: <20190505081633.41157-1-liboxuan@connect.hku.hk>
        <xmqqy33iljo8.fsf@gitster-ct.c.googlers.com>
        <CALM0=-=5WeTJ2-r+u-8TYzOAih_3aCEESSpA4oKhxjRpK2yj6w@mail.gmail.com>
Date:   Wed, 08 May 2019 14:49:30 +0900
In-Reply-To: <CALM0=-=5WeTJ2-r+u-8TYzOAih_3aCEESSpA4oKhxjRpK2yj6w@mail.gmail.com>
        (BO XUAN LI's message of "Tue, 7 May 2019 20:42:45 +0800")
Message-ID: <xmqqv9ylh4wl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D94E454-7155-11E9-AE43-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"LI, BO XUAN" <liboxuan@connect.hku.hk> writes:

> Thanks for your review! I can understand your point, but I've got a
> quick question:
>
> What if format-patch really breaks and 'am' magically does not break?

Doesn't that indicate that you are not testing the result of "am"
adequately?

I am not saying it is *wrong* to split the pipe into two.  I am
merely saying that it is borderline Meh, as the primary point of
these two tests are to see how the command downstream of the pipe
behaves and not the upstream one.
