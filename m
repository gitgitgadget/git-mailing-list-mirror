Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DDD1E1C36
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739296320; cv=none; b=kTvaWS/Va155rWzUbjK5Uf8F1AdWkSZVXTEaKADC8rkmDh8da7kd5v1xUIDMUGk8UX8xCACMXEtMGxbO3xT1UoLA0aq/gr4ailMP+J914+l45W5Mk/QR4aWhoKuugroxhEvOBG9p2ixwGzoYdGZJ8pO0a7qMdvnijlge0cIC80k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739296320; c=relaxed/simple;
	bh=NUShJEacqJgq3N5yqXmVVQEgZmCvikVEk60QFGTAu4s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oZBfM0+Pd/yv3c4PSLTolCJIBBxhPxoex+hbyJej42akgxFtuZXu33/fhLOoFdt0QoMxC+XCLO0XxkYWFFnjQX9mONrsXRYs4KtjQ2qo6XomLooesj+blmB+qU+qIxXrs5YkOe1awwVCl3tLn0L13K8wLxpX9/MmrRwmM9gN0k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Lx/hgUAD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ui7MEdKO; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Lx/hgUAD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ui7MEdKO"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 56D0B13809A9;
	Tue, 11 Feb 2025 12:51:57 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 11 Feb 2025 12:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739296317; x=1739382717; bh=H5vKr7Nw16
	Ol+sSQEa8+q8nNMYtSl/ZtAucpIFjSqDc=; b=Lx/hgUADbtHhmmJJtJfy/2TAy0
	Z2le4nf9TpbXj71LO/LrL2xTN1Yjhc9FnLvhpRaepcZc5URC5bP62bPN3QyZrHRe
	xI7dFgYviPZoJYd9K3R37NBwMKPkoIdh1NysKOMtH151t4+ELho+m63gUGllwX6r
	+EEuF19k7qCUW3pcWzJrXOhPgFhCW4F4eZPjLyyYTDLzBNlMFyGMyMz04BLo0KaC
	0ndQIQ08lnbmyH+Po7L8dq4SLVDfohJ1B1pW3IIccSBDn5LwgodoIUGVKoMZKIpO
	DrGwpB6ALIMo7K80FLzYSexTmQqFzr6TRHwxvUU4iRJve+EP4ynYqb9TQxKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739296317; x=1739382717; bh=H5vKr7Nw16Ol+sSQEa8+q8nNMYtSl/ZtAuc
	pIFjSqDc=; b=ui7MEdKO0FCBJn73gAOotm8Ef7CTGnVOHvlvEVwW9zfp/LJ3Jx3
	Pur2hDhDz+LpoxJaKBCKHhZ8fqF+XDaMPNHMNAGFPVa7BOomFdQTc6F4ULC4fnD0
	HpL3wGBCYL1x4eZQEplKN7vbAQS3lNvYqFofty0YLycFn14uVNXSfXRm5BcDWF3L
	w/YPMeudh0TfUJXj/uMh4k190QHUMWxQB6cM5+WNV/BUuYLtrzf2Q4pE1W8PybB6
	YPHxmthD2/aWMzDG5aoxQll7fRNYh1kwgD7Cy/Tr5H73BOBKBp3uDSF3cbNemo63
	l23l6nOGXveTtkemPD9yFXl2ko39Cz6UfPA==
X-ME-Sender: <xms:PI6rZ7-dEVOpWGVL73bt8FHxgxO0lSIVrDu6uFZ1P4QawDRtKwg6SQ>
    <xme:PI6rZ3vgQ4hRBU951pWWFx0TSjW4VslGHXHGNGjfraieqWklwfKanszhfM9Dg68V6
    oyQ7LVUMFdDcaFlLg>
X-ME-Received: <xmr:PI6rZ5BuWZPW3mTfoMpkZWlEpuubwWsjfc9bFOTIs2PGNC8wGFGxm_AAUIPLYktrXDSF3N57UkF0rfDcSsXIz1VTfiI0eNDlI8rDBZY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegudeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:PI6rZ3ffDCg58hFo2PYD2OLAnl0PHDumnZFhJu3ytMHDdWlOGOnhwA>
    <xmx:PI6rZwPUNw7fP7_i4MMCPOSfQatHhegz9ZxMR3O8OgBwZzABj2D83g>
    <xmx:PI6rZ5mT6sP1-4SZF9z_mqlnphPPQyw08q49UOMAUINNrlcu32509g>
    <xmx:PI6rZ6vfJV26729Lw2vv2YtSDemTtXgpRt9ihcEaFiJceujPOoQicQ>
    <xmx:PY6rZ9qYdWXij1frmMO36LLtjc-s6oU_hC5a4JyRxXXsLth3W--E1COC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Feb 2025 12:51:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] rebase -i: reword empty commit after fast-forward
In-Reply-To: <pull.1860.v2.git.1739289549299.gitgitgadget@gmail.com> (Phillip
	Wood via GitGitGadget's message of "Tue, 11 Feb 2025 15:59:08 +0000")
References: <pull.1860.git.1738751840816.gitgitgadget@gmail.com>
	<pull.1860.v2.git.1739289549299.gitgitgadget@gmail.com>
Date: Tue, 11 Feb 2025 09:51:55 -0800
Message-ID: <xmqq8qqcz7wk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> As "git commit" will happily create empty merge commits without
> "--allow-empty" we do not need to pass that flag when rewording merge
> commits.

Thanks, will queue.  Let's mark it for 'next'.
