Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F73200BB2
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 00:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731372751; cv=none; b=gc7m/JgJCwiQhIPqI5cXscPydoUgJnG16G0u9fmKJ3NK7bC+X8I5pAkq9XI0a44gNd+k688UqS2P/Gm9DZl+QgocMO68Us/MCYaoOGS37nO6o0w2w5xGQfsfIkZjJsCLtiolOCEMxLFBYLqvqIWHCZQHZK00m5+klm8UuoLWXeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731372751; c=relaxed/simple;
	bh=WdT4u/e7ir8Nxmmj34/Ci5SXaUtFemHL0NASLSxOHZc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N2hRpJYTUyaePc2ErWErpuZJ/MCvrMFGJ6nHNFoYQHx8y4/S5NPtIP9YgL8ExPmOEnNa0XqTm3aVSBjAi/78zmxY2bZxT3r8+GYqLs6y4IzNUhzpjloKngHTPWj1+HPvEMOeW8xb8gRVQEkQZQnLHWg55xOR5lAmV551fy3vCKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dY5aVjvn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cinSEQeZ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dY5aVjvn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cinSEQeZ"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9AEFA114010A;
	Mon, 11 Nov 2024 19:52:28 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 11 Nov 2024 19:52:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731372748;
	 x=1731459148; bh=McZZp3x08WuAHu2xy9PtXf/6up5jIDaFObeWT6ocivU=; b=
	dY5aVjvnA2g1SZpBobTA/Cw59f5EN1jpXtoJ8xUEBYOUwJS6r28w/e0gJClbc8eW
	KgHAoQ3H6QioxXoT39aZ7bm/pZsek4qySBt2v/frhjpb37L5xjfzvTN7m1DvWLR1
	ZLCWsv/dVrj+T+1kvMlbfgox2Wp2DMV+HY2iFZILBLIiCfcnOxMYEzq6cpdvQpbA
	ILaruvG+QUZNs7xf7lnJty4EvvT0d8x/kDDfxNc/dtTWgd+ZWBCkHTiDBDXZjX8K
	vJM2/osTJlKnMHA1pKtmjteBO1vCflUeuIVC99Kh7BBlJ5/IxyT1GoRVgv6DLujs
	MHk4IZYL8UT96nVINd4cmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731372748; x=
	1731459148; bh=McZZp3x08WuAHu2xy9PtXf/6up5jIDaFObeWT6ocivU=; b=c
	inSEQeZuaZ1iogfImGLtw1c2V7SpyyHc6ncs8esIQpM3Qm2gw3dx5xnSAdjzBPAA
	MuY2XHUROhfr35FERYNHgGFe/MWh7117C8baM+epS1L1gFDO2KxedZivKR/iOmIK
	rAlXSPXfCRXuCJTQKzmbkarF6Tpf9W5c5YvQf8kZvH9FhmMSvUvLRlebtRRUx53a
	32kEWKukFCZArQAE1zOstPT0X300LQM/mCHbc1tkR7OrbHeKBR1vz2VkcmvN1WLo
	MiuwhDVRBjxJPXtexoHagbJ+31gWtxc3Ej2ACCvIABf2SLIsq4W2EcCY04Qz24wg
	LnQNdX4gd6T3i1pH3RKIA==
X-ME-Sender: <xms:zKYyZ7EQNSe-P7wLLGai7Y0a8gSeYH0hN1eYqH5K2I8uGGwpQpsqaw>
    <xme:zKYyZ4U9uYf1HtzXjH3pp5Ygb36_V_IJ0YYt8IkFim2-VO6LbXgt69TZ2oFIprjdX
    C4xwIJyvwBAl8UjyA>
X-ME-Received: <xmr:zKYyZ9IHITuV6_3WtvocejYICkdtT_js_EU5xzCglWpjBFOILzi7ixKaOjtOZOzvFw0_ttAOjyRdKu8prfI03QzgUUn_ovCv5L8d>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfekfeeh
    iefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:zKYyZ5FsknCT0A-F2dUGftpplC5X2ZDk36vSl5ROPuADe4XNO5319w>
    <xmx:zKYyZxVE0ouPpYOhHEfNIEhk0jQF1Ke-RVBHAyJ63E6wMBTrk-UsFg>
    <xmx:zKYyZ0N39Ov8ydpGeZtGDZGT7inwloG6tsvmcrJfCnDieoPVhUf6TQ>
    <xmx:zKYyZw2Lnpgvi9LAX4hGKTnsmy72-cRnjR5WFSa02b4EbrlitUx5Pw>
    <xmx:zKYyZzIEPPrpn0SV72HKeFalRR4-n-2d6uoyIWjE7A0jsIf4NQqHENvD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 19:52:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>,  Patrick Steinhardt
 <ps@pks.im>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v2 2/5] doc: git-diff: apply format changes to diff-options
In-Reply-To: <129763c2aaefd92bddaa59601c5a3275b9defa36.1731343985.git.gitgitgadget@gmail.com>
	(=?utf-8?Q?=22Jean-No=C3=ABl?= Avila via GitGitGadget"'s message of "Mon,
 11 Nov 2024
	16:53:02 +0000")
References: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
	<pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>
	<129763c2aaefd92bddaa59601c5a3275b9defa36.1731343985.git.gitgitgadget@gmail.com>
Date: Tue, 12 Nov 2024 09:52:26 +0900
Message-ID: <xmqqh68d8e9h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Jean-Noël Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> --s::
> ---no-patch::
> +`-s`::
> +`--no-patch`::

These are understandable.  These dashed options that are to be given
literally are shown as `literal`.

> @@ -39,28 +39,28 @@ endif::git-format-patch[]
>  ifdef::git-log[]
>  -m::

Shouldn't this and all others like -c/--cc be also quoted as
`literal` options?

> @@ -73,33 +73,33 @@ The following formats are supported:
>  off, none::

Shouldn't this and other option values like on, first-parent, etc.,
that are literals be marked-up specially?

> --U<n>::
> ---unified=<n>::
> -	Generate diffs with <n> lines of context instead of
> +`-U<n>`::
> +`--unified=<n>`::
> +	Generate diffs with _<n>_ lines of context instead of

Understandable.  Shouldn't <n> part be italicised?

> ---output=<file>::
> +`--output=<file>`::

Likewise.

Thanks.
