Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FD821FF42
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 19:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753125241; cv=none; b=cwA8VpClBqtiEUBhtgHqkUiBVEhhU5VY5vLe9+zqnSps3bBSJLQm657ceUsdKZDIIlVAzr6NLwNxqPGyZyzv13Xo2r1IENRE/C/PRyXniRxreVIvOYnr3KtNgVdXJcJygVzXo8yoIrrG42Lu/tanhk2wJpZPZpopfN7pk///Vnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753125241; c=relaxed/simple;
	bh=V40U/LfvBPP8uUmHYYeVhrUdN2y9BBEA5i+iGEONSXY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l+3VDDvHOXiBgPyY81OgwfcUC2cpyjF/cLHdRwW/Vc+T577lc6jMyjt/PAEFn5Xi6RhN4/8UqOP8krz0z8Wk14GWR92U517iuVCbP6Wz3DpPI1jHXD4OX9BvgSceARy1Rj5/zHeODIe2ZsvKEPYoK2csalcddRJmsqGcG2DE2lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h2+UXQGZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wkc6NElN; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h2+UXQGZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wkc6NElN"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 9BE101D000E9;
	Mon, 21 Jul 2025 15:13:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 21 Jul 2025 15:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753125238; x=1753211638; bh=hWze/nyW+M
	tQWi8z+oEPxf+38d7ZfnhWVPexKzx1dZM=; b=h2+UXQGZC67QIAY4rZzVDqe9mv
	jOvD69+qu/7O2+o5/HljEl037KHf2DfdWR14oe0ZB8cHk+4/67ZLezHsiJqFvuGg
	NZ9jKf7Kqb/rZV4vDypDr6sxAkr8BmnhLoqkln6slsPSb3ZTUhfVFEZhX2frG0Zz
	fkefwko2b0qiFJt7WQwfzvvSURMwwVqceSiDdtl7F2oBpNeNjFfhgzRQeB7eqYmE
	EJJ/rP5EOhWPrG2qvG7e8Gvk72tN42E6IZpAfy7T6xknw11h4FUWxN98BDb++KNy
	M50/W4JDcUxnCFG/zYUI8WCOsfzUC8UjJyRsIDULSn8SOJWp9pf4QphYk9CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753125238; x=1753211638; bh=hWze/nyW+MtQWi8z+oEPxf+38d7ZfnhWVPe
	xKzx1dZM=; b=Wkc6NElNyK51IpL8iunB/XBYHtWMgZe07atZg/bGuZmVjKUrDAw
	uQ0qeT9h6pZk2sansTl7JIW8FqN8FksOU456FE+AbNxA5M0IPjBjjchOJ0NblWRi
	HHBgC40i6CUE8l+QWP3DSdmUO/ZysPURte8/3t4iw7YeigFl3EEGv0EeZi3SccG+
	NiZfvf6mVRion2q8iVPxsOMpSoAmnAA33zRRCdAsihrN/wQF04QsaH5F5QKXUSsS
	uoK79QBQcexpNPYf8q+CM2H3RLvs0prTMvtY/nujxS3A9o/GIMHy62i8q/0rcQi4
	rNaVKesO2MHKrS7sMO8kB6KXhh106kCBrkw==
X-ME-Sender: <xms:dZF-aJ9cW_wZVOOayO7BhL67asUcC9ZT1IiLrtFeYf0Hx8fSj-rDHA>
    <xme:dZF-aLQl9bcfh-UOs3uQ2L56z0Wlx5KaiRgq3YjT3mOylvWoxYkueocYaIb93gNAh
    UxvHXtjN81WlVWiSQ>
X-ME-Received: <xmr:dZF-aNcz4Pv97DwKEcHgHjtR37k7oTrf4vItEc7p0y7tRxU6S_h3Dktp7q23T1YULJtS_asd_x7xAV-hWFSATyk5OeYJNtAu1QWxeXU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejvdeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgrghrghgrughithihrgdtkeeslhhivhgvrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    uhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepkhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohep
    sggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlsh
    estghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:dpF-aPAQ8jADGVz0TioxhomZJJfwYDWnk56vwqpfT9vzRU9ql5CyIw>
    <xmx:dpF-aPk11mGeaJYgXRG1sofTvbdfCxMLBJw71649jAr7UstjmJe7aw>
    <xmx:dpF-aKcMGUDI8zdWQ2UbUY08pfN_PuNQqZ_S89U7J7N6E1pz2oeGNQ>
    <xmx:dpF-aDRoZdYtd-gKDDK5ktcT1QVbeO6dDO7mPgmMKOLIctjVoUuK9Q>
    <xmx:dpF-aGxfn3gYC4Y8amGXMA55Fs4HSHgqubLbj85-Bd_HEBAIT7LuowP4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 15:13:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>,
  "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] send-email: add ability to send a copy of sent
 emails to an IMAP folder
In-Reply-To: <87a890182591c9c21061e85834fc99a766252611.1753092192.git.gargaditya08@live.com>
	(Aditya Garg's message of "Mon, 21 Jul 2025 10:05:39 +0000")
References: <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com>
	<87a890182591c9c21061e85834fc99a766252611.1753092192.git.gargaditya08@live.com>
Date: Mon, 21 Jul 2025 12:13:56 -0700
Message-ID: <xmqqpldtxsp7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> +sendemail.imapfolder::

Do we expect that the use of IMAP in git-send-email will be limited
forever to store outgoing e-mails to the Sent folder?  I highly
doubt it.  For example, would it be plausible that given send-email
has so much richer feature set compared to imap-send, it would not
be implausible for users of imap-send that want to stuff messages,
with Cc's, threading, etc., all prepared by send-email, to their
outgoing folder.

And when somebody wants to add such a feature to "git send-email",
how would they find this variable that uses imap-send for quite a
different purpose squatting on its name?

Same comment for the --imap-folder command line option and the
internal variable(s) used to implement this feature.

These things should be named with words like "sent", "fcc", etc., to
clarify the use case this new feature is trying to support.

As imap-send is not part of my daily workflow, I have no strong
opinions for or against the proposed feature, and I didn't find
anything glaringly wrong in the implementation, other than the poor
naming that would block possible future enhancements.

Thanks.

