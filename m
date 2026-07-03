Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4957231960B
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 05:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783056090; cv=none; b=W2kmcarxij+MDmXxyhAUpME1I5St7z8emSZM9QNMsjcKWcKiAK19CdFl6t1i4BfSt9/eMmKzCWnqD2LBeFOdPx5WYIhmbkEv0jSUVR12iB3x13v+93A85VRPkf/MQaeBoiTvLJP6Fm+hlOGZyKLsYyE8SMAl5ONh/Rw1i6p3KOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783056090; c=relaxed/simple;
	bh=1/puOwVmW8zJH8BYhj5MP9FXzxBhzatEec88y8EH1dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHtkgGFD3C4ZTNSDdJM6/cQFOkL6tjsdYqO0FVDp5pl+0U8eHbSuA5EOTYXxy/aC7YYnZJLuyrEliu7LPIZcUMlW7WD9cZxzyqUpUseqbK47FmCO22DOGm75JSwYVdpo8BAmoEjdVbeC1B1yz/1XOFHo9kRXpvdVufUPLIUSbBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WM/AFRZ0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j7WVP4nR; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WM/AFRZ0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j7WVP4nR"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 3F1831D00013;
	Fri,  3 Jul 2026 01:21:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 03 Jul 2026 01:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783056083;
	 x=1783142483; bh=70nU6CccUD1NrN1ViqhX4zpoyBqEDIjYGsmj55enroA=; b=
	WM/AFRZ0vsbaYTP66IiB4jsBLPP+3dIBprLXJk1gJj9VK34z8MrQfh3jhOgGFNrn
	EeYgltFs/ROaM7qWogSKHMmEeRQXPEHfM/eyKF8GJRLduFVdzw/g0dIZDA9NYAmF
	SoksxxvdjnuLngZxpLsuIf7kbLFmDusR7jwj2fca2CTg8tsJcbNGqhrRp47/t8bF
	10jQta29BMzy1OLxaQVvO3Y7BpmJKl25bRnQjog4l2qo6JHk9dNVzy0wVfkUf4QW
	4E2M2J8ZkR5X+OA9Y1tFFyJzKtaCASeXGdxi2PnN6h9TMPpNI0ps2sS9k74uNZhG
	hNymgsXovwOO6+FdHIKbPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783056083; x=
	1783142483; bh=70nU6CccUD1NrN1ViqhX4zpoyBqEDIjYGsmj55enroA=; b=j
	7WVP4nREY9giuDq3+zg/yMPZZbfR77KetxmPp1QBTLf7JKimCw/wI2HF32YSc4Ap
	sU76+c0gx6ob2XAJRUVqViaz/ok1XV378aO5ESVaTNjCvfVRRnS8vl1/nORfx4GN
	GglUu0IR6SwV8G3tw6EjKgIastnKD7s/Bji+x9hfm8JtGFsDk+E0fGi2l31jN12O
	6V5COPoVtp473wWAi2qFmJTLcm2LzMY27wUA1hQ8iKoESUhjop/mWKdIHVhHtJH0
	2iaBOo9xpJPAPIqIAcQ0DeiZTwijsfmNWnZmQ752A80FmNvHVaVCIkCRPqrR5qqP
	VQGDcnC+vY+GEzj4CpOGw==
X-ME-Sender: <xms:0kZHagDgNTaujPwjGJGeOcD94J24SeRAH5lcwakE9N88NJ7GWXRhsg>
    <xme:0kZHap9XAq4T6qs8_uzDLvl-5vaOALWCd3_6Zy-9KBa5k3MugfB7GelVg_vfDBpUy
    KjHSJgh7MyhnbvALIP6yOTKHk-A8jjB66LI7vL4vm5dhXcwDHiox3Y>
X-ME-Received: <xmr:0kZHag8xyg5rejbleKF4jMfbavkn8geaCGsncVIQ-OiC4MFasOlQ-yFyH1-IeuuWlYhC1lrOJrjaFzuTscyIwH0PnFxWEG55jVxaS6dN4w>
X-ME-Proxy-Cause: dmFkZTFIusyqErPxYI9TvTZysJsDRcg1ylMHaOR3Ssn+u9XexAtwJXGbO+jIzMpDVjj5uv
    s9y41Goxgj6ae1FK8cCkzvTO8wFJloudNpLvQeQDUxiEdLETpz+YP1zLL++igh48YZXcm6
    t6iQRl2F3TqshHkkDne7YlYhbQMvGktkufaj3JS/BAj8Ru4CZCy1pG8yi8r7eg2v7qNk2x
    T5ERNb7w7jz3Of/lko2cZ/Jpzu3jAg84eV4YKTzFBRKWJDzL7CDvCQpKLfOME4Kh8NG6Wu
    H4lKfRg9Dalm4rK/HKSZJYTtzEXRG1XsjobOIUO+DRAapM1BtTIidpInOg7Tzr/tvi0BpW
    4JgEvWintb6rHzeMjC3GIW1bIpUFofn6iuoNuEilSJ7ahasoVSeDicRLUZDKL9pOxojJM6
    m86RvLZ4QVXVoqQYI14v/FTWVIBdLKnXYyIHBpsFCD60JM7xtBadRBbd3VFSj5RZtElT6R
    cvcZ9jPiRP+psdq2dpPlA9NDTd78uzDCDFU2816PooUEZgaaxex5TbNSudvL/rJZTDmN/H
    DubksKcCjo7UJsaotduXc2Hyy7t+NfAkp7OJNBHMWoCTn0rEsmGTl5NsVvOCUWp+wFqAX/
    vg2GJD/DqZyMl55cuonlo7viQL6dBcXOsngRkpKDqAevjk0BSRTFdHKHkUJQ
X-ME-Proxy: <xmx:0kZHagfhyBjfvOqfFfylUov825HDFvcYz9oIsUatg1MlLw5qYp3HfQ>
    <xmx:0kZHapGVifYLgfoIGbPcm8UyzVISOGPsUHqPNcqemhltSVDXrDK60Q>
    <xmx:0kZHaud1Mj9seOLR5JtcB1ee9jc5aNJrPA_m1MZ6MdytvvN4KFFrNw>
    <xmx:0kZHajHHMK_StyxOCqYa2JZihK9FhboqqalwtF1h9Fh3QxMcNGjBJA>
    <xmx:00ZHasm-Y3juPf6mi5U_JoRnzwyrJCro-NF5qJmIbOtLP5wzN3g8Gs3A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 01:21:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 19fd0e70 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 05:21:20 +0000 (UTC)
Date: Fri, 3 Jul 2026 07:21:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Mike Gilbert <floppym@gentoo.org>
Cc: git@vger.kernel.org, adrian.ratiu@collabora.com
Subject: Re: [PATCH] meson: restore hook-list.h to builtin_sources
Message-ID: <akdGzbF7dex9XQwp@pks.im>
References: <20260701193928.358825-1-floppym@gentoo.org>
 <akZGJP1kVtjBFN_e@pks.im>
 <CAJ0EP43gyQf_XhCLCNEzCq9wMYXZBQX=PWjR-wYqoESSvByJiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ0EP43gyQf_XhCLCNEzCq9wMYXZBQX=PWjR-wYqoESSvByJiA@mail.gmail.com>

On Thu, Jul 02, 2026 at 01:03:05PM -0400, Mike Gilbert wrote:
> On Thu, Jul 2, 2026 at 7:06 AM Patrick Steinhardt <ps@pks.im> wrote:
> > On Wed, Jul 01, 2026 at 03:39:28PM -0400, Mike Gilbert wrote:
> > > diff --git a/meson.build b/meson.build
> > > index 3247697f74aa..bdc83843e8e0 100644
> > > --- a/meson.build
> > > +++ b/meson.build
> > > @@ -566,19 +579,8 @@ libgit_sources += custom_target(
> > >    env: script_environment,
> > >  )
> > >
> > > -libgit_sources += custom_target(
> > > -  input: 'Documentation/githooks.adoc',
> > > -  output: 'hook-list.h',
> > > -  command: [
> > > -    shell,
> > > -    meson.current_source_dir() + '/tools/generate-hooklist.sh',
> > > -    meson.current_source_dir(),
> > > -    '@OUTPUT@',
> > > -  ],
> > > -  env: script_environment,
> > > -)
> > > -
> > >  builtin_sources = [
> > > +  hook_list,
> > >    'builtin/add.c',
> > >    'builtin/am.c',
> > >    'builtin/annotate.c',
> >
> > ... that's exactly what you do. So this fix looks good to me, thanks!
> 
> Thank you for the review. This is my first contribution to the Git
> project and I'm trying to follow the lengthy SubmittingPatches guide.

It's gotten quite long by now indeed.

> I believe we have "reached a consensus" and my next steps are as follows:
> 
> - Add Reviewed-by (or Acked-by?) for Patrick and Adrian.
> - Send the patch to Junio with the list CCed.
> 
> Do I have that right?

In the current state you don't have to do anything. Reviews were
favorable and you weren't asked to do any changes, so there is no need
for you to send a second version. Unless somebody else chimes in and
asks for changes, Junio will eventually pick up this patch and may then
add the Reviewed-by trailers himself.

Thanks for your contribution, and welcome to Git :)

Patrick
