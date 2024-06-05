Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D3F1922FC
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 08:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717574537; cv=none; b=ldI/84RXttS8FC50tmanjordhwm9T5kI/7dZqORAJ2zRPeIj/64zXfsjfKXebL2y2oQz0BSfwHKjLMTSQtr/GcHbuwnxKMl+u3H6U2betAux4d2XUNEadBLcEZBqgbfsVfW+DBLL6z9Idnz+qbODcjfYsoYYvvYRv26notJ+9mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717574537; c=relaxed/simple;
	bh=pLAaD2nt8OyRVEHzTtvMYWNVjdl9R8kpSJnJrfh/SL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPsmscnNAW0Ab7PUJAjKXbE7+3VGddfdP85f77ENLgktrvwD8+UhEU5MPH3AFGQ9hN4eHiYtGrbBvGfIhZD+Y4NDnuyzzRREqnQ+C+Ua2pfwUwQCDO/VuE2ItYp28GKOesuVWWlwkxKNRi/qQvUNAEmNwOyGWZtJy70jMcx9OsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BNU96udS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pgHNdB92; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BNU96udS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pgHNdB92"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 78A051380178;
	Wed,  5 Jun 2024 04:02:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 05 Jun 2024 04:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717574534; x=1717660934; bh=M22eQKHx5C
	qnRgTF5NePMKgTtqEsc9mLoB/QwogDM9k=; b=BNU96udS/pK2L4wsb5vV+2LXeW
	IgV1MPJuTrDyx0RNJ+G0ogxxoM6x6OhAJWIObIqh8gXlIaqy49Q28KPC8AXKov4D
	7ThRI3Yaqe2/s8yjXxpHiKzH+ssxQ5q+wCzhmg9Bw7uwrNctrfSrk9HJrW7RHep2
	FnlTeMapk9ZwISTkIz3x7FgGBfLqvhDFOw2Syr14SJ00+BAUheW6LA2tW+yMpf2Z
	G9uZdST2gtuynuuiNz+Gpk+ElU4NRWuhHva1mHw5Z2kwTWFUuHIsq3dmIKymbCi9
	dKvGxbwtM8w7f3hg8H4+B5AA4VXONQDxBV5pBs8k0FEeCsIGOLolhtSoyD8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717574534; x=1717660934; bh=M22eQKHx5CqnRgTF5NePMKgTtqEs
	c9mLoB/QwogDM9k=; b=pgHNdB92QR4gj0+BgQ4HrVPHWb+zx2UOSHljURwl1FWz
	eWBena/czRm2akV0gdzw3fWpAfOD4aflfzk1zJZBYkYMGket8yadT5uH2ck1seeK
	pWYbBdm0Js6V+VaEQi3DTbG7V8PSfj6pTMZa2mZnnWgAybJ+9767MLO/poSQDUCh
	uLj7TqAlPDh7YKwpXeFiS6ty7Esj3mWX6E6Pvk6XO2w7O5xyimm/VpIzHLZeIAa+
	ufn6yNeYvmNfdViJXd3kWJkztnDQsliHZVQGc2RbuX+UA3bjiYzI5vBNTb7WC+2Z
	3OFkBongBWhtzX3BU7iOkXuSZe4Tr5wo1BgY57pZ2w==
X-ME-Sender: <xms:hhtgZiCmFaf069y23Qr9vJUIupsmgefyIFfRDb6peeRfFKEw5ZWrYw>
    <xme:hhtgZsiX7sRisC2OcE49j1Z9ZQP7h8GZ7-At5fqGfPX_wvXjJEf6tkjXNO-811PHa
    5TVhv5YA_yPKSPnmQ>
X-ME-Received: <xmr:hhtgZlmotInag1uEG-ZfJL7Mb0oasp-t2LcuAYr23eHsPiQKVIA7V0sNl_bR0r71HXdP_ROHK0YYZaRG_1qL8Ydd7AfOcRbRqKTlNcAa5bxVgljVbOE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelhedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:hhtgZgwQG5ZsTdI3NjFt6060akZBFx7y5PkS4_t-FKD8_98yXJd1AQ>
    <xmx:hhtgZnRhRKkRAWpBNs5u0kAbqkK_4ma3LYwvItENIcYUDo4M1llFfw>
    <xmx:hhtgZrZSgnE9YJoxV6ZJ8pNIJ3LrBikfX5J7hNYatWhJzF4RBwVX1A>
    <xmx:hhtgZgRNMvFB9K2qhtGbgOOW6cLamPlwBIu0KXk5ChnLpEUVrc3WGA>
    <xmx:hhtgZhcZIndrPy-lwkKAswHZo1E3I8qymPnsZkGqqW9MBeHOWH7R9F-u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jun 2024 04:02:13 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 892f7847 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Jun 2024 08:01:42 +0000 (UTC)
Date: Wed, 5 Jun 2024 10:02:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 3/6] update-ref: add support for 'symref-delete'
 command
Message-ID: <ZmAbgGfNpZzU76pd@tanuki>
References: <20240514124411.1037019-1-knayak@gitlab.com>
 <20240530120940.456817-4-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pWDCdFVmGqKYprJW"
Content-Disposition: inline
In-Reply-To: <20240530120940.456817-4-knayak@gitlab.com>


--pWDCdFVmGqKYprJW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 03:09:37PM +0300, Karthik Nayak wrote:
> diff --git a/refs.c b/refs.c
> index cdc4d25557..e29abebe1d 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -950,7 +950,7 @@ int refs_delete_ref(struct ref_store *refs, const cha=
r *msg,
>  	transaction =3D ref_store_transaction_begin(refs, &err);
>  	if (!transaction ||
>  	    ref_transaction_delete(transaction, refname, old_oid,
> -				   flags, msg, &err) ||
> +				   flags, NULL, msg, &err) ||
>  	    ref_transaction_commit(transaction, &err)) {
>  		error("%s", err.buf);
>  		ref_transaction_free(transaction);
> @@ -1283,14 +1283,20 @@ int ref_transaction_create(struct ref_transaction=
 *transaction,
>  int ref_transaction_delete(struct ref_transaction *transaction,
>  			   const char *refname,
>  			   const struct object_id *old_oid,
> -			   unsigned int flags, const char *msg,
> +			   unsigned int flags,
> +			   const char *old_target,

The old target is somewhat weirdly placed here, as I'd have expected it
to live next to `old_oid`. That's only a minor nit, nothing that's worth
a reroll in my opinion.

> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index 52801be07d..848d6fc42e 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -1731,6 +1731,60 @@ do
>  		test_cmp expect actual
>  	'
> =20
> +	test_expect_success "stdin $type symref-delete fails without --no-deref=
" '
> +		git symbolic-ref refs/heads/symref $a &&
> +		format_command $type "symref-delete refs/heads/symref" "$a" >stdin &&
> +		test_must_fail git update-ref --stdin $type <stdin 2>err &&
> +		grep "fatal: symref-delete: cannot operate with deref mode" err
> +	'
> +
> +	test_expect_success "stdin $type symref-delete fails with no ref" '
> +		format_command $type "symref-delete " >stdin &&
> +		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
> +		grep "fatal: symref-delete: missing <ref>" err
> +	'
> +
> +	test_expect_success "stdin $type symref-delete fails with too many argu=
ments" '
> +		format_command $type "symref-delete refs/heads/symref" "$a" "$a" >stdi=
n &&
> +		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
> +		if test "$type" =3D "-z"
> +		then
> +			grep "fatal: unknown command: $a" err
> +		else
> +			grep "fatal: symref-delete refs/heads/symref: extra input:  $a" err
> +		fi
> +	'
> +
> +	test_expect_success "stdin $type symref-delete fails with wrong old val=
ue" '
> +		format_command $type "symref-delete refs/heads/symref" "$m" >stdin &&
> +		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
> +		grep "fatal: verifying symref target: ${SQ}refs/heads/symref${SQ}: is =
at $a but expected refs/heads/main" err &&
> +		git symbolic-ref refs/heads/symref >expect &&
> +		echo $a >actual &&
> +		test_cmp expect actual
> +	'
> +
> +	test_expect_success "stdin $type symref-delete works with right old val=
ue" '
> +		format_command $type "symref-delete refs/heads/symref" "$a" >stdin &&
> +		git update-ref --stdin $type --no-deref <stdin &&
> +		test_must_fail git rev-parse --verify -q refs/heads/symref
> +	'
> +
> +	test_expect_success "stdin $type symref-delete works with empty old val=
ue" '
> +		git symbolic-ref refs/heads/symref $a >stdin &&
> +		format_command $type "symref-delete refs/heads/symref" "" >stdin &&
> +		git update-ref --stdin $type --no-deref <stdin &&
> +		test_must_fail git rev-parse --verify -q $b
> +	'
> +
> +	test_expect_success "stdin $type symref-delete succeeds for dangling re=
ference" '
> +		test_must_fail git symbolic-ref refs/heads/nonexistent &&
> +		git symbolic-ref refs/heads/symref2 refs/heads/nonexistent &&
> +		format_command $type "symref-delete refs/heads/symref2" "refs/heads/no=
nexistent" >stdin &&
> +		git update-ref --stdin $type --no-deref <stdin &&
> +		test_must_fail git symbolic-ref -d refs/heads/symref2
> +	'
> +

Not sure whether I overlooked it, but one test I missed was when trying
to delete a non-symbolic-ref.

Patrick

--pWDCdFVmGqKYprJW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZgG38ACgkQVbJhu7ck
PpQfdw/9GLF78uDo0FfoOFMqKxMFgeKgUiJYjpVzgWWhX4Da1jyF5j5raGXIaT2f
BEdB+woYEVewcq0MkZFjlwaekv/Yn+lVZzLy/wpRSpLOFMhJdmwajbAmyvagBaI5
9y0KlkB0VlUs9rZs5ftjosbuf/9eJ+9SUP7dh5uQR/oCvBKelH3arlIIc51HAffi
oAmmrOdhLSgS9eSbDwvC6aHwiqQtGO8Vy+c8KOl47/qMwS4l1xxzmCaZTZSSJ9sI
fZOcVC5rfoPxE9iz4szzlxWyIoyB5/qpZNEMT125NrDIi5WSWdkvCOKoI8E1+DaT
OP32MoX7y2TuhF4o+RuLXSOir5ziKbwLhTneVpb27ahwFrAX9Yu3aVLQD06hjQMd
wZz4l6YjFhH1w4vge1CoTmxT8o11U+a5Am9O+185nRq284fAUy5yURUXNzDa5D87
yzIFcJuu1lTsr0S915MEZP3vs0NbuSr0cpLoyrPJSj4f/OxxzGejihWsAZyJxy/h
u6QJ+o0l6m0WAG6yJUWxpGiTBvcWNNQEILX8rEFH9YTa9tqsKqktJvg1ep2+E/ZS
u00zjrvhASOVKUmFFv1374YM+DailA9VZwYnIT8S+241QsQRtTWCxlFvf0RN/PVl
YhrkH5555NaJdu1bTwUa9q0W0EahyZK9b+vdEWtSGq45DxkYIaw=
=/c6i
-----END PGP SIGNATURE-----

--pWDCdFVmGqKYprJW--
