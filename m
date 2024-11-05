Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761271714A0
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 07:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730790715; cv=none; b=L3xkbzS6bwwB0zHmYBaYWXBfuMe7WqntAGNUr7EjTchCU566AF40DksXDyA7s5+PC78qwoNLJ/N6FCaqpxoNaFyJmifc0R04fALBLWOgsQuKuL7VuqWKed05Jl1mswGdbQLHHPZ0gFJptzkDTADUMZg+ohIufmuMMpoftC/hoxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730790715; c=relaxed/simple;
	bh=xmcamdwJXlq4WNuXIuK9OrTlLLFj6kbB0tpx0RKeUgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdY4VkDIc/pgvRPaZ6n3PlntJAo1QnDHuFVXRRFaejTgLethFhafcwcitqi9SD/DXEs8u/NgTS4Uk+ojdJp/W39Y78cfSBgHqpVRGgjAtkD7JvSCEKIdpUEq56w3607fxiguMlAkTBxSOKixUZrzUbEJ2CL/zZOJ5WINmeVoWEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O+ZI1N4/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=frRTjlpp; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O+ZI1N4/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="frRTjlpp"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8090E254014E;
	Tue,  5 Nov 2024 02:11:52 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 05 Nov 2024 02:11:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730790712; x=1730877112; bh=/6G0KZcKp8
	DClKId5rUoJUknoC+1Wzqyle9INnbBudg=; b=O+ZI1N4/ZTrzURn3tNsIH3Unaw
	FMJPQM5skjVsZk90BTMhbEolU2JazIDeUR7ENM7s2NYypLAdOiZdL7oDw49sniAc
	VCoigO5V8wUxZMXcDMZ0CaAsSpPconIgMLq6rQmqhrpTftEskMO7Z/zD0XneORQO
	KOgVT6JP8VnLRweOVVXlaPITXRta/RMR+cOdhNWyi5/g336IxAt6RXxupBDMNlqf
	mqbp7q0lBHbSK75j5/Fk3heQ1E9xOX/8xj6NF4rQxR0zosWgsUfTac4f3IjyabS/
	8KGjq1luFrgDdR+PlOhoWk6XjUXQ6fGTIAPqvQ9AiYBatPLZjEMC8EhCLHrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730790712; x=1730877112; bh=/6G0KZcKp8DClKId5rUoJUknoC+1Wzqyle9
	INnbBudg=; b=frRTjlpp5S8Gmd45MsPcbqhOoE8rfAm32km+7pPiCvgYcjWSrdn
	2IT6LfoVkh9m11btDaTvAYklaQAZzghkW3m6OB2JW/wnyQ7rEfXKM7EEgSENwSbJ
	zZB04FrhVRjBuiDO8unyCGGKhvCMqFCj/1fUvYj/KtOUT847MJM8rMvucbCbrYXh
	zGhCgU6VGuzX0UIvckX65OMHn0Gy8Fn1OnvPgBQohjFxqqsAn+GzdynKnR6xJPQD
	955dgzGEPUryobIG+KBWCp2CGCdP/oesIB4KoCUgKT8CC8Web1JDmnindzrwPvwO
	aGKHs+7PdOghYX1ZI4D/I2EsQ7V1QbloNXg==
X-ME-Sender: <xms:OMUpZ5GXilb3cKm9D2Ky73NLRhcbvz0YoLTpzWcS_I2sU42Bt6WvRQ>
    <xme:OMUpZ-Xq0BzP2WWUtltTOONTkMyQcIDgj22vKvl5x22lcIHpindlauob1Nr3Ww10k
    Vq-OWAOLeQhB5UnAg>
X-ME-Received: <xmr:OMUpZ7IZehBIPh0aHKPSSe2JzfrERj3mjZL0ztMoxClZxmjWNuh6qyEeu0xSKoVSgsrv_40WpZhMFz6-1XGw-PYL7_BubLqz6gZ34z4QAK5yCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgv
    jhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:OMUpZ_FIDgg5Ex0tBUTPAETFGoBlASoZIXmfhwbfRNKeWknslfNaNQ>
    <xmx:OMUpZ_VYDbyGf2FQJZzrwkIEIDifCYvVX4jOmtmBYF3LJaF8KVKnfA>
    <xmx:OMUpZ6OaXQgCVDAw0bXPMk2ZYC75QvG8ioByVNgNiDJnkxGOkoz1Sw>
    <xmx:OMUpZ-3aqgP0Vx2mdTQLoVUJaJpH6xXaxwZvw1oS4M_eZYwvrZqalQ>
    <xmx:OMUpZ1z6McPKTvzAUMT1LrhZVzb9jIJO0wyn4Stk3VYW63yyncXXOQpc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 02:11:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2a81b091 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 07:11:27 +0000 (UTC)
Date: Tue, 5 Nov 2024 08:11:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/9] ref: check the full refname instead of basename
Message-ID: <ZynFKPFcNQILce3E@pks.im>
References: <ZxZX5HDdq_R0C77b@ArchLinux>
 <ZxZYXpuCD2I_3bNh@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxZYXpuCD2I_3bNh@ArchLinux>

On Mon, Oct 21, 2024 at 09:34:22PM +0800, shejialuo wrote:
> In "files-backend.c::files_fsck_refs_name", we validate the refname
> format by using "check_refname_format" to check the basename of the
> iterator with "REFNAME_ALLOW_ONELEVEL" flag.
> 
> However, this is a bad implementation. Although we doesn't allow a
> single "@" in ".git" directory, we do allow "refs/heads/@". So, we will
> report an error wrongly when there is a "refs/heads/@" ref by using one
> level refname "@".
> 
> Because we just check one level refname, we either cannot check the
> other parts of the full refname. And we will ignore the following
> errors:
> 
>   "refs/heads/ new-feature/test"
>   "refs/heads/~new-feature/test"
> 
> In order to fix the above problem, enhance "files_fsck_refs_name" to use
> the full name for "check_refname_format". Then, replace the tests which
> are related to "@" and add tests to exercise the above situations.

Okay, makes sense.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 03d2503276..f246c92684 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3519,10 +3519,10 @@ static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
>  	if (iter->basename[0] != '.' && ends_with(iter->basename, ".lock"))
>  		goto cleanup;
>  
> -	if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
> +	strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
> +	if (check_refname_format(sb.buf, 0)) {
>  		struct fsck_ref_report report = { 0 };
>  
> -		strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
>  		report.path = sb.buf;
>  		ret = fsck_report_ref(o, &report,
>  				      FSCK_MSG_BAD_REF_NAME,

So this only works right now because we never check root refs in the
first place? Maybe that is worth a comment.

> diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
> index 71a4d1a5ae..0aee377439 100755
> --- a/t/t0602-reffiles-fsck.sh
> +++ b/t/t0602-reffiles-fsck.sh
> @@ -25,6 +25,13 @@ test_expect_success 'ref name should be checked' '
>  	git tag tag-2 &&
>  	git tag multi_hierarchy/tag-2 &&
>  
> +	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
> +	git refs verify 2>err &&
> +	cat >expect <<-EOF &&
> +	EOF
> +	test_must_be_empty err &&
> +	rm $branch_dir_prefix/@ &&

`expect` isn't used here as you use `test_must_be_empty`.

>  	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
>  	test_must_fail git refs verify 2>err &&
>  	cat >expect <<-EOF &&
> @@ -33,20 +40,20 @@ test_expect_success 'ref name should be checked' '
>  	rm $branch_dir_prefix/.branch-1 &&
>  	test_cmp expect err &&
>  
> -	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
> +	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/'\'' branch-1'\'' &&
>  	test_must_fail git refs verify 2>err &&
>  	cat >expect <<-EOF &&
> -	error: refs/heads/@: badRefName: invalid refname format
> +	error: refs/heads/ branch-1: badRefName: invalid refname format
>  	EOF
> -	rm $branch_dir_prefix/@ &&
> +	rm $branch_dir_prefix/'\'' branch-1'\'' &&
>  	test_cmp expect err &&

Okay, we now allow `refs/heads/@`, but still don't allow other bad
formatting like spaces in the refname.

Patrick
