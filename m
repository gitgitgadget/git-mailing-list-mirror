Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E45A31
	for <git@vger.kernel.org>; Sun, 10 Aug 2025 00:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754784973; cv=none; b=kfH64acAjgbrlcnV8ca7OmR53cH/D7jEBmUvJATv6bP7Sn3R+Jl57tH3/mnFzfHSKDbBkNPfRM1B1vb/bWm2OaLKTm0hJrlvgVNllMZ4gpl2wUE9Jkj/lVCX59t71f/YlXdqvDTIAVMFl/IeSQ8GT8r3GYBNCj2VsBlkfXyMurE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754784973; c=relaxed/simple;
	bh=Q2HPTfMJK4NTJhiPB7P2fapGJmfdhOFcpy7axLL5MaY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sa3PDrsan+uba8gT2fbreuyWJzYfvdnt4ASaqr3T9bsU2KgxeS7uMeNjKvK5TfkfaKg9Cowk535WLbQc+dNMtFdJC+sj8HDnDA9CI5GRkxbg8MItvdSeQRTBbQnBhY+pF8AMRYv3mPnSm7p23yuU7B92RjcLwXZn3bUTEzUms6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hrBotmQ/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a4zbQEy8; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hrBotmQ/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a4zbQEy8"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id CA219EC027B;
	Sat,  9 Aug 2025 20:16:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sat, 09 Aug 2025 20:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754784970; x=1754871370; bh=fikrRQhk8n
	F4CDfgQjQNYaOMXK49bAJwy+sA9xQKKR0=; b=hrBotmQ/85ogDs2BT1OK/nApD5
	QYL00cinFs4dN54Cb+8d3bZdO9eX5/kkdv7BOv6+CXONfCsYxr2Kf7RAwiANt8yq
	Oxi06N60ecyjXu9DDF6U6k8/XGtyotmBBLjco/26LGoG0FUPVROW/lezAgFtADbA
	0NOk7UAkMX2U5Q8qH75s0axFyEh4evmztb4yghGfeHtr6CcLdsLDTReu2gSd5XjM
	JzRIS+YtONJ5FZA5UI5KrYwdJoXlePSisyvCtslXhVo0DxtsRLJkBwbcxXwJTM9L
	4EdKob6p7jsTtCE4e0y1ZodFUasPr89uDxvE0EXvP1XY/ls+WmJ2DGUZwOQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754784970; x=1754871370; bh=fikrRQhk8nF4CDfgQjQNYaOMXK49bAJwy+s
	A9xQKKR0=; b=a4zbQEy8laHAoLtS68gSD+wMOt9cpzA5v2efoUVCyhqO6qJVTfK
	gqYz3VsPdwzbocMB7xGbYDW09FuS+EWlVc90fEJZq4drCxvg2dFA8ID+7fwCgfuC
	7boPqh7jxnTeuI2ToAAM9+uPoYDaGF4m6zA1Da2r6AINKbKaQ5uxYUeVNG1/ZLhX
	3hgk3PBdK2NBTiZaXVucTCqnQtPm5a4+2p8oxLaORUPh+faxArRIbZkR9po/UPj9
	IqK47J8uxYgo13JiQBJhfOPBTAbN9gEXpHFxw4bIg1TUs+nQ2EufarpO3utZN4E3
	yIgRezrhKAdvHcdg/aMfmExHIdSgVrf0RLg==
X-ME-Sender: <xms:yuSXaBY9g0xE5DkXOGZbc9fj8OI0vOWWmjjmpWYueQ-FvgaQxxw3TQ>
    <xme:yuSXaPRBbEvMelAUPq-DY5dg5pxmTPzg3xRBHh2jAalg3kHPlPqboeq56YFipkjKQ
    IUubRIkZGTsPDFV7A>
X-ME-Received: <xmr:yuSXaA7O2s9UcI4tyNOULUmVOC9W9qnZbYHFxzYKD95-YhyTs4yBYguQJN-mAwvm0bjU58a7PUEY44QtaXuJRGzmiV-vqVX4R5wkU-M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdekuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepveegudetudffjeekledvieekvddvheekueeuhedttdejveefkeektefhgfeh
    ueetnecuffhomhgrihhnpeguihhffhdrtgifnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgs
    pghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrg
    ihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:yuSXaMxZBZzdKUHu5QRIi8gm2O87o8onjrGigTaY_XGY4KRuTLq5WQ>
    <xmx:yuSXaHREM1DrDSzrqUwvf2U0Z_L46FRrjMq2c0fcqEhjFKhzotNOsA>
    <xmx:yuSXaDVrLlZWvlFmw9_RCAG9hoeNcLoEJ8FYQl8DnH_kU-iUqxFDsg>
    <xmx:yuSXaJZREQrdazNYd7gFg1cB0tDoju5ZzgTkcFFMtsLsjW2IWFUqnQ>
    <xmx:yuSXaHPgvSDz3XB_VkVKlBBVF5f_8e-ZtObzZHPkrC6uR21fjNLnvtFN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Aug 2025 20:16:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>
Subject: Re: 'seen' branch fails to build
In-Reply-To: <92c8c9eb-91de-48c6-88ac-7d5583cc766a@ramsayjones.plus.com>
	(Ramsay Jones's message of "Sat, 9 Aug 2025 14:34:29 +0100")
References: <92c8c9eb-91de-48c6-88ac-7d5583cc766a@ramsayjones.plus.com>
Date: Sat, 09 Aug 2025 17:16:09 -0700
Message-ID: <xmqq5xew58vq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> See commit 456a265746 ("diff: --no-index should ignore the worktree",
> 2025-08-07) in the 'jc/diff-no-index-in-subdir' branch.
>
> In order to get it to build, I just did:
> ...

Thanks for noticing and reporting.  I'd save the translators by
reusing the message used already elsewhere.


 builtin/diff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git c/builtin/diff.c w/builtin/diff.c
index 3eb4cbb057..0b23c41456 100644
--- c/builtin/diff.c
+++ w/builtin/diff.c
@@ -497,7 +497,8 @@ int cmd_diff(int argc,
 	 * prefix.
 	 */
 	if (no_index && prefix) {
-		chdir(prefix);
+		if (chdir(prefix))
+			die(_("cannot come back to cwd"));
 		prefix = NULL;
 	}
 
