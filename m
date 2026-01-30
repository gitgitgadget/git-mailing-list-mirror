Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D663E2F7ACA
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769790586; cv=none; b=U3FpwIZ+zIYrWrtq578NMS3OP+T7sLQEj9Rz1JKrRnkpOiZYRd0VSpuFDsgyxtQHGdxZVB57SdmOGQrf4hh3sZ8R/rSJWa96wFPf/YebBu9HA/Q0fNA8ZQkYQqZB2YvNNfRXBbz33Z1yU+L8LSvNAHRxxGJo+YbZLWZ2IWi6z3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769790586; c=relaxed/simple;
	bh=k+8NUopf8WHuN1WEnKVElx5Uj7THdo3usQ5OcJNGLpc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SgNOeM/UU2rKzm4lLpOVatlgnnJY8dQvYuAmeOkuSlRpkVoHQDgDQh/n0NbsbQh3XOoa6EJ882KeXgOh8Xvg/cJ0+WMSWmsAJr1Psmhpqu46rnBd7C9jqx/jKo8XZNIrAYYanKp4RE/cbthfkLw7ItX4drh4v6t5pb1ZZ5Ybxl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X31m2Frg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M8iahx7k; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X31m2Frg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M8iahx7k"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A6E251D000E8;
	Fri, 30 Jan 2026 11:29:43 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 30 Jan 2026 11:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769790583; x=1769876983; bh=k+8NUopf8W
	HuN1WEnKVElx5Uj7THdo3usQ5OcJNGLpc=; b=X31m2FrgH0b+Ld/amrSvfDmIoo
	RHGyCSA/hTUawOfpSBWVJ6RbqEf9bKVaOVTFZWWfax7oL+7QEEvEHE2V5+3ZMz7F
	cFjh79fazWgr/8UBSKJiWlKq3r+P0ghAETfkTssn10KEEPZZUvKTj4qkYscBlFVK
	KeNzpKebpYUohQ8y0461VRrkDDFK4rHb8vr0XgdpOiQFOqG0oCAtANqtVV3ltALq
	peWVJLJBEZ2wibNGseI9eWUh3DippmT1E3BIRkS2tXLWI12J2w0boCOpgM6wtRhs
	rJe+9MveLOFsR5+kFk/vibuRgT7dBUIVhhAqrs0JEskI7umUwj1rkyjOkTqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769790583; x=1769876983; bh=k+8NUopf8WHuN1WEnKVElx5Uj7THdo3usQ5
	OcJNGLpc=; b=M8iahx7kmPYZZFDv0FbDU5N8NyGNyVb4PtN0R7zDGS3SzhB91Xf
	KgbrZKirF886SeGFScu/T93gTZya50CIjBDpE4QIcgsJGrREuXPurzdPjMgwdQ14
	xh3ypsmhsI8rEpD5Vpz+vX3U22y/AiAblAxCmqjbAVTkTGYMoBUOUmh2cCm9U/wa
	dMSDWnXPKqaquDQSNxdLP6cshJ3TQdM/WUw9g7nmB19mbRsxQKqpW7SxqQkxniFz
	xYjbaBdIKKNLYSXIgZ5DW2twg+euTCyfW4roZ+WWD58IrwrY5forgTFWEMN603np
	NBKKPxsxFGc90KIvq/1PM2NAE93ZEYIzrnQ==
X-ME-Sender: <xms:d9x8aT9qFNC3yeAYK3U7zAk8laqD6St4TAat2-dqjsxNNP6LWkKwmw>
    <xme:d9x8aSS37bYfhE9kKnv0ewv5wabzqRX39Lnw9wat7tnMBN_Q8FjKG6zZKnPjmNJvS
    8HZG0j8BcNpVJjXCqfuTidbgrYdfDOoZ4jBZ4s8morkrBBo2IJ5Wg>
X-ME-Received: <xmr:d9x8aUonDwqH9xZy8aGC_yHIFygRCjC0T2uCc8faiBmoH02eeHa5k4hZxKFiY0fvjgUjtAmhMjNbtON3fyybPMxmYj_FpEAWjML44Z4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggsrhgrhhgrmhgruggvkhhunhhlvgehtdesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehphhhilhhlihhprdifohhoug
    duvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgr
    shhtmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:d9x8afnrhFcu1V0592MQ_RCObRYrkW2oK85rjouvm8_TPpzgnW8SHg>
    <xmx:d9x8addepqj18Z2KWBReCtj65DTFNJXiebIV4Bc9xpO4InRj_xA7EQ>
    <xmx:d9x8abpB4TkQM6osIvxo9jpR5avSaJ6aamPLKcrBGbBxlVt6_3H5yw>
    <xmx:d9x8aXMUdbKeHY_79fTYXeM3_uevXJa7UA8UFAOSIxnIzmGnLwiF3g>
    <xmx:d9x8aZb-YMcpbqLj-5MG4Yq9CFDchagk7dILfG3kEEi0msfDTJgYMz6h>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 11:29:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Samuel Abraham <abrahamadekunle50@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood123@gmail.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,
  Christian Couder <christian.couder@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 1/1] Allow reworking with a file after deciding on
 all its hunks
In-Reply-To: <CADYq+fbt7zHO=gAsRp=b5MTb=2aFfifCjWnW6u+58iv4dk6bMQ@mail.gmail.com>
	(Samuel Abraham's message of "Fri, 30 Jan 2026 10:22:25 +0100")
References: <cover.1769522219.git.abrahamadekunle50@gmail.com>
	<9b21cb901ab14397af94b8ed2d09da1a9a6d862b.1769522219.git.abrahamadekunle50@gmail.com>
	<xmqq7bt2g4tl.fsf@gitster.g>
	<CADYq+fYeWh0tLEepOGVa=1i9tXZfWaGfyi6H+xUB7rbdQ=t5aQ@mail.gmail.com>
	<CADYq+fbt7zHO=gAsRp=b5MTb=2aFfifCjWnW6u+58iv4dk6bMQ@mail.gmail.com>
Date: Fri, 30 Jan 2026 08:29:41 -0800
Message-ID: <xmqq8qdf83nu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Samuel Abraham <abrahamadekunle50@gmail.com> writes:

> Hello Junio, thank you for your review.
> Here I explain my decision to move the "git apply" in patch_update_file()
> to the caller.
>
> Does it sound like a valid reason to make the move?

I am not sure, but as long as this is an optional feature, users can
choose not to opt in if they do not like the new "all or none"
semantics, I guess.

Thanks.
