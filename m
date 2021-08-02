Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22055C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03D0E60F55
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhHBQZI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 12:25:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54262 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhHBQZI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 12:25:08 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 34E18CFD04;
        Mon,  2 Aug 2021 12:24:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NHXCFklfkkkb
        RX5l/U+rdEvhgJTOwBt2plKaz7RCz48=; b=rGNPHVRwZ7NCz8AiNS5S6L10gpAj
        ShbM9SxMBs4P5ot3RexFVtrJ0/gh+41bP2/T+oCH3AmYeeXmns+idfR1xXH8ZRKo
        RHne/g2h1ryMY0Tl/y2TA+w7yDEQOGpjZ45DTkCV6uaj1qRoe0abgWhw/BJrm9tC
        QwdvIOUqriA+ozg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2DB14CFD03;
        Mon,  2 Aug 2021 12:24:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AD1CFCFD02;
        Mon,  2 Aug 2021 12:24:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v6 2/2] tr2: log parent process name
References: <20210722012707.205776-1-emilyshaffer@google.com>
        <20210722012707.205776-3-emilyshaffer@google.com>
        <87lf5kp27s.fsf@evledraar.gmail.com>
Date:   Mon, 02 Aug 2021 09:24:57 -0700
In-Reply-To: <87lf5kp27s.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 02 Aug 2021 12:30:34 +0200")
Message-ID: <xmqqwnp3x19i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2D72006C-F3AE-11EB-AFE1-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Jul 21 2021, Emily Shaffer wrote:
>
>>  compat/linux/procinfo.c                | 55 +++++++++++++++++++++++++=
+
>> [...]
>> +	/* NEEDSWORK: add non-procfs-linux implementations here */
>
> We'd want non-Windows and non-Linux implementations of this, but that
> NEEDSWORK comment should not be in compat/linux/procinfo.c, where we're
> never going to add non-Linux code.

I am puzzled.  This is talking about additional implementation for
Linux that does not use procfs, no (i.e. what to do with builds of
Linux that compile out the procfs support or installations that do
not mount the /proc hierarchy)?

The comment seems to be at the right place to remind us of them,
even though I do not know how important such an environment is.
