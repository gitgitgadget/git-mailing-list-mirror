Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649FC3FC5DD
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 13:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860929; cv=none; b=HFm0APwHAQpcLf4gnI0VwIduteMlUZth3MExVip4H03N+fe3U3TZxx/HrlJOzXG68FrLjg/SXobELrSlgjkAe1a6/EcKhNFdU/W2cDSwCExki3AnwqLE/DuLVNhwZZT9l0TY6qL335zhw9G/0RSnxjS9UXgwr4WG6W/6QNjCBj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860929; c=relaxed/simple;
	bh=U54nUOQgKZGAEcOR6ulp5wNgyb2+HsoE8nLYKhAm+4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nrr6KAHUL6JFPpEjpEisczKVpeJYe0D8uZQbcOTWFtI1Mr9hgtSLtDjfHPFVcDcYZ2oPAN0GI+QgkBpWh1TK63PJZ3CHYgT60GRhOxw84mGGZ4wQb1ddANP7nxz7L0+j6xfFTFWpZyPsPzqmdNR0p+Qpq88iTMWZisAM9exgtWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o1KDUpO6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HZ+XXBvK; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o1KDUpO6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HZ+XXBvK"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 5F74CEC01AD
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 09:22:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 01 Oct 2026 09:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790860927; x=1790947327; bh=MYFssrd7a1
	oqRnFOMIry5HykfN3H8PeahGzro7GPHUM=; b=o1KDUpO6gc0NEdZZrtAbmiqBqK
	5tX7SbcViSN9pC7peDgnO870Iy/KNc64OZ4QjaJUhwJn2SDT+gD8GIVaYOSzteLb
	bgkK3nRm52yu1h6PfcKLjSEthyZepA79EoTYrXVuZTfyCUU3r1xSNXfjwOMQgoDn
	QlPZH3b62qjm3ggmRWun74Fw3vMqQDG3My8gLsiXYGqHVHBACq213FKP7mKGKskk
	YlZ2P9+KdbPmW+QCuhepHbcAhUlzg3Sh4ng27NsbyeZThKAeRbTW0KmH1pP9Doda
	17RJITIb7JvggMw1mzDPiK19Ts2N+dmNVipAAZ+yttez9O6jOYvxMH1jlkTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790860927; x=1790947327; bh=MYFssrd7a1oqRnFOMIry5HykfN3H8PeahGz
	ro7GPHUM=; b=HZ+XXBvKTNUjeDiYhOjd7tJKPBjh05rK0yFvdKOE4z8YNLxDzrm
	R6FMoNmQP6cAzycKLnvr1U3o3le1NOgM6eOicO2LOmV/bwQErWETVajEoNOhxc1w
	NPzt4gjdqUfYfPs+TJ10TWOzzj8V1yPPtd2ngPV8Bef1ca+v4aY8Vby8u8X1i1j3
	/anYvoBjtfJIl6fJkJUPFxFYcfdkphdM+UrTRS9YOZuK2qVhjQ8CY6/vfTNdvxi3
	TB8D8oXPzhzLVUPjhwGKbAnrpJU9gI1mG+dQL7+4ypW5LMaEUq0AJVUh9geh3zC6
	19UXFur8tFZmKwkDsggybh9WVmj1dMk0j3Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790860927; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:F5JlRzNzsmib2SiQOlYU11qO1OJcF2P1JzDr3LIIb110sj6
	TBLrH6mzDQornqkQwZvFi+8qZdtM0P30nTCxHPt/hzIxzQ7ZzRtvscAfAl5ExvTa
	ylV7QtAs/vk0w9JGMRK+DHjV2flJbL+eJ24CzZeeb1S5DvBunNxr62PzJzLlOg/Q
	vX5hZT6SQQW0IoigEFnkPXAUeUX+hDJLvDVCzyun1Mgv2Ij1j7uspjfOOWau+lDm
	HBQtGneh+F3TmOd0TBvwPpP3Rt4zY83eSaRurrPzu86I9GCpqtYNTVvnXIBG89U3
	xN4l+ihaJZZTY8T0g7jHUbRjeBm96W/j0oiGoCg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:YpaMq83eQGs9HT53KM09ULiRkZKDUzjwozIkYyAzpR4=:U54nUOQgKZGAEcOR6ulp5wNgyb2+HsoE8nLYKhAm+4w=;
X-ME-Sender: <xms:f16-amEJb_tnQnlyF1jVh54KvMXCuU4Qfy3ugxV221JtkqKu-42r4w>
    <xme:f16-atXDs2xrdBqxZJjRtnlSwoQ0hsSJLsGxc8B_aW66D6dUHH8kqsHMITZPO4lhW
    ZNivVkWhNS3SRE1Gm-CQrcnK6duDRXh8mXNOnze3-2bZn_BkFWxpQ>
X-ME-Received: <xmr:f16-aty1ID03OoXBADP7D4uhJdun1Ks4U3XYc9mfR7sP4yi-BsG0yTKBsRFGhsaBjMbMSw>
X-ME-Proxy-Cause: dmFkZTFHughwZWIOiekNl9/ZszSoqOOtuFY/pSlpK9kdJ1ZfcrU2VL7RURC3HRF/0V0qQ3
    Fh5MZI2WetBIWxzJAJ7MBiASqYFxtUjwmnr8cb+ZT3iy3raXQ4cUkVie7psLqdZOasy8HF
    qFoZnZ8WBbDRlfQ0+EkG2XBy8QYu5so9VaAJLqBpz8ev17QAPpyUHwkzD6PgHVDECh7uqw
    MxxFhhO1WmxMxORhGOctGFR9a8bixoRRnrCPnaQErd6VS3lbPObr3TvjRx0i4reM9g4VKf
    sE6LwhRFrxJYqgAw7uzmigreSeM3qR3kAHDunBuqqeCS0cCZYLjXLZM3JDE4Zbiz0mvJdI
    xe5OtHdQgh7EO1e8OJ82fVKD6gwP0Cf2emwmpxndeCAHbq6S2NpXdOCv5DNoA39YQN9Evv
    99t3e0x0ZohsgIdppmDT8DKRxzR+Frkh7Ep/yuHS22e/0jJwtUE55yAx6nzhXiZ/q8LnG7
    PQRLoGzBnpySvvd19kMEqmSaYC/jkGkwFzJhAktMcHuVYQei12iaSRdLjz/fM+5DdpYJsb
    +R1zKO+mJo61x984cCyqD0yMTd9EP47KcHiz/mLu+bFSaPkAbzS7/5YlzMZVYL94IbQhAz
    qsDeWNzh/gZ8GydsNz/0YpILTI3I/mhsaaIHGT0UUCz67rOGjB3qgCneskEA
X-ME-Proxy: <xmx:f16-arNf-wAn2pP-71Z2RM1w7FC-ANJKztriRgGN_oSMYUEpnMTpPA>
    <xmx:f16-au4OzZ_lHfxcKEJBjz1_rS6LZtbQ15I8KMZfI5zPpYNjaClmtQ>
    <xmx:f16-asMauQoCX5V7RhPSB7BhHRbwdjjIdq-Pap6PzbIN4UKzaY1HRQ>
    <xmx:f16-aslJNICnVyRhJpeVaJONyu4EcbD3fVlPvyG6JNPdkh_lx5Fu-w>
    <xmx:f16-amZPL7sPIIWOGakf86C11dcfsWXgag0d32yowPRQBq55PmoJoCfv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 09:22:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b7b85f2d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Oct 2026 13:22:05 +0000 (UTC)
Date: Thu, 1 Oct 2026 15:22:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Alejandro Colomar <alx@kernel.org>
Cc: git@vger.kernel.org
Subject: Re: git-rebase-walk
Message-ID: <ar5eereSq91xldo-@pks.im>
References: <ar5KL4_IKXYbx3Sb@debian>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar5KL4_IKXYbx3Sb@debian>

Hi,

On Thu, Oct 01, 2026 at 01:58:42PM +0200, Alejandro Colomar wrote:
> Hi!
> 
> I use this little command to apply iterative rebases, which are easier
> to handle when there are large conflicts.  Are you interested in it?
> 
> 	$ cat $(which git-rebase-walk)
> 	#!/bin/bash
> 
> 	set -Eeufo pipefail;
> 
> 	git merge-base HEAD "$1" \
> 	| xargs -I{} git log --oneline {}.."$1" \
> 	| cut -f1 -d' ' \
> 	| tac \
> 	| while read -r c; do
> 		git rebase "$c";
> 	done;
> 
> The source code is trivial, so I guess I don't need to explain much.
> It behaves quite nicely, IME.
> 
> You may of course want to adapt it a little bit for merging in git(1).
> I could help improve it a little bit.

this reminds me a bit of git-imerge [1]. What this tool does is to
basically perform a merge between two branches incrementally using a
matrix. The tool tries to address exactly your use case, which is to
"present the user with one pairwise conflict at a time for resolution".

Maybe that tool is interesting to you. But it's certainly fallen a bit
out of date, as it hasn't received any updates for more than 6 years by
now. Chances are it stll works alright though.

Thanks!

Patrick

[1]: https://github.com/mhagger/git-imerge
