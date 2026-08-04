Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7433A427FBB
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 07:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785828101; cv=none; b=XFP04H1cafdAlZxLU8TOa6apGQzZjm2ya8XiljRTncg1zukJaCDnGNdJB7XwiwcuX509VpDoFrGmiivL31vGlQaHvMOww6NyptX/Q3MlT4jjaDC7jjezSuyrYaSVi61Wt1MDEybjRzUYCeyA/nhC/1j0Yoc+5Ff1AiTkTzwpzQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785828101; c=relaxed/simple;
	bh=qSYMC8kThcJPb2adrZ/vtuJhdkn/rpeAibHO8X2IwMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhbOhvCXfjfJ1Qtb8g5QtOO4lmRFYaKTOPRa/wJDQrWfxvblPgieYbsW4X5DpS738hxg91t36pOFjB9cAWlEzCTj1b9gAga1jxIqWo0nPUPJV7kNlrOBnpJZz0puJxPemVDfG6D2v+vl4LyXoQdr2By8kMGNSo47QPdsnfUhQAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=in14mUUE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jPZyrZzf; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="in14mUUE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jPZyrZzf"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id C2F761D00181;
	Tue,  4 Aug 2026 03:21:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 04 Aug 2026 03:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785828099; x=1785914499; bh=2U6YiRxZdx
	wAUgQMNcKWA1QS5cnwarpagsKPk1si9mI=; b=in14mUUE86qtLTVHmZW517jeJ9
	yWCTaKk+mDVgLkc/O23myJFf0D8FsakHD9SyUm39t5YCYk3m4NVFHCsn8Ud1EG8f
	pz7XYtkvvN4Y6uI4qJK1L9E4xwB6IWQbr9issNiTVuk//KXOzgfPYbxGN/wZ2gGc
	g7Kh+AlDJpy17A9mjKP7pVhD24Tg/+GdKH9MnuwBVQ5YX7GubP5CemD+p2ILwx89
	mhCe8d55ZqvHRPXG+rM7uaMh8Bm68NHnR7QmwdsrE3AUVbyxigP7WSBRt2dWOdkC
	Dtcx1ESEgN8UegTK3gZYbV+htYeBUSf6mIhhfIhoylZXGdI8pmUMLxyuBDEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785828099; x=1785914499; bh=2U6YiRxZdxwAUgQMNcKWA1QS5cnwarpagsK
	Pk1si9mI=; b=jPZyrZzfWN9/+GZwXZkpO3ml+fGdJdiex2yFlM9eCRoniGjXadN
	gsw2hUXkJr1/AvyVKkNa9/74k8DFLHmAcnuxGFuVt6gWHufEw6tXRG+EzIyzfLs0
	zQ/Isovg28wwajjSeVHueNCIOt5vU3wzwYEmM1Y4u/H9VCF8PsmqJw/wDriBZ4mD
	qt2cup4OGs9OJm8+XGDTcjoHh7berllH+4dLImAZ5r8pRR9s3WBGOewYSLfjz2O/
	1Hzs8VFFCGpWFegQvU11+6drzRcVm1AysYMEyYfOSaovx9FA/NcN1U29KsZGQkiF
	e77fQvpHIIHR48XD5pEkLRFBB17eXOL/HxA==
X-ME-Sender: <xms:A5NxauKHlMOaLE6hkVgp3p3skOs-ZmCvEDTZDBS9skuOcOVXhSsQeg>
    <xme:A5NxasKGPtFgszBIU43Tb3DWowxQYL-5tr3ML9GJ5vLEBArejqfMAxVFk1aJgxeS1
    A8U1EGfHTjvK215rCP64jzAUbW8Ju81LejVp1UU2ClTFOrhQ1AL5Vw>
X-ME-Received: <xmr:A5NxasWi0u9mBXZCMGCpwnK2aFi53pBfkg9MF8Dxn5sMnTpbZmnGYtmuQegPnxVBESZP7IBb4JuNZ3FgL8kUqi7KK0NmRMz9BN3bVdFA>
X-ME-Proxy-Cause: dmFkZTGv26e48nS5TUES+Y2rWV0UOotlqQ/3ysHRb+g1cCrrIYKZ6OIbfQwAZ+fVBCCG4i
    zmupeo+sH2cdfJPaEcWt/ZPEMYy3jkepg+9ObrTCDbNDC5/X5F5jxLeb/bneqr2HU8t2tm
    sYYseOaQfiCXL09uuA7W3RfYJMaxU6ZKTuKz5FrnY33EYbFg8eh2r9QWf3iSWMF262AskO
    gLVIH10B6GTFKcDpS2PNkDlrEdg4IowlfhGCprJXiUdBBYti2EVb8h/3lfBRemxF1jefHr
    4tuOzuyn8LsyQ/Xvznq9cowt4Lp+Y3ML371s693D7XJQgvYT1+WXJRxLXgij3bLL0scYFj
    iDwDcQve/meCfp1+p/q0PJfYcLxZ1tiQj10XRV42Ns9f3XX6skc4eWcii5Q9zZHEggoFee
    oGCymirPrq+mAOK5Sohm2ZliE0xR1zVuHz5WLGQoHYIzLLKi+1ZXXm2Ufp/lne9wz5mLad
    0t+Qsag9dmBuQ8II+6F5HXSsS9QReqdevIMvBF5FyrRFHqFAjoDhEOn1cyeFowPA+YRpXj
    JMybXZIbYSi72hpM3TomvvjvQqkhSy3EwLYsf2Nu29cVsWSdF04z9ysrZwGxERwrFRErAv
    ZKWq0GpsyaMcFEqPrvFFIEXI+wgx4iFfhgaY4b31YZgBhazl84rBdESIMEGg
X-ME-Proxy: <xmx:A5NxauiUYmaeJ9BH4GtjlrXBnF_veLdx-1lyMChHbrUZfzQzfxoWgw>
    <xmx:A5Nxan9UaIlpy3ATDafj9qrEcXql7slC5_MVRQ8KCQZstdIbcpKhyA>
    <xmx:A5NxaoD_AeLUI8iJ6qtIdPetRt1L8r9S3Z2zUIysC2Wzr-CIH9pDjA>
    <xmx:A5NxakJ8-2uy8mly_l9A-DyoYWEVk9S5pe3R4vKNjY4nzHzVCFFOSg>
    <xmx:A5Nxav6wucZlk5pAuV3J0LXXXGzPWxQMueXE7maSM4iSyWQTWWguGrvs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 03:21:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dc9db070 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Aug 2026 07:21:37 +0000 (UTC)
Date: Tue, 4 Aug 2026 09:21:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/5] setup: detangle loading of loose object maps
Message-ID: <anGS_njkfklt9gbd@pks.im>
References: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
 <20260724-pks-odb-create-on-disk-v1-2-3b3d265d979b@pks.im>
 <amkOb3rvWFUpnT28@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amkOb3rvWFUpnT28@denethor>

On Tue, Jul 28, 2026 at 03:32:27PM -0500, Justin Tobler wrote:
> On 26/07/24 05:48AM, Patrick Steinhardt wrote:
> > When a repository is configured to use a compatibility hash function
> > then we load the loose object map when we initialize the repository.
> > This object map provides the mappings between the canonical object hash
> > and the compatibility object hash.
> > 
> > Loading the object map happens in `repo_set_compat_hash_algo()`, which
> > calls `repo_read_loose_object_map()` in case the compatibility object
> > hash is non-zero. This setup sequence has two major downsides:
> > 
> >   - We assume that the primary object database is the "files" object
> >     database so that we can extract its "loose" backend. This stops
> >     working with pluggable object databases.
> 
> So IIUC, does this mean that `repo_set_compat_hash_algo()` is directly
> reaching into the loose object source to load the compatibility object
> map? I suppose it should be the responsibility of the respective ODB
> backend to handle object compatibility.
> 
> >   - We require the object database to already have been initialized when
> >     configuring the object database. This means that we must intermix
> >     configuration of the repository and initialization of its
> >     sub-structures in a weird way.
> 
> If there any reason we need to eagerly load compatibility object
> mappings?

I'm not familiar enough with the compatibility mappings to really be
able to say. Naively I'd say "no", but I'm rather erring on the side of
caution and want to leave this as-is.

> > diff --git a/loose.c b/loose.c
> > index 9dad75373b..a3b2dcedc2 100644
> > --- a/loose.c
> > +++ b/loose.c
> > @@ -69,6 +69,9 @@ static int load_one_loose_object_map(struct odb_source_loose *loose)
> >  	FILE *fp;
> >  	int ret = -1;
> >  
> > +	if (!should_use_loose_object_map(repo))
> > +		return 0;
> 
> Previously the above condition has asserted in
> `repo_read_loose_object_map()` which calls `loose_object_map_load()` for
> each source. Do we expect each source to potentially answer differently
> though?

Not really, no. But as it's now the source that loads the object map it
has to verify for itself whether it should or should not load it.

Patrick
