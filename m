Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2CA220969
	for <e@80x24.org>; Thu, 30 Mar 2017 20:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754669AbdC3UoO (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 16:44:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61165 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754435AbdC3UoN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 16:44:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 13CCB6EF41;
        Thu, 30 Mar 2017 16:44:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jw5hi3WIQIn1E0w8JaE001BBiro=; b=Vwmyab
        wiCr059GdIAeZghtsGvszFOg+X5S1WraBVLz8Ql7p9Wi0W/lA4dKWuPcXh6WSMfI
        opSsGcleIKBBcv1tTdRaGa17CQGjIMplFzOEpmBYEiIJz7JWDF27Yu9wrmNfBdlx
        3i4XXfNb6ZKdLpUN8T/uL8fkpPjKxe9IZhmf8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Bnk/M2aRXT45XLstzZbmbTds6pBpHdoZ
        40PaBkCFmxiHxM6TjiYBP1KG0QP3Ee5imK67vd9Vn1VP2yYMN2Gt2raWy0pCQEyH
        Uj4OsaSbmFy2Zhhh9oulwyWvflY2+aQxWy+vvLj0FyKtK/zpuODLBDtRPoWkVfSb
        qHLKJ2+Yk1w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B0A56EF40;
        Thu, 30 Mar 2017 16:44:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5E6706EF3F;
        Thu, 30 Mar 2017 16:44:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 0/2] read-cache: call verify_hdr() in a background thread
References: <20170328190732.59486-1-git@jeffhostetler.com>
        <20170328191628.dprziuhpv7khvocu@sigill.intra.peff.net>
        <35f220df-aa63-b80f-8970-429850202cdd@jeffhostetler.com>
        <20170328195605.xy4pnhy74s6wgwps@sigill.intra.peff.net>
        <xmqqtw6a35qc.fsf@gitster.mtv.corp.google.com>
        <20170330195820.kexvl44x7ncthlcx@sigill.intra.peff.net>
Date:   Thu, 30 Mar 2017 13:44:10 -0700
In-Reply-To: <20170330195820.kexvl44x7ncthlcx@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 30 Mar 2017 15:58:20 -0400")
Message-ID: <xmqqa882336t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A10140C2-1589-11E7-862A-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Still, I'm not sure the extra layer of cache is all that valuable. It
> should be a single hash lookup in the config cache (in an operation that
> otherwise reads the entire index).

OK, let's drop that part, then.
