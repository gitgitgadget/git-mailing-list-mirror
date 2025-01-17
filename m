Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D6625A659
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737106580; cv=none; b=MIlkpdWbZQE57HDhmh8NtCafMb63OYTGd93FoOZdQZD24Cb1mFrkquuD5LU9InBTvK1pDn/gwzp5MHlVZ2fPiFlPtRdrzwFjZp0HNBtyOMQNXMTNOuK71HBgUoFQZdjnQUwkMRNl3BujZdb8kw2AeLqVO3qrJ6A6k1tFwgfQVRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737106580; c=relaxed/simple;
	bh=4+kGRY00aGTGA+QqJVCbiICQ/PXpG8yvQfXCnknMOB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+/jIGW2WnY337juf4SZtH3rp+tHd0Xz/Zj13QE2REZKxai/y/1PWo+o9v+/7HgCv63SWq0G8a1he9Mi/6xlJyfTrYQDcUbJP2aa+tZRvpRgVuE/qmg9wHX5oZ5TBaBW7ErMvSi7l1WlJ7HM2DtkzZcp8dmwmD/B7F1XS1dWmo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BZhVrMB6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WK+T6yjM; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BZhVrMB6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WK+T6yjM"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A904011400DB;
	Fri, 17 Jan 2025 04:36:17 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 17 Jan 2025 04:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737106577; x=1737192977; bh=CrkTdzyOYt
	6s5qscTR3rhQ8fJyFyKE4HrCN9RmWWS6Y=; b=BZhVrMB6/BoVrpSNJyvVKYQwOn
	zZgf893A+yWTZHIUSA9rNm6A/LNhckNa88qV+MHLwM+utPvG6qE7hRXWDz9oTOEr
	f5oKfZC+HMdtULeVriS+LG/h5IYM/ILyjQKhyyjAXl4xDfRBJE+DzUpARNlO7XLO
	t5fkGfNNpLXSLpOXavA3Rtx+KPukgU43ptdo5xo/VYB1YnBdyuLN5t7QVYBN9b7A
	/BhpdfD9GHyMWKahWTNmqZ0d88AQ/e/FYVM8CTJx2qUctwmdeTaJTEHu9ec258OO
	PAfx7fkHOGymjEhIYX7IkXYuVStpE3O551bNoXQOTTW1MSVGsC+9jxNSSwTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737106577; x=1737192977; bh=CrkTdzyOYt6s5qscTR3rhQ8fJyFyKE4HrCN
	9RmWWS6Y=; b=WK+T6yjMgTxWLYT7x3GUPga2zvn37wT/OinU9ZmX0OKyfenurmg
	40VweuMC838RZxo8G9kTP+TZL2GWPEGek3v3jsUhfe1htWb2kWKCbNyKPYSUXRJ0
	Nm39EKY9p9mo19Tz9yMrUniEWfI1dKl/DMjAvD89pufKPkk38nH8s0ooU9up+2bD
	/QhpM1AhqBKsRDeCuUnp4UNeTM0J3VV6+7qU2OpllvGIsX3WrgPzZvS9KXLQZTaK
	LkX1XEJCCSwoJ6OVw1QcmOWYMujmswAyqtWykKBzEUq0QT36NIoPZ0aPVSyNZAbX
	60dZ7K/pYhaLqToKFtnm1F4vmoQcyBgzQnA==
X-ME-Sender: <xms:kSSKZ4GhaZ2nppvsspi_DtIF1ZczL1jNAiRYIMHTAO9QVO5Dpm41yg>
    <xme:kSSKZxXG9fUME0TEYEZzT6xVKg4rmTiRQO-Foi7u_4VCZf-x1o-po2SeUYw5ZyjXV
    Qvtwb-7G4BX09lTjg>
X-ME-Received: <xmr:kSSKZyKNWFLpXsF3hbD83I5-bW45KBe6TnT0enzm35r1rfaJgXsUBDQxpFRDpxFOQCbWTa4aoD3AbR359orHmxFpBfZJQwes3GTSmyZRKxTz0Ws>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhhsehglhgrnhguihhumhdrohhrghdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:kSSKZ6EPvHoVVNaxKhcmVZDlMOqxEuybB4ywfpVg0UCMMZtiAZrqCw>
    <xmx:kSSKZ-URzXripXgexP5_-h9zcnz_FBlbBSL5UCd7_1fwTz-emQjitQ>
    <xmx:kSSKZ9P4Zh2WSj2yJRK68ffbD7mlN3kuTfoH2bRjI7oTKw6Q4fMbJA>
    <xmx:kSSKZ10Vh9dlcYBi6cqvPRsid06iC3QBy09ZAB_HZtHwb0TAldTJFQ>
    <xmx:kSSKZ9SF-Kf7W-SEU0WaRCa0VSZmCOeTrxZxCtF70MUL7VwD2npOHSdO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 04:36:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a4a585b7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Jan 2025 09:36:14 +0000 (UTC)
Date: Fri, 17 Jan 2025 10:36:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Mike Hommey <mh@glandium.org>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] connect: address -Wsign-compare warnings
Message-ID: <Z4okjR8YfUGvnt1t@pks.im>
References: <20250117074909.1430067-1-mh@glandium.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117074909.1430067-1-mh@glandium.org>

On Fri, Jan 17, 2025 at 04:49:09PM +0900, Mike Hommey wrote:
> diff --git a/connect.c b/connect.c
> index 10fad43e98..91f3990014 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -77,7 +76,7 @@ static NORETURN void die_initial_contact(int unexpected)
>  /* Checks if the server supports the capability 'c' */
>  int server_supports_v2(const char *c)
>  {
> -	int i;
> +	size_t i;
>  
>  	for (i = 0; i < server_capabilities_v2.nr; i++) {
>  		const char *out;

I know that it's often frowned upon to change formatting while at it.
But in the context of these refactorings I think that it's quite helpful
if you also moved the loop index variable declarations into the loops
themselves. This allows us to trivially see that it's not used anywhere
else.

> @@ -232,12 +231,12 @@ static void annotate_refs_with_symref_info(struct ref *ref)
>  	string_list_clear(&symref, 0);
>  }
>  
> -static void process_capabilities(struct packet_reader *reader, int *linelen)
> +static void process_capabilities(struct packet_reader *reader, size_t *linelen)
>  {
>  	const char *feat_val;
>  	size_t feat_len;
>  	const char *line = reader->line;
> -	int nul_location = strlen(line);
> +	size_t nul_location = strlen(line);
>  	if (nul_location == *linelen)
>  		return;
>  	server_capabilities_v1 = xstrdup(line + nul_location + 1);

I think splitting out the strlen(3p)-related changes into a separate
commit might make sense.

Thanks for working on this, quite happy to see that this gets picked up
by the community!

Patrick
