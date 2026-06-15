Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27F8332EC5
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 07:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781508135; cv=none; b=frw0COsVF8ZU4nXtvEXmLdTY1sHMdZCJi6nnb3tfHeVg7rnhy9yk8uoOQ7WULcetZrhifiAQWk/MwQ78nVitNW3YjmyogdKXc7GovxaT0fUIDETX/ivcVzyVIZf8SCtyKndDzzBgxqV/5XYvqvG/KDLg87DC1TWhZjC4e60pqi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781508135; c=relaxed/simple;
	bh=yH88odHJPrUNcgc2bPeHiAdTMMNwlVUsiLExrNmpAbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZxkMUGiKLbUj/P+J7EvYrNXWo+czNe5FuC3Q1ndcm8Jw3NGBkjJDQUdF6gLhbSTpqfQeQlTUjz0DAUKgGyqF+GJmm0fAn4kUDu7IvXCe3SAne3IDOm4XXVbEE9IayvqIZkkkpjeVvMu6QbJJY10d9SDNGnhI6hP0gJ6puBsuAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R6rZCAyx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P/mWGkUC; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R6rZCAyx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P/mWGkUC"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1EAD77A0048;
	Mon, 15 Jun 2026 03:22:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 15 Jun 2026 03:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781508132; x=1781594532; bh=n2qyoMjlVA
	jUFTi6pAu6jJY18ETfAafZRfQd15Wzorc=; b=R6rZCAyx/B/LVG6Cp5cDjQszZm
	Auvu7kKcn+P6laiRwzQK0em1rTkgWPVuyx7xTMOE8N9Q8SMpA6r04IpSu1illg7i
	EnCpdwWh6MMMVgmvlUs/gAXrYfYCmErbeexAxl/8IeiLiI/yG4wtcZz+oDeTCl64
	Y1SmikBbHAqjptsLMnk61+tgX2aFWw881TndDSJkG4hywm4xnY5f0WQGYNA/BxLe
	b3hanuGedQV9FQ5yYar4E2hQWK0xEUIdDgTZLo0CTnJczGY9xnTx3c1s4aJhEm3E
	iibmC858+JKjsu9f16fK/p4162BVoqIlodi1MN2Ztg/4wvXY974gXNfZ5Amg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781508132; x=1781594532; bh=n2qyoMjlVAjUFTi6pAu6jJY18ETfAafZRfQ
	d15Wzorc=; b=P/mWGkUCI63DzKaDLnWJvcQFbSXFM3l2Br46NFCQgZaHco9D7Ys
	oLiRXCugJmoDa8Bn9PHo0sq+ae5GpBKWN3IZkW/7exEyn+Q5FPOOepeVPaMW4/zz
	6l3fS+5oJaOXTTMrm2GeeYkeXPh6eACW8LVjIciTn2fJohF1x/lokxamFwsq8N4V
	dA57z+tgLrY/T/OtJuV+hGvOhmw20UBWuACc9f80y6IGjut7o/DqWDmewE5Lb3C4
	5GhArtNd2TwsDrv/bxZ3fOcVfHhwKXPgx9fqHm0s2tGpmBuE1mSPyFe0mGMYUPId
	019BQi3McYIiHr9EJtiwHBDt9vXQHqCbOYQ==
X-ME-Sender: <xms:JKgvamiHXrTg0j7P58ni9LzUj0Ax-x8W_RTf8S68Jl_h6gwt8_F7jg>
    <xme:JKgvaucOmW80UD04ZQZCxeQt1rHKuuTJkXxy0wzkWet_QHqTB1vMWyheKJAzZpLDx
    RMKrwit7dH1ETdDtTqGjkQIGB9rjBLGJMMHY5cRKHySZ8qC-IHDzYI>
X-ME-Received: <xmr:JKgvarfqAEux77DBqnTtLVOzWOHTzyJJIO2koOzX659Jzry1jdHiB_gHSxLleAnquv-M8bQQ8bf0R8egIsG5ZuUANgBVY-EQZ_tX3PbQwg>
X-ME-Proxy-Cause: dmFkZTEJmae7FbYDZB2vkTDrxaI6JqtRsQ3YZsfC4jwVuQJKQGHUKGmlMQYPUDDwLP4XF2
    YmBm/ox3uabB8lFCUonlTyhw7S72Z+fJ01fj3dZ2Mft2gmXOliEQObUMJy4ehgF9HbGtk5
    H1N1eFywUJ/y8Hu2ysEf5z22qhO6mXT37CIVdc1jBOmpGMeVgj+Z2YS4Fb3WMOwcidA83X
    YO5WpwrRub0qLfUOmERKxyPyP/Ulco0pu2TNnKJbzvzZSrQvP+x88VcEG32afdU+/lXHmm
    36bCVo+mcqvA5z33X55QIL/PgIISdln7U7lZGybrzj8uYKN6ZkeoXH5af90WbkA0YRIgsk
    QA95L0F60a0nChuIbVc905Mf2Hk1TBCNv6+XwjeKmyRWuyHXe0zrIRoyH9Ms2zty7uBKZt
    /tWnypIwOjFx1+GuubG9vP0EbJIzdAOU03vmh/SGID3w3P3aqGoG72bCxoqUY9doJPtibm
    4M/GNXpb13SrLPcGe5//vqRXBUTmddQLiavULjgbsJD8poGMW0kXvqjOECZdzSj1oBO8lJ
    UOGNm0Tvx6DKo3OAS7fUt31Vp3fTgWKscnmflvIsJVpxbuuD12JBcZLkWGwxyhSTdzH8+I
    gZ5WjveOFrE3gB4TJ4Qc9JWQYZrDaj6sBljxVrfaHb/W0FG0Fmt43AF+g9lQ
X-ME-Proxy: <xmx:JKgvao_dwr0dhPC7k30MY1HK7L_iuMwxhnjecnCAO_VNUuqTwxMtXg>
    <xmx:JKgvanlLPIugpZU7XYBc9AJ_cwCOB3flBvPOh6a-4kyn5Pbzn4LfIA>
    <xmx:JKgvaq9ZmADB68Op99ry5Uz-JeaJ3yoO-rqq2MEKXI6jANIkI_m2_g>
    <xmx:JKgvallzmP4W5TUAVkNasFXORqERw-l5dOB8DjO_rJmXCHy5KEXQyg>
    <xmx:JKgvap49EZj3LQwYWODS2tCT2QFtVa5dmP4CAKeLdNzSWNUvdUFmfWRc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 03:22:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c99afdd2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 07:22:09 +0000 (UTC)
Date: Mon, 15 Jun 2026 09:22:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Koutian Wu via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Koutian Wu <ktwu01@gmail.com>
Subject: Re: [PATCH] gitattributes: fix eol attribute for Perl scripts
Message-ID: <ai-oHtHFsyhnLDWA@pks.im>
References: <pull.2151.git.1781497525828.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2151.git.1781497525828.gitgitgadget@gmail.com>

On Mon, Jun 15, 2026 at 04:25:25AM +0000, Koutian Wu via GitGitGadget wrote:
> From: ktwu01 <ktwu01@gmail.com>
> 
> The *.pl pattern currently sets eof=lf, which is not a built-in
> attribute used for line-ending normalization.
> 
> Use eol=lf instead, matching the neighboring *.perl and *.pm rules, so
> Perl scripts are checked out with LF line endings.
> 
> Signed-off-by: ktwu01 <ktwu01@gmail.com>

The Signed-off-by and commit author should use your real name, if
possible. See [1].

> diff --git a/.gitattributes b/.gitattributes
> index 556322be01..26490ad60a 100644
> --- a/.gitattributes
> +++ b/.gitattributes
> @@ -2,7 +2,7 @@
>  *.[ch] whitespace=indent,trail,space,incomplete diff=cpp
>  *.sh whitespace=indent,trail,space,incomplete text eol=lf
>  *.perl text eol=lf diff=perl
> -*.pl text eof=lf diff=perl
> +*.pl text eol=lf diff=perl
>  *.pm text eol=lf diff=perl
>  *.py text eol=lf diff=python
>  *.bat text eol=crlf

Yeah, this looks obviously correct to me. Thanks for the fix!

Patrick

[1]: https://git-scm.com/docs/SubmittingPatches#real-name
