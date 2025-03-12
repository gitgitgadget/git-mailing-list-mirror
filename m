Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C54C13B
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 07:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741762871; cv=none; b=KvFP1Z9JqK9teO3+fzT7eTuMRjhvzR+fd8/Acpe7OY50cJa1p3qFMWfp0hqUMTApF4hFPMvgdlCEHTJsxgqP0qNwIKv9FRQN9gW9/VK9T4U2i0JGqvovuCwl3wctS9HeVbd+JQJL3wRhI+zDRlBC0+uCreetCzP1YnuNYar+KPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741762871; c=relaxed/simple;
	bh=53SEIQPigsfrBpiWXfqfI6s0GTe069QTDzjhOszLI2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZAEzMCjkKqOiyDrk+rNLMXi1S+JziSBsa9QHRmKFe1hmF1l/0WnuBqWWjT4lHTxuYntx/H5X1QpRaOOIw+h1euYc+23eq7/fAjg+bEcaiw9s1q+pqj0ZcP996OTVhDQ7Hzfk34vMSYqLTUFkhZVjycsgnW0U8OO7jh47l9N/ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=efNmqUv3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M9pUhA2G; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="efNmqUv3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M9pUhA2G"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 963521140292;
	Wed, 12 Mar 2025 03:01:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 12 Mar 2025 03:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741762868; x=1741849268; bh=OaUO5HgtGk
	6BZbfUfqa7Bzho1jOUzQo6Xlu2NyDTGh4=; b=efNmqUv3cRCo1V5JL9RIHVV1X0
	Fk9IIz8hxejyOy5CB/dJXhqoFBmIrusWubxcSbX8ZzZ7xVQVBd5qtkDO4hka864w
	MkeAbked8Ah6/2womTHzzb99/pYm/3KDyvhUs+AJCUHMqlNs3pSt97zLh7/zSr8l
	Yx/g0TkewMF4rCWXCO+C6fZjlKXHn4J20OBz2/72D2RmMHczGAuy9JpnwrnRPtKX
	t13JZXmQOMao4Y596YzNVNiF1F5Gw5Sju9zBJF0gd++R2nISGe77dMqxT22HWgAi
	0pO+pAbsD9hd3hra6x3xtmwBbiWVB6BmPRniXPVN49cfSr36+a15pQ9h2r+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741762868; x=1741849268; bh=OaUO5HgtGk6BZbfUfqa7Bzho1jOUzQo6Xlu
	2NyDTGh4=; b=M9pUhA2GSZXPIMQJBfLBID/nkTwH0Q6VaA53U27emXhkkA4a4kq
	ZCadbTftFFr5+RddQWIT4+FCENLA0u+sMHp1GIBPWnWr48P/Rlvs0cRrZO7SVwzM
	0bX9MfQe3cyEWiW6P7ANqYrIMovHLHKO3Tg3xPlRRRKokFbgD5Z9yLqlVT3A2LtS
	LVqyum0l1oxgLJ4/DMHnKcMj6e+9lOk6vlAA8qRO1/BBaR+Fj7yxQJ6Tr4FTdeXt
	y6cx2NbONx93CwDjtdd7ZxJ9T2OFLpE4su5O7L4FpVQB3aiWfy06CSLeT+2dj7Sn
	Lfkh2X80pn4c3KnnWedUxX/r0uBI3neJlpA==
X-ME-Sender: <xms:NDHRZ8BRSu6-P3IGNKNCo1XXQs7KLHB_h279lePSTgGcPhMYZo2d1A>
    <xme:NDHRZ-hqDWBrnZstQ-xBp0nsEi1KTvYQ-mMhSRKgSvGaqU3QgJ4H6bO3LfXWI87t5
    uOYFuAzSu5vFzJGUg>
X-ME-Received: <xmr:NDHRZ_lMA6nQNy4L3qK3wJBIKwNbSumDlyH48cJywpQE3fHqf7YTi61nfGHCWNfydtXR-bpR8YZd0Og3LnAZf2RyLYxo4ER1kP27tTsq-JZSUXrbXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdeggeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:NDHRZyzo_hWfzADGNXsfke8nFh1VvLpwHhRluVMsrNTJhqpIChUxhg>
    <xmx:NDHRZxQn9M73CGVx6BwlhFou2hRL820B0X2S3h6CrGEXXmNhgclOWA>
    <xmx:NDHRZ9Y3Z1jLYVWJ4aHz7v0h21ybJ83F1A2diYTxL-5QwUgeyM283A>
    <xmx:NDHRZ6SbAuBT_qtbRcyVaBfu4OylaMLrnFqj1dxgLRUzqzEjrEbVxg>
    <xmx:NDHRZ8eCbSBTRt2-Hcb0WTqLYgxVB6hdxESO5PQ0KgbYg7umPdwGlZ1a>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 03:01:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 40b8e2f6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 07:01:05 +0000 (UTC)
Date: Wed, 12 Mar 2025 08:01:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/6] t: extend test_lazy_prereq
Message-ID: <Z9ExMHf9CkcDwEt1@pks.im>
References: <20250310231652.3742490-1-gitster@pobox.com>
 <20250311212505.2920181-1-gitster@pobox.com>
 <20250311212505.2920181-3-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311212505.2920181-3-gitster@pobox.com>

On Tue, Mar 11, 2025 at 02:25:01PM -0700, Junio C Hamano wrote:
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 79377bc0fc..16eaaaf4c3 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -773,6 +773,8 @@ mkdir -p "$TRASH_DIRECTORY/prereq-test-dir-'"$1"'" &&
>  	rm -rf "$TRASH_DIRECTORY/prereq-test-dir-$1"
>  	if test "$eval_ret" = 0; then
>  		say >&3 "prerequisite $1 ok"
> +	elif test "$eval_ret" = 125; then
> +		:;
>  	else
>  		say >&3 "prerequisite $1 not satisfied"
>  	fi

The semicolon in ":;" threw me off a bit. Am I missing why we need it or
is it superfluous?

> @@ -811,6 +813,9 @@ test_have_prereq () {
>  				if test_run_lazy_prereq_ "$prerequisite" "$script"
>  				then
>  					test_set_prereq $prerequisite
> +				elif test $? = 125
> +				then
> +					BUG "Do not use $prerequisite"
>  				fi
>  				lazily_tested_prereq="$lazily_tested_prereq$prerequisite "
>  			esac

Hm, okay. It feels quite close to overthinking the whole deprecation
cycle around prerequisites as it's nothing that we tend to do very
often. But on the other hand the implementation is trivial enough, so I
don't mind it much.

Patrick
