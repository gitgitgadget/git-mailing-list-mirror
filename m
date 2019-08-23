Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3CC71F461
	for <e@80x24.org>; Fri, 23 Aug 2019 20:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389453AbfHWUSw (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 16:18:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60098 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbfHWUSv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 16:18:51 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B90267798A;
        Fri, 23 Aug 2019 16:18:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=IvTaul9WOcx2
        /+QhTBFZERZwCdg=; b=oWdEfwiP5QHOEsl4gV5hcpNlEkW5jdaYXtAn8fNguK/n
        8h8tVjYQ4fz217NuhhiTzrJGD9Ps0anLiU8ZuZxKkSW/DtRsmBatMUMxKAEIURNS
        a00sk4rbOnyM/V5BAhCpvYDVaLiUyUkMhBVlovx3H/UV/GabJAraVuhBUC9uRg0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=kv2P1e
        mtXKQSBSdRXytrqX13nDu4+jN7Mn/VAi4IdNLCLJPzj3brbfc3Mpq6klX/qUrfie
        yJBeZJSmgQFnQyp9ZqYLeZIyZ0fGXym7u8ewllPwwECVIuB0DU8pO0T7lML/PVHk
        dHYMXPtF9/pnvjdt80y2VjcUSxl/6WzzzDTD4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B017E77988;
        Fri, 23 Aug 2019 16:18:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D4F1E77987;
        Fri, 23 Aug 2019 16:18:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 13/13] format-patch: learn --infer-cover-subject option
References: <cover.1566258525.git.liu.denton@gmail.com>
        <cover.1566285151.git.liu.denton@gmail.com>
        <de599f7ca9b5fe7e298bba0bb8c5d05f2f5cf34f.1566285151.git.liu.denton@gmail.com>
        <xmqq8srms4ak.fsf@gitster-ct.c.googlers.com>
        <20190823181545.GA14048@archbookpro.localdomain>
        <d8a02cfd-2250-44ce-b559-dbec742b7cdf@iee.email>
Date:   Fri, 23 Aug 2019 13:18:44 -0700
In-Reply-To: <d8a02cfd-2250-44ce-b559-dbec742b7cdf@iee.email> (Philip Oakley's
        message of "Fri, 23 Aug 2019 19:46:30 +0100")
Message-ID: <xmqq1rxbmy8r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3630209E-C5E3-11E9-8B60-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> Perhaps the `--infer-cover-subject` the config option needs to be
> multi-valued to include:
> =C2=A0=C2=A0=C2=A0=C2=A0 "subject" (always expect short first lines) or
> =C2=A0=C2=A0=C2=A0=C2=A0 "message" (always the long paragraph descripti=
on, still use
> ***Subject Here***),
> =C2=A0=C2=A0=C2=A0=C2=A0 with the "true" being used when expecting both=
 as previously
> described.

The idea to have three choices feels that this is getting better,
but I notice that the choice is no longer about "subject".

I've always felt that the name of this option is way suboptimal.
One reason is because the option only says it is about the subject
of the cover (letter), and the verb "infer" conveys almost no
information---especially it does not say anything about what affects
the inference (hint: the branch description value gets used, in a
single hardcoded ways right now, but now with the patch we have a
choice to control how it gets used).



