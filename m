Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E2F1B4244
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 04:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767675367; cv=none; b=PBBGSiowtdo8TJw3e/wBqteFH5xUmBQNKBb/TspjwDM0J/0MUohBZCgXR24ia9TxVwI8ApVguzghgg8tFkY39vJ4erFcn3J67WZzaH0Q2DlZ5dUdQgr2iNLfU/7IbYoPf3Y8hnOImxMBb8Jm6Yt0YVTe78a+ZBMY17aCjl+SmXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767675367; c=relaxed/simple;
	bh=yKKCoU3mj3wh+sYFyb/j72Viy4puNwnSTNYd0tRgMko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VK6Fj1sCIl/curs7CwFvfwi+H4MvyR7llFLIe/oEDwmq31q6Ptj/DckEjMKIO8i2jHYC2IoW1bfCyLUDqtZTaphzk3a/Q87uG/2MCnv2JHcv9Iu2eF2m/EixLLlp1kRew8D7vKa2v7X3j9l6T6mAypOLQccW5k9NQNgeE2S5xdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.dietrich.pub; spf=pass smtp.mailfrom=mail.dietrich.pub; dkim=pass (2048-bit key) header.d=mail.dietrich.pub header.i=@mail.dietrich.pub header.b=pYjP2LxF; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.dietrich.pub
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.dietrich.pub
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.dietrich.pub header.i=@mail.dietrich.pub header.b="pYjP2LxF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.dietrich.pub;
	s=protonmail; t=1767675355; x=1767934555;
	bh=yKKCoU3mj3wh+sYFyb/j72Viy4puNwnSTNYd0tRgMko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=pYjP2LxFop7VYnyVwJK6XfZATftPm4Ce7DkrU6JfKLDqkopN6JRzJyw/8JNObiQ+b
	 fQ8f5PW9AiK/4xao3gKeqCq3nmQuLKIkZt6LVn+g2pnqOS11KE+jWAGwMiLe47n1hF
	 2tqvKQIEPxoY9zqCjlpB8AmXN1o5j9/iQO6/jExaEFCu4g3yVijJE+uxvMCjXSsIdO
	 FnIMdw/CwB1dDKodPbGePl8fCUAQGkFKepam3mUFUbNZA4vqlvl4pujPFlr+IDaiJi
	 WzXX2k2MX9aWWGe8nqg5OEW+D8e8SF8QxAT/ccbjDIppObiAsusA99cY2C0Z323C6J
	 +Ab6Tb2uVQA/g==
X-Pm-Submission-Id: 4dlf4l46jvz2Sd33
From: george@mail.dietrich.pub
To: ask+git@howdoi.land
Cc: george@mail.dietrich.pub,
	git@vger.kernel.org
Subject: Re: [Bug] Git subtree regression
Date: Mon,  5 Jan 2026 23:55:28 -0500
Message-ID: <20260106045528.2628818-1-george@mail.dietrich.pub>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <4a9c1a5f-336a-472c-af1d-7011fad776a6@howdoi.land>
References: <4a9c1a5f-336a-472c-af1d-7011fad776a6@howdoi.land>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I suspect the best way out may be to remove the `should_ignore_subtree_split_commit` heuristic entirely.
> It is mostly useful for repos that use `split --rejoin` a lot, and the check itself is slow. WDYT?

I think this sound reasonable yea. Should be sure to include a spec to capture this case going forward too ofc.
This would at least fix the breaking change, and some other heuristic could be applied in the future.

> git v2.51.0 also adds --gpg-sign compatibility to subtree.
> Perhaps this is what you are seeing?

Hmm, I don't think so as I'm just learning about this now.
Will give it a shot next time I have to add another component tho!
