Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A0720C488
	for <git@vger.kernel.org>; Thu,  1 May 2025 23:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746141764; cv=none; b=Cmeaytt4dg7pFswpTDBrEbahknFnmOPGlGk1IVetV29MqyHo/gmCfimJvK9kJQiOOYp3vLr5prk1slAjag/gauJwhYoItOLLXAQb5dAiYIWmhmXZszc+FEAmBICgO+naD5k77I38mMBlLCQHL7hyxYlF9v8fA3qtHkbDCcvHbeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746141764; c=relaxed/simple;
	bh=FP4z+0WLg7RERnEWv6Wo29epDodmWp3OXSaDo6m5ehY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NryK8nt19SMIovG2lQUfTxmciDPcpQraiFnm9TU2H/TPzniDGNkPW3GxnuzgtXqyEoUPB10OKGVOyatXkNFtzve9+KlmtJ3aLHTWgaYmYp7929almbsI9TrCSqS6YSpN16W+B5NcTJ9y+hgQvL9VNtcoxvrQ5KVD2CNkD3/pHYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PH/CQ39k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CIwGumCO; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PH/CQ39k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CIwGumCO"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5CAD113801D4;
	Thu,  1 May 2025 19:22:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 01 May 2025 19:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746141762; x=1746228162; bh=azhPIX3N+g
	0ROeqCK13Dp+y7L1UTZ9bbDuJU67xRrx8=; b=PH/CQ39kPeidSlz7S0OVafK6Sw
	vKbIfL1yTsfJ7ExB9+322Z36a4mMsSIukq/9Wnn3M9oDtgYfNZ7bgUO1OSgX6Hh+
	0D6yixgDgMUg6GmhjcGwzOEqsNI5veH8TMcOexBW6Hn6clYok74b1XmlOtT2I+b3
	eMQ4/6mWFgQfdQwaB51V8lAWHAhu/y9ySwfYl+4SHjPcx932e6N5hCnb4YbwL2IK
	u0aLwpY/QEjR9Gqk1HYHNZoFVckfmr16k5Z3lhCWqNhnWSVQzfYxqQO1pvHZEqMo
	nf2Op2CuuYZF/P7xdXVzWV0axRWWsCbfvd88nqmEtY98rvfBic0lDJK1JTEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746141762; x=1746228162; bh=azhPIX3N+g0ROeqCK13Dp+y7L1UTZ9bbDuJ
	U67xRrx8=; b=CIwGumCO8RoYCTUy1SkqY5nUfdhY5VQ4XY6h7o5Z4LKbFR3sDoy
	pmMYvuTam90DePzejujWcQ3BAVWICYPbX7Z9fkj6qPd+ryb97yBlEilqrW0Yjck2
	aCPT2P3nSO+Uw+JlmToXK5x8nE8IlCqj77aVndEkJp0XSTn2oB1anqQIu9twX/q9
	Jrjq/7qnRbWa3kpQTQ0/dW9xTDtv9hxXWR5VTJhHdYHjnSjrRKQJ1jTa8aDb0o1z
	L1f2vW4xY2Fl4HMyh9rXjs6aT7ivcXN9FIOs7o+ptJTJayHApufAbffSFLjaJesz
	cDBqreZEENINdhc1exdEwBerjzbDKCz61rA==
X-ME-Sender: <xms:QgIUaJZIiZp6Qh173ckTR9CyjcOTV5zHTRtoXF5nfALRWqAS5hdZhw>
    <xme:QgIUaAbI6GlVPfoqyUT34XCWnniEYCW3sq8lXU4UdnVKoJO5-HaAd5xaTl0UK1_VX
    LTQjUUUpP5-hJJLDg>
X-ME-Received: <xmr:QgIUaL_musxV_j8NZZPkcdOO6IadqF35pzFWc0MQwSFDXMabdGWYTpuacB_GSXpuTa4qV5Mppv6myea4OmEI3bxoLT7m-7tm1hit>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedtkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepvedvffetgedugfeiieefffeghfegudek
    geekfffgieehvedvudefkeejueehueefnecuffhomhgrihhnpegvgigrmhhplhgvrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhi
    thhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:QgIUaHpF27Wur2N-9pbawWeNVimutSte-kHXQAkbXjK2SeNMLtAYBQ>
    <xmx:QgIUaEr1g4PaJU2U7qyBikhIwkRqd8hgosmkthQiYE8a8N02nigwfw>
    <xmx:QgIUaNSIrlr7xw61D026e47PKyHbxze3m4BAR1P-Us3AWC0FpymH5A>
    <xmx:QgIUaMpLTNnEvF9Cn502UXXPMgq1mLR9h9x5E0H-FEFaeEeqglUbiA>
    <xmx:QgIUaBOZ9KTiGMFWzLxtDiRDCgdOKHxKSTjLrv9L0CmEk-OsNPw-TVYW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 May 2025 19:22:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH 3/4] git-daemon doc: update mark-up of synopsis option
 descriptions
In-Reply-To: <xmqqa57wvsbb.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	01 May 2025 16:12:40 -0700")
References: <20250501213414.370514-1-gitster@pobox.com>
	<20250501213414.370514-4-gitster@pobox.com>
	<CAPig+cQ1CC2SXN6bViusJXy93jZ6k8UvxRXa6mE0At6FgvS2-Q@mail.gmail.com>
	<xmqqa57wvsbb.fsf@gitster.g>
Date: Thu, 01 May 2025 16:22:40 -0700
Message-ID: <xmqq34dnx6f3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Here are incremental changes relative to the previous round, taking
inspiration from your suggestions.

I think the sample option, sitename, and pathname must be typed
verbatim by the readers if the behaviour described in the text
is to be reproduced, so changed them in the base-path description
all to be marked up as `literal string`.


diff --git c/Documentation/git-daemon.adoc w/Documentation/git-daemon.adoc
index 3eb9332e55..bc3f77405e 100644
--- c/Documentation/git-daemon.adoc
+++ w/Documentation/git-daemon.adoc
@@ -32,7 +32,7 @@ that service if it is enabled.
 It verifies that the directory has the magic file "git-daemon-export-ok", and
 it will refuse to export any Git directory that hasn't explicitly been marked
 for export this way (unless the `--export-all` parameter is specified). If you
-pass some directory paths as 'git daemon' arguments, the offers are limited to
+pass some directory paths as `git daemon` arguments, the offers are limited to
 repositories within those directories.
 
 By default, only `upload-pack` service is enabled, which serves
@@ -49,15 +49,15 @@ OPTIONS
 `--strict-paths`::
 	Match paths exactly (i.e. don't allow "/foo/repo" when the real path is
 	"/foo/repo.git" or "/foo/repo/.git") and don't do user-relative paths.
-	'git daemon' will refuse to start when this option is enabled and no
+	`git daemon` will refuse to start when this option is enabled and no
 	directory arguments are provided.
 
 `--base-path=<path>`::
 	Remap all the path requests as relative to the given path.
-	This is sort of "Git root" - if you run 'git daemon' with
-	'--base-path=/srv/git' on example.com, then if you later try to pull
-	'git://example.com/hello.git', 'git daemon' will interpret the path
-	as `/srv/git/hello.git`.
+	This is sort of "Git root" - if you run `git daemon` with
+	`--base-path=/srv/git` on `example.com`, then if you later try
+	to pull from `git://example.com/hello.git`, `git daemon` will
+	interpret the path as `/srv/git/hello.git`.
 
 `--base-path-relaxed`::
 	If `--base-path` is enabled and repo lookup fails, with this option


