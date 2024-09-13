Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0458224CF
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 06:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726207530; cv=none; b=b5J9xgI9xNzPrpPPJmYrdeZn0lg9Sfd6Ko0a5Fm+fuRqQxX0Cgpeo7Q/8NU6zx8EAtdm+4opqX0AtmIYLh4DVFIAFVek8WY3JLcpWJyHX9ugHMC7FuAaieG4C8o+vC32r41u4HRUUC0v0YBS7YouElJMSuPe8T4J2DORBniZ4qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726207530; c=relaxed/simple;
	bh=GS4tEYGLTquy6khq/74lIpfxQOKhwWMqvfgqWMid9vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlDCmaQPEpxeTj6TaW3hjFjeu8G2kyedIRZHalw2IxLLm6GMhfCxhmF6nA6gArtym6lRpx1HU+1hPHs7IUpNS2vilPvCUYvyU8XXax1ZzAiaD28o8e3kDp7FqcAEbzIW3bbda3KCPiPaAxV+AilK0h9ewl7m0//i2BvzQJvdhQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lJqkeGD5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eZeA4Juu; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lJqkeGD5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eZeA4Juu"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C3FB41140110;
	Fri, 13 Sep 2024 02:05:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 13 Sep 2024 02:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726207527; x=1726293927; bh=tewzzbwZeQ
	54wBD6asg6o39oBFx4lsoW9AEuTUv+zLY=; b=lJqkeGD5rYAQKuA6tBJ7CY/m+6
	Frz1OjoMDvEukejFeyRCSqR0CDc9bUOYtJ/s4RZn1dd2MA7CYQrRqWtYmbGXOEj1
	iBXWzKyNaNAMegEsn1DbbZumuG7YZKfSuSP0LJ5SmEVBtXCcsd0T2ARFDtgg4Dvs
	//QARtARG+RahMLLBqaEGN8HROFsd4isUM0T6aUFa0nzGcxH4tjRmWOWh5Z7u/u4
	mFuHkU+ORQb4ks2vTlrTLF1bl725jySr9bADZS7+L0kaUNzjue5Qt9Q4AFE6qioN
	1gLKOFQISo/qt34FHwRL+fHLAFvlcmNC6WBed/Wwfxm02NivJxzPXkISYmMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726207527; x=1726293927; bh=tewzzbwZeQ54wBD6asg6o39oBFx4
	lsoW9AEuTUv+zLY=; b=eZeA4JuuYytGOmSTD+GCKl9W2nDGW2uZ5ImTEhsx8NHF
	uwIwhgyZiz/bYzEbBHfGOqZS4n3B4C3Kav7ULhN06y9Ttg1d4PM13D8aLbfU1tRd
	qZRUMc023px1NCGVbpGuxb8Dxb3IN5njKZ4SvJ/05NYDGFSEf3iKfJLKdHiIK2Xt
	vJFsMgU2GsjBW30ghJFNPvJueyv43yXp8Kxep/Y3Jc+JcwNejX4lyCSFo03XCptc
	PC/m2MVVlPsWooKjxlRXyLmjhHVxYHE//fP0e7tCsmbs7AklgFxYddCXP2fOJ2aI
	6fnCLURGIfh+MQlzMj32ejYp+Ww7kQ54raoxefI19A==
X-ME-Sender: <xms:J9bjZggpdONQz2fdHFA0FM18ue4DNaJ7dsZL1G0GR-mlN4s6ZA1Cyg>
    <xme:J9bjZpDEqEDJgRdnFydq2N4puSfyxt33Xau2XcWHasCRuqs_aZ6geB3FQu82eC0gf
    IKGeIWHw8l_EQgm5g>
X-ME-Received: <xmr:J9bjZoFplTRSURqPR-ToTB-D9R5k-lhjLgPvHbDa_8XjnhWKz_UBY01QvEmBwptQsQY1mODoUxq9WOLtmPtJRsRSnqimPWMgQG3ZcPokovi7eA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejiedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrohgurhhi
    ghholhhivhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:J9bjZhQ-NwZk3O69_9E5RU7H7TDj6PcAj3-3eivmAEyDGRtqKYSTDA>
    <xmx:J9bjZtwq_xVulT-hd77brhJtopCoRVfdfuilAp_Zgf4vf9v_yFF_Iw>
    <xmx:J9bjZv6D3WnaA8YojCgqpd5ewlTATtDFeJzJB_JM2ncIF6PvVQJpmw>
    <xmx:J9bjZqz4rHzxr12cGVNkGsoSIa4UgAM5ZzuYxxxtR7DPibYeJ1XVOQ>
    <xmx:J9bjZl8r5_WXi3vEEi_2SrIye8w0RUZY7izP37Aj8_NlhJVGc6nR8vPf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Sep 2024 02:05:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id db0ec6f4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Sep 2024 06:05:16 +0000 (UTC)
Date: Fri, 13 Sep 2024 08:05:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Rodrigo <rodrigolive@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] Git.pm: use "rev-parse --absolute-git-dir" rather
 than perl code
Message-ID: <ZuPWJtPo-2f2Mgbl@pks.im>
References: <20240912223413.GA649897@coredump.intra.peff.net>
 <20240912223725.GB650605@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912223725.GB650605@coredump.intra.peff.net>

On Thu, Sep 12, 2024 at 06:37:25PM -0400, Jeff King wrote:
> When we open a repository with the "Directory" option, we use "rev-parse
> --git-dir" to get the path relative to that directory, and then use
> Cwd::abs_path() to make it absolute (since our process working directory
> may not be the same).
> 
> These days we can just ask for "--absolute-git-dir" instead, which saves
> us a little code. That option was added in Git v2.13.0 via a2f5a87626
> (rev-parse: add '--absolute-git-dir' option, 2017-02-03). I don't think
> we make any promises about running mismatched versions of git and
> Git.pm, but even if somebody tries it, that's sufficiently old that it
> should be OK.

Agreed. We should eventually be able to rely on things that we have
implemented many years ago.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I retained the "require Cwd" here since we use it in the conditional
> (but moved it closer to the point of use). It's not strictly necessary,
> as earlier code will have required it as a side effect, but it's
> probably best not to rely on that.
> 
>  perl/Git.pm | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/perl/Git.pm b/perl/Git.pm
> index cf1ef0b32a..667152c6c6 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -187,7 +187,7 @@ sub repository {
>  		try {
>  		  # Note that "--is-bare-repository" must come first, as
>  		  # --git-dir output could contain newlines.
> -		  $out = $search->command([qw(rev-parse --is-bare-repository --git-dir)],
> +		  $out = $search->command([qw(rev-parse --is-bare-repository --absolute-git-dir)],
>  			                  STDERR => 0);
>  		} catch Git::Error::Command with {
>  			throw Error::Simple("fatal: not a git repository: $opts{Directory}");
> @@ -196,12 +196,12 @@ sub repository {
>  		chomp $out;
>  		my ($bare, $dir) = split /\n/, $out, 2;

This line here made me think for a second what happens if the absolute
path contains newlines. But it should be fine, because we only split at
the first newline character we find. And as the first parameter that we
pass to git-rev-parse(1) is `--is-bare-repository`, we know that it will
output either `true` or `false` as the first line. Any subsequent
newlines should thus be handled alright.

Patrick
