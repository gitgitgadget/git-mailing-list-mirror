Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3135B1FC7F0
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 00:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731372486; cv=none; b=KbyotFDC8ZJYT0cUB5dJGoaRBtM1WyNa5L6P2EtbqMoB2JQclnDhcGuP/vI1A50CiXBMWa1HX/s0CeySzppSrh/eALBHpf48a+s3dh3gA84vd3hEUO4Szd0LwSKTSL14iLkC8ABeeHK3qOUY8snADABQlf5H4bOhxnZdbs/FzpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731372486; c=relaxed/simple;
	bh=bIxj0hXlMEoQ4WUFTBhRpYRa8IFqXU8mIBlhcuIxMdo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Edg2/n6rSzyfnQoHQRp/SdS3XCMenpRrhNpZnHedEFrdExInOd2T44TMiyRVXy1eELsroJDwQNvW/mXHSWn3qHk2d3D6qVwSvWAVJppjmP/Jqyn1MQGipgkRdq1LFTz3mhw790kP4hI7iEo72VKFAx5JGuoQA+rmT4+lGUQHxmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J7v7eO6J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kWyo2Mpj; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J7v7eO6J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kWyo2Mpj"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3410F11401B7;
	Mon, 11 Nov 2024 19:48:03 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 11 Nov 2024 19:48:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731372483;
	 x=1731458883; bh=lFuA5kV8hfbb3fQsOWbAWOCbMWltSKnM+2Gu41+9LYY=; b=
	J7v7eO6J9Biw6snIg1NT+/Ic7iytkMaiEHQDcYAFBVSQRvdBj9lg19J5Aqn/aN9F
	/91dCO4qBLUVL9vCZGvS5Tb8Njv/EctWSqKXv2lvs1E0TRZKXA5zGT/zu49aK9Lh
	CDkl5WnDxVlAc98GJSbO4qNvDYWu7bQmbM2nVHtaCE/fl/qG1hC6z+HJUBcYax4h
	4aRTDR1JrybgNF2z/u7X2wUyduFuShEfMCVf/suYFxjkSZdmtTmFAW+0JGEPYLRK
	QPWUe4aG6ml54xlIQjmhECFT2H1lS27aH93nEAOyNfXywQgCaYgyNTSTGMnZtdNG
	+BI8Xyn+yHGMiLRHqOwt4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731372483; x=
	1731458883; bh=lFuA5kV8hfbb3fQsOWbAWOCbMWltSKnM+2Gu41+9LYY=; b=k
	Wyo2MpjJ2zULmZ4Chul1aZQP9s4BvzaFljmSESE+ZWHvge+NjaRD4ChFjURg9Ogq
	UP1Cd8WMc42tB12p+JTWnIF8nGmnyFrGd7cuW7TRLsNq48mlTMoAcNikU2ZjvvFX
	TxkQQXtFjFCT7isP6pg3+uFJszt4YRGAWHpBuVuG3w8rt41MczdAYziTyj7v3SAl
	ur4eY3An+X06AeZfepPuiOKmU9DQpD2HOM731XMEhVYK1lPr/YcqBU1JwO3EJ7n7
	2OocR8wEMZi29A7+/TtmOevB0JIn3zhtOtyAoaCqwL7fg2LKwtdTutJxSBL3ioHs
	LH/xVn3svEp2I3Y/yzjfw==
X-ME-Sender: <xms:w6UyZ1n36YsUmw95_ShNyza6ZtgcBZh-P9OPRFTGTcEAeG-x8WjR7g>
    <xme:w6UyZw1j2kItEcCZF2w73TPfEagtiAryX0ybDnvaxyTqI-z30KVPmtJ2voqqenjul
    R32-fDkA7vAYxhkLQ>
X-ME-Received: <xmr:w6UyZ7oyVjkNX5_Ml7QOQk3cNvDmLeF7ngOaOR7c9lHK093rA4c-mN18xcRCjpLoAlvF244Acajld8yaAj1bAw73idvrS-zAOBzf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgddvjecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:w6UyZ1khoi_cirYbgs6UdJ11cF-ltNy8hJs_CjXVNoEt-78rLZLo-A>
    <xmx:w6UyZz3tTRrh5_jwXTOpnqXx6yDUN65oWxfPDYgmkeq4TGy3C8_yAA>
    <xmx:w6UyZ0ttdVF867zCEhlj0BNrwes4SNl0N1LC9ALcQDiH0j2zSRx79w>
    <xmx:w6UyZ3V88myQU32VE5EpBIXbOlp0b_Ig3npCU8DrZ21L_z7n8lwLtQ>
    <xmx:w6UyZ9rkF3pNktuoO5WdSFjNiKUEe8YW--zGLCosE3Ta1cpUUoaGbp-b>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 19:48:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>,  Patrick Steinhardt
 <ps@pks.im>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v2 1/5] doc: git-diff: apply new documentation guidelines
In-Reply-To: <c104bd50b646646e980905a9294209f381b9e61c.1731343985.git.gitgitgadget@gmail.com>
	(=?utf-8?Q?=22Jean-No=C3=ABl?= Avila via GitGitGadget"'s message of "Mon,
 11 Nov 2024
	16:53:01 +0000")
References: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
	<pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>
	<c104bd50b646646e980905a9294209f381b9e61c.1731343985.git.gitgitgadget@gmail.com>
Date: Tue, 12 Nov 2024 09:48:01 +0900
Message-ID: <xmqqo72l8egu.fsf@gitster.g>
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

> +[synopsis]
> +git diff [<options>] [<commit>] [--] [<path>...]
> +git diff [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]
> +git diff [<options>] [--merge-base] <commit> [<commit>...] <commit> [--] [<path>...]
> +git diff [<options>] <commit>...<commit> [--] [<path>...]
> +git diff [<options>] <blob> <blob>
> +git diff [<options>] --no-index [--] <path> <path>

Again, not having to worry about `mark-up` _<rules>_ in SYNOPSIS section
is very nice.

You may already have explained the rules elsewhere, but please
help me refresh my memory with some explanation.

> -'git diff' [<options>] [--] [<path>...]::
> +`git diff [<options>] [--] [<path>...]`::

Here, we just say `everything in literal, including placeholders`,
which is very pleasant for us writers.

> --1 --base::
> --2 --ours::
> --3 --theirs::
> +`-1` `--base`::
> +`-2` `--ours`::
> +`-3` `--theirs`::

Why aren't these `-1 --base` and instead mark up individual tokens?

> -<path>...::
> -	The <paths> parameters, when given, are used to limit
> +_<path>_...::

This has to do the _italics_ for placeholders, unlike the full
command line examples we saw earlier?

Where does this difference come from?

Thanks.
