Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADE51E04A9
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 18:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739297225; cv=none; b=TGEdQ6yC9IYnCZkhNAS4yPcBDkXa3Nwh3nIaP4mh7Hsbf0KOQ3ihbfLXWS49fVa+wCqEBykVFwpCCEx6A0eS/hobzUvc+W7GLgmjr3VjNWn7GFKGSWBmx3swa5A5ot4nIYNzgnd5UyzI0uHpWv0MMnmeswqDxnrEUnEwXD5Y6kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739297225; c=relaxed/simple;
	bh=2iHdHQUVINwW+V/AkiI0npIxnfhpaScEjq5W5lEGhb4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JggUTYUulZRoWExayqpaYmgdPM/1WGvV1qq1LzXT4pPuz+aH3Kua9hOYaI8MOnGwaqBCp6nU+jURpmOifwWECIJx2hKb3BWZLpzy6p3og0HB5FlZ/0tVXvVWtUndFbZf0Oj3WAulUw1gBwtUlNzTq4BxJco1nWs0BykUNru/uNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q33tZSE9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e+6gt9ee; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q33tZSE9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e+6gt9ee"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 56AF71380A20;
	Tue, 11 Feb 2025 13:07:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 11 Feb 2025 13:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739297222; x=1739383622; bh=kHPCc+kDuS
	F7868fJmS6aP7JHPys1GuqGbwsO0u1wYY=; b=Q33tZSE98EYremUT+fQJIicI2N
	QTR20d4QAvWcYoK85ZY5e7n9UyQUcbpu2alNr+kXeIaL7Qy17gBlOdBAQ9kq5QMl
	2x4kxbSQkD4ILje4lH6LL2Kn/J57tSXfrQckytR8jEzenZ3F+itEpoTwu8gSP1vf
	ko9pXT5z/ovIIhRQApEQ8jWjXdJM6SDFh0hLE+1CCadV9ET083ph2nkf2+WYMbBB
	k/tCxpZTALJ7JY6sVzXpG8Au9Vw7nLs0V9EZeO/xwIXHMaoc512lALOQNvmJjt0i
	ynU9OmNCodJa70Mt1kG2wR3do9mvfC9EnpGMuqMJYpibGjExx/g5kQFainKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739297222; x=1739383622; bh=kHPCc+kDuSF7868fJmS6aP7JHPys1GuqGbw
	sO0u1wYY=; b=e+6gt9ee60ZqN5v4vLE0quK57KNhbk5pMzv9jA/vxrDVG5V7U7r
	N1BVI5SLG7tJnGWlGuYkXHae82X43VmmUtDDfAkjNvWBJ6xEcNdnabXiD8ZhKjfj
	bxHFwgyIKLxDfCRvofWBwVjl2yrozoyY1ny55gyFlG5W39pabE2eiZBV8L8jyMWV
	insjV7fzt56jJ5dn9dl7gjpAEKbLrhmhx3A1xEmUIhXLm1IRa6QqXFKClc/fA0nT
	EHpoG33ZKz7jqVdUWqj4cbuu72Y7RIFxOs8UPKWHR/VwqyJeZTUmEW4yZsjhN8LH
	jbzn1fT0paNA/sNS60p/NXHGGLb9JZtH9Ng==
X-ME-Sender: <xms:xpGrZ4dxhMx_S4UY0cOmZY0jBhj_FqWhKAuuZhGR3iNoWhcemy-m_g>
    <xme:xpGrZ6O8zRRNbriU5IBxQnk0v7GUlH0jx80XPbtZY-toSXvVlu3WKFY8VgnM_YQJh
    clRS4KsIinKwHe5EQ>
X-ME-Received: <xmr:xpGrZ5gbuOo-lIzPlJPPKh1f1CrdaJLsWjZgWEbN66nOIAaZrV5PWl6xXH2Dp3Mqyws9F2DTUtDTUS5QYIpxswdWuU_pvuIP0AilmlE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegudeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpefgteejgeduveeuteeiudfhhfeguddtjefh
    jedvffelteelhfdtveejueehudffueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepihhllhhirgdrsghosgihrhesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:xpGrZ9-7Md5t-p-QIEtoVzDP5yzA1Xbpa6JN3ML_IgSJqWwN3dzRWw>
    <xmx:xpGrZ0sczxmtFIJxMFweBAX0bVZm-c2l8YiC_OaGGv3M6Hhleg54pw>
    <xmx:xpGrZ0EKpbB2IG6F_L7lpgzlOdSOl6YfcHzotoVCLYt0NvoPBeuNaw>
    <xmx:xpGrZzNVBcIc-uEf4MHmErrljHWzp-9eCwnX-9Dj7VNERqiAChoe5Q>
    <xmx:xpGrZwIXsgawwctJ2ITlnAYTQskWoG7DZYGFwA7hw18wAH9HpnkjnvVc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Feb 2025 13:07:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Illia Bobyr <illia.bobyr@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 0/10] Long names for `git log -S` and `git log -G`
In-Reply-To: <20250211085028.3923875-1-illia.bobyr@gmail.com> (Illia Bobyr's
	message of "Tue, 11 Feb 2025 00:50:12 -0800")
References: <20250206014324.1839232-1-illia.bobyr@gmail.com>
	<20250211085028.3923875-1-illia.bobyr@gmail.com>
Date: Tue, 11 Feb 2025 10:07:00 -0800
Message-ID: <xmqqwmdwxsmz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Illia Bobyr <illia.bobyr@gmail.com> writes:

> I've split the big change from v3 [1] into multiple, mostly independent patches
> to make it easier to review and merge each one separately.
>
> [1] https://lore.kernel.org/git/20250206014324.1839232-1-illia.bobyr@gmail.com/
>
> Patches 1 through 4 are fixing minor bugs and inconsistencies.
>
> Patch 5 contains updates gitdiffcore to use same placeholder names as the rest
> of the code.
>
> Patch 6 contains a minimum change to add long versions of -S and -G.
>
> Patch 7 adds bash completion support.
>
> Patches 8 through 10 increase usage of the long argument versions in tests, CLI
> help and docs respectively.
>
> Please, let me know if you prefer it split in a different way, or reorder the
> changes.

When you base your patch on a different base than 'master' (or if
the previous iteration of the topic has already been queued in my
tree, then the commit used as the base to queue the topic), please
make sure you state it clearly.  

This iteration seems to apply on none of bc204b74 (The seventh
batch, 2025-02-03), on top of which the previous round dcc02caba2
(ib/diff-S-G-with-longhand) has been queued, or any of the recent
tips of 'master', like 388218fa (The ninth batch, 2025-02-10) or
9520f7d9 (The eighth batch, 2025-02-06), so I cannot look at it.

> I was not sure if I should include a reference to the previous version of the
> patch into the next reroll.  It seems that
> `Documentation/MyFirstContribution.adoc` suggests so.  But it creates very long
> threads.  And I've noticed that not everyone is doing it.

Almost everybody does so, actually.

Taking a topic that has 5 iterations, each about ~20 patches, as an
example:

https://lore.kernel.org/git/20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im/

it is perfectly clear and easy to nagivate from the list of messages
what discussions we had in previous iterations.

> Reply to review notes ...

It is more customary to Reply-all directly to review messages,
instead of sending new round of patches.  When the cover letter of a
new iteration is sent as a response to the cover letter of the
previous iteration, readers can find the previous discussion
messages.

Thanks.
