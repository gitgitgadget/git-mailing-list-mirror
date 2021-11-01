Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181D9C433F5
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 17:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED68360EBC
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 17:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhKARrf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 13:47:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54900 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhKARrd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 13:47:33 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BFD9BF90B2;
        Mon,  1 Nov 2021 13:44:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=HFbyL0B2ROqN
        vCq0F+YvTQwgD5dQuBEGtdUanDoqVIU=; b=dP7DblkED+dkzPP+LJMgad81shB6
        TUpA3imN8T2sM961sm0Kg+K2AiROZfcux/JRjEsITFCLHRJKZqWmAd1eg6Ugq0As
        +KCP1KiidEZJHNf+NvvFt1jZIDXj+X50RYJwbnCOByQvpFpSwSJ8frPneIOJ1e/X
        M+SUgrX2alt1Zk0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B5768F90B1;
        Mon,  1 Nov 2021 13:44:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2873BF90B0;
        Mon,  1 Nov 2021 13:44:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] gpg-interface: avoid buffer overrun in
 parse_ssh_output()
References: <f6fca7c0-079c-4337-23d9-cd970c79b8ad@web.de>
        <a72ebd19-9871-f811-cd5c-72b89dad6c6f@web.de>
        <d758381f-064a-1d0a-afab-cb2160ea2eec@gigacodes.de>
Date:   Mon, 01 Nov 2021 10:44:57 -0700
In-Reply-To: <d758381f-064a-1d0a-afab-cb2160ea2eec@gigacodes.de> (Fabian
        Stelzer's message of "Mon, 1 Nov 2021 09:33:39 +0100")
Message-ID: <xmqqbl33db3a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6EEE1B50-3B3B-11EC-B96A-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> On 30.10.21 19:07, Ren=C3=A9 Scharfe wrote:
>> If the string "key" we found in the output of ssh-keygen happens to be
>> located at the very end of the line, then going four characters furthe=
r
>> leaves us beyond the end of the string.  Explicitly search for the
>> space after "key" to handle a missing one gracefully.
>>=20
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>> This code was added after v2.33.0.
>>=20
>>=20
>
> Thanks. This is obviously correct.

Thanks, both.  Will apply.
