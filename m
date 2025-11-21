Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B692566F7
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 06:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763706719; cv=none; b=Cvuk2X2NZIe8gjPqPxBaammF33Zlqh9/zae3i5OJ0giorrs3uClTADUVIn77q+ZLPnttKCMLLE5fXNXU6y2rnyajSnilaxCMlrFhu1WizowxK3rfylrgvw9OPdQldyBjenptaX6NuY6qJuUeOnkRAXYsSm7x4+52xY2Rb5ODGLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763706719; c=relaxed/simple;
	bh=3ZMCHdrA+dEHxM8+p/sadVmsNtSNM0wKeuh0n+K0NbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2mniHR+RdvmmqVAXYUMeMi8WnZmRF70mT8/jy7EUXj3d7PZW2f551tPp34wSUUffN/svL35A10wvqJ5U6cYZHK62zkAJyiDU8slF6yHvrYYa+fbC/QTpisbG/PtokHDx6iHusVXo51cIAiT5MO6AVuKYKF/747WsiwxDUdH4QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EKDZnDGC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yfaB190T; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EKDZnDGC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yfaB190T"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 2AEDD1D00218;
	Fri, 21 Nov 2025 01:31:55 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 21 Nov 2025 01:31:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1763706715; x=1763793115; bh=Xy1M7JIuX1
	JN3M28pzecavY7w5gRqJoHcMVfcY2CExE=; b=EKDZnDGCACH/4GUmULC4dXyA60
	T+7VrN43YxAdUeSc6e9Z1Ap4ZWtpTwj8L5+O0L7nOnjkBEqJmGIxIAzqoQOgqEUQ
	owovOv82Sp4bicj0U86vaJU3SdNT5+MuFBxH4BtW7oL6SB6guacrXpd3vD6FVPa1
	NvkQ41WqlAVSuz6CtmWXkwXrKZqRyAw3Eix5rXyoLKq9DSBJhILp2o0IAM3x2phZ
	KsvJMUZDlMAftCdZ6KnOD8Urv7pWtFjpkaCBkC0kYz6enircnvhWVes8yJxThGOP
	nEovoPkNM2PWtmQ7oGO+UN2N7nJpzG31TueGa0YcU0bRApsQpOznvfiNcQyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763706715; x=1763793115; bh=Xy1M7JIuX1JN3M28pzecavY7w5gRqJoHcMV
	fcY2CExE=; b=yfaB190TZ1FLJNO3WrXkxjPXeCoDLCMZG/m4eHfAET/ZM1zYzLH
	ddd2eByd3sYQo9r87XO8R6ruLb3yRzAgoG28Aqr7AeXj+vKsTlRMXoiFJgEABz5q
	RQ9OBOtjUdZwxc2fHKdZu/Y4jGXBf7E0a2TyfBsXdKdjg3Ex7XPobDFD5sVNziAD
	1t0vd+cNjb060v1VzvJucAj4cQN6q2VSYug96hjT4L+DuaZMhXLtN23J/p/QRdrf
	kKVbGCIJB8MOB3VBf+j9qbpvlQ9+LgK5P0vr32u2wXcCKaQR/39TQeQLmoUEYJSp
	3NFU5BkR5nIPzuwFJaI8ugQ+atKioIvrnYQ==
X-ME-Sender: <xms:WgcgaUffMyZC0v9t2NDYfJJCL-3LPioMR0p1pcs7vDxdsZ4zl-lyZw>
    <xme:WgcgacN6tx5GgeaaLMnPU27h7lXN_Ba07hS4e-5pqooabu4Pu3fNYmM8WO4DqsglB
    Yoh4cLgNZgD0CoRloc0VmHI_VxvJuH5_z4PgNTuFVfHicd89eAxwdM>
X-ME-Received: <xmr:WgcgaTJtd2ZDmXKL5x2yxW2qYhSIeK2lfzA7gSSq0eJEgfVJINlj_UQ6YZ4KyERgLE8VCa2U1J2zmSiY9p8kKpSRrr9JIMRlKp4uzSD8iaw5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:WgcgaVGz5hq43-3gwom-V5wMkVgjeNBNXDgFUCRFmAsVgspibNN6_g>
    <xmx:WgcgaTSdxy8jHK2cUOddgwRcg7K7b4AG5ihI-4cwfcdON7FL_79csQ>
    <xmx:WgcgaZGSwlA80ZimgufiUqaOQ2WkYMDg25ekikui8peaxhW42BuYHA>
    <xmx:WgcgaX9gx-nKAzZECY0ZO_32Pmiw_pbMn32ucp8NsMOOBeg0lng7Yw>
    <xmx:WwcgabM2AUfLy5z1EsQ4c4p4wrb3yjEroFKlfmT69rQ6qcR4zCfrvjXz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 01:31:54 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 094417fc (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 21 Nov 2025 06:31:52 +0000 (UTC)
Date: Fri, 21 Nov 2025 07:31:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/18] streaming: rename `git_istream` into
 `odb_read_stream`
Message-ID: <aSAHVZCR7U1Di-LP@pks.im>
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
 <20251119-b4-pks-odb-read-stream-v1-1-adacf03c2ccf@pks.im>
 <2nd7qcj7jrrwc4fyhfsovs3ptrwmrdxxcap4sqadujtwwua5ha@bpbjlbnbcpiw>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2nd7qcj7jrrwc4fyhfsovs3ptrwmrdxxcap4sqadujtwwua5ha@bpbjlbnbcpiw>

On Wed, Nov 19, 2025 at 12:49:22PM -0600, Justin Tobler wrote:
> On 25/11/19 08:47AM, Patrick Steinhardt wrote:
> > diff --git a/streaming.h b/streaming.h
> > index bd27f59e57..acf4c84338 100644
> > --- a/streaming.h
> > +++ b/streaming.h
> > @@ -7,14 +7,14 @@
> >  #include "object.h"
> >  
> >  /* opaque */
> > -struct git_istream;
> > +struct odb_read_stream;
> 
> The name change here makes sense. While we are here, it might be nice to
> leave a comment annotating it's purpose in a bit more detail.

I do this in a subsequent commit, so I won't add this comment here.

Patrick
