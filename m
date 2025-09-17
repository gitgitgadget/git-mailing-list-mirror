Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A34132BBE0
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 12:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111177; cv=none; b=dTTUbQHRh5oTfLrKhhN/SlT97vWL45hrJdsP8NtnXO8cFoh1nKTOupna1AvG+B4kElCADUocu+CRgp/g1dvFCtvdBmVqOT4T+xqQRPg3xMTYhbfyhNVEihqp52B4xX5vKNmGOLvfSxv/SSBsaSiLg4t3FH2OLmOp3d26RuXkg60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111177; c=relaxed/simple;
	bh=bYyT/GscwWeWlw3zgOok431Oh7cw6fqepK4FRRZUQSU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gLtcZAYtxwNnzJn+b6s0QbeFVboADtNNeDEKMrc2NaM7ib/SNuWnn253whRqR/iMnViUUj4kHUGTJHzoFmtf7iGC09MExwdBprxz4GK4E2xrtywE9lCvs1Sts/gNQEdYok8ZoiTmddpRNS3wlhRJq55lTe12TfCPwjoGHAor2QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cMAcMt4y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A2GS5Fx1; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cMAcMt4y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A2GS5Fx1"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A7022EC022C;
	Wed, 17 Sep 2025 08:12:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 17 Sep 2025 08:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758111174; x=1758197574; bh=G1hjj6xNK0
	oMbTIgMMHBEOv71+dlmBmTbhEVp1ywHpQ=; b=cMAcMt4yR8n7qZw7728O1ARtAs
	VdI3cqka0xonlEt1gADG9Yo48TSVFKFz8Z8ppb6/MSbzhQZ2SXZXUhO6me1xx76p
	gSsZ0NN/NtRdfKtYDx+pLKL8f88f6MUYUROlU4DZS+aiwbni3wVdcyTfxNJpFDp/
	yPLjUARou6lQm5frHPh8HXI9WdLeW8xAiBoVt558e+MsQtrfszgCD8dgZM1Aoi2c
	JBbJR2K/DE3SyN/KY6MjcCuGwQpOBxmCYbIPEm/g6LKHv4qCJdP5Rj0gCyzYXcH8
	YzYlnsCJrncpvmgABoBRR6Ofhaj+p1fW95C/DqNjbbXpN5GOXoQI7yVlnwfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758111174; x=1758197574; bh=G1hjj6xNK0oMbTIgMMHBEOv71+dlmBmTbhE
	Vp1ywHpQ=; b=A2GS5Fx1KZ3squxVf9o/MdURyAh3rYhZprAygXf9v9fTxSqK0rH
	zNyBS9iGUgNOcYcMkcOZFKQ1afQjwm4kSwgIPXcfsQ0wdTTeGnfYoVIiC5PDuhVK
	+kzszhE3JW9PTS7UMdhEOna6jkwGoSDw4z0hVMOmkd++K8A7N4cG/eIfQ+Fo/OvD
	JCcu+ppCY+sWc2lHnmapz56RjqC5aBy4F7wZFpX7NMQh/gHtLtHyQIFTC69737MT
	o5ViRZOglAyPXKvidJ0iXH2h5nqoaJv06js+/+AJoI5FaTy4KkdS8y2JRiSkaQ/X
	bEZCTzuh+WOixrdUdR0ckiQd0fOR0o1w3cg==
X-ME-Sender: <xms:xqXKaPfyxnqWL2eiifviT7vR_R4JK2ldvgYBhX6eSdOvxB7oMOsByw>
    <xme:xqXKaPxqnaB58Aks06pMAkyYt7PzzVdVWrlAAYH3zpsXeEw4UM8kjGORVF54TUM-N
    szxflNIXM3KhnLGAw>
X-ME-Received: <xmr:xqXKaFEDldKwuNs5NG0URAUX5GIs11vneK81gehmegcKVOo_rM_AS-oKlZwpcHX8WsaJVVGZYiasDCCkhuO4IDxVtkRhyOGpvHWFloo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegfeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehmrghilhesrghnshgvlhhmshgthhhuvghlvghrrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xqXKaDxlWoSeF2u9o1ZWxvijLrablxZ9F2aI2txoJ5gIKTt0P4pNVw>
    <xmx:xqXKaGtQVzsHFv6_2JxdOKxfk0StWN50tPQuiNm1YBeQz3ftZ1NdbQ>
    <xmx:xqXKaA1z_CpYo3V9BwCBdnhsejg_PWMdhNf-LDe8Gm1ZxZ_zafHzwg>
    <xmx:xqXKaB-RA475gfssr2MAuNjTwBV3HnqvyS99puS7UDsRLz7iWOFjlg>
    <xmx:xqXKaPNQbcmCKIUJtyzr5Fxi9Tn_TgS5ToOtp04qlWTcbhw7T745bFgc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 08:12:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Anselm =?utf-8?Q?Sch=C3=BCler?= <mail@anselmschueler.com>,
  git@vger.kernel.org
Subject: Re: Why does git-status suggest different commands to unstage files
 depending on whether there is a commit yet or not?
In-Reply-To: <CALnO6CCz6dFX1Est0hhCbvaepBvG4+rpYQRQ2bP5vAQVmaY=OA@mail.gmail.com>
	(D. Ben Knoble's message of "Tue, 16 Sep 2025 16:52:17 -0400")
References: <5036f7d8-8ac9-4f50-99af-5a3a2d1a07fc@anselmschueler.com>
	<CALnO6CCz6dFX1Est0hhCbvaepBvG4+rpYQRQ2bP5vAQVmaY=OA@mail.gmail.com>
Date: Wed, 17 Sep 2025 05:12:52 -0700
Message-ID: <xmqqqzw5i8fv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> ... " the following
> does work in a non-unborn repo to move "newfile" from "untracked" to
> "staged" and back again:
>
>     echo >newfile && git add newfile
>     git restore --staged newfile
>
> So we don't need "rm --cached" to
>
>> remove <file>
>> from there [the index] without losing or clobbering the <file> in the working
>> tree

Now I think about it more, I wonder if "restore --staged" is
misleading and confusing to new users?

When you teach "git restore" what would you tell them?

NAME
       git-restore - Restore working tree files

is how "git restore --help" starts.  It is primarily a tool to let
you repair messed up files in your working tree by copying out of a
known good version from somewhere, be it from the index or from an
existing commit.

But the instruction used to recover from unwanted "git add" to
update the index with modified contents does NOT want to destroy
your files in the working tree.  You want to repair only the index
without touching your working tree files, because you added modified
contents that were not ready to be "staged".  Hence "git restore" is
used with "--staged" option to tell it to do what it was *not*
primarily designed to do, i.e. only touch the index without doing
its usual "Restore working tree files" job.

But there is a lot more appropriate command whose primary focus is
about the index.  "git reset <file>" would grab the contents for the
<file> in HEAD and replace the index entry for <file> with it, which
is exactly how you would move the "Changes to be committed" files to
"Changes not staged for commit" status.

So I think use of "git restore --staged" in the instruction is
wrong, and it should be replaced with "git reset" instead.

> (But the point about having nowhere to restore from stands!)

Yes, and the point about having nowhere to reset from stands for the
state on an unborn branch.  That one needs "rm --cached".

