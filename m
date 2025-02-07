Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4BA1F76B4
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 15:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738941823; cv=none; b=NqbyXU6mha89uL4kK/wjUNEDKP8COkmUHRQNCHTtx/MXGov8vRSQ0XuuMFPe+x8GtjeIJY09yuNngP0B60lU8YvUJ0hAdrkD32rKr8HgWlp2IKTbo7iWNcKzPveWNImie96GY+T1J5tQqIzL62ll9bIAn+7razfMmSdS/y7s2ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738941823; c=relaxed/simple;
	bh=umEucqNwcYk84uT6i4bnTkTsamOn/nrKindL8tkQG8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbqBN6dY+t9r/CnNlcUgx119CF5FoL+dLZ65PJaDQkhAohVnaKYOLXoZtDY9LNTojdXoluPxECDBce30ZqGHldnNDDqAbnPPNHJ44sS53Vz3/PA4xJhVNMz+rGfER5hbpthIrA4eY/Hrds8biUZ6/TdxGmLMkpn29DhlVQP0ZlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YmK4aDnb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hWDt6zdJ; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YmK4aDnb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hWDt6zdJ"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3026625401BF;
	Fri,  7 Feb 2025 10:23:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 07 Feb 2025 10:23:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738941820; x=1739028220; bh=e2idxGmsW4
	CLeTJmF6Gi3dl1cb7QMsjj8G+C6/PvxJE=; b=YmK4aDnb4NP+vd8ZaRdUnxzmNl
	Rac+65ex17ctcnJPEmCshKubmhAWFrMx7XTzWPeZllqGEAaXO55P4xHKwYRCKI/f
	5EFuMVucogOPRLQ6r5/zmFWH/dW0PYdhVThsibZyx0AzClRS9YJ0Vzj+S+E7lIe9
	8kSpt2OTkDApTqMRIACAmO8cjKQCHA4JPQ3ZuWaE3y4YqoBobOwfh8uqUtCiaF0R
	28gOSy7fM1lplVMCj7GHvAdmeRWNwZu+xZYEqo0TuMHllOu8myK4pCk3H0EXqShi
	qMNN7Heo9SRzLEYTJj8ZlqtyjIoA7QPZs3OpdkU5XeBHvcZvYA3qZQ1MUz6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738941820; x=1739028220; bh=e2idxGmsW4CLeTJmF6Gi3dl1cb7QMsjj8G+
	C6/PvxJE=; b=hWDt6zdJgEpetf9iHbRyrrYttFGNpqd98RqAPpoZhms0fH30cCH
	fvaB0N/s7Qbxww1SJo0tCiM/sft0n4UwpOuWRD8oaSUpHLt4vT0EeYTp/lekhTVC
	LVVfX3l2/E2wuRmY+Zh8KKPfZvHvay63SK2dRB46qj3tUgxYl8X0hcecsBa61CD0
	n0Vo+E5lnACuqjpbNCFkSnEZiihFSO8Ou49zzguGIF5undp9Av8iKvPZwnxb8T7/
	wy9X04haLjxnYKZu8BIROFdpcadLjsJmIm+XMZiv1S1b347BDSNFBQZ32NXFckPC
	4WL43IgTGmQhVIWcEZnGTBr4Bpl+77ZAyUQ==
X-ME-Sender: <xms:eyWmZxb03cOOscSLysgeksVcrcCzZ8O-iTTxvizL_7-NKwkx5Mz-Dg>
    <xme:eyWmZ4bNCi_sOI8EwQ3UgZhlYnQ2N2VPYzhofXI79LuLzCpfQAWoFbtXRVa1Nz3Cl
    TwbFNOkBHtDxuTwHw>
X-ME-Received: <xmr:eyWmZz8-KF_6URhIY22Uwnq4EqByeVxIshnBA3YIHx2xW-r2yLMk2aXpWLv-SZ1GAxbyz6B_4LoHVH9ZcDmcRHL7d5JsRQ-M8eSjAoXXqcYnFTIE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:eyWmZ_qGBvVmdr7t75kdMDnEh5x5pfwgyXT-I8LeuWJK1oDdSGJ4fQ>
    <xmx:eyWmZ8rYx6f6f_5M_bzEqEaBTksLkWO9PINGrtvAkI3Xb5LjP8Uk4g>
    <xmx:eyWmZ1Rm-4MzT-SYbUrNP-8G4J0vLsPzD9s_ZetMReR5AVQgQ6h17A>
    <xmx:eyWmZ0qbB7CDeoMGTNrVv7l-9JvS2IzkPj7mx80Z03-Ztgi-y-T5TQ>
    <xmx:fCWmZz11ZUgvAXkxmebFsuOsRCGlacVHXNdhy66r3sboHJK_zVTcOjgg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 10:23:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 29525e79 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 15:23:36 +0000 (UTC)
Date: Fri, 7 Feb 2025 16:23:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] builtin/refs: add '--skip-reflog' flag to bypass reflog
 migration
Message-ID: <Z6YlcpKp2U2V8Yd3@pks.im>
References: <20250207-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v1-1-7d40f3b4e30b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v1-1-7d40f3b4e30b@gmail.com>

On Fri, Feb 07, 2025 at 12:57:31PM +0100, Karthik Nayak wrote:
> The 'git-refs(1)' migrate subcommand, which transfers repositories
> between reference backends, currently migrates reflogs by default as of
> In 246cebe320 (refs: add support for migrating reflogs, 2024-12-16).

s/In//

> While this behavior is desirable for most client-side repositories,
> server-side repositories typically don't use reflogs and the migration
> of these entries is unnecessary overhead.

Nit: if the server-side repository doesn't _have_ reflogs, then there
cannot be any overhead caused by their migration either, right? I still
think that the flag makes sense (well, I proposed it). But to me the
argument is rather that we don't _expect_ there to be any reflogs, but
due to historic reasons there actually _might_ be some. This could for
example be caused by a bugs, misconfiguration, or an admin who has
enabled reflogs on the server-side to debug something.

So even if there are some reflogs, we don't want to migrate them. Which
coincidentally helps us to improve performance, but the real value-add
here is that it makes the result match our expectations.

> Add a '--skip-reflog' flag to the migrate subcommand to make reflog
> migration optional. This is particularly useful for server-side
> migrations where reflogs are not needed, improving migration performance
> in these scenarios.

The second sentence of this paragraph feels duplicated with what you
have already been saying in the preceding paragraph.

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> ---

Another thing to teach b4: skip the comment in a single-patch patch
series in case you don't supply a cover letter :)

> diff --git a/refs.c b/refs.c
> index f4094a326a9f88f979654b668cc9c3d27d83cb5d..5e8f5c06fa68d16c93ee11edd9742995eea994b6 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3035,9 +3035,11 @@ int repo_migrate_ref_storage_format(struct repository *repo,
>  	if (ret < 0)
>  		goto done;
>  
> -	ret = refs_for_each_reflog(old_refs, migrate_one_reflog, &data);
> -	if (ret < 0)
> -		goto done;
> +	if (!(flags & REPO_MIGRATE_REF_STORAGE_FORMAT_SKIP_REFLOG)) {
> +		ret = refs_for_each_reflog(old_refs, migrate_one_reflog, &data);
> +		if (ret < 0)
> +			goto done;
> +	}
>  
>  	ret = ref_transaction_commit(transaction, errbuf);
>  	if (ret < 0)

Nice and simple, as expected.

> diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
> index a6d9b35a46eb59350aa0d59d982a2fbfaecf1448..9059d4c4121842a9d2e77dc4e54c537eeff8afab 100755
> --- a/t/t1460-refs-migrate.sh
> +++ b/t/t1460-refs-migrate.sh
> @@ -9,14 +9,16 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  
>  # Migrate the provided repository from one format to the other and
>  # verify that the references and logs are migrated over correctly.
> -# Usage: test_migration <repo> <format> <skip_reflog_verify>
> +# Usage: test_migration <repo> <format> <skip_reflog_verify> <...options>
>  #   <repo> is the relative path to the repo to be migrated.
>  #   <format> is the ref format to be migrated to.
>  #   <skip_reflog_verify> (true or false) whether to skip reflog verification.
> +#   <...options> are other options be passed directly to 'git refs migrate'.
>  test_migration () {
>  	repo=$1 &&
>  	format=$2 &&
>  	skip_reflog_verify=${3:-false} &&
> +	shift $(( $# >= 3 ? 3 : 2 )) &&

I honestly have no idea whether this works with all supported shells. If
it does it's a bit funky, but should work alright for our purpose. I was
thinking a bit about how to improve this, but ultimately came to the
conclusion that there isn't really a need to overengineer this simple
test function.

> @@ -241,6 +243,17 @@ do
>  				test_cmp expect.reflog actual.reflog
>  			)
>  		'
> +
> +		test_expect_success "$from_format -> $to_format: skip reflog with --skip-reflog" '
> +			test_when_finished "rm -rf repo" &&
> +			git init --ref-format=$from_format repo &&
> +			test_commit -C repo initial &&
> +			# we see that the repository contains reflogs.
> +			test 2 = $(git -C repo reflog --all | wc -l) &&

Nit: we don't want to have Git on the left-hand side of a pipe, as it
might make use lose its exit code. This could instead be:

    git -C repo reflog --all >reflogs &&
    test_line_count = 2 reflogs

> +			test_migration repo "$to_format" true --skip-reflog &&
> +			# there should be no reflogs post migration.
> +			test 0 = $(git -C repo reflog --all | wc -l)

And here we could use `test_must_be_empty`.

Thanks!

Patrick
