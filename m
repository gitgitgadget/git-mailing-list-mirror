Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FAA3EC827
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 12:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790772534; cv=none; b=K945GW3uHmuPMr9KNbaLqvIF1trhVcCJHievn1EhaK3W4dnzuv6Yp0zKtHLdmUXts/LJrwNegPluZSLgnKBobwII1GRiSjV28trDTZdKLDgUR2h2apsQVtpe8E5TbK3A79xz5clP+Y+S0M31g7UMFWs1fnAD3r2fMXzqpntRyaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790772534; c=relaxed/simple;
	bh=RP1pjbNpqIhnUyS9BHTLshwJO+t5EwX+/236eoLf4XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggJkQC69eP821IDZKN0NhfV+vr9oP1fMi4W5bkzY9C370MqtPj26DKJOBFx6DmeRPmj8x1DaxPBcV/6eSUjF3M+ktDE3qgSwQM2gmtBHlWfbm23+RdclLBQ/j6QaHGpAUr5uqM2+6QevR2jeYp+68ID0Ysb3YfuHqInnxFy6ikU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AbniVziv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dNKdK23m; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AbniVziv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dNKdK23m"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 62553EC0313;
	Wed, 30 Sep 2026 08:48:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 30 Sep 2026 08:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790772521; x=1790858921; bh=lCzqjHS3n4
	/IaiLJral5+Mf1T/iriyuddi4fQm+Yx3A=; b=AbniVzivYvEH1nwUceW6W/IrUD
	ae8E/pwCyFhI1DROR5DFq9BOlX/sh9/tBwmAJqAprzot6yAa6RTKB4wzPx+kG2vV
	jtX+SlLgjVQyJpTDUSHruYAPpW694v+0Xf/e7tnGXDjgZQTmS5BKPlR0WSciloyH
	0PGd/m0p3TEr92o+mFGjS02Chye11tUgXHUt70oZSV4Mkjrlt6ArWjx9ofQuL+5r
	RLqAABYr1vjBlL0I49b7FI435wwYP4sBiqVDj07zIjFlVzsfca35XPOH22Nw+VJ2
	ql3ooBgUFnL2Uexqu+ZDrQuHlkcT3fc8VBCijcD3XXrSc0t+1XKMC++bJVxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790772521; x=1790858921; bh=lCzqjHS3n4/IaiLJral5+Mf1T/iriyuddi4
	fQm+Yx3A=; b=dNKdK23mj7O8IcqjN7ZoFmK5wxYy3e+gF6rTucmqXuzatX3Xxen
	5jrOsluZwwr8OiHsUm9RTkHxp4ARVIXg/pNWJ+33L0cFBr7ijrg1sZVmgGG02P/N
	LyRnQ0zrmfdHSASZaJZtRXkPHDsQ+iwTImc741z7ME752KGQCm4NXx291bZw036k
	Rqh+iFj4RwP5HOTMvEeTawa3Uf6dFo6QO0aGaM0JnG+Oqn5xWM78IgQ/bsWAVlK1
	hn92sAIVpbR+btdgIWCyz1mNoSu3CR5Mt2y3phhIbBbJY+HML7VnMApIFukDypwZ
	rJ1tegeZZ/o+UCtpG+7f28Jtfskc02wRtPg==
X-ME-Sender: <xms:KQW9ahon2hxpZttIo2vbYHFgkl5slblT2Dgf8Z6EZjANzk77dlMf5Q>
    <xme:KQW9arH5zZHXDQvNdZ6w8ECKQoEX_JWsUUmEBD-a7p6myIKL8XkAqb30dJd83ynvA
    zrN7Bj00itCGf2hIOMzt5oVOEim9Mh-u7-JF_nay46uOOXIQEl4-Xs>
X-ME-Received: <xmr:KQW9arlesgQV0zISfd4J8KQJCOrJA-Syk_r9x8Wt2EynCqO9ZHfmvA>
X-ME-Proxy-Cause: dmFkZTGSGPbchAXRsp8fqxQf8FU0w7ZuBm7jHTqRb74UOD9mGiFBHcX8pODgUCsvaRIXu2
    ncveyKOZqGrJrbSQYmOX/osAPWMmXzvqSwjXm8c1hkke1ozmNiTzPMftWxIzzbB7vPiUHl
    iRo4niSC+S+/jzeHbSdx7eoUx95n+gqQbny6p3eRfjtIyp6aX+2QrM35iVi2/glujIqI5H
    hgkpS0HWFL6kqqhCfXGVM7Q6qMv9PPFA41T2n96aQCajjeDQtRkk94RgPDv0ElCz4osbYR
    jw1R2sXIPA2Rf3mk4cm34f7JRRTuYM95Dofjm1WB4DiE9OWOCr9GAnYhj1DamtrXuYAWXy
    gbkBJpFxdWLsbyqg48zLqgRxejT6xBhs2Z3ez+7xSOorSS7+EYsJKusrCqZG7NzLrnYrvJ
    pm895bIZ3IjwGVTOBRgBGuGnLz4/q+hZ55idIfjpNVaeiaL7fft2mEYmqGi9yHWVcZ44FL
    EWcTpH1nzMAAMYEv/c42VeWIJE9Q2Hg8oh76XueBV0K8FBG/sNQ+XK9DgsBvt06vsgwKIl
    Yoo4do/lUw0gR/tcH7GKucHJBmyeC+DydLTBtGtATHOI0z03NpxtLwyvSPZpqmyrQtjh0P
    30X+v2DbHAVSerVGA0fAp9hu10fch5njGzQWec7J+PCvbvYZAKlFmgJAbOSA
X-ME-Proxy: <xmx:KQW9amkOY-pbbZP2Kr4AmeVTA-BUoukiz6Q8cDXV8oxjVK_BCIrI8Q>
    <xmx:KQW9akv0TIzoXgbflc0x1jRxp7RoRYKhenAIZpOxsSRm-mP6bds7Eg>
    <xmx:KQW9ahnn9CmwO3XQzsc2dSbadfR3hYx7AZYKorzKXKmEz6YqKvK0vQ>
    <xmx:KQW9anvlxQubppX3ymuZi2iVI84Y15ragCFGw8IhODX1LOobCX2ckg>
    <xmx:KQW9ahnbWNGu-sc6-_vV3MaKR87L20ktDRH-ec0mnV6wwdtxtyFLhUaS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 08:48:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cd110a44 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 30 Sep 2026 12:48:39 +0000 (UTC)
Date: Wed, 30 Sep 2026 14:48:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 7/7] gitlab-ci: fix hanging MSVC jobs
Message-ID: <ar0FJP9cAWFY7SZa@pks.im>
References: <20260924-pks-meson-improvements-v1-0-90b7f79f1c4e@pks.im>
 <20260924-pks-meson-improvements-v1-7-90b7f79f1c4e@pks.im>
 <CAOLa=ZShU_FhuudX6JSPO7q6w9xBR-QRyEd1UbCZ15o-S3xtqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZShU_FhuudX6JSPO7q6w9xBR-QRyEd1UbCZ15o-S3xtqQ@mail.gmail.com>

On Wed, Sep 30, 2026 at 05:26:17AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/ci/install-dependencies.ps1 b/ci/install-dependencies.ps1
> > index e3b367fa54..2ceb5dd99a 100755
> > --- a/ci/install-dependencies.ps1
> > +++ b/ci/install-dependencies.ps1
> > @@ -53,3 +53,11 @@ Invoke-Installer msiexec.exe @('/i', $mesonMsi, 'INSTALLDIR=C:\Meson', '/quiet',
> >  $rustMsi = Get-Installer "rust.msi" `
> >      "https://static.rust-lang.org/dist/rust-$RustVersion-x86_64-pc-windows-msvc.msi"
> >  Invoke-Installer msiexec.exe @('/i', $rustMsi, 'INSTALLDIR=C:\Rust', 'ADDLOCAL=Rustc,Cargo,Std', '/quiet', '/norestart')
> > +
> > +# Disable Git Credential Manager, which is auto-configured by PortableGit.
> > +# GitLab's runner picks up this Git in its cleanup stage and runs `git
> > +# credential reject`, which hangs in GCM and makes the job time out.
> > +& "C:\Program Files\Git\bin\git.exe" config unset --all --system credential.helper
> > +if ($LASTEXITCODE -ne 0 -and $LASTEXITCODE -ne 5) {
> > +    throw "Failed to unset credential.helper with exit code $LASTEXITCODE"
> > +}
> >
> 
> Nice, for reference the runner team also has a fix on their end to
> disable credential.helper on their side too [1].
> 
> [1]: gitlab.com/gitlab-org/gitlab-runner/-/merge_requests/7470

Yeah, I've seen that already, but thanks for pointing this out to the
mailing list. I guess it makes sense to apply this patch anyway so that
we don't have this issue anymore with the current-broken version of the
runner.

Thanks!

Patrick
