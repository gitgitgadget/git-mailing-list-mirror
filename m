Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2261DF254
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 19:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759778398; cv=none; b=WZf3Cf8Egwe8TknipQ50htyIGVo2/eikqjEaF9pi+zqIsCJ5WmU9CDzMQxXGOdps39KtxFNw1Qj9fJ+7C7GwgNrpZcFLb1WRtAj+U+Gm309P3LyZTdhtjPqWSsLns5+4ZqhV+hjoXclrgQuJn8uhDLm/TJkmBuImtNSvP6514IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759778398; c=relaxed/simple;
	bh=KmwSN1QeYxH62HZvEguJZYwECXvAGUkdMKkkNL4uOLU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijuMsAJGtQZ03/xEvJPnQilYsKUrCo5cjCpCLyqdZ+tz0NtHK9KGWi4KPe6+sn65EcYxD5RecEpz+Kat44hpbvNwCjhmp+fph9jVTwBBFpP0tdmEbPZw+hVlOIdDrq62NNpy1wseBPzNUJ9ZdU/q7f3vhlmISjCj1n8HpqBWB/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=T0rQEP6G; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="T0rQEP6G"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-93607aec358so127141639f.0
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 12:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759778396; x=1760383196; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYr4UhpkFqYWl6D4MTW9tLsLg5T4mDUmhMu7IWg7gIs=;
        b=T0rQEP6Gh+y0M2OIFR5t+wetdK9rIsjPbYmDG1wg2zRZ7zitkX0Z1544MZ1hBp/D9q
         IRhR4FDRozt3OVpCyn8U/5v+QAfMFFJFMbHbSXh97elN/lCugPYhq+FuYhQRJ3Qz+PPX
         LHSOQZ4ii8qnJE3g1ACbMh0YyMivMMpf22F9OF1hIMDNBL09haQKTSwZluX6U8SVSNzN
         lgXPmusU7RmxDNik67c412IFM7mGFmToNlk4RKqipqV1T+G8sL53wR49QKC6WpB1GLE3
         Zjw1jepJkZW++Rv00Lz+BwGWPvWb1dWkjgHOqWpLRxRIizeGHno6BMOFgOnC/IyGtQ2d
         0Kwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759778396; x=1760383196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yYr4UhpkFqYWl6D4MTW9tLsLg5T4mDUmhMu7IWg7gIs=;
        b=n/pK2qa7fjlSdhIeyK26plygzAdKrHcT0QN+M2HEmiDADosqGGYW/L5HxO4iKrclTA
         17m7O2ah0RTMnnvcPMp6C+zq2fe0oExT3g5VVPYRBYDJanEuVkvtJX9B6dw7bse2j4cq
         zwPF/8MBhPrt8DH1yTzhMzzU1Cs4K6lUs9lQoAnouU6ZM506srndrDE94IY2gkhfQ+LC
         FZx+kBHX51EZCHjHCGfG+BvPdGn4Ao9mzm4tormMv3ZwFVjR2vxx3V5MEpB2myLep/xP
         pmztpV/KUFetds6r/oCiECS7LWJRz2VRVrsxKP3P3fOv80y+eaBM4au2JPTuWLMoacYs
         Jp8Q==
X-Gm-Message-State: AOJu0YyddW7h+VpgiK/Vh3pim3gN9MdU60BMn2QROczLjvh0dEmk78qO
	hEiUXd/2NLqVhKI25RLHjR1UcmDLcuvLbL+vrQGIfhnxGK3CSNJrIZhIjLF6guAIHS4oUs+YiXV
	VjbP9p+T0Pg==
X-Gm-Gg: ASbGncsN1lNx3sbjK3y6E/P/eZqiloXJaJ2zrjqzNzVs3x/uyo5lWLTQw8WU7IO8+Ib
	2OMVrJywS2XCySbBpLQMwJacpfgGu+a8BsYmOwuKljs9egxXdOgVJ8guAVyvnGT8YpSd2QqkHTh
	DIv9yovFf9C4ux22WjQ7dTjK1u2nnavsYPqkA/zOTkKjdVD9ziwpNEixKlDh5JkCbBdyYfSoRP4
	G7Z53XBDASFUM4c5cPPHiKVKwfJyAmtg13Z+Z9aYTgc9lygO1MrqYCCHiUG+2fbn01vcImYmRCi
	SeqE9+KxX0/B4spXshPq7S+pRC+fJuy7cl7w6nQx6X00ra0IsV+o4R+He40WsIZBhgbIKmN8kAU
	Mo4WSrY0HZ/SDuxwtt0zlFrrg/ib4YVqvl8TREh2gQTH4DgplKcq6mG+yeo9kCWm2U8OOVdo3Em
	SStqSxzoh2NMRzCfxbYLk0gVJLpF3JDNFBAyig3Dr5Ti1aaBQCcYfJqCSunr+T
X-Google-Smtp-Source: AGHT+IGx0ZPw9PaJZTngTrD/T+sZDR9vuVa9i3uv3ukI8oigWmb7KsporObzjqjU4WrDfz67qDCJsw==
X-Received: by 2002:a05:6e02:1527:b0:42e:7426:7cca with SMTP id e9e14a558f8ab-42e7acd27edmr159939495ab.7.1759778396217;
        Mon, 06 Oct 2025 12:19:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-42ea782d1a3sm44325655ab.16.2025.10.06.12.19.55
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 12:19:55 -0700 (PDT)
Date: Mon, 6 Oct 2025 15:19:54 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [NOTES 07/11] Change-ID Header in Git
Message-ID: <aOQWWkj/q7GfKZY7@nand.local>
References: <aOQVeVYY6zadPjln@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aOQVeVYY6zadPjln@nand.local>

Topic: Change-ID Header in Git
Leader: Philip Metzger


* How do we store the Change-ID? Store it in a header? Some auxiliary metadata
	store?
* Happens to work in a header for GitHub because they survive rebases since
	GitHub uses replay, not all forges do this.
* Want a standard interoperable way to associate Change-IDs with commits.
* Storage discussion has largely been covered.
* Taylor: what's less clear to me is the semantics of when we keep Change-IDs
	across operations, when we assign new ones.
	 * Cherry-picking equivalent assign a new Change-ID
	 * Almost everything else retains that Change-ID
* Taylor: we need to agree on the storage, but not necessarily on the semantics
	of when we keep versus assign new Change-IDs.
* Caleb: Assigning a new Change-ID when cherry-picking is interesting, since we
	(GitButler) retain those.
* Philip: Gerrit does the same thing, but JJ does something differently. Their
	approach was to have an optional header that describes the “origin” (in some
	sense) of the commit.
* Caleb: I wonder if the semantics are important if we are trying to use these
	in the same sandbox?
	 * Taylor: we need to understand and agree on them when we are working on the
		 same repository (regardless of using the same tool), but not in general at
		 the tool level.
* What's the next step?
* Martin: experiment with it, see if we like the semantics. Don't want to
	emphasize the divergence table.
* Taylor: do we need a version associated with the change-id? Philip: no, we
	treat it as an opaque identifier, versioning not necessary.
* Elijah: given that multiple players want this and have agreed on a common way
	to represent it, maybe we'll have a more productive discussion on it in a year
	after they've experienced working with that header for a year
* Jonathan: does it matter what forges do with automatic squash/rebase?
	 * Philip: for JJ we don't want to use that information, but we're just
		 another Git client in the ecosystem, so that's just our perspective.
* Martin: Should there be agreement on the semantics?
	 * Elijah: depends on the usage.
* Elijah: semantics get fuzzy because of splitting and merging, so not clear
	what to do there. We either need to clarify it, but probably not here.
