Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D918F20133
	for <e@80x24.org>; Fri,  3 Mar 2017 19:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752285AbdCCTOE (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 14:14:04 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57533 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752145AbdCCTNw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 14:13:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 26E06642C5;
        Fri,  3 Mar 2017 14:13:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1nY6DUETjk6J1BlrISAwEQ+9kCM=; b=jHClNf
        Vg4IlOVs1vGRcoH1fS+Zs9dIogl0HpvgwYCIg8B1MfRSqgnnl3D5PbazX/xFBM26
        cBOV3nSuQ2PpxoYNluundcCsTT5fpqtYT5rg0NX6Cl7jPLAxkZO7tjxf/NidGPpx
        DmHQpdgAaIWNBEssp67RzUQVg7tOMvOjeO6Nw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EOH7h9uEQ09k8meARXHIVuEbHt70xcNW
        1RWWjweoh5Oh8UhvBmzGayCjAoh6a7EUQiCFPogAaaPMlGFcweeKgDwufSu+jBGD
        VHLcKZs88r/3/zsxySUv5F0zTFArEXkrt2mwG72f/+y6C3aIhFe4JpyhjWoVxmBM
        wtQrg24/UL4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DD80642C4;
        Fri,  3 Mar 2017 14:13:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 75C32642C3;
        Fri,  3 Mar 2017 14:13:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        sschuberth@gmail.com, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Philip Oakley <philipoakley@iee.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v7 0/3] Conditional config include
References: <20170224131425.32409-1-pclouds@gmail.com>
        <20170301112631.16497-1-pclouds@gmail.com>
        <20170303063329.ji6do6eqjbpuwmxz@sigill.intra.peff.net>
        <20170303095252.GA12072@ash>
Date:   Fri, 03 Mar 2017 11:13:21 -0800
In-Reply-To: <20170303095252.GA12072@ash> (Duy Nguyen's message of "Fri, 3 Mar
        2017 16:52:52 +0700")
Message-ID: <xmqqpohy897y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 78165E3A-0045-11E7-B167-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> The patch to fix it is this
>
> diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
> index f0cd2056ba..e833939320 100755
> --- a/t/t1305-config-include.sh
> +++ b/t/t1305-config-include.sh
> @@ -102,7 +102,7 @@ test_expect_success 'config modification does not affect includes' '
>  
>  test_expect_success 'missing include files are ignored' '
>  	cat >.gitconfig <<-\EOF &&
> -	[include]path = foo
> +	[include]path = non-existent
>  	[test]value = yes
>  	EOF
>  	echo yes >expect &&
>
> Junio could you squash this in?

Sure.
