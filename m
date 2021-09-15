Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A205C433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 21:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0078D60F70
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 21:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhIOVHo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 17:07:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60042 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhIOVHl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 17:07:41 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 68CEBF7370;
        Wed, 15 Sep 2021 17:06:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=RkD+uXCLcF2m
        cX/PYTwT+SzcPJhD8C7ixr8OIAYKPMQ=; b=kTuxWB9LwGiEBxl4iQQFeqH4/0BZ
        dYXXijRJLrUjCbW75vb3bHV5tIv512sJrBZdHDxLdiiC/A/6gD6yqeXXTfBZXfeG
        tYoiGOS6HGA7Nyetw6ly/sjQYEeS9NSE/MAzDe923jNGPBlJx0TwpZVvFnNRTX0j
        jPaoIYXXoL3beNg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 61B29F736F;
        Wed, 15 Sep 2021 17:06:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E621AF736E;
        Wed, 15 Sep 2021 17:06:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 3/7] simple-ipc: move definition of ipc_active_state
 outside of ifdef
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
        <7de207828caa9e50906f39b955e39e9de2c1768f.1631738177.git.gitgitgadget@gmail.com>
Date:   Wed, 15 Sep 2021 14:06:19 -0700
In-Reply-To: <7de207828caa9e50906f39b955e39e9de2c1768f.1631738177.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Wed, 15 Sep 2021
        20:36:13 +0000")
Message-ID: <xmqq5yv1wnuc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C6380B02-1668-11EC-AA57-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> From: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
>
> Move the declartion of the `enum ipc_active_state` type outside of
> the SUPPORTS_SIMPLE_IPC ifdef.

The second one is not an in-body header since there is already a
blank line that signals the end of in-body headers after the first
one.

This _may_ be a bug in GGG, perhaps?


> A later commit will introduce the `fsmonitor_ipc__*()` API and stub in
> a "mock" implementation that requires this enum in some function
> signatures.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  simple-ipc.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/simple-ipc.h b/simple-ipc.h
> index 9c7330fcda0..b396293bdfc 100644
> --- a/simple-ipc.h
> +++ b/simple-ipc.h
> @@ -5,13 +5,6 @@
>   * See Documentation/technical/api-simple-ipc.txt
>   */
> =20
> -#ifdef SUPPORTS_SIMPLE_IPC
> -#include "pkt-line.h"
> -
> -/*
> - * Simple IPC Client Side API.
> - */
> -
>  enum ipc_active_state {
>  	/*
>  	 * The pipe/socket exists and the daemon is waiting for connections.
> @@ -43,6 +36,13 @@ enum ipc_active_state {
>  	IPC_STATE__OTHER_ERROR,
>  };
> =20
> +#ifdef SUPPORTS_SIMPLE_IPC
> +#include "pkt-line.h"
> +
> +/*
> + * Simple IPC Client Side API.
> + */
> +
>  struct ipc_client_connect_options {
>  	/*
>  	 * Spin under timeout if the server is running but can't
