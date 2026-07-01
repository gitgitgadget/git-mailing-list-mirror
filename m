Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21263BF667
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 07:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782892598; cv=none; b=hTDYCqip6SqdDQWQLrFQA5aZAH++mLgneVYg1bGYuwDGw/WGCtmtnN11R2NCwQ5V2yQS803qdizlD+xd5fmtUwvw9/kNiIChIAG83W40o1epodmPpfMMoW6b6DiNPWsLhY6fZ7TYpwrh7FZLPgmrM9aTOzAUwVdf2VOnVVTCbIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782892598; c=relaxed/simple;
	bh=ZWaQtHZ2+IEjeCQU2K/Wr+p0pCxtkf8qD0/mpS8cUSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7JHOMKMY8tD/6A2rJs925ACbw4RHLXEed6UmHOKmBhWczm6L8gVD8YSXiwn9JbcMMPnqt8zohWRcV5a+WGKWUI0zkoJbRrY289MkzEGToDLJFCZsp3KPpchyonBHIksrpXmlcuEvV9O66N3za5JtoPBtxsaWDtTKPKxh7T0wTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Pkt9QU5R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dg/nc9dr; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Pkt9QU5R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dg/nc9dr"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 00B39EC0121;
	Wed,  1 Jul 2026 03:56:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 01 Jul 2026 03:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782892595; x=1782978995; bh=2Eq7GDm+HY
	dpO7qtXgey1SRNwAZWEuTXp9TwdH45wvw=; b=Pkt9QU5Rwnhd8Ory2Z9nH2/XlK
	wceaYyv85mfVQF0sw3XguhUxaNNrAG97mXHZ/nZKN8eeGNG+Rh+RFkVmgYrGenrr
	XKrRGyQbV210wiQ6E0+DuUMVLzbYuAek6S4InnM8Id8DIDmL44bebNyld9RQNFdn
	8CaxiuMI+XSHWhZ4ilQWn/9hIAL626lNkV/CXwrG4QXs0zGPVDgD+gOhREkc6JMH
	2p2TF7dNrBgiXsydP75u2bN8CnwszCiVZd+o4LaOzERDQpGAAUv3SaRihyUxKFns
	oy2JlJPULt24iRvo92JAa34GVWVRLuLW+Mm0+hInhYf/5poufXtSxNV2eS9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782892595; x=1782978995; bh=2Eq7GDm+HYdpO7qtXgey1SRNwAZWEuTXp9T
	wdH45wvw=; b=dg/nc9dr+WS4xD6ijqOoBFLIBsj5S0sJk4v4rd4xto4GFSRE3zL
	GDvhMRWSGC3VRFPkQWWY7hNm8HDqi14KL2F9cRgdZUwsVyYFvmSW2aBSjiYL8bcL
	/zybE349SYswhTdsQPC3frN1A3wuBli2JZpmSEND9BWe8DJ1OVwiSgIKv+gdKCVs
	uq928gTMJ4Q9GuBG0yWgSNAVgRlfzxtPtOTFBbEAcKz7alW9v7JVfQPxgmX+uaNn
	KKszmI0QqLW3zrXGETk47gX9zO7CCe28xaFY5Pb7CLguQIkU1UcIyj5C3szWb1UW
	D7WlFgavXs9SAecgx3NVSn8KBLTaLZTODHg==
X-ME-Sender: <xms:M8hEapy3KtEdACjUJ-zsexPG8QPp2dY8Nmd1yQjQR3ZGENjpxy6CQA>
    <xme:M8hEagtNyK0-dqQwT34s6DplFihHt0pZucmIWlsDKWBnV3D6tK1dYl2r1JW021vF6
    srMgR_MiFaTL52kD8J9ngPpyDhIq09RPLVek0PXIQLx8t08joih>
X-ME-Received: <xmr:M8hEagu4Irg6zKOHTc5R_K5c1gxeDBqLQ-nrFMfbpOAo0bXG9dGyP2HEkTh5VJXNBCRm9PI4sCqKyKreMD7Rhkl1trB5cu-kEOH2StOSFSk>
X-ME-Proxy-Cause: dmFkZTFtX1O9DVmM431WHiNG9tQeWb1YE6n3zMc3dQdXijCycgqkj5Nj93P41TECjph0Ez
    GVvkliBKTzInmvmcE+bG3PvoNUfSg6oQnnbS3ykLtq05kN2en9CbuNKkcjt15mDFiJK9dw
    Jsq5wz6rsIvAoRYWCLC5KZtXAuNPmKbacibAwmerfa28r9/7ZVb0nr0nu2d0m0Cx+F7hwP
    qPFn0O/k/V9+24hvVyPI7PFTPNyJMB4lPbqZf9oD548K7z1On0Xu7sHVx+FPSwrCCynPqu
    haxkfLccNp5zi2cODUOvlLAoDyvsW/anKwPLwU5fXl16xCjR/W412iEsHSsnbXOOJhLETs
    FHtqTy48kaQyjM9hzFRSwxxFOJN1XOv8uxQ/rAMGE7okLAqXKAtl7kPTOCWM88V1R+eZ8y
    NFAy9N7ktM8WZLTmNzWT5ppZesz4ASA6BcwFOy3+ZSwsfdAygjk3vF8fyCgI64gTJFxHso
    mHnfiYrznl8wKieX4bwQlbAHwrDfFrPAI7qMPQyOY7PYIfL2ENUAAnQ3cnoI1+6mOdRzpZ
    w38OobMeHs4cLHa6JsY2dII7FGnyrSwW/u2XbPT6claLXHtUPBSvkFDD6c3sGXsLbl/Li7
    rBjXSLX6glsjzUh2EnTma9zXJLWy9kv6zAo4J5jXQw81FYFtmuhV3vLKX1dw
X-ME-Proxy: <xmx:M8hEalPCELVDrIMlUhR_c3t5CTrsJQCr1mt5A4_rgCquMmrW4id1hg>
    <xmx:M8hEau3Knq86O2r6A4Gf3nSdV5YGQxbKpxoDceBAiTlHVyIoCsAaQA>
    <xmx:M8hEahPW-hPp5m4Cs0E-obbIChkYja0lTtr7ammv2uE0MGnKfLslyg>
    <xmx:M8hEau1BeR-iw2lcjHvqqrcrRXbFlRZMpoLt3o41WLiSDCrr7NEbig>
    <xmx:M8hEapOGR0WbE1tyARVo2ZRsvjACPQQDJEjip9xsbUEZ5JOZvLVwa8nD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 03:56:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 92283a75 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Jul 2026 07:56:34 +0000 (UTC)
Date: Wed, 1 Jul 2026 09:56:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 05/13] run_diff_files: avoid memory leak
Message-ID: <akTIMM6qLfDNdg-a@pks.im>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
 <860bc8f52dc9be8bbfafcda296be831a1ffaf1c2.1782889472.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <860bc8f52dc9be8bbfafcda296be831a1ffaf1c2.1782889472.git.gitgitgadget@gmail.com>

On Wed, Jul 01, 2026 at 07:04:23AM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/diff-lib.c b/diff-lib.c
> index ae91027a02..7ba839b4a8 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -152,7 +152,7 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
>  			continue;
>  
>  		if (ce_stage(ce)) {
> -			struct combine_diff_path *dpath;
> +			struct combine_diff_path *dpath = NULL;
>  			struct diff_filepair *pair;
>  			unsigned int wt_mode = 0;
>  			int num_compare_stages = 0;
> @@ -164,6 +164,7 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
>  			else {
>  				if (changed < 0) {
>  					perror(ce->name);
> +					free(dpath);
>  					continue;
>  				}
>  				wt_mode = 0;

Huh. There is no assignment between the variable declaration and this
call to `continue`, so how could this ever plug a memory leak? None of
the other paths seem to leak the variable, either.

Patrick
