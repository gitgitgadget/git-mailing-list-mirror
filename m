Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521FCC2D0EC
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 21:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD79F20730
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 21:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ieHZ5P1v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgDGVfW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 17:35:22 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54907 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgDGVfW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 17:35:22 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E1EBBC9BA9;
        Tue,  7 Apr 2020 17:35:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C5yS9hVqZBsXCvbt8ND9KFSKWc0=; b=ieHZ5P
        1vGCCo4esMxdBPDLBT/TX4a9WbRDXGL97aaLe4ZBLQA030Q2Z4sEtV0cdQBMtdeb
        WWc/L9Qk/UNCTaZcDb99M778HO+lo8B3MZtlKbxN+Rv9NhbUu4vujMI1vFgoG/hu
        11PfvOFmlbeOXiXWxHP57sXniJ1VqDh0LLVdg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BgkDnOnUgPk5sOBrme3kOUVrMLXYjacJ
        hkx027F5QnrSqTumWO5NodRJs64OmB+4cUa5mD0pQFC2SO8SjuDxnKDQL4M6h4CY
        ce0UH+eVMrPVcaz2oaKSj3aMz9E5Tns2XSIm+WAJ2K665j9wteXtLQ74UMkNi9RX
        8PNXulFoNbY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D9B1FC9BA8;
        Tue,  7 Apr 2020 17:35:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2D5E7C9BA3;
        Tue,  7 Apr 2020 17:35:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBv?= =?utf-8?B?w6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] travis: build and test on Linux with musl libc and busybox
References: <cover.1585203294.git.congdanhqx@gmail.com>
        <cover.1585474409.git.congdanhqx@gmail.com>
        <6cf6400f2e0f7336e9b13ddbf412101c4ab48dc5.1585474409.git.congdanhqx@gmail.com>
        <20200401221835.GH2224@szeder.dev>
        <nycvar.QRO.7.76.6.2004071651060.46@tvgsbejvaqbjf.bet>
Date:   Tue, 07 Apr 2020 14:35:15 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2004071651060.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 7 Apr 2020 16:53:54 +0200 (CEST)")
Message-ID: <xmqqh7xvrncc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AC695A86-7917-11EA-9F65-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> The recommended way to build Git is without autoconf and configure.
>
> That is news to me.
>
> My understanding still is that `make` is the recommended way to build Git,
> and `./configure` is only for those who want to use autoconf.
>
> It seems that the `INSTALL` file agrees with my understanding:

Did you misread the sentence you quoted?  It says "without", not
"with", so I think you two are on the same page.
