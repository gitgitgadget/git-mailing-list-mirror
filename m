Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475B430566C
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781256402; cv=none; b=gMjzI7/L4duHWz6H0ILOFO2akTrulXVqeKBNL8PlvWjcWlAwgCsObod0eDV7wZsjwDiphPLRFpMwRIZ5Lr3+UNJifbZ1Y35+/vwvLplYErFIJFMmhAcqWwhtEbiIfWi3Wa7EMX4Vs22WyYbNp09hWdSpDq5h2eM9Eve1vPDxxks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781256402; c=relaxed/simple;
	bh=6gdOoSL8Ca6gYigAXf554mlYJ3m4Og01wzqrFn93gR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDAVftOGrZ7Z1dqiIvzbxeQTnQk9Vtw+TUXMWRodyPRkwPeHpjftSg0d/q3CcoxLIIP+8gUuToC38c7fK/w93aCpYI8bJaL/KbXA9RfW2meOdvL+e+GJ5uABfDaT94lpx7Te1mIkIogX4qH+LHVPRuC4I/p9JonsN2YDHyeP4wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=CqQjiIO1; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="CqQjiIO1"
Date: Fri, 12 Jun 2026 17:26:23 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1781256397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J2iZojrfp7vTGm2byczLjZrMja37QzJARgsdTI67p/o=;
	b=CqQjiIO17cyXhxC6/3Lnjzp8lyXrTQGZQS2x8sNaMxKpTCdq43oQfDEBLcWl13Si67BbGI
	IZ/RkdkR3u/bkCizOMIlFQvQRNcHyCi3eexkx0Xko6A7RBlshQce6scrolSzazAvWkSvW2
	cogSpgCsMvRNt8QOcGRq0WwV0cZfL6cfZf2g9ScaOU3Sj3HMv5Pu2GgcToNMCQWQhfVLTF
	AfB2KP2TaJu2SBOSuHpYc0zSpqHtwLWlTqLOKFEnR3q6JjPW7jqcAMFNgoG289kMgmd3iz
	WSGTJdRZZfByI4Zm7cwhooR8N9N376ipoC/ySdTC8j3vDDHlvtQesdyjMuLHBA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee <stolee@gmail.com>,
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] commit-reach: remove get_reachable_subset()
Message-ID: <aivQv5FkTEWDn22i@wyuan.org>
References: <pull.2144.git.1781033285419.gitgitgadget@gmail.com>
 <pull.2144.v2.git.1781178567862.gitgitgadget@gmail.com>
 <ffaf26b1-c55e-43c7-84b6-f810a54f7717@gmail.com>
 <xmqq7bo5nf31.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7bo5nf31.fsf@gitster.g>
X-Migadu-Flow: FLOW_OUT

On Thu, Jun 11, 2026 at 10:48:18AM -0700, Junio C Hamano wrote:
> I wonder if we should talk about it in the SubmittingPatches and/or
> MyFirstContribution document?

Hi, I think it might be a good idea to cover these details in
MyFirstContribution, then cross-reference them from the part of
SubmittingPatches that discusses sending a new version.

More specifically, I think these details could fit around steps 3 and 4
of "A typical life cycle of a patch series" in SubmittingPatches,
starting around line 54. That section may need some reworking of the
existing wording, rather than just an additive change.

Also, for the part about sending a new version, I wonder whether it
would be better to summarize and fold in Patrick's explanation here,
thank you Patrick:

---

From: Patrick Steinhardt <ps@pks.im>
Message-ID: <aietF4BX1Ewt3cpG@pks.im>

> By the way, how long should I wait before sending new versions of my
> patches? I have 4 outstanding at the moment.

I typically aim to send at most one version per day per patch series.
This avoids that you're "flooding" the mailing list with too many
versions of the same series, allows you to address feedback from
multiple folks in batches, and it gives you enough time to think about
the feedback without having to rush anything.

Whether I actually do end up sending a series depends on a couple of
factors:

  - How big is the series? The bigger it is the more time I give folks
    to perform reviews.

  - How substantial were the reviews you received? Is it just a couple
    of small typos? Then it probably makes sense to wait one or two more
    days to get some more involved reviews. Is it something that
    requires signifciant rework? Then I'd send out soon so that others
    don't review a patch series that will change significantly anyway.

  - How close to being merged is the series? The closer it is the less
    substantial the reviews will (hopefully) get, so it makes sense to
    reroll a bit faster even if you only received minor feedback.

So there isn't really a golden rule to follow here, but a lot of this
depends on gut feeling. You probably won't have that feeling yet when
starting out in a new project, but that's fine. In case we see that
behaviour doesn't quite match the norm we'll typically give a hint that
the contributor should slow down or maybe send a new iteration.

Patrick

---

Patrick's point may be beyond the scope of this thread, so I only
mention it as an aside. Maybe these could be part of the same series.

Thanks.
