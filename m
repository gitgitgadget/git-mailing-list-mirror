Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E505C202A7
	for <e@80x24.org>; Fri,  7 Jul 2017 15:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751100AbdGGPyJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 11:54:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59152 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751034AbdGGPyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 11:54:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BB3357AF07;
        Fri,  7 Jul 2017 11:54:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=MDTbK7Sg3pSiSFUL6V89Pu/nNeQ=; b=tW/B5V
        YuH8lT95k/P7RwFmsJpfeQbGoNo5x+Yv7hiaiygu0l4QWuWfBpVZEE/PFO4zCW15
        qc5YUBkbXcfxPerc/QEKRZTvDBnLJuJKNROyQEB6jNLmKvWeQfh0SbYAfCqzdTA6
        Fc5Kmk4s0NX3sg1tkyKM0704pJ2615tC6ZmHo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B27087AF05;
        Fri,  7 Jul 2017 11:54:07 -0400 (EDT)
Received: from localhost (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 21A307AF04;
        Fri,  7 Jul 2017 11:54:07 -0400 (EDT)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Sahil Dua <sahildua2305@gmail.com>, Eric Wong <e@80x24.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 6/7] reflog-walk: stop using fake parents
In-Reply-To: <20170707091407.nm4pm3bdvx6alohs@sigill.intra.peff.net>
References: <20170707090507.ko2ygry7j4zv7t3s@sigill.intra.peff.net> <20170707091407.nm4pm3bdvx6alohs@sigill.intra.peff.net>
Date:   Fri, 07 Jul 2017 11:54:05 -0400
Message-ID: <87van48cpu.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8228D944-632C-11E7-9F6E-EFB41968708C-24757444!pb-smtp1.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:references:date:message-id:mime-version:content-type; s=mesmtp; bh=MDTbK7Sg3pSiSFUL6V89Pu/nNeQ=; b=AQxCFDU7/5NidE8zFGyMT+R5zFFwFIjee8xInmOQ+eQdJ5y29razIB8sY0xtp5PIx/H2Gp8uJ/8jmoK1YISjJUopZMt7s6qlObnpXYYy9A3+mOo9M0E1IxmcOyqpKMXakxh3F94hMEXztlyCvafwYCjAxN5DWcluuVUlcDUXE7w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>      Prior to this commit, we show both entries with
>      identical reflog messages. After this commit, we show
>      only the "comes back" entry. See the update in t3200
>      which demonstrates this.
>
>      Arguably either is fine, as the whole double-entry
>      thing is a bit hacky in the first place. And until a
>      recent fix, we truncated the traversal in such a case
>      anyway, which was _definitely_ wrong.

Yeah, I agree that the double-entry thing is a bit hacky and only
showing the "comes back" entry makes sense.

And with this change, I believe that the display of a rename event will
be the same for HEAD's log and the renamed branch's log, despite the
underlying entries having a different representation.

-- 
Kyle
