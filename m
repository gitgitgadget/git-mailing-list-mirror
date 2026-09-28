Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1803B36A341
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 07:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581313; cv=none; b=CFvZp7C4ZrTj2Gj/KY9jSI4nkuyz6VD9SUNQM0p15lWwhQe1oN0qwdsyVeq+e3CTEB/m8uX+cKvrXHCTIcR+gnaS82+Z2Ba+qj7q4DXsJY9MCWr5mGbvNv24cKLKOcgb/52mZGUgov/L5PPtDwsyNbgscCVYEdCfJrify00kYSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581313; c=relaxed/simple;
	bh=B3CvXxEWE2ta43alVAh6bWQiP91UjRDZS4ISpun8o68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDbXQ1+vsGiEgj9miYrf9f9JR6z0v+H9cTitMNX5lShHj7TgCD6U92RGhiqlDZEiwTEvMuc7u5JdyOOGXyoVU3KGIuOgDEhIpkB3wpvSvzNbYnoZGlYKh5ODeaFIIjCPEwajpsQQv1fv7LbjVcSgwNa2LdD49r3OurS4HujQXSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a91VpYKO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MOWDUjzn; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a91VpYKO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MOWDUjzn"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3385E1400098;
	Mon, 28 Sep 2026 03:41:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 28 Sep 2026 03:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790581311; x=1790667711; bh=UCb4oTL1Vj
	4zpw0ID8WBOplQUzK485UJdKV5LPgFcyM=; b=a91VpYKOyfhodma9iEBRy+OGUq
	WxXeypBfBnTxZPpt8cyryd/IhmQFpnuUbO55FXf2q8OOOUyo7TwR7iAaFRSgd6tH
	gNLgkRlpGndLPDS5GtKvwi1K2ccg8KKUPluP39GNNlip6rZBkS/qWyQ95c+ZIhM8
	6q+fG6a2GOe8olBWIVzuOOJabOLYKXXI2sSYa5lXJfBqyGTdRzs82YBqYe9y1R6+
	azRY3sr3g+A2iLWT0sluURP2tWaUpAr4hmtUnAZd4xiMGxg/jOuKyA07DwEQ8niq
	sS91QSDs/qjophrohp0qx2ASdZDF9VkPF24PmTfZhqkBmwLXQPevIABM4tEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790581311; x=1790667711; bh=UCb4oTL1Vj4zpw0ID8WBOplQUzK485UJdKV
	5LPgFcyM=; b=MOWDUjznEH+mtbgmBzxmxyTmaNW6x9UqSQTpZ5xuyYA+mhPhDgV
	hYohhNwBTMvG6jCrX8SYW7/Y2TGPZJ+6nBGnedJDdiHZ8r7k62VoMfR3JvL2H3t/
	XyCPn1BK4KDdvZzSKP6MJKdo1xNr5mV4Il86P5XXhNGfhNVzgHtfHLq7Xyy5O3MC
	PPcDOa5sKqDu9TwsOmGaSk6bDxlWELkzuwgbA0RLRifC8PM+qYoIA4rLM/GVXWP9
	NeuOE7X927EjFFaf35Y1qGw/oILNkexZ4V5IC7BHWb5nNEgSBn8SxmCZJoF5suTO
	QBxM7J9OiZVSKY5X/iP/GEYoH7pIrFTswnw==
X-ME-Sender: <xms:Pxq6aoJRxDX67N0wlUHZ3AtRLZWkGhUN4s74egpE_gVUYENLTR4WnQ>
    <xme:Pxq6avJA2IjGLOi0eJ8wWpJn-Wd0PggqDYLxUPvY4eQMi2yyZLq37VyK2RRUs7FxS
    xuTtKPnusL6JlDQ03bS93yiqtxMHJ2n5ak04MUzM6qnmRUX6e1D3qc>
X-ME-Received: <xmr:Pxq6atsgb7eBNzAQ5w9zVLCX7xRqVnmZmwMy7yqhnBGh3mqM6ogWbQ>
X-ME-Proxy-Cause: dmFkZTFoRkS1T90Bxcjs0RAQBC9cOzO6furnyIpBYI2fV48fJ43dm1zZhRk7Z+PnWhimcH
    ebZ3eQdIrHEZADlY9bYxTd1k5uht4oU08BTZ/HP89Qjw+T0IrHmODcRPRL3RJ32d0J1yOQ
    PBi2K1CzaC8tW2ODme/VPV51XrLVs1GbuWgrOTcyCRElZ0qMyZUeG0LOPZZH2zn87HOqXy
    /TK9haBIFRJHIWVlOZTuR1f+ofJLKQQGj9CtvpNZIWpWFYqJeQnH2FBvI8tCXpgrwcHoJI
    +aq0GNHdsjllU8A6iHQQdG1B/4jsbEKYE2+Y1hY2PrG7Uo2YmMDNHl1dfkprxZTn/NJUIF
    mU1nid6ABBlXZuuwXOIMPfhqRYMHw/ZrqbYLoBWQ5wAayHIwmlH8e4hckjuWjYbv7g+PsZ
    RUNOzeezhQOE4InPalcBLbS6saUQLXkzAZCd6Erc2brfz0WBzcVuYAuU4CXgv4yaip53/w
    UOuaOz1+iKuP9qJStveMCKAR8VbXj49Hm9gv2dqWz8cMBxdiIzDMATNprsFs8WfMTuweai
    f4E97o4Og7mO97IqlrIQTUWRdGJyOOeN0Fb3tzVVrSD4u6PVcpkk26wuqhTvQNIGfnfVML
    ZCXCLvVqVJaTc9bAlDgD5oMpsMfMgQf4AvIlj7VPLuEr1jyfoeC9zUmvRWKw
X-ME-Proxy: <xmx:Pxq6akTN2f6QJFeL_VRXEfvZVE_UQ6gdVEDIGhszJXAm0aLFqfB_AQ>
    <xmx:Pxq6arOzGBF48Vsfb6exqHniK5Xq9UxsGkloqbACaTtPAMSr1P7lcA>
    <xmx:Pxq6ahajkaopqoTAEpJTMFGqdg9Su5YE-ZbkCMCmCIWXU744sbd_Mw>
    <xmx:Pxq6atxHu2wWtaaayTXx86g7PjZIrO1lGdfn6KQivybKsxQ16nA-PA>
    <xmx:Pxq6av9zxDA5ZfYuP_eViC1OnzOcD2Wc0a9Q_aFT2B_C2bY1P2eeS3s4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 03:41:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8ee7bb93 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 07:41:49 +0000 (UTC)
Date: Mon, 28 Sep 2026 09:41:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Patrick Monette <pmonette@google.com>
Cc: git@vger.kernel.org, newren@gmail.com, toon@iotcl.com
Subject: Re: [PATCH 0/2] replay: add signing support
Message-ID: <aroaOsUFWt2lYOVS@pks.im>
References: <20260925205348.1210154-1-pmonette@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925205348.1210154-1-pmonette@google.com>

Hi,

On Fri, Sep 25, 2026 at 04:53:46PM -0400, Patrick Monette wrote:
> This pair of commits fixes a FIXME in replay.c. With this, it's possible
> to sign commits using `git replay`.
> 
> To follow the convention of git plumbing commands, where they must
> behave the same regardless of user config, `commit.gpgSign` is
> intentionally ignored.
> 
> The first patch fixes pick_regular_commit() to ensure failures to create
> commits are correctly handled, which can now happen more easily because
> of signing.

Note that there's already a patch series in flight that's adding the
infra to sign commits at [1]. Your patches will conflict with that
series, even though you're ultimately adapting git-replay(1) and not
git-history(1). So I'd suggest that once the series at [1] land, you can
maybe rebase your changes and then send a new version.

Patrick

[1]: <20260912160045.36064-1-git@5ouma.me>
