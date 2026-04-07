Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB54E3431E6
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775583409; cv=none; b=Rsd/AQ5vHQT39hqDT548wloEl67dT3NhQ2QwFS0g/502ZNv6y6ihPBfE2RIC0VGdQXuNBrFlJ5NBqy2FfJzkjrJ+qqX0Yl3OcGNmEdBNd940wrI1pAYoG7/XiEQiHom643UhYYR5We7QSaTIbT9tzXTFMxd61t8jRUg+m8K2M/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775583409; c=relaxed/simple;
	bh=6Jb+NyZK1p4MnatLfkIDmpaG5Nni61ZJFwbvH0AfHvg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b+4KvK0dBcQ4+2BDAHgWBlUodYLrjUW5dd9SObn62VNfZONBYpZe0LAX5LMCWyvIRMdWnYOX4NnnnOQ+3GYdesJ/eNmZZ8eEcj+nlBMqnJTLSIrgkoNuRPjWT/9UMjzdFHdnZaKEkEq7i/UCPU2J3A2MreyHTzGLhjGmHDm+ze8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZPQXhvqY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ryY45eQE; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZPQXhvqY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ryY45eQE"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 07A93EC00F2;
	Tue,  7 Apr 2026 13:36:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 07 Apr 2026 13:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775583407; x=1775669807; bh=+GDz72/2g0
	G3/iJHXDJ3lxnJD0rBEA2+3KvOniQlehY=; b=ZPQXhvqYdQqtsnD8TP9KzDDL2y
	UDipXPUsOT/65tz71GP/aRh3QrQgSH7Ea4ipmxBCB8f5IK1clKdzC5sRzlSNSe9A
	mAB8SS0+POp3DhSery/qCfQbp2pEYbLzuoV6Kug4E784If+iFZNDWFotby1hISy0
	A5Pk2JiIxF7M2+MZ3Q8XJ3SuSY0wAerxnAjOAjJg6dJRtRcMHVsuanS6u8yPrwGy
	VEZ3Uz2Jz4pFmQQC+3zlMmE2qeY+ON0HRW53sObGi3LkzCH7PNMe8eTIQ4YHENeB
	gF6NThZ306bZk+FZHQEfeWYrDLDlcTeQWiLkRFcgPv5u/LmYxGThTfVw5S4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775583407; x=1775669807; bh=+GDz72/2g0G3/iJHXDJ3lxnJD0rBEA2+3Kv
	OniQlehY=; b=ryY45eQEgyQxCdD3IKCrRAmeOFG5WVwlL08JhTM9l421a7U+FTe
	Uyzbn2HgXuEgrKpKon3LrXyd2PYlgyfrZsy4ifoXKoeeGlP7wuY+qWC4Gwwa26Nz
	srIZJumhPopVBeJrf59Uqu/J5vZcmsBGUY7XKI8eBdi4HGEWN8qOxuhEmLuW5LIb
	ULLv5C8j2OJ/e2GqllSQBavL9Z25szKHUhCr4Qkuu1ooJ7Cp9+N6nYDKck2b/DYZ
	G9uT9ktriD1EbuyHkR5krFWWZsGzpVFDlwBUzBfbi0QIfLzIjDA0ntkIzyujqBcb
	qFM6Q5KBDdKxpP2jLbtAn2qbHTteI5vXCZQ==
X-ME-Sender: <xms:rkDVaUjgB-nQuavJjQuURBQAjzi7SiG4ww-pVrMLYtBwqBMRh0ONkQ>
    <xme:rkDVacEppAwmvdi8-c8oe2NZag8KuuysHIBcNXAW7DUKWefmMvW5U8usuoZE8Quey
    LI86nGMaK6VWhAh7CGC_Mkqs2JSV6Qq1Gm-GlyEwZ8PobXyt-YZXQ>
X-ME-Received: <xmr:rkDVaSTr4U6IALcMvDdvCFDBQj1SG-mWHUtrMlJM_gmYI_4RdEgS-kmm5PAHd--qL-0oC_iyKyZuvmOIEwc6dfXYtqOaHdiG1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvuddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhstghooh
    hlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:rkDVaRyUjAHWg9yHwFTXToCUqZJPh9hEVzdkU2-COP2gC-AwWaiXhQ>
    <xmx:rkDVaWfG-u-wGfc_CoLcc3Wiknqj0SiCMRMO_tcL8jRZGSUBKWYULQ>
    <xmx:rkDVacMBs5U3sRxrCtFb-1zEbTiGtp-cc3J_PgzpwIWNGvZ2lBikiA>
    <xmx:rkDVaZtCVM0oA2_2Ngvbqv9wSlJzLPc4I0MU_6N_YkR-x1Zibt-DKw>
    <xmx:r0DVaaC--qHIdXPUvFeTEypA1_6C0ywrExAMIXJot9-vn8AVQWJbN1VX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 13:36:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <me@ttaylorr.com>,  Karthik Nayak <karthik.188@gmail.com>,  Elijah Newren
 <newren@gmail.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 04/10] promisor-remote: reject empty name or URL in
 advertised remote
In-Reply-To: <20260407115243.358642-5-christian.couder@gmail.com> (Christian
	Couder's message of "Tue, 7 Apr 2026 13:52:37 +0200")
References: <20260402070613.85934-1-christian.couder@gmail.com>
	<20260407115243.358642-1-christian.couder@gmail.com>
	<20260407115243.358642-5-christian.couder@gmail.com>
Date: Tue, 07 Apr 2026 10:36:45 -0700
Message-ID: <xmqq7bqi65aq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> In parse_one_advertised_remote(), we check for a NULL remote name and
> remote URL, but not for empty ones. An empty URL seems possible as
> url_percent_decode("") doesn't return NULL.
>
> In promisor_config_info_list(), we ignore remotes with empty URLs, so a
> Git server should not advertise remotes with empty URLs. It's possible
> that a buggy or malicious server would do it though.
>
> So let's tighten the check in parse_one_advertised_remote() to also
> reject empty strings at parse time.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  promisor-remote.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Personally, I am not enthused to see "NULL or empty", primarily
because it is an entry into a slippery slope.

Sure, an empty string is implausible, but would a single letter URL
a lot more plausible?  Not at all.  How about three letters?  Would
it be now a bit more plausible than an empty string?  Drawing the
line there between "" and "x" does not sound sensible.

Don't we have a code that _uses_ these URL strings to protect it
against a malformed or otherwise unusable URL already?  Can't we
rely on that working correctly to omit this check?

> diff --git a/promisor-remote.c b/promisor-remote.c
> index 8e062ec160..8322349ae8 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -722,7 +722,7 @@ static struct promisor_info *parse_one_advertised_remote(const char *remote_info
>  
>  	string_list_clear(&elem_list, 0);
>  
> -	if (!info->name || !info->url) {
> +	if (!info->name || !*info->name || !info->url || !*info->url) {
>  		warning(_("server advertised a promisor remote without a name or URL: '%s', "
>  			  "ignoring this remote"), remote_info);
>  		promisor_info_free(info);
