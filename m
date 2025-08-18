Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC6A146585
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 21:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755551542; cv=none; b=CenOGvTELW8cGX9nj68Yjf9Rl6hcA9JTBNqgbnjJIxhyFG7Gh27cvVn8ZsCbxqrTEplt+y1BVpvRh3GPj2C2798L3bwklVfCV/XN6ZH3jD4d2GPbfANe0OJSBQnz2SmL7uFmF6brK804svJUcmxtP3VV5tYAJ+NLaGwWxe68Wjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755551542; c=relaxed/simple;
	bh=JFR7eTR+RVzQSFj+3o+WWa4ndpYWLX+Kvc2lRB5imKo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pjbo5PJhV3nRnlC/LY5fq3seAUOcw+KYEiPCK96xzxnLSW/MZqMiPOf702W0/hP99r+csrTcAbozlwug1l8UlVfvNqlxsHY81cr/cssrubpnBOJ+jEAHQHl8Ml7iZKxv8+SgeP6shfUKgg1yI2ruWHhWkznkds+9m4WwKiDS+iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V2Iu8opP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QZBH1ggu; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V2Iu8opP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QZBH1ggu"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 665F07A01A1;
	Mon, 18 Aug 2025 17:12:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 18 Aug 2025 17:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755551538;
	 x=1755637938; bh=oRQbqAwPpe5nXpSDvlICamVivNDu8AuRuDSQs4sPY14=; b=
	V2Iu8opPVCNol5jlPAtghxEt3G0EZSYu+qxZh9BEQjB1aytESTqnPoEOA223Es6J
	jjCD7xeEHILojN1irpo3fvlB+ZRnuAEtpaw17I6irSgh7d3+aq0DzzK8GS6P1IpC
	ZDawQwcpzN3nFomD68iiqOEVhsMEnJ1TJ+ksssC7Nv1aejS35BYUH7c3qa8iuwdo
	oqxEkNvncXWJc6LIkxfxmKhSJjVde301lSLvJVe+eSWKBKPUI9vNH8dJah7bgL3M
	lI6W2YCrHPAgl0Mk81EGRBqehKAduqqZ8yyNLNUfGId8GXnoU9PrHGfPsCkgOEDr
	N9WQ154X99fy63nMRJWJEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755551538; x=
	1755637938; bh=oRQbqAwPpe5nXpSDvlICamVivNDu8AuRuDSQs4sPY14=; b=Q
	ZBH1gguJmooVI928cRLQTEXBLytEKbreV9ujF0FjX/qrWDYQvbLOa29vqcFoYG5J
	WW2E1mZQqdsci5ooybkpq+P9TuQbhUZkqoYWU5U6hue5vQsuJO/SODcxVd1z6dd8
	Z1NbWe5FWPVRkO7PtOH2yZNiKpMyo3bV0oL9CNO06uGh68BWsIkJvj7+XzXOGVAr
	Sffe79/j1zGwOT2l24MAXVT8hND9+1OK7iMlhIuIc2vwBsSk33gQ0Y3niQHzeJHA
	TRRce16McNp/dQNkWWgxpCMrOna4w1DLOJ6KWPH0JlI24t4KQTVwxoeF8eHhW4px
	39kIh+ylAlebaTLRjDQbA==
X-ME-Sender: <xms:MZejaKeXOGTC5IoO_AQqeHApnQNdk88lXyKPODmzr2kK1v4dz-_asQ>
    <xme:MZejaBx4kA_2sZ92wV4C5NyK0_0K_K-WEgD-PiO4o-fWuqCZJlODb7RGoubjDsqqb
    48FPIv7vvXaCrsxVg>
X-ME-Received: <xmr:MZejaB-66_yBska2_mTxzX9HQMel1YSS-tEA_9qDwJV3GF2d4bYhngxGjvnx99kQTH45ubaNFyzTUpagXtm22ZVvLWwhp5-P8eFma8E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheefieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekof
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnhepkefgtdeuvdejfffgheeufeeuge
    fhtdejhffgkefhhfetieffteehleehtdfghedtnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtth
    hopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthho
    pehprhhophhhvggthhgvnhhgsehsthhurdhpkhhurdgvughurdgtnhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:MZejaJjt3jc8j086LRdwIeufYZkGxPIXcE9VcLSdYBvZ1Uv_fLmQOQ>
    <xmx:MZejaIEZzz1ETMXUXVfyoTSpuEBy8YGTh7iS0n0TjjDd8EsgcGkUmw>
    <xmx:MZejaI8d3jaq6rLc38CyTWNM9MWFie1Iy-iZ9s8-UJwQVlcaOFZC1Q>
    <xmx:MZejaPwKXrtA6_TLC7SAbqXl16RQeitd57GSwp_B69SyEHOP0Id_-g>
    <xmx:MpejaFge79AumetlQCsse2rY0UwJj2CMvfU4xw4Vly0Y92bTtQ3Bw5zK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Aug 2025 17:12:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  phillip.wood@dunelm.org.uk,  Cheng
 <prophecheng@stu.pku.edu.cn>,  git@vger.kernel.org
Subject: Re: [PATCH 2/5] describe: error if blob not found
In-Reply-To: <20250818210125.GB1024556@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 18 Aug 2025 17:01:25 -0400")
References: <20250818205812.GA1018043@coredump.intra.peff.net>
	<20250818210125.GB1024556@coredump.intra.peff.net>
Date: Mon, 18 Aug 2025 14:12:15 -0700
Message-ID: <xmqqbjocibbk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jeff King <peff@peff.net> writes:

> If describe_blob() does not find the blob in question, it returns an
> empty strbuf, and we print an empty line. This differs from
> describe_commit(), which always either returns an answer or calls die()
> itself. As the blob function was bolted onto the command afterwards, I
> think its behavior is not intentional, and it is just a bug that it does
> not report an error.

Yes, let's do so.  Silently succeeding without returning anything
useful is not what we usually do in this system.

> This one is perhaps the most controversial, as it is a change in
> behavior. But the current behavior just really seems like a bug to me.
>
> Unlike what René posted earlier, I didn't record the dst strbuf's
> original size and compare against that. This is a static function with
> only one caller that passes in an empty strbuf, so being overly
> defensive didn't seem worth it (arguably these functions should just
> return an allocated buffer anyway).

Sounds sensible.

Thanks.

> diff --git a/builtin/describe.c b/builtin/describe.c
> index 383d3e6b9a..06e413d937 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -535,6 +535,9 @@ static void describe_blob(const struct object_id *oid, struct strbuf *dst)
>  	reset_revision_walk();
>  	release_revisions(&revs);
>  	strvec_clear(&args);
> +
> +	if (!dst->len)
> +		die(_("blob '%s' not reachable from HEAD"), oid_to_hex(oid));
>  }
>  
>  static void describe(const char *arg, int last_one)
> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> index 256ccaefb7..470631d17d 100755
> --- a/t/t6120-describe.sh
> +++ b/t/t6120-describe.sh
> @@ -409,6 +409,12 @@ test_expect_success 'describe tag object' '
>  	test_grep "fatal: test-blob-1 is neither a commit nor blob" actual
>  '
>  
> +test_expect_success 'describe an unreachable blob' '
> +	blob=$(echo not-found-anywhere | git hash-object -w --stdin) &&
> +	test_must_fail git describe $blob 2>actual &&
> +	test_grep "blob .$blob. not reachable from HEAD" actual
> +'
> +
>  test_expect_success ULIMIT_STACK_SIZE 'name-rev works in a deep repo' '
>  	i=1 &&
>  	while test $i -lt 8000
