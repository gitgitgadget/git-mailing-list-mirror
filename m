Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152B61FDFAB
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 07:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730790723; cv=none; b=Pz2SRS1p6wsv+lYOSm2pDwW5chqR7uOYxyCriy68D92S7j52gY6AjfgH2kF3jgmtuskI1d+T3FWKu49ANYh3CUxOGKJx4C1POEw9k387BZBGGchdVXogTphNjHfGNV4BdWhoWfW7cp7lVd1Wej6Bd/RA5LkZ9q0yC4OCbQwKNro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730790723; c=relaxed/simple;
	bh=3Hlx6iYIciypU5cTn4RvSsDlsXLLBpB5vPM7mK+QxWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWNrP2tr9hy/Y5n2URKt5rO8ZE+vg/dDiBZujs2fFNV+SqxmePB3MxG1UUcU8PhWEL9akT3WMGx5A6+/T+iX7dtlBWq7AwEanhsN6dGWoKX1O0ykFNmjF/5ycA9ut6anvRkahORj09aF3yq1bYa03d/hCY6XPkBRWH7c57e3rnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Sq10H5Q2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SwXojZx6; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Sq10H5Q2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SwXojZx6"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 31E82114019B;
	Tue,  5 Nov 2024 02:12:01 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 05 Nov 2024 02:12:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730790721; x=1730877121; bh=5Y0xmi1+jz
	pQNUwdUsD14gNVL228kKkmZvSpsHTfVpw=; b=Sq10H5Q2Mr8XZ5gzax/O2BREN7
	BH5hOuSEu5DA2ddGPwgRM/JX6mCnDRwTS1W7F2PSoS79JjyJjH2EjVUUeeOvdxWs
	hdTtj1rr1FlauWaFPL+mkZAhEPYE/2TXaKMPCMf+sq8AtzLD/VOl7MbCM2erVD3P
	KfvMtgqIr9VtnG6ra97cgn6ItqpsEATv14Ovc2eS7MbTyO6UCSX1HLHJDNhKeEaO
	I0h6x0knNyNajI+b2D4fYj+/UfWZISepQGdhkM8uwtNv+Oo7UbC3nzxW3LLaM46I
	q6nr4/8+x8Rh3PLuETb+R0/0IqTCfYadWIZ5/N1O0XbhDgw5H0U7kYvlloDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730790721; x=1730877121; bh=5Y0xmi1+jzpQNUwdUsD14gNVL228kKkmZvS
	psHTfVpw=; b=SwXojZx69ezoCFt1q0ePaSPs28tc06/NqPZBW3O6VSwDRz5phBF
	dUvcDdoi0ce5aU1Jsq2vtt0rsUHo+ouzduJn4AtSnaLIgl/e4/RinjF3Rj8X1qVP
	vC2rw4hOQaKo+UQ3QKc9fwakMgE03PnBaEaTH1T14YF2zx1suiNZPbKz3OnZ0kxC
	LtOzs3ZooNtBoPkO+8h5qlFjQSIPm9yymsfdKLPnQB8Fr6NKrcxiIYNDF08aFwC0
	uGvD+zLfCKiZ0wPyWpRSfUSeCejEmaPzA+oSuGRw/7YQGesaadhdFuMO96uB+Lyd
	khwVrAnlEGQPUl2bGuxjPHP6ITq8Lm6Rhkw==
X-ME-Sender: <xms:QMUpZ7vA97nIQpWfGNLIT1qPtQdiQvXDoYBVM0CHQSBQpBTLcBC31Q>
    <xme:QMUpZ8ct_-PNkuPRF7yA0LNPSufrhylJqfz1HSRqzVx_gAxNMFmpgNYBXyOupBTBP
    aIEpxG5BL6RYzcnrg>
X-ME-Received: <xmr:QMUpZ-yfmxM7VHhMlOlIIeH7Gn3S2Z_8qMT-oN3zomhq94y8cv_K15eThDv2QCSp6VBfoCoC55vJm2eUBOnrwwh4poQkXlAMa-LRbwpgAmwflg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdortddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeejtddtgeffkedujeejgeduhefghedtgfdtieduleeu
    lefgueetheeludegueeuveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:QMUpZ6OLZIXu5LsNEAZQQFrCzLBk9rMvbGwy1oVhEy8nX3w4p_hTow>
    <xmx:QMUpZ7-qy3GdV5UiXURBGvj66DgYAfl8Q72k_hAafrhjVjtCm4bXFw>
    <xmx:QMUpZ6XpGfqPRYQ4rBs9KBLB52gMRhijIsRuV56bQxenxYEhdyQLkA>
    <xmx:QMUpZ8dKrLEJCa81WoF4CDNZQ4Z-WfuNATv7L0wV3wUsxv5t8blm1w>
    <xmx:QcUpZ3bLW6YAUSSE5qjUfplkL0HLFHSZ58HzV69gIgMPmy61-7pAInnL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 02:11:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8180b660 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 07:11:38 +0000 (UTC)
Date: Tue, 5 Nov 2024 08:11:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 5/9] ref: port git-fsck(1) regular refs check for
 files backend
Message-ID: <ZynFOUSUXAtTtWTk@pks.im>
References: <ZxZX5HDdq_R0C77b@ArchLinux>
 <ZxZYd1qL6LxAc9-Y@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxZYd1qL6LxAc9-Y@ArchLinux>

On Mon, Oct 21, 2024 at 09:34:47PM +0800, shejialuo wrote:
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 24ad73faba..2861980bdd 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3505,6 +3505,48 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
>  				  const char *target_name,
>  				  struct dir_iterator *iter);
>  
> +static int files_fsck_refs_content(struct ref_store *ref_store,
> +				   struct fsck_options *o,
> +				   const char *target_name,
> +				   struct dir_iterator *iter)
> +{
> +	struct strbuf ref_content = STRBUF_INIT;
> +	struct strbuf referent = STRBUF_INIT;
> +	struct fsck_ref_report report = { 0 };
> +	unsigned int type = 0;
> +	int failure_errno = 0;
> +	struct object_id oid;
> +	int ret = 0;
> +
> +	report.path = target_name;
> +
> +	if (S_ISLNK(iter->st.st_mode))
> +		goto cleanup;
> +
> +	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
> +		ret = fsck_report_ref(o, &report,
> +				      FSCK_MSG_BAD_REF_CONTENT,
> +				      "cannot read ref file '%s': (%s)",
> +				      iter->path.buf, strerror(errno));
> +		goto cleanup;
> +	}

Let's drop the braces around `(%s)`, we don't print such braces in
`warning_errno()` or `die_errno()`, either.

Patrick
