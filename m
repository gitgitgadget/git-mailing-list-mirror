Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6479D1F991
	for <e@80x24.org>; Wed,  9 Aug 2017 17:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752615AbdHIRkR (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 13:40:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61592 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752147AbdHIRkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 13:40:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C937694D48;
        Wed,  9 Aug 2017 13:40:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Er5Ryw0Zy4XijINSVg5wRXlAr6I=; b=UgEJRf
        QStSnpA3Vh9Rfj20Vzs8e2rcjm/g8CqlS6v34G36ZzYZ2HuV3JJO+oy8e5/uWPYR
        2GL0grXTH4/X1MNZc5SUktovTBxfMJ+0QABE5kUC/VfyXbEOOwct93wjEH+yIOeb
        3TiS/6VCxElBIu8jchKApa05GAOHoZnQX+iTU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PiJtnuQ+Cc2yhRZ2st+sIRjW7ogmOyRe
        VXsGORqBqvgFxI/UEIaKhCgtTA/nHBSZG+0NMoCH+gkPenND/tg1X1D3VN9Zny8j
        7XNbxEYWQjk0uWBX67tNcFfMrAfZ1ZjIftF3bT9A53pfpm2IhSCVE61CY/LZr3Iz
        2fYwxrIPLIY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C08DA94D47;
        Wed,  9 Aug 2017 13:40:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1777094D44;
        Wed,  9 Aug 2017 13:40:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] http: drop support for curl < 7.16.0
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
        <20170809120157.il4ktf75wscqoyic@sigill.intra.peff.net>
Date:   Wed, 09 Aug 2017 10:40:13 -0700
In-Reply-To: <20170809120157.il4ktf75wscqoyic@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 9 Aug 2017 08:01:57 -0400")
Message-ID: <xmqq1sok7i82.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD640BE2-7D29-11E7-8D30-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> -#if LIBCURL_VERSION_NUM >= 0x071700
> -/* Use CURLOPT_KEYPASSWD as is */
> -#elif LIBCURL_VERSION_NUM >= 0x070903
> -#define CURLOPT_KEYPASSWD CURLOPT_SSLKEYPASSWD
> -#else
> -#define CURLOPT_KEYPASSWD CURLOPT_SSLCERTPASSWD
> -#endif
> -

This part I am not sure.  Don't we still need to substitute
CURLOPT_KEYPASSWD with CURLOPT_SSLKEYPASSWD for versions below
071700, e.g. 071000 which is 7.16.0?
