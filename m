Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84FA36495C
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 21:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991717; cv=none; b=urObHb0WLd5vjky9RzMQg99wxPGUjJplYsbDn34BuFymnjV3kS5QNyS8GXg8ee6m4nIdeZWcElcfiDoV1u3UmHTId62h6/R6PQ/hxxXsPngF86uPDZqv1Yzo4YC6rftx6j1QKvVEsBNSB47MqGagjWs44TqxgmQk4i++6CFsdYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991717; c=relaxed/simple;
	bh=bt4ZtDXLVsUpMFdBpxwnLWiAZu9GMtwFpphUwxZGwD0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=L89AxV6DU2ZS6NeUukpd8N8NtJa8aszE6Hc9qD63vIeaNXemusBB1ACeYDYtfsjkhvRv+qjOHZEPf9AKoKCEli+ZYxKvUtClmVPbM9dVcpUNAk/8vgwtnCvU72B67BAl0WhW/wkmpSYLIKug7adE6nb1T8wYK1v/IQemItiCw6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=CVpEUCt/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R7LCO/Vl; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="CVpEUCt/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R7LCO/Vl"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E71D414002B3;
	Tue, 31 Mar 2026 17:15:14 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 31 Mar 2026 17:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1774991714;
	 x=1775078114; bh=t9w8UWmsjfKnMuP4hxoAKfB2Ka5weRs4Wg8pTYoxWrI=; b=
	CVpEUCt/ccKf4EvWcIo4U1Ldus/SjSLae2S4jbFdTdlS+cN5rNPn9lGeLnfZDYrs
	fLKeS7mvFKbdMqF1WhNzT6hK3+te6P7x/UT12dDxewRYVP1NSrjMOzRTO4ULLale
	A0mmz2mhqADpkKy9FAb1Z9Dg8aMvCNOzrC5DQ0DupZQGAVQb4iWTlz+jQ4Tv+OTq
	AHllMo5CmSCbfNHyJ2z2wDPqf+XLodIb0hbpMElSbym6C4WlysHZGfE3B9V0uYj5
	v/1kPdURUJgr+NLNShyLbcDiQOolbsZYIyGvK0IuaCIIgBQMLNtftb4F5lmEELJH
	7Fc3DMgFwCRvYjsWGfSCrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774991714; x=
	1775078114; bh=t9w8UWmsjfKnMuP4hxoAKfB2Ka5weRs4Wg8pTYoxWrI=; b=R
	7LCO/Vl8YWs587LJuqKmjiJubfJCC0whpWCKCyR2X/u+eaIqMxjTj//dczSidvCY
	Wncv2TJkopi58xNmW3B9bWNNfDbccwCz4zuEw0zLXNSKNsKjQvl7bk0DA9br4AaY
	quEqK7kSYfjdxKlMp2VcsBltRjeoxv4oF2Vhn5pXQppOVQMdnGmGUFHuXd6EAeXk
	71dErSd2GWoyuJwl4fNaxT5Zme0vDZ4tFb4GDrp6kyMnofiyAkpZtYRkFB+YBADY
	tYcSdkwItSAPbgwqkOCMHzB8O2TTViF+l6yOfwU3FPL3qHEhlFLQ15xvMZn4M41r
	t20vBlgRbOtJy4dpHJ7QA==
X-ME-Sender: <xms:YjnMaV62c2iKWSG8FF3eWKwDW-yQCsVIt1Ow9XzC5EguJPO-fTaXWSY>
    <xme:YjnMadvtU-3aLeGMaJ6NPmksknYZjKbGltXB2eMS23GeKxdYfGS_mfy2JoSFdlbjD
    okOEiu2wkSurmFNWMuC_34vm0csQzJCcogJiK4kRVJzdzXLQU8BrsE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthho
    fhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeegjefh
    heeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:YjnMaUXYYVZ65VTYukUmg0lmKwhaa5OUEztph3mo8-5U_Oa3Em6psw>
    <xmx:YjnMaQWXXc7H_kbW3ejq3giIJHnvOYzg-QWHCdbjciNJ5SKnVNcrRA>
    <xmx:YjnMabdGhew_X26phM96nXoz5ZT59pspvR4P_h5kbymmYCqhUO0Igw>
    <xmx:YjnMaRUHjV-_giveMKsA2T_4MowbBM84CHqKm6S7zYXpLKXwyg-eNA>
    <xmx:YjnMaeOySeCgkOfdlGCWHtUMZzoMAx4XGH_tI_TaWULIyryjyN0Gk5gG>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9D02B1EA0076; Tue, 31 Mar 2026 17:15:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ax8gMV7f33-w
Date: Tue, 31 Mar 2026 23:14:54 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <7bb06f60-01e8-4d51-8ba2-9a510d18d32f@app.fastmail.com>
In-Reply-To: <xmqqv7ebya8j.fsf@gitster.g>
References: <CV_doc_deprecation_config_--list.54a@msgid.xyz>
 <doc_var_no_config_-l.54b@msgid.xyz> <xmqqv7ebya8j.fsf@gitster.g>
Subject: Re: [PATCH 1/3] doc: var: link -l to git config list
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026, at 23:12, Junio C Hamano wrote:
>>[snip]
>> ++
>> +WARNING: Deprecated in favor of `git config list`.
>
> This changes the meaning, and I am afraid in a bad way.
>
> Use if "git var -l" to ask values of configuration variables is
> deprecated, as we would encourage use of "git config [-l | list]".
> "git var -l" is and will stay to be the way to ask about logical
> variables.
>
> The new text, unlike the original, does not limit the deprecation
> only for asking about configuration variables.
>
> The logical variables are called logical because their values are
> synthesized from information taken from different places (e.g., you
> might not have user.name configured but may have GIT_AUTHOR_NAME
> environment variable set and exported or your name configured
> correctly in GECOS field.  We can ask what the value of
> GIT_AUTHOR_IDENT is, without knowing where that value comes from,
> and the source might be outside the usual Git configuration
> subsystem, which makes it "logical").
>
> I'd prefer to see this step just stick to `git config -l` =3D> `git co=
nfig list`
> rewrite without the separate WARNING: style change.

Aye! I missed that it was only talking about parts of the behavior.

I=E2=80=99ll drop the admonition change.
