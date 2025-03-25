Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98B51AD41F
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 23:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742944782; cv=none; b=ReDSRycaPkhpPTPywgigrqXc81rRekD+gDqJOm8n2rqs0oSZZjJ4Dhy2lBoPB76+8fqCcri3Ephv8EcJyew3OC8T7o3iAZNrColfOZFhduUEFlNeTFaBXGwcs1Q5Eed0BWsRch6bvB/elsJTRYQpKOvb1KpfAjcm1uqI10iCdWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742944782; c=relaxed/simple;
	bh=QbarrpvC80ytO2BEP0zE6uRlmRfWC+xn+N0LxasUGYU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KaO5UBWGgWrL3eHDaaqjrd05QU5QqYLp03tPpO6B7l4N+pfAzdR3fQPE7ghrabMAIeCJmk+2MFC6qUnM4kxDLk5oKr63MN2uEhGHyk+bRcgQ4wD4zW9nvA76P92QoXOTtrwMaMDsSOwgUTNJ3uU+YQ5A9bR5ITF0RR+oQmwcUXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uK3EO+UU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QlacJyrZ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uK3EO+UU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QlacJyrZ"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B6E5E1140211;
	Tue, 25 Mar 2025 19:19:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Tue, 25 Mar 2025 19:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742944779; x=1743031179; bh=bQutUzqqwC
	fzTbl13kPmps3gzceowyo0vhDu3xo+Kqc=; b=uK3EO+UUdrF7TqKLEog0MVuXsL
	5CfgTvAkBoN0vaVeCHW4FjSWaUl2MCCjwdOudga6DiIfdpXC5bbHqEhv+/QXingk
	3j+kWao0v+LhBxrMkvcojFxkjiROQev5e2cHn91uzi+/1O/p1swxlsHmjIbslLwG
	VuLOk+rahCZdUzjG0Dd/bsXb1MtG2L1iZR+iFcdPi/D++JLoOJDRYhDYP6nHzh/r
	aXdjRqoPD8/wyJhaiXo6aCAxJ2Bvzci0X5XJycTAleWc9i56FQwmNC1YJW2rxrw8
	g092y2jMYtbfMiUyVXkZrvKGdjijTvd1FNNFqFRYxP0hjGay9BztS9dlOllQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742944779; x=1743031179; bh=bQutUzqqwCfzTbl13kPmps3gzceowyo0vhD
	u3xo+Kqc=; b=QlacJyrZNavrFYG73FL/8B36lklayMuBQQwRCA6Fz2dEFNCAVf/
	JbHO097wTAsN/3IhIIEQdJwTGUNeuytBvWOl1aoPWt57PyCdGLOO8Rf/HQ80ICOc
	zF6Ot+LXp0QanRyrTLo2+Ts96NJI6JGfygm0eXVvRA52DJ+wgsaN+4F90noZY0Ua
	2zAhGnvjsi8C5V3sBvrstKjWOlT6VTW4LepmRP6cNst2eiKDwncwrZD8baY3F35z
	bLNFKFO7rcknJO/6LSPuSbtiNPgHB2nU8L/OiI/tshsLm3q7UC/9b7qFf71Wxo2o
	jnAUft3o+nhdo37RDoU54VLQ2K3h5JvI6jA==
X-ME-Sender: <xms:CzrjZ_yorrK0IK_jB1rmKBg__OQOLc4X_GK2al2reW3BHtIITRJb1g>
    <xme:CzrjZ3R3dpizLeyS5KBEXGDxNYu21SS3q9yHxEYfkk3tgDrnAw4ITsEzCsUQWPmZN
    mY0KQat_twybi--Jw>
X-ME-Received: <xmr:CzrjZ5VsEwhpMQg8T-aAl0m-6jsLulD4OxNCkS5vTo78zg7Y-FXM63NYNdfFU4oR7-YGC_21h92H9Uc7Pcu-uSAXh5u7Ev78h9EgWZM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieefleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhhikhholhgrhi
    drshhhuhhsthhovhesghhmrghilhdrtghomhdprhgtphhtthhopehrshgsvggtkhgvrhes
    nhgvgigsrhhiughgvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghs
    thgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:CzrjZ5iFEnh1cEVDKg1vj8MxEcHdWKVFdgV7mO41ZDBV-4_yG4wpEg>
    <xmx:CzrjZxA2TfhEHwza4XTfKf6Ts_2qGXJhGbcFUu9d9T3P72DQstIU7w>
    <xmx:CzrjZyIBGU-EaiQ-xpqy90mAWQ7K98itcWc4Pd7BZVsCvBxaX9jB-w>
    <xmx:CzrjZwCZnx5qIRxCpIdTcFXpjGOA__0R16tNecEURxVCK_IMm4Q3PQ>
    <xmx:CzrjZ06D7nrEESfk4-6_Zd-4YhRD7235YpnIeJ-G1JwcElO6M0ZqJw8c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 19:19:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Nikolay Shustov <nikolay.shustov@gmail.com>
Cc: rsbecker@nexbridge.com,  git@vger.kernel.org,  "brian m. carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [Question] Moving from Python2 to Python3
In-Reply-To: <66e39a95-09a3-44dc-ac71-a6c02b5949c9@gmail.com> (Nikolay
	Shustov's message of "Tue, 25 Mar 2025 18:40:56 -0400")
References: <022b01db9d99$e68785c0$b3969140$@nexbridge.com>
	<Z-MgpuxFQ3xEgvsU@tapette.crustytoothpaste.net>
	<66e39a95-09a3-44dc-ac71-a6c02b5949c9@gmail.com>
Date: Tue, 25 Mar 2025 16:19:38 -0700
Message-ID: <xmqqtt7glmut.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nikolay Shustov <nikolay.shustov@gmail.com> writes:

> git-p4 is designed to work both with Python 2 and Python 3.
>
> However, changing just PYTHONPATH may not to be good enough.
>
> In general, it is necessary to make having PYTHONPATH value and the
> version of Python executable which application is run by, to be
> coherent: Python executable has to be able to work correctly with the
> libraries PYTHONPATH points to.

Hmph, but isn't that the core competence of those who package Python
to their target system?  If we run something with /usr/bin/python3,
without any strange customization, that binary ought to know where
it should pull its associated standard library files from, and we as
the language users do not have to worry about it, no?

