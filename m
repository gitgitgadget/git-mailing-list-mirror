Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0C028DA1
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 22:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738104527; cv=none; b=ejYACi9yQgzLBjKJi0Ol0diguyjxvB9yrxs5WXsyVnBvntNxGR9UtSULooIYmeZNVFzYDPqeFVZDfukz2Smb6QncXfA+WwfAFtACaj+KCtZeFXyqO1e0wAJ4/O8bwF15of+0A+BZ9tP+ZMF1/pvfHeOhtaX0qHwCAoYWixAp3NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738104527; c=relaxed/simple;
	bh=DcxAmsVO0QbWyAqeTKzI0iig/sNXhnFci7nVVvSP2xI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h5Ef9ASlRtfhd57o4MuEgdGF3lzPjmOfNoq4l3W7kjjzCNnzM+JMJovusQWJ3CFrncufHbvMt5U1hd0veg9dycndGHZOe41gpAIBdlWVJFSi1RESag8WH0yc44JNpZhiNGdj2QLv5BDNsztXnxhdNslHKJRBr8ROUGwlo640ZOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HbDWz/TP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AcK0CC1X; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HbDWz/TP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AcK0CC1X"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 659411380AC1;
	Tue, 28 Jan 2025 17:48:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 28 Jan 2025 17:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738104524; x=1738190924; bh=6tHIe6PBSh
	2zSs9LbPnCo77qIKQGDLuxVL6RzlmEYfo=; b=HbDWz/TPVJ1+sZEZ2iE/AawGtS
	GqojCl+/Ft2z8QHHPeCKGF/0xtrlQfr6zxpayAfbcQXvzNVUt5KOPk2ZrWRP68Em
	tdX4qLeprExQmP6cjwQreC8yuSZSy4lD6+GzOXpWhBC/8Jx7it8vVx8UUE88DtzG
	vQ6qW/PwrI03uhiwK7aWLU+q53s95mc89S6r58Nesidc2wHOnZjpy3KBCvAXFbVP
	5FevmKdhaF+5r95uK+/THbJgGx+3vIprfUu/8aD9RHXHkt31iH62ijrA4wwgnLqk
	1+Oee4mFm9i7GKLz/jlFb7iQlKTBl7jUF3atiPvccm6b5WCzgsXfvS+DX8ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738104524; x=1738190924; bh=6tHIe6PBSh2zSs9LbPnCo77qIKQGDLuxVL6
	RzlmEYfo=; b=AcK0CC1XNpwDlvqCE+RykV7Gpr4J/MhiF8Wa9PUaZmAfdyG7p/N
	qjJZT8VFsH3r9KgJ7p06lAZ+SCoTyFaThahaz7a+nXatldLo2kpsyWC/oGARTzGC
	WJp2kBY2+4xRrrj6JK2s/aafjcVv2L+OQZxe6S+r3xkTyPdgnZ5lLxR/OGfJ3xHH
	hic1Yyg+ZxK+jtaIP7H4y4yurrMhAuXVpvAcuWgNUA1NwE70ftLFTy02OfWzodQt
	HOJs0lLxk2I7PQEBhXnHhevFRVi6I5FNb2pmKxmhNXf4quECGIjrwgIW/H4IooP+
	wf6Te3CKdCup3B7nnwpyDw9/JdmjmqueARA==
X-ME-Sender: <xms:zF6ZZ4r2hEBPrwAmiF2u6O5BYS3WP416p4Cp2DvGufZklIfbOqxLdg>
    <xme:zF6ZZ-oQSykTfnFhpDg-oLWqqX3tFSUUadEyiBYMsc6ARG1mk3gSfUptif59bDv0H
    HTRLfDrRGi63Ge-dg>
X-ME-Received: <xmr:zF6ZZ9PHQIEvk2sQh_Uv9l7MFrtvNC0EBg88tQhOPegfFpgntkcflqPFBnuDI6E2A5i2o3gbvtxLLpX_lbMwayAMrFbtb1mrwnyZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    vghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepjh
    hlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:zF6ZZ_4ShLGG7BlkWtD_d4C9SoK1o54IWv2NOkAJ-y7TH1KKRuLiog>
    <xmx:zF6ZZ34OuEBL-IqfZ6HgEuUfxph4Egmn123OiMDcaDZNooTxnydQGQ>
    <xmx:zF6ZZ_j7cQzIwEQEoeSEKIVbUpm6-yJGlxEfgzLVWSnK-dskbyYngA>
    <xmx:zF6ZZx6qJoBYBa2Py-FKQEhl98pTre578jatakT_8miT2trnlv2Mow>
    <xmx:zF6ZZ9Rz3fp1RgT59-OVao28aUkgUq9t2X2chyRkVBWEX68iWYCdb94F>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 17:48:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Edward Thomson <ethomson@edwardthomson.com>,
  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 00/20] reftable: stop using "git-compat-util.h"
In-Reply-To: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
	(Patrick Steinhardt's message of "Tue, 28 Jan 2025 09:28:01 +0100")
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
	<20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
Date: Tue, 28 Jan 2025 14:48:42 -0800
Message-ID: <xmqq5xlymu5x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Changes in v2:
>   - The splitup of Windows headers has broken compilation because some
>     of the headers couldn't be found anymore. I've fixed this more
>     generally by converting includes in "compat/" to always be relative
>     to the project source directory, dropping the platform-specific
>     `-Icompat/` include.

Nice.

Use of -Icompat/plat/ would make more sense if our sources include
a header file using the standard name of a file that usually appear
in /usr/include/ on a platform that either lacks /usr/include/foo.h
or whose /usr/include/foo.h is inadequate by giving a replacement
definition in compat/plat/foo.h we ship.  But that is not how we use
them, so I very much like this change.

>  -:  ---------- > 15:  3a4949d74d compat: consistently resolve headers via project root

Will take a look and replace.

Thanks.
