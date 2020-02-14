Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C35FC35242
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 22:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B762082F
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 22:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="u20LM2pF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgBNWa5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:30:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61462 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbgBNWa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 17:30:57 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 77B273EBEB;
        Fri, 14 Feb 2020 17:30:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oJwc7IuPpV2omnONvz1v3B+4xIM=; b=u20LM2
        pFImLarxodXdRolVMiWsekrwiLnDfkOM2nuS/Jy/MId/9KQmZZbeLgLnzIb45hZX
        c/GFx5H5pKTnvSfcNxTgYISYb964Sd2PWFZeHZLn9uVGz8IzAIG26BRSWi/esHnT
        tp44DDzNJyritbfwBcQbkrWsOzQJtjVJHcEQU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tfP8yaYOG2ZqIacka+qqexNAvw8SQWzw
        t77mCgdHgerHDzpsEQ5oYXXcTezxQETN1PUbl4h6cAhrgeqs66dw76aJ4bksoEJB
        7+RCh8s9uNjzXzsOEkQyKuYIW8mxROMoPkKYKPpX4oY5zKnXI59oHnzdM3dW4jN3
        jFGCW7ebqQE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F26F3EBEA;
        Fri, 14 Feb 2020 17:30:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DB5E73EBE9;
        Fri, 14 Feb 2020 17:30:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Aaron Schrab <aaron@schrab.com>,
        Danh Doan <congdanhqx@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v7 00/15] add git-bugreport tool
References: <20200214015343.201946-1-emilyshaffer@google.com>
        <xmqqv9o9nkh3.fsf@gitster-ct.c.googlers.com>
        <20200214220003.GL190927@google.com>
Date:   Fri, 14 Feb 2020 14:30:53 -0800
In-Reply-To: <20200214220003.GL190927@google.com> (Emily Shaffer's message of
        "Fri, 14 Feb 2020 14:00:03 -0800")
Message-ID: <xmqq5zg8ol7m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9F3AB98-4F79-11EA-BBB3-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> That's fine by me. I find the [[:syntax:]] extremely ugly,...

FWIW, I find it so too.
