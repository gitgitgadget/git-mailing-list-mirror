Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66D7146580
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 07:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725434064; cv=none; b=M1mcMcGPPWQHY8mrRv7XjsrEBFT/Sby91Yc3l5+V4ENIL9sBVhAh2Lwptbtbp8rG/wMKt2bK3gU5IRrck+H/yMR4UWTY6jgM7eOpzDV2XBYtdtmLOVt0SemLciu849lHmCnpu69xaN3i1HcUOwHN91RMyKNTmfAHVWWcShmg9tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725434064; c=relaxed/simple;
	bh=WrLBUPmuBeh+riESqMwNpNX2i91KhGWZX/iGac1zmmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IleaMGm/pxVM7FL3D4XLASBVibuP0PhJIJ6E95ppai2HBorKM1ljSeLSXdJEXYCL7CVlrr2HiaBHyjQa3dGdhnJ3cXCV+V4TjLpsS56yc8bu8tkQ4ny7nhRxYAXW735paia08NFJJ0tHj0luE99fr70hMI1zpsOhHQCRrF8Zkj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JGHWUhXf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ge9IRs67; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JGHWUhXf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ge9IRs67"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E638913802AA;
	Wed,  4 Sep 2024 03:14:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 04 Sep 2024 03:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725434061; x=1725520461; bh=7QYjx5Gqoa
	67jJwSnGpGoNEze+SwHYiHJ3zxDfAFpl4=; b=JGHWUhXfNW53YF8JPm294x2hf4
	05mi2gZwvGir8Thtukx59R/aFKWMc9xKLmjNjYrufWXI5il+I9HGG1V7esNVvnbY
	ybSw319MvP3+G2ybc+qLrCF8mVHn2YLG8xP3rkWvm+4fw2xDUWGaCakCTh6LrWXv
	mCF5Ls0gehMr6peEtTbuWxbnypk33dxZprzu93f+rEpUuprSgLOiMKUh0ZGUOjPf
	X8nCiOqKz/a8RuUjtkd503q6XJ6CKGBQY+xLA2cZgB2xi/88He5GKEV6XmJiChmS
	hFe3vXoXIFGNh7WDX/maImqwAscYgATFQWJoFuqItNXiJbtTPDbCtMRKYN3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725434061; x=1725520461; bh=7QYjx5Gqoa67jJwSnGpGoNEze+Sw
	HYiHJ3zxDfAFpl4=; b=ge9IRs676dfGR8ZcrHFv+n9kMqqliyBy+RwNBgHGu/o5
	OQI3zj4qR+hJAg6YF7p4zIPPTNMvduWw4gqgVNvFg3xGzGQJcqxBEpvnna6WZ7UB
	T1g2iWUU+5ndtwZSRI2w1Kg0HWEAmqeCXk+BhwrsZuA8eVYyR5oPe2/ktyNdCBWE
	4fplLYo8x2kB2HUxNbLKm3JFZ4V6pQ+Wr+XxupEZGQ40IL6OqeDj8vAcRXOLyv1y
	C2Xgq1v800YDEAHlhEajQeyERMoeLcQVs0SDXkFLU60pQ+XwlGdyTC7tywEOEqLb
	uuzO4C43R6PCoQNcZYS+Un8MJ1QylRs/hL37wLm42A==
X-ME-Sender: <xms:zQjYZrA_XVoIyE5GNaWS46Oc-ltucQV32fAzCDXL39vUjsliJz3Hzw>
    <xme:zQjYZhhaIt-NDqoFOR3QzlQHwg3Ww9NxigvNfwoDsV_pQRkru6tj3MzOBE8UhUcUw
    A_idhGph1B2o5uNQQ>
X-ME-Received: <xmr:zQjYZmlEErSWoNbcGUGVABNXn4xZ6a0OEBX_zlb9YNyrkFv4zzXPApOwAo02xpcGEIne_Afj6rCRAAxhu1touA7kbB8B5kPqBFGXksy2suD4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehiedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:zQjYZtzi7Hg_putTGlD4cQXTAoZBVAN8772IYzJ6H9xP59IIXLMsCg>
    <xmx:zQjYZgQEwncUs2LWKpTnERnxL65R0_4vSBzUBBAU6GEuCq5YKIFQqg>
    <xmx:zQjYZgbqzfmqtbt3ZbkOvX1bX2zdgTZYq7DGLIg-IBOgkrIUDG_ZhA>
    <xmx:zQjYZhSaE8FxIF5H9DwBgk6DP_mEAAAZ-VV4pHxoX76n_nVndVYbuQ>
    <xmx:zQjYZlKdYVf5a9u2Zi5PLARJ94z6hDealpXXmivXU6I5ZDIJkhH4hbA1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Sep 2024 03:14:20 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 44a05d2c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Sep 2024 07:14:10 +0000 (UTC)
Date: Wed, 4 Sep 2024 09:14:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: James Liu <james@jamesliu.io>
Cc: git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 08/21] config: make dependency on repo in
 `read_early_config()` explicit
Message-ID: <ZtgIyjGnpwX3VvYP@pks.im>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1725008897.git.ps@pks.im>
 <b8aa5dcc0b67e3957dc65f38b7dc02a97cc096a7.1725008898.git.ps@pks.im>
 <D3X4D0DUL3TS.1FAOC0KJ08D9L@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D3X4D0DUL3TS.1FAOC0KJ08D9L@jamesliu.io>

On Wed, Sep 04, 2024 at 11:46:47AM +1000, James Liu wrote:
> On Fri Aug 30, 2024 at 7:09 PM AEST, Patrick Steinhardt wrote:
> > diff --git a/config.c b/config.c
> > index a8357ea9544..043e1c8a078 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -6,8 +6,6 @@
> >   *
> >   */
> >  
> > -#define USE_THE_REPOSITORY_VARIABLE
> > -
> >  #include "git-compat-util.h"
> >  #include "abspath.h"
> >  #include "advice.h"
> > @@ -2204,7 +2202,7 @@ static void configset_iter(struct config_set *set, config_fn_t fn, void *data)
> >  	}
> >  }
> >  
> > -void read_early_config(config_fn_t cb, void *data)
> > +void read_early_config(struct repository *repo, config_fn_t cb, void *data)
> >  {
> >  	struct config_options opts = {0};
> >  	struct strbuf commondir = STRBUF_INIT;
> > @@ -2212,9 +2210,9 @@ void read_early_config(config_fn_t cb, void *data)
> >  
> >  	opts.respect_includes = 1;
> >  
> > -	if (have_git_dir()) {
> > -		opts.commondir = repo_get_common_dir(the_repository);
> > -		opts.git_dir = repo_get_git_dir(the_repository);
> > +	if (repo && repo->gitdir) {
> > +		opts.commondir = repo_get_common_dir(repo);
> > +		opts.git_dir = repo_get_git_dir(repo);
> >  	/*
> >  	 * When setup_git_directory() was not yet asked to discover the
> >  	 * GIT_DIR, we ask discover_git_directory() to figure out whether there
> 
> It doesn't really matter either way since we perform the same checks, but should we do
> 
>         if (repo && repo_get_git_dir(repo))
> 
> instead of accessing the field directly?

We in fact can't. `read_early_config()` is typically invoked with the
global `the_repository`. That variable is always set, but its `git_dir`
may not be populated depending on when exactly we call this function and
whether or not we are inside a repository. With `repo_get_git_dir()`
we'd now die in scenarios where it's unset, which we do not want.

Patrick
