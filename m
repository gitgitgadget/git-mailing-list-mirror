Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742DC36AB53
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325332; cv=none; b=bavvq6XR8rbp1SNCzmMGcJCyMUpSnQA2D4pDOWwQIwCj+nMJkFdhQ+PG9s1wZ5ugInKdu9uCH3iTrwqTMNDaIG/iacOLjS+ZeYlcLaVrN3VE0dUblQZi3iX3MHeAyeBJnGuyuAo1yyUSWC+CypaRgf27AECWunx8qROm8icsAyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325332; c=relaxed/simple;
	bh=x9GvMebL00HfJyacdSM+3TdX/Ko0I0BpSwXzoLjQgzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYYbkm0L0HpdZOidE97FyiWDiRvIzjpCZX9mgNs8C1qtKzKlVnoE8kHh1bDx368cQGyUn8YUbG21ZMvjs8Q2OM3E5LyxNGzrZvGexVvYw+e/oaqHTDKlTTqLWEDElz9ByuFy3+9GiFJZ3MI4vnpsoyonkCYdx0uCrMeqDGzK6x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i9SNTli0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BGOdVk4E; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i9SNTli0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BGOdVk4E"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 7E1EC1D000FF;
	Thu, 12 Mar 2026 10:22:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 12 Mar 2026 10:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773325329; x=1773411729; bh=eNXQWMHlzP
	AkImje6WZsy1R6s02jCEna2FH1wCOLcPo=; b=i9SNTli0kfV6ZC0tVtnHeRWu7Z
	mO3gEJvHv7SfyxkcPyAWa+J+WXd+MPIAhwd2dgs3g+620WP1Oaa53S6lo0LlcB6+
	I20Xegu4UoCVwSdHGZqkarnnHQMdzKAN2Wm0CGxvKiHt7RAc0+V2cBNWswYGw3lI
	g7XK18cgd1T8z9inooq4cdjBVbShkS1IDVFBupLyDHEifsH8JMVg7QDqCHye6tnG
	n0rAwRt0b1gCiwjhSf69tlkG3scWAfV7lOZ+aMSfNznm/A1L2i2GF6gTvtU2Xoxn
	Kz5+vANvlpyUi1UkvZXCssfPuAgIQsEH8F1F5LHwYwCdut3lvc5sgrQFgoug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773325329; x=1773411729; bh=eNXQWMHlzPAkImje6WZsy1R6s02jCEna2FH
	1wCOLcPo=; b=BGOdVk4EdsCl4AODCj6OKhivkRfqAm6/klf6DKz/hnj4OqJ5JPq
	IMd26oT5/GfyfZEoU6uIbSEayhFUhyIbigWPGlUwYulY9jbeO1+buomlSAqq82qC
	HmpoDGv9sxIht5aUg7vE2fZvvQa6vEPS0bUVC5Cn6yMcOsB82SF5oY0zfJjTp4j2
	OiFJVPHSpOhkeElIhWygQIDPbg5DgEWOsimDl5BJ6Nwyn1NLySGSIVJAKGv06vs0
	HsdmhTk+ESKVfN2svu5qLM46yxyHYsQwgTNzD8nxMXISffvVyDkbXlbWCqu0NZx9
	30w5TvWWmVvJqF8s/s6ezOSrQ2MUM1gDzug==
X-ME-Sender: <xms:EMyyaXgOMTEKTC9Tf7si66GJ5NM8aQZxqM8CEcHqYA1bZzvLw0Zfow>
    <xme:EMyyaa7fr4YeYO4ncd-UmN_PbvAE2MlS0-9DzSTM7Pogwj6euNAf_qrO7rWPBX59C
    g6diLKopj-GdtkcidASW7emTeUyiFEaupHDZAGDGEC2S3DT4HxRtQ>
X-ME-Received: <xmr:EMyyafYjUxcNcwPB9p4qB3sNHAHdwu0pCXdXhlyA5FFpBtH2SvVO63odhkGUu9_W5a7TGn4NwWN1q7tVs8il2QFALHlLlPlwz_5t3uBP4Ft57Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejtdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:EMyyaf59HqHGmEEjxQtgnXU58cg9iUn_hKbkOobBAXz7AZUIISAaWQ>
    <xmx:EMyyaSCWa56zZWY5iZGZgVpPLEjXNZogCD_C7ZX2jhQOwOuUo8pepQ>
    <xmx:EMyyaVcFLEY3Zhb5rwf5D2baiFg2xPSi_vr1kv9C93u5QYnjlyvRBA>
    <xmx:EMyyaRK49yH5A2YhgGwcilpe1-RVOiOhgzDrOv8n7ECis9ZlpJEEgg>
    <xmx:EcyyaSLDHEfBlbvwJcmoprd_NBLKr4Z586P2DrsiehxYpbb0FlZNyh1b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 10:22:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 05af0b28 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Mar 2026 14:22:05 +0000 (UTC)
Date: Thu, 12 Mar 2026 15:22:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net,
	christian.couder@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v4 3/3] fast-import: add mode to sign commits with
 invalid signatures
Message-ID: <abLMCxWWNiCnqmp_@pks.im>
References: <20260310201116.1130160-1-jltobler@gmail.com>
 <20260311173147.2336432-1-jltobler@gmail.com>
 <20260311173147.2336432-4-jltobler@gmail.com>
 <abKUBRRgRmbJ1hRA@pks.im>
 <abLGgq-PXzdWs6kD@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abLGgq-PXzdWs6kD@denethor>

On Thu, Mar 12, 2026 at 09:08:46AM -0500, Justin Tobler wrote:
> On 26/03/12 11:23AM, Patrick Steinhardt wrote:
> > On Wed, Mar 11, 2026 at 12:31:47PM -0500, Justin Tobler wrote:
> > > diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> > > index b8a7757cfd..d6281ff119 100644
> > > --- a/builtin/fast-import.c
> > > +++ b/builtin/fast-import.c
> > > @@ -2865,6 +2855,66 @@ static void handle_strip_if_invalid(struct strbuf *new_data,
> > >  		else
> > >  			warning(_("stripping invalid signature for commit\n"
> > >  				  "  allegedly by %s"), signer);
> > > +		break;
> > > +	case SIGN_SIGN_IF_INVALID:
> > > +		if (subject_len > 100)
> > > +			warning(_("signing commit with invalid signature for '%.100s...'\n"
> > > +				  "  allegedly by %s"), subject, signer);
> > > +		else if (subject_len > 0)
> > > +			warning(_("signing commit with invalid signature for '%.*s'\n"
> > > +				  "  allegedly by %s"), subject_len, subject, signer);
> > > +		else
> > > +			warning(_("signing commit with invalid signature\n"
> > > +				  "  allegedly by %s"), signer);
> > > +		break;
> > > +	default:
> > > +		BUG("unsupported signing mode");
> > > +	}
> > > +}
> > 
> > I'm still not convinced that it makes sense to warn about this case.
> > After all the user has asked us to re-sign such commits, so they
> > probably expect such cases. These warnings would thus result in a ton of
> > noise in a repository where most commits are signed, drowning out the
> > potentially-useful warnings.
> > 
> > Anyway, I won't insist on a change here.
> 
> I'm not really against removing these warning as I also agree it creates
> a bunch of noise. If we get rid of them for "sign-if-invalid" though,
> shouldn't we also get rid of them for "strip-if-invalid"? If the user
> asks to strip commits, I figure they would expect such cases as well. If
> we think removing the warning altogether is sensible, I can add another
> prepatory commit that simply removes the warning for the
> "strip-if-invalid" case.

Yeah, it kind of falls into the same space, agreed. As said, I won't
insist on changing this. Maybe the right way to approach this is to keep
it as-is for now and create a follow-up patch where you propose to strip
it from both sites?

Patrick
