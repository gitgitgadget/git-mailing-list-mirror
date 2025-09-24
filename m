Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D363B2FE56B
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 12:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758716941; cv=none; b=fBnWOwW99BJzZRfdpLNyTBoD5yNT42n3wq3koNnnIX8k9gDXfLi6TSnIVTnsrpOi3WvrJKqM4tep8mGMCoiq0qaMuUcx3lWAmSwMesR4GL5FqyZd0jZKjuf1ALRr90XOM3FVV79XZF1NSRrGqEZWl9exwKMHlWd+2dFaEYqNtxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758716941; c=relaxed/simple;
	bh=198Ug0IayrULEZte8YAtVC31njtBdRVoZSdYw/qoaNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQWMr2reFJsELy6tN8XOdiGDKISaLsBBj8p+fxl37ULtSb8Lw263OQsSkXGx2gkyecgdr+PIxAIBTfMF/IhcGtM5wWKdaZ/2MKpwPQqAi8tvldgS5coA5XIXemccv97FlX6OjQek8Q7KmiLfeJVeY3kHKkBshg9+eBNkb5IuY+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Wzp4Fr8s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YrS05NYR; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Wzp4Fr8s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YrS05NYR"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 982591D000E9;
	Wed, 24 Sep 2025 08:28:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 24 Sep 2025 08:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758716937; x=1758803337; bh=pMfTpCRrSm
	/asji//DyYHf0j1ClCXhoRPhZVPIh5TP4=; b=Wzp4Fr8swQI2cSlhU9bBxaQJ0Q
	duwfhqQR3CB2uaIrm46TAFVZkSFYRNaaIYb3zrMC7E69qpL4pDVE3JQNPUgkq92Z
	81foIplB1fxGJqCwSkh0dsWMoU5DOAOCGtYuEI05YBX6OGu7xFkGyBsEp+ywycm9
	eofhXlDxizecB51DZd4xDwFhrkFGnn0krjqCrqow++mWnyYb4r23kaKpwaElj0LM
	DS/3yaCZSMaHKMXGBN/oIMTRl70o6LPGVIrklIPRci60fesnB+g7eJDUc8am75RL
	gX+4IkDMMwMuvJP9PdrEatzLP0S+j2R3J1sFFfEzTsfBI6tuia4P4ux/hxag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758716937; x=1758803337; bh=pMfTpCRrSm/asji//DyYHf0j1ClCXhoRPhZ
	VPIh5TP4=; b=YrS05NYRk1rm9f8S5O6mobpF7tgffFXD+4kEhKvzN+bGxKXIotE
	eMupEOROeIZSlpB0sSn1VpCJ59VgZQU1ciXSsXx9DpRTww3+t+pIQurklrTYOZR0
	E8tVKvVS8J3Ud0ekAGNdzMhP3OH2SdFY57fy+Fu/d4HZL7T1M+eL4+pOW5iBFmoD
	bsihoA8IjZfH9IL5Wl28px7qDu+6x2Fgn3x3w8voZLarjci1fFuEt04eyON/DUPE
	HAHJPWzl7XKNXMf3q04/4iVNIwkx2MXkC2mlQ7xp0wZ+aVLHMFlTiPVK/FSq5Zhr
	SeXiykymwrcKT6QqvGc7u17cMcUWhUB7JzQ==
X-ME-Sender: <xms:CeTTaIxHp0woEMZjw-8U4lqS2sPFpgMZq6dEtQsluPl4l6L-L-8NkQ>
    <xme:CeTTaCTeJCOzpS6ZdtzAAIihULV5IeaHYVHjqjw36qMvWbBu6EqocLSqOXaNc5WPf
    SdeovGTMR3wmo87kibKb4x_9aQ1JR2vfw24X9ArZEYOCKn23jnZ4g>
X-ME-Received: <xmr:CeTTaH_jv0ttG5R6EclA6ce13vopvLv3CCVfqgQuR8n_kHuJX8_c1ph6ym9W23ZuMsISiTIWRUACWZD1quuqDc1sCze5SqfEU07rVPf0lA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifeeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:CeTTaBpABqrF3amZp604YXFVktCwjCX7CPe_OjVToSiI6f_UxCDr4g>
    <xmx:CeTTaMkk_48ahY-SgaF9FymMCrkWs4R7HqjCreFugp4W28aZSoC2-g>
    <xmx:CeTTaAIrk19SrgmZ2hBCCtWuaCLw27LwiUp-QCb7Q0I0kYh__Z7u9Q>
    <xmx:CeTTaJzOuSdtCRbj3YxiPmS5mYQRNr9W7JT7SZad6GqJL1-O0Icabw>
    <xmx:CeTTaEjbKqVx3nZqfwjAv8kTQPjSLmHaPdDqJODAHVLDn4GRRvIgjunS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 08:28:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 221bac34 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 24 Sep 2025 12:28:54 +0000 (UTC)
Date: Wed, 24 Sep 2025 14:28:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] refs/ref-cache: stop seeking into empty directories
Message-ID: <aNPkA9UZtEqHsa3f@pks.im>
References: <20250924-583-git-for-each-ref-start-after-v1-1-c73be2b5db5a@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-583-git-for-each-ref-start-after-v1-1-c73be2b5db5a@gmail.com>

On Wed, Sep 24, 2025 at 09:55:51AM +0200, Karthik Nayak wrote:
> The 'cache_ref_iterator_seek()' function is used to seek the
> `ref_iterator` to the desired reference in the ref-cache mechanism. We
> use the seeking functionality to implement the '--start-after' flag in
> 'git-for-each-ref(1)'.
> 
> When using the files-backend with packed-refs, it is possible that some
> of the refs directories are empty. For e.g. just after repacking, the
> 'refs/heads' directory would be empty. The ref-cache seek mechanism
> doesn't take this into consideration, causing SEGFAULT as we try to
> access entries within the directory.

Why do we even try to access any entry in an empty directory? We have
`dir->nr`, so shouldn't we check that `idx < dir->nr` every time we try
to deref an entry?

In other words, I wonder whether we fix a symptom of a missing bounds
check instead of addressing that missing bounds check as the root cause
directly.

> Fix this by breaking out of the
> loop when we enter an empty directory.
> 
> Add tests which simulate this behavior and also provide coverage over
> using the feature over packed-refs.

Nit: the commit subject might be adjusted to mention the symptom we're
fixing rather than what we're doing in the commit. At least, it feels
like the segfault is the more important thing to talk about here.

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  refs/ref-cache.c               |  3 ++
>  t/t6302-for-each-ref-filter.sh | 65 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+)
> 
> diff --git a/refs/ref-cache.c b/refs/ref-cache.c
> index c180e0aad7..8a260028ec 100644
> --- a/refs/ref-cache.c
> +++ b/refs/ref-cache.c
> @@ -507,6 +507,9 @@ static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
>  			slash = strchr(slash, '/');
>  			len = slash ? (size_t)(slash - refname) : strlen(refname);
>  
> +			if (dir->nr == 0)
> +				break;

Can't we break before sorting already? Avoids a couple of no-op changes.

>  			for (idx = 0; idx < dir->nr; idx++) {
>  				cmp = strncmp(refname, dir->entries[idx]->name, len);
>  				if (cmp <= 0)
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index 9b80ea1e3b..d14567cb62 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -754,4 +754,69 @@ test_expect_success 'start after used with custom sort order' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'start after with packed refs' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit default &&
> +
> +		git update-ref --stdin <<-EOF &&

s/EOF/\EOF/

The same is true for the other test.

Patrick
