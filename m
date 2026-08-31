Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFD239E18E
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 06:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788156046; cv=none; b=GZ5G8rus+DQaJyazdk6NMteVnehzJn5Ql2DGz3n0FDCZB2YH42sn+Phw52jzveT6NyllKudQ5s1fW/i039+PW/EyCupNwwosv1HtG3EhEGL4FdhYvLTaoYpdZNJpZrl+Jn6Hq/BC5dNmmy1kB0XBnzW2ZRauNguyFumi7XUdlQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788156046; c=relaxed/simple;
	bh=w6su9IeU/GwAQ0mDamJ94nHkkezxzCjPUQdcsOM2NoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYvZ0hflZuHGOtY30ubfp2SQ6M3H+ORSh1mjrh+d9eZVG2YHaVQuSpOfp7Mf7SUxWUCzc+W+7XHjr+39S7TO91VvlOYk0UGFa+c+rYBLU3yCUCKwjCOM1mdHK7k3TrxvVNARbEV32ypphHpERVi8ZcFEu57qFzYbLpwBczHM9s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a8XlzKFt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i046x7wH; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a8XlzKFt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i046x7wH"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5E3447A0139;
	Mon, 31 Aug 2026 02:00:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 31 Aug 2026 02:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788156044; x=1788242444; bh=m/7pVzpKdj
	+QhNbSWDRPYWEyU1C5xoikWwsPOGsb+cc=; b=a8XlzKFtYahcpofoUQk5ihuhKZ
	9V2YOimRWMp8sRwWNbWyiJl9G2O2bRYHbthv+INFNG2UEp2gLNaYYanyAO+ogn3y
	V9Nr6wQVqBPedkLfkiYOTArLQ2cCYKPWI7mHvqSXasHiSJ/7x3aCkGOD8NQqZx9+
	wXNXAcGfaGz92366XCrJX7mWudiJj34KQr99vMgm6cIF3cUq2N8zj9hiOzXK3sPs
	hWXBkmaVGGNXMwDWgYxYm6YyzUpUob3knctnlKES38XOZw6/psgkarUkCULviP+S
	5CJec0JW70yriOTHNcAdFBv+tWuJRfcIbaHtRC+LLXY2W/tvuWeDyajtpzQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788156044; x=1788242444; bh=m/7pVzpKdj+QhNbSWDRPYWEyU1C5xoikWws
	POGsb+cc=; b=i046x7wHrwyWkGh4L27yKBEOT2BdyAskuxKmPSxAVj8cNxiItE6
	eEpnVV5Fr4YWWO8iUqUhauETozkrgBkpyuZNAf57o35Cxk4Hs2Uci1tgNYWTdnOd
	BRFEFf140AAVZgFedk0t0uZL/Xk/ps+UPAzReZhXHmA9+GXuQNm9ayqdASq65rXV
	lJ5qs0YavnYRUHPFWkyUCJ7EGcfYSs2SY7q3iATyq4fSjS5HEJ9d7fVUvB7IqOpo
	TL6YklHqXFQoDAqk8PDkxVFkTDGL7Vaj2fmoB4RnIFo9MB2cG1dxDrMPrqUqNkQm
	6YzLomhZ5KptN4sv30U7ZtPf6dVY/6SLGtg==
X-ME-Sender: <xms:jBiVaiHpt9Y-ELZMKRzsSJfjdEWvXB0yMYFEDLqqmrHWVKt8EZ3HVg>
    <xme:jBiVapWIwQhV1M4_xZ3D3Vkge0j321kWWRi81hbivhatAudsxrzyD-RJtsyzvv6Vg
    1h9UsOVoiHNnupGdwOQD9DsnGBi1pQ5VPHgUBkI5pdbyMnGakmgPBo>
X-ME-Received: <xmr:jBiVapz7we4O7FSxY5vButpEwqdib7k3VFWFjBkdlMKjZlsn-2GvNLXXDDab-w5iiQWWoA>
X-ME-Proxy-Cause: dmFkZTFMKLwiil4HL+xg0vV0X8ZHibuphipUKGgdJIVIc9Kt87M7HfYLYQnrQ3WcjMRK5m
    PBstsMhC3Gok/QZGKy3NnZehG1f5th8LFuV1ZVNfcnv6rgYl2/fCy7aIIWgC2d9OFb6NTc
    Vov1tvWQbQLZwsFDU+n6CVG0cShTQurg4WSbr1tKBA6PhhRV+XOTlLgTQ9j8yXztfTa2pw
    L0r1zq3AjnkkO9pT8GImcmgFbpOoZ66UHxWOtRfW8xicZdyuDGaeFGaPjiD++e4dR94YTZ
    PWQ02Osm7vOltcu7Co4Ntfhd/Tmavk85Gdc4yf1nn5gYtd108LL2IWDKASihhgpBIKwum9
    uzX1KkOwyGJioLJOhVPLK0Gt5ULjGEYGyiQ0CvbPQwHy5t4TjbOUEioJxS2xvXPSVlq4T/
    FHYSwC3EHYC+ONeobaNrfi5lVHwMR+hDwLot4OPew+VF4IlzUHaCe4Xx5S8bCAFVIQqziM
    sMFCsl5QHNY/LmJNGwCuFA32BZlH7GL7m7ChXhMxiYfgt5BvG2t/U3sXhsO6pVT4EJNKyN
    nGKFY5oJA6Us3RcwDOG9nbUV7tW4bW49TsDsFTtmtet+e/5hKTnJN/JqpEPwf8255b5t8Z
    FX6Yaquc9Nf0Rg7QHeTXcsdEiflOgk/xQjn5UWrL+HsxmempzQFn/E/C8zhA
X-ME-Proxy: <xmx:jBiVanOSUFQDy6nxw_LMZuzggI4Su4hZyYsxUbiqHuNhJMVr4RGJbw>
    <xmx:jBiVaq4qrO-BH0g-41QGJgx8_6XdavEI-u4xkIyIbqj9yaYoNkO48w>
    <xmx:jBiVaoNrppRi4491GquqdHWAD7bqRJOYQIDmd7313XDn5GfKQkdxXQ>
    <xmx:jBiVaokrzGHSfMh0PvwOa406DZh_bsqTyPFbTX_6BCRH2b-hsBJkDQ>
    <xmx:jBiVai3O-B6vmx1iY-rdi3ZFIu7uzOntYc-zNJq9ZyW014rvPqurobXH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 02:00:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b708403f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 06:00:50 +0000 (UTC)
Date: Mon, 31 Aug 2026 08:00:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 05/10] odb: provide infrastructure for pluggable fsck
 checks
Message-ID: <apUYhh-Uz-ZVrsFh@pks.im>
References: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im>
 <20260825-pks-odb-source-fsck-v1-5-b756de0bf24f@pks.im>
 <CAOLa=ZQaetcmzOWzba=peCadW6i_JqhMth5cmQOZ32xz-E-zoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQaetcmzOWzba=peCadW6i_JqhMth5cmQOZ32xz-E-zoQ@mail.gmail.com>

On Thu, Aug 27, 2026 at 06:49:38AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/builtin/fsck.c b/builtin/fsck.c
> > index 3f6056535f..adbe192e56 100644
> > --- a/builtin/fsck.c
> > +++ b/builtin/fsck.c
> > @@ -977,7 +979,8 @@ int cmd_fsck(int argc,
> >  		OPT_BOOL(0, "root", &show_root, N_("report root nodes")),
> >  		OPT_BOOL(0, "cache", &keep_cache_objects, N_("make index objects head nodes")),
> >  		OPT_BOOL(0, "reflogs", &include_reflogs, N_("make reflogs head nodes (default)")),
> > -		OPT_BOOL(0, "full", &check_full, N_("also consider packs and alternate objects")),
> 
> Question: OPT_BOOL sets 'check_full' to 0 when using '--no-full', does
> OPT_BIT provide similar functionality?

Yes, it does.

> > @@ -1047,10 +1050,13 @@ int cmd_fsck(int argc,
> >  				    mark_object_for_connectivity, repo, 0);
> >  	} else {
> >  		for (source = repo->objects->sources; source; source = source->next)
> > -			if (check_full || source->local)
> > +			if ((odb_fsck_opts.flags & ODB_FSCK_FULL) || source->local)
> >  				fsck_source(repo, source);
> >
> > -		if (check_full) {
> > +		if (odb_fsck(repo->objects, &odb_fsck_opts) < 0)
> > +			errors_found |= ERROR_OBJECT;
> > +
> 
> So most of the functionality will move into this and we'll cleanup
> around in the following commits.

Yup, exactly.

Patrick
