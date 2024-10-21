Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5A31E7677
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 12:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729512535; cv=none; b=f50t/3Ke/gbktjayuQ8gv5GcJAOIL0z7zopWT3y+azBH0dh9nRfK8uU1RWO9BC0Shp1gTJTKVeQaGH9tvOj9zC8xKhtbxjlLQ2NxxWGVFVJDZAxydOFEyU3dOQ/3q0qG89by/yrgEqXjI8kjoH5Tsq2BmrPZtOpuH36z2EtbOXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729512535; c=relaxed/simple;
	bh=mqfx0aDGghiLB5HZbNos9CSjIEkngXIUsgW2XAkmtvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAqfGhvA9aX8vxQt4G+b/mkxbiwWTryUEMeGsXVxJZxvSa07INzV73Z9SPOt0Fll7fcIb5AclZYrJiEjpz6Hvj0VJ89nTfQsSeche8Xa0Aa4WwIjCU7Ngtav1bGWymQepP8Ten0e3D5b47duOh/OHaANGYl2NYfbfxhT0J47Vyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Vv0G26kU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NZS9uvgx; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Vv0G26kU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NZS9uvgx"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E7BBF114024B;
	Mon, 21 Oct 2024 08:08:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 21 Oct 2024 08:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729512532;
	 x=1729598932; bh=VyJ5QpKqSHjuFffb5y96QvlpoLM/6n95s9XrRzKXeTc=; b=
	Vv0G26kUvdXjcbwgWTP7ZDvGqa/GPorsZkxy/hSJq1fumF41cbVjGobL0f8tteDa
	R2kmNthzUkLdGlUjKmbyfkxdX9TSJ2lXq1vmxKdzevgAjHmQQyUjSX+hK3+4d2ho
	aG7+8S81pQZEpYjvEfie4VlFYho5N61Cy1K8eqIfj2Sb3WE60XsxYfIv7bsJJ8qW
	jQ3d04CISB4gFokfE0Ilcjjjy/eMS5dBzUJPSheu9FwZuB2hNficC/GIHpfgswBC
	blF+uR9SNj0XpAgP3TDcnQhA4An7PyTuN5AXxj64HVoO5fj3hRhk8qwS/F/99AAa
	EfEFrj1pS0/GolSsL58RSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729512532; x=
	1729598932; bh=VyJ5QpKqSHjuFffb5y96QvlpoLM/6n95s9XrRzKXeTc=; b=N
	ZS9uvgxLLIIJZkQp3SS7QfVciUS4NC+FKpifB+gIVx4EBa7jSWT45dFucrGlYcpH
	Z4CAZF9hEbJZXVhwejUYifuf2YikcoWx5d5A0Ai8dCYmT426p3sRJt+/Im+H52F/
	g694AA3SUmqgB3ypIW7ripKL+F4r6btm8PRG8xiL0k9XHTtWZa/tFAg5DEYOGEXP
	U/W+6coaArHv1/eNfDeCGC0N+Pq8g+dlTP++FMmaCQ3dtEf1/AvNUvHjbl2VbuqA
	zvfuHDBKPrA2N+eVQ83Zrf+pVeJXB3im6zMjSpdmFpQngRDt798R3BdALU0DZ9td
	/mJaiUhsXjvbNy3Ji1LqA==
X-ME-Sender: <xms:VEQWZ-uRb82I60CkdGJB_EQGUtFCXxp1vwU6exdKiMIToxNfb9UnFg>
    <xme:VEQWZzdfNEzAiVkDLALIUY38thUAn45AlJBgyH9YwZQNdy6-ID3OigdLhQlFh3LrK
    GVuqK2cBGoqR4hsfw>
X-ME-Received: <xmr:VEQWZ5xM7O_u3Xe9zF-hmYgjF6_U6DNJfmMhM5nNBNTg78qvg0kmcszATuNOAnUodDBD-SZDJqyd7tsqO8oU6Odb26KLiiTCsBNc_LHzck37>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvedvfeegte
    ffvdduuddutedvffdtkeejhefhfeeggfdtffdttdevieeuheekgffhnecuffhomhgrihhn
    pehlohhgrghllhhrvghfuhhpuggrthgvshdrhhhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthht
    ohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghouggvsehkhhgruhhgsh
    gsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:VEQWZ5MyJKEVHU5CjWKw3ReTxf93zPgjQj8GTqeaWDIf5XXBFN94bw>
    <xmx:VEQWZ-9eoXdaTSdP5Gd3mXX0ufRqiXev91jPiZ8eSwn4P5ZRYP5qrw>
    <xmx:VEQWZxXCOjJxPP3hne66PObQ1kTVV__ez39mRfVYr8PJTdNgl-yltQ>
    <xmx:VEQWZ3cSXcFV1mUYmul908G0oBCUspofl0itAMDf0tX0oSZjk-LATw>
    <xmx:VEQWZ1Z1z_Utlx3MsrTTsH6xKzvCrr3f6tx9tuLY46UiMzB5sgSGog8z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 08:08:51 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fa24fba0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 12:07:20 +0000 (UTC)
Date: Mon, 21 Oct 2024 14:08:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH] t1400: fix --no-create-reflog test and description
Message-ID: <ZxZETN7WjbNiSRyF@pks.im>
References: <ab7d4c8d89c075de05bf04f1f9dc195145455964.1729439476.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab7d4c8d89c075de05bf04f1f9dc195145455964.1729439476.git.code@khaugsbakk.name>

On Sun, Oct 20, 2024 at 06:12:03PM +0200, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> This test has had the wrong title since it was created.[1]  Use `always`
> like the description says and negate the expected outcome.
> 
> The test works since `core.logAllRefUpdates` set to `true` does not
> create a reflog for that ref namespace.  So the test is testing the
> config variable, not the option.
> 
> The test itself is fine and does not hide a bug: `--no-create-reflog` is
> not supposed to override `core.logAllRefUpdates`.

That's actually surprising to me, as command line options tend to
override configuration.

> † 1: 341fb286212 (refs: add option core.logAllRefUpdates = always,
>     2017-01-27)
> 
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
> 
> Notes (series):
>     From the commit message:
>     
>       “ The test itself is fine and does not hide a bug:
>         `--no-create-reflog` is not supposed to override
>     
>     A source for that: roundabout through git-branch(1):
>     
>       “ The negated form --no-create-reflog only overrides an earlier
>         --create-reflog, but currently does not negate the setting of
>         core.logAllRefUpdates.

Hm. The "currently" reads as if this was a known shortcoming rather than
by design.

>     I *suppose* that the same applies to update-ref since (I suppose) they
>     use the same underlying machinery.
>     
>     See also git-tag(1) which says the same thing.
>     
>     update-ref should document the same thing, then.  I have that marked as
>     a todo item.  The changes there are a bit too involved to implicate in
>     this submission.

So I'm quite torn here. It's documented, even though the documentation
doesn't exactly feel like this was designed, but rather like it was a
side effect. The test also contradicts the documentation, even though it
only worked by chance. And as mentioned above, everywhere else we
typically have a design where the command line option overrides the
config.

Overall I'm rather leaning into the direction of making this work
properly. But that would of course be a backwards-incompatible change.

Patrick
