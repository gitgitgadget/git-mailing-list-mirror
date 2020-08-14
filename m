Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B95C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9052C20771
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qs0OEO9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgHNUnL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:43:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57674 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgHNUnL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 16:43:11 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B795806F6;
        Fri, 14 Aug 2020 16:43:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=X2KWwNVovGpU
        Zf4ykRF5iV4lHrY=; b=qs0OEO9x4nRIlIJn8vKpCwZ1LMUTTKrGxQs/2872WXES
        Xj99CuivhXlzEEu8XckrU9zxYXVRnOwtOI9K2XSyXXCBHN6WHatccC6uXPeOpPbF
        XMPboV3NTv6wbGjeEYg3OmmALX+6QlOgPFYoyInq9qz9bNg+DIy91jLGUazs9KQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=lX+W95
        Y99bARictdoCA6BwjkmTiCF43CEKGd9VqtnzmtLh0JwLDD0ms7p0jxSq+kwOwpc9
        iz/PwLSYhr0GYDiK+6DleoN/mRoQhN91ZhIRwg5f69ToGmdoW45TBCffRu4lNXqA
        0lCdPlf7ycRCSi+lICVRm/7n8rbtgAPdE0VoY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 734BB806F5;
        Fri, 14 Aug 2020 16:43:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F08F3806F4;
        Fri, 14 Aug 2020 16:43:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/5] protocol-capabilities.txt: clarify "allow-x-sha1-in-want" re SHA-256
References: <20200813224901.2652387-1-sandals@crustytoothpaste.net>
        <cover.1597406877.git.martin.agren@gmail.com>
        <13798dfb121c9631e9d811f5f74f9a78c1fcfdf9.1597406877.git.martin.agren@gmail.com>
        <xmqqft8pxhd9.fsf@gitster.c.googlers.com>
        <CAN0heSpv5L67hYSX44LkwQ1pJ+_px_W=FQ4piXKS1anpMi0n2w@mail.gmail.com>
Date:   Fri, 14 Aug 2020 13:43:08 -0700
In-Reply-To: <CAN0heSpv5L67hYSX44LkwQ1pJ+_px_W=FQ4piXKS1anpMi0n2w@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Fri, 14 Aug 2020 22:35:10
 +0200")
Message-ID: <xmqqk0y1uffn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C3263B60-DE6E-11EA-B7ED-01D9BED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

>> I think we should have either a new sha256 capability or a more
>> generic hash-algo capability whose value can be set to sha256.
>> Neither the connection initiators or the acceptors should talk
>> in sha256 until both ends agreed to do so.
>
> I think we should, and I think we do. I haven't dug into the details,
> but "object-format" looks like it's just that.

Ah, Yes, my thinko.

> Maybe instead of SHA-1 and SHA-256, this should talk about "whatever ha=
s
> been negotiated through 'object-format', or SHA-1", similar to brian's
> suggestion elsewhere.

Yup, that would be wonderful.

Thanks.
