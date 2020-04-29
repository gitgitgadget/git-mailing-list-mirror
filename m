Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22ACC83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 23:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94A4020BED
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 23:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LC+97yQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgD2Xri (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 19:47:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59660 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgD2Xri (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 19:47:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 722C0CB40A;
        Wed, 29 Apr 2020 19:47:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NXBJ53nGFn/O
        t1rE8fp+SPmw1EI=; b=LC+97yQSP/pO7jy/+H3MR4FmiMDl9rI9uVCeBLr0drrS
        OPs7TcX55HmqJeu6VoSL6Nge+vfsjfK27l+xZKmckW9f+V9NoaLsy5DRf1XP+C+0
        gTw6+bYo/E0zgrKiYTWw5AiZoNnaN7Bw/myuVbcEl0T56jKClGSQE7BEk2mRybU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=VmuYML
        0wpRkMHrXV58TtLjQvNsp1Bzukq4zT4GMrgafK0YxSYIhNdupFm4nWTfqrrM5SV0
        iudFiLu1qwpHASzbSCLDeYzL4knK12lDXSOFdqv/q3ODNvPaTM5bu86PdbvDMSpP
        ROy10GratjI/ak5c84BBlPcdylt2aIrNovzDs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6955ACB409;
        Wed, 29 Apr 2020 19:47:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9D52FCB408;
        Wed, 29 Apr 2020 19:47:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com,
        peff@peff.net, jrnieder@gmail.com
Subject: Re: [PATCH v6] credential-store: warn instead of fatal for bogus lines from store
References: <20200429203546.56753-1-carenas@gmail.com>
        <20200429232322.68038-1-carenas@gmail.com>
Date:   Wed, 29 Apr 2020 16:47:31 -0700
In-Reply-To: <20200429232322.68038-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 29 Apr 2020 16:23:22 -0700")
Message-ID: <xmqqlfmdua5o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CBFF4D20-8A73-11EA-9E51-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> with the added checks for invalid URLs in credentials, any locally
> modified store files which might have empty lines or even comments
> were reported[1] failing to parse as valid credentials.

with -> With

> instead of doing a hard check for credentials, do a soft one and
> warn the user so any invalid entries could be corrected.

instead -> instead

> make sure that the credential to use is complete before calling
> credential_match by confirming it has all fields set as expected
> by the updated rules.

make -> Make

> diff --git a/Documentation/git-credential-store.txt b/Documentation/git=
-credential-store.txt
> index 76b0798856..122e238eb2 100644
> --- a/Documentation/git-credential-store.txt
> +++ b/Documentation/git-credential-store.txt
> @@ -95,8 +95,15 @@ https://user:pass@example.com
>  ------------------------------
> =20
>  No other kinds of lines (e.g. empty lines or comment lines) are
> -allowed in the file, even though some may be silently ignored. Do
> -not view or edit the file with editors.
> +allowed in the file, even though historically the parser was very
> +lenient and some might had been silently ignored.
> +
> +Do not view or edit the file with editors as it could compromise the
> +validity of your credentials by sometimes subtle formatting issues,
> +like spaces, line wrapping or text encoding.

I do not think dropping "view or" is justifiable.  There is no need
to invite the risk of opening with the intention to only view and
then end up saving a modification.  In other words, do not encourage
use of an *editor* in any way.

> +
> +An unparseable or otherwise invalid line is ignored, and a warning
> +message points out the problematic line number and file it appears in.

OK.  You didn't want to tell them they can remove the problematic
line as a whole with their editor?

> diff --git a/credential-store.c b/credential-store.c
> index c010497cb2..4d3c9e8000 100644
> --- a/credential-store.c
> +++ b/credential-store.c
> @@ -6,6 +6,15 @@
> =20
>  static struct lock_file credential_lock;
> =20
> +/*
> + * entry->protocol comes validated from credential_from_url_gently
> + */

Sure, but wouldn't it be simpler to do without such a comment and
check it also here, just as a belt-and-suspender safety?

> +static int valid_credential(struct credential *entry)
> +{
> +	return (entry->username && entry->password &&
> +		((entry->host && *entry->host) || entry->path));
> +}

> @@ -15,6 +24,7 @@ static int parse_credential_file(const char *fn,
>  	struct strbuf line =3D STRBUF_INIT;
>  	struct credential entry =3D CREDENTIAL_INIT;
>  	int found_credential =3D 0;
> +	int lineno =3D 0;
> =20
>  	fh =3D fopen(fn, "r");
>  	if (!fh) {
> @@ -24,16 +34,24 @@ static int parse_credential_file(const char *fn,
>  	}
> =20
>  	while (strbuf_getline_lf(&line, fh) !=3D EOF) {
> +		lineno++;
> +
> +		if (credential_from_url_gently(&entry, line.buf, 1) ||
> +			!valid_credential(&entry)) {
> +			warning(_("%s:%d: ignoring invalid credential"),
> +				fn, lineno);
> +		}
> +		else if (credential_match(c, &entry))
> +		{

Style:  "} else if (...) {" on a single line.

>  			found_credential =3D 1;
>  			if (match_cb) {
>  				match_cb(&entry);
>  				break;
>  			}
> +			continue;
>  		}
> +
> +		if (other_cb)
>  			other_cb(&line);
>  	}

This got vastly easier to read, thanks to the additional helper.
Looking really good.

> diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
> index d6b54e8c65..3150f304cb 100755
> --- a/t/t0302-credential-store.sh
> +++ b/t/t0302-credential-store.sh
> @@ -120,4 +120,84 @@ test_expect_success 'erase: erase matching credent=
ials from both xdg and home fi
>  	test_must_be_empty "$HOME/.config/git/credentials"
>  '
> =20
> +test_expect_success 'get: credentials without scheme are invalid' '
> +	echo "://user:pass@example.com" >"$HOME/.git-credentials" &&
> +	cat >expect-stdout <<-\STDOUT &&
> +	protocol=3Dhttps
> +	host=3Dexample.com
> +	username=3Daskpass-username
> +	password=3Daskpass-password
> +	STDOUT
> +	test_config credential.helper store &&
> +	git credential fill <<-\EOF >stdout 2>stderr &&
> +	protocol=3Dhttps
> +	host=3Dexample.com
> +	EOF
> +	test_cmp expect-stdout stdout &&
> +	grep "askpass: Username for '\''https://example.com'\'':" stderr &&
> +	grep "askpass: Password for '\''https://askpass-username@example.com'=
\'':" stderr &&

These messages are passed from credential.c::credential_ask_one() to
git_prompt() without any i18n, so use of a bare "grep" is good.

> +	test_i18ngrep "ignoring invalid credential" stderr

And this is new message inside _(), so i18ngrep is good.

Nice to see such an attention to the details.


> +	test_config credential.helper store &&
> +	git credential fill <<-\EOF >stdout 2>stderr &&
> +	protocol=3Dhttps
> +	host=3Dexample.com
> +	EOF
> +	test_cmp expect-stdout stdout &&
> +	test_i18ngrep "ignoring invalid credential" stderr &&
> +	test_line_count =3D 3 stderr

The "ignoring invalid credential" message could be translated into
two or more lines, but I think that is worrying too much about
theoretical possibility, so checking line count would probably be
sufficient.

Thanks.
