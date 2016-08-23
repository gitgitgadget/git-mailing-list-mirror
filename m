Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2269B2018E
	for <e@80x24.org>; Tue, 23 Aug 2016 21:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752962AbcHWVqI (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 17:46:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51400 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751710AbcHWVqB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 17:46:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23C4736FF0;
        Tue, 23 Aug 2016 17:45:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Sjz4HXcjrUbWG8h/+fmZkvECKyA=; b=qVMawG
        1s17L7HtnivMO29WyEjsRl5tAkvopdElRivxS3MBEQKU1L/EL9urhg8IicGBTY6H
        voERWKYPStqhvXVkdbud3rOYgAGs1DPdax8Ro0+lRVT333KU36sE9AKFJXCgr7gY
        ifyt4vj66Zmh4VIuuaaCVdzZLdmKHSLB6Qb08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ndbKjIbvhmjcRfXmHZ47EYx5tTbhunxc
        45a+iczTRgfgbs8HaPmK12kWoRnu0DkA4sBA7n8cNdydGdfPNYOstm4a+8T4HykP
        79S0IZlKe1xQ6Ub0gOHSbzmWSQJrgaj4P6fPQr+ZBZ8Ncm0nclPY1watBOwRIPLc
        58xbkC7Fli0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 18F2636FEF;
        Tue, 23 Aug 2016 17:45:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7AA1836FEE;
        Tue, 23 Aug 2016 17:45:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/7] cache_or_unpack_entry: drop keep_cache parameter
References: <20160822215725.qdikfcaz3smhulau@sigill.intra.peff.net>
        <20160822215744.nc3yqv64gf3hwcv4@sigill.intra.peff.net>
Date:   Tue, 23 Aug 2016 14:45:24 -0700
In-Reply-To: <20160822215744.nc3yqv64gf3hwcv4@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 22 Aug 2016 17:57:45 -0400")
Message-ID: <xmqq60qrupl7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E7AC6760-697A-11E6-B3F9-E86612518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> There is only one caller of cache_or_unpack_entry() and it
> always passes 1 for the keep_cache parameter. We can
> simplify it by dropping the "!keep_cache" case.
>
> Another call, which did pass 0, was dropped in abe601b
> (sha1_file: remove recursion in unpack_entry, 2013-03-27),
> as unpack_entry() now does more complicated things than a
> simple unpack when there is a cache miss.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  sha1_file.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)

Makes sense.  Thanks.
