Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329E0158DDF
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862708; cv=none; b=on2piR0HcVfUjqSr1yfe7glb8xMj/IQ2D5BHeiukAjaG8z4AZ/aCnU6LUMyjffPaUP0+blUFfiybDxXPe22qoxSKGgLwIuB2iM634oc2UmdiWRNFdg9DnCAAO0ZA6YcH825CL9DrfrK02n2swM0/i8r6zLQov1yXDC+erY/iaw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862708; c=relaxed/simple;
	bh=7yXJ8mDUdC/TJrkfHpvXV4FimbttTLHKJwKv/NPGrV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhfhxoHj94Czq86zXRwtvSI+/2QESJ5wYUPx5xUpO791BGjyLV3SS3lcOBe8mYXysgWGx7DicCP3cvqy6qf65d2QcAnBaqYV4/HU05/cWjy3pIYMTAYPoOIQQt6i5TROipOu7Al7Ks9RGzGsZJpEy5r4CQ3I4nbUoswTbJHBf+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LiZEy8rI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iXe979He; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LiZEy8rI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iXe979He"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5637D138FC82;
	Mon,  5 Aug 2024 08:58:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 05 Aug 2024 08:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722862706; x=1722949106; bh=7yXJ8mDUdC
	/TJrkfHpvXV4FimbttTLHKJwKv/NPGrV4=; b=LiZEy8rIgvNjUAYh9V/dh6UhPI
	dhaowgwCZ6Fbd6EvbD5TgG+c8EYqf5GEYS78H8mGtOS+aBHlk4wKw5/xMKhYbHgp
	b0S8y2vXT02i62UDY8yhSBF0vC2trW00jS0yJ+NHp/+Ml2CYqrZ/cY3vBe2FUU7d
	YnqZ9jUKvl67Q3k9AjXXxraeVm4w2Zca3Os6O8VLOvLQSUjguhrqLo6e8jtMYgUi
	ajYLa7eGGrQjdAXuCH0iX0rUPR1A84eMcFN3ws9c1e5VN29irYXYa4MMU1LMoqEj
	+Q7cAcZWOkAmgOzkS3iiM1J3O45S5ApsqC2STK2WYMdcj7NI0J54wjF2y46A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722862706; x=1722949106; bh=7yXJ8mDUdC/TJrkfHpvXV4Fimbtt
	TLHKJwKv/NPGrV4=; b=iXe979He8c9/ZLB+WcweTFQDIneWTbDtZglcDd/kuh6m
	+ZMyswAt6CWW42g98Q+forf4x3l7HXtfDdh2s1CZ7NpW3h5CgfkVJlBw1FUP+pQH
	OwtpNAYc7pLlYsNEjXREi+UEGzs0ZghJB9EcuvTBaK7j0PyhpxZcJvIqIOPwxvr6
	7ejoLzi4AdMYPr/Sc1MnNOncj2iKqO9zjbEfpDXEtz6TkxsEcpPVAVLZ3XmE8/K+
	/ql7aZYf0yb/zWntI6Sbib/ODA1o8Xr/ZypVOT3laUZghcLVrve5pzd1Lzdhew54
	OuON1XejMtPC6wC+1YQJm11udv0NJgjLyQupQKuUdQ==
X-ME-Sender: <xms:csywZqubNC2Cn08-bok9wJ165rBrwCwCsYtieZVEIM9tdOveHoVS6w>
    <xme:csywZvcF3JZQmYU9SHU8SmFVvPspvtzFe9_pFCSOKGY1aFlyJoYQ6k-WyH_kxy2t2
    5yuvx4rZ0d70SYbhQ>
X-ME-Received: <xmr:csywZlzMHpLX_KP7vlRX48NuL-csxIprcEB1ajEza_PwE6S-BxFpP7pfrsM0R2q1FMLoWiK__n2d4SpbYXND3pvkNFNuWXFTxj9NgH0WYotN8C92pQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:csywZlMXa1RkpG-kqq1PPRe_Mym1piyhq88rUgU9tbFRcxm0kRtWWA>
    <xmx:csywZq9EVd9IO-GJ1xN3m_2K5thFIJ2Bt-KFwVKbWLUs-V2oqvBbGw>
    <xmx:csywZtUUPkeEhHzTSj_hF_rb-8KjR_JiHVW159snbnt7f6z0sr0q7w>
    <xmx:csywZjfOH3mQdnKjOToSz9g4n1ZUVi7DR4QlqNHRDfue5Ytk50m1bg>
    <xmx:csywZqxBfDhqfV7L3Yx02dKdawzKoYKFmVZ7xmJmhW7N22I2pL56h0tL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 08:58:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e3159588 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Aug 2024 12:58:24 +0000 (UTC)
Date: Mon, 5 Aug 2024 14:58:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v14 06/11] fsck: rename objects-related fsck error
 functions
Message-ID: <ZrDMbnIgGNK8F99N@tanuki>
References: <ZqulmWVBaeyP4blf@ArchLinux>
 <ZqumVWxLZpBYkrGB@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oIqagrxBXgNAQLzx"
Content-Disposition: inline
In-Reply-To: <ZqumVWxLZpBYkrGB@ArchLinux>


--oIqagrxBXgNAQLzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 01, 2024 at 11:14:29PM +0800, shejialuo wrote:
> The names of objects-related fsck error functions are generic. It's OK
> when there is only object database check. However, we have introduced
> refs database check report function. To avoid ambiguity, rename
> object-related fsck error functions to explicitly indicate these
> functions are used to report objects-related messages.

Nit: I think it would be a bit easier to follow if you moved this step
a bit earlier, namely before you introduce the ref-related infra.

Patrick

--oIqagrxBXgNAQLzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmawzG4ACgkQVbJhu7ck
PpTdwRAAjgbWFgoGwn5OONEE5+s4d2KlE60ppIqanAuPKuF5utdjBoozDhDY0Kwu
Wx69DnDLq1Xzs1LOTF9+cCJcJjvJi03TkNXIBabEs5xXUh51EES41X85KnQda2pu
2VXKovJG8GtwFIvmZ7r8SdCeHwKCDHo/fe+7M6OPAmWh21D4ojrN0dpE3EV9A7Vj
Rn9uZVscDV3Y4YroDekLuA2wtxSi5gat1hopEbXsOGCFy4md2enHvmohUh4ZAr9y
93/DZjhwlfF6AXvTbAV+blFAAU6tjbqGQqE0CnBtzXBXo84wgsyFlsVfpVRS5ZMR
/cd5+zD6xXzwObdIRUiX/+Uen5yD0IBaWe9wf0zCbuyJYqVNNVrUqliJ9Yh7nfjT
w8J0Hpr+xV/Y2GEnxmhhy9Zuzh55Taq1TO/lOcCwHvExTvqg9uMIPoYJk7Ufe3bc
oSrhwqv6Fi2UMQGQabrvNVObHozsT4+GzZ2Mtt6kucaby+KTUtrUhfqbcgpLye8d
fCWXRxBPgdohrV3Vr/Pse66aZQWSQtmhqWLvZxGJ1FWVZZ8FEUGoOMgi/uVkoiKK
PguCb/BrR66TYgZEt781+1IJz/DmxsR7e1O6N/k1E3Td30Dtno+5U7wA+zLqWPTN
pHYKnMqntD4HPDaD1MP6vvhPJEI1kwtVysveUuJVSraGu+5sR70=
=7bgP
-----END PGP SIGNATURE-----

--oIqagrxBXgNAQLzx--
