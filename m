Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8797AC47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 13:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 457D361406
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 13:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhFENRm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 09:17:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59270 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFENRm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 09:17:42 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DCBC9B99FA;
        Sat,  5 Jun 2021 09:15:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LIEmtskAOeAD
        XaGcWnXgdBkfXusS5isgeie4x8Jbt9Q=; b=EMaBzD1o4uBSYxLw7o4up+WKaDSW
        4kjkfGj1CMffF/5OWjw7i0AXQ2OBhPc37P73sPcesBKcN+lb2czqSIyQ2Atb8cwP
        eWzqqj8mqrRIVwd1nDEf/ASgDSGCYSA72niI7fXz+vxmtYn/QmOyK6SdBRYmvOxv
        WgKbcDVz67zm6GE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D3CFCB99F9;
        Sat,  5 Jun 2021 09:15:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5C3BBB99F8;
        Sat,  5 Jun 2021 09:15:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.32.0-rc3 - t5300 Still Broken on NonStop
 ia64/x86
References: <002701d757d8$1a8d9dc0$4fa8d940$@nexbridge.com>
        <YLfc2+Te7Y3UY+Sm@nand.local>
        <YLfgy94sbmStC0mR@coredump.intra.peff.net>
        <YLfl4jkuwSCiNrrS@nand.local>
        <YLfm8cqY6EjQuhcO@coredump.intra.peff.net>
        <xmqqk0na2yyc.fsf@gitster.g>
        <9b663ba3-6680-0d9a-4910-502cb2abac6b@web.de>
Date:   Sat, 05 Jun 2021 22:15:52 +0900
In-Reply-To: <9b663ba3-6680-0d9a-4910-502cb2abac6b@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 5 Jun 2021 09:04:49 +0200")
Message-ID: <xmqqeedg1mgn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 27BD3E56-C600-11EB-BEA8-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> The function body can be written like this:
>
> 	while (fsync(fd) < 0) {
> 		if (errno !=3D EINTR)
> 			die_errno("fsync error on '%s'", msg);
> 	}
>
> I find it easier to read because it has less syntax elements
> and is shorter.  Bikeshedding, of course. :-/

It indeed is easier to follow.  Thanks.

