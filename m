Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0352D1448D5
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 02:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764901396; cv=none; b=COpDsojn7pw4oULNvrLZCS2xtN3KQT0Mwlo3yegkzqwtcfIYYYIuRjotsm5SiHEYtfWdIlevqeTcxD3gkjPDeYT1QlcrXrPTMBI2uqUBbq6Nj3MYd5+wMXgYYGNBqmOux9SVYoH760uaSpbbPqsKy0Fb6+hTpWKDNlP+D0CJO6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764901396; c=relaxed/simple;
	bh=cretG/FsoPAO7IvoNPfIOPy+PW5MEwZaIKBiK/KxLUs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KNyLvZ3z2f2lprNpu0vD75iEE/d3SUNn5io7zMB0gfRheYfLZ6ZrvUuiEEg2IytaELQ5tUooFALlouNTvnr933mq6/8jUaP+EkzRxzhYIZgXuDaVqgAal40GlBxZZngjhbtjX93wXrHGy9OgsGErjl/yJBpI/vEHNgytbFW6O1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=U1sNPPOj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ULHPb13E; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="U1sNPPOj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ULHPb13E"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1D69C1400130;
	Thu,  4 Dec 2025 21:23:13 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 04 Dec 2025 21:23:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1764901393; x=1764987793; bh=YyFY0/JPSO
	AenBY/BEr05xvX89+Qz1h2mq3MhQ1c4QY=; b=U1sNPPOjOEootDgDmOtOGVyScg
	jPwfZzQltfCUjNOCs+UDygwlMuZFe58CpP31H1vGgUn31VGvLkzFHRSy+hYecj4U
	TxPWdrVFzjdw6RU2n69DaH2/HKR5btOGE/X6qRcaZE3V4UT2ZxmZo3jq4mYJMeWG
	lW2lsVhxzVJLhFt4ZcetNmrmCBPqCr4YAR96XCXdI6ipglwjWhdrgplGi9boXNk7
	lvbv3WA5VEvchxq/wtQ/r2av6Mpl/WFJhxGLQ+lXzvYxRb+lqGXQnR5DGywCWjdk
	6hgfayfRtVYGSs0KuX2/I21y/ah6GMM/fFraWI4T01143lw4mKMSjOQ+7SAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764901393; x=1764987793; bh=YyFY0/JPSOAenBY/BEr05xvX89+Qz1h2mq3
	MhQ1c4QY=; b=ULHPb13EQu+4u7iqoV1GtgQotS6qgQOIEy+FegFOKXEULTUCbLJ
	rmvEO+3kxN7IE/tdHslnva+dHpUZ0Am5ux12cX+ue12+Z2sF+eBi+YugUBp4l9+j
	DSGw1yvfi0P8MBBGyZOh7I+8YRtmU96/nRb0irNMvymmVIK0jyRn5yguC3Cfue8E
	PQ+/TkflY8ddT3EfR6bMInCnon8bN/GSfwSC6UUA0lIeyIErlWB4CnSdfADFaAyE
	rlaID2iJWlaQflRRIxApEcc90gSdyEf8W7NF+BI9578iJQAks42X9NpNgTvRIACa
	wKW+IvuBVKMI6JMN9uM8PgH6MKoIIIgkieg==
X-ME-Sender: <xms:EEIyaUq6LTpZ9nuoZPBo9_JvbQMn9qdtDvgM5tab8uGIrHvwRNwVLQ>
    <xme:EEIyaRqOPSYYQz0hYtXrkkVQ-qA-guO0jbablApGi6NkbTWEf4uJbqzY4Hs_iZYbd
    rA0BIcLNBCNHv5uyNkVoTe4RXaGwlO3jWk7YEI_SzYYmubfOGDH>
X-ME-Received: <xmr:EEIyaePqwo9-IPl3KCFj5QLrJswd4leWtxKf0CLbDUGbdHFafgVJmDCpHhxgWhds093jC4zJ-1_QxzYVW7ospBNLAEtX6D99frXD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtre
    dtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgs
    ohigrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefke
    evteevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepthhosg
    hirghsrdgsohgvshgthhesmhhivghlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:EEIyaawCapH9Lfc27--CitBoFLJcnHUPmLEeHqnICZkKGFRI7OSUaQ>
    <xmx:EEIyafvgWnS4kk7Ublm5X5_UvnhcBF-v8C8ESYdauMpDLeGcXK9sew>
    <xmx:EEIyab6azZACF-qQMR2rm6GTOyCJXnyMeZG9bpAZWFZUOr1Nq5SSSQ>
    <xmx:EEIyaWSqpFNG08eq9MWECJgVFmx2dtQ1Ngem_LQInwor08Qh2v6Ozw>
    <xmx:EUIyaUfYEVrb4xCkoDvGVjB2fN_9nJ8AGz58jpcZMgHefsdmB4qixpcd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Dec 2025 21:23:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: "tobias.boesch@miele.com" <tobias.boesch@miele.com>,  Git Mailing List
 <git@vger.kernel.org>
Subject: Re: [PATCH] gitk: fix history window panes position
In-Reply-To: <9f7af47a-ae39-4931-805d-f6e4549231ac@kdbg.org> (Johannes Sixt's
	message of "Thu, 4 Dec 2025 10:20:52 +0100")
References: <AM0PR08MB5426BC141388A69BB5087732E1D8A@AM0PR08MB5426.eurprd08.prod.outlook.com>
	<9a9441d5-fb64-4718-8765-852e66458598@kdbg.org>
	<DB8PR08MB5433FCF25C0693952E0E67BEE1A6A@DB8PR08MB5433.eurprd08.prod.outlook.com>
	<9f7af47a-ae39-4931-805d-f6e4549231ac@kdbg.org>
Date: Fri, 05 Dec 2025 11:23:11 +0900
Message-ID: <xmqq5xal8y5s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> BTW, the email that I received was not usable for git-am because its
> body was base64-encoded. I had to copy the text from my MUA to a text
> file before I could apply it with git-am. If you have trouble sending
> out unencoded, raw text mails, please use Gitgitgadget if there is more
> than one patch in the series.

"git am" (actually "git mailsplit" that is called from it to extract
what can be used by "git apply") should be able to deal with

    Content-Type: text/plain; charset="utf-8"
    Content-Transfer-Encoding: base64

so there may be something else going on.  The rendition at lore

https://lore.kernel.org/git/AM0PR08MB5426BC141388A69BB5087732E1D8A@AM0PR08MB5426.eurprd08.prod.outlook.com/

seems to show that it has in-body headers that should have been
moved to e-mail headers, but otherwise it looks more or less like
legit patch e-mail without anything unusual.  It could be the patch
may be full of ^M, but we cannot tell from the way lore/public-inbox
shows its messages.

