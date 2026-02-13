Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7BB26056D
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 05:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770961887; cv=none; b=TomBdV728HrN/foS3LkpOzQJ8qn1oFu43FwPJ6ljwagbTDbNGOgPKMpmoJo9LsGN1O5ox9MooLm+6ERDd6YV3lFm6+vZgMmHly2JXVsYrXvEIizU4v2A4iNnGMtYIWiQZfjtpxG82WK5BMrrA8KVpTk/fg97bNowMHxP516crhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770961887; c=relaxed/simple;
	bh=lsReF5Qf3VVVyi7/BjFeVTaYO7V8f5h0I5jqq57uJ2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDMDjznmT3XhObszKabEdapWCdkLmDPvWCd0YIMAalAqVoWHkO5dc9pmZskZeHP+ofp2JNY+aYRNL9g82xSyjT22IJaaxv1qoIigmPazknsGWgMAkmp90cfQD6QNRCzp/+I/926xriUNT3vFJMZG3vLm6JlW62tJy9JWLOr08RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NwO0chls; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W+fKVCIg; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NwO0chls";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W+fKVCIg"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5AA097A01B1;
	Fri, 13 Feb 2026 00:51:25 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 13 Feb 2026 00:51:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770961885;
	 x=1771048285; bh=5Pl6ERYLAtc1xgiEgMlpjla6EtRB4JW7fhU2Hfd4UnA=; b=
	NwO0chlsLSgE2L6E25bn4J8J/rUXfwrYCfyjRpG8oXPJdkSlrq3Y3MpJjM2Zsuyb
	nR293Romi6ojf7PSIhZ3eA+cyLfJ7VdnC9miqhXmV6iMScdbLpnUTfjS8Mf17XiS
	GK7qQXQGJ7/gCVzTdQPg1gf23qsA364TD3AJ/7ANRadmK/OCZJ1Mq/M0qoSmfoQb
	UCAf/wCxUtBLCOKXdEprzpkyQrB6Pw267uxbD34D/7qZrzi9l/Prahk21U7EwsP0
	nknVHKmZEHUf2OiloiW5F2j0u61gQD90WwBU2FHRF5/P6TVBanmf++gcWOBejFvP
	ECkYmvXGor9jTVdr18lOgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770961885; x=
	1771048285; bh=5Pl6ERYLAtc1xgiEgMlpjla6EtRB4JW7fhU2Hfd4UnA=; b=W
	+fKVCIgJehp9TXNis+xfj2COKAIYcl+XHtIE18eW0Z9cj2KWjJ5mNVo3mMs3yVzy
	ExMzfGTbwzmv2JJzBSoTEwYoQvPNkaHpTsam2Dy/P/U1QyVuB4UMwGXW+9nn1i7d
	eO8kL/hRIn9nT/UNrrGNxCQ0UP4WD8LQwb39rk/tb+Gsjk7yw3Eyfwibx+nN/h6Q
	0XF9tcMZyyCMcNZa9Tp9FjVsy9gmsKjoqzvnaWxxQ8sUs8KgEqxwbd2C6nVU2Wo1
	3GlTE3kz2b04qBvAUjOcORj2exLx74hdTDBEHivnSpMh38sKBgXmwVxmA4f05LRP
	/+n0R6K/L0m9U0nm2u/eQ==
X-ME-Sender: <xms:3buOaccsEHepDdPLeeXs6FH1iFqWv_rq9ac-6dNLPsdmRYyMR8km9g>
    <xme:3buOaVrSY8Wg5jBmHrPXiUI9Qwy5XdeZl58hDqmX0CbnoZGgFBKY5h095CUDo29P8
    NcTR9iscGUKEZEQaJsh3Dlpy22atixlU5ZjwXrjVFA4xidYAckL6w>
X-ME-Received: <xmr:3buOaa508-Uyxkbzdatcgm3d878FNcW6SS2arEWbKuLOaap9QVz5NcKokUN53yjn0uyGOPBYYVaHgpeOBi4wgZKbzGEaP45ohl-bgxEfxwP0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdejgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnoh
    gslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:3buOabqFrwAFqMHgr6kh82TdhtfUFpnIg1BIBT2SeizctEPuCJz2Vg>
    <xmx:3buOaciHuvqGQZR-3WapSpqQk5YTiduCQ5gPfbckZkqG5Zh9s1jNXw>
    <xmx:3buOaVIBW_7eCCtxc4DUGYNwbydNQvhZSV-mteQsF-v7qF8rqQmGpA>
    <xmx:3buOacBFWtEYPSPTM5_mQf7MWOMuvNvHEw0VtnuYv9wpH02PZbOpgA>
    <xmx:3buOaRoxFA2xAptN-_4hqJleex_bRoYcrwPiIGNirEpoAOwCKcTmLr7W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 00:51:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ad8e82df (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Feb 2026 05:51:23 +0000 (UTC)
Date: Fri, 13 Feb 2026 06:51:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/4] builtin/history: check for merges before asking for
 user input
Message-ID: <aY672KjOwxyTFJli@pks.im>
References: <20260212-b4-pks-history-dry-run-v1-0-1ce03d631c1b@pks.im>
 <20260212-b4-pks-history-dry-run-v1-2-1ce03d631c1b@pks.im>
 <CALnO6CCciWF_GOd3WqOVwUDLoPRABNgDWbSu7FTgP8KLWQKvgQ@mail.gmail.com>
 <xmqq7bshmwd5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq7bshmwd5.fsf@gitster.g>

On Thu, Feb 12, 2026 at 02:26:46PM -0800, Junio C Hamano wrote:
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
> > On Thu, Feb 12, 2026 at 7:45 AM Patrick Steinhardt <ps@pks.im> wrote:
> >> diff --git a/builtin/history.c b/builtin/history.c
> >> index 1de51372ea..ca0cdb6a58 100644
> >> --- a/builtin/history.c
> >> +++ b/builtin/history.c
> >> @@ -177,6 +177,42 @@ static int parse_ref_action(const struct option *opt, const char *value, int uns
> >>         return 0;
> >>  }
> >>
> >> +static int revwalk_contains_merges(struct repository *repo,
> >> +                                  const struct strvec *revwalk_args)
> >> +{
> >> +       struct strvec args = STRVEC_INIT;
> >> +       struct rev_info revs;
> >> +       int ret;
> >> +
> >> +       for (size_t i = 0; i < revwalk_args->nr; i++)
> >> +               strvec_push(&args, revwalk_args->v[i]);
> >
> > I'm surprised we don't have anything like Rust's Vec::append or
> > Vec::extend_from_slice
> 
> strvec_pushv() is what you are looking for.

Ah, indeed, will use.

Patrick
