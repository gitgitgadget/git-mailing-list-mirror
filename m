Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C46AC433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 16:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 488D321527
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 16:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cmEDg2d9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395250AbgFSQf7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:35:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60923 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395240AbgFSQf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 12:35:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC1605FAFB;
        Fri, 19 Jun 2020 12:35:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=HQQYmILpsk6E
        bKsVDkDhO5QUtpw=; b=cmEDg2d9ZFa/GaSwryT5ysX0yaQnQbxU/7mTkCKnL3ph
        TFFa4yr2b0Ggqpf9joAlQhVME3p1XzK1r8BoyD8ctqMsSNtxqdrZr8og1elOlJld
        MzECFAcgiv79vZEK0Si5wRMtxNk5ER9qe3w65tu8PH4yKp1FAZXxUyq7VulGL6U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=pTNsM+
        ExYuj95Wb4kVHDC6B4trXGrKZY+KUo1Sfx7yoHPP7rTxc4fXJklhmyLAeCvIxdKn
        wowI7ntlWHGxi/3fM+6JS8TR/MFLF+qy4WOzliir3LMEIhYZYIiz8Kjt7+580xij
        ixW2zd9V9UVy20ONw6T3HL4ZjbcC8A/XMWSPs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C3A4A5FAF9;
        Fri, 19 Jun 2020 12:35:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 41FE65FAF8;
        Fri, 19 Jun 2020 12:35:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/2] git-prompt: include sparsity state as well
References: <pull.808.git.git.1592350413.gitgitgadget@gmail.com>
        <pull.808.v2.git.git.1592513398.gitgitgadget@gmail.com>
        <17254b30a5bcbbe3e14dd47272dfcb4c867030dd.1592513398.git.gitgitgadget@gmail.com>
        <20200619161528.GI2898@szeder.dev>
        <xmqqftarj9qu.fsf@gitster.c.googlers.com>
Date:   Fri, 19 Jun 2020 09:35:53 -0700
In-Reply-To: <xmqqftarj9qu.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 19 Jun 2020 09:33:45 -0700")
Message-ID: <xmqqbllfj9na.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F1D63410-B24A-11EA-9B34-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
>>> +	local sparse=3D""
>>> +	if [ "$(git config --bool core.sparseCheckout)" =3D=3D "true" ]; th=
en
>>> +	    sparse=3D"|SPARSE"
>>
>> Nit: indentation.
>
> Also, do we want "=3D=3D" there?  I thought [ ... ] (unlike [[ ... ]])
> was a mere synonym for "test", to which "=3D=3D" is a bug.

Ah, OK, this script is very bash specific so POSIX portability rules
do not matter.  =3D=3D is just fine as =3D there.

Sorry for the noise.
