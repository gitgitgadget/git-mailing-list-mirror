Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DC5720373
	for <e@80x24.org>; Mon, 13 Mar 2017 20:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751575AbdCMUfB (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 16:35:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53304 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751201AbdCMUe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 16:34:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F409C82834;
        Mon, 13 Mar 2017 16:34:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pYib5nCtFTuPoqa6I6mLH7t540A=; b=qaLWFX
        qFuvuqd5P2OmLBZx9NbNGkpGcTO90fENUxIZere/1H8Z/a+bcUcgkNqEIobUVYMl
        W/4C9amxkKiurOF900CSN4xfHzSO1Pk3nc0qYBDccIKzbPdn3bS6OahQTNXGu6qp
        /T2+TKcjbt5Ff1byDFsj0GGiyWbtmO0MVN85Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZCODtMGJ9c9w7kfNMtlRqvuyZQA+/r7B
        aFXC8WVqpnpb7yp22E+9ZRo1QEQHSUoH/1sMNLKmIcTWAiEIpRWpQmN7s8lXX/Nl
        Zby4BIjGMgRFTxXC8dAyNJ0ZGbc2utNvOWYiGfaR47k/lfGHvRsZfnWHNuHKtxvl
        KczSPr0GpXQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE05D82832;
        Mon, 13 Mar 2017 16:34:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 66E7C82831;
        Mon, 13 Mar 2017 16:34:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v6 03/12] Prepare setup_discovered_git_directory() the root directory
References: <cover.1489098170.git.johannes.schindelin@gmx.de>
        <cover.1489435755.git.johannes.schindelin@gmx.de>
        <8d8be2b095afb215f5bf0e0bb7989c9c9ab3f471.1489435755.git.johannes.schindelin@gmx.de>
Date:   Mon, 13 Mar 2017 13:34:56 -0700
In-Reply-To: <8d8be2b095afb215f5bf0e0bb7989c9c9ab3f471.1489435755.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Mon, 13 Mar 2017 21:09:44 +0100
        (CET)")
Message-ID: <xmqqr320rk3z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85CB15D6-082C-11E7-9CD8-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Subject: Re: [PATCH v6 03/12] Prepare setup_discovered_git_directory() the root directory

I do not think you've changed this title throughout the rerolls, but
I cannot quite parse it.  Would something like this

    setup.c: only append '/' when not at root in setup_discovered_git_dir()

give enough information to the readers while making it readable?

> Currently, the offset parameter (indicating what part of the cwd
> parameter corresponds to the current directory after discovering the
> .git/ directory) is set to 0 when we are running in the root directory.
>
> However, in the next patches we will avoid changing the current working
> directory while searching for the .git/ directory, meaning that the
> offset corresponding to the root directory will have to be 1 to reflect
> that this directory is characterized by the path "/" (and not "").

OK.  C:\ would be 3 not 1 but the same logic to compare with
offset_1st_component() covers the case, which is good.

> So let's make sure that setup_discovered_git_directory() only tries to
> append the trailing slash to non-root directories.
>
> Note: the setup_bare_git_directory() does not need a corresponding
> change, as it does not want to return a prefix.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  setup.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index 2ac891d4b9a..23114cb7aa3 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -721,8 +721,10 @@ static const char *setup_discovered_git_dir(const char *gitdir,
>  	if (offset == cwd->len)
>  		return NULL;
>  
> -	/* Make "offset" point to past the '/', and add a '/' at the end */
> -	offset++;
> +	/* Make "offset" point past the '/' (already the case for root dirs) */
> +	if (offset != offset_1st_component(cwd->buf))
> +		offset++;
> +	/* Add a '/' at the end */
>  	strbuf_addch(cwd, '/');
>  	return cwd->buf + offset;
>  }
