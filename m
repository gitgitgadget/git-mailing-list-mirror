Received: from mail-108-mta5.mxroute.com (mail-108-mta5.mxroute.com [136.175.108.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AE82BDC29
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 10:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756375295; cv=none; b=c/dFWyqbXATzHWknU0AU0ExohsszTVcG+21uSD9vKruUXEbvBEwe4MDFvcU2bSXaghHScHHjaln7kE0Se+Epn/WvFb5cx4xWUQ66IDM+jIVTDM27B6Ad4zQVP14oeapX1+Xvr9KDQRjgXKb6Ceubzn0s2Qg6+JqnHYDStmVKpns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756375295; c=relaxed/simple;
	bh=TLzKzOcUONU7dwTq66wvYE0HF78nfJAXjzgf/1ScTgA=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=TgYR/NBy310T8CUSsuUsEuOCMSsm3bMy9NsLXV/w2nrJ6SYXZVRjzklM//5cBcxAaHcVHtrzIxQW1JqRgJ4hSSD2UG1UtGXtRvOib0ex5iCpjqHjeSp8JutML71FNlJwk9Otr+sQ9t1pn6xgY+xcDkGN/IyqqL12L3CUpP3hGtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=that.guru; spf=pass smtp.mailfrom=that.guru; dkim=pass (2048-bit key) header.d=that.guru header.i=@that.guru header.b=Zg68NdUM; arc=none smtp.client-ip=136.175.108.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=that.guru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=that.guru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=that.guru header.i=@that.guru header.b="Zg68NdUM"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta5.mxroute.com (ZoneMTA) with ESMTPSA id 198f01b5721000c244.001
 for <git@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Thu, 28 Aug 2025 09:56:20 +0000
X-Zone-Loop: 3bdc20cad18e3735762c372f635683ecdfe06a6159fb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=that.guru;
	s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type:Date:To:From:
	Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=TLzKzOcUONU7dwTq66wvYE0HF78nfJAXjzgf/1ScTgA=; b=Z
	g68NdUMT8JL058T3Si0ATdMSSfDIYYG2ZBNYlV7y7lrdFn+K9gYkfpHFssYErwhDRYJDtNVe/zIza
	QX6kqabIuIVkOnoDQu/IzBDX8kw5pWO7IH7ghjrPREltVAaWr2fYU4U7fbjF1i+O7BJ2AEoRXHUSm
	8cp2TsqTjTmle8wFNCAdUa7yWya3pdS94dHXcp63mpFt7e/GJFWR9KNbW3Y0Q+BIQLZjmhOy5QT93
	ovYzdXWZwiJRncLYxrQaDxgSv1Vx1yRLyBLM+VGRxFMgu41vUAaVeV18AuqVytZwh6QsdrGpyAhPm
	JlnkUysUQ9FSmk+OQnwmQsfDtuv2XgjUQ==;
Message-ID: <53396d8a6c08c7045d0f381a10db8b3058565ecb.camel@that.guru>
Subject: Difference between 'git rebase --continue' and 'git commit' during
 rebase conflict resolution
From: Stephen Finucane <stephen@that.guru>
To: git@vger.kernel.org
Date: Thu, 28 Aug 2025 10:56:17 +0100
Autocrypt: addr=stephen@that.guru; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Authenticated-Id: stephen@that.guru

o/

Per $subject, I've noticed that when resolving conflicts during a
rebase, I get different behaviour depending on whether I use 'git
rebase --continue' or 'git commit' (followed by 'git rebase --continue'
[*]). In the former case, both the authorship metadata and the commit
message are preserved. In the latter case, only the commit message is
preserved. This can inadvertently result in you stripping authorship
metadata and not noticing because the commit message is unchanged.

Is this by design or just "how it has to be" because e.g. the
authorship metadata is not available to be pre-populated in the commit
when doing the latter. If neither, is this something that could be
changed at some point, either by preserving the metadata or preventing
'git commit' usage if a rebase conflict resolution state?

Cheers,
Stephen

[*] I'm not doing this intentionally. Rather, it's muscle memory from
merge conflict resolution =F0=9F=98=85=EF=B8=8F
