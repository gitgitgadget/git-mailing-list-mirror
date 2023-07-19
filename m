Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32951C0015E
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 19:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjGSTY5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 15:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjGSTYx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 15:24:53 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06562120
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 12:24:33 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5363C1DAA8;
        Wed, 19 Jul 2023 15:24:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eQhVOA+Gpakg7H28lyrNfZVuqntgzNaBAQRhq5
        RtIF0=; b=I7jW+oc13gkOaloQdZ9QtDbI/vUAYsW0x045QjvowPk9sXyJl/M1vk
        R4LZZv5QR20dD6cPvGhefuaP0I2Vg+AjElctTb64m/G7bP+VJYOwX1zLgynW8vgt
        a/oJoHPdO5flu0DEoQn9Kz0Z2w8NfLZxU6R1mV35etoEn+zEzhQcw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4C3621DAA7;
        Wed, 19 Jul 2023 15:24:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CC2611DAA5;
        Wed, 19 Jul 2023 15:24:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/4] commit-graph: avoid looking at Bloom filter data
 directly
References: <ZLgc5q0FrL1s7j0j@nand.local>
        <cover.1689789226.git.me@ttaylorr.com>
Date:   Wed, 19 Jul 2023 12:24:28 -0700
In-Reply-To: <cover.1689789226.git.me@ttaylorr.com> (Taylor Blau's message of
        "Wed, 19 Jul 2023 13:55:41 -0400")
Message-ID: <xmqqwmyvaemr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E1E75D54-2669-11EE-8885-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> The first three are preparatory, but the fourth patch should allow us to
> drop the Perl hackery necessary to dump the raw contents of arbitrary
> Bloom filters.
>
> Feel free to pick up these patches (or not), just wanted to get these
> out there as a possible suggestion.

Thanks, these seem like a good thing to do.  Would love to see an
updated version with them rolled in.

Thanks both for working so well together.

>
> Taylor Blau (4):
>   t/helper/test-read-graph.c: extract `dump_graph_info()`
>   bloom.h: make `load_bloom_filter_from_graph()` public
>   t/helper/test-read-graph: implement `bloom-filters` mode
>   fixup! t4216: test changed path filters with high bit paths
>
>  bloom.c                    |  6 ++--
>  bloom.h                    |  5 +++
>  t/helper/test-read-graph.c | 67 ++++++++++++++++++++++++++++++--------
>  t/t4216-log-bloom.sh       | 14 ++------
>  4 files changed, 64 insertions(+), 28 deletions(-)
>
> --
> 2.41.0.366.g215419bf3c2.dirty
