Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8809BC4332D
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 20:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7FF2077D
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 20:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TlUgHey7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgCUULc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 16:11:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60577 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgCUULc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 16:11:32 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CEF1151ED3;
        Sat, 21 Mar 2020 16:11:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JAsyIs3QTahIc/hGh4lYxYwJHlY=; b=TlUgHe
        y79kd7N+C0Ywt+z6SDJ3F+7yJYp/pz8UFtoMkqldWvc67BQY9aMJ0nBTl0uWSisK
        wR1HJ1UaySJz9Lz3EuUkKLuzn4K4bHvn6aOWaeHh9GMXJd8HPRxQ74KwI7bJxgXv
        BrVZ/vEKibBxM2VTYwdzNFwiXv4ezG2d47LcE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xrezRkCda89lc85wicx9+GcW6QEblfdD
        j+bG+TZlhUUn22miieKmx5Pz7jEXeCgvO153s66CVD+uIQKlkLFUK6EM7n8sTX2S
        xhvujNLycPDVonMqIx+eWtY2r7Hg0wNDsghdlscYNBtMBJ9BWLjv9VjHjMbrpg9Q
        yyKxDPqCJyQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C685A51ED2;
        Sat, 21 Mar 2020 16:11:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 53E2B51ECF;
        Sat, 21 Mar 2020 16:11:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Johannes Sixt <j6t@kdbg.org>, git <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] test-lib: allow short options to be stacked
References: <48c28683412e3e0803d4c7189a6d66daddcdc580.1584759277.git.matheus.bernardino@usp.br>
        <2a54d866-c40e-da5e-4c0c-6bfcb56eb8f7@kdbg.org>
        <CAHd-oW73xp2=XcFr1F57fo2UtAyuZ2aeXVSc_A50bYKKVN7fJw@mail.gmail.com>
Date:   Sat, 21 Mar 2020 13:11:28 -0700
In-Reply-To: <CAHd-oW73xp2=XcFr1F57fo2UtAyuZ2aeXVSc_A50bYKKVN7fJw@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Sat, 21 Mar 2020 15:55:27
        -0300")
Message-ID: <xmqqpnd58o3z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 268FB974-6BB0-11EA-A42B-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

> Makes sense, thanks. However, using Peff's suggestion[1] for the
> character iteration already eliminates the need for extra processes.

Even without an extra process, having to strip "-", assign an empty
string to $extra, and then strip that empty string from the tail to
come up with a single letter in $this, all are consuming cycles.
Even though these wasted cycles are now much smaller, having an arm
that specifically catches unbundled case and avoid doing anything
extra makes the codeflow clear, I would think.
