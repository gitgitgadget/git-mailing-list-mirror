Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4A53624D7
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 06:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773903396; cv=none; b=d6oL/9Knu21dDiKyxoJxr6x+oRgc4GFr2pg0+whKa4pIi64mBvqhtlnEN1NLNZaBYFWPkgJmL/8s9LHjP6NGVDIUv2aQCWRt8FpsaAzzfYx6mTV8IXybVfrUaJiKdfoS6PzPIZypMK8tM+kJB7gVaAJFbv1qp3t/2c5rXUv5vOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773903396; c=relaxed/simple;
	bh=gGmF1oezma9ojIUFUgTkwhTHvipI0JaCCjtnZAbqhxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNho1Ofe+wapAvhpvUJ74Gdc7nLCsmHFb9ZRqcffww1TwmuJ8SGqugQ+2kow36igwt58AZLeofm0QKfQdpMIEh/IS/QWSBVotvRWcgxI4kLhvTozn+tEwd8cZdSTkCNJJsnrbmj98DFlHoP+adrq0iI/tB623M/zNwoG3nfEv0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LXLwM9rz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FcXB0hJP; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LXLwM9rz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FcXB0hJP"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 95909EC0222;
	Thu, 19 Mar 2026 02:56:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 19 Mar 2026 02:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773903394; x=1773989794; bh=rzWqYteOFK
	lAGf3zkjCqCVE6L+YcTSPkQ+pD91eOg9o=; b=LXLwM9rz3mlzkVYd5br4UZEh/I
	7VLq4GPmdBDru3MEo15B17xUPGMVd4TzA8/NAa4AHqBYszE5H8qlVBBWbmHWBFc+
	wa48aRjYKTC5IGy+EGpSZXa51yaU902737l3iBp+OlJ80DhrcPUanpFtUh/1ALaD
	sS+1iaMiIBWde+vDNC8bDi9FvVXPOm7tkyxxaiAVD+B9W/lCCqaV2szB840Er4HS
	VXvz8kXTvkK6uD9s4GFLdFVmat5WDbSACaQpOV+WMa4tEZjWrpnzkZifq5S/e/NP
	53Y+CcGRdiSf/DXGnWiinBMUh6BEOj0qZzepwQgioDKpBck6HYN/UMHw4SPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773903394; x=1773989794; bh=rzWqYteOFKlAGf3zkjCqCVE6L+YcTSPkQ+p
	D91eOg9o=; b=FcXB0hJPuuRDKkBdpnw+Y71LzUqlMMczy7cezwgxuiZYk71cw6w
	0L+pV9bmLwU4F1/02EQKH6DqV/7NzvBT07V4DxC8D51FR5+aMiUsetAyjQvH0EgA
	4KQdZ3pZcMyANLlucA0O29FqhsPtpQCvD0N/ZL8uJudZwkOL9V0V/I+FHCwBLsAY
	lWPbihGQhMW2gdEqo8UQfCcYXQ9tgHiS4EoFsfnDeqyW3b+tXlGZ6CZnI+CQH7nA
	KbPkAyPnIzTEKyeNoBhFCNHcuXSARAHss5jpuj7APYCtfYjcDyjsayuM8gDlVxWL
	ANDbr0iOZjtRmrLgYAqixNwIm/TmeajcZwg==
X-ME-Sender: <xms:Ip67aTnW6KJXLrDAzw6tUNjAVdVl7aaofL6hL9aA6c_A1mn8vcAMBg>
    <xme:Ip67ac0LulBFbg9MuUpy9Hwr59anzBz_ltSEyhE-Cne76VS8_VeU4pozJgISDptDW
    BQuGAskZ4BFwWtTQLejoJDVBwGwi3uftEJ5qhTDxS89VvU6bR__zQ>
X-ME-Received: <xmr:Ip67aXQqFmHS_RZ2cCYmcEpWy7P-xb494vUjY45q3fhCKTcsvGWFWdqRU1VDFQ58tNv7SWf9d_TugNrFa13fuyzIuaFWrzryjCJC9eYNjx7l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeifeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevhfeffedtteeluefgtdeugfdtkeeugfelke
    dtheegieekudduueevgeehudekffenucffohhmrghinhepghhithhlrggsrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Ip67aWuUXiNTC0wyHdyDusxxKzOnxuBXzKARxjSwJWonopy25W91_A>
    <xmx:Ip67aUbRB4-2HEwNFlX3JZuF_BcSsxNsR2E9bqx46dqy1OyhtRGISQ>
    <xmx:Ip67aTvqeCr_BjW5xqItF37leakO_6ApGqQACBovaO2yDkspkFDWkA>
    <xmx:Ip67aeFv5atgq_b-AY93PazaLFpYvcAx7UnKiw2xovQjZNlBdYmN7w>
    <xmx:Ip67ae90Kjvgfa0ozzgynzFuWSLJGvSpIMHCaOTteWFTG00vFwWwUrjR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 02:56:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0256f2b0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Mar 2026 06:56:32 +0000 (UTC)
Date: Thu, 19 Mar 2026 07:56:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] commit-graph: fix writing generations with dates
 exceeding 34 bits
Message-ID: <abueHjVHCztQtL6b@pks.im>
References: <20260317-pks-commit-graph-overflow-v1-1-e6bee22cd826@pks.im>
 <xmqq341ykzyc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq341ykzyc.fsf@gitster.g>

On Tue, Mar 17, 2026 at 12:39:39PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > this fixes a regression recently introduced by myself in 024b4c9697
> > (commit: make `repo_parse_commit_no_graph()` more robust, 2026-02-16).
> > The regression was found by GitLab's tests suite, see [1].
> 
> Curious.  GitLab's test suite runs pretending that it is way past
> year 2600 or something?  

No, but one of the test repositories that we're running tests with [1]
contains such a commit.

Patrick

[1]: https://gitlab.com/gitlab-org/gitlab-test
