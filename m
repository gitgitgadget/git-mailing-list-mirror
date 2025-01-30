Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAEF1DA4E
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 22:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738275476; cv=none; b=dRBGsDS8giUsk7DQlslXgdJ0TtjMQrxPRo1M06WvUToXD43hoBfcqvfcpmAVjHATsE7mMOubtVkOZrJry3uoGj4Su6Xo+MBH+mrYM+47m6ylTWDUZebxP8FCDQepOZPoE7YEUpxXdyUnjwecyvZmr3upZPZlvSeB0eKXaBKVyR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738275476; c=relaxed/simple;
	bh=4x7Hg4hfpc8CKd/iC5+fAOkZ+KgoVVwwG3+a6nw/NFY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FCBqHI4M8L1Hu4SMJ/JSPjya/mxB8tHYqYECsQj9WRZm8SvXHZC+wM3GY3RuDET3BUuzzHcgNSn+U36yP0u6t++rA5DqIs2gyn3d92ejdpxBEHkCR7vvrwoGrSwRsx/nBckOo9cgMvFwHHJl8/ou04nUaXUc9qtGWkWH0QkqZr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JFZvp6C4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QPhZx0SN; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JFZvp6C4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QPhZx0SN"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AB188114012F;
	Thu, 30 Jan 2025 17:17:52 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 30 Jan 2025 17:17:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738275472; x=1738361872; bh=WfLffflJoB
	Gmx99JfELdKX3vg8u85R29QQEvWs+JuVA=; b=JFZvp6C4NtBl+Wf/PIVTlEisqU
	Xc8eLBiaHihI9ZIE1d+KWT4xIBs2ITv/douleYojV32oyPqo1d6X7KwDSgZargrh
	b92KEGR9UuU1Q90kljMp3mgIsTFD42fughPuI1Nl4Roy6JS8D4RmM9alyGBfu9V/
	6gg78ivuonMF92tYP13VI0kpEphL9Q15cQoQ+DePyk5foNJy4YMc6sqrVZuvSsTW
	SxRAonJUFmnPVTTZm5FjsGbQXzCnEWfJhvY4gnAwoXlUVJVKVbdVBKEP5FvNw/yi
	wdgkIgqYXfToxL8VyCtaT2OIOfUrWt67+YTxC7V4qcEoW+DeZpy4m9dKZOlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738275472; x=1738361872; bh=WfLffflJoBGmx99JfELdKX3vg8u85R29QQE
	vWs+JuVA=; b=QPhZx0SN/9SkrGi7iZLu+lfTPmxXkhDK+xPBdEiNYZXYDz17nMg
	eOe6wjPE7FKQhWLPBbdMjlydTrskpqd1u5+hXYPCAnsta9VVMpY/epZy43hAGNuK
	TaJg+OpbYwucvpTkRALzypiIzJNiRh7P9J5wYDwp13QN3y0byRDfF6b4yN4bQ+og
	1X3sCvdI/m2otBYDlEwRwBMwdD9NdlXrf8uku3kndXJo11rGrRrBe7FHJJd1ikv3
	FxmcXQRz9bbpT+FtF9mX8WW/oXN0fVizPuoHWOCE4BXToFCB+KNLn5erJC8EBl0P
	Ok63JPvG5He1WHxAVA1Tcn/WgEdoiqM8CPQ==
X-ME-Sender: <xms:jvqbZ3T2FbIpgmEMOM7M45sEmy65VLXISaLp49FFyn-fCuHzlahvgw>
    <xme:jvqbZ4xDrKFLudTW7U5lT1Zh8IiRTslcGhebGHAxHPn1I8GS2EAZrXgRuhYC5Y1fc
    07JbAz4nZxWok8ktQ>
X-ME-Received: <xmr:jvqbZ83ieD8GFbBkd0unyCQPG1uuSgU4eCl3-bBgm78ykNBYhHjG_C3MeiAAXrDe0RXvJ2COP5fN0mAI0Il5ZS0OwNBZm-vH4l9X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehsohgvkhhklhgvsehfrhgvvghnvghtrdguvgdprhgtph
    htthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jvqbZ3ArHMJzHOGQljRwxn1F8gxGG33RZMMwY2pksT9t5UcjCHeDBQ>
    <xmx:jvqbZwjjiFy3BkQbS6NfDB-M4Zn0jTycfQ9L8sBcHmGCFv1pZY9ZXg>
    <xmx:jvqbZ7p2iB6q_ZBu6G8OkDJf7BPWw3AAKYkzjEPb_WiLDpGleYfipA>
    <xmx:jvqbZ7g628zaeQLcLxt91J6yfjJ-erRB0a81K7YXr2Ay-t0oA_QA5A>
    <xmx:kPqbZ6bBxgS9ZFbyFCYutZZHt_bspgwwCigEfSXHfBL8fkoTLt69aRgf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 17:17:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?S=C3=B6ren?= Krecker
 <soekkle@freenet.de>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] apply: detect overflow when parsing hunk header
In-Reply-To: <pull.1858.git.1738235310815.gitgitgadget@gmail.com> (Phillip
	Wood via GitGitGadget's message of "Thu, 30 Jan 2025 11:08:30 +0000")
References: <pull.1858.git.1738235310815.gitgitgadget@gmail.com>
Date: Thu, 30 Jan 2025 14:17:48 -0800
Message-ID: <xmqqh65gaqur.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> "git apply" uses strtoul() to parse the numbers in the hunk header but
> silently ignores overflows. As LONG_MAX is a legitimate return value for
> strtoul() we need to set errno to zero before the call to strtoul() and
> check that it is still zero afterwards. The error message we display is
> not particularly helpful as it does not say what was wrong.  However, it
> seems pretty unlikely that users are going to trigger this error in
> practice and we can always improve it later if needed.

Thanks.  We made an effort to use a type that is a bit wider than
"int", but we apparently ignored that the Git userbase will become a
lot wider some day and unfriendly and/or hostile folks would start
feeding malicious input to us X-<.  The check presented here look
good, and the fact that there was only one change needed shows how
well designed the base code was ;-)

Will queue.  Thanks.

> @@ -1423,7 +1423,10 @@ static int parse_num(const char *line, unsigned long *p)
>  
>  	if (!isdigit(*line))
>  		return 0;
> +	errno = 0;
>  	*p = strtoul(line, &ptr, 10);
> +	if (errno)
> +		return 0;
>  	return ptr - line;
>  }
>  
> diff --git a/t/t4100-apply-stat.sh b/t/t4100-apply-stat.sh
> index 146e73d8f55..a5664f3eb3c 100755
> --- a/t/t4100-apply-stat.sh
> +++ b/t/t4100-apply-stat.sh
> @@ -38,4 +38,17 @@ incomplete (1)
>  incomplete (2)
>  EOF
>  
> +test_expect_success 'applying a hunk header which overflows fails' '
> +	cat >patch <<-\EOF &&
> +	diff -u a/file b/file
> +	--- a/file
> +	+++ b/file
> +	@@ -98765432109876543210 +98765432109876543210 @@
> +	-a
> +	+b
> +	EOF
> +	test_must_fail git apply patch 2>err &&
> +	echo "error: corrupt patch at line 4" >expect &&
> +	test_cmp expect err
> +'
>  test_done
>
> base-commit: fbe8d3079d4a96aeb4e4529cc93cc0043b759a05
