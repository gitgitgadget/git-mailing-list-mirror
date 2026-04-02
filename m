Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD96373C0B
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 05:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775108704; cv=none; b=Cx8JEiwnqE0mdkSFUXJamqXIbIP7CGh+RlzFLWvj2ZlnUUS9zmSAvrjKyDRfNpzPLFuW2zG0gXS2oYEm06LPQl9jTt2BUIBy7LvEAzXDxXEnsQAOCRG+7b/43WHHpExQlHt2XOHlYo2Q2JOaV4oetyuDi7aEo5hv84BdjeDek0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775108704; c=relaxed/simple;
	bh=sGhV9WGDx26oD+W8UWuxWNEDsA0BjAeFYxC2LSXBtoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSOxVCQETjC4nEDsMa23hT/aBRbDYDM3kCidAlKO83dlTyoeXJF+qyk0dy3O4z6sAPQAyG9yfGlwn+/UEnNMJhK9RJ1v7JGwF3zJD3tC/sJQ0cI0RwshY/YxuS4xY5PAa8wPPMncYJm8Wzd6wJxQnWQV6FHp4ElZ0Jy/bz0FNN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kjP5ww7F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uue0fzCh; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kjP5ww7F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uue0fzCh"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id A834A1D003A7;
	Thu,  2 Apr 2026 01:45:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 02 Apr 2026 01:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775108700;
	 x=1775195100; bh=FEaLthZ8Xe+0SxUcOe/xXfEdWA6JAx0uLh9Lv64gDB8=; b=
	kjP5ww7FQvuWIr5gBDb6KWLwpPxuvGgs3MB++9J0kwvmz9DZ57FO8zNebsGrBpv+
	r6nFOlLmZ2Tfsdtg4rtc/x1/4WYStYv5/MUJQFW/LRn27jGRrXUwHuJz3QzwXRsJ
	ZVbNFljiqLFFXjmIqx0nVGNiHfr/P5XjbT9jNxRfGMbkRxP1/48xFIPTUmDrQL+N
	14A9wyWYgXKj9o8JRXRl7JSTKcWw2CrIZ9cRMgA6uewPHkY3EpzNx8NzF4++5FFV
	dYGGrnSlK6c7FcVTTOyLqY1tHl5IoQyAX8MqYsOCZ332LV51Rlj7BQM/964n6Deb
	Z1x6VP0JP9rEcuzRXb/4Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775108700; x=
	1775195100; bh=FEaLthZ8Xe+0SxUcOe/xXfEdWA6JAx0uLh9Lv64gDB8=; b=u
	ue0fzChsNrwcZ+yu8PDcsKxQJyN/qyPuy9DkS+ibkm3nBXHx7ty/VPsCXSCz7BAM
	C9lGvbryLR9yWJR26lrTuYMHY+3tk+VIMJ7bkQo+X6hcXSxtZJFooCPpqwvXaMzr
	eDzIVPybRAPAWOjdCFVKTip/HrP5PTDcXhXv5AOLz2Ye8FNa5cMPYUf+OHbn/eug
	m+7zhRPVtJI3RuiBK2AugamrFrPT0+5YtZ7cDiECSmm3iwpUX9nWpRhsclMJf3mq
	K5CR3tjRYb/41s9VnoCupKI8ba9CIO9UOIXWna6g65blAshFIaI3WfZBXKMAQBsz
	vqk/8HRE/lrL04ohzLomQ==
X-ME-Sender: <xms:WwLOaTYCC6IeyMDRT6DcyngsZIsdJ6r-vjca1DMgbUgQC6rnOkjedg>
    <xme:WwLOaSj2BcspiFfejFxowjZxVjiy5GWjSnhn8FELq9YNtC98GPt8upB9VdV_iME3j
    2dZuqJH9ASIdtf46Wnlla31O1A719TqdOqe5ACXAd-zwwX9BUzRoA>
X-ME-Received: <xmr:WwLOad7IZNfMYgkzp67Y0DQSpaQZjxPdw1-jkl7l4Zofkayhm723GOGRgNrSOhIWWJTxGwvRdoub56FyyYf81F8xWwoWPmH_02XEYd4jIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    elveegvddtjeetgfetfedvkeeiffelhfegudekffevfedthfevuefhgeefudevffenucff
    ohhmrghinhepvgigrghmphhlvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshh
    hinhgvtghordgtohhmpdhrtghpthhtohephhgvrhgsvghrthesghhonhguohhrrdgrphgr
    nhgrrdhorhhgrdgruhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:WwLOaR67N1a27RxLSAG9bUxWV2V75N1SJmxLYdBChu8fGwPQg5InSA>
    <xmx:WwLOaZetablnNXhxgKdaYVaJqGTTRVJOeb9bQnDCdeSKkvUfUj610A>
    <xmx:WwLOaVChSLawT-wRp1-QW5TjmEGA1MqHZBgEkzhGkxnjYk3FU0MxJw>
    <xmx:WwLOac_E26CGlMztErohj1Nlxw401tQVnnBjcoIpSeRU0pSBY-lkJw>
    <xmx:XALOaRow0bFgm0uQlwj_KTA38il5BtBoaOyz7ZUtmYUsJEG3rkh1Exys>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 01:44:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7d5e08e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Apr 2026 05:44:56 +0000 (UTC)
Date: Thu, 2 Apr 2026 07:44:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 1/2] t: work around multibyte bug in quoted heredocs with
 Dash v0.5.13
Message-ID: <ac4CVegAlxdf0zHq@pks.im>
References: <20260401-pks-tests-with-dash-v1-0-d70b5040aa5d@pks.im>
 <20260401-pks-tests-with-dash-v1-1-d70b5040aa5d@pks.im>
 <CAPig+cQHUk5abmc+CeJ0tPWs5z7XMq9AxHKZRdvEgULF4zTg0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cQHUk5abmc+CeJ0tPWs5z7XMq9AxHKZRdvEgULF4zTg0g@mail.gmail.com>

On Wed, Apr 01, 2026 at 12:21:41PM -0400, Eric Sunshine wrote:
> On Wed, Apr 1, 2026 at 6:59 AM Patrick Steinhardt <ps@pks.im> wrote:
> > When executing our test suite with Dash v0.5.13.2 one can observe
> > several test failures that all have the same symptoms: we have a quoted
> > heredoc that contains multibyte characters, but the final data does not
> > match what we actually wanted to write. One such example is in t0300,
> > where we see the diffs like the following:
> > [...]
> > For now, work around the bug by using unquoted heredocs instead.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
> > @@ -675,7 +675,7 @@ test_expect_success 'match percent-encoded values' '
> >  test_expect_success 'match percent-encoded UTF-8 values in path' '
> >         test_config credential.https://example.com.useHttpPath true &&
> >         test_config credential.https://example.com/perú.git.helper "$HELPER" &&
> > -       check fill <<-\EOF
> > +       check fill <<-EOF
> >         url=https://example.com/per%C3%BA.git
> 
> Oof, this is the sort of change which cries out for an in-code
> comment, since we can't expect that future reviewers will remember
> this specific workaround in this specific script, and we can't expect
> that people working on this code will think to check the history to
> learn why the heredoc is unquoted. Without such a comment, someone
> working on this file for some purpose or another (or even a GSoC
> applicant looking for a microproject) will come along and "modernize"
> this script by adding back the heredoc quoting which this patch
> removes.
> 
> To prevent someone from "breaking" your "fix", at minimum, please add
> an explanatory comment somewhere near the top of the script which
> pretty much duplicates the information from the commit message:
> 
>     # *DONTQUOTE*: ...explanation of dash bug ...
> 
> and reference that comment at each location you "fix":
> 
>     # NOTE: Don't quote heredoc; see *DONTQUOTE* above.
>     check fill <<-EOF
>     ...

True indeed. I'll just add a short comment to the individual callsites.
Thanks!

Patrick
