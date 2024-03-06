Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ECA86621
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709728682; cv=none; b=OGkvZ0pKUNvmyFsv2boywrUSxrEPkOkTgQr8QyiUB89hjy9NGa/e94RS8qsAT4fjRelGRdq2JLYFEGf6m1v6hhoVF4B+pBYCUsRn0nx8q0SFWE9iKG1q18nNdDws+ABmTH10jEnJxWXzGCZ3dftcbKKLQFvWw1G07xuM4q9iLUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709728682; c=relaxed/simple;
	bh=r9PxBpW7cb9yMDpnWgjAwL/r2PRSJgArQWjNWdp8xB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/ixpOujdgUlDDZuzEnAB0jZJPXBSgtdfOaYTcRdGDpoC8gOB5UwttlCXVDFVcAms5vTfC2Xy7t92WKWA43/8yxye06vVKSAqUobCxkccxMQUl6mumkuT34pmlyY5SpaioYGBwvOouP80q9V5cz3ycSUZKD2PvKrIPrUW4+SKLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eeEis4tG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qfw/3sEZ; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eeEis4tG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qfw/3sEZ"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id CCE5A320010B;
	Wed,  6 Mar 2024 07:37:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 06 Mar 2024 07:37:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709728678; x=1709815078; bh=+NUQbXCTT3
	ecFxKigjmEK0yLcWo71EM0ZyrpRuxpItM=; b=eeEis4tG9SJhLu/D8PBuCtswzD
	QJPTlmMLGcveWDA9HUVR+xFdw+ca76pa/Xni+bG0i1Uw8o5QYFZCL4VrlQ4dA43Z
	tK6GXInf+Gc3AR5YooLW5V4MNbPV+YZt83UG/MDK7Yc4seFsXhmH5pzEcuu1prh5
	lHlIYR5vqZE8QP7SsggQUQZ07I5v/Os6NnFbGhVDxy1GjZsxmEYMbHQj+hp9wWro
	2NyFMb3WsoJkokyBJBVlou8jKSOq5IsH6DNN53LYZNdA08ET3ZOBiACO87mVBl8s
	zvSnqgpsnvv1z7iXkHH3ayKmY/jGrOp+xIMIJ/tXLqMT1T/wodpwopXJCKqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709728678; x=1709815078; bh=+NUQbXCTT3ecFxKigjmEK0yLcWo7
	1EM0ZyrpRuxpItM=; b=qfw/3sEZv76XhOvIsrPCTfs1xYhXnuSRTjO0Myd350Zv
	vVL49iHsKjvXfe03q3+qSpJFOQhfGXUSiM7qgmDrBWEP39hHVU/4TxdJ3l59PWR3
	tFVsgz6nsU4QKTXzv3bFb9weVDsL83L2YdcpSIYV3mOQKfZfDj9U7vekDFloTRBx
	ar9X+RrZkFuiKQrYTLo56XZFuDIQOnDhioaYi47ka0sj++BFKIpkbKrSz5CWE0nt
	GMvlv/zvBiUqn8kU0icDEr89+yB4QiaBTmvUyKdDEvZyBbqfPN0zJpZy2i/wM3oz
	AgxN4qaqHMs0A4tuiYHWgkO3sr2Yk/CB0i43HUlK0g==
X-ME-Sender: <xms:pmPoZZOoDHsx8scLEiE4-y3Iv4dLOytw2A-uoiDnoO_GRt6_mauRRA>
    <xme:pmPoZb_0Ue0mPnWkacI2r5Do6JAgzbQZdU0taJYBNUcvG45wPsfEgv80-MPENfjoI
    ob1REIaK_PAslNzbg>
X-ME-Received: <xmr:pmPoZYQnPee7nGtKTqkJQ94Mtrr6r5j7pRIl67nXIQVRhqkmrsC1FaoRQ_eabbWb8KM3XAJh8hHLWvJJur6T_7kN9W3QlGFbTaDNwLk7Wpdnf2mvwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:pmPoZVvXHZG7IYzijzP0NoLL8I5pmNLLFRPBOIiRKZpAS72SsVxNNA>
    <xmx:pmPoZRc4WEcopL2d4hNMAW07LTg7UmhgfmM6pvgi34m-smojw1hDCQ>
    <xmx:pmPoZR0oD8sM9Q1IWI021jw-5duCjWDF9JYQt8hQxvDbV8tFOyUdkw>
    <xmx:pmPoZSqRUx6L1H1iH_B-ybydv4Y3H5kCjG2aXh2HF6cIDMKnBJ9Ifw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Mar 2024 07:37:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5b5287af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 6 Mar 2024 12:33:26 +0000 (UTC)
Date: Wed, 6 Mar 2024 13:37:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH] reftable/stack: use geometric table compaction
Message-ID: <ZehjoXhH6deTJmSm@tanuki>
References: <pull.1683.git.1709669025722.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Dfot0bADQFD0tDG2"
Content-Disposition: inline
In-Reply-To: <pull.1683.git.1709669025722.gitgitgadget@gmail.com>


--Dfot0bADQFD0tDG2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 08:03:45PM +0000, Justin Tobler via GitGitGadget wr=
ote:
> From: Justin Tobler <jltobler@gmail.com>
> @@ -1305,7 +1287,7 @@ int reftable_stack_auto_compact(struct reftable_sta=
ck *st)
>  		suggest_compaction_segment(sizes, st->merged->stack_len);
>  	reftable_free(sizes);
>  	if (segment_size(&seg) > 0)
> -		return stack_compact_range_stats(st, seg.start, seg.end - 1,
> +		return stack_compact_range_stats(st, seg.start, seg.end,
>  						 NULL);
> =20
>  	return 0;

One more thing: I think it would make sense to move the refactoring
where you change whether the end segment index is inclusive or exclusive
into a separate patch so that it's easier to reason about. Also, the
fact that no tests would require changes would further stress the point
that this is a mere refactoring without unintended side effects.

Patrick

--Dfot0bADQFD0tDG2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXoY6AACgkQVbJhu7ck
PpTfoQ//WWBy2a52ZPw5bw5F2H8ke2V6JsLZvzOnkGUN2AzuuONPXaEHd4JPWqAv
QUw8nJUbvGx3sJ4Hjbw1YWNKu65h4fPgu4nrlydzKFOs+l1CZ0KpHj/WpM4Jvoy8
XaKAmjaXKsscuBNJsWCyB/ZE1RFPCR1VoNZDAnUAbQ1rY+kCJkJe3+gezEBhd4CX
qLCSRJL39gC92s97KNB1UmRBYcp43vN/OH8LTo/+p0Ck+o4Na4l2IlD2RSU0muzg
qXrIUT7dNQJbNRxkAS86drcltTot8MM9R1EjJ7/7G5KwHENtpJG+TrCKIUnamhwN
AzERsTVxT27PLnvVLdWqY6Q85/q8UkmRai2kYml24JNxOiweATerZkBczDXZcWs3
BdvV/ZfvX+ktkknP7xYgBvv/PibZxhxjSe15wEfNdVC1pApCzXt5QWAMHxaHzHuz
71f1ITb4XuPiQT9YbIGEII00opl+UdMzm0oJAYS9Mxxj2OmAcWoLOPLArJjprwbB
88X3bIN2cwGje0R78cK5EGmKLRkPCJmFF1k0+lXtnMUEYyS0fvt1aWI2BsqFwITQ
prPBqkGeq5ogDq8TrLizZs5mpxYfcklkzRixw9YghXnXDI+IpzQJS3vMKbnK0LVC
UlSYihKtXssp+P8BTB940RQLjlYDTuqY+ZavX2ADArTyz0SB/qM=
=rfnj
-----END PGP SIGNATURE-----

--Dfot0bADQFD0tDG2--
