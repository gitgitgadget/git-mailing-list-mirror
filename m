Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13AEA211B4
	for <e@80x24.org>; Thu, 29 Nov 2018 08:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeK2Tr3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 14:47:29 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64722 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbeK2Tr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 14:47:29 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B903D3D1EB;
        Thu, 29 Nov 2018 03:42:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bKNhpNRa47O/npblCvA8BZ2MKu4=; b=wyEC7F
        KnknW1dCT38ThKvtkuV2SRT85/y1nN5OMS7k7mPZo5tbtqUGjFc6H4SyxXMSvzYO
        vqGvxAe4gOeHQW7jTBlaG9V1ZSyT7yeO8UGpJTCyrTS1YXM2SDynmt2DXm2xy0EQ
        oeCppL9FIiAUkHjEi0kZbMnBZjqowGxRvrldU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kjILZkgLUbB7HfTSYcMDd77+DUX4RF1b
        1wHJ9IlFW2ZYRbTNgBPDYFJEketVY08volJyLZUx4WYJYs+XV/WygsZHjuRmW8yK
        cL75dsX4aTDL/Ecv7FLNqMJQZIKKb5nAgLoUsAQzkM4eInu78Xd44Q/2lGXnB+Hc
        LvgywSMzdVI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B188D3D1EA;
        Thu, 29 Nov 2018 03:42:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CAA8D3D1E8;
        Thu, 29 Nov 2018 03:42:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Masaya Suzuki <masayasuzuki@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pack-protocol.txt: accept error packets in any context
References: <20181127045301.103807-1-masayasuzuki@google.com>
Date:   Thu, 29 Nov 2018 17:42:46 +0900
In-Reply-To: <20181127045301.103807-1-masayasuzuki@google.com> (Masaya
        Suzuki's message of "Mon, 26 Nov 2018 20:53:01 -0800")
Message-ID: <xmqqwoowmfzt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C028D100-F3B2-11E8-B772-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Masaya Suzuki <masayasuzuki@google.com> writes:

> In the Git pack protocol definition, an error packet may appear only in
> a certain context. However, servers can face a runtime error (e.g. I/O
> error) at an arbitrary timing. This patch changes the protocol to allow
> an error packet to be sent instead of any packet.
>
> Following this protocol spec change, the error packet handling code is
> moved to pkt-line.c.
>
> Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
> ---

Have you run tests with this applied?  I noticed 5703.9 now has
stale expectations, but there may be others.
