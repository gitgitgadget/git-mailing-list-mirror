Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E34255E43
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 07:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113477; cv=none; b=SFxOnGP/Ys15W1PmZxYuWeaWVX4Y+hY1t1UW8v7IMhuiAYTJQ7FVs1mHE7bMzYoTUWkWEDIIulvQablUwHOUmmNTPk8OmlGU8npIW1xVANtOpYEH1kh7GWu5gQYeUCKEpVDaofXerwIFBZH/A5Plqe1vdKbAw24Knw/9DGOAdvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113477; c=relaxed/simple;
	bh=9xt9b35dACzwz9Yk002mFVCah6jfOnTWbTKnBxUQwho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+i/2zCCNzpaX0xNWdmd6oMYyaBpWAZLSMmBNM1CTupEqD1KBMsdUqWAFdBbsCrO7didEG7pDGKv4Hk0vtSodJP65F3OUpyfJsBd+we0zERHhO6Jp8+ZKZJSV9iccKjS310PV3UK8dq4B+G5U8h52EyBWWPutGXqGCukGqk/5i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E9yqxIRl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vPT7lQol; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E9yqxIRl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vPT7lQol"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B0A0A7A00D9;
	Fri, 11 Sep 2026 03:57:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 11 Sep 2026 03:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789113474; x=1789199874; bh=+lRNjxagiC
	+aZCIy75QEUYiK7CYOUjgp56w7m0XmsGc=; b=E9yqxIRlmkhw+AbwRNOII3M/hZ
	wf87EQIhkyj1oaJFXuWcx+DIu2kla9BTrJvbG0KUIzQzkdeZJhQrmmisc2CBH8Iv
	/2KHv0Jbk8Jk06wPofrflQT8jFp40DZR/U3gafDs+Exs4IdxGVufdPX6ccEBqWCo
	W0n5+5uBJaJoWyq+9BdCZrK0BcOg2gdiYSLmxyRx3tcN9rvXi4jDdaRZGrgA2lBX
	2BpWnagWSD0lL15G9lDPmP7NF4RjweojoVmfGJdmn/uZugDE1rcCytvMFAlsToeM
	QQk4RKh6ASXqSd+u6/Z0ywmOQu36bKmUFouWCq5KtFzqooEQMqpYTcUruUJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789113474; x=1789199874; bh=+lRNjxagiC+aZCIy75QEUYiK7CYOUjgp56w
	7m0XmsGc=; b=vPT7lQolJWtudfHdCerzxeTUy4tgVsVMH8ENwYMUVqJ8UgeMdlk
	JrOnT3BlM8Nu2bD4FPsgz/bHJDnzpT1FpecajAgVf6suHpmd9WZQRgKpjULBQzW4
	WPgExy68l4eqRp/UqcZO8W3hwl0KMHSEVyuZs6KweFhELOTQNWT1Y6Emse/sXEFq
	lWOVQ4d6VXkQueTS8bYJb0HRoZTLj8Bmblzhe26WWMCe1GXz4jhkghNjSGYAPhYk
	tgkUWoNG/N8jH9KSuUsrubkCEwc2oihiZec3xnHIlnD4YGOkqNJEkhzkO9Z2GkDC
	EK1Nz2Vp37fVK4a32463xU/zslbCfyrWlbw==
X-ME-Sender: <xms:grSjao_omxg0MASbfM9mBdw7iKTbAkQoUI3bqYjJVZKriL7KHIL3sg>
    <xme:grSjaoJ2-KSd_WSdSNbU4UNWapeYxygWZYnUfK2xS-D8FzyFXHobi6avywRUHg1q9
    PNye0uvJoIqvw6k9NR3cSICxs4mzvaPww9icL7vfyMPSyn-TgJlVY0>
X-ME-Received: <xmr:grSjarZJmajaFC_ZzreiFrtIUYPVAgCJ0nnIUziX-MaGeYQ7ihbUSCrN3R6bhrMq5oy80A>
X-ME-Proxy-Cause: dmFkZTG0T3qYZCnlgeGmPSqKdxfQZuWtbwGXGUEb6jVmohMDhCrc1dSEfUAdTydR8Jv4sQ
    rP1SFe+9ew2cEWvRt7HIu3zZA2n4daWKLjnfcbrdrFmN736xadqU3TSitML6dtdKL+3dJi
    5iqxGQx6LsTKem32qgSe/ZCveGo4XVFFI/HHTLoDUFXOdhi72sdQDmKBwR+R5LL+t3kNR5
    aYSZVmDqhcz7W57pyd/wV+KpT5ms8U0m3HnVczdH0N3vmL13AAHC/rbp31HOT6Ac2JTnea
    nEBGiPxInvX87X/nZ5ob+dsWZEFwEPYAV2qSN75LhHO3S1lys+SUMybozbRkkY8VOc1OYc
    k6jH9lqFSCPWTVy1QoH48YlyyEiFrBhfr7MrmP4egFqkor654UiMf4OoxGAEQoNyQ16DJ+
    UuQkXqcyy22D7csCc3HKbW5qwBFFWPy3oK6JyeEcXK2PLoi3yoQuh5Y8NXB1Py+PsHDqHA
    CrHukbreYLGQieboC+nURQY1IuzRbz5laocxygNCz3txgNXmAso+325iUrRXz6QUCCKygM
    MU5wlodD7OqlwJAGg4zv+DwjkHK/lQNyMHPo20Etn111C2flE+FI3UweuedhkJvcOfAsRl
    uSQdgclDtJQjSac95U/PSPowbKyi4GEKwbw1PURpKMDBCW0roZqt34YzxF4w
X-ME-Proxy: <xmx:grSjaiJqEDLc_yrVl5ZW0WV96R6D1Mxo3bBPqcmOExgnPQ93GZ-lDQ>
    <xmx:grSjahA4Ec5qRF4IgUzLpwPjUNihli0pbI6tDME2pzjHOWKgubtHMw>
    <xmx:grSjavq_BM9XOyyA27DgS6PnJzfFST577EdGk8G5dVEYVI_Rlbd-oQ>
    <xmx:grSjakhjy50KjsS_dYgWBAeAiGu719OGqovOV-dbhiY_4VON-3vRzg>
    <xmx:grSjaoRNC3n-s_izFrIDJ16cUvgUAhB7eagvax0ZUGqGAeTSJNPuzZh_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 03:57:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c34f4d1d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 07:57:52 +0000 (UTC)
Date: Fri, 11 Sep 2026 09:57:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Souma <git@5ouma.me>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 1/2] replay: allow callers to sign commits
Message-ID: <aqO0fcF-feQHIjks@pks.im>
References: <20260703145037.69832-1-git@5ouma.me>
 <20260717145142.39478-2-git@5ouma.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717145142.39478-2-git@5ouma.me>

On Fri, Jul 17, 2026 at 02:51:41PM +0000, Souma wrote:

Sorry for taking so long to review this, I lost track of this series.

> The replay machinery creates commits directly through
> `commit_tree_extended()`, but callers cannot currently request
> signatures. Commands that replay rewritten history consequently cannot
> carry their signing policy through to descendant commits.
> 
> Add `sign_commit` to `replay_revisions_options` and thread it through
> commit creation. `NULL` preserves the existing unsigned behavior, an
> empty string selects the default signing key, and a non-empty string
> selects an explicit key. Existing callers zero-initialize the options
> structure, so their behavior is unchanged.

Nit: I feel like documenting the exact behaviour of that parameter here
is a bit excessive. You document it in-code, which is sufficient.

The changes themselves look good to me.

Patrick
