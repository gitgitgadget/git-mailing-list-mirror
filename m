Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29F73368BD
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 05:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772601391; cv=none; b=TS1FvRKBSvbbDAnx5MEXcLAUZX6UtuJnE/oe6/9iI30fY1viElAOzTGlSwRj0Wb7B8fXZp1bFp4i0iJcIQfQl6qXnyLpTWuBj8hlebDVQkoP8RbWSLbouZKWxRamjtLAjke3+Nv/6n3iEGgWivZWqAOBY8kHvAg3J8ForD6DsvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772601391; c=relaxed/simple;
	bh=iXKDOZ5naDRuRYhfW5n5cgzklrVpS9hlGfW7fjUOm/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IowKea5CU9vleW4qTNb4flCVpCJqnOKJxGwtT/uAyHhgdE85phofGrdhh9pE8i2O27rt3DW5lDIsDJgyDG24TwjNXQ0H6vt+tAojKE1nA3djHkR7ADG5Tivj8RNGIh1RdnJmcAT3q/iKDjWS8iPxqtvD55vvgr9C7XKuoGXEfLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PuGTtkdO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PmUFJR0L; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PuGTtkdO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PmUFJR0L"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 1E2271D0019D;
	Wed,  4 Mar 2026 00:16:30 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 04 Mar 2026 00:16:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772601389; x=1772687789; bh=YfmUx21hEa
	SnArtPSWOxeye0dRR8mYS9q47wpBoZB1c=; b=PuGTtkdOWezJZzA/6Jr+oDSQeK
	ziEZsmCG4p38dra/AG4JAFmXfOrWsCgbFuAvoBiW6FJmh4mA1bMQut6LQ789yB8L
	lxzH+9p4rBluMgCLR7ZjL5WGbTfPLkOUMgltCtsMd+WZWHQb+tT/1vPpoO177Jwy
	gLC6G9FGbFkznmIZd/2BelyeHoymzosHIcfJgFhgNvBpSDueWR7FGPkgT3s1x5C8
	3qP6dsRGqWZ6vg0FLzF6L/oACTZPa8DGw5UFzHV/ScPNgmNMVLSXgoQ6z9RRzthO
	fxZ4zYGsTtK1QsesP6p8KpbUpfV88RoALrrJF9g4agv/Qlm630dZQZhigpiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772601389; x=1772687789; bh=YfmUx21hEaSnArtPSWOxeye0dRR8mYS9q47
	wpBoZB1c=; b=PmUFJR0LBd/vIX+CPe4+OkfEVKKG3euT+Q/rizZDVtqDmU3D/8M
	9EuJWFZXrj3OCHTq0ivuFphYrxTbhFnE6wajzMMsUIblDEAPEIXdMLkyDTiSYSh6
	xH0i/Fg/PwC+VPOoy0M5y2+KAnHV6jfaeJMns7n9oY3mjvcbc/g+V6ngyW1iaANL
	Kv1UVjuaQ8poE0lHnepMDUGPXU+l48H32YDb443hFPsQue3AWsz1Jn6q33jjIbx0
	g+MG+cw5E3rFhIQtvAaF1hGWlchUwFV2SitQjB4AAZAIRRe719vv2vXzXtKBkII2
	1ph8SdB1rslgDGnI24udtDZoNnrgGWm2oIw==
X-ME-Sender: <xms:LcCnaXpp9XxfECUg5uvD-lFExyFQ_h3-vqj2Utbe0ny23xa8mEjrQg>
    <xme:LcCnaZF8i2tgrSwL47f4pOmHvnzBwDsKdHpjoDhA6WJ_DpWqSwFJbGxvsJmnTTLcw
    6Oap42y00A0LMsB6XockfzQxu4n9WOwG1_6CQx2KLx37GbxSkIicA>
X-ME-Received: <xmr:LcCnaRlYeOSA0sVvPq5rsATRGJw5NLCPQI5m_dO1iGqlc9nBi9KrL9_SxHDCWpPW2xmPfJWyk7FHT2H--cKsiKWlaYQuL-bCunHllG9stzAEvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedvieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohephihsihhnghhhtghinhesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:LcCnaUl8OjRp3xV0n1tK0iXA8yE9ld8juzn0ftnd1aP3PLWuM-IzyQ>
    <xmx:LcCnaav8PRR3jWzdAvs6JBFYKuripIdXo100EuZOppVydCrbuRcx2g>
    <xmx:LcCnafm3m5GsJXyiMihwc3mPcd6sL-V7_0m3dcRlLHPZTLa167wHPg>
    <xmx:LcCnadsU9tv3Od7OKTOnlupqbBshxryCmr0XBi-UpuUt3QKtC69mag>
    <xmx:LcCnaREmC_fxILKSIy5V4ZzdWJj2FgJgs0jDCXYpuF5K61g6zXfBtqtf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 00:16:29 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d365a634 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Mar 2026 05:16:28 +0000 (UTC)
Date: Wed, 4 Mar 2026 06:16:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Yuvraj Singh Chauhan <ysinghcin@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 2/2] t7412: modernize path checks to use test helper
 functions
Message-ID: <aafAKc41y4CdZmUt@pks.im>
References: <20260303175750.361563-1-ysinghcin@gmail.com>
 <20260303175750.361563-2-ysinghcin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303175750.361563-2-ysinghcin@gmail.com>

On Tue, Mar 03, 2026 at 11:27:50PM +0530, Yuvraj Singh Chauhan wrote:
> Replace 11 raw 'test -f', 'test -d', and '! test -e' calls with the

This explicit number of course made me verify that you didn't miscount,
and you indeed didn't :)

> corresponding test library helpers:
> 
>   - 'test -f' -> 'test_path_is_file'
>   - 'test -d' -> 'test_path_is_dir'
>   - '! test -e' -> 'test_path_is_missing'
> 
> These helpers emit a descriptive message on failure, 
> making failing tests easier to diagnose than the silent 
> pass/fail of the raw shell primitives.

Yup, the reasoning is sound.

By the way, you have trailing whitespace in the commit message. I guess
it'll get stripped when Junio applies the patch anyway, but maybe
something to watch out for in the future.

> diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
> index 41ee035e3c..cdc7f59e12 100755
> --- a/t/t7412-submodule-absorbgitdirs.sh
> +++ b/t/t7412-submodule-absorbgitdirs.sh

The changes all look obviously correct to me. Thanks!

Patrick
