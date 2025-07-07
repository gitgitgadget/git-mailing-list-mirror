Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6921533993
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 06:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751868527; cv=none; b=WSzNLBopft9mP4zk+6Z4fKSSXlAfEQCw1BJbZvOsCpdmM1fe7JFmj8yziw6jw8QH7tLDP07AFR/Ens0zufDTHTF9rQEPJDPa39DmjPauEHSSnQtRDksYPIep8nO4EXVoSY5svPSQQ+AbUk6Nij62dpUz8atYRWh3NLTQOerYcBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751868527; c=relaxed/simple;
	bh=j4G0Wx2yr4Ie076V8PuheN4NOheXivQOkTLVOcN52K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6LPZDNn4U10XMb0W3A5m7mwcVBGdfHSrVctJxuF4E6zrdDcLo9JYKkNzjSVtjP20hbRJ5+CFmEMNoX4DlYf42BUvHQUikce4KbC0HU2RnZjvWr5dHd9FSHC33TDtHyIajme3ijU2+CRIZkJiZLa+VyvWXvdBd5ogeYGUudKRSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=yRjvoK1N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FeI3twQN; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="yRjvoK1N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FeI3twQN"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 85DC7EC0470;
	Mon,  7 Jul 2025 02:08:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 07 Jul 2025 02:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751868524; x=1751954924; bh=llsS4IwazH
	e8dEv6keGAKuQEwnblUiuOP4AYnaS9gKQ=; b=yRjvoK1NQDyj+wtTuOermolX8d
	pu5N+RV/xzU+zC6OIBJ2PRUqxQGUFuy66HIyH2nZwnqBrOzFcPkkDbBq3zPQOiwI
	ZvoNSY4hK/bJmnvFf//gfUiWbsuLHsKD6VJWHfSal17GFLR1Bks0JNCmVAW+o+lJ
	m6xX1Fa2ghm+oAiugyaCt3DNgvHTuM/oIi53kneugLLwN2Qxxhg2ZSTu4ZhlYWUm
	B7HW2CYuVO8owhGoOd3jmFMwbjm1m+bno20xyhnzGgPE2uheLxjz+NFkjR6eWieH
	AEaZUnX9CbBQjbEnIQ9KgQ20YfRwyFD22PMCDKVI7c7fqa6RsJcQDkWcLk7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751868524; x=1751954924; bh=llsS4IwazHe8dEv6keGAKuQEwnblUiuOP4A
	YnaS9gKQ=; b=FeI3twQN9gm3iX0O2/l8oygnZDt+Ay1496Ct4iXZ+NJv8EUSPzQ
	wcRvInnRQza8cWnG4b8vLV4D/iGyTcp9NuaOaT9rdTv/ulNI+6D1vHWkeJXo3T9k
	4ermVaOA8FRwotL+VLd0c21Fg69ewwDAUde3HGcS47UyAi94zhFybnM2AE6mk1HT
	OeGKfHezzzpb8YSZdSN1InbI7Ddf9p6Nyw2OstY/LZOl87xpOdtv8BYUQJJt4jGT
	paJZA0f9F9RLVz/0DVdCx2FCPcSt83/AofOYfVUdwtCFRr07gZVqKf+ff8TOxpod
	GmrkqPUtc6noLg/Ha8jwACPQLygWnPWj49w==
X-ME-Sender: <xms:bGRraJF8-eU9-xk42iMdq0oR9CvHF2RtEqOk9D0JBLpXAZMirEyYaA>
    <xme:bGRraPC9fzP4TzC3rep7Hq7FFLdbfcmNizC2TYPA3i_YZ1dS8WNwcNVTAuY6EqHOm
    1TWOpPeBTDipOj7RQ>
X-ME-Received: <xmr:bGRraJVT_jIeyZy95ZDYRXxrcGawLCkuqFVVLzdMZLTIkGmkAlNp4vBa3ww-pqMZXp_mEN66hf1T253OOmhCZJI6hp3iMlHct6y3ByshXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefuddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehushhmrghnrghkihhnhigvmhhivddtvdesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdr
    tghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprgihuhdrtghhrghnuggvkh
    grrhesghhmrghilhdrtghomhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehshhihrghmthhhrghkkhgrrhdttddusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:bGRraDrUCstHYZOSVF6783aMMzo84uB239DSMQ7rQEd6ZIBUAaqZlw>
    <xmx:bGRraFTUmpOttYf_MGrrjNRZIH5mqEKBUkGrRcz_IQDwtyO6uiz07A>
    <xmx:bGRraN3aiBeykd59UBAkYL38-2pWsvm_022XDcfcBcdpuFMZ3T6Fig>
    <xmx:bGRraBB8MPed0JcFOj_-cVecBDvJL6F4QUbOp0K-p1uTOYWO6TnfRg>
    <xmx:bGRraBq20tpJumKKNYPe7ekYNi8ENFq-gJtb2MvSWNodAUEqKsbQF9gR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jul 2025 02:08:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b33f41db (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 7 Jul 2025 06:08:41 +0000 (UTC)
Date: Mon, 7 Jul 2025 08:08:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org, shejialuo@gmail.com,
	shyamthakkar001@gmail.com, gitster@pobox.com,
	usmanakinyemi202@gmail.com
Subject: Re: [GSOC PATCH v3 2/2] builtin/prune: stop depending on
 'the_repository'
Message-ID: <aGtkZgbJhO-GQ1XX@pks.im>
References: <cover.1751630981.git.ayu.chandekar@gmail.com>
 <22fbbc8cf1b5cd622197e6d9f009acdbbcc0e802.1751630981.git.ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22fbbc8cf1b5cd622197e6d9f009acdbbcc0e802.1751630981.git.ayu.chandekar@gmail.com>

On Fri, Jul 04, 2025 at 07:42:35PM +0530, Ayush Chandekar wrote:
> diff --git a/builtin/prune.c b/builtin/prune.c
> index dab3c19b6f..320e9c2341 100644
> --- a/builtin/prune.c
> +++ b/builtin/prune.c
> @@ -173,20 +171,19 @@ int cmd_prune(int argc,
>  	expire = TIME_MAX;
>  	save_commit_buffer = 0;
>  	disable_replace_refs();
> -	repo_init_revisions(the_repository, &revs, prefix);
>  
>  	argc = parse_options(argc, argv, prefix, options, prune_usage, 0);
>  
> -	if (the_repository->repository_format_precious_objects)
> +	repo_init_revisions(repo, &revs, prefix);
> +	if (repo->repository_format_precious_objects)
>  		die(_("cannot prune in a precious-objects repo"));
>  

Okay, we now only end up using the passed-in potentially-NULL `repo`
after we have called `parse_options`. Makes sense.

> diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
> index 6824581317..8f59b867f2 100755
> --- a/t/t1517-outside-repo.sh
> +++ b/t/t1517-outside-repo.sh
> @@ -114,4 +114,11 @@ test_expect_success 'update-server-info does not crash with -h' '
>  	test_grep "[Uu]sage: git update-server-info " usage
>  '
>  
> +test_expect_success 'prune does not crash with -h' '
> +	test_expect_code 129 git prune -h >usage &&
> +	test_grep "[Uu]sage: git prune " usage &&
> +	test_expect_code 129 nongit git prune -h >usage &&
> +	test_grep "[Uu]sage: git prune " usage
> +'
> +
>  test_done

And we have another test that verifies that all of this works outside of
a repository.

This addresses my review comments, so this version looks good to me.
Thanks!

Patrick
