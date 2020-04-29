Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8AEC83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 21:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB5A6206F0
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 21:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JbFYaI2/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgD2VM3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 17:12:29 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53221 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgD2VM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 17:12:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1CBEFB06FA;
        Wed, 29 Apr 2020 17:12:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UBhINIFZi1u4
        ZUHF7Gcz+EwUDyk=; b=JbFYaI2/kw9f44G00OdcwnGJSzJbAqX87mRoa5X2qqtP
        fvGoQoP667V/UqHWOwGaIEIB33oTQkJn2Jmr2vjt7dfouicT7FmQfDon1HJV9udj
        DrpbUjqyH8Yb7KZpUeiRv+9xQi0BC48Yv9xWgEh0p4+zz6r011O4hI47iyUG110=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=JwnCah
        ugC6tgRrnFuP8O75FS62JNZUnBSg3oztcBi6nRvknnSd8Lx1J+1Ufx+YQWpYvHIG
        5GyNtz1Tla8PiJWG49+smaC5newP0nVGzUOiOIY/bzSjeiS7QXhLOWaJE2A/7yWQ
        G00AUzYkU3yTwmpvlSIMez4UlmEwyH8S+J080=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 106AFB06F9;
        Wed, 29 Apr 2020 17:12:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 52017B06F6;
        Wed, 29 Apr 2020 17:12:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com,
        peff@peff.net, jrnieder@gmail.com
Subject: Re: [RFC PATCH v6 2/2] credential-store: warn for any incomplete credentials instead of using
References: <20200429003303.93583-1-carenas@gmail.com>
        <20200429203546.56753-1-carenas@gmail.com>
        <20200429203546.56753-3-carenas@gmail.com>
Date:   Wed, 29 Apr 2020 14:12:21 -0700
In-Reply-To: <20200429203546.56753-3-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 29 Apr 2020 13:35:46 -0700")
Message-ID: <xmqqk11yuhca.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1E9F4370-8A5E-11EA-A27E-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> originally any credential found was tried for matching as far as it had
> a username and password, but that resulted in fatal errors as the rules
> were harden.

harden -> hardened

> now that we have a way to report malformed credentials, use it to notif=
y
> the user when username/password was missing, instead of just silently
> skipping.

Sorry, but isn't that what happend already in the previous step?
What are you ordering the codebase (after applying the previous
stpe) do further?  It already is "using it to notify the user when
username and/or password is missing".

> do the same for credentials that are missing host (or had one that is
> empty) or that are missing a path (for supporting cert://) as well.

While the intention may be a good one ...


> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  credential-store.c          |  7 ++++---
>  t/t0302-credential-store.sh | 38 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 3 deletions(-)
>
> diff --git a/credential-store.c b/credential-store.c
> index 1cc5ca081a..53f77ff6f5 100644
> --- a/credential-store.c
> +++ b/credential-store.c
> @@ -26,9 +26,10 @@ static int parse_credential_file(const char *fn,
> =20
>  	while (strbuf_getline_lf(&line, fh) !=3D EOF) {
>  		lineno++;
> -		if (!credential_from_url_gently(&entry, line.buf, 1)) {
> -			if (entry.username && entry.password &&
> -				credential_match(c, &entry)) {
> +		if (!credential_from_url_gently(&entry, line.buf, 1) &&
> +			((entry.host && *entry.host) || entry.path) &&
> +			entry.username && entry.password) {
> +			if (credential_match(c, &entry)) {

... this makes the code even harder to follow than it already was
after the previous step.  In the previous step, at least it was
clear that we'd catch *all* the well-formed/parseable input will
come into the first if () {...} block, but with the extra logic,
that is no longer true.  Even a line that is well formed may be
bypassed from matching and will be fed to "else" side.

