Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3284FC3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 20:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEA642071C
	for <git@archiver.kernel.org>; Sat,  2 May 2020 20:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bEhzwuQN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgEBUrR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 16:47:17 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52894 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbgEBUrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 May 2020 16:47:16 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3DD51CC7FB;
        Sat,  2 May 2020 16:47:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3r6FWzmgpLzz
        rkSPCYCi+t5Y6p4=; b=bEhzwuQNv37Ei6XxlNoBFYwz3bErsrjfGVbZDI7G5DvE
        DLuB7GzZat7cJ9mA8f3eFiGxpqK6xsKGL9Ynkh0UlTn16/hxh7+/JjDD3XR3PYx6
        hcfuPNWzUpQ/SJZwWxoKXNPJkC+GIuu5DsV9LdD1T/Z6vlw+GNXlKVaTUpHXHzU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=hon8Uy
        OuqPVhMtpjWdyBDOa71J1QYoN26yQQgsPDyf2kcjJ+vfxFbjJahLxb3nUvIdLOs0
        +tpL330ipGL7mXd6pM6aMFi1nNP1jw8qgY0xF4hRulJHP9kQorpghYhHLdDSDc7E
        aMoecbcS500JA7sDm9yEFcNwI4D37/9oPXBRs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 35A44CC7FA;
        Sat,  2 May 2020 16:47:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7647BCC7F9;
        Sat,  2 May 2020 16:47:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com,
        peff@peff.net, jrnieder@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v10] credential-store: ignore bogus lines from store file
References: <20200430160642.90096-1-carenas@gmail.com>
        <20200502181643.38203-1-carenas@gmail.com>
Date:   Sat, 02 May 2020 13:47:09 -0700
In-Reply-To: <20200502181643.38203-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sat, 2 May 2020 11:16:43 -0700")
Message-ID: <xmqqo8r6jc8i.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 18BA1228-8CB6-11EA-8CFF-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> With the added checks for invalid URLs in credentials, any locally
> modified store files which might have empty lines or even comments
> were reported[1] failing to parse as valid credentials.
>
> Instead of doing a hard check for credentials, do a soft one and
> therefore avoid the reported fatal error.
>
> As a special case, flag files with CRLF endings as invalid early
> to prevent current problems in credential_from_url_gently() with
> handling of '\r' in the host.

I do not think it hurts to silently ignore a line that ends with CR,
but only because I do not think credential_from_url_gently() would
not match such a line when asked to match something without
complaining. =20

In other words, isn't the new "!strchr() &&" in the condition a
no-op?

> diff --git a/credential-store.c b/credential-store.c
> index c010497cb2..fdfb81e632 100644
> --- a/credential-store.c
> +++ b/credential-store.c
> @@ -24,8 +24,9 @@ static int parse_credential_file(const char *fn,
>  	}
> =20
>  	while (strbuf_getline_lf(&line, fh) !=3D EOF) {
> -		credential_from_url(&entry, line.buf);
> -		if (entry.username && entry.password &&
> +		if (strchr(line.buf, '\r') =3D=3D NULL &&
> +		    !credential_from_url_gently(&entry, line.buf, 1) &&
> +		    entry.username && entry.password &&
>  		    credential_match(c, &entry)) {
>  			found_credential =3D 1;
>  			if (match_cb) {

In any case, among the ones we discussed, this probably has the
least chance of unintended regression, I would think (with or
without the added "!strchr() &&" check), so let's queue it and
quickly merge it down thru 'next' to 'master'.

> diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
> index d6b54e8c65..9fd0aca55e 100755
> --- a/t/t0302-credential-store.sh
> +++ b/t/t0302-credential-store.sh
> @@ -107,7 +107,6 @@ test_expect_success 'store: if both xdg and home fi=
les exist, only store in home
>  	test_must_be_empty "$HOME/.config/git/credentials"
>  '
> =20
> -
>  test_expect_success 'erase: erase matching credentials from both xdg a=
nd home files' '
>  	echo "https://home-user:home-pass@example.com" >"$HOME/.git-credentia=
ls" &&
>  	mkdir -p "$HOME/.config/git" &&
> @@ -120,4 +119,63 @@ test_expect_success 'erase: erase matching credent=
ials from both xdg and home fi
>  	test_must_be_empty "$HOME/.config/git/credentials"
>  '
> =20
> +invalid_credential_test() {
> +	test_expect_success 'get: ignore credentials without $1 as invalid' '
> +		echo "$2" >"$HOME/.git-credentials" &&
> +		check fill store <<-\EOF
> +		protocol=3Dhttps
> +		host=3Dexample.com
> +		--
> +		protocol=3Dhttps
> +		host=3Dexample.com
> +		username=3Daskpass-username
> +		password=3Daskpass-password
> +		--
> +		askpass: Username for '\''https://example.com'\'':
> +		askpass: Password for '\''https://askpass-username@example.com'\'':
> +		--
> +		EOF
> +	'
> +}
> +
> +invalid_credential_test "scheme" ://user:pass@example.com
> +invalid_credential_test "valid host/path" https://user:pass@
> +invalid_credential_test "username/password" https://pass@example.com

These are quite clear to see.  Nicely done.

> +test_expect_success 'get: credentials with DOS line endings are invali=
d' '
> +	printf "https://user:pass@example.com\r\n" >"$HOME/.git-credentials" =
&&
> +	check fill store <<-\EOF
> +	protocol=3Dhttps
> +	host=3Dexample.com
> +	--
> +	protocol=3Dhttps
> +	host=3Dexample.com
> +	username=3Daskpass-username
> +	password=3Daskpass-password
> +	--
> +	askpass: Username for '\''https://example.com'\'':
> +	askpass: Password for '\''https://askpass-username@example.com'\'':
> +	--
> +	EOF
> +'

What I am curious is if anything breaks around this test if you lost
the extra "!strchr() &&" check.  I suspect that this test will pass.

> +test_expect_success 'get: store file can contain empty/bogus lines' '
> +	echo "" >"$HOME/.git-credentials" &&
> +	q_to_tab <<-\CREDENTIAL >>"$HOME/.git-credentials" &&
> +	#comment
> +	Q
> +	https://user:pass@example.com
> +	CREDENTIAL
> +	check fill store <<-\EOF
> +	protocol=3Dhttps
> +	host=3Dexample.com
> +	--
> +	protocol=3Dhttps
> +	host=3Dexample.com
> +	username=3Duser
> +	password=3Dpass
> +	--
> +	EOF
> +'
> +
>  test_done
>
> base-commit: 49458fb91d61461938881559ce23abbb1a2f8c35
