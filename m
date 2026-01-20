Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F92B1EB9E1
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 02:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768875592; cv=none; b=JdgGio2Pa8w95hJFPWfclfhlxTDgk3KNJpmy6xuED4azLa4zEY0+2tituvXpzT10UvHJoRJ28jpavsnSkeY2Aw26Mv8dnxKVCLZlkxK+gC1qGHShep3xuPt5jTU7scjPr8pUWJiYBSZEXYyMrdmL5spIb83Aq7hNPg4NVLIHSAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768875592; c=relaxed/simple;
	bh=3mSqQkOACu6eT4LkcGVbVOcLuJv4e4Ory3eOBvA+fds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rKcrl0e1DjowRFmPniy8ZHb5EcW1C6O8El5o5K5Dye1ZwdNpgvkUYJuAoylGWoCEqqIBAncU+nuskQKqMTmVRXy7U74TEBXot6vEr5gttL1LxIuRwnBrMKTY2782GKqLq0srqAs2sXqcU8websZKNFJ7xtHuiZzjTlDy8J373uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bxGLEW/R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VR8SL0am; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bxGLEW/R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VR8SL0am"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8356D7A0586;
	Mon, 19 Jan 2026 21:19:49 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 19 Jan 2026 21:19:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768875589; x=1768961989; bh=yN2p4WxLGR
	DidqpwuS8zgIohhWUZNMX6F/qbGiKxlIY=; b=bxGLEW/R2awqGjnBYjslVI3QDN
	X/IcH4YxPEDYaTSA2/qqHHGz+DnRtkSK4yt/ZgphI0ys9PkANVWhiEkQUW3ZQy7g
	sq227FBLAAIpju9EHQDGxNfFaHW29AIOczMuAIKSUG0Jg0CKBzABtOB/Sq7cxNQD
	RwYkWtEJBowG8WCW0O8Vr/cXRT8kiHAXh/8isUxjVRzTqVKIyQA4SL4sw4dPpxbF
	DFOjGIsbgDpYpBA6opT6lJQJIZYw2mUSetw4Ha6iFjZ/ViG8OEu7uW2b6lcLHvEo
	0h38Uc+4cq8JqpN5Gizu2mPARDt+g12EdQwW5XdkWAqb//cLM8NGTkbGw8CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768875589; x=1768961989; bh=yN2p4WxLGRDidqpwuS8zgIohhWUZNMX6F/q
	bGiKxlIY=; b=VR8SL0amWxqTcoxKhR0McIAC0g3DFYKClEFOqy5E+CnkxY2n9FN
	NO4rDff7IKafL2ghlxARRKrTbG0JX8IVw1MtVO50wZs8a1FYWeFGe5C6cKr22xw3
	fKhpPYl0KeLxIp3Xdl4GAblZ61MEzAbyIYdIqVilUv68O0aUN/BHiHBv/OR/JeXh
	YLdOeIAahJhz0CCvfR6B0zi8F053RdqtbmT6KanrCrGsOsmnQwT2ev/qmRseU5ie
	66bd9KiWilSyx31gdjwqCwj6IcivyhXfMtL/CP6alUfZqxa3vrMvmapd0CpRv7Mf
	jxi8VVcbVSXzco7If/EhX/i68mo/QDZFoDQ==
X-ME-Sender: <xms:ROZuacT_wkfg2MWaqGjfNaHy0Tk_WZlqsnT4lElPkIUpFy6g-MjMKg>
    <xme:ROZuaWu8DRSJ4ynOZFsN8NNGKTJ19jFhdZUjTSztXVb2TiZho8bD_uZU3uklGF5ua
    0K5N9j8HHAQB1AsOetotNyzZ5TwFvVni92n0t_lzYKs5a6aLrpBow>
X-ME-Received: <xmr:ROZuaVd5rtKSZvr_xYQhUZy8FcvEVlNXsOfXgyn8yeD8waZ8nIRik3xB4DfeHpo2Ix2BAE4c7ReHlD4ePvoXXCI0TX3BfiEpqDwQOps>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeelvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepvdevleffhfdttdfgieehgedugfffvdffvedugfegvdegtdehlefhvdeujeeh
    tdfgnecuffhomhgrihhnpegrshgtihhiughotghtohhrrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepsggvnhdrkhhnohgslhgvodhgihhthhhusgesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhish
    gtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopegtohguvgeskhhhrghu
    ghhssggrkhhkrdhnrghmvgdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
    dprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgv
    thdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ROZuaYZiwOt3PctMTK7-_vyg-a7Vh26obtg1p44VUtSPdEY7-LWqZA>
    <xmx:ROZuafZUriFK2g7pzZiljhQF66TjX1Z3MSQjkdbeWqjOWeb-zIVHEQ>
    <xmx:ROZuaVKBGiGHxYhdXFlLK5kLHbofm8QhYrl9J0VUy9QCVsiG1WG0CA>
    <xmx:ROZuaTucxG4-m6PA8ba30UOMVW6RE_i0-VBJA1ODSkDY9GNT3MerTQ>
    <xmx:ReZuaVhKn92LCGYnR-y5wc5ZcIUoA9gNkcf6zdmQtA_7aDEYmoOnWZTZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jan 2026 21:19:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,
  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Elijah Newren
 <newren@gmail.com>,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH] replay: drop rev-list formatting options from manual
In-Reply-To: <01a7acfaf87494419b3766da57d4c05cf99c79bb.1768873599.git.ben.knoble+github@gmail.com>
	(D. Ben Knoble's message of "Mon, 19 Jan 2026 20:47:29 -0500")
References: <01a7acfaf87494419b3766da57d4c05cf99c79bb.1768873599.git.ben.knoble+github@gmail.com>
Date: Mon, 19 Jan 2026 18:19:46 -0800
Message-ID: <xmqqldht2fgd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:

> The rev-list options in our manuals are quite long; git-replay's manual
> is no exception. Since replay doesn't use the formatting options at all
> (it has its own output format), drop them.
>
> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> ---
>
> Notes (benknoble/commits):
>     I noticed this while reading. It took me a minute to find the
>     Asciidoc reference on multiple attributes [1] since it's not used
>     elsewhere in the rev-list include :) I'm not sure it needs to be
>     included in the commit message, though normally I would, personally.
>
>     [1]: https://docs.asciidoctor.org/asciidoc/latest/directives/ifdef-ifndef/


Indeed.  Not just rev-list, but ifdef:: or ifndef:: anywhere do not
check multiple attributes in existing docs.

"ifndef::git-shortlog,git-replay[]" is rather hard to follow, as it
is unclear if they are ANDed or ORed, and it does not help to have
it with negation X-<.  I guess there always is the first instance,
and we need to get used to it ;-)

As long as the construct is understood correctly with AsciiDoc and
Asciidoctor (two renderers we depend on), it is OK, but I do agree
with you it deserves to be said in the log message that you noticed
this is the first time we use the syntax.

Thanks.

>  Documentation/git-replay.adoc       | 1 +
>  Documentation/rev-list-options.adoc | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
> index 4c61f3aa1f..c3b214ec69 100644
> --- a/Documentation/git-replay.adoc
> +++ b/Documentation/git-replay.adoc
> @@ -64,6 +64,7 @@ The default mode can be configured via the `replay.refAction` configuration vari
>  	range should have a single tip, so that it's clear to which tip the
>  	advanced <branch> should point.
>  
> +:git-replay: 1
>  include::rev-list-options.adoc[]
>  
>  [[output]]
> diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
> index 453ec59057..c4d7a6b989 100644
> --- a/Documentation/rev-list-options.adoc
> +++ b/Documentation/rev-list-options.adoc
> @@ -1096,7 +1096,7 @@ endif::git-rev-list[]
>  	Overrides a previous `--no-walk`.
>  endif::git-shortlog[]
>  
> -ifndef::git-shortlog[]
> +ifndef::git-shortlog,git-replay[]
>  Commit Formatting
>  ~~~~~~~~~~~~~~~~~
>  
> @@ -1265,4 +1265,4 @@ ifdef::git-rev-list[]
>  	counts and print the count for equivalent commits separated
>  	by a tab.
>  endif::git-rev-list[]
> -endif::git-shortlog[]
> +endif::git-shortlog,git-replay[]
>
> base-commit: b5c409c40f1595e3e590760c6f14a16b6683e22c
