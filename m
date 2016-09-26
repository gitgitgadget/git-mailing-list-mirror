Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68CF3207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 22:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751690AbcIZWMV (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 18:12:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53057 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751088AbcIZWMU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 18:12:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C93942CD1;
        Mon, 26 Sep 2016 18:12:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=35SxV70fLDtN4cc9KkhOvB1t5sc=; b=HQlzVR
        baE51NBMqxtecmyKrhMJnRuv/75U5ZQTROlMCbiGpJiSplCsTueusbrUKkt6MUkz
        ZGH487RpjV8+3b11kj3vcnwCjdLzFf0hFowlPReLFew3ZCf2dAxIiOjbLcbkjQzN
        qtAeJOihYdX0s0uq6d3DkwmZJhzLL50eFE4xc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pATdXBjIsBRnupdYm8669RiAacrddkZw
        JQ2JGeuIefIuk5PgJfwctp34MBgJ4vplme8YW/Ia3dHiXAeP+3F7Y2I23M/Ikw1J
        2+S1KA0cd2UDsFVG17+Bc+S39kSbyNe658sZvgTn66ixMbNlyYBml2+rYg7knxxN
        XLarKTaDFAA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2244042CD0;
        Mon, 26 Sep 2016 18:12:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1760242CCF;
        Mon, 26 Sep 2016 18:12:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     git@vger.kernel.org,
        Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>,
        Kevin Bracey <kevin@bracey.fi>,
        Philip Oakley <philipoakley@iee.org>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [RFC PATCH v4] revision: new rev^-n shorthand for rev^n..rev
In-Reply-To: <20160926204959.26007-1-vegard.nossum@oracle.com> (Vegard
        Nossum's message of "Mon, 26 Sep 2016 22:49:59 +0200")
References: <20160926204959.26007-1-vegard.nossum@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Date:   Mon, 26 Sep 2016 15:11:53 -0700
Message-ID: <xmqqbmzapaza.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 472B87E0-8436-11E6-9479-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vegard Nossum <vegard.nossum@oracle.com> writes:

> +test_expect_success 'rev-parse merge^-0' '
> +	test_must_fail git rev-parse merge^-0
> +'
> +
> +test_expect_success 'rev-parse merge^-3' '
> +	test_must_fail git rev-parse merge^-3
> +'
> +
> +test_expect_success 'rev-parse merge^-^' '
> +	test_must_fail git rev-parse merge^-^
> +'
> +
> +test_expect_success 'rev-list merge^-0' '
> +	test_must_fail git rev-list merge^-0
> +'
> +
> +test_expect_success 'rev-list merge^-3' '
> +	test_must_fail git rev-list merge^-3
> +'
> +
> +test_expect_success 'rev-list merge^-^' '
> +	test_must_fail git rev-list merge^-^
> +'

This seems to be testing failure cases fairly thoroughly, which is a
good sign.  One thing not tested is "merge^-1x" to ensure that no
change mistakenly will break the strtoul() check you have to parse
the parent number in the future, but other than that (and possibly
reusing the set-up of an already existing test), I am fairly happy
with the tests in this patch.

Thanks.


