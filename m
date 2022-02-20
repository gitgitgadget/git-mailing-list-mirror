Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B29C433F5
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 12:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbiBTMDB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 07:03:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiBTMDA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 07:03:00 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55FF37A02
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 04:02:39 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 99B4C168D0A;
        Sun, 20 Feb 2022 07:02:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=1jhzZkvxPqRxj/vboRcYCFg0V
        3bYaUxcbddlboCEmvY=; b=sWNueydq+D5eWD2RNfNprH4xoDFExkcybWlMC+jDr
        4afE1KlAfQnGqJey6xV55kWM2p6r2HAPWrTkINgcoHMjkl4O1LZJg1VLcBrZG59+
        ZQAJMTBaYHxTJg0a7dF69igzhoBK87e1Cgp/YjhU2+lqjogUHQJKzSQrDAM4Bvot
        7c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8FD20168D09;
        Sun, 20 Feb 2022 07:02:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 067EE168D08;
        Sun, 20 Feb 2022 07:02:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 3/3] trace.h: remove never-used TRACE_CONTEXT
References: <cover-v2-0.2-00000000000-20220128T110330Z-avarab@gmail.com>
        <cover-v3-0.3-00000000000-20220219T103752Z-avarab@gmail.com>
        <patch-v3-3.3-27ea260bbea-20220219T103752Z-avarab@gmail.com>
Date:   Sun, 20 Feb 2022 04:02:34 -0800
Message-ID: <xmqq5yp9wxt1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FE1D74E6-9244-11EC-95C1-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The definition of "TRACE_CONTEXT" as "__FILE__" added in
> e05bed960d3 (trace: add 'file:line' to all trace output, 2014-07-12)
> appeared between v6[1] and v7[2] of the series that added it.
>
> It does not appear to have been something anybody asked for, and
> doesn't seem to have been used by anyone since then to override it to
> something other than the default __FILE__.

Sorry, but I do not quite follow.  How can we claim nobody used it,
given that it should be usable with CFLAGS=3D-DTRACE_CONTEXT=3DANYTHING?

On the other hand, I do not see how it is hurting anybody to have
this indirection today.

Or am I missing something obvious?
