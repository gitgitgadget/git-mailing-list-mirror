Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA47C433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 18:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 023BE60E0B
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 18:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbhJYScT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 14:32:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61054 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhJYScT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 14:32:19 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EC20DF82F3;
        Mon, 25 Oct 2021 14:29:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QRET7EQfuLpd
        nA6oV3nQEAGX+RPnX7CsRpnrCSsP1Hg=; b=YDHgmqN4RZLZPxepHbsotv3vYaet
        k1+GBkzqtb0CVtJd0QiBxWQ0eagyktFvywSNWObjeXyTxR6Ms9lkq8XIWesbCXju
        OAWAcFWdypd10bNAWIsWGbuMnRooFBfMhT7MebBGUEeGrVwj1/UYyjrVgnqiLMRb
        im60EC4fgqVJPFg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E38E8F82F2;
        Mon, 25 Oct 2021 14:29:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4D6A6F82F1;
        Mon, 25 Oct 2021 14:29:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 01/10] command-list.txt: sort with "LC_ALL=C sort"
References: <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
        <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
        <patch-v2-01.10-96885282988-20211022T193027Z-avarab@gmail.com>
Date:   Mon, 25 Oct 2021 11:29:53 -0700
In-Reply-To: <patch-v2-01.10-96885282988-20211022T193027Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 22 Oct
 2021 21:36:05
        +0200")
Message-ID: <xmqqfssp0xge.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8D116404-35C1-11EC-A685-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> We should keep these files sorted in the C locale, e.g. in the C
> locale the order is:
>
>     git-check-mailmap
>     git-check-ref-format
>     git-checkout
>
> But under en_US.UTF-8 it's:
>
>     git-check-mailmap
>     git-checkout
>     git-check-ref-format
>
> In a subsequent commit I'll change generate-cmdlist.sh to use C sort
> order, and without this change we'd be led to believe that that change
> caused a meaningful change in the output, so let's do this as a
> separate step, right now the generate-cmdlist.sh script just uses the
> order found in this file.

Hmph, I do not mind sorting this file bytewise like this at all, but
does the justification above still apply to this round?  I had an
impression that we lose the sorting altogether in the end...

Also, I am not sure where that "led to believe" comes from---do we
have a test that checks the output from generate-cmdlist somehow?


