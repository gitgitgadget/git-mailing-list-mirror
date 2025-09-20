Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0846E179A3
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 17:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758390520; cv=none; b=jCj6jDIUVxAhnNyVENYcWdgAMjBNECxOrYf9o9sMP7hs3W73v4ddeK9srWzx6QUf2CXbrY5Om1uE9zj7LYNbBKcTitasGdNyQaSQgUnyczsdP/jR0tI+loplU7iH94Hh598XLSFDOnPe9wX8nKEucrjwZcb/XKUBVgbS94p5aqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758390520; c=relaxed/simple;
	bh=NBrHJx0AdhOwAFuJQB2GU8FPvMnVcqW0HNhFxqQrkZA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yq6byc1wqMQk2rJBB55na2yHUzmx23TxE83teBWTLZp/d+iFXGzq1YI0def5BfQDpEgohNa8opOzyvq+uZMN01euXMaMioSkYG1D928IdcXPkKI1Vkzn3K6TJxG6gLBlFjMyxDPagU+PkhWgn7UEo3JkCRal2TCuOULAb+mdLZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JVL5p5tV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PH2kYJ98; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JVL5p5tV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PH2kYJ98"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2D0FE1400095;
	Sat, 20 Sep 2025 13:48:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 20 Sep 2025 13:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758390516; x=1758476916; bh=iEv94WK7DS
	zkzYurf9a5Pboeh5OsmUsGE4nbU+c1pIg=; b=JVL5p5tV3V3aD5aLmGovXVvGD8
	BxznTN4wiYaZpgVwMtDjKOemO56WzVDwkyVe4MP6q/50pYbHoWoBRK1vNm1VAFDD
	m/0OrBVuTJQNxpvfM90mq6Va9LCdB52Usnh/+/j4pkOxg62D6Tcn/d61To1LZtT/
	a7PuXqCuNLk1uTEtpC5bFlIJT3bHPNWY8Uq7QWoK8SqckrKLuXaXj/qurTea8eGO
	UHMNDRVvSoajRVOqdJ8yEVe5TEcR37e9EsUhRjF6pcGlX4tUvTzbGt21TP8xL5Ki
	AfbKPsOddvX9t5f4i39zwoJU1CbQB+lNNRiPHi6gsXgYwCZ3+ncREWFPHfIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758390516; x=1758476916; bh=iEv94WK7DSzkzYurf9a5Pboeh5OsmUsGE4n
	bU+c1pIg=; b=PH2kYJ98ojXH6xeY7wfqb1OvnfCYtjlFG8WToYEdn3v8rgpnHis
	d48/0Y/UQmP7fTktbHduVInHBDIOwjJBTZSzJZAKR5o6olbbh7Fwo16F5OgwPQwy
	iLvcfyvIJ990ORzEZY+5A7aNXYhDRSUehnW2or6AaDAVJxzntxtz13hxirTc/19Y
	IEdvwpFCN0JaI2sr60OsRHvMPfLOPM264fXOtnZW5WxE2+WJffyO/UB11ekKiSNI
	OzXpJ8DFUhkdSx6/Bh6CO7ffot2xm7/y7ReerzpfkIAMMNdeRT5h2jOGQAYQNvnZ
	kqTYMQAoT0CKCb+wf4jmb3cdfPQFibvW6iQ==
X-ME-Sender: <xms:9OjOaOqjJK_noUBpol9u9D7yBOSSkFGobRYbS_movyfx_121CMw2rA>
    <xme:9OjOaKPi2XCMqYjZ1fFfMkZxoGaCRIcO38OvgNi7KWJMO2ejRSLMmdzksgYR1D3Cs
    niwga7KuhAsSqUKOA>
X-ME-Received: <xmr:9OjOaJpfV6XxANDrkDYK41i64tIyhNW2AggL2Sv4Ow8Z_uyAhWhNaeWkYW9mQKZ6lNlRWrk2ghz5UCOGI7oVrgOXaFsG5kXEoSKn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehvdejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    nhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhm
    rghilhdrtghomhdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9OjOaPfkxNtDeJYTzyYF3ly1DPR7k2OaYaNE8MmB1qx3XAV2vYH-0Q>
    <xmx:9OjOaPTGjBBXaaPjAggRSNUTh16_u3CF6o6T1bkh5g3iiutU2hR2Eg>
    <xmx:9OjOaIZJevsBCgj3XXefllLcL_97uAuLEA6cr78pcJx_237bin_Pvg>
    <xmx:9OjOaCetEHs2YMsIP17gNmOjPEF9-_fksI_Jks9-NG7XgZpjUCN8AA>
    <xmx:9OjOaG6M1et2y95oNrRDIuTHrz1JAHEwo6diEQAHpcrU-UXC2J7uw-0p>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Sep 2025 13:48:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Ben Knoble <ben.knoble@gmail.com>,  Ezekiel
 Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v3 04/10] xdiff: delete xdl_get_rec() in xemit
In-Reply-To: <ddfee67e06bb56cfa8f11187dc27135bfce63647.1758294992.git.gitgitgadget@gmail.com>
	(Ezekiel Newren via GitGitGadget's message of "Fri, 19 Sep 2025
	15:16:26 +0000")
References: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
	<pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
	<ddfee67e06bb56cfa8f11187dc27135bfce63647.1758294992.git.gitgitgadget@gmail.com>
Date: Sat, 20 Sep 2025 10:48:34 -0700
Message-ID: <xmqq8qi9xbf1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ezekiel Newren <ezekielnewren@gmail.com>
>
> This function aliases the fields of xrecord_t, which makes it harder
> to track the usages of those fields. Delete it.

Can we phrase it in a way that is a bit more friendly to casual
readers?  It is hard to tell if the function is serving any useful
purpose from the above.  If it is doing something useful, but is
hard to read the surrounding code, that wouldn't be a good reason to
remove it.

It seems that this patch does what people often call "inlining a
function call".  I am not sure your comment about aliasing or if
that is why the code is harder than necessary to read.

> -static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb) {
> -	long size, psize = strlen(pre);
> -	char const *rec;
> -
> -	size = xdl_get_rec(xdf, ri, &rec);
> -	if (xdl_emit_diffrec(rec, size, pre, psize, ecb) < 0) {

So we used to get "rec" and "size" separately because xdl_get_rec()
made xrecord_t inaccessible to its callers.  To call a helper
function that takes a <ptr, len> pair, xdl_get_rec() is the way to
grab that <ptr, len> pair out of the record index.

> +static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb)
> +{
> +	xrecord_t *rec = xdf->recs[ri];
>  
> +	if (xdl_emit_diffrec(rec->ptr, rec->size, pre, strlen(pre), ecb) < 0) {
>  		return -1;
>  	}

But by directly peeking into the xdf->recs[] array, we do not have
to.  Each element of the array is the <ptr, len> pair we want.

The updated code is certainly easier to read.  That applies to all
the other callers touched by this patch.

Thanks.

