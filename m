Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D467C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 23:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C890920774
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 23:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ofAVZQVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbgCZX1X (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 19:27:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59056 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbgCZX1W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 19:27:22 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5836BCAE6A;
        Thu, 26 Mar 2020 19:27:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NzC0zP/6uHHECf8FIYL0+OgITWM=; b=ofAVZQ
        Vt+uHtOre4dCz+4/lALoOEs64YSvCAD4yMvRcQw4uwCb5FK1xJA6holpBm+eKpTl
        ptwXXwMdggMYisGT1O8r5NpbvQRXl115vh4KA3IPqbYVVJwNVSUoZFNS9pZ+lpvv
        r3jPlqx7KkwFcz9UE/aSXS2mgNiCg/cIAoWg8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OH4LZ6KgZg1EIqgKk+q4AoYPJkgrOmwB
        0NM93ja1c2n6FnZf//KU43XQONhRfYXQ6i66JhqYSid3Eay8WPpsTyH5vnwOhA/r
        RiCrOoLOh2NW/Kz/+m/bt6aA2HJ3j7zdqZv7CCqt6d/kFVhyhiefF8rSJUlKBC+n
        k40UF39reS4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4D269CAE69;
        Thu, 26 Mar 2020 19:27:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 972F8CAE66;
        Thu, 26 Mar 2020 19:27:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        William Baker <William.Baker@microsoft.com>,
        Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: Re: [PATCH v4 1/1] midx.c: fix an integer overflow
References: <20200326213534.399377-1-damien.olivier.robert+git@gmail.com>
Date:   Thu, 26 Mar 2020 16:27:16 -0700
In-Reply-To: <20200326213534.399377-1-damien.olivier.robert+git@gmail.com>
        (Damien Robert's message of "Thu, 26 Mar 2020 22:35:34 +0100")
Message-ID: <xmqqbloiitnv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 55BDCD00-6FB9-11EA-8057-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Damien Robert <damien.olivier.robert@gmail.com> writes:

> When verifying a midx index with 0 objects, the
>     m->num_objects - 1
> overflows to 4294967295.

I think this is underflow & wraparound, but I'll let it pass ;-)

The patch looks good; will queue.

Thanks.
