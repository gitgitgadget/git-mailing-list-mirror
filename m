Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89265C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 01:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E8720774
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 01:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lCogl9G1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgC0BSZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 21:18:25 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56745 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbgC0BSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 21:18:25 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 05299CC239;
        Thu, 26 Mar 2020 21:18:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6G6uJRRUTpAy
        bAc63E64LfxmPAE=; b=lCogl9G1fND4bH3N/6CHHY6JVxzaqAHxqacTgWLY3yQ7
        osQmS5pFvDKdxj1PfdjU6yE+XDSR2z57H3genq6WN6J0h91wZ2fAbZJREpHdqx27
        9+DxV7eBtBembY1KZ4vTd4EpadQDZK9qgCwFFEzw9w3I51IjiSbm5a2boc2meG8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=KRL1Ag
        yxzDJLcFU86YZ7u3e5qS2zZb1qKjOmowIZW67QOLJvTIwJB5LFvlZqm5UMpTm1m8
        CvikZiNgUJWHd7RKc5Z8mR4MFgl3qL3Di5qJOTrKYLD2Pzvp/36bVM2jS+yOQHjI
        hD330RzqDo87tQfRFF8xuSxizlMNjPmUzZUMA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F1A7ACC238;
        Thu, 26 Mar 2020 21:18:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 48FBFCC237;
        Thu, 26 Mar 2020 21:18:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 7/8] t4124: fix test for non-compliant diff(1)
References: <cover.1584838148.git.congdanhqx@gmail.com>
        <cover.1585197360.git.congdanhqx@gmail.com>
        <02c115e93aa27bb0a8ebfb65a69d12b4cd26fc9b.1585197360.git.congdanhqx@gmail.com>
Date:   Thu, 26 Mar 2020 18:18:18 -0700
In-Reply-To: <02c115e93aa27bb0a8ebfb65a69d12b4cd26fc9b.1585197360.git.congdanhqx@gmail.com>
        (=?utf-8?B?IsSQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh"'s message of "Thu, 26 Mar
 2020 11:37:37 +0700")
Message-ID: <xmqq7dz6ioit.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D868F1E4-6FC8-11EA-9AC4-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> +	# busybox's diff(1) doesn't output normal format
> +	if ! test -s fixed; then

I've touched this line up and tweaked the log message while
applying, as I didn't see anything else that is iffy and wanted to
save one round-trip.  Please see what's pushed out in perhaps a few
hours (and please complain loudly if you don't like it), so that we
can merge it down to 'next' soonish.

Thanks.
