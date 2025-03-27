Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C2B20E6E0
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 10:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743070421; cv=none; b=QjLSD9ievTHk1bqaIbKSA9hrBcUiP8lmFpmtIi/7zqmDyKxBJsbdpp0ToM4sn9V61U1+HtCxGEZw7iuSwfDaxUcZLkZJ28+Bf/RmtFVUQ3d/z3ofLVkwDIlQLhsXkOW0JP+GqIXwLll9LLkogKCXmUk7Jw7Cjr1/MUkzT6BMLzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743070421; c=relaxed/simple;
	bh=CnBdSuK1G1tdSHJIIAfUsPdqzRx4Phgt2JNeMbaqXfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2Yx1wmW5OFEDzHHjahXXe2eSwwe+uoLe9QQ5vBd9ui+xcm3M3uaLYQfNkhVUJQ8o1JOWcdAPxIqfCm4fJ6PsHVVwP0dydMl72w7n/nXFeIY1tFV6kWXxVeUVr+mwK6R4ioMkQbY5TMx2JbPret1y4HErVd+Lddw+gvJwSAqnkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pnmLJIlj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gpp9SvP9; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pnmLJIlj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gpp9SvP9"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 7530813838F2;
	Thu, 27 Mar 2025 06:13:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 27 Mar 2025 06:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743070418; x=1743156818; bh=FFyEJ8NSn+
	9WCEho0nRsqD1vYgaI8tYXXljE8ZOcTtY=; b=pnmLJIljvblxf0qv0f0m2PvJEQ
	C40TVxVApoICQQ0ZYUoNOqZpEJ/AzpHQEY1syVXABKHu+nxiW5Xb61MyrSs9gELw
	nRRUYvgOLyDgWTCd4FpSW3FDU+nx5Qw9N1GeO0u1SyT5iALXPOY5kch4CzwO5LYh
	+KJh07I4M4L/wg+iGhONTdVVUuVqL84OLJBR2fji+T7Fg/yZN1IN3EcX3I7dP7Rw
	uMxSP7uiUbYudLW3dfbfGEXFEZRR7AOu/f5Z5fZZuZn+ekEj9Ri4SR9167hg4yjO
	naWrejSiiHu553kTiATVvo55KYeajw1jdWiZP7reS09BtVl9anvZ1f5mUPiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743070418; x=1743156818; bh=FFyEJ8NSn+9WCEho0nRsqD1vYgaI8tYXXlj
	E8ZOcTtY=; b=gpp9SvP9pVnBePvyBn+nXDBK/antzV0AdXAeJLSGwknPo6UN/+r
	SZrfwhPOnYIbG0HjHzkRPUQjbb8So21NzsCylHudSdeVrDFLEJLfk5ku3MhH/EFE
	a+Nyno7LQV2NJRsmCuAzvRyiNc+DFS7R2f3tca0AND8w1u6NmqcqO77RSSPQc/IO
	YTg3ltbrl8GfkLfRC9hOFRhH5Yb9tXpKi2EGN2udWeYg2JREyjpXKtZ5/WgPg0xG
	PaSme5el5mkccgU3tGsUemsH5GekopQqdGUCpNsih3rucuB+uRl/QHSMttSgMseH
	DoQhovx/javlmZkLcv2HgPxnHke1sq+LTVA==
X-ME-Sender: <xms:0iTlZ5IlpdgYSCDR462nuVP0v763-0ZJ_2P-BrWwPbFFNyQBLtT4OA>
    <xme:0iTlZ1JHoCT6yeYeTsRU0b6NI7ety9hA9c5vta4_n35rUibd8XjjxRz_CARIRNbYn
    N1uLq4kaRz7-RICAw>
X-ME-Received: <xmr:0iTlZxtiSmuQRW8-vw4HFrqPbKIN_XXdO23zD0pmj42bF4BGysjgih4p-ZhY-Lw33xuO4hdcMDohlwPIHQPvQL18qSzd2JzDIvnNk79LQ5jEDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtghesuggvsghirghnrdhorhhgpdhrtghpthhtohepjhhohhgrnhhn
    vghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:0iTlZ6Zzl6Jsm3xMaZa7J1RwTce23zXt_CNDq61S-E7gKCnSS4ac6Q>
    <xmx:0iTlZwYmrxlmqhw-XKjFogzfAzSSErA-cJQDEIv0j3_9ZgTZNJItjQ>
    <xmx:0iTlZ-AwKw6rE1hZn2O06716rULE7vmPDvFDJw3kT38QAi4_Al3UIQ>
    <xmx:0iTlZ-agapfAKMlXOm2EOxulm01RuqmNJiWgGOifsBf4YN1Xx9a08w>
    <xmx:0iTlZ4HS9LwhABA2ha3mZB1FEnQM_KbPXZ9X1EJGmLm-agsE4PrOomTi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 06:13:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id debb083f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Mar 2025 10:13:35 +0000 (UTC)
Date: Thu, 27 Mar 2025 11:13:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Thorsten Glaser <tg@debian.org>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: gitweb.js build mistake
Message-ID: <Z-UkysDjZZcVFfyM@pks.im>
References: <070641d0-730c-7d92-af4a-9157dc1edd3d@debian.org>
 <Z8FfeEDHZocWHKeM@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8FfeEDHZocWHKeM@pks.im>

On Fri, Feb 28, 2025 at 08:02:16AM +0100, Patrick Steinhardt wrote:
> On Fri, Feb 28, 2025 at 06:34:43AM +0100, Thorsten Glaser wrote:
> > From ed9863971d37ed53628a5871a4a569ccd6287f53 Mon Sep 17 00:00:00 2001
> > From: mirabilos <tg@debian.org>
> > Date: Fri, 28 Feb 2025 05:33:10 +0000
> > Subject: [PATCH] Unbreak content of gitweb.js
> > 
> > The former $^ adds all prerequisites, including the
> > (proper) new dependency on the generator script.
> 
> The commit message could use a bit of polishing. How about the
> following:
> 
>     gitweb: fix generation of "gitweb.js"
> 
>     In 19d8fe7da65 (Makefile: extract script to generate gitweb.js,
>     2024-12-06) we have extracted the logic to build "gitweb.js" into a
>     separate script. As part of that the rules that builds the script
>     has gained a new dependency on that script.
> 
>     This refactoring is broken though because we use "$^" to determine
>     the set of JavaScript files that need to be concatenated, and this
>     implicit variable now also contains the build script itself. As a
>     result, the build script ends up ni the generated "gitweb.js" file,
>     which is wrong.
> 
>     Fix the issue by explicitly only passing the JavaScript files.
> 
> > Signed-off-by: mirabilos <tg@debian.org>
> 
> We typically require plain names instead of aliases in the SOB.

> > ---
> >  gitweb/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/gitweb/Makefile b/gitweb/Makefile
> > index d5748e9359..2a8f97cef8 100644
> > --- a/gitweb/Makefile
> > +++ b/gitweb/Makefile
> > @@ -118,7 +118,7 @@ $(MAK_DIR_GITWEB)gitweb.cgi: $(MAK_DIR_GITWEB)gitweb.perl
> >  $(MAK_DIR_GITWEB)static/gitweb.js: $(MAK_DIR_GITWEB)generate-gitweb-js.sh
> >  $(MAK_DIR_GITWEB)static/gitweb.js: $(addprefix $(MAK_DIR_GITWEB),$(GITWEB_JSLIB_FILES))
> >  	$(QUIET_GEN)$(RM) $@ $@+ && \
> > -	$(MAK_DIR_GITWEB)generate-gitweb-js.sh $@+ $^ && \
> > +	$(MAK_DIR_GITWEB)generate-gitweb-js.sh $@+ $(addprefix $(MAK_DIR_GITWEB),$(GITWEB_JSLIB_FILES)) && \
> >  	mv $@+ $@
> 
> We could avoid repetition by filtering out any files that we don't care
> about, like so:
> 
>     $(filter %.js,$^)
> 
> In any case, thanks for discovering and fixing this issue!
> 
> Patrick

Thorsten, do you plan to send another version of this patch that
includes my feedback? Otherwise I'm happy to bring this over the
finishing line.

Thanks!

Patrick
