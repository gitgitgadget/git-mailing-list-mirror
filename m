Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E6B2F3C07
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 06:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960974; cv=none; b=oHgLIw20AVuiWy6WsOmWOZe1zugeqeqVsH2ZCVM89wyGyRpHM7BBUlIFG5vySGoPe8tLkxqbRmLur4t7aMFzrfbVDTBrQlETxSVmXCI8qbYSKk83Dw4bA+SLcIORyQPd2EGQPIMoVW36JNsJVPBfoWSO72ssU7XoPrKxz/cAas0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960974; c=relaxed/simple;
	bh=NA2/5lNEDm0TwsSukgBs0qzpBsnxibbW7d+TH9CQA4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLwBhJaFjff/ofOYMWOkfw8s1bosA1cUYlT5+PblmNPq6IOTrLwYQRp6uCUgxWuFfgJ4UADcd1tI6GOo1gx9dRmJQ4spv/b/AfkChpDKMTMaYPMPpi8ZGXkPBnP3rF0p/NxJfObvhOEpPAZh0LTg1/VblGJf5aHtT4elFyFHRJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DCP+Jvsa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cVPCRRSI; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DCP+Jvsa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cVPCRRSI"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 632CDEC02A8
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 02:56:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 14 Oct 2026 02:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791960972; x=1792047372; bh=mNypEhWCGC
	kE8fM4B762Nat1iFRRvczd8Rjrtn+E4No=; b=DCP+JvsakZr12y7tporkz+FRBj
	j55Hk7IsOGzfWfAQYiV6MDVioPPVeUqhvixl49SjSZ3vfOf4gq+QKQTddxP0WREe
	DixS5GiwNhoRePm40hlT1lnUmWMNdR4w8xYkRg5JYA4CwZyFqQeuGClI+EcK2d8U
	DClcXj+yu1sa5wAlDZ2c6eZLXNafpmhINhma/BY2qxd68CsMkUKDlp4pmX2cUq7I
	1LDCzzKLmIBk6jcgV1vXnPYtr0It6Akt6BONGzqHM08Qtt86e9YoOOdQKpYv7uar
	NJIl0iVv9dauV7IkE7A/A6zYHnH+6DcjkUNdb6he0dUhMCcOrBTeKfv1N8VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791960972; x=1792047372; bh=mNypEhWCGCkE8fM4B762Nat1iFRRvczd8Rj
	rtn+E4No=; b=cVPCRRSItyMODWTqU88WYtb7vQVEiyqfPEfC/MPRQwu1NDI69ul
	71rK0Zgtc9fP7WtXoxom7Eeg+H3efj6MGZtbJDbH47f5G5wrcMcmXdDe0FFYTLol
	A9w1byfSl9OFLtrsMh234rhX5srya8HBNpP2DSkW3L89hWP93BwQ5w6Rqboyod3l
	JoTDqfrwYYbDGn8txSW6dK3j/cwKLpr83jV2qxvL84UYfCFInR8mUGkoz7KiETIQ
	Aa5OVHpUH9bmxvlFvRbBTSI22we6LCR1GgcF3+OM6bW4btNQcVWNTPfK2KYcCL/M
	XUAvOlLmfC5ZkYFDXg2rA7EFf3m9ERqCCxg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791960972; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:aw0hvxg2SiUwwqinFZviMR59RhWp0wG2y01hYp6tU40bHfI
	NEqW23r1CHqYLilxc5yiWuni7N1anFP6PR3RDfJK8bqutGFvodPQ/FAZrp2EbvIC
	eMVs63sn3jLB6rfgGrPoMSVTGxi9kW7WeQPX2ghDL2btRdSf6Fl3g7fb5ayrH7GO
	4LwoLC8kBX3+NfRsrG4vjUgzQSd1Mf/oAu6lEbTsGL7YRO9yay9QZ7+vfwUacoix
	YyaC04ZJ9Vw1txyu1tH4PKL7mhHU8Mf7ArRCq+MLiviqjrPAA89/8I9SFTScE6cz
	PLPRMnOiYs6gf+fpEXYePHVMVE8vKlcmFtQnQ/w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:8QOyi/mj5hFPpx/Whg2zwJBY5FpGO3sBS3nTkoxdFvE=:NA2/5lNEDm0TwsSukgBs0qzpBsnxibbW7d+TH9CQA4s=;
X-ME-Sender: <xms:jCfPaqsbvX7JXsfwG5zAw3HQPhFS5Fx01SSVvbWxz8ojo281dwPikQ>
    <xme:jCfPamcqMwxFAUKAkhxCh01pmtvE5yhcgCFIT8Oqlq1Ccw_GE0L_TADZMSx_gdg52
    53elFyldnDGYtupm7YKMVynDzbHe_pnCaOjHyHQ3Rst6PygvVFCp4o>
X-ME-Received: <xmr:jCfPaqylvwBKWbVn7yPCfzEm19q6uis5jzdhx0GJFDcy7BI2rN7r8g>
X-ME-Proxy-Cause: dmFkZTE/tqtsUSDqKQa8vgx0QAsTIKfZAtsgsHBm2GZyCMJZ85XBkTiO7gP7VxUFGE16ts
    QOrgNaZk+66U+iiPrKU4idouZwPlI0YudBbYklk9HT1x7EpGWkkZzIaSi5QpHVjyrR+bdk
    +ySpk0IlCmhFX7nBgH0hT9Do3s0FtEtXL2Jjxc0NHkx3qrTDXaEB7La8c+ALtSIqJuvW88
    csroneVcZfvFatNwRpct+u79/3v9SLRS8iMhhSh8f4ZEjH4yIoTr7hOTdQtTWXzmCsFrsj
    qz40wcdjb8cOUAQr1qnK3szGw0KSxThAQS8oEyARb/V1PmhP+V7SjYAKuldW7N5IbDn5CY
    L9VsVkVVIuDPfeAjIu4roQ61vrqEEqSZvtkFdDStFHD/9YnrwnBgx0ndoud7bEqTLcRSLn
    g6B+XqmFiBUhsrMhyprgooymePJv/ztI8w9iCSL0jxbx88POCxpj1tJLJW+FcfSvAfclX+
    BrsjPfLxw0hKFZKuNRl+W+upQdjJn6ux8CMStWII2UklHvFhqzle6KyHmDZj2N45PWhZbt
    RQti2kTGAmL2ZrlBUi0JcJFZnhAMIJu7vHw+iljeQjruWreayKgoch5c5FEpJy6abATVx4
    3lRV13WPSODsYn6mNvbayUrxyyxGvLF6yDIG5K+2teR02KdV9WBFL2rm4jOA
X-ME-Proxy: <xmx:jCfPakEgIjzXzx3s3zbJGupYHLTZkTxcHXLOS3Y7Jr5cq1_ZsTQ-wA>
    <xmx:jCfPamxXrwqkKSsEntmRXKXcfgTpvoZMZkCzeRAJwtfDy8zQTmRIoA>
    <xmx:jCfPatuOWaNT0lcMMTCoUY_QmFh233jQHa_fhHh5i4tP95gMpEGQQg>
    <xmx:jCfPar2oSScCA7aRwwA4LXjb6pnH62siJmfzLbNZ3ac0yUheg26Fhg>
    <xmx:jCfPajoM3AFTT8HFp3-pQDrKETzvPEhbKIRhr9bskfqnysQ_DCv-0upP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 02:56:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 15a4259a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Oct 2026 06:56:10 +0000 (UTC)
Date: Wed, 14 Oct 2026 08:56:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wolfgang Kritzinger <wkritzinger@atlassian.com>
Subject: Re: [PATCH 4/5] odb: remove read loop for found objects
Message-ID: <as8niG1LrNqxfRzV@pks.im>
References: <20261013-pks-odb-files-alternates-cleanups-v1-0-b7030ff2b26f@pks.im>
 <20261013-pks-odb-files-alternates-cleanups-v1-4-b7030ff2b26f@pks.im>
 <as6kNufOqLFeBoNh@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as6kNufOqLFeBoNh@denethor>

On Tue, Oct 13, 2026 at 04:48:23PM -0500, Justin Tobler wrote:
> On 26/10/13 09:36AM, Patrick Steinhardt wrote:
> > diff --git a/odb.c b/odb.c
> > index 69a4c203bc..095183aec0 100644
> > --- a/odb.c
> > +++ b/odb.c
> > @@ -265,7 +265,6 @@ static enum odb_read_status do_oid_object_info_extended(struct object_database *
> >  	struct strbuf corrupt_err = STRBUF_INIT;
> >  	const struct object_id *real = oid;
> >  	enum odb_read_status ret;
> > -	int already_retried = 0;
> >  	bool corrupt = false;
> >  
> >  	if (flags & OBJECT_INFO_LOOKUP_REPLACE)
> > @@ -277,38 +276,39 @@ static enum odb_read_status do_oid_object_info_extended(struct object_database *
> >  	if (!odb_source_read_object_info(odb->inmemory_objects, oid, oi, flags, NULL))
> >  		return 0;
> >  
> > -	while (1) {
> > +	ret = odb_source_read_object_info(odb->source, real, oi, flags,
> > +					  &corrupt_err);
> 
> Here is try to read the object, the backend is responsible for handling
> any retries internally that it cares about.
> 
> > +	if (!ret)
> > +		goto out;
> > +	if (ret != ODB_READ_NOT_FOUND)
> > +		corrupt = true;
> 
> If the repsitory is correct, does it even make sense to continue to try
> and fetch the missing object? I wonder if we should set `ret =
> ODB_READ_ERROR` and `goto out`?

I think I tend to agree. I don't want to do it as part of this commit
though, which is a plain refactoring that shouldn't change semantics.
I'll add a commit on top though.

Patrick
