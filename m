Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BB710A09
	for <git@vger.kernel.org>; Fri, 17 May 2024 05:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715922942; cv=none; b=RWwmBQbcUTQTV6uLeH1X/BJbzGZydqTH6F4AiEeTenM+NrTh9IC69zuksouVqigOPtTYe9VoeyqzvoCyP4Re4+SMSOkECI0XG8aK3dDuVFxUchSgNhLUWzTef0JyYynTOFuPsHF5F+PVxLq1pOzMsTLjDVh3XqBRae00A6HWhRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715922942; c=relaxed/simple;
	bh=bmDkY6zTJjDj9rdSivxFhW8StiqdMr3ZB+FqZJf214g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+cBROInGpdicNMczYCWDKQjR2RIrFc91YF1oJN0sYbFjWPEEigsMJKsT23SRnf0RFcDnJhi4wZ0iXCc1wzKzgvpWDVxuJBsFtbxbz1hku7G66MF6XPUduKYsmTZcbub4X7Aapc779habv/sNswvUDZINR+c2yiKlm79Ve2sqQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XEDXyW3e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bso9B+0J; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XEDXyW3e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bso9B+0J"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 71F5C138035B;
	Fri, 17 May 2024 01:15:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 17 May 2024 01:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715922939; x=1716009339; bh=ay+agDyHr+
	ogVa13Qi9ZItM57Vdog5GXVPRucK8Urzc=; b=XEDXyW3eyY2KumXRl/4If1ezc4
	Pq1LexLVCO61hWEl5Hbbvf/mA93PvQBhn5Qkex/dGL5HxM+y5LS54NrOL2P0P6mJ
	b3KOvv+3y+gziW3eyb/OlGf2mboCAKpPUKhoQ8nNpb+ffsyNm6I9wh8ESTA0RqtL
	BAdrEMygvdSwE8k6vyov74weVmLuRS7OgHRMnZoLkBuw97qJgKdNsiCDkZmwdGbG
	+HkXBPmOA50LLj4GXQ9a7VL7xY1KEWiur2OCZH8o4kZxsxJvF7+4Pz0PzyL7SAJf
	5WNtDC4P61+Y5DZTmsjfBPPz1Hj38jS0X1JsUtxg8cCzWmBHeIx7rpKIqOzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715922939; x=1716009339; bh=ay+agDyHr+ogVa13Qi9ZItM57Vdo
	g5GXVPRucK8Urzc=; b=Bso9B+0JFDyxDTjQ290hwEZMvGbpae3pOuEHZW4RbvXT
	NLVT440+cZE1Uxd6RZJGjwEtcpEbDJ6HFqJC0kD9mz+XMrJjZxCK0qIEoX0aWNG4
	x7hQftr03plBDdcI6WnIhh3ambxLyeuDKBBN5EaBkQZlLhDCSDZjVCdo1yY1ko0v
	UWN+wKG5xnkVp8pX7RpcmNFjYXhdHvk+M5qYoy78cXodUKOv/itROBXqiAyXOA6N
	XCb1UzQBf5obUzjCOh6ps9xZIt1+i825AnJYvDY0+2saOoaXIc097zfFYkcT7iZo
	Cbst1cLvupjqFKB7k27OC7ptPXKPuUomvsIO9t1TeA==
X-ME-Sender: <xms:--dGZhxbPRtTxRS0dfpceqzOlFDwZ9Kcf47POb1ANe5ugeZ45c1UUA>
    <xme:--dGZhQPwUaHoviAe8HLAOrDn2yqq7JLh7SMyvzgMvsaUtZqfnli09iwPM5MrhAfz
    T-3_2cvKBJXxrs8Ig>
X-ME-Received: <xmr:--dGZrW7j8mpU842C225k1In9KqPgEItJaVOlW73j5fHr21_0OZkwx85e24H9U0f9MUmIBrkYKaIFclXYRq98bIrB31qeHw3U5M5Ot29Cg6eRa7brQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepieevkedtgffgleeugfdvledvfedthfegueegfeevjeelueefkeegfeffhefglefg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:--dGZjj2ljrs54Z6FQgZPo0MKPmHG2goM7M5fPndW7WrnlZXSoADwg>
    <xmx:--dGZjDqYFv13U3R3UfggoRHBwVB1aqbGFeCKYDuxHRpkBnC-MzazA>
    <xmx:--dGZsJy0f-msgZjoo_hSpE8s03iHcVt0rwPBNp7SR97W9KTQc0xqA>
    <xmx:--dGZiC6vZI9qyxqnlA2yAH5o5_ODQj0NERzKnK3mfCYxg89pOuBFQ>
    <xmx:--dGZqOu-AluLO8o9IA-_m94R4hVUTVxr8jv0h9T3FPCE4qlnQTH-3wh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 01:15:38 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 677f8caf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 05:15:10 +0000 (UTC)
Date: Fri, 17 May 2024 07:15:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] SubmittingPatches: add section for iterating patches
Message-ID: <Zkbn9_-cOiapWSSb@tanuki>
References: <20240514123039.1029081-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MBk1A3Mh+cnP5YLG"
Content-Disposition: inline
In-Reply-To: <20240514123039.1029081-1-knayak@gitlab.com>


--MBk1A3Mh+cnP5YLG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 02:30:39PM +0200, Karthik Nayak wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>=20
> Add a section to explain how to work around other in-flight patches and
> how to navigate conflicts which arise as a series is being iterated.
> This will provide the necessary steps that users can follow to reduce

s/This will/This provides/

> friction with other ongoing topics and also provides guidelines on how
> the users can also communicate this to the list efficiently.
>=20
> Co-authored-by: Junio C Hamano <gitster@pobox.com>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>=20
> This came off a discussion wherein I sent a series based on `next`
> instead of merging in conflicts [1]. This is mostly worded by Junio and
> I've just put it together into a patch.
>=20
> This is based off master, with 'jc/patch-flow-updates' merged in.

:)

>=20
> [1]: https://lore.kernel.org/git/xmqqy18lpoqg.fsf@gitster.g/
>=20
>  Documentation/SubmittingPatches | 79 +++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>=20
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPa=
tches
> index 8332073e27..2fd94dc8de 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -608,6 +608,85 @@ patch, format it as "multipart/signed", not a text/p=
lain message
>  that starts with `-----BEGIN PGP SIGNED MESSAGE-----`.  That is
>  not a text/plain, it's something else.
> =20
> +=3D=3D=3D Handling Conflicts and Iterating Patches
> +
> +When revising changes made to your patches, it's important to
> +acknowledge the possibility of conflicts with other ongoing topics. To
> +navigate these potential conflicts effectively, follow the recommended
> +steps outlined below:

Okay. I was first wondering why we only mention conflicts when revising
changes. But I see there are other parts in the document where we
already mention the potential for conflicts, so this is fine.

> +. Build on a suitable base branch, see the <<choose-starting-point, sect=
ion above>>,
> +and format-patch the series. If you are doing "rebase -i" in-place to
> +update from the previous round, this will reuse the previous base so
> +(2) and (3) may become trivial.
> +
> +. Find the base of where the last round was queued

It's somewhat unusual for bulleted lists to start with a dot, but this
is consistent with the remainder of this document.

[snip]
> +Do not forget to write in the cover letter you did this, including the
> +topics you have in your base on top of 'master'.  Then go to (4).
> +
> +. Make a trial merge of your topic into 'next' and 'seen', e.g.
> ++
> +    $ git checkout --detach 'origin/seen' &&
> +    $ git revert -m 1 <the merge of the previous iteration into seen> &&
> +    $ git merge kn/ref-transaction-symref

Let's remove the trailing '&&' lines. The leading dollar indicates that
this is interactive, so you wouldn't concatenate the commands like this.
Also, preceding code didn't have it.

> +The "revert" is needed if the previous iteration of your topic is
> +already in 'seen' (like in this case).  You could choose to rebuild
> +master..origin/seen from scratch while excluding your previous
> +iteration, which may emulate what happens on the maintainers end more
> +closely.
> ++
> +This trial merge may conflict.  It is primarily to see what conflicts
> +_other_ topics may have with your topic.  In other words, you do not
> +have to depend on to make your topic work on 'master'.  It may become

I think there's either a word too many or missing  -- depend on what?

> +the job of the other topic owners to resolve conflicts if your topic
> +goes to 'next' before theirs.
> ++
> +Make a note on what conflict you saw in the cover letter.  You do not
> +necessarily have to resolve them, but it would be a good opportunity to
> +learn what others are doing in an related area.

s/an/a

> ++
> +    $ git checkout --detach 'origin/next' &&
> +    $ git merge kn/ref-transaction-symref

Same comment here regarding the ampersands.

Other than that the additions look good to me, thanks!

Patrick

--MBk1A3Mh+cnP5YLG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZG5/YACgkQVbJhu7ck
PpQBlQ//aTvZzT2ibs5zRD7RDqVkyAssNs2hC6dCIiXZpBpJI3WNFb0cdMCrhkNx
pLL3h1S5unFjnmCp8QGNqy8bewltWDrx+eAfe+4pURMSj4QIwBXQLQ8uHQakDYpG
uRqD2qto2jJLqRVHotp+2AndH8sXbp34DfjIYtvvxxHnYptZaoXs8zioVFFZNvJ7
RIGTPow3GAxf5cCepO88JemEBBPvTzZ/RVJLPgJl3CcmqJd4BEm8YmIP/QlNqlnf
LK295C8sXV1GnU2FQg9z3k1Au8P6A5MJ8hyvBHwwD2Ehwa28TetVrqdGYY8qYegl
avrPNwEDTxM/ggV9ky31cvptIubHuoh02ed/URu5721WK+lvZ01kEEdKY/fvWVn+
2mAu7HXEWnTwG6VdzDY5gIUuQcE4qwBwsnd/i/JmmWN1J23rp82lR/uG6mn2XAi+
/w/ULD+EchJ+/zYAnjIAZG+7k9i+en1bG31rvWD9249LbyMecJ2DdFzCM4co2N7P
WtZK53imu/trZWje5KEjkO4a3pTUYfGP/8GUxlbg7HbxZe3CDUHdOU/zgdfPdDWX
NeDM2X1l4JLovztLGG1B5/IPdUkNXqtbi34sfkVMs/vGrZvE8AwNKAfb9BxhRBx/
IZ3xB37X9GcEzEKfxCJtDOAtM1pZFZHw4wOIi7C6rS9BiBsW9AE=
=1WL3
-----END PGP SIGNATURE-----

--MBk1A3Mh+cnP5YLG--
