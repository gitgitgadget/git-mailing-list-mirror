Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3751EFFA1
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 01:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772673639; cv=none; b=EMXNRIysBUQqUQFCYnihiibqiOVCqF31w0S1MmL+K6G43tCFzcbW4R6i/qx9BGDxZpWNJnPmgSB3Wo+zkhSLOV7aq9G1l0QrnrX1HyDDRPJMy/CAioMigaw/8hgh7DA0T9kDZl9ogZULIaInvdkSk4qJLl7CeG8AYj1nwL/kA4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772673639; c=relaxed/simple;
	bh=okTyEDo6vEhS+RvBCilq6YlRP/pOvgNnPJvCsPhqGo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxx9ecI/a1oHgZopSKCLCkQxUaTlNnQLT5dB3kRxdSfJ8F+kqVW7Z57csO3p4uo5W0Qiev8h0laWvxe9ncvJWy9k+Vx96HPvMLz6e+HWIvDcwRs3tpIFaE9dEY/RvL+P+CU9UbRVmXNohgFtAJLpB4bsWLKNe5TIgoWCbBqD6IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MM673m5W; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MM673m5W"
Received: (qmail 1897 invoked by uid 106); 5 Mar 2026 01:20:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=okTyEDo6vEhS+RvBCilq6YlRP/pOvgNnPJvCsPhqGo4=; b=MM673m5WsgzQ/jV2hnP67UwZoxX2oqf1iuNN3qSUdfAtZfu5HdZknByvmuy/QjLUH8or4hLYOiEGdJyVacEu4jCBlle1q6g+Spow4JMrlZ0H8r563W4JXPAwVDJaIbddm5Pwgragt1byycN5mLtF+E7kqxeLqueDW1zf8o6z3L1rpxy5Z2OiAW56SUsRoddZBV+JfNDMDOTwbKXHqYyp1iLWvEsrllH+cMvVJOhhBRylbdLN9SV2C6Hw7yJtf3PIc8lUXDHRQsTIsjQZaFA+Guh+Sf2dIpBuyOxhJ7o6Xw6ElITYd//IZXR3dqcLYl5JmjQ8ygK8+2X+9bTc+ffF1Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Mar 2026 01:20:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 376473 invoked by uid 111); 5 Mar 2026 01:20:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Mar 2026 20:20:37 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 4 Mar 2026 20:20:35 -0500
From: Jeff King <peff@peff.net>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, fastcat@gmail.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4 0/4] for-each-repo: work correctly in a worktree
Message-ID: <20260305012035.GA53966@coredump.intra.peff.net>
References: <pull.2056.v3.git.1772465805.gitgitgadget@gmail.com>
 <pull.2056.v4.git.1772559114.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2056.v4.git.1772559114.gitgitgadget@gmail.com>

On Tue, Mar 03, 2026 at 05:31:50PM +0000, Derrick Stolee via GitGitGadget wrote:

> Updates in V4
> =============
> 
> Minor updates from Peff's review:
> 
>  1. Update the comment of prepare_other_repo_env() to avoid duplication.
>  2. Rename the new method to sanitize_repo_env().
>  3. Move incorrect removal of 'int i;' to correct patch.

This looks good to me. Thanks for accommodating my somewhat-bikeshedding
review.

-Peff
