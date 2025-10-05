Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061DB2A1CF
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 21:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759701225; cv=none; b=mPzlsfj7bUZo+7nQDN/hia3mjg2P4Y1d9AKDC9FQm9UBvAZcaTm+bfzmx3FYIdujLpYAKxlSOXTN0J3qHnVZML26KriWzP/QgWo4H/5/01AdLYrBPA3M7bN0+N69dzAvOUij+POBhftAsXKFUtDLmeL5Z8bVIyko2urkSW1EzvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759701225; c=relaxed/simple;
	bh=szOdR+io34JkSdxXC0WE7yZAyTIrWfMMHxHcp0/ULBY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WuQCvSnW1wCeSlqvJsR/783wWJmvKVwaf6hT9QFZkVK8U5huuXRl4Dxpvr7RJiqHQTWn5Z1U19AuTGkgI5YWy5E93pzHTtV+6OuPxxraGhgvtv27V3QNVidyA7XVVC8mvdj9LYUJh2yXdkbjNp+r+m9ZfTvyDbEhKr4mO98Ec60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Gj148zX+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=trfwDvzt; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Gj148zX+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="trfwDvzt"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 016981D00038;
	Sun,  5 Oct 2025 17:53:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 05 Oct 2025 17:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759701221; x=1759787621; bh=FnJEC7YXe3
	2/AnKhhp6vlFXYaqkk3lE5wVJS/eZNNG4=; b=Gj148zX+SC6RYVR7w+tQGvimTz
	eDTTE7G5ax1DPNq38Yyw4cT9wQNCRfW8qHnJs961WgOqVUFIj5cDwn/2IetmO3kw
	zA7BMuVYjgYqcKEL4UGzVwW9tSSYovsAnB0xjS95BpEuRju8fO0cCFNcooJpwABl
	rB0ZM5QIfX7I+L0PGeT+tObi0bZno9S8tjXTt6lqOcOC5GtJwYNbFWDandfTR0QO
	BS1uDbWxdwLOoco0MrI/e5vekEocfh3NGp/+8ZgWQVPo7zmW95DG7IivvJ1kcw8z
	Ln5AIxoRjx6r4Bh0lxwKvL+AI156y1LFkD5ld+E/oloajoNuBcMppXO/37zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759701221; x=1759787621; bh=FnJEC7YXe32/AnKhhp6vlFXYaqkk3lE5wVJ
	S/eZNNG4=; b=trfwDvztmfPOuBZk6jwQIpYZ3xDDDAfY7sX/WI1OOkk3QW06AeX
	VUWpzRhUqDK4iaowd2j3SBtXwEHzMo8SLh4Wp4m2daQDX77/fQpX84ID8zlJnaKu
	SW/JJi4Yvf6tmS0VWIvmUTiAQi4q+ThnTppMPBlaHb2h3o+30A/lNU7So8dfFzv6
	QNCkAx7+cGope8LNMgBQAL/CMSLgvbsG2Bk++J6ev4EXmsAD/wNZNvJVdLzW5vSo
	Uy8lbL2brNTo1Wm9q2PyjBlmzr3aNxjaGsoMW62KeQOvDnWRy40oD1Q+K/2vzMdi
	CIFwhgx+CBBoo/K6lAiTXGA7XHP1Jiwx3wA==
X-ME-Sender: <xms:5OjiaCTwB5GM16hQ9uc73aOH3qplK6kmmEvXTIshc4ZUqN9WqBN4xQ>
    <xme:5OjiaKCbH3oGddyExsoAkq83j4jN865GPsLivpgSPCM68x98MNx1g_lG16hi5iAHo
    Bq-v_bw4F7P5xj3LIXsow4f0rS9x7inQy68MCB0EgtoxzhhGqB_>
X-ME-Received: <xmr:5OjiaCHfCojBPAeZ73xPrCZzrQSX2njmJDqp6f8OLt2EiCqXE1TbdA0UK4rTXmuM8DWEz2fyBDliWIR8fLFzDH6Tr0TK3_PgaqA3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelheejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehhrghnhigrnhhgrdhtohhnhiessgihthgvuggrnhgtvg
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohephhgrnhihohhunhhgsehprhhothhonhhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehsihhgmhgrqdhsthgrrhdrihhopdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:5ejiaEAVNJCdlJxHBI-SDNsQ6VLYyAzRMnC58abohmG49UmTTw2_9A>
    <xmx:5ejiaKVg-Y_UpGwszJ5L_nAlYKxGObquYOizB5ltgIt_b3WRoUHLbg>
    <xmx:5ejiaArEa9pCNIF_Dk7oEgXcKkjcfpp20-jSyijPA6De8tWPfV2ckg>
    <xmx:5ejiaOTPFasADjcMv-zLIM7Htp8q6v088sRKQTEuzGLkpLudxwb1CA>
    <xmx:5ejiaPBGYmO11pOersvnB8Y2Vw-V_t5OkSqZkl3SJxNpzDmy7crzMPMt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Oct 2025 17:53:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Han Young <hanyang.tony@bytedance.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com,  ps@pks.im,  Han Young
 <hanyoung@protonmail.com>,  Sigma <git@sigma-star.io>
Subject: Re: [PATCH v=2 1/1] files-backend: check symref name before update
In-Reply-To: <20251004144223.23436-2-hanyang.tony@bytedance.com> (Han Young's
	message of "Sat, 4 Oct 2025 22:42:23 +0800")
References: <20251004144223.23436-1-hanyang.tony@bytedance.com>
	<20251004144223.23436-2-hanyang.tony@bytedance.com>
Date: Sun, 05 Oct 2025 14:53:39 -0700
Message-ID: <xmqq347xrp5o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Han Young <hanyang.tony@bytedance.com> writes:

> From: Han Young <hanyoung@protonmail.com>
>
> In the ref files backend, the symbolic reference name is not checked
> before an update. This could cause reference and lock files to be created
> outside the refs/ directory. Validate the reference before adding it to
> the ref update transaction.

This leaves the readers wondering why refname_is_safe(), which has
no direct callers other than "git show-ref verify", is sufficient
for the purpose of this particular validation.  All other callers of
refname_is_safe() seem to use it only as a sanity check combined
with other criteria.

For example, refs.c::transaction_refname_valid() calls
refname_is_safe() as a small part of its validation, together with
check_refname_format().  It also refuses to touch anything that
satisfies is_pseudo_ref().



> Reported-by: Sigma <git@sigma-star.io>
> Signed-off-by: Han Young <hanyoung@protonmail.com>
> ---
>  refs/files-backend.c | 10 ++++++++++
>  t/t7102-reset.sh     |  8 ++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index bc3347d18..d47a8c392 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2516,6 +2516,16 @@ static enum ref_transaction_error split_symref_update(struct ref_update *update,
>  	struct ref_update *new_update;
>  	unsigned int new_flags;
>  
> +	/*
> +	 * Check the referent is valid before adding it to the transaction.
> +	 */
> +	if (!refname_is_safe(referent)) {
> +		strbuf_addf(err,
> +			    "reference '%s' appears to be broken",
> +			    update->refname);
> +		return -1;
> +	}
> +
>  	/*
>  	 * First make sure that referent is not already in the
>  	 * transaction. This check is O(lg N) in the transaction
> diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
> index 0503a64d3..1dc314474 100755
> --- a/t/t7102-reset.sh
> +++ b/t/t7102-reset.sh
> @@ -634,4 +634,12 @@ test_expect_success 'reset handles --end-of-options' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'reset should fail when HEAD is corrupt' '
> +	head=$(cat .git/HEAD) &&
> +	hex=$(git log -1 --format="%h") &&
> +	echo "ref: refs/../foo" > .git/HEAD &&
> +	test_must_fail git reset $hex &&
> +	echo $head > .git/HEAD
> +'
> +
>  test_done
