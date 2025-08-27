Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0B82F1FC2
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756314383; cv=none; b=CtwSjvilJ3kAjT838Q9YvRcFTR05gJFfZcOIUu0yqNlMYcij0i5PUf9xIMjEvCMn43TGevp+ArvDHrIJROSJoqNF0VnXOdeIabMsn0KLR5KC+y+c0NTxYUzEuOQn6l76jjMVVxYwz8ILX/brOh0VXHCVtZbyOMEZ28EUS7RKf74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756314383; c=relaxed/simple;
	bh=ZM9RHSkpB4IGHoGvPE8DVKzbIriq+TEr4C1xO/jbI/4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V4JkULEceCVHvSm/2Y7eHPfJTh3l+qWoJ3M/DkGzSvz/LTjSO/b5o/SIQFnp8pdnffg6qT+ufyMR7QjOdQhqMMePfukhWAa2ki6VnMMYRP2EIEBD9Is9BWZ66EPkCvgd9AU6PQ4FA/stVluQ0JPz/fi0aidPuxo7hlZ7zhJox2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vV9+MiN9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Epyb3PoG; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vV9+MiN9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Epyb3PoG"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 3C7A6EC02B5;
	Wed, 27 Aug 2025 13:06:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Wed, 27 Aug 2025 13:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756314381; x=1756400781; bh=hYPyoSh3hy
	h11CegwL5TH+VA2iw3mRdyGL2U5yhEgQE=; b=vV9+MiN9NFdr9/u5E2hE6U7JiD
	uOQK1Z9qWR446TQ0q1iiGDRdXaxSmVUtqPBeNxYhNo3/GF0thDSSaqC+TVy/opPm
	SNGLFQT6c4UfJSqdvzxx+q90MNfn+bI3F238s3uu+TGvBFFCpDlQ1/KfbpdD0w/0
	3DjW+ByESXBBWm8nKNsc79lXLeBUfynhTaQWuwDZWNArnt3J/QqmPKwBY3BefKSJ
	2JyCaL38I6NUUQzA0RbbqVJ3BPI4JxcWgP0YqwGGKmhHbhouiaxwrtglsYIppjSD
	eVbEhKotWTDSnMGwGYXBA6BOyD+mKn0q2cB9CsnajL6IA7gk30XbegpawUWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756314381; x=1756400781; bh=hYPyoSh3hyh11CegwL5TH+VA2iw3mRdyGL2
	U5yhEgQE=; b=Epyb3PoGbpTNPnGzztQvBsExVSfqBUHDzDz6y4Hd4YatSZg5Xvq
	QcGeHHMKfdRnOZ4+bNAmtDaa05PtvEoCIQTSL1dXr7TmhMBBadpaLOGHKvgAt0Ti
	4MyspY47qUzb5WgNDETfsfQSmv5rlRD8xCx3TKaexNgznIVPr8q/d9TINr+mEWfp
	w5+gnRtFe5n5VJDrXKjN63IqIwhkbpUPXNEIGfvwUwPMz1k95S+qRk3E8O7FiwU/
	emkKnH8J+OCAl7iXE3mlct4vgV+gevnvVDtRIzJk7aID7wsLmeYbRub8q8qcKmqK
	vMo1k7vFuVy3pGl3cUWipbQDe9mC/9q8u4g==
X-ME-Sender: <xms:CzuvaM-zvMgrEBvQkgIQI3mMs7y-4GP4exYC_b9gC82j6nryqeKg_Q>
    <xme:CzuvaPeZ5J6GMeWlI649SjOjXYInzv4NwVKue59ufJ8H0mRjAK5OA3CXFNAXCWdbX
    ppYtN8vf62t2frJ5A>
X-ME-Received: <xmr:CzuvaA5IADjQiZPGodWQROp1UCw7c3TkGgepXd3igln_y4w2tilYcwYuiCOaAEXUvl6t0nvFwt_Wehlp_L3paQaPm1YHFuCSajIBw5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeekjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepvdegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtg
    homhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepnhgv
    fihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruh
    hgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgr
    ughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgr
    shhtvgdrnhgvthdprhgtphhtthhopegtsgesvdehiegsihhtrdhorhhgpdhrtghpthhtoh
    epphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:CzuvaDObC0b3Na8KZEDiNR2E31RGCiRKnyy-MmVwh1CLPZXka0J-sQ>
    <xmx:CzuvaB4uj1uneVrS_y2DBknoypIi_R03i4t2O_fjmr1KdMDalSuSSw>
    <xmx:CzuvaKzWym_tuWRFygo5niW90J4xTKIlGh2Ad9MS_98jUYdUi2aLmA>
    <xmx:CzuvaBQAqFa6YFpqYZzDbYfyX05I_wsD_FzoFOjW8EgML9DyvRmQPg>
    <xmx:DTuvaOu5L1_X35a5hWD3JmSqJ7_Thv9qvjs_DYqRDKHatpCChB2O56aH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 13:06:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Taylor Blau'" <me@ttaylorr.com>,  "'Elijah Newren'" <newren@gmail.com>,
  "'Kristoffer Haugsbakk'" <kristofferhaugsbakk@fastmail.com>,
  "'Josh Soref'" <gitgitgadget@gmail.com>,  <git@vger.kernel.org>,
  "'brian m. carlson'" <sandals@crustytoothpaste.net>,
  "'Christian Brabandt'" <cb@256bit.org>,
  "'Phillip Wood'" <phillip.wood123@gmail.com>,
  "'Eli Schwartz'" <eschwartz@gentoo.org>,
  "'Haelwenn (lanodan) Monnier'" <contact@hacktivis.me>,
  "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
  =?utf-8?Q?'Matthias_A=C3=9Fhauer'?= <mha1993@live.de>,
  "'Patrick Steinhardt'" <ps@pks.im>,  "'Sam James'" <sam@gentoo.org>,
  "'Collin Funk'" <collin.funk1@gmail.com>,
  "'Mike Hommey'" <mh@glandium.org>,
  "'Pierre-Emmanuel Patry'" <pierre-emmanuel.patry@embecosm.com>,
  "'D. Ben Knoble'" <ben.knoble@gmail.com>,
  "'Ramsay Jones'" <ramsay@ramsayjones.plus.com>,
  "'Ezekiel Newren'" <ezekielnewren@gmail.com>,
  "'Josh Steadmon'" <steadmon@google.com>,
  "'Calvin Wan'" <calvinwan@google.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
In-Reply-To: <01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Wed, 27 Aug 2025 10:39:10
	-0400")
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
	<pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
	<03939951256baaaec3fcc690cfa38ee12fb553ce.1755921357.git.gitgitgadget@gmail.com>
	<030a01dc1433$ee3e2510$caba6f30$@nexbridge.com>
	<4dffd698-9d3c-41c8-9d3f-0d3750e683d3@app.fastmail.com>
	<031601dc143f$7a9a25d0$6fce7170$@nexbridge.com>
	<CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com>
	<aK5mJI1NfVQDmDXN@nand.local>
	<01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com>
Date: Wed, 27 Aug 2025 10:06:17 -0700
Message-ID: <xmqqsehc1ypi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<rsbecker@nexbridge.com> writes:

>>So my impression is that the main contention here is a concern that worsening the
>>portability will make it harder to push out security fixes in either direction. But I
>>don't think that's necessarily the case. Even if it is, I would again hope that the track
>>record of the folks on the git-security list would suggest that we'd do the right thing
>>and not abandon users on older platforms the moment Rust is introduced into the
>>codebase.
>
> This is indeed my concern and hope, Taylor, as the maintainer for a platform that is
> feeling abandoned. Please note that HPE NonStop is an actively maintained and
> vendor supported commercial platform based on x86_64 POSIX, just not a
> Linux/Windows machine.

Thanks for a friendly conversation, but I would have to say that
Taylor's "we know we end up having to support both, and we will do
so" is way underestimates the cost to do so.  And I hope that an
actively maintained and vendor supported commercial platform would
bear the burden of the major part of that cost themselves, when it
becomes necessary to do such a dual support.

Thanks.
