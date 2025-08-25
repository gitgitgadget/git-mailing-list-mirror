Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839AD301029
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756139892; cv=none; b=sAvlUn7e+jeAPHgMILD4xFRpCxzo7GXOZUVFJY09pJUfV8O5AALi6v/ioCTd8liGYH87hwhGmeesgFAulbqv4o9C2jCs9jMurPI9eXq4yqtQU4J3aAPyxewELqcRisu6MLiJ30SLwRx7vWTeroKkjRPHI3aAKgNK50khSQBrLZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756139892; c=relaxed/simple;
	bh=0lNM2Iwo7Dhb4inJbTkfB51zC23jIfUcU7+Ph1Gx4XM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BezSEIHiuAJ0p3WrAclm1AnX29y+v67R/TX75LvLjU+Jmzy0jDBzIphzJNZkLBcC91UI4t2EoNwDGDFoRGjtdjF83aK1jZnF9QJA4L/JPppxwXjZbGe+BpkvimfywOQSidkW1XhjJyU7Qhi5dFU7s55kQOHI/i+sdu842X5Agz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=crtS7WHp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bCw7D9By; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="crtS7WHp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bCw7D9By"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 65A5D1D000B1;
	Mon, 25 Aug 2025 12:38:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 25 Aug 2025 12:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1756139889; x=1756226289; bh=KJS5uNIFz8
	kuU6SQZxneQDStgrRgx6e7PyHzMaKbQzI=; b=crtS7WHpxswTNwmI80MBTEmd35
	emSTs06CmSncR+6Zj7HyBAW1wPktZ40zPD4hMrBOwjDn6q4VoZdf5Oad0sglBn3u
	SE37f37aR5gMKXqK4Os7tSjhfE/ZxexrY2I7Tp2oENLX+N+gcms0H6jvDApvbzSC
	laxClckE5YNTjJn6yeszQChqe1amvmFT6lWrnXS4QfpXct3ZIm6YWX365VUmJ+2d
	iugnqyy56vjpJIGQK2ef2N3ekp6ksDt0x8X7SidmMnLMlr/W/W/PCbLVD+C3CTcU
	NnF0gLj7099dp86dcUoRCR+8xS/giEAK46wXvIPwTIFLLzQ4GIqnqElWWHug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756139889; x=1756226289; bh=KJS5uNIFz8kuU6SQZxneQDStgrRgx6e7PyH
	zMaKbQzI=; b=bCw7D9By7Om+j6hEk4tZbdlK97dyYboK0mnqoVqjlB77ib941DH
	0L/obDDM0R9wo3fHnFS3qsAFy6+84R5W3JfRCm/r1ltP4sBWomJ0UTAQbLf0Sf6H
	CD0JbZtiURxyLc7U2mZcMvi76AGEpsdz+GH42OKMPfcNIZP5/KuXPi9oR5qDEVlB
	miCbSSRoVGMPEDOVNs9K8KvYT6/ZTkJzJtiPUmxinUXdD2gk5UMvtvuZIbRS1r+v
	uZLkQwFnZ+k+x20QYVpeVl5SuLxpbSmMRbqKFGeyfDiFsUu3lHu+ENNoGrSMFlrj
	DYiip1OvFP3//I0h347/xxF8vo2Yl0kzIoA==
X-ME-Sender: <xms:cZGsaJvPpcrqfQje7Sz-UqpHRCPZuZ3-e77VQ-BaRes_dZ3G3qTCbQ>
    <xme:cZGsaPZkj6ETMpUP7uJrxmCw5FzqiYPQW4s4CKZIDsUyj8v1ro0ZqzuZgcjkEaN3n
    RcHp6Z-HbZ8GAaljw>
X-ME-Received: <xmr:cZGsaIYedHr1Q-IHijd-gJMzXPxUKwu-n_QcLLiJFZKe-86S7EMcoJJrvUqCeZuY7O39VkBX3posHp_1iM-6VJWomi0rNWNwEytEcQs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedvkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepmhgrrhht
    ihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhh
    gruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:cZGsaInxo_ZlGsfd7U-9w9zkAdGUKnfUc43FVoejoAlvifaZ5e4NKQ>
    <xmx:cZGsaD3r0qdJiq-i1q8UZCRqbnAKUc0unF9d3bjlHook8NwTNca0aw>
    <xmx:cZGsaI1HJjkAnZk-NCxvk-joHvTgRnb2NQnmV2jET7qLSaabL7ROMQ>
    <xmx:cZGsaFoFRSgmjA6AZvMsMhbhBu4mIh0pUW6uEwQGw9k5t64shhJ86g>
    <xmx:cZGsaFOQqrlBF4773DEC5rN2buL3vMhIujwa52K9EWmRGHmuiuOeLgzL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 12:38:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Sergey
 Organov <sorganov@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <jn.avila@free.fr>,  Martin
 von Zweigbergk <martinvonz@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH RFC v2 05/16] cache-tree: allow writing in-memory index
 as tree
In-Reply-To: <20250824-b4-pks-history-builtin-v2-5-964ac12f65bd@pks.im>
	(Patrick Steinhardt's message of "Sun, 24 Aug 2025 19:42:18 +0200")
References: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
	<20250824-b4-pks-history-builtin-v2-5-964ac12f65bd@pks.im>
Date: Mon, 25 Aug 2025 09:38:07 -0700
Message-ID: <xmqqjz2rs6fk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The function `write_in_core_index_as_tree()` takes a repository and
> writes its index into a tree object. What this function cannot do though
> is to take an _arbitrary_ in-memory index.
>
> Introduce a new `struct index_state` parameter so that the caller can
> pass a different index than the one belonging to the repository. This
> will be used in a subsequent commit.

Nice.  

I wonder if this would also allow us to simplify the code paths for
"git commit -o <pathspec>", where we use a separate temporary index
that gets populated afresh from HEAD, grab the new snapshot for the
paths that match the pathspec, and write it out as a tree to be
wrapped in the new commit (and then the real index is also updated
at these same paths).

I guess the code paths need to expose what is in the temporary index
to hooks, which means the index file needs to be written out to an
actual on-disk file, so the picture would be a bit different?


