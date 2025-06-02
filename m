Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD85BA49
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 00:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748823202; cv=none; b=q5Ux3z1ROZ/F6BXDuWJRZwoC9ipvZ6+JMXjDsESfqFhE1wFc8arGVAq38kpV7cf3tywFmej7Fpg34M1HW+D707wLUE2P4WkUAMuMLpxDPWmSJwDJOHKgCKwPl4NZjy8SPTFAQA5pPuUTANNcY6JEpKxEhNYUO97eVmf99AtNQzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748823202; c=relaxed/simple;
	bh=YXuEqbhsdl215hHSe3c9XAfqqJ+w6o9qduV/ZUlqQEA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lImuoLOSoOUJ+eCi31d3FyOHICSi6zPrQDpcqwneJC90xN/ora4XRFtDGbHc+OWgTX5Zy8gMduleqqMMiVePsAWBaYa/ej3WlSkUTE3S0XiVeOYVf6ty1u36XAsbRofMxAHt6qH3B92lRWrqD3WyQPVjsqIdWUx7IkXM3bmMw6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xafczegT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D9VwsuTU; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xafczegT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D9VwsuTU"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E602E11400E6;
	Sun,  1 Jun 2025 20:13:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Sun, 01 Jun 2025 20:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748823194; x=1748909594; bh=pLpp2n7Qis
	wRtjVXOGraZlHlJtXqnYVVoSXFvZKiskg=; b=xafczegTXS5rmB7B3h0/4sjJhD
	7kqgc8FqMFx5z9Z7M/qo2Mpqi0aOYWOkaChONgr7zT1f0pTo6fBT7t3bt6TvzgnJ
	RVAHyRoHBfQvQCi3T4kZYV8DpfQU4Y9hyU8gNNP8PZqZNRuMqkuj4LbsFeZTt/Hp
	uSZzfL6/vXP0d9rRdPIxhW+3HdfMk6rU3IVqXX8LoZw0n05VEj2F0vyOLHiafEvT
	q1Jp/EInSYuZKjMb27LvptrHegHipkBXzfSi/Bvov1ZBuXN7Yb8ESqzAgr11NQ1n
	uX8q4QYo1alwY9L6DizhJgxFWl64vhmPaROcwGEkGf2A5bzBQxrcKqNhQ7Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748823194; x=1748909594; bh=pLpp2n7QiswRtjVXOGraZlHlJtXqnYVVoSX
	FvZKiskg=; b=D9VwsuTU7t4K0BIZAOm/0w0i6LF54Xsn/9y4RRnMAmdT4s0LqTq
	R1ji4lB0Pnx/p59tTP4Uop9K83NwHESkV1aWB3cJ54JgMkxgmj5ScvX6RyBFYLIG
	38Kf5iFmQVkYOAiRDRpW5V/YyMKNQwtX7h/PL/TI31uk7QFDvkrKijCuPIxsTTws
	e9wyqhhHOiNs0OFIYkMJqkcXT7y+4OvoQK85DEb2jomP7lryUvfE3H1Dd3wInxZa
	TsSUm2U3ValbKW8GxCrQinX8v043n07+w05M5ryIAepWckR4FA0mlMAeQzZ+f8ME
	dcvzd8qzdNuQUU9rn4gs4ZT8cjQW03hVLHA==
X-ME-Sender: <xms:muw8aJq3BPIjyj-jqtG42oEb63IAj1zlzJ2rceSD3ybtyOOrfwpTUg>
    <xme:muw8aLqk5F5m6ZNjiHzD5Aa3ZLgdz5f33QOeDRZfKski8-cB1FgzrbP8bbQ8QVmtZ
    2bTVX-45bxP28mv4g>
X-ME-Received: <xmr:muw8aGOXMfImxB7SGcEaOumYrGsB4kFuO9K5WR0Al45XesCcBnXvnPnTfC5oooWoLeCCipThCOSJA8m0ewUE1dBhKK734rzgE5pI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefiedvtdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeekkeehueeu
    hfffgfelleegheejleekleeitdeileeuveehjeeufeefhfetgeehteenucffohhmrghinh
    epihgvthhfrdhorhhgpdhgohhoghhlvgdrtghomhenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrghr
    ghgrughithihrgdtkeeslhhivhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgv
    tghordgtohhmpdhrtghpthhtohepiihihigrohesughishhrohhothdrohhrghdprhgtph
    htthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsggvnhdrkhhnohgslh
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfees
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:muw8aE7TR1se_MNA3thYjmbyk1F-CzHHcspf05oESrsYHWVfW9VxZA>
    <xmx:muw8aI7QmBHU5tHPnOGpIafw2lLcqMvOACspG1WUTpJa-qojZrY3jw>
    <xmx:muw8aMj8PrHamAoCn4fQXu8GrHNkByGGqZII6wZ7RTeZD7oDmvrsww>
    <xmx:muw8aK7i6vnLKE2aGna-xTT_R9vKT8M2cBa8Ls_2JgR6ZSYoXvYKTQ>
    <xmx:muw8aNEQGhTY5ptaWbU-VaGoQPlw70iWN7FHHZR2jBV8lbD4izSVr-Pf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Jun 2025 20:13:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Zi Yao <ziyao@disroot.org>,  "brian m .
 carlson" <sandals@crustytoothpaste.net>,  Jeff King <peff@peff.net>,  Ben
 Knoble <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v11 2/9] imap-send: add support for OAuth2.0 authentication
In-Reply-To: <20250601083821.2440110-3-gargaditya08@live.com> (Aditya Garg's
	message of "Sun, 1 Jun 2025 08:38:51 +0000")
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<20250601083821.2440110-1-gargaditya08@live.com>
	<20250601083821.2440110-3-gargaditya08@live.com>
Date: Sun, 01 Jun 2025 17:13:12 -0700
Message-ID: <xmqqtt4zvw4n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> OAuth2.0 is a new way of authentication supported by various email providers
> these days. OAUTHBEARER and XOAUTH2 are the two most common mechanisms used
> for OAuth2.0. OAUTHBEARER is described in RFC5801[1] and RFC7628[2], whereas
> XOAUTH2 is Google's proprietary mechanism (See [3]).
>
> [1]: https://datatracker.ietf.org/doc/html/rfc5801
> [2]: https://datatracker.ietf.org/doc/html/rfc7628
> [3]: https://developers.google.com/workspace/gmail/imap/xoauth2-protocol#initial_client_response
>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
>  Documentation/config/imap.adoc   |   5 +-
>  Documentation/git-imap-send.adoc |  47 +++++++-
>  imap-send.c                      | 179 +++++++++++++++++++++++++++++--
>  3 files changed, 218 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.adoc
> index 3d28f72643..fef6487293 100644
> --- a/Documentation/config/imap.adoc
> +++ b/Documentation/config/imap.adoc
> @@ -40,5 +40,6 @@ imap.authMethod::
>  	Specify the authentication method for authenticating with the IMAP server.
>  	If Git was built with the NO_CURL option, or if your curl version is older
>  	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
> -	option, the only supported method is 'CRAM-MD5'. If this is not set
> -	then 'git imap-send' uses the basic IMAP plaintext LOGIN command.
> +	option, the only supported methods are 'CRAM-MD5', 'OAUTHBEARER' and
> +	'XOAUTH2'. If this is not set then `git imap-send` uses the basic IMAP
> +	plaintext LOGIN command.
> diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send.adoc
> index 26ccf4e433..08ecb1e829 100644
> --- a/Documentation/git-imap-send.adoc
> +++ b/Documentation/git-imap-send.adoc
> @@ -102,12 +102,18 @@ Using Gmail's IMAP interface:
>  
>  ---------
>  [imap]
> -	folder = "[Gmail]/Drafts"
> -	host = imaps://imap.gmail.com
> -	user = user@gmail.com
> -	port = 993
> +    folder = "[Gmail]/Drafts"
> +    host = imaps://imap.gmail.com
> +    user = user@gmail.com
> +    port = 993

Nice to see such an attention to the detail here.

>  ---------
>  
> +Gmail does not allow using your regular password for `git imap-send`.
> +If you have multi-factor authentication set up on your Gmail account, you can generate
> +an app-specific password for use with `git imap-send`.
> +Visit https://security.google.com/settings/security/apppasswords to create it.
> +Alternatively, use OAuth2.0 authentication as described below.

The new lines added by this part of the documentation tends to be
overly long but with minor rewrapping you can stay under 75 columns
or so without too much effort.

> +If you want to use OAuth2.0 based authentication, you can specify `OAUTHBEARER`
> +or `XOAUTH2` mechanism in your config. It is more secure than using app-specific
> +passwords, and also does not enforce the need of having multi-factor authentication.
> +You will have to use an OAuth2.0 access token in place of your password when using this

Ditto.

> @@ -124,6 +159,10 @@ Just make sure to disable line wrapping in the email client (Gmail's web
>  interface will wrap lines no matter what, so you need to use a real
>  IMAP client).
>  
> +In case you are using OAuth2.0 authentication, it is easier to use credential
> +helpers to generate tokens. Credential helpers suggested in
> +linkgit:git-send-email[1] can be used for `git imap-send` as well.
> +
>  CAUTION
>  -------
>  It is still your responsibility to make sure that the email message
> diff --git a/imap-send.c b/imap-send.c
> index 37f94a37e8..4f3a1fb5b1 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -139,7 +139,9 @@ enum CAPABILITY {
>  	LITERALPLUS,
>  	NAMESPACE,
>  	STARTTLS,
> -	AUTH_CRAM_MD5
> +	AUTH_CRAM_MD5,
> +	AUTH_OAUTHBEARER,
> +	AUTH_XOAUTH2
>  };

These days, we allow and encourage ending the last member of an enum
with a trailing comma (cf. Documentation/CodingGuidelines) to reduce
future patch noise, just like you did ...

>  static const char *cap_list[] = {
> @@ -149,6 +151,8 @@ static const char *cap_list[] = {
>  	"NAMESPACE",
>  	"STARTTLS",
>  	"AUTH=CRAM-MD5",
> +	"AUTH=OAUTHBEARER",
> +	"AUTH=XOAUTH2",
>  };

... here for an array initializer elements.

> +static char *oauthbearer_base64(const char *user UNUSED,
> +		  const char *access_token UNUSED)
> +{
> +	die("You are trying to use OAUTHBEARER authenticate method "
> +	    "with OpenSSL library, but its support has not been compiled in.");
> +}
> +
> +static char *xoauth2_base64(const char *user UNUSED,
> +		  const char *access_token UNUSED)
> +{
> +	die("You are trying to use XOAUTH2 authenticate method "
> +	    "with OpenSSL library, but its support has not been compiled in.");
> +}
> +
>  #endif

Let's keep a mental note that the lowest layer of the auth_*
function can die() for the methods that are not supported.

>  static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
> @@ -913,6 +993,46 @@ static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
>  	return 0;
>  }
>  
> +static int auth_oauthbearer(struct imap_store *ctx, const char *prompt UNUSED)
> +{
> +	int ret;
> +	char *b64;
> +
> +	b64 = oauthbearer_base64(ctx->cfg->user, ctx->cfg->pass);
> +	if (!b64)
> +		return error("OAUTHBEARER: base64 encoding failed");
> +
> +	/* Send the base64-encoded response */
> +	ret = socket_write(&ctx->imap->buf.sock, b64, strlen(b64));
> +	if (ret != (int)strlen(b64)) {
> +		free(b64);
> +		return error("IMAP error: sending OAUTHBEARER response failed");
> +	}
> +
> +	free(b64);
> +	return 0;
> +}
> +
> +static int auth_xoauth2(struct imap_store *ctx, const char *prompt UNUSED)
> +{
> +	int ret;
> +	char *b64;
> +
> +	b64 = xoauth2_base64(ctx->cfg->user, ctx->cfg->pass);
> +	if (!b64)
> +		return error("XOAUTH2: base64 encoding failed");
> +
> +	/* Send the base64-encoded response */
> +	ret = socket_write(&ctx->imap->buf.sock, b64, strlen(b64));
> +	if (ret != (int)strlen(b64)) {
> +		free(b64);
> +		return error("IMAP error: sending XOAUTH2 response failed");
> +	}
> +
> +	free(b64);
> +	return 0;
> +}

It feels very strange to see auth_xoauth2() defined unconditionally
and leave xoauth2_base64() to die when built without OpenSSL.
Exactly the same comment applies to auth_oauthbearer() vs
oauthbearer_base64(), and auth_cram_md5() vs cram().

The reason why it looks strange to me is that I suspect that we'd
end up with an inconsistent behaviour like we see below.

For example, here, when we at runtime detect that ...

> +			} else if (!strcmp(srvc->auth_method, "OAUTHBEARER")) {
> +				if (!CAP(AUTH_OAUTHBEARER)) {
> +					fprintf(stderr, "You specified "
> +						"OAUTHBEARER as authentication method, "
> +						"but %s doesn't support it.\n", srvc->host);
> +					goto bail;

... the other end of the connection does not support the method the
end user specified, we gracefully fail like so, but we do not even
bother detecting at runtime that _we_ do not support the method the
end user specified, until ...

> +				}
> +				/* OAUTHBEARER */
> +
> +				memset(&cb, 0, sizeof(cb));
> +				cb.cont = auth_oauthbearer;

... this callback function, which is a stub when we do not support
the method, gets called ...

> +				if (imap_exec(ctx, &cb, "AUTHENTICATE OAUTHBEARER") != RESP_OK) {

... here inside imap_exec().  It is probably no use that the
imap_exec() call is prepared to catch an error, as the unimplemented
method would call die() as we saw above.

> +					fprintf(stderr, "IMAP error: AUTHENTICATE OAUTHBEARER failed\n");
> +					goto bail;
> +				}

Instead of making the lowest level helpers like cram(),
oauthbearer_base64(), and xoauth2_base64() conditionally be stubs
that die(), wouldn't it make more sense to conditionally define
helpers one lebel higher, i.e. those you stuff in cb.cont, only when
the user permits Git to be linked with OpenSSL, e.g.

#ifdef OpenSSL
static int auth_oauthbearer(struct imap_store *ctx, const char *p UNUSED)
{
	...
}
#else /* !OpenSSL */
#define auth_oauthbearer NULL
#endif

and then write this part of the code more like this?

		} else if (!strcmp(srvc->auth_method, "OAUTHBEARER")) {
			if (!CAP(AUTH_OAUTHBEARER)) {
				... the other side does not support ...
				goto bail;
			}
			if (!auth_oauthbearer) {
				... we do not support ...
				goto bail;
			}
			memset(&cb, 0, sizeof(cb));
			cb.cont = auth_oauthbearer;
			if (imap_exec(ctx, &cb, ...) != RESP_OK) {
				... we both support but we failed ...
				goto bail;
			}

Exactly the same comments appli to other methods.

Including "CRAM-MD5", that is.  That one may have been iffy before
you started touching this file, but it is not a good excuse for
adding two similarly bad code in the patch series.
