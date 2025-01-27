Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D4F53BE
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 20:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738008848; cv=none; b=LrpiXn9xQ69NFxlqLNSmJgzs/h+eJ55tI6o7mbGl7VZwASDgITAcdbevWjJLZqVVK/68jnjUCHxTWxfTQ3b6p3e+ZrtU5hCC7kMlF0S1xEpFmAlfSOE0J7sR4IzaUJ8Mz71rt2LHVst0FurlWZHO1gZAlwGFQlv4qdfjmEXjaLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738008848; c=relaxed/simple;
	bh=BjHn8TI5VW8VtPOxsGzQUztzeBSUg4ibWTm23FgRguQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tQtE2Pz24nAHWPE7Xanm9uK5SwyyUafDgcjpSay+R6PHXStc+uwZCbthiO3CoIKMrHhIpJvYg7MQYfjXZ831oZIkDFHAcbgAFB7ap+bP0F6R5o82In0d1nXx6YQ/k19Zbfes1bmxFgEXhJPJcRsQg5ge1PoVYJJi1TS3RRbp0HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mtuvfHNK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nr0CHsFe; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mtuvfHNK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nr0CHsFe"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 5B13711401CF;
	Mon, 27 Jan 2025 15:14:04 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 27 Jan 2025 15:14:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738008844; x=1738095244; bh=k0+OOol2xM
	BNEER5xGyauLoEgsoOAFlC3maM1pF5gTI=; b=mtuvfHNKonZsee61sYELhVcTWG
	ACcJ9rVS5YI6z9mxeFuz7cfFjTKghieGyjYPsAS8e5OKq98yx3eYy8wU/fJ1G2Tl
	4y4ws+Yv3EhwgqwMTABaKrWi/4FNJ12qFsZGrvIesjQb7LBveWHFpmby9bJVAabB
	zuLjdwsOMVRL77PWPHVVXtStoAQn8o3D0/C99qb9SjHyhNfQ5R+PY+F5lX4Ah7ks
	zhE/bVtoD/Mdzu18OOvyRl1itjK5E4hGnh+xVXQwz02VwniaOEhTMWsMQS1f4bZJ
	v/Y6M93KXvaiAdtfapV7+uauFPzYOBH9m+Nq5imdwL85ljruGYMRFUj58zfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738008844; x=1738095244; bh=k0+OOol2xMBNEER5xGyauLoEgsoOAFlC3ma
	M1pF5gTI=; b=Nr0CHsFexza7Gv/FzjpV5sO+398h3tvB2fa9JkxEw23+sXNzz1b
	wuWjtuCJUtr1+Zr0mgBjdMheyWCYfZnM4UvJZMzwOTE1EL15IrlQOcUImq06Ha3T
	4erjBZuYTjENv86Hd7Q0Rrf8pl9YhoC7tOkCZSL7l5mk7tiCPLpUZt91MrSBB5K5
	L+hRPlYrrsovGOynjlrLTHMB509QHBKyEmSzOdTvCxLTYyPIKUCqM1r38rWbfEB3
	JCMWPwwufns54C9HnlEdCukG6iJU+1+xW/87o+cRJlTlfXthUKIuARzT5/DS1bco
	sO0toklwVFlwFb+5AX4ikK5iw+lKf1YwrzQ==
X-ME-Sender: <xms:C-mXZ9HS7r_AyZ6SjNdfOopup6JPAWYphq5T23rYMovYlcDiZyCXrA>
    <xme:C-mXZyWluSh7PWjRiULMr0gP1sOjkbP2jBJ4dfA2p92iGR1ELwzOBMKkfbxw-2lDN
    9m98se1ma08CkbiaQ>
X-ME-Received: <xmr:C-mXZ_Lm5mzr0vBWdbR6CV7r0voIQbCA2Rt-stbSxfNxHjznSlGth7lpOg8nDwxR_KdhE2E3oDg8y9Ad-iUhXe-aP_NhTZe4xOBM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudegudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvvghtshhonh
    hifedtudejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehshhhusghhrghmrdhkrghnohguihgruddtsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepjhgrtghosgdrkhgvlhhlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmh
    grthhtrhelgeesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhn
    vghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:DOmXZzEtydnfBStwdMDNQk_56o_AxRob0_AqtQejEB5wq51_G5ST7g>
    <xmx:DOmXZzUIstzWYvhl03TrUoMzscCeom8BSJObJ1eCt0Ft2AkJBvyObA>
    <xmx:DOmXZ-O47_JGGxwuW3k9lampzCzjWnUXKgxHySL9RxyxOyxUGXNehA>
    <xmx:DOmXZy08D46EL6wLMDnKrV6l37gZoxJyWf9nTmdFp3k-nDRrYOSz5Q>
    <xmx:DOmXZzT8t9XUqw-FdeVrJtt5PAKjvDtSl0Az9TBfxCiL76KRbhfWp8ax>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 15:14:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org,  shubham.kanodia10@gmail.com,  Elijah Newren
 <newren@gmail.com>,  Jacob Keller <jacob.keller@gmail.com>,  Matthew
 Rogers <mattr94@gmail.com>,  Jeff King <peff@peff.net>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 3/3] refspec: relocate apply_refspecs and related
 funtions
In-Reply-To: <20250127103644.36627-4-meetsoni3017@gmail.com> (Meet Soni's
	message of "Mon, 27 Jan 2025 16:06:44 +0530")
References: <20250127103644.36627-1-meetsoni3017@gmail.com>
	<20250127103644.36627-4-meetsoni3017@gmail.com>
Date: Mon, 27 Jan 2025 12:14:02 -0800
Message-ID: <xmqqtt9kqak5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Meet Soni <meetsoni3017@gmail.com> writes:

> +/*
> + * Remove all entries in the input list which match any negative refspec in
> + * the refspec list.
> + */
> +struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs);

Excellent.  

    ... it is merely moved from the original so it is not entirely
    your achievement, but still, this is good.

> +/*
> + * Applies refspecs to a name and returns the corresponding destination.
> + * Returns the destination string if a match is found, NULL otherwise.
> + */
> +char *apply_refspecs(struct refspec *rs, const char *name);

Explaining a function whose name has "apply" with a comment that
uses "apply" as the verb does not add as much information as a
comment with a bit rephrased explanation.  What does it mean to
"apply refspec to a name" in the context of this function?
