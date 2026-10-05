Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5351F4772A4
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 10:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195911; cv=none; b=ZFXx2JGSEVobGc7wcm/+FLz6BW/r97qXpmChn9TGgBoO2kYGWgrLi/VOj6/vy4l0Vki/BokR9OcVBMJ8YXetH1ilBU0k2neMLEJERkKdm+Ie0F1XDrVWIF1aBbCc/yvy1gug/19ArhsHWSRG3pLqF69+RzwzU6VqxqmlEYQehew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195911; c=relaxed/simple;
	bh=LMeKCMONmosdrbPdda/rg0ArobLZd81byxmjo0MfjL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rI9fcTCv4iRJkQo7NnmeErU3cvCE4ttv281L9EgkL24+1hTaAprn5PYf3ijogtY6v1/uNEkSX1KUDmjWeev2TdwJWla6vgrIWucQVnOY7JOLGGcnJXeVsbGHiNe/Q/o/QAO+51SPbLbMH2Sr5HzLktRLe2W4+i7xBrHMnmCHDzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sin7sc7m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wo7WHdKM; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sin7sc7m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wo7WHdKM"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 48B211400113
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 06:25:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 05 Oct 2026 06:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791195908; x=1791282308; bh=xqJG94lyFq
	MI/Qtdz/dPELLnxqdLXdtt321z3zDglyc=; b=sin7sc7mxMnkOev9yLj6BrFo69
	3LPDj2yqx6rEd7/EdrBjxqvTK5MgqipDM1M2dtr+juaZb4db4l1Pt1x3Q6xzYmB2
	e3NE1xZAh4m7VINcnupiA834GI8MXNFp/HjbSsDd+Bh+X8xMLjlfa9msMVrKDo/2
	XXnuh/RHW0Eq924LwY2sEwRJT/F5Nga1KYwwZ15WOf5bufKMpLmfiOlJ/tstp9sB
	sqpgImsY1OT5hr38wX8wmqM8OhnIQ34j9xDjTCf6pFsNO77XxVZordU6KWZP7crJ
	OxyIy4gbAaj+804O8H5qqMHTGeeGxQUOQoylfYtH64NA9q16unT08DSMl+nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791195908; x=1791282308; bh=xqJG94lyFqMI/Qtdz/dPELLnxqdLXdtt321
	z3zDglyc=; b=Wo7WHdKMcn2lFFLfeld6n8Xp4XxnmhkC2pnE0UjcorikMfsnkts
	V3wrbT5iPkyxfv2548G9m5qqWpECcUbG3ozZONT9LDRPDGnwmEYDu1C+d/YO6Tc2
	yNMiQLV3YP/ki4hqSWtMfs26qlCtblPJ5bvADEfx7uHEnBl5iNG8NpExAZO02Bbu
	PfJ3PKNKKZi3cfk/IDB9qrJ0SnbDjnXh5MulTzGWXbmEXVLPZDxKEO8O1xsM8Coc
	4WQ/rBBgK/OriP+XUaNjDlsR81zp7htiy6WMT4w8OBZ6niVy52JlngAdLnaD7NB3
	kxSbrr2LwUZdfAH28HG9STZ/1oQfKNfLtIg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791195908; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:NKapuG6BzmDd5lIrWHBOjR3GZJ2m7qoMdJNjXT+0rQQ98sN
	ok+Eg5ftOeW15WcEuML+DbqnobA4554Xx6b78KflA0PyAKw1rT5E1SSph2o9IIWm
	qyhUUw/I4g10hNRipqjSrpb/6aF13d58Ogbwr/TT0rlBmn0MVCO27iWGdLM4gtFU
	k8k+cKPkXBgGHP5DQIM6Owar6BfeVZeAw3JrLjcBE3PZeyqf1UCKF977mKNZn4wz
	Cqqah8RwTHPtjQ9sPDYb/hXfbB5SXDEF6NP3NHVN64wAkzvjngV3iOYLIr8ndh+W
	9I6fvcN0SNogBFnnHvxzpNCRqphaZ+PbjCCjojQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Xje925J6qvLdU3yI7p7m5kdYl5hLbKqEMNrHegej/IY=:LMeKCMONmosdrbPdda/rg0ArobLZd81byxmjo0MfjL8=;
X-ME-Sender: <xms:BHvDav5CgeyXdDlQUCiZh42mJDhRmpuTvOXaBgiIgvNs5Bx9Uzlwiw>
    <xme:BHvDasWxM43EWAD9eL2RXj5bSho3qju3_ELcrfSwvbVaOSgDu1EWLTkfOtheqDjUi
    rPqr-0gbkqrEcgXgeCd_IMZKEWy2Jf28ehJdnSbZwBQAMe6VYv-tw>
X-ME-Received: <xmr:BHvDaj2303xy5xRDwrPbqDbXgO81nPujb29UKj-1UlYBHcJUtdhl7qCvTYk0nLi-5ClrI_Q>
X-ME-Proxy-Cause: dmFkZTGXBrRAyzl2T+rLLZkNV80AVWVI7fN7GRE0mZ9c3THXrIs34NJMNkcUaJVjfkPrNZ
    RrHEMlH7W+BVoWwcAV7pwY2GfJBElffaSvM8M8JeWgB3fWuRtGczqOJ8iFWxejt8F03mUS
    Oh8rhKYrtZMhz0KmrGUItbhvZwMCcEADUxh9m09d8NBxfUwKUT+7z1/whrh039edjOvg3I
    nJKRWYAoK44xqz6nSQYBLF9FqeoSREDmaTnO4l0tITnV15ux7hByhH4i7Y0Y57Mv7I+FPR
    AW8fjh4CO459ZmjhwSLXs40DNE/gmNtQA1M1xdHN/yFN1xJ+i+5RHW1KGj4xy4zGx299lG
    TCngy6ZPXPUetLmmHsMfPGo/kKo0E8aYFfE4wpT46Rp4AwJ0Fzjqq3bW45yv6r8NRk6bol
    QuDoXQ6TpW2Pv9fwoAv3fgtSBakY8PiIBz6a4K63BEDEnVLJ9oWWqYXW/S0ZeUBWtGv/f/
    1lIBG3fbjElen5HSBhHdrc/5Z+BVjY6v/BoZ8/VesDD/5oq+wJokEo61PwrVjZmw8Qlj2j
    Fk25LeEvmgcvWVSiJhX32ldQPSICyEOaiNqVSqK81/eOaaLJnBR8wYh0llxr5IMswa0wsM
    7WXVdl4Q6nGFs9e0VCYbpcKhWanr766Ii9gP7bQ1yB6IpkDBmBKHPTHdxs9w
X-ME-Proxy: <xmx:BHvDap1WzBerIriBgkkVlNK3zkv1bN0opa9DENto4HUBePjeDvbYlg>
    <xmx:BHvDam9q7yAvj-eTP3KrIf1sKIAtf4EBLDyCUV69LIz6BE00AFtYTw>
    <xmx:BHvDam2MdYpvn3isar1h6KGlcJzjqm5SeghqZIGQSnD_wK6nGX10lA>
    <xmx:BHvDaj_Chfi3cOiivdKsNv-OhMnRYyRPil7AN-UrxE1Ott8QGdhG4Q>
    <xmx:BHvDam3xSXk24MXL9dd6FDxws5G7bHwhenPZPmr6GG4cUcNQ1Y6Zmvmo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 06:25:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 26cb716d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Oct 2026 10:25:06 +0000 (UTC)
Date: Mon, 5 Oct 2026 12:25:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/7] meson: update wrappers
Message-ID: <asN7AJdVmPCzov7l@pks.im>
References: <20260924-pks-meson-improvements-v1-0-90b7f79f1c4e@pks.im>
 <20260924-pks-meson-improvements-v1-6-90b7f79f1c4e@pks.im>
 <3de4ba2b-9b0c-499b-98bb-7077e0d7613b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3de4ba2b-9b0c-499b-98bb-7077e0d7613b@gmail.com>

On Mon, Oct 05, 2026 at 03:12:34PM +0530, Kaartic Sivaraam wrote:
> On 9/24/26 19:39, Patrick Steinhardt wrote:
> > diff --git a/subprojects/openssl.wrap b/subprojects/openssl.wrap> index
> 873d55106e..e775bb104f 100644
> > --- a/subprojects/openssl.wrap
> > +++ b/subprojects/openssl.wrap
> > @@ -1,15 +1,14 @@
> >   [wrap-file]
> > [ snip ]> -wrapdb_version = 3.0.8-3
> > [ snip ]> +wrapdb_version = 3.0.10-1
> > 
> 
> We are using the latest versions from the wrap DB for the above but the
> versions available via wrap DB itself appears quite old. For instance,
> 
> - curl 8.12.1 was released on Feb/2025. The latest available
>   is 8.22.0 (released Sep/2026)
> 
> - OpenSSL 3.0.10 was released on Aug/2023. The latest available are
>   3.0.22 (released Aug/2026) and 4.0.1 (released Jun/2026).
> 
> Is this version gap something we need to document / think about?

Maybe, but I think the proper way to fix this would be to update the
wrap DB if we really care about this. For now we only use this so that
we can have a mostly dependencyless Windows build with GitLab CI. I
don't think anybody uses this for a production-facing build.

So I'd leave this as-is for now, but agree that we should maybe iterate
a bit on this going forward and collaborate with upstream.

Thanks!

Patrick
