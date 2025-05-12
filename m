Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A8B248F7D
	for <git@vger.kernel.org>; Mon, 12 May 2025 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747068134; cv=none; b=N4KVLokI18VQU+zpSOqMp0bi7lZuJCLT6qDu5WW92rBssRnWEZtTNde6hlWxNkQs6+QOdg4d5lnu/hRl6FREdIwm68gd6H9HAxKLU4QvbRv/vAdQEvtozV/yLiM7ywJ/TvL6mv5Fu/BtKeHQ3QShDFQcoYDxLHVRyEDPbW/FFIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747068134; c=relaxed/simple;
	bh=efxIJjeZQh9vLLx0ihALVT7P1J4gvzcmLKOpk0bQKIo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oV0JH4PvDmVyyd9E5ujYOalGKUgPNb72hhg74HqXcPGv56/qHwqJQnsTjbFAVCSPgWkhzgUv6WmPjXKywWmSub7LF5q8beKnBMfeRqUktzcVWjf3FyIh1oXcMLwuwG9IUXaZM6jix0BDQ91J9uIoOqMYX2FR43PmjzNw/WzRiVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mK07YAFs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nNi+v0o0; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mK07YAFs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nNi+v0o0"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 94F4D254010E;
	Mon, 12 May 2025 12:42:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 12 May 2025 12:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747068130; x=1747154530; bh=q9u9IeySeL
	FRzioM9iT+M+qtoMxtWfZmyAC3iY78Sis=; b=mK07YAFsou9b+uCbIcCEtNJIFI
	6cVbbLr7gbVhb6onUYkYcm6HUzwL3fGedBUlcVEIi5VxeFNdiXKCL6Jk0BfRjXyX
	vg170j0YkTrkeyS7RCoHc56mxU+TZdDz9wY+es5DfiXfz4cMHi9rB5iwSBEgM6dd
	MZx7tUNSbSba/fNv/33nZZ2uodKH4DyPdpAwCqLT5hcX9gTBhLQhsuZ4F0bRSKzK
	rfTf7YSrLjR0tcnnKO6gAWTtfgJ8pVFgNI8gdCa0TuofXAg7Q2blK8+bc62c18Ht
	0hk2PViIqGGVuiYN8O+YPNYId9On0CTwiTqy3A1aheWyHQPBfBXm6dt0z/jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747068130; x=1747154530; bh=q9u9IeySeLFRzioM9iT+M+qtoMxtWfZmyAC
	3iY78Sis=; b=nNi+v0o03gAk4PYtHLEBkRhDnBCI4VewosmkcGF9B0t3s9zKlgC
	3pD+uuVmXNGbdTKUcxf0kNtHq+elNhlsTTUmvjuPupW8dwYE4n9+UDJGtpnzF6Vg
	2JoqIk2DcylZXodB/vSwREGUWidlzQFIYSg7oLeu7Absm7A95zk3wrD7bX3cnYlE
	0GgQmrbdQOT+LjsXLY+QWO5c+9/kHJtBug7cVEkoKSzRaDKhxC34+EYt9HfGdY9C
	aaN97L7fvWTdc2xWoB1VQ8Fh4O82rHFKTRuhHzQGBN1w/FlyD8UBZQxkU/Q93BgV
	R3jxhJH6AQyrhms8nbwEsygiV0/Xnj+o2aA==
X-ME-Sender: <xms:4SQiaIXa8wbGDe1o4QGpK2kE9JS0bYj0pUoL-DjNB_i8Sf8F3DO_Ng>
    <xme:4SQiaMmkuRzM7iMdwdzjN_gkB3jEVV0u_M_C3iDnxoIkLcJ3oKlrKqeytL6C9goL7
    2kFrktD52ivQD4fRg>
X-ME-Received: <xmr:4SQiaMYXxDMTy1aiLY8QHv_ivty3tzSipwzjgE_XH1LVj5SgR7OGHmAudWUhhJjrfNMShb8hVI8qFAZPZg9khf8KyrjGcjNmr4_XUnk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddujeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhulhhirghnse
    hsfigrghgvmhgrkhgvrhhsrdhorhhgpdhrtghpthhtohepghgrrhhgrgguihhthigrtdek
    sehlihhvvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgt
    phhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprh
    gtphhtthhopeiiihihrghoseguihhsrhhoohhtrdhorhhgpdhrtghpthhtohepkhhrihhs
    thhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:4SQiaHVvRRtdBFk0UO3iCPGlQt--o_LEXNShV15xc5lTYiruR_9sKA>
    <xmx:4SQiaClX03AdLuh-IRBH26onNFYa3BY_99WY-IdcsPmpw_fXNWHKwA>
    <xmx:4SQiaMeO_VJQRDynrCTCgY-IlQzwEPCcUc3yqnq8FvrmmCgddQjlPw>
    <xmx:4SQiaEEmTshP8Oyr2UqCu9kAjendEB1pcpvYy0qN0vawvDzDlkZ9MA>
    <xmx:4iQiaASsOuIMMqjQsbPhSEqKL1bBdIp2aRX-epENiW7tMyxEyBYvVVo3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 12:42:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julian Swagemakers" <julian@swagemakers.org>
Cc: "Aditya Garg" <gargaditya08@live.com>,  <git@vger.kernel.org>,  "Eric
 Sunshine" <sunshine@sunshineco.com>,  <sandals@crustytoothpaste.net>,  "Zi
 Yao" <ziyao@disroot.org>,  "Kristoffer Haugsbakk"
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2] send-email: try to get fqdn by running hostname
 --fqdn on Linux and macOS
In-Reply-To: <D9U0KAX6KVXK.WCY7YGX2Q0A5@swagemakers.org> (Julian Swagemakers's
	message of "Mon, 12 May 2025 09:46:05 +0200")
References: <PN3PR01MB9597C419019DC28E489D2AF9B88AA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597BC2E1B526A11D21BAB24B895A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<D9U0KAX6KVXK.WCY7YGX2Q0A5@swagemakers.org>
Date: Mon, 12 May 2025 09:42:08 -0700
Message-ID: <xmqqa57hvl0f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julian Swagemakers" <julian@swagemakers.org> writes:

> There are multiple implementations of the hostname command, and they
> don't all support `--fqdn`. For example this will not work on Alpine
> Linux as well as macOS.
> ...
> All seem to support `-f` though, maybe that would be the better option.

What makes me worried about such a proposed changes is if there are
implementations that takes `-f` but uses it to mean something
completely different from fqdn, and emits something that looks like
a hostname but is not.  At least an implementation that takes --fqdn
without erroring out would try to give what this code wants to find
out (or it is simply crazy), but -f does not feel specific enough.
