Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A251A6814
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781877853; cv=none; b=qBfqxrWVgz8pKv80ppiZ2KDU8RvGWxvGoq7S1BHJMQlEu6eGPL+Wcbx6DoqpuneMbqAQ2GB6WhuHXu9MwkileP3R+hGcwtCKgEw+ZvPKSdmBN8atONzHGFs51q2/FtbNu6vRzDjyqKbr+aEcFn6iNFk0lOwgnKfooA3MfkodYR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781877853; c=relaxed/simple;
	bh=0+iFWU03p/dMydRhFNerhWAEhyCubKdAmMY5Zb8CVuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3MLjJlb0C8a36QD1n/RQBVC8CFW3wQKToMK7yju+f0xy9+Nhiy4L8LxJUUZkYROREJifp+SeQeYUf4Mmc4nlZKKIt1p2VDxB93FS+wu8/oROAk0SSi/obji95E0XRL5/h814dCda/94mDgfh621jFTV6xEqphhfTtHCqK25YDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y+9GlJb8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SHdCbPFZ; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y+9GlJb8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SHdCbPFZ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 860DF7A012D;
	Fri, 19 Jun 2026 10:04:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 19 Jun 2026 10:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781877850; x=1781964250; bh=nPKs/Tluym
	GpwhR4NfU96BQ41VjLtA/EvbLL8zRXpPY=; b=Y+9GlJb8bA2SdM65n/ufnSRK6V
	YWT+Q257BrXKD5rNZMInzmL84+TsU6mhCGoxbX1oOMu40zyhQmvKQ9deUbFgRfiC
	n7mcSblNbC8g90tc3jpuERDKXYFPYbeAjKW7I8u3XICjLL3FdsZte78xzlSPmBh5
	wV1Yzi4ozyuSpVtOj7CrW0/6XPXscQRbDkVN/P9jUl4ffu8Lf5YSJ9j4Vs0PYwr4
	zYFvatH0Id7dk3wXUvOvg9A8M1iVYypvWKMk8Iiah2RLxZa2hm7ikAOiXZI/aD6z
	H9wkiuXsVS06s4/tGygT4r6yPRPJA1y7/+6tP+8FegtmtpDkReoWW9rSp0Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781877850; x=1781964250; bh=nPKs/TluymGpwhR4NfU96BQ41VjLtA/EvbL
	L8zRXpPY=; b=SHdCbPFZduNE2DNUEB2MYvj9y39ysbac5rFUUr2Wj2mqYsI2vOW
	wsLKCcXnIVHfohm/gZC7fOpASItuxNWS2sBXm43KuhiHnbwgc694ps9moPo2OrGe
	effZFEKGd+bHEmTCDY2+T9M7J4aeXOMZrFVn4QkzQrAaqEtHSwbPQd+fHKUl0Pa1
	rMttN9yXwNsI5VRyzym4t7F7eLqbvyDHOe6iNZAqkMC956bJghGCVSGMiVoE+zKi
	9sRlocuMhfe4imQoKFligTuq/CeM9fUNuwqZ95imvNRvYGFWXvVZULFMxcYplTGF
	dAe10/TGpMEO2BZV95N6m6XYpdrpxl9Xpsg==
X-ME-Sender: <xms:Wkw1ak9M2lwMZAzcqkbSh-vyW2fVwjr97W25nWXZ_dmjaFheyYugZA>
    <xme:Wkw1aisX6VzuF6fII6z9fg25JSowMGptX3c3jjfp7sKTws97FHeYh69muGqNjXI-r
    HiCnWs1IgFef7bueoViSQstvniYMVH1ayX7acFOn5Iw7wX4esuMGw>
X-ME-Received: <xmr:Wkw1anp1_NN0cYEHXw9xhDUdReBEi0KB6MTOieqFbI1S6i5nVDrt-iaq5eu-NTdocVgEGHZeqjRWoufpY6TIgirVuGwIWUxeW83KMFV_O34>
X-ME-Proxy-Cause: dmFkZTGIW3yh2C+18UJ/P1SptK/y4RnZOo1QQDtrFuIbnnfz1D2jl7Cgzkd8qwuwolLI4o
    J4BCbqp4+39xD6HOUrnpnnQmNB49e22hcs6I1t7Y+6hBSVK+XW6tD2sTQwSRNwVMawAi3C
    bC/OS9RpkgbqK8dr7q+bkHm8++ySyZ+rN1jaspujmAr2a2+wLc5Wzw/fUgpEORyxSUMWI8
    xy+NOdPVGFtAv/21C+BNR5WZjfuoyLZo3ae2EJ6RO4vI/wnPBQFg8Bv7GmdfZjwnYVxofW
    QmmRYNOGLPwn3/JxkvnetOurOzx2UlZxWwbs0sjQ+6CAb08DAugvi1c3f9MqjBT0EzKZgi
    /+3dZV8xgb/CgNEGl1UKbSzEQqPk4wmNTvl511o+qC0RmoJEyUItjNa1RIAUz4jotcmtYa
    Tn1LCQ00PJVMLATx6Mk/uuyffoD5UA8QfFrqM8pDp9/KQkyCOeuQEn1M5qv8QI56+ZsAaV
    Tfgxv9JBxU4imKX/cRhStnZLFg/fclrA+M39VpesneOFFdSgW3EVcY6kB13IfOI80pIKLL
    UathDgqQrQSZkp/YVLH2ZTRfMVXc/phWd8jGuvok0oYB8LyYLwshfzaTRNOsmHPNv0W4mK
    Dl8Bmtw3LNIavdbalLaYd2mwL0Ul5huhrE4knpn2lQjyGdDF8qj4iojQYNbA
X-ME-Proxy: <xmx:Wkw1avnpW1SOuPYRo10fpovB3VQU-Jjwj9mpOA32BeOpH2qjO4zlAQ>
    <xmx:Wkw1arzSqgiNjNkaaKixpCETXSACqiZy1MWAHn3Xuvn897I7jBxhyA>
    <xmx:Wkw1anmN-BTHNtEvMGUkj9mUqTOi_TyL9-qg3tk8SuxYsnpjYQ9uZw>
    <xmx:Wkw1akelD3JMETj2bPlovwZqH6Qle5DpcCZdJJH5GIDBCsb1DtwGlA>
    <xmx:Wkw1agWubnkfi-QWfgxhGDNPV_RRY-v0HNjYpFd-uJIjuKOwYpyh2McG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 10:04:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6e1b669d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jun 2026 14:04:06 +0000 (UTC)
Date: Fri, 19 Jun 2026 16:03:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [RFH] Why do osx CI jobs so unreliable?
Message-ID: <ajVMTjniOO-eG8h1@pks.im>
References: <xmqqik7fnz90.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqik7fnz90.fsf@gitster.g>

On Thu, Jun 18, 2026 at 05:35:23PM -0700, Junio C Hamano wrote:
> I've been observing that in recent push-out to 'master' and 'next',
> osx-* jobs in GitHub Actions CI keep running for 6 hours and get
> killed.
> 
> What is troubling is that this seems to be very flaky.  For example,
> https://github.com/git/git/actions/runs/27778820659 is testing
> 95e20213 (Hopefully final batch before -rc2, 2026-06-17) which got
> killed after wasting 6 hours in osx-clang and osx-gcc jobs.
> 
> https://github.com/git/git/actions/runs/27790036076 is testing
> the same 'master', with a patch to .github/workflows/main.yml to
> remove everything except for config and osx-* jobs, which succeeded
> within 30 minutes.
> 
> Stumped...

So the raw logs have the following trailer:

  2026-06-18T23:53:33.2996180Z Cleaning up orphan processes
  2026-06-18T23:53:33.7900380Z Terminate orphan process: pid (34022) (git-remote-http)
  2026-06-18T23:53:33.9848670Z Terminate orphan process: pid (15488) (httpd)
  2026-06-18T23:53:34.0321490Z Terminate orphan process: pid (13146) (httpd)
  2026-06-18T23:53:34.0808280Z Terminate orphan process: pid (13145) (httpd)
  2026-06-18T23:53:34.1212760Z Terminate orphan process: pid (13144) (httpd)
  2026-06-18T23:53:34.1570160Z Terminate orphan process: pid (13141) (httpd)
  2026-06-18T23:53:34.1924140Z Terminate orphan process: pid (12553) (bash)
  2026-06-18T23:53:34.2472970Z Terminate orphan process: pid (12552) (tee)
  2026-06-18T23:53:34.6547890Z Terminate orphan process: pid (21209) (bash)

So I strongly suspect that it most be one of the t555* tests.
Furthermore, the t5551 and t5559 (both of which are actually the same
test) are the only test suites that use lib-httpd.sh and which are
missing in the job logs.

I have not been able to reproduce this hang on my macOS virtual machine
though, and on GitLab I didn't notice a similar hang recently. Maybe
this is something that's specific to GitHub's environment...? No idea.

Patrick
