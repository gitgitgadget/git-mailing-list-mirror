Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702FB3C197E
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 20:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785442426; cv=none; b=fSIWe6ZRu9/reFC0CAv7lPIZ5B2UOKg9fG8wklvgUxm6nDE2Fz6xZe2x7Hh9P04IoqEWRcT/nclI4uaY48DK734sl8Lq7yMR8MosuZIMfKNTdxranqZySLEk9lTrsDCz/nPmZC1ZtkeE4VHuZWcuv/NjQQXb76JzfCZsuIRqxLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785442426; c=relaxed/simple;
	bh=Ikrd97KKIf+CygC1LTdTUm14JkG75Pis6ObtYCJ5lNo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oId+yx5klHtVvH2dNGsAMnBdHi/AuR47T8dc+2hhuJM2lbLFdLS6FPxhNX92RSLwDFlWmGxtKlhZl6Qa9lngl0t5VvIpgUXSahRJPOomnGHheYCZhkKBOi3ac7Jk67EY8nC8PGo1NzALKYKqYE+zBo4QZcnrppwvRR7j6DjX/ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z5YT2n8F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Clmqfk6l; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z5YT2n8F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Clmqfk6l"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B497314000F6;
	Thu, 30 Jul 2026 16:13:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 30 Jul 2026 16:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785442421; x=1785528821; bh=gRcsHYyjPo
	G8WtJKfc1nCAKH1JYV08ztKUcCYDY8fE0=; b=Z5YT2n8FENDelR02s436XwzoOk
	CK3qQHNV4Xb96zCz5qqg/Txl+2JHSAcI2/giVYlMreYSZOrQaXHhdpg1wnE4JX3f
	sOaw09/o1vgi/4oBJd1OGkKAxh3eNszBs3fZfy5Tgc1o7agAbkO5LIUDIzYKZk6+
	FanVQ83JdgT3vRI5YplwQncHnb8eUdBn1w3HrH630ieolCwXWLamPJMStz5Yil1N
	K/bj2tpfOZfungdAbULx3D/un/kEMvGlxtZqdGD+ljaZz1F1rkJ5Re+HLuw9pCnQ
	fuSZSmZya30LVFDKjdT/2o28F0Bdu4V8wXrLzkm2rVjkSeOZy2GFgSi6fi1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785442421; x=1785528821; bh=gRcsHYyjPoG8WtJKfc1nCAKH1JYV08ztKUc
	CYDY8fE0=; b=Clmqfk6ld0uKPn/yt0csKL7RJz6SQMSfxqMKzf92za/nAxx7J68
	H+OSyHrxUFmgXo8ZXYyejx0tUEDNl5OzD0lci/TnGM8IpCRVA7tVL5jzceY0I2DW
	ft9f7qV5lUfvsyGAS86N8p3Ix1BEsbyfKLDWQI/EYKZJRLJVWHwOv37MV/0fuXs1
	TNBPl1k/JLtzLZJ0nF8l/qZaGc3g7rIKsYzNG0vLUof1djxK5zVo3LscSqEyc6PC
	TxJAsPF1mN5ItGtfx6IhvCFE+OzrVc0MPLt/OsoEcJ7Up7pny052pygggy+avbAI
	T9iajBt9Zv5r4+Nd/9KnyO74BW918+eyehw==
X-ME-Sender: <xms:dbBrahztPyBzH9wzXzfGGQAPv3Hybk7YqddtvVt8AcXVaKgEhKri-g>
    <xme:dbBrak9egP-SeY5WGtzgUFfJaHviHE_V58w8wEX6ZQlaEIoSd7pH_W8RVut5BFdF3
    bRw9p1N2dZsC8giT8gmfPKw5QKxMnFak2Zb7KEb1iEUwrOnOP8V1eY>
X-ME-Received: <xmr:dbBralJ8-tlS0YVKx0-y9tDvSCQ6V8mYnJ5xZL8mHaPzX5bNyYaYmR-iDRJIhL7P1C-VRBHHssWqW1BhE499CzRQntmL3T44aA>
X-ME-Proxy-Cause: dmFkZTGEjugeKhuL1/HPyZYC3t27EDld1sJWgFc4j61KCjYIlt/WgTBGaLKwDo9RAfBQSf
    +rqSdyD1KgaQo5sH6d0Cm3yEhqUA5XttakytTXUj62weADel+esWodsgkooV5z6p/4+SGR
    kJaZ0yro0pFPSpaUVwsH/y4CCdRRAz1r6NQURKkV/hTnXd8DWGdVfQO3SS9Or4Fj/xawTY
    uVnawKWS5mp790VHVfvVM6aku62pnqfL+3qIWE5p3rGCMbNghVXE7A2g8KWbnoSEU+V98N
    gKVi/+qHv2MkGwkBDpJJRjdXp3VQOJFlCzEgdv5ZLDShSO93V3TKgLyeNclyoPnKd0Pldv
    DFg+kYirHemYUHPAvUPwIiYh/mhHAXJY8Qwo++SEwnNwV/jb7pr9KHkiF8S20ysyqQuxu8
    SMoa6YocI6hTRUFOr74ifUYkC5ljpcpq8sAvk8T+oq0S4d5HBdWUlFuB8nHxNrsMFOqInf
    twuDF5ZzYcynm7nSR1cqekW3HOs9Wh9sKM47ngJrw/wHppvP4TOyR5XXIFQTgb7KVRpVeJ
    Tlj9S0ZuZMtOCmXJwxbpRNhXZoMUyUjcXrCqN8GsY/reYfboeqrD+eFaGl7ZQlh/snAoM5
    Qatg2Ojg1nj4qgkD1fa7pTtLfFVL6EA8BwHcYgaH4zwCx5ECynN35tH0ncww
X-ME-Proxy: <xmx:dbBraqcK3naJonDW8dexgweQAWB7M2jHevAe5oJSZRzJTJgUyfGg5w>
    <xmx:dbBrak9ihiS6XqP1x6d0F-YrqH2R8I65Fhy_xtxKYdqnprzsWVY8sg>
    <xmx:dbBranr0jvuCnQ3zEmysmR5khRkOk8oER7Sh3_RkWYKBoczI2-KiBQ>
    <xmx:dbBrapAqBMaWvqWzRp5S6fe7qSxDGQP48ndleR5GWpYPi8EcrJmLPQ>
    <xmx:dbBrajVflUp6-cCCgUkbjxuytA4ZeQvgnC9kMmkpg3ef6-VnBk-x1EAc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 16:13:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Lucas Zamboni Orioli via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ben Knoble <ben.knoble@gmail.com>,  Pablo Sabater
 <pabloosabaterr@gmail.com>,  Lucas Zamboni Orioli <lucaszam0@gmail.com>
Subject: Re: [PATCH v5 0/2] mv: report missing destination leading directory
In-Reply-To: <pull.2356.v5.git.git.1785410884.gitgitgadget@gmail.com> (Lucas
	Zamboni Orioli via GitGitGadget's message of "Thu, 30 Jul 2026
	11:28:02 +0000")
References: <pull.2356.v4.git.git.1785097071.gitgitgadget@gmail.com>
	<pull.2356.v5.git.git.1785410884.gitgitgadget@gmail.com>
Date: Thu, 30 Jul 2026 13:13:40 -0700
Message-ID: <xmqqtspgjkwb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lucas Zamboni Orioli via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Changes in v5:
>
>  * extracted the shared "will this move rename on disk?" condition into a
>    needs_worktree_rename() helper used by both the new leading-directory
>    check and the actual rename(), so the two cannot drift, per Junio C
>    Hamano
>  * allocate the dirname copy only when the destination has a slash
>  * reworded the opening of the commit message for clarity, per Junio C
>    Hamano
>  * added tests: moving into an existing directory (destination is normalized
>    to a full path), and moving to a bare filename in the cwd (no leading
>    directory to check)

The changes relative to v4 look as expected.  Looking good.

Thanks.


