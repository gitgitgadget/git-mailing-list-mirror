Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A3136654C
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771612825; cv=none; b=fpIj48AmDyRWPVl4IeScw1PeKdHfq8e9s0iTw9uPj7ue8LBt8NsU1Tutfoa3xCNm+b+Diq/obr0isrk1CSF7FSCZnmUxX5kjEVgcoEejXk/yacSpSEjXNjYBoyg/LsP9CxVLnaDK/8qer+eAMJDrphep+YLAAYCQ88/RAUzHvuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771612825; c=relaxed/simple;
	bh=RNER8iaXQzd3DxsszRtVxcFGFDknua1K1AdztseTxnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvurbLIL/JlGEKLfnw7d/krmJgbf6MDa8beoGeuBH0hghIOvjn7NCOZHlKhEncC37h22i9HyEVjmscy4GdzpECEX4/XbWUCno6PJQT4SQcZn1pIi/dxzA9itzzm/YaHSiOQ5gXarxGC/fZNnYc6LjjijA1rlrdFcjPRGEV5FEo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o71WhMo3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CkuLepJ8; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o71WhMo3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CkuLepJ8"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id B1047EC05AC;
	Fri, 20 Feb 2026 13:40:22 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 20 Feb 2026 13:40:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771612822; x=1771699222; bh=NhYmGXZLT4
	Vl81ZlkUNzOooOC6tdf1nSp4gBKAvBlA8=; b=o71WhMo3wzt5pgsZXMwQ8zZkTT
	pt1eYyxOAbsPPael6hvONs06pP2DCoZsOdd0ukbF6mEsbF0P1VGmuAucgRnMKprr
	P3qm0dqdACu5cFJ0Xva8rKrhEWqx5K6IIIqshxifco89DO8n1l+jRGZF6JtieHMX
	LRt0zekyYYJ4gJZJVVgnUpt+Wy32h6Gb4H57kHszGkM+8i5rBbdcQGVr3clcJSOE
	ymJAKnrITGAp5usObm8cBS6N9N9nxPgrP7uCuyVri1NLRGZ2ek9jgTfSylX59Lgc
	iqlyaAT6MJqEgj/KxqunYYBXhzP0a31OPgwZfelZac/GJ2wWqvY1w69/k5rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771612822; x=1771699222; bh=NhYmGXZLT4Vl81ZlkUNzOooOC6tdf1nSp4g
	BKAvBlA8=; b=CkuLepJ8mL6yxoBdk0IeSxks+UIhrLxOX0ce8oTv188tLRnx5Zi
	Eo3pdRrEtQah38MU4Y9htL8HkwN4d3O6hIXMOZyRzd7dnW7gMr7CTEGsUnjVHruu
	ednhJ7SibDi0GdxYOw5xGdpiLiYYoEASrDf4F4QRmRe0eZO+hijWfIgtm34+Iy7+
	W6H3jXjKKRdruvLM3ABQ/wRU4s3FVNTq0EulhC3dY2HJfO6YmqwNiv1eEwu/ne16
	J5L+usRzCuxivP0rkBzgRlu1ZW0N7XZ5T1f1gB1wq2l7AM7R80BEwwbRXfS8MLDx
	oAs4W6fMiwNyCrdVrdljAvS16J7iC4rDiEQ==
X-ME-Sender: <xms:lqqYaSUOTt3YyOo_r7svv6TDAVP1BnjI1Zj2tNcX_BGje6X5HBl0Qw>
    <xme:lqqYaQ1I23k7ewRPRrQ57H9NMB6S3mdAhSyeNRoq96d-5Xpd3pZmSCUfdYV3KzpKM
    ezwlqLdEVA8fbTjK1ovyhGsMc21HvBLfIfZgCO44pTwSuuba4IhPQ>
X-ME-Received: <xmr:lqqYaYo3WYL0jQsZeHg0DrRysHr6OyYGdwVeeQ03C4lmm15Lhs8_L7WJj9tWLo5HQ3DRCBwQEdi5b6GftPXx7kad25sIQcVjd3RIySUYjiel>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeludekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtoh
    epshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepkhhrihhs
    thhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoh
    epvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:lqqYafUPyhWQ-z9yfoTYP_FQtpVonX1-3gWc6ag5Ok31XL4sB0NcWw>
    <xmx:lqqYaba970QFcXd9boGaVzqMcoUP-bXjxbZi8F1duOGlsJ3_RWJ5zQ>
    <xmx:lqqYaUeqmsihukIw-is9FkM2N6D8xPLIQdjlALPgD5o_RS2m8w9cyA>
    <xmx:lqqYad2lJF4aCMvpIXyAsW12-hHEEZBRtIO8gngqJvvZrUQQ0GiYcg>
    <xmx:lqqYaZog3XNKODBNiqzcMF125NKjTUJqbu8NhbKPxsX8r4udBupEG1da>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 13:40:20 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a110f372 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 18:40:17 +0000 (UTC)
Date: Fri, 20 Feb 2026 19:40:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 5/8] hook: allow disabling config hooks
Message-ID: <aZiqkB61YXCAKEWE@pks.im>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-6-adrian.ratiu@collabora.com>
 <aZhXom2cD8juWYs4@pks.im>
 <87qzqfwjym.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87qzqfwjym.fsf@collabora.com>

On Fri, Feb 20, 2026 at 04:47:13PM +0200, Adrian Ratiu wrote:
> On Fri, 20 Feb 2026, Patrick Steinhardt <ps@pks.im> wrote:
> > On Thu, Feb 19, 2026 at 12:23:49AM +0200, Adrian Ratiu wrote:
> >> diff --git a/hook.c b/hook.c
> >> index 8a9b405f76..35c24bf33d 100644
> >> --- a/hook.c
> >> +++ b/hook.c
> >> @@ -164,6 +164,21 @@ static int hook_config_lookup_all(const char *key, const char *value,
> >>  		char *old = strmap_put(&data->commands, hook_name,
> >>  				       xstrdup(value));
> >>  		free(old);
> >> +	} else if (!strcmp(subkey, "enabled")) {
> >> +		switch (git_parse_maybe_bool(value)) {
> >> +		case 0: /* disabled */
> >> +			if (!unsorted_string_list_lookup(&data->disabled_hooks,
> >> +							 hook_name))
> >> +				string_list_append(&data->disabled_hooks,
> >> +						   hook_name);
> >> +			break;
> >> +		case 1: /* enabled: undo a prior disabled entry */
> >> +			unsorted_string_list_remove(&data->disabled_hooks,
> >> +						    hook_name);
> >> +			break;
> >> +		default:
> >> +			break; /* ignore unrecognised values */
> >> +		}
> >>  	}
> >
> > Somewhat similar to my preceding questions: why don't we store the
> > enabled state in the `struct hook` structure itself? Like that we can
> > for example even list disabled hooks in `git hooks list --disabled`, if
> > we ever wanted to do something like that.
> 
> The answer to the preceeding question is unfortunately no (I tried it),
> however the answer to this question is YES.
> 
> I took the design decision to "filter" disabled hooks at config parsing
> time, however I had no idea when doing it that we might want to run
> something like "git hooks list --disabled".
> 
> I'll change this in v3 and cache the disabled config state instead of
> filtering out disabled hooks completely.
> 
> This way we could still use their information as you suggested and we
> could even enable/disable config hooks via git commands, however that is
> yet-another-new-feature and this series is big enough and should be just
> focused on adding the "base" functionality.
> 
> So in v3 I will cache the disabled state add the `git hooks list
> --disabled` feature as well, but stop there. :)

Note that the "--disabled" flag was just a way to explain why I think
it's useful to track the disabled state explicitly. I didn't mean to say
that it needs to be added :)

Patrick
