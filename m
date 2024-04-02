Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC1B78B63
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 12:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060459; cv=none; b=fBaJeJnoeGbBOV8MMrVb0oNYJrv1KwR0upZkRJ3IRgGsE/dUIEf2V0uOBURWOqyW/WakNaSkY6bbAHm4X0xsuDtVvFaoLjEs96yH0E91CI2ds+8tZOpjsUZf/K03XAPL4w8RF+icZABKh7WsqR/L05n9ER6rgq4QZ/vHmk4Dqvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060459; c=relaxed/simple;
	bh=HNTlBCbxyDAg2yhfkIRg24DBzywS5XvrvauBAWc8w9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXBHxjwp2fOvnDXe7bhRqvVSkzPl8JbWgCtUZW3TxuEVEr3NL05cTsaV9JMx3zsLiyXGMQegU2VwrmTaRiJTfi1bxWbtT8pN8+OH1BgATa47HoMkMilN22zjX4maV87hwu9NLz2qUigV7qq2+2WC6BC2lpHEJCMGIjOCygThWfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ew1lyH+e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vZFXZXt/; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ew1lyH+e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vZFXZXt/"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id E2DF81C000F8;
	Tue,  2 Apr 2024 08:20:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 02 Apr 2024 08:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712060456; x=1712146856; bh=BdXr104n6J
	h9F5A/c4M0YSr/ZZmuZ627UI48ZUz0HF4=; b=Ew1lyH+espZTDxr2/hTWEf5PRi
	JCjnp28csKXFsAZdXd8tneBAGgg7WaQN3Ag4rZ5tIpUgKcwUEm5iQjilQPWkaWzR
	Q1xHFJGAW1FRLZps9QKRNq0JU6Lst3Uio0HStHxxX1lmUQWBdWjKf0WX1omY0iBc
	LoRvQ1EVMxuYagpOCTk0bdMTWtMzH/DXYfsd/2ReiDhPIw0n7jWALN41ZBW3rzNI
	pTJWNk6GcRbrmV1k8nmBVZ6QXthAhNywo0UT3eLBKJ0xb7utfqVDwuLRQuNrdk4s
	ZpSSbj9U62e8ApgEVEU9WjII0UIyWkqMabU8fiFvSUE91/Ii2/k1vDkbzARQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712060456; x=1712146856; bh=BdXr104n6Jh9F5A/c4M0YSr/ZZmu
	Z627UI48ZUz0HF4=; b=vZFXZXt/t2K6ZEAyM3GEMDwFNDPUkdxm434sWIbYP4Uo
	CaPr8zY3XGmG6ZXymEPtunnqOHn/aTXtiUiaKedH0LbHzdAO/JHqtTx6eAV9OXDR
	CCuyQIcD+rHkGZ1v2ept8Iqi1LcBqkmBLIrGP8vgZsj4gukJZBzmG5BtE/XNMZ2+
	381skjI+MYqdERC18seLRL8Aky/0TC9C6Jv8Y4RgjmTjaw0/e07gZilt7zaaO2Ea
	Qz9Jj47kxEX3BsKvqvuKTtteY2cX+xCEJ0QSd9uQkJ8d4qiS0BA9QEbq3jGafMSG
	qc2bir3MVSxHVqAN6NGPeMLXerPtjA4pnWjWhCE9Bg==
X-ME-Sender: <xms:KPgLZoSENDLOQgI0FJYHb8wqRaxe2glpptao75XLB-f_Q2nwvvyS4g>
    <xme:KPgLZlwgEXmirFJhb7nttBaGgXxmO-G-IKqBcqZNBrUyOTF1EvyvY4QxaqG_IT0nE
    xEuNg8oS7kHD9vF9w>
X-ME-Received: <xmr:KPgLZl3HjYM5zYdEKrzzLj2odPIg-IH3JuQR9ShfdISuuH3BrWyz49b7Mgh5Z9z0z87-ExDPi-B90bh0ZIokG2PLyUpLQ9LIA8Q5QhttQ-gmvXU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:KPgLZsDcGhmxbbRricZWZAYdp-ojtIbVn0WFE-iBDIKCUqMXo_wO1g>
    <xmx:KPgLZhhCCBCDE8zpunGlQYRObVBm6wKHs0NNYWQ3xwuBj1ogNegebg>
    <xmx:KPgLZopQ7H3VHq3v9wA6qNOLuq4tijdaxYKqLr0-nu5s0p8tsvWs6g>
    <xmx:KPgLZkjYz0tRy5lB3ly5j7xM1xaHruzmORe4P8wc_QJP14vlYQalmg>
    <xmx:KPgLZmt9FkE0TZpECKWksJCE1kAzpJMfTNmVY5yN37_q-BZxJYjYID6d>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 08:20:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1670d480 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Apr 2024 12:20:47 +0000 (UTC)
Date: Tue, 2 Apr 2024 14:20:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 8/8] refs: support symrefs in 'reference-transaction' hook
Message-ID: <Zgv4JbwM3HNX_Ftp@tanuki>
References: <20240330224623.579457-1-knayak@gitlab.com>
 <20240330224623.579457-9-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YtjZpfWlWPEwyfDE"
Content-Disposition: inline
In-Reply-To: <20240330224623.579457-9-knayak@gitlab.com>


--YtjZpfWlWPEwyfDE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 11:46:23PM +0100, Karthik Nayak wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>=20
> The 'reference-transaction' hook runs whenever a reference update is
> made to the system. In the previous commit, we added support for the
> `update-symref` command in `git-update-ref`. While it allowed us to now
> create symbolic refs via `git-update-ref`, it didn't activate the
> 'reference-transaction' hook.
>=20
> Let's activate the hook for symbolic reference updates too. This takes
> the form `<symref-target> SP <ref-name> LF`, which deviates from the
> form for regular updates since this only contains two fields.
>=20
> While this seems to be backward incompatible, it is okay, since the only
> way the `reference-transaction` hook outputs this syntax is when
> `git-update-ref` is used with `update-symref` command. The command was
> only introduced in the previous commit and hence only users of this
> command will face this incompatibility.
>=20
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  Documentation/githooks.txt       | 13 +++++++++++--
>  refs.c                           | 17 +++++++++--------
>  t/t1416-ref-transaction-hooks.sh | 27 +++++++++++++++++++++++++++
>  3 files changed, 47 insertions(+), 10 deletions(-)
>=20
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 37f91d5b50..ae9f02974d 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -485,8 +485,7 @@ reference-transaction
> =20
>  This hook is invoked by any Git command that performs reference
>  updates. It executes whenever a reference transaction is prepared,
> -committed or aborted and may thus get called multiple times. The hook
> -does not cover symbolic references (but that may change in the future).
> +committed or aborted and may thus get called multiple times.
> =20
>  The hook takes exactly one argument, which is the current state the
>  given reference transaction is in:
> @@ -513,6 +512,16 @@ to be created anew, `<old-value>` is the all-zeroes =
object name. To
>  distinguish these cases, you can inspect the current value of
>  `<ref-name>` via `git rev-parse`.
> =20
> +For each symbolic reference update that was added to the transaction,
> +the hook receives on standard input a line of the format:
> +
> +  <symref-target> SP <ref-name> LF

I was wondering whether we want the format to be a bit more explicit.
The proposed format works alright because refnames must not contain any
spaces, and thus it can be disambiguated from normal ref updates. But
it's rather easy to miss for authors of this hook.

I don't really know of a better format though. We could of course prefix
things with "symref:" or something like this, but that might not be a
good idea either. In hindsight it would've been clever to have a
specific prefix for every single ref update in the reference-transaction
hook. But well, here we are.

Patrick

> +where `<symref-target>` is the target of the symbolic reference update
> +passed into the reference transaction, `<ref-name>` is the full name of
> +the ref being updated. To distinguish from the regular updates, we can
> +note that there are only two fields.
> +
>  The exit status of the hook is ignored for any state except for the
>  "prepared" state. In the "prepared" state, a non-zero exit status will
>  cause the transaction to be aborted. The hook will not be called with
> diff --git a/refs.c b/refs.c
> index 706dcd6deb..d0929c5684 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2342,16 +2342,17 @@ static int run_transaction_hook(struct ref_transa=
ction *transaction,
> =20
>  	for (i =3D 0; i < transaction->nr; i++) {
>  		struct ref_update *update =3D transaction->updates[i];
> +		strbuf_reset(&buf);
> =20
> -		// Reference transaction does not support symbolic updates.
>  		if (update->flags & REF_UPDATE_SYMREF)
> -			continue;
> -
> -		strbuf_reset(&buf);
> -		strbuf_addf(&buf, "%s %s %s\n",
> -			    oid_to_hex(&update->old_oid),
> -			    oid_to_hex(&update->new_oid),
> -			    update->refname);
> +			strbuf_addf(&buf, "%s %s\n",
> +				    update->symref_target,
> +				    update->refname);
> +		else
> +			strbuf_addf(&buf, "%s %s %s\n",
> +				    oid_to_hex(&update->old_oid),
> +				    oid_to_hex(&update->new_oid),
> +				    update->refname);
> =20
>  		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
>  			if (errno !=3D EPIPE) {
> diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-h=
ooks.sh
> index 2092488090..fac5d5fc6d 100755
> --- a/t/t1416-ref-transaction-hooks.sh
> +++ b/t/t1416-ref-transaction-hooks.sh
> @@ -83,6 +83,33 @@ test_expect_success 'hook gets all queued updates in c=
ommitted state' '
>  	test_cmp expect actual
>  '
> =20
> +test_expect_success 'hook gets all queued symref updates' '
> +	test_when_finished "rm actual" &&
> +	test_hook reference-transaction <<-\EOF &&
> +		echo "$*" >>actual
> +		while read -r line
> +		do
> +			printf "%s\n" "$line"
> +		done >>actual
> +	EOF
> +	cat >expect <<-EOF &&
> +		prepared
> +		refs/heads/test TESTSYMREF
> +		refs/heads/test refs/heads/symref
> +		committed
> +		refs/heads/test TESTSYMREF
> +		refs/heads/test refs/heads/symref
> +	EOF
> +	git update-ref --no-deref --stdin <<-EOF &&
> +		start
> +		update-symref TESTSYMREF refs/heads/test
> +		update-symref refs/heads/symref refs/heads/test
> +		prepare
> +		commit
> +	EOF
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'hook gets all queued updates in aborted state' '
>  	test_when_finished "rm actual" &&
>  	git reset --hard PRE &&
> --=20
> 2.43.GIT
>=20

--YtjZpfWlWPEwyfDE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYL+CQACgkQVbJhu7ck
PpQLaQ/+Oi7v/dIm+pkOy1V9M22rQ6+K35X1ZOvXSYDE8R6vd/B69fopWpvvybM3
9eYtJF47C0GH8Esr9U6pf3ByqxlcMCFN0k0zQPtQVwNxJPJR4kZoUci8Q0oBlGfy
upRPhXNFS3UBBK8RzyxOs3MSIxxvMs/22qpXTE3kdEDms1o5tVT0YKp+MV2GX53U
MrHRH13NY/wfI9hGljWW9eBc+I10VmOCNcLW80o0q087dB9LYjNMl6WIuZpmM9QU
2JXGTvC5AUpV2yuwZvi3z04iBNDv3YunvuQAORo+q2dMKowjGAXylhDApq4uh4N7
USctEFmzbSaZRqQWnUI2K+kb+jwZMDhkp8Mjvt++GOwknvJNsXM5BUSeYdH0LSgY
okF3t+oCcEBiIiaMTkBswdNrR/iryxgCrEBr36tz5uDqVvf88AcsSuypzvZ8oToM
jpxL0LOh3dfOZ+R69iYbejx+1HYClIZCDIGjicekg+QmR9mYF6BPOOtZ3Ew1Ocyf
TGRTZpTgZpSfJCZv/5GHrPCK9a7GOL1Xtg9F35NhuA+D5F4y6T6fTzVNNpRLYIRa
YeTUboPSFBZY4yeeYXJDZ91ItpAP+oh3BetWTqo3iVPRjDP98np0zwjqgXNxFcUU
xejEX4V2xeep422ndaoplVG/qAu92MUEKZMhusjrYa29vbIwIpY=
=4aIt
-----END PGP SIGNATURE-----

--YtjZpfWlWPEwyfDE--
