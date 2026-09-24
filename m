Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C723A3911B5
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 06:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790229638; cv=none; b=Fz50x9BtHErnUwqGHEITp4h/STQEDaNH8rQgkd94p2DpG0/6JtfD4GvQBQ7MROhM7o4AIy6CH0XlxH/HLYSslODtvioq5nV+r7ULFjIXEBKMA13gSDzvAdzIvFAptRplzL6mWovitgtuUnwVpc4U8ZsMEEqdBpKxpqeq+Jr2Q80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790229638; c=relaxed/simple;
	bh=xgmZyHH9GErNi9SzRRpmPGUTjxtMynWopyFMFJyZE00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvO+5x5IHd6SxGkFC596lrPq305NSZ+OqFyGEexnBUpYuEyM1R/yRGLjifVhGjE6VPC8tDnyHRTCJIok/KXQe81BEWOtiteZqorLqlyLoHDN+9KYJsZ6V4plfBVX6mO+St2V5ozwPuCP9VQTcLe5etmlalIBWyz2lXAqQyMP/lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=s0aVS1AD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rJFoygDg; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="s0aVS1AD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rJFoygDg"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D4DA11400019;
	Thu, 24 Sep 2026 02:00:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 24 Sep 2026 02:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790229635; x=1790316035; bh=XO1B3nl2vO
	3IHjyDofBtlkX38dPcQyd5bD2jyDFWi0k=; b=s0aVS1ADq89QbAiFVUifbIi4ew
	VDc503G1S/NZW6Z2pLng/LP2E2ArXzQVIzo1vicNEsHSY2HiNOqrPGxy062pcKUU
	KVYtlwVhWdG1yme8sVPivCGd8fT7dXb/2wrc+A2rIRfWbxG/zEYxKlPYkr2sWiic
	4+G9ViPXZa71MuC6BRFurZuo7hh5ePybCcVTjY+b2xV4YLrMQUcSzgABaW773sGI
	GBl6gs8nsX5tIPWg8dr2VwlyRmj7IXxrWRyFGBkS5Z5I4fVrkqVyxHfuOX9Kv+on
	lwW53we3AxObUH44LOca6UW6Xmy1augqD6F1ljVK0I94+xSHNHxRP42oWIQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790229635; x=1790316035; bh=XO1B3nl2vO3IHjyDofBtlkX38dPcQyd5bD2
	jyDFWi0k=; b=rJFoygDg8RdGxSgHbZCOYS6yBTjiImvrpWMMIKRHyxBkMDjVfbi
	eHN6uyhiUDMvyQJNPLq9A2pLGspUOpOiXsbdKO1SUOl5yIn2ozG8MCQVJlxlcdoM
	HzTd/sV35HQDDpoGdxLco/NN4zyg3x4kyaDko+EzlE8rpk+6sfWe+X+2b9Ck/1vK
	1QiwIyXdjyUMe5egxZ0Dj+IccURtN3s21c5s3J7M/814W61lijLXWSODWkcZAMwh
	XMfI9UStnGFy7BYWhZJTBFeFh7LRqCKUtqWLt/z3SVSEl1wh3KCM9e/zRP/Bq8J3
	JWgMIbIqLunybpBmgO/TYSb3HJcN46z8IpA==
X-ME-Sender: <xms:g7y0ah24KM2sGKJAZTOOhkmNZLuzM2k1jWukks6C0i3rJjYX2lBRQg>
    <xme:g7y0auEREKn0lXiBNM0A2JxhhURQ9DznAz6DQ_Q2FIpC00obAGDO5Ml9mphLDfzv9
    LP5Y-bCK4SSIxZ39f3bHSdpQ9uxrXSJ1SJbktxitQ3mF67nZifRTA>
X-ME-Received: <xmr:g7y0avi4nDlPf2AgDOBzRzz8eg4-t1WI93KppLy9nDREjDtjzzc87dtD1e58_dfccoAQth8>
X-ME-Proxy-Cause: dmFkZTEpYAOKg005ANUoly1Rw58+OscmlpSsA+2jGrOO8804eMx5Mrc3D4LpcyD39pSB88
    AvUbIYY5fCKt5pXrGsf/JonoP44OFGwZDrSbFqEP9bEokc0twRIT0sYe0KQ0txRTAm+8Yj
    d1n24wJusLrE6daHk7pklwCAb4GUXw7acfQZmDpZWFELgSfwCOS7dsDm1meJ5w/4H+a3np
    a4lTzr5OqWcJWxpZWUXwCi6OvEfzVS0MN9hDN3O6bAziCP9IKIX1VRxUrZAufXgCsJGenj
    iNTmGu8SgO7djLJ6UrlsEQqvV2d/URYJV2e+9coOj9cKV1svsbBBtycNNxXE+pypyx5Be/
    PmzbsWK3Mqlm7TQvTHc4Lyb3UCAr06MASLdCgTwh/AM9avd0lq/6gG5rUIFVPWpLVEJhPh
    gpzypzRu7B6dM1VfYSF8VcbCd+pZMXXCqdrWKkz4KDQL72ZBZFA0l6tV7WAnnyTRf1HOXG
    Yc8eBgr7WaGYEuWiagRNYgpQz3d5JW3p6Bbwv0RsTegwMD6wZyl9b/QT2qRUkV5OT8RLJ4
    ATUf0cjzmS/6dXIVywLzRGcoHJrr2/ewrLNMlJ/55jWU5/LpIDKkExJpQSrHmCNfMmvNIq
    fOx6r+W9ajM/xN911iBNKEcNSKBIxEOkOghtQ3Ib2Jw+3cuIGo1JOXmT3MMw
X-ME-Proxy: <xmx:g7y0ap_aYxKo7uUwTz2TEpV74ZZi5x_cJyWxy_EXunGO1P3tiAdBbg>
    <xmx:g7y0amptSeFWkTAIOk2kfOhf5RIIAKu6aQEJ6uHd0tWMIINoaVXHag>
    <xmx:g7y0ao-94EvnTdh4S2cjMBRq9OSqc7T_QOPSF9JFO7pKCkcm47_g5Q>
    <xmx:g7y0aqXiZ9ZY4WeyrK04xDs9Ss0iaR9K6_8JqltpBo0Sm2AdE-z7Fg>
    <xmx:g7y0auksfTkZTGVeshQx-J1wf4rT1QttU9SEr95xdxyeBshSacb3wC57>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 02:00:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a7e29c31 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Sep 2026 06:00:34 +0000 (UTC)
Date: Thu, 24 Sep 2026 08:00:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] object-file: lift ODB reprepare out of packfile flush
Message-ID: <arS8f6SShWyc2wrh@pks.im>
References: <cover.1789328612.git.jltobler@gmail.com>
 <cf14416f224f48475dfc9f79d8ec62756b9fdedf.1789328612.git.jltobler@gmail.com>
 <arPQrtYHen3UAvdk@pks.im>
 <arQ8nsUzg9atdCeD@denethor>
 <arS77zUvWKdjEeS-@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arS77zUvWKdjEeS-@pks.im>

On Thu, Sep 24, 2026 at 07:58:07AM +0200, Patrick Steinhardt wrote:
> On Wed, Sep 23, 2026 at 04:04:55PM -0500, Justin Tobler wrote:
> > On 26/09/23 03:16PM, Patrick Steinhardt wrote:
> > > On Sun, Sep 13, 2026 at 03:26:21PM -0500, Justin Tobler wrote:
> > > > diff --git a/object-file.c b/object-file.c
> > > > index a4cbf8b081df..0f123b79fad1 100644
> > > > --- a/object-file.c
> > > > +++ b/object-file.c
> > > > @@ -909,8 +907,10 @@ static int odb_transaction_files_write_object_stream(struct odb_transaction *bas
> > > >  	 * to zlib compression and is sufficient for this check.
> > > >  	 */
> > > >  	if (state->nr_written && pack_size_limit_cfg &&
> > > > -	    pack_size_limit_cfg < state->offset + stream->size)
> > > > +	    pack_size_limit_cfg < state->offset + stream->size) {
> > > >  		flush_packfile_transaction(transaction);
> > > > +		odb_reprepare(transaction->base.source->odb);
> > > > +	}
> > > >  
> > > >  	CALLOC_ARRAY(idx, 1);
> > > >  	prepare_packfile_transaction(transaction);
> > > > @@ -1260,6 +1260,7 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
> > > >  {
> > > >  	struct odb_transaction_files *transaction =
> > > >  		container_of(base, struct odb_transaction_files, base);
> > > > +	int have_packfile = !!transaction->packfile.f;
> > > >  
> > > >  	if (transaction->objdir) {
> > > >  		struct strbuf temp_path = STRBUF_INIT;
> > > > @@ -1293,6 +1294,9 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
> > > >  
> > > >  	flush_packfile_transaction(transaction);
> > > >  
> > > > +	if (have_packfile)
> > > > +		odb_reprepare(transaction->base.source->odb);
> > > > +
> > > >  	return 0;
> > > >  }
> > > 
> > > One thing that I'm curious about: we don't have any error checking for
> > > flushing the object directory at alll. So there is actually a change in
> > > behaviour here, where we now also reprepare in case flushing has failed.
> > > It probably doesn't matter much, but it does raise the question whether
> > > we may want to start checking for errors.
> > 
> > Regarding the behavior change, I'm not entirely sure I follow.
> > `flush_packfile_transaction()` only returns early in the case where
> > there is nothing to flush. In both of the above call sites,
> > `odb_reprepare()` is only invoked in the same circumstance.
> 
> There's a second early return when `tmp_objdir_migrate()` fails, and
> that early return causes us to not flush.

Oh, never mind. I think I've been confusing the fact that what you're
changing is actually `odb_transaction_files_commit()` itself, and that
early return of course still exists in there. So this looks good to me.

Patrick
