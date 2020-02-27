Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEE2C11D3D
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 18:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8052A246AD
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 18:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DvoElm7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbgB0S6j (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:58:39 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59652 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729269AbgB0S6j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 13:58:39 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 65003C091E;
        Thu, 27 Feb 2020 13:58:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QSsMGbl6lSyqv2/6vwOV+SddNe8=; b=DvoElm
        7SwIExjgl6UagURtYUwMotpJv0voRBNJIcO73+P1RKD2g5EgPdUTSCeA7W6FqT6R
        SJ/STXZR/vda/NUfn4/PKD5gkDAOrgKsObysJRe7TszNgu6LzNXLhIsnPosQXQMB
        7D/AbmJB9p9ZYQMCxyDp2kNfV/sbbuZuQ+41U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WgpiFv6VxFYr04xjeX6NdHmEAnumjGfS
        art8yT7DE6pHWgNaT5docv2ZGRCNBuZDAgd4MH16EuA9B1CpoE6XHCYgTLMW0xkp
        Oj2peOBcA6Lh40okQzv2XWYxssEwzJ2N7jevSNkIImz+mTmzGdGEiuAxzpUu8cGE
        fqMbZnHXMvA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5DF07C091D;
        Thu, 27 Feb 2020 13:58:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 85449C091C;
        Thu, 27 Feb 2020 13:58:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jorge Lopez Silva via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jorge <JALopezSilva@gmail.com>
Subject: Re: [PATCH v2 2/2] config: documentation for HTTPS proxy client cert.
References: <pull.559.git.1582321003.gitgitgadget@gmail.com>
        <pull.559.v2.git.1582759438.gitgitgadget@gmail.com>
        <c40207a3928f9cbc490b9ef2e99e7cba7788e7c0.1582759438.git.gitgitgadget@gmail.com>
Date:   Thu, 27 Feb 2020 10:58:32 -0800
In-Reply-To: <c40207a3928f9cbc490b9ef2e99e7cba7788e7c0.1582759438.git.gitgitgadget@gmail.com>
        (Jorge Lopez Silva via GitGitGadget's message of "Wed, 26 Feb 2020
        23:23:58 +0000")
Message-ID: <xmqqblpjg8mf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 277A88E8-5993-11EA-8E1A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jorge Lopez Silva via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Jorge Lopez Silva <jalopezsilva@gmail.com>
>
> The commit adds 4 options, client cert, key, key password and CA info.
> The CA info can be used to specify a different CA path to validate the
> HTTPS proxy cert.
>
> Signed-off-by: Jorge Lopez Silva <jalopezsilva@gmail.com>
> ---

Thanks, this should be part of the previous patch, as it was that
commit, not this one, that adds 4 options ;-)

> +http.proxycert::
> +	File indicating a client certificate to use to authenticate with an HTTPS proxy.
> +
> +http.proxykey::
> +	File indicating a private key to use to authenticate with an HTTPS proxy.

I think these files not merely "indicate" but they themselves
"hold", "contain" and/or "store" the certificate and key.  Perhaps
more like...

	The pathname of a file that stores a client certificate to ...

Also, it is customary to camelCase the configuration variable names.
As I understand http.proxykey is roughly corresponds to existing
http.sslKey (the former is for proxy, the latter is for the target
host), I'd expect these two to be spelled http.proxySSLCert and
http.proxySSLKey respectively (without omitting "SSL", as that is
the underlying cURL option name if I am reading the code in 1/2
correctly).

> +http.proxykeypass::
> +	When communicating to the proxy using TLS (using an HTTPS proxy), use this
> +	option along `http.proxykey` to indicate a password for the key.

And this would be "http.proxyKeyPasswd" for the same two reasons.

There are a couple of curious things, though:

 * Is it a good idea to use a keyfile that is encrypted, but leave
   the encryption password on disk in the configuration file to
   begin with?

 * This teaches our system about PROXY_KEYPASSWD that protects
   PROXY_SSLKEY, but why isn't there a similar configuration
   variable for CURLOPT_KEYPASSWD that protects CURLOPT_SSLKEY?

It is possible that the answer to these questions are the same---an
on-disk password is a bad idea, so we deliberately omit a config
that gives value to CURLOPT_KEYPASSWD and instead use the credential
subsystem (see http.c::has_cert_password() and its caller).  If so,
I think it would be prudent to follow the same pattern if possible?

> +http.proxycainfo::
> +	File containing the certificates to verify the proxy with when using an HTTPS
> +	proxy.
> +
>  http.emptyAuth::
>  	Attempt authentication without seeking a username or password.  This
>  	can be used to attempt GSS-Negotiate authentication without specifying
