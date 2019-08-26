Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D0451F461
	for <e@80x24.org>; Mon, 26 Aug 2019 16:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732524AbfHZQlr (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 12:41:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64182 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729344AbfHZQlq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 12:41:46 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 39C25177121;
        Mon, 26 Aug 2019 12:41:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N+t5GkEpUAXDqJ0VZRG51hSx8ho=; b=Xq1s5P
        pfWEfT/Dduj1J5cgJE8D80ZFZ8M42LAeaJBe5gfOQajr4TR/UnPd1XW/DX4JjA9Z
        lVxzFinW9lv4q2Tu4d8JZ45r1aTVgd7al/+J5tQyZ4qFl8Hl/wzMuiaNIJdye3KV
        V6kuCx/ICIkSVBpIFjjKaBb1sVCzXN8jR4y0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IQqjBAM0ND5vFGZ+/k18HenrEb9EpRvI
        xcvdNY+aI5x6u0+tg5Y1arREjLFNckzwZNfpl74Zuu9Al3pA+BDWUuTPiKW84eNh
        zsKOL3QymL7oEwxxgA/SbtiZmFucYHouYsz/IuX/cix+TCSDcSqeCNdAxmy633lf
        cep/wnsrCmM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 29189177120;
        Mon, 26 Aug 2019 12:41:44 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 76E4417711F;
        Mon, 26 Aug 2019 12:41:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 2/2] apply: reload .gitattributes after patching it
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
        <20190818184403.861907-1-sandals@crustytoothpaste.net>
        <20190818184403.861907-3-sandals@crustytoothpaste.net>
        <9b940950-666a-0c4c-58c0-1e61ac9e654c@gmail.com>
        <20190820024505.GH365197@genre.crustytoothpaste.net>
        <18fcc7db-7c09-3fbf-1e3f-81be99f4bb17@gmail.com>
        <xmqqd0gzvgo3.fsf@gitster-ct.c.googlers.com>
        <d59de3db-13e6-35d5-2cb1-b38dc8854c60@gmail.com>
        <e8196c6e-7f3c-1b29-73ba-40094f1e0280@gmail.com>
Date:   Mon, 26 Aug 2019 09:41:42 -0700
In-Reply-To: <e8196c6e-7f3c-1b29-73ba-40094f1e0280@gmail.com> (Phillip Wood's
        message of "Mon, 26 Aug 2019 16:09:20 +0100")
Message-ID: <xmqqk1azj2ux.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 62E3005E-C820-11E9-8589-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> I spent some time digging into this and the attributes are reloaded
> before each pick. This is because check_updates() called by
> unpack_trees() calls git_attr_set_direction(GIT_ATTR_CHECKOUT) at the
> start of the function and git_attr_set_direction(GIT_ATTR_CHECKIN) at
> the end of the function. This has the effect of dropping all loaded
> attributes as git_attr_set_direction() calls drop_all_attr_stacks()
> when the direction is changed.

Ah, OK (and thanks), so it was working by accident ;-)
