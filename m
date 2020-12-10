Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F06C4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 19:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B58823440
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 19:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390900AbgLJTCo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 14:02:44 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54840 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389213AbgLJTCg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 14:02:36 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92D9CA66E6;
        Thu, 10 Dec 2020 14:01:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0qlF7cIA/hli
        P7V9UEbyWLEscs4=; b=R0dZ+To8QDlXDjzzprLP0OTx26zag3Bsa/uVY+KG0S/F
        ffVUzpe/EhqErEyRlP/Q1kvOJMuazNULpfupoG1/p7NCYC5vxtUpebUQ2H5eY3Ci
        VDtHZTDelfAUtHNqCE2GX6B66acenH7pX5A7V1smMhGCn75CHwKWNz5FD97wZeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rM9aSm
        sHlCcU0jnMALxetlyTdJ9p9jlbO1TTnXllSiN6rp0zLjIU0E6nNOdoZPeCc/XQ5m
        DIzJt6hi8gDVWASVDYaaRIKX1yli+XhlnEo7Kq8U8SQKPWxQOgUzKB0DEy957uR7
        HMDj29J0yZtmYjmBBfCBkPzkXfvMiJWH757mY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8944AA66E5;
        Thu, 10 Dec 2020 14:01:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0A6D2A66E4;
        Thu, 10 Dec 2020 14:01:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Anders Waldenborg <anders@0x63.nu>,
        christian.couder@gmail.com, peff@peff.net,
        jonathantanmy@google.com, Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v3 2/5] pretty format %(trailers) doc: avoid repetition
References: <20201206002449.31452-1-avarab@gmail.com>
        <20201209155208.17782-3-avarab@gmail.com>
Date:   Thu, 10 Dec 2020 11:01:52 -0800
In-Reply-To: <20201209155208.17782-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 9 Dec 2020 16:52:05 +0100")
Message-ID: <xmqqv9d9v61r.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2A59D3B6-3B1A-11EB-B0E9-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> -			  and zero or more comma-separated options:
> +			  and zero or more comma-separated options.
> +			  If any option is provided multiple times the
> +			  last occurance wins.
> ++
> +The boolean options accept an optional value `[=3D<BOOL>]`. The values
> +`true`, `false`, `on`, `off` etc. are all accepted. See the "boolean"
> +sub-section in "EXAMPLES" in linkgit:git-config[1]. If a boolean
> +option is given with no value, it's enabled.

Nicely written.
