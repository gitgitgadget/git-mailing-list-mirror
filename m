Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA50639447E
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 10:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768388335; cv=none; b=c8LPeDzfTY7KYPmtBvBmywIHRj/5Il8Reeh4tjkjH/yM5/le0aEx1KxGP4dpodK4h704eTgwGx9h9LcpUhSNX5MRsQe2cV++0W3zIwwVY/wDcwi8fRd7JyAYk5LHH1OsgdH62GSaYgAfx5K1O4BTGvEY2L26o3961xzdPELGK+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768388335; c=relaxed/simple;
	bh=ty1gZG6pgaAWCJwZ9PnoX3jtk9zYJOGUr6KWe+46/gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryDxaCYh0qbhc4je900/CDrP0uAy5fe8894ULp/ZMwgW5lrHB7P1frFiJGwmVnyCgUp8fFi0eyieYMpZ6LzfKvyKp0fik4bz/EHacJB4P91sD9Gi+aj4oFrbwy4K52U17vCeIXzut5DPVnR477oe4xna5yy0CMdat/9Yv8pI15U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dWtbC3di; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0a8qSFKu; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dWtbC3di";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0a8qSFKu"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C52961400040;
	Wed, 14 Jan 2026 05:56:13 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 14 Jan 2026 05:56:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768388173; x=1768474573; bh=eWqA35rnLM
	jOSqIOeZAbScFSa3l9hhRV50tWn5G0SQA=; b=dWtbC3diqWax1M4SqU8s7h8ZVl
	sdmoaNjJjOq9tn5n5Gns7pyYpZDdZMRhGx5F6lFxdNW2q3MQVMlPjTFDmKUv2V+2
	2uWiM0+y5kgjz4g+rEqN+9G7DIo4NZePqHqsbDntQ6FR5ek26Nfs1DQFP2rirXUA
	aSaFK+IzlJMdCtKbLtTCmXlkZA1+vxEQbP+Jc6vqyWTkUowvmuKFIF30TpSgBYEV
	Qsg2HgpTE1l58J2WNK9mTY2QMyxPyMGN26dBsxm3kCsEPE/lq+/9HFWmK2jEDDyO
	rrJXnROXuu4TWilh50jBozl6u4IT/hhVq4Ivz7a+GIqv78k/EJ55rvWCRBvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768388173; x=1768474573; bh=eWqA35rnLMjOSqIOeZAbScFSa3l9hhRV50t
	Wn5G0SQA=; b=0a8qSFKuWNJq+kGcs/HkwLBY3hjLaq6R+E0DVmipFHA9nfMMWo2
	RJS5n5ug94VKH2kT+wXVmuCL5cl2Dyt+DPpvwQ4LkEm6BUbQQZ0yMjIFev/HNPfW
	JCTwX3KyT9c5gTvRofQAq71oh/KtPahxuI9BcTDrdv7cJj9jAbsb9wwNo5T25/ni
	D1Gp4NJEBZJvyEPQXMQTHVuhF7x0yk+X9sw+UUdx6a0TO4bbcRwZccvBjglQx92n
	Edn5N9ez5Hel/QC1mEqHRIzRNoytnt+VqkC9FcBONmIf5Y69Wak3W5gl8Rxjndz/
	3rks8g2vy+Xam9kWuMPONLU00qfF/hYqvHQ==
X-ME-Sender: <xms:TXZnaZpdWvzgddn5Z4qP9PgPBdlJUs4gYI8g83E-zMf-vXCOJ2VxMg>
    <xme:TXZnaRrWHVGrxNUjpv1O8wZUASwWSAp7fhyEFffWKPxjJ6o3Ox50UD0d44j6ra5Mq
    7fsC3q7CLwND1yKWhsjHiOk2wlqJrSnbtfXwbg31piNUu73vbrtlg>
X-ME-Received: <xmr:TXZnaT17UHieKThtVD6yWl3NxZjO20XaEfJI4SiRMjtX1spLEYEvdhFDU7y7dbSO7qYLBr-3_pVZtp2KUfhOeRkxkRyT3K6_O9p60zme8kA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddvleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonhesih
    hothgtlhdrtghomh
X-ME-Proxy: <xmx:TXZnaQCQEzMYnrRdC_njsNghYT1k0RtN6AGWdfREX41YedawAA9-iA>
    <xmx:TXZnabfNevw4xTg6mTocNfDb8UUpM6Xlx9peFpEXDfaw6_5WO-IXnQ>
    <xmx:TXZnaVjsZ8lEQff0nOsHXd_uwfwt7fUslMYQMlibViaocuhwzYBpQA>
    <xmx:TXZnaTpkSyy6CXgPlAq9YdKDuhCmIvNuij2WTJVjDIGs3YMBbHjxEQ>
    <xmx:TXZnadBAwAq5HvTb9JE3OjBVuok7tmEkSmSUmcPrrT3VNvyExEe9ssPu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jan 2026 05:56:13 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 380279cd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Jan 2026 10:56:11 +0000 (UTC)
Date: Wed, 14 Jan 2026 11:56:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] last-modified: rewrite error message when more
 than one revision given
Message-ID: <aWd2SLrBQRBC1e2S@pks.im>
References: <20260114-toon-last-modified-tree-v2-0-ba3b1860898f@iotcl.com>
 <20260114-toon-last-modified-tree-v2-1-ba3b1860898f@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114-toon-last-modified-tree-v2-1-ba3b1860898f@iotcl.com>

On Wed, Jan 14, 2026 at 11:24:45AM +0100, Toon Claes wrote:
> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
> index c80f0535f6..06e3f79aec 100644
> --- a/builtin/last-modified.c
> +++ b/builtin/last-modified.c
> @@ -145,16 +145,20 @@ static int populate_paths_from_revs(struct last_modified *lm)
>  		if (obj->item->flags & UNINTERESTING)
>  			continue;
>  
> -		if (num_interesting++)
> -			return error(_("last-modified can only operate on one tree at a time"));
> +		if (num_interesting++) {
> +			ret = error(_("last-modified can only operate on one revision at a time"));

Do we maybe want to be a bit more specific and say committish instead of
revision?

> diff --git a/t/t8020-last-modified.sh b/t/t8020-last-modified.sh
> index 50f4312f71..1183ae667b 100755
> --- a/t/t8020-last-modified.sh
> +++ b/t/t8020-last-modified.sh
> @@ -12,7 +12,7 @@ test_expect_success 'setup' '
>  	test_commit 3 a/b/file
>  '
>  
> -test_expect_success 'cannot run last-modified on two trees' '
> +test_expect_success 'cannot run last-modified on two revision' '

Nit: s/revision/revisions/

>  	test_must_fail git last-modified HEAD HEAD~1

Another tiny nit: I'm always a bit wary around tests that don't verify
the reason for failure. We might want to add:

    test_grep "last-modified can only operate on one revision at a time" err

Patrick
