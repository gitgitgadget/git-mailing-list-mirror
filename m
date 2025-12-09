Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA85221554
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 07:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765264912; cv=none; b=cAPaavCCrGudyZNLcntZNJ5Yhr/Y6Yk56wp/fhJmMgaPo0uo+jlunA+l2Q8MeFHR3e8CPfKCoKHH4LGHTrZk9LQE/rhF4GuHgVoo3MLIX5Cm7JcZTNrs7gdA/rixqSUXSspUMnJXpVXYdzDGvnWsmrOq+Pezlz50esZe6PWf3Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765264912; c=relaxed/simple;
	bh=ESfLThJvn7ZurAeTZQ5qghRJEEc4RerxO48EKEZlhOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAEVPNMgvyrmt9OyJe7YDytsJXMHU2f4IvJMKdveDn0MTJN7JYbotpV7wKQ+KHdZ5R0P/0XF6A1OhMvwS7NTNMXsD8Zxt82qTaCvxZwDa2Ipg8tUMdB+VZOiBnbTZIpZyTlPuDaqL54rAnXlRx9Wx0f+VLRUeCGnicyQ8ta97us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OWmdRcse; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PYZJy7C2; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OWmdRcse";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PYZJy7C2"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A0AEE1400085;
	Tue,  9 Dec 2025 02:21:48 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 09 Dec 2025 02:21:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765264908; x=1765351308; bh=lNsroyvQgx
	JXw2dMwc+r7OgQfZadof+1OymLPKxtiZg=; b=OWmdRcse4BoRlzoPMU9chFKcMg
	LNeeGvtlnyeTs8qraxK/2IOC6Xt48Yhk550p1ycVr6gUcqg6DyZz4dg8qO9pQkf6
	tjqRxZdUzjee0CLU7jE841JH5vyaayAAD1WvdaBXENPw1u4rpu4YBYehoTdJXFFQ
	rZWB0clWELcRp0eR7exIB0dnOlgCE9aEQt9zRD6B4JDeH9VYZJk5S1bhsSnE3AEX
	3tx+v8pLEvqvOL8aozwEOyAkwCMu32wK9+ITohRf8lZw4mOJc7k3LlZ83jjib535
	xU5U6y4Lwr10FD/5CbH0aN6GAfOI4qz2UJUsCcugYFHiHmqaPOGuSixCO+mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765264908; x=1765351308; bh=lNsroyvQgxJXw2dMwc+r7OgQfZadof+1Oym
	LPKxtiZg=; b=PYZJy7C2XY3jV4xvD6NdquFnOYI2diH1Njq0pP4bsiEdURojKyi
	fZhQGAqRvsPyIQKUQCANSvTcIHlHSAPrb1zN0t/8kur5S9xF4uxtUYPKfDJtFRpi
	aqUiyx8K7SJsiP8xOToVHMX72CLDZcFQzn7/1qXPPUsebGQpw6cQ/nnhYXuhJOTr
	j3ra/UwpALwrB7NSPSbMpz4wxTGXVoAd+z/8Z9y2bmhkwAPKAutWCjlZuP2zwHXz
	byD1tG+qCbTlGVv1THcIg8jKbP3GuRAz6HJH9RnZX/UcrPkYZDljyoWSUnhUoCqP
	y6S8736hOI3HvErmMd7lhKgSR5tkNqorUNg==
X-ME-Sender: <xms:DM43acFJsRxK-wKdYTDUMA9B7JSOxBhiuVnKiQVlkB2AVEYCsz7ZHg>
    <xme:DM43acOz2PZxdOq6Zv77FklDqlrK3NxrCm7ynILcx63xt-ONcTat6Qbw2O8dM1AYd
    rUh9_LfZJFvCSwgirKLKO8EHlOnTC7D3K9wCl6errnc4aWqJgAzRA>
X-ME-Received: <xmr:DM43aedOnEBQUgKl0LcigkIZQUVb1AejM9MnMmgvxIYCwf28ROJB-OZEGw9tChlVB20gfHgrXyPHoSUraQAGZS-Q-1wdeS365a6hTtnJxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohep
    nhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:DM43aZtMBoYkvAMKu7no7jicyd3rOVpn6OqGUKDAK1TD1IqREEiqRw>
    <xmx:DM43afmce_cH9vOR8iMX0KaIuEqX88POeY8LgAgWmwUhuFfw-r8_kw>
    <xmx:DM43abzlMRaAuvLMA_2cngFrtaHIhKNVQgCVQWrtKvCN3YWYrQE8YA>
    <xmx:DM43aRMBL28YI9hNFgl42E_kjBEZYPEu-FaYoetunWAPXbJ3pgddZQ>
    <xmx:DM43aWPI1Iq-4gqJOUgV-E2CmC9r2tOrdFcwy06rebm259Vlapzox0Qv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Dec 2025 02:21:47 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f96e3bd9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Dec 2025 07:21:46 +0000 (UTC)
Date: Tue, 9 Dec 2025 08:21:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 17/17] midx: enable reachability bitmaps during MIDX
 compaction
Message-ID: <aTfOBz3ElQYi6j8i@pks.im>
References: <cover.1765053054.git.me@ttaylorr.com>
 <d6a4e6b69552d8626e6df2d7cd042b9fe151914a.1765053054.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6a4e6b69552d8626e6df2d7cd042b9fe151914a.1765053054.git.me@ttaylorr.com>

On Sat, Dec 06, 2025 at 03:31:50PM -0500, Taylor Blau wrote:
> Enable callers to generate reachability bitmaps when performing MIDX
> layer compaction by combining all existing bitmaps from the compacted
> layers.
> 
> Note that the because of the object/pack ordering described by the

s/that the because/that because/

> previous commit, the pseudo-pack order for the compacted MIDX is the
> same as concatenating the individual pseudo-pack orderings for each
> layer in the compaction range.
> 
> As a result, the only non-test or documentation change necessary is to
> treat all objects as non-preferred during compaction so as not to
> disturb the object ordering.
> 
> In the future, we may want to adjust which commit(s) receive
> reachability bitmaps when compacting multiple .bitmap files into one, or
> even generate new bitmaps (e.g., if the references have moved
> significantly since the .bitmap was generated). This commit only
> implements combining all existing bitmaps in range together in order to
> demonstrate and lay the groundwork for more exotic strategies.

Will there also be a follow-up patch series that introduces geometric
repacking for multi-pack indices?

> @@ -216,6 +216,8 @@ static int cmd_multi_pack_index_compact(int argc, const char **argv,
>  
>  	struct option *options;
>  	static struct option builtin_multi_pack_index_compact_options[] = {
> +		OPT_BIT(0, "bitmap", &opts.flags, N_("write multi-pack bitmap"),
> +			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
>  		OPT_BIT(0, "incremental", &opts.flags,
>  			N_("write a new incremental MIDX"), MIDX_WRITE_INCREMENTAL),
>  		OPT_END(),

Is this new flag actually incompatible with the incremental flag like
you claimed in the preceding commit? I had the impression that it should
be possible to write incremental bitmaps now.

If that's not the case, we should probably have a call to
`die_for_imcopatible_opt2()` somewhere.

Patrick
