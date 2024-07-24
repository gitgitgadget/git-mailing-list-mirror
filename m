Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE9E15748D
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 13:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721826717; cv=none; b=qT70PStl10n7ZrFWOZ85YX789Ud2I27xUUcVACeOvUaIG5CQxCVjc9eico1+rOo+h0cte1wxRhxu350UKtnqrHeeSWVDPXsXZ/u4sKr/KFdAGR+cPIr/nSFDUWTyPDn2iI6jqGEPEw9YqkYzpnJFnKY6zVDZsvJFUY0InyE/Qko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721826717; c=relaxed/simple;
	bh=L9pMdseyncnn37HDL1Hlqe1Zoe9BPkyuicEVcPh/IJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sW5NCuIX3hkq1OqMp7kfsOR4rtHUfMlTxZ4IdGdcHDp+xfm83SgXuC6cxI5+HtG4hr4XXoCDEgyYUcHR4XkAOalRsPHEXeyPFo4QjRBKG8XbZxxKuPE77TzD6uj/5Ufvbx9O58GjVWlvOVo/kTY5m1RmDMeiI6UfkSTwzUq8J9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q8BrFbQX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UswMlHuI; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q8BrFbQX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UswMlHuI"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 16CCC138032D;
	Wed, 24 Jul 2024 09:11:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 24 Jul 2024 09:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721826712; x=1721913112; bh=jw2onVUkQJ
	t2ipe/qxtLec4reGouR9B7KIhW/+m8o2c=; b=Q8BrFbQXjIo/7vR/ZS9lOFz9XQ
	Qmgw8JeHGcqPojG4XPGd3I0WDwVBo49p03EX8N8vRb8BB2jkQO4/GcDIoGgy3MIf
	m8QwEzybbVj6tA8Vgmjcj/xVaEDRLwFUq31Kh9YsBq2msJ5j1FSX1cdWFOXxNH0D
	sA9JwxUQ6NZcOGV59rBYuqE/AvD9KtcJdeLhqGwFxVByq4Wld7BFi5hPjtiKg2dY
	EpuEAfVU6vIywQw0GQbv9t+RiLmKtqSvRpezTeI8ybyau++qMtLjMtlvXDiMv8Ca
	ZPjFiWKDdQqElOM/L3YNciSObuf+kjGzRxKAwR4sji+2ZC5fyW/dF9kEXEig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721826712; x=1721913112; bh=jw2onVUkQJt2ipe/qxtLec4reGou
	R9B7KIhW/+m8o2c=; b=UswMlHuIrbrhG4OIAAT9nY5msZLR5vJnj0a2KIhp5MYz
	Am4BvWRi+dOjR61M08r35Br97HBGw68ddL99mkoqNHI2T2jjzuLdKgj6dAVwQRkJ
	4lq3tMqc/eEN7ztHUJdEp7ye+JDPKpD08AhLUojWkmzDWNCyg1l1HHeheSWB/bsy
	C8bLL7P0gTioQxuX4YoRHhOuRE1yc7WL/nvaTLlqm9Bjkncirgl3HC53AR9mGPub
	nEzAoNpJKySl86sULXzFqJEmZXWdglf3fAaacuAhtT4ifchebRcnt7qRxg81qgT9
	nuyftDkSvEZWk2uieNJ0D2EHnBNVfhDc0qMuhUVmlg==
X-ME-Sender: <xms:l_2gZl4FXWFMpNgQf-RuXgl0BaSSLtQQEpuD9-pMTt5VjWVUezrOLw>
    <xme:l_2gZi7ZC8Zv8cdN861gSylqNRnE5BknzZWgJ8SqUBPOY3FtI-EdD0BrvDuaBmFJ1
    iLk4Tecb6wgc8XfeQ>
X-ME-Received: <xmr:l_2gZsck8wl5UOzdOletY7dG6zYJNI_B9kQyoRKfCHnHQnbs99P2YWX6-n705qi5X2g5_CGVastncUgm1uZahiJUlGJ7jCHLurbcEFj-dcqIQDUU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedugdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:l_2gZuLe6G2s5SqZoATpgNfQQq67nF5caP5cLBqZkbHQSqukPf4qLw>
    <xmx:l_2gZpK2AbXxjmdfb0lnv_CQKZIZkKP10C4kxz_L00-rQTOnIXj_uA>
    <xmx:l_2gZnyEQAfgihNMYzbvFR7OPDrnsnca_yumr9w0uhMfiKrlGQ30BQ>
    <xmx:l_2gZlJibSr9T-bPqpqqXQ_T6QQgvvigo2eUemYQ2BcnVwhqpoTyZg>
    <xmx:mP2gZgVEgjMjUNxjbH6EuV1kpd4LJuhsetgV7B-UCLkE83VcqYSfiAeC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jul 2024 09:11:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 25d15b1c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jul 2024 13:10:32 +0000 (UTC)
Date: Wed, 24 Jul 2024 15:11:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] Documentation: document difference between release
 and free
Message-ID: <ZqD9keTtimiqJnJP@tanuki>
References: <cover.1721818488.git.ps@pks.im>
 <5e1de3c3159968e897a83c05dae5e8504d37a16c.1721818488.git.ps@pks.im>
 <CAOLa=ZScBn+sMB7BWMpsS=Ld0sUW14Li5JVuKPGKtY91hVo4jA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N+M3ycsOeKA42K4p"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZScBn+sMB7BWMpsS=Ld0sUW14Li5JVuKPGKtY91hVo4jA@mail.gmail.com>


--N+M3ycsOeKA42K4p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 04:46:20AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > We semi-regularly have discussions around whether a function shall be
> > named `release()` or `free()`. For most of the part we use these two
> > terminologies quite consistently though:
> >
>=20
> I noticed there is also `clear()` used in some places. Should we also
> mention that we don't recommend using `clear()` WRT freeing memory?

In any case I think we should decide on eithe using `clear()` or using
`release()` for consistency's sake. Which of both  we use I don't quite
care, but the following very shoddy analysis clearly favors `release()`:

    $ git grep '_clear(' | wc -l
    844
    $ git grep '_release(' | wc -l
    2126

So yeah, I'm happy to explicitly mention that `clear()` shouldn't be
used in favor of `release()`.

Patrick

--N+M3ycsOeKA42K4p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmag/ZAACgkQVbJhu7ck
PpSZig/9FH4W+2u44OMtYxpCzF7yOJj3gXDy0BZ+dMNYhLGyF47eHZJtLNPfOY3B
Yw3XhjZa8TW7Jugoc66FzSJavQPJ3oNvrER7OGvwsNyTJUdOuYjB18yEHvnMbw4k
I/hI66E1w8V0upfLTWKKX/7yc4JWmCCRob70NgM1j7sf/p3nA+GL6Nrsz2uIou/z
EmekD0h+m3damoA8gw75z6w2PN1o+82tktszm1FC96dt647sH7G82VVCu4Xy2bST
+vjOB20tTY4cCSGdPomlPFtchvDQWW5yy8/E6rBKhQzyjU2kDK+lnZX0xRQKNek5
j9Q1HyrLHE7DNBSIb3Rcd++Tf32327e9hQjVswpYnnhZxg8s+RvI3GrYb2w0Ok7v
vVXL3GAM3dYGFtOKlpapArfmNWb8IJdPTJ1AZVXcH8JXxxN9nydDNf0zi+palA8H
TvRvV8KfmmxYVkiJBEDsstkF7G/FUq8sws+RlJ/DMf4Ql9t7kmbkg3olyifHyFvn
5QFJH+SB9xduCL2WXyQwM+ljj48rMxBafRL4YJjum2cHI56VOQGBwO/IpqlLi0j8
fS+eQJ1gcyMGzh6WfmSjooQzafWynug72rIE5Q3t6VlLKVDLB5hd+TB0fI96QOVv
hMDoZn2hwlOBBLEwz0dy2n3FJmMB3I6XBFHbVtVyaIPJekhLLk4=
=Pdxt
-----END PGP SIGNATURE-----

--N+M3ycsOeKA42K4p--
