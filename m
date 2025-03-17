Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE582EACD
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231952; cv=none; b=Z+U2I4kltD7RYY9+cOrEEfYNQYHVUzV5A7Sa6/+vCdKWFsDR97GOY/LMWY26nc5px5zeTPcufB+2nE8cPFFJxN4uSOeNQoD55lH52wN7cZVOE49s8tBbw2LUb+lu631G6v8CTIycqEBHu9MgD0oWQjL8z294R+BGncKWMmsYfrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231952; c=relaxed/simple;
	bh=bKyAwuWx1It45a3vaJJ9w8zOSjsSn3YRZ1oazXaLzns=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X/9RDesvaFsfARsXEoL4xNbopRnJJs4gELR2lYFua9wBmC9XqM++jUCp+g8Ic6hyjoevgi6AteOCkDGWLqm0qC3HBoTxyvVx55is3Km82f0lZNd8Se44RA5Zg7gUeq2/BZHZcD+yy9pgH8/M5h901ipxeLRZiEowGNf34XeJ+9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KtWFcsW2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d+vovFaF; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KtWFcsW2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d+vovFaF"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id CF79311401F3;
	Mon, 17 Mar 2025 13:19:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 17 Mar 2025 13:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742231949; x=1742318349; bh=9Sp4BphbyY
	BdfF/SQQnni+Voy8FWi2PpEKIEPLEf0uo=; b=KtWFcsW2qZdN9aCbSMEuLcFMg5
	ZBlEpIbVXjso/JiqROQci7V69/LuFelWPz0hN2LdFUv+6oW6Hwq6h9Ibwnjvzoau
	XI6JYPd4ohRwXToV8SJsiEDgZ7c+AXVKXuBiXS55q8IfPExDL+Xo3EuUeXIW1My+
	xW8u4KOLUZBKQUa/rI4azY3nto6Y3fl+pbbvjvwp2WzXC8ig0/Trjzs3TEuIVEOW
	1u+1Am9XrPsMCwG1I5h0n/p3gsKPE/vxXtpWlP/Hk9rtA/qUQRdaqCiDfkfdiZwi
	vXDaY86mfbQECRs2mvOpcmYufPh6QYGbvlxFATPsx0slAn16GsF7Hb5h/iPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742231949; x=1742318349; bh=9Sp4BphbyYBdfF/SQQnni+Voy8FWi2PpEKI
	EPLEf0uo=; b=d+vovFaFo704HDLnM/Uqq2cKSv+0L1aRkCfWxLjKUgSEYTh8164
	O2IB52de99U1X97vEWRH6P25OabTH313WuJNsgeeCg797vTH/E4/V6uOiZZzbVxH
	mw5+bFfth873IjjCnn+myZ7vcBOYARvZzdil3qnUIsARtgP+mQU2Zv1PF23C26W/
	iyesikzJtnD1JJlpAE/l5zhFkIMncdSZWWLNoqg5kFBnBDTSDGXgdq3B0drGqOQf
	hOs5GKimm+g8ds01uSbKhPZd3euHKYrhL2Vf//MZM+7ohtkXH9aikymsfYBIx2B3
	viCcQDBwPaGXouEPlgXeHiY4oEfyT1sDaVg==
X-ME-Sender: <xms:jVnYZ5h5bdtgMT-_ktuA5MU7_VJK9-B6BoMrKuOCD-Ms10x98zBN9g>
    <xme:jVnYZ-Bx8fgJRI9KGqB9Kxj4b9suK4ufuzNtq3KM8DRDXjxrTcXiNjvmTGpLYxbFq
    lJtiSrGQQJFrQJ8xA>
X-ME-Received: <xmr:jVnYZ5EU_RzDcCwHfSyK0ndmLE4Ao7qoBahnFDCBWAFGwlHt5uhRSxCeikKTFUZDxEJwYjapVRcSQ8nNBRSMn8wkZUH6bvXLZjxTHUo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiugesmh
    grnhguvghlsggvrhhgrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jVnYZ-Rzy7AFqDAIY3Do33byxiPO1dWj1QiSobA7E-wMpKYWIGfoig>
    <xmx:jVnYZ2z0Mtv5bVhhFvAWUU_nkpty5Pe3JU70Zl4hpL5pb_aOr9USzw>
    <xmx:jVnYZ062wZh-KVVXVc-zcWRI6Mvw7cVB05KgvAt2IrrdCFUeSq8SJg>
    <xmx:jVnYZ7xEyjp3msXFtEHoAjBQ1GSRLrE-uIsKzIkFJ0ZmamTjKzlomg>
    <xmx:jVnYZ69XIbKIgU5hzOpQTNs_TFIiaGzFuJ8N45odn8uSFE561SO5z4gE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 13:19:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: David Mandelberg <david@mandelberg.org>
Cc: git@vger.kernel.org
Subject: Re: git switch --force vs --discard-changes: docs don't match behavior
In-Reply-To: <bce5a500-76c4-4462-8f99-b17a6f21f7ec@mandelberg.org> (David
	Mandelberg's message of "Mon, 17 Mar 2025 12:50:12 -0400")
References: <bce5a500-76c4-4462-8f99-b17a6f21f7ec@mandelberg.org>
Date: Mon, 17 Mar 2025 10:19:07 -0700
Message-ID: <xmqqo6xza838.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Mandelberg <david@mandelberg.org> writes:

> $ touch Makefile

You'd need to explain this example a bit better.  The reproduction
must be done in a repository where the master branch has Makefile
tracked, you are not on the master branch, and the commit you have
checked out does not have Makefile tracked.  IOW, this is not making
Makefile stat-dirty, but is creating a new untracked file.

As I wasted a few minutes scratching my head before figuring out the
above, I'm leaving a note for others.

> $ git switch master
> error: The following untracked working tree files would be overwritten
> by checkout:
>         Makefile
> Please move or remove them before you switch branches.
> Aborting

Makes sense (note.  I do not use "git switch" myself).

> $ git switch --discard-changes master
> error: Untracked working tree file 'Makefile' would be overwritten by merge.

I would guess that this "discard changes" takes the word "change" in
a reasonbly strict sense (note.  I do not use "git switch" myself,
"git checkout" does not have this option, and I do not recall
thinking about how "--discard-changes" should operate when the
feature was added, so this is pretty much my first time to think
about this issue).  Untracked "Makefile", by definition, is not
known by Git, so it cannot even tell if it was changed or not.

If "Makefile" is tracked in the current commit, this would have
discarded changes from that modified file and allowed you to switch
to the master branch.

> $ git switch --force master
> branch 'master' set up to track 'origin/master'.
> Switched to a new branch 'master'

And forcing would give us the same behaviour as "checkout -f".

> Is this a bug in the code or documentation?

I do not have a strong opinion either way.  It may appear to some
users that giving a finer grained control is a merit.  Even when you
are willing to throw away changes to already tracked content,
getting stopped when you may lose a totally untracked thing might be
nicer.

On the other hand, I suspect to many others this finer grained
control does not give much value while adding more confusion.

I am obviously biased because I am accustomed not to have this
distinction and accept "checkout -f" as a reasonable way to force
switching to another branch discarding any and all local
modifications including untracked new files that get in the way,
though.  But I do not feel strongly enough to say that the behaviour
and the feature itself is misguided and we should rip it out.  As
long as that "finer grained control" is working in a consistent and
explainable way, I'd actually vote for fixing the documentation to
explain how "--discard-changes" is a bit milder than "--force'.

Thanks.
