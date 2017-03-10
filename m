Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 763BB1FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 19:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933174AbdCJTiR (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 14:38:17 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51067 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755351AbdCJTiO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 14:38:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 64927670B2;
        Fri, 10 Mar 2017 14:38:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bcZYpnXDJG0w3RagNQDLetuTqRU=; b=IARohP
        3TXdGaT0CRkM3O6fTw+T5pVIydcdZU8vfHz35LeP8ycFWspijYEt2r0zA2HtikSf
        7+Y26r0GLCBi7BLibZ7+dSBCAAI4PR/3uwdk9RzGfHdpQusTYgW+S6gG/quImRVy
        VhpmO4WxLnE+F0afVjJIo9GDLaqj71ecCZbDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m7lLcYp0TxyT9fXXjQY2QLJ3G6jOP+bn
        NCrDNw3Vzt08sLWw5C0P7orPvpLDXQfZPotN/imY6+2zniK0BzmNluX/aqe4Bm1E
        /CKNYNpffv1fLWpmCOLmozsDOb6xRlyRGpqNFyPsIwl9Sfo4zMooHbHKMyf1H2xe
        pi+vHEZvYi4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B9A3670B0;
        Fri, 10 Mar 2017 14:38:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B3574670AB;
        Fri, 10 Mar 2017 14:38:11 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org,
        markbt@efaref.net, benpeart@microsoft.com, jonathantanmy@google.com
Subject: Re: [PATCH 02/10] pack-objects: add --partial-by-size=n --partial-special
References: <1488994685-37403-1-git-send-email-jeffhost@microsoft.com>
        <1488994685-37403-3-git-send-email-jeffhost@microsoft.com>
        <xmqqh93338s2.fsf@gitster.mtv.corp.google.com>
        <1c38ffbc-e4a2-32e5-d324-506c2111043e@jeffhostetler.com>
        <20170309070438.r5g2h5vlmgzds4kp@sigill.intra.peff.net>
        <20170310175823.GA53198@google.com>
        <20170310180341.bbzukqrj2zlkje2b@sigill.intra.peff.net>
Date:   Fri, 10 Mar 2017 11:38:10 -0800
In-Reply-To: <20170310180341.bbzukqrj2zlkje2b@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 10 Mar 2017 13:03:41 -0500")
Message-ID: <xmqqzigsylb1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 18A55120-05C9-11E7-BCBB-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think we ended up deciding that it would be better to just disallow
> symlink .gitattributes (and .git*) from entering the index, the way we
> disallow ".git".

Hmph, I thought we would need both, though.  Or do we specifically
want to honor untracked .gitattributes that is left as a symlink
pointing to elsewhere in the filesystem or something like that?

