Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9922214812
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 01:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783561817; cv=none; b=fyfJ/sJSMXfBYYYZFv0EDHZ+a0BnLyXr+rtMha04ShI3EHNkc5OZr/zbs5ejvtbW4WDXZemhg0NbBBypnUGeBCqpirgu9uhJ8IT5nVoaO/7tYIXRvvqzpLSpQhA9NAwbhl5L0I0lA5hql6Sf5tar5SRRPXKkii5OdT1ZmEcQhhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783561817; c=relaxed/simple;
	bh=wD3NrDum1ko7XYc9vNzBpvpOepuJrBmfAZbWBOVw2tY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6DsrsmA2IAijiZM5KCZr4R290V3XkNEe3aNl8WbY8bMXOfB+A2IZlYODnhN2vxJwhyNrNMtmlP2U39bgvQ/QqHofc51UXXqunbSy43EGNARBzeB2n7O0hSCCe+Znj97CLtmbbjiGTc+W0klGugGYjUzAu0m9h2usIGcTkvBrDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=C3rc9ecc; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="C3rc9ecc"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1whdtu-001LbE-DF
	for git@vger.kernel.org; Thu, 09 Jul 2026 03:50:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=eXpVXlzhdqfyCU7hJg2GhU3VG2aUHDcufABQb0V3JG0=; b=C3rc9eccd0EkQY8D2Hz8bHC+lo
	/MruKyN23SWxtg7MAzvnQV8196Rc1R7w9cu0C4Q00wznGR63G89hy6hrkWrGoVA7mAimuRCicoqYQ
	3yoj7y1Gip0C+0r268X1yUOe/pENL/rO+O2IlfYYzWxzvDi2VFpvqZolRlnOtnK+/CJKPubx6TB1A
	0JuB9VTyKqH0EwUsp5LZr5k+NdziteBXDu4hASQCMF1TGSdzALWuYu7DySUX4eBkkleI6mpsGbal8
	Iem817eawNy6Ndt2VqczNXVX6Er72tuV04J+L1fy+tbsJxKkRRxgmIJ3Qk8RGTh29YAfPre6uBhsZ
	VyYV04mg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1whdto-0006NY-Rn; Thu, 09 Jul 2026 03:50:01 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1whdtW-000Eo8-Qi;
	Thu, 09 Jul 2026 03:49:43 +0200
Message-ID: <f557bfcf-ffd2-4903-8015-97fff97dbe09@howdoi.land>
Date: Wed, 8 Jul 2026 20:49:40 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] git-subtree: Bail out if we find output from Rust
 rewrite
To: Ian Jackson <ijackson@chiark.greenend.org.uk>, git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20260706115816.20267-1-ijackson@chiark.greenend.org.uk>
 <20260706115816.20267-2-ijackson@chiark.greenend.org.uk>
Content-Language: en-US
From: Colin Stagner <ask+git@howdoi.land>
In-Reply-To: <20260706115816.20267-2-ijackson@chiark.greenend.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/6/26 06:58, Ian Jackson wrote:

> Another, bigger, reason is that current git-subtree generates unmarked
> subtree merges (ie, without any git-subtree trailers)

Subtree merges can be performed without git-subtree, via the `-X 
subtree` merge strategy option. While the design of RIIR git-subtree is 
outside the scope of this patch series, this may be worth thinking about 
in your rewrite.


> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -278,6 +278,20 @@ main () {


> +reject_if_v2_config () {
> +	local config=.git-subtree/config

This is a nit, but `local` is not specified by POSIX. I know it is used 
elsewhere within git-subtree, but it is specifically discouraged.

> +	if git rev-parse --verify -q "$rev:$config"; then

For subtree split, should we also test for this file in tree you are 
splitting: i.e., "$dir/$config"? The answer might be no.

I think that subtree merge should only test the top-level project, as 
this patch does now.

Colin


