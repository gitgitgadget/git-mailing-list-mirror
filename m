Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D68C43334
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 21:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiGJVzC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 17:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJVzA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 17:55:00 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FDBBCA7
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 14:54:59 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5223C12DA4F;
        Sun, 10 Jul 2022 17:54:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5eUk3mrwcPw3
        2hW+YLeuzpZE6ultVJPOHwPjUK5hcyI=; b=X30YvLuE+6RPCiQvIWSFVpc4eC0K
        d+aXRo83cidNS/XsxksgO9zcZQkVHP7u6Plpx2daP9ESmyy46qmMdxOgy20fIpc7
        pFHYM8725DJzXDJtIEt46gN1x3hMt5T39D/o2U6F4CPeoKguKS9KbeCWPGR3EZpA
        YgVkPHDiivALV1s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4964C12DA4B;
        Sun, 10 Jul 2022 17:54:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AE54912DA4A;
        Sun, 10 Jul 2022 17:54:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] multi-pack-index: simplify handling of unknown --options
References: <20220708202847.662319-1-szeder.dev@gmail.com>
        <xmqqh73ruxc8.fsf@gitster.g> <20220710151645.GA2038@szeder.dev>
Date:   Sun, 10 Jul 2022 14:54:54 -0700
In-Reply-To: <20220710151645.GA2038@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Sun, 10 Jul 2022 17:16:45 +0200")
Message-ID: <xmqq1qusr5u9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EF405032-009A-11ED-8313-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> > Let parse_options() handle unknown options instead, which, besides
>> > simpler code, has the additional benefit that it prints not only the
>> > usage but an "error: unknown option `foo'" message as well.
>>=20
>> Yes, I agree that getting rid of KEEP_UNKNOWN is a very good idea
>> for this reason.  But I suspect that we still need the "did we get
>> an extra argument we do not know what to do with?" check.
>
> Uh, indeed.  I got too trigger-happy with deleting lines.
> Updated patch below.

OK.  I suspect that a test would have caught the breakage in the
original.  Would it make sense to add one now?

Thanks, will queue.
