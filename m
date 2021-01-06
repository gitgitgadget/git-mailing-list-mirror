Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15043C433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 01:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC98422D74
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 01:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbhAFBvC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 20:51:02 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60764 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbhAFBvC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 20:51:02 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DD251AD7CB;
        Tue,  5 Jan 2021 20:50:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WUUSWpm4PDGm1EL9CmfDwaBzT3s=; b=T7ZdnV
        spITDbshsyuDn4an58zNNlezSPRPGpp5mzv/bUwRiUaxTzbGeda4kbsv0sIb4cyT
        vs2VP0wWb0X21uH4PaKZRovLDT8sblLzFTJhZnNqqZuykKSGonRhOZ6jkB+dKQ2D
        hOaCr7mbZLDhA7NOKb/bFwk3zirRHGTlGSVl8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iIcNmIpPiZlC6EWVpPJW3ZvkyY7EDJzg
        Jj922xmk1no3dn9wD2AYrSGGnQk8cizOQqK1DwuLnjhrVksrBzMexH6gsQmKcZg1
        7CzkhtB/kawcCuUIeGrnjrj70Isqf67NBSDKbkzNmpTsfcbSx6TkY4ZhwW9pjDk5
        s/l8EIOr4Ks=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D43DEAD7CA;
        Tue,  5 Jan 2021 20:50:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 57D68AD7C9;
        Tue,  5 Jan 2021 20:50:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 5/5] mailmap: support hashed entries in mailmaps
References: <20210103211849.2691287-1-sandals@crustytoothpaste.net>
        <20210103211849.2691287-6-sandals@crustytoothpaste.net>
        <xmqqft3fywsd.fsf@gitster.c.googlers.com>
        <X/UENS0EXyFjjjHA@camp.crustytoothpaste.net>
Date:   Tue, 05 Jan 2021 17:50:18 -0800
In-Reply-To: <X/UENS0EXyFjjjHA@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Wed, 6 Jan 2021 00:28:37 +0000")
Message-ID: <xmqqzh1mx291.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 87FDE8E8-4FC1-11EB-99F5-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I added it because I imagine the use cases for this feature aren't
> immediately obvious to a lot of people and the general rule is that
> commit messages explain why we would implement such a feature.

Yeah, I understand that.

>> > +SHA-1 is not accepted as a hash algorithm in mailmaps.
>>  ...
> I'll drop that line.

Thanks.
