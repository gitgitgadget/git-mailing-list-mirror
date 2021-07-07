Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF70C07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 21:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86E2161C94
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 21:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbhGGVaq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 17:30:46 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61061 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbhGGVaq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 17:30:46 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0B49B14220C;
        Wed,  7 Jul 2021 17:28:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y5EBEgkvz0o2YMhYsuP6QqB4vC8DyVWePs/pbV
        ETVJg=; b=SjB9SjtoRDX72KVEvl/Fh0tm+gDKML/pHA0mKWLsXRJVxai7eR7yTs
        Vzg9EBuTPd12OA+dQbJOm74myTtm/YNIl9PgxA0feoIvSx7t7UKS9dxvx7yMQgbs
        NpWN0XO4sHs1xqIsf9eMLR+6OT5ut83blOcRpHzTuJn9fQg3vK/bg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0431314220B;
        Wed,  7 Jul 2021 17:28:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5021E142208;
        Wed,  7 Jul 2021 17:28:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] strbuf.[ch]: make strbuf_fread() take hint, not size
References: <cover-0.3-00000000000-20210707T103712Z-avarab@gmail.com>
        <patch-3.3-46c65a7ae12-20210707T103712Z-avarab@gmail.com>
        <CAFQ2z_MWMokX8hXdOJfiL9Yn=F-QUWe5VHXFEF5DoSBBJu=dmw@mail.gmail.com>
Date:   Wed, 07 Jul 2021 14:27:58 -0700
In-Reply-To: <CAFQ2z_MWMokX8hXdOJfiL9Yn=F-QUWe5VHXFEF5DoSBBJu=dmw@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Wed, 7 Jul 2021 13:47:00 +0200")
Message-ID: <xmqq5yxlervl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3463E0F0-DF6A-11EB-88AD-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> shouldn't you rename it to strbuf_fread_once, analogous to strbuf_read_once ?

Good point.
