Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF38C433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 17:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1409E610CC
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 17:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhJLRiT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 13:38:19 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57072 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbhJLRiT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 13:38:19 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2C647163FF1;
        Tue, 12 Oct 2021 13:36:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7Kv8Ihh76Yid8Tfix3KJkDt1XVso69rLRo+1WS
        bbTPo=; b=frhrZ4AgMJwPcJ8YCRRnXMrAmS1BK65QTaCf5JDe+CqgAyB9Uw17lm
        biePYCCwdp4ThM+pGJrp1vFleCwgJXcU0j9RsuAjv54uaGM7pbbVZyGBm0NjcLB/
        OsgEADppDNPlFq/8n2yZnC+lKoiXAPXX+05SbgItWKBxJR6AzNZdA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 256A3163FF0;
        Tue, 12 Oct 2021 13:36:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B1116163FEF;
        Tue, 12 Oct 2021 13:36:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] fixup! ssh signing: verify signatures using ssh-keygen
References: <20211012092236.619822-1-fs@gigacodes.de>
        <20211012092236.619822-3-fs@gigacodes.de>
Date:   Tue, 12 Oct 2021 10:36:13 -0700
In-Reply-To: <20211012092236.619822-3-fs@gigacodes.de> (Fabian Stelzer's
        message of "Tue, 12 Oct 2021 11:22:36 +0200")
Message-ID: <xmqqr1cq4036.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E612EEC2-2B82-11EC-8EFF-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> This behaviour changed during patch review and documentation no longer
> matched it.
> ---

Thanks, you'd need to sign-off, to make this a standalone bugfix
patch.

>  Documentation/config/gpg.txt | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
> index 51a756b2f1..4f30c7dbdd 100644
> --- a/Documentation/config/gpg.txt
> +++ b/Documentation/config/gpg.txt
> @@ -52,9 +52,7 @@ gpg.ssh.allowedSignersFile::
>  SSH has no concept of trust levels like gpg does. To be able to differentiate
>  between valid signatures and trusted signatures the trust level of a signature
>  verification is set to `fully` when the public key is present in the allowedSignersFile.
> -Therefore to only mark fully trusted keys as verified set gpg.minTrustLevel to `fully`.
> -Otherwise valid but untrusted signatures will still verify but show no principal
> -name of the signer.
> +Otherwise the trust level is `undefined` and git verify-commit/tag will fail.
>  +
>  This file can be set to a location outside of the repository and every developer
>  maintains their own trust store. A central repository server could generate this
