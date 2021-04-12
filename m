Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B93C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 10:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D901361029
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 10:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239190AbhDLKx2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 06:53:28 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53076 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237944AbhDLKx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 06:53:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 142B013512F;
        Mon, 12 Apr 2021 06:53:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=TdD0FzGAEfBomL/tp/FtMwq7N
        nU=; b=IMDevKHAKQpwLRcTLoPnYpHIWn3a0zRGwjF6th9+sy6eeMdLyHANwmd3k
        /jCM+rgOCn6XTLdi+F17Py9s84Xtb8T1BTtHmW5X37buIBE/Ty9wRaIvdZimWBOC
        7uS9fvXs6v/lhOPBnzf+J7l2UemAi9UyyQTf4xvzQtbzXDMWA4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=TNiiJ3rVbHRmAQSmClN
        QqzrdEkeVJ8MXjJVKgi0x55kl14CB+DX+ZoEcwU577nAu6bSzTDFxNuQzzZfVcEy
        wEzIDmuS0oxRUUQVZa//Y79G2BR8fr65/hlqvSglf0YT/D7H2JU30BX2NCJTZYuL
        eYepCUiFu5utwXYmpdkBvGWc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0CCC213512E;
        Mon, 12 Apr 2021 06:53:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5437313512D;
        Mon, 12 Apr 2021 06:53:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 09/15] hash: set and copy algo field in struct object_id
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
        <20210410152140.3525040-10-sandals@crustytoothpaste.net>
        <87k0p9f2z9.fsf@evledraar.gmail.com>
        <YHNusqcmwv75P6Ck@camp.crustytoothpaste.net>
        <87wnt8eai1.fsf@evledraar.gmail.com>
Date:   Mon, 12 Apr 2021 03:53:05 -0700
Message-ID: <xmqqeeffg4fi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 43AD847A-9B7D-11EB-B70F-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> But we can use some subset of C99 features, and happily designated
> initializers is one of those, see cbc0f81d96f (strbuf: use designated
> initializers in STRBUF_INIT, 2017-07-10). It's been used all over the
> place since then.

Good advice to cite a commit that on purpose used a feature and
documented that it is allowed.

Also see Documentation/CodingGuidelines ;-)  The document should
give the authoritative blessing for features allowed to be used (add
any missing with a proposed patch).

Thanks.

