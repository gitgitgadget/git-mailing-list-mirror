Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894F71DFF0
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 06:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294294; cv=none; b=lcf2F2w+WkqX4mlOEDvpG/OktSuXXBkAUxLC5dZKsCir84rPzxz5MChX5Wt0AadfIRLen7gxP/So68mqAVSsSiXi7aATxascblNAqnF6/gOxD80NWvU4f7Lad30+hWgQmjciHA2Pug0L8t0vicEGAXcWL0NoDWDUOzBqQAq0+nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294294; c=relaxed/simple;
	bh=jEL8gXsA5PTjFow1RmHkCo6kiIXDCntQDxPtwmVPS7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RGWFh3zUbLTusCeSCX+mAAuhKQBVpRTPxpql20wvzcNbpll3vvBgD1I9hnMJmc/NGfpUge269Lu5Wzs8Juh821F268mJk3bZ9EWfk2lgS5bjaahBcXlKdmeZdtLqf0P2G0XdlG4MPmPgW3rwI+d1U+goEN1wtIgJSZUL43Cb7tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emailplus.org; spf=pass smtp.mailfrom=emailplus.org; dkim=pass (2048-bit key) header.d=emailplus.org header.i=@emailplus.org header.b=dxKUESLK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dTw5pOz9; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emailplus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emailplus.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emailplus.org header.i=@emailplus.org header.b="dxKUESLK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dTw5pOz9"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BC2FD7A0054
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 02:11:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 01 Jun 2026 02:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emailplus.org;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1780294291; x=1780380691; bh=P2xdDdJZgEbjdSackSeS4
	W2Ca5YvirYFOpJTkdPP5BY=; b=dxKUESLKk8FKMds1NIozByBomxgmV3dbLGOlr
	3oGDXGoSKDqnGU4tWgB2+bx2yCGTmJs8KpraLI0zqzjohukl2twccImTKFkl0wj1
	r0K6lY99hHDw0KYm1rxVSd8QrlCsBgMDDUYL4kbhLELCz5NMQh3Yyss8FbvluDDb
	f3y2icXzi5BCjVFN1bEs0PyL06K729X7jsIHCEz8xjUzl0gAsmkCGS8+mTH7t2ti
	tEWjBLfvm518XswTvY3a9EjDQkIQRLhnTbfO/o+CnCACZp9FcO5icXG/mkHsJI/T
	2sIEegPZQ40Ni6BaVyN37MeBMFlL3+BmAZ9xPpmwBYzMzLbMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780294291; x=
	1780380691; bh=P2xdDdJZgEbjdSackSeS4W2Ca5YvirYFOpJTkdPP5BY=; b=d
	Tw5pOz9dCCKGg8junoTsk3Zz00VLREMkDuFwgVEc+EDzTzQyG9zNQps3w6FKleYr
	mct2MG81xj6+ED8mRRixNpEInmbEONHE0CzwCmKYNoz+tspGvIGPj80P8siSZNan
	TsJyh4RsRhH90Ljc2Cx9iihAfw2qWOw2/8hnjExkFkgsTW6Tfl2wQttJjFy2C8Jf
	0iEQugDnhocBo/P6eawaPAq0qJWj2p48RD0PTVHar1RbdVT1gAp89JNZyzljBUeX
	G9ltogvdir0SFXZ1HIuyM8x7vPoqV4g3gu1BfOwNfPKVd9CSisSmuXcTrwJ2uh+C
	qTj5P4NCXQ8hvPmlMdiOw==
X-ME-Sender: <xms:kyIdalTFm2GIgqKWSA19etnbnE8VwWGQhN37AZTc6byZo1YP7_9taQ>
    <xme:kyIdaluRrOpaT8WyL_y5nOsa9hZJ-t4PdrM0ptv42K-jdlS07ycXXwRt8cq63ZpEf
    ZUqdtBwVeYsWeO0lY3jN8wQNIX1NU8ZmwQnv787ahGkhljas6QI>
X-ME-Received: <xmr:kyIdagcRGFwglG1SegDbWS2LZo_dVcoo25iR2ZGXSkmYTSALFBmQsw>
X-ME-Proxy-Cause: dmFkZTECl0XGZpMXH6OC4Z9bLxZO23i6fG7JZIh+gceKt4PsgiMs0yi0kM55nHRoilFISV
    pv7bEmIowEi8PfRvoN8M0v5NibP8We0bzS+H8QPa+x3+qc/VXk2cCnHmTT3dDRLNx8Xk+M
    yxFWIB9nye0MgB/XQeZCb8s9NwgFdI/6XnT+DtB4VT+epjxmT8EKUp1OEWLh7funHBq2sS
    RrYsnxqDMATXi7zFrdxK53uC1g1ej5iW5/fEgmVAK7Lp2NmEXChZRZ98PNv1VhrlyAEhcN
    NyX9ARZrFHBitBn8cI+exXZcM0VK6X/CTesMPpSbVC/fpl1y3GvV+0G/mcuQskfiuKjtYw
    AeAstMl+7mQ4Y5EYp0L1hNOrK+7oapB0F+JL5/0XmTqw23dgwPJFWKnZoPzAS0s0j+AFQ+
    Qvxfk9bFETh/k+4OxR1AKVauIve1+FB7dqp4agi8sYJDtxVQw3VJXN2c/K5HzSliEVL09I
    jhKi0bwgvr/c1vJb6HtBMd1EGg4rTHZAj73szGBP7Y4/BlkDz1M28xj61AaJXVWVGoQWCd
    QUjhCnHNmcgdQuUfYtb9wqzajbceVx/1uKuJslG8BFxKV5hTWe5sKc+TFOcM5h6ysD/6Vx
    DVpyPAi2Bz12QPl7PP4I4MU9sEy/Q5tglw2aDX7+Sx+NEIPF0NQaXTpr/Sqg
X-ME-Proxy: <xmx:kyIdaiILdQIe7urmuidBzpbb1gbFUkI_cnachnvDdhgSm_USZolezw>
    <xmx:kyIdauY-U5R-oko1TJbBV8ULaTRJ3cuE5WZubYWdNH6bAWLbmFsaIg>
    <xmx:kyIdattYpyP8hsdNBggnDGTZ1oSa79HHfcBoA4G16-m-5Wvi6an3Tw>
    <xmx:kyIdarug-God9wWr5dcnc87OaGwSa3TbIho3ubjn1EyAIQr2tFmLzg>
    <xmx:kyIdahRnKrdBSlWe5vNvkEVz491HC5BJ5yHksx8kCM4fKVv8eiVBeR7a>
Feedback-ID: ic1e8415a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 1 Jun 2026 02:11:30 -0400 (EDT)
From: Benson Muite <benson_muite@emailplus.org>
To: git@vger.kernel.org
Cc: 
Subject: Mirror repositories for submodules
Date: Mon, 01 Jun 2026 09:11:28 +0300
Message-ID: <875x42vlgv.fsf@emailplus.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Would a contribution to add mirror repositories as alternate submodule
sources be considered for inclusion?  Some projects have mirror
repositories on other hosting services, and may have bandwidth limits on
their primary hosting service.  Being able to indicate mirror
repositories for where to check for updates and sources for submodules
when doing `git clone --recurse-submodules https://my.repo ` or `git
submodule update --init --recursive` would be helpful when there is a
timeout.

Regards,
Benson
