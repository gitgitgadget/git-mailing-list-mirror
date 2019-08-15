Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A09D1F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 19:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731414AbfHOTeP (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 15:34:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56275 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfHOTeP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 15:34:15 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC74515F4B2;
        Thu, 15 Aug 2019 15:34:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qOMy2296PL4E
        BOGypMW8/twV2yc=; b=UTDL+J9T9MnGL3+ono3FsOGzvQK16doX479CahnO8JuX
        BxzZYvTMnw7geKOZC+8Csh3n6tdJIE4hjzLpWPHAIp8jbOTMbv1uBlMc1x/z+CRV
        X9Qi8Y6LLIWFOQYO0w0KNrhC0905Q/LJmNuHlIourksVqOvaiV6GnJtaRFtN3Hc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=fmNhsc
        NRLN2B5cswG7dOwUAgQmlzxrqNNWRpzoooD9Y5nNpPWuoYXXnh6Cy6ER2poIG+Rd
        itFoEk5XE2gyf1D85FTRg61BoreUUvBEW2J3XXaEAA16Y4Sxb4AN9Sva6qrAnfJP
        HxMCKU1sm9JPTHVp9OG6aK3dSo6+HmfVIPusE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D329315F4B1;
        Thu, 15 Aug 2019 15:34:12 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 28ADD15F4B0;
        Thu, 15 Aug 2019 15:34:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, daniel@haxx.se,
        peff@peff.net
Subject: Re: [PATCH v2] http: use xmalloc with cURL
References: <20190815153504.23199-1-carenas@gmail.com>
        <20190815191314.27440-1-carenas@gmail.com>
Date:   Thu, 15 Aug 2019 12:34:11 -0700
In-Reply-To: <20190815191314.27440-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Thu, 15 Aug 2019 12:13:14 -0700")
Message-ID: <xmqqo90q2pfw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A8A2BCBE-BF93-11E9-9D7B-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> +#elseif LIBCURL_VERSION_NUM >=3D 0x070c00

#elif

> +#define curl_global_init(a) curl_global_init_mem(a, xmalloc, free, \
> +						xrealloc, xstrdup, xcalloc)
>  #endif
> =20
>  #if (LIBCURL_VERSION_NUM < 0x070c04) || (LIBCURL_VERSION_NUM =3D=3D 0x=
071000)
>
> base-commit: 9827d4c185e4da728f51cd77c54a38c9de62495f
