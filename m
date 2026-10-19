Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136043603DB
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 07:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792393269; cv=none; b=Qsl7BW1jAIQo134YhYBGrAwYO3TGrUzREThSpN1cYRbtUb4XtvDd/JJ5kEEDyMK0aQuwMYc2KiHb9XPp7EaL2iAD2f/kCEBZMMMUpvpd99gWaJbXOZWZP3npRFbVsdK7RnZMXDnuZZ8CJMAR09BE9pQZeIpyDqJyqp/nQzWQjwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792393269; c=relaxed/simple;
	bh=ULOdZX5eA21yp4ozwsy+mk0kycEKunZaOl16xq9Zpx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g36iYUOu8VLO9egDW4SxmyTr6hOhr4VBmjlJnQOjmE4DtqK4+xGnfHfrY1v1h4uHS/THJ7YR+eOG7QB7LvkR0SeLVDe9x85r5DH64Je33kQgdqPkcvryVTn/+4pQeO5uyhObQeqxrIgsSokfam7sKFPFnvd/JKuWYi0kndpf0y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pN3wmOJm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XfYoZnGR; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pN3wmOJm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XfYoZnGR"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 50AF21D00150
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 03:01:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 19 Oct 2026 03:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792393266; x=1792479666; bh=6dVwoyFbp7
	PG9I/vgEDKkmpZ6U5qYwj7qkSNW4xCR84=; b=pN3wmOJmlJH97dtkcLOFgakdTW
	/eIrjsaZfvmKYNuNnJq7wlekl4IrZJm9NQ5pO1ZeR96YkHlvTDSeVNgZXfCrw7Q1
	59dqzRFc4dVqbk2Pew7oV4SFK5Mdw5/M+R0HiGRf3OYIwWtyw0eYgXqXxl1Hhf86
	xIqzAIXYr9cK0++0i9lIJFGEM2x6aCBw2lupxqnzAdfkLZDpZDrbBL2uJ6XvxZud
	a6Vxrcv1FTROAd9NR+82wNNQQEfhcoVUITH6pKc8LpNLrH5LkHLErQ0Uwnr4ckPg
	extYrOWSmH8dqnGD3FCk6k2DsyoOkPkgtWx6L5PJyUIPEc7e5LLJdmArthWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792393266; x=1792479666; bh=6dVwoyFbp7PG9I/vgEDKkmpZ6U5qYwj7qkS
	NW4xCR84=; b=XfYoZnGRmhYuQuvceYd9C5uuZcFhsalxEkh9xNeQptvMLRcuJQr
	YzrCGVoV321Y5B3NUL7XT9GNuuJRkB14+EyoorvbsGtA/1ZSw/7CfVSfHlmbVuFu
	Gpwv+aeEDQhiA7lPQSlOB5xAvxjcvfmU5kKv2Yb5hpBRpDNLRdSWPCOsUer/9pc9
	45efTBlXQzaThRSoLfCyiE6IEcENBExnvR2loHIZ96E9dRNQCg4hge6PO/VWPKwi
	bJu68vd25XX/kp+0Sj2CXcJWEJmuVFVtabY8WkQP70t+7QtN8nFIsiEhSyOVran9
	ffr6UlSUhQvqhZXrbzSnwDQcXDy3/8XUgiA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792393266; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:tGxtm6bTWLoHDL68dKOZJ+H4k+e8pH3JZuJIWNniTv8aLKE
	19w1ku318TxtYLLoF5fS9pOxcxn93ucLviyc112yUPl2Eg9u1+ZLrbDM9zOhuygG
	bLd+TLuGZ61aKRkKTWxP+H+uvKXTKIhLsIwS8+6VLPJ1njFLTl6hi8ht82Q68Oar
	Ic+8toS4Z0Bl9KcpIas02rPhjqos2r3AlEA6aGedQmRt5vuU4jYjnJg5W9YEPAM4
	971VaNwtHu8oTKENgJYgx1m7XBOlim8ieBp1FXGmvcPL5+JVzWQhmpvt2rpkzy+T
	a2kB5Z0M5CQJCALmBcxkd/fHCFcTAECAxbMtiiA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:GjyBKk4VZQEPYp0IkxDaeKmLt27V6ligXxrbc8JV+Zw=:ULOdZX5eA21yp4ozwsy+mk0kycEKunZaOl16xq9Zpx0=;
X-ME-Sender: <xms:MsDVarCsnTv5WS4ytS4Q2mmnSBAakiul9uxu8lcVtm6OsZOuEdJnkw>
    <xme:MsDVavW0qLaSka2o2cdkK9e5y6NAz2GybWLhZbWbXcbhDIrVKDHQC0NLnzYintyN5
    FuA_V5cZlyzMT7OFc-fuwHsan4n6HV8txPFyswTdNmuWpDwYbvNMQ>
X-ME-Received: <xmr:MsDVahBghk0MJ_OgSlCsWlUkr4pdxFcMwZOeOgVdDLGUoxdbsf3ymQ>
X-ME-Proxy-Cause: dmFkZTE6xWSXN9BtWbHrVOOmrXo4W7hstCLt48FvaUFwvfnqmoK3Zo8Ltjtpqditc9aDpj
    pfsOYhX8hp7EZY3WJ9avmOPsFwhxeZ6nmsiJcJA7GaM8htVVQponXKW35PPf4UuSgkf4Fz
    uScjI4zkyKhzNh4jHKKnJy7g1ifC0cQfAbd2uQN0ADxzGXa7br8bHEaqJ7nUmoSDp5gnEi
    LXkVWuZbZPZTVifQAfXTsLhWVmvLT4ETRlI3hnv6KmwGb/KTwGSFJhoiR1930afYqGRtiu
    uOG1NOJnOkbv6X2MewvrVF6RS3hau42z2aGBjdnG7aVrljBSsFj753TzOhVQ+rX3IeDzW7
    wmPYyFdHhQiIFWlihNqHHaMk+q/3cMV0Purf45XaMSD8FWStpdp4Ojsk9u0/Q1dwa5ALMG
    BtGUtrgKcn4p+dTQ4UVTPz2P9tZWVI9XbfVgjaU1R74PxlQCSvsALj2SrYVtTiVYal+sYQ
    ticQlQuM3faN1aGeNkqZSKgD6BBD8kp88tOFzIAyuwqwK9Pw/ItAikGx+LCAihFiO66+Ua
    +duRC08mCuFZbOYRAR/cxGPV3UjPfxBrIpRqA+amWCdfyxRNDyu9LT411NMwyhmmTandPq
    oFkoL/Hwnvi8OBV69uWjvq5LSlfYjzZCHw1bCX/VFA9adbjfnmW7Ll8pK5Uw
X-ME-Proxy: <xmx:MsDVaq-U23lHJiy4lnOtamcLOcgsp1a9vwgFWXK-Z-nf-8fPZgyS_A>
    <xmx:MsDVagGcUoW6VEvMyLqDiZ64WN0HvedhfRcISKKAqHXz2XqZ0a-yPg>
    <xmx:MsDVagM5bsZklqP8SRm6-FDnqafg-KX6e9ZosmqlKfovXTVnwv7f5Q>
    <xmx:MsDVaieL_U8kNxot60AtTNPqiFxpbwoaRl0s4GYRZBqiyKzJzI-lng>
    <xmx:MsDVap-fSf-8NVE1T4mxhNvIFDiw7Djhf2VACoTyRDOH0r2g_9b4S-Vg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 03:01:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9113f7bd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Oct 2026 07:01:03 +0000 (UTC)
Date: Mon, 19 Oct 2026 09:01:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Szymon Wilczek <swilczek.lx@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] cache-tree: do not die when the index is locked
Message-ID: <atXALEuiGk0TrdMN@pks.im>
References: <20261015214242.1196722-1-swilczek.lx@gmail.com>
 <20261016091647.1332692-1-swilczek.lx@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016091647.1332692-1-swilczek.lx@gmail.com>

On Fri, Oct 16, 2026 at 11:16:47AM +0200, Szymon Wilczek wrote:
> Changes in v2:
> 
>   - Reordered the commit message to describe the symptom first, then
>     its cause, and the fix last, and explained the two things that
>     `write_index_as_tree()` does (thanks, Patrick).
> 
>   - Spelled the lock check as `fd >= 0` instead of `0 <= fd`.

Thanks, I'm happy with this version.

Patrick
