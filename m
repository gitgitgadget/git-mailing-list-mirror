Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2883434C130
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 03:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773112128; cv=none; b=U3e9yZIqxlVFNjKdpazwliDxAsu+5AcIPeNnQfZmu/l+SulX2Fn8e7Io/pxOELcOIV5xv6XkDvhH/bX1SYQTcKJmRmLhQxFoOCCX+z6QH57blfEzBOIb9U4lBvSIHs07ZrqHNLtPVpRFg2xRxMqnRBZfSmWG+4cDskQl3lqHXEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773112128; c=relaxed/simple;
	bh=FbZx4F2KYfPzZtOWYg3rAM96onBMJlathTiRANK7dPo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ukMrbDkaf9kKCyidj604RQla3pA81wCiH3fmxkJ0zWRUpGGkRhuFWg9KNCBKaZjhU0VtDJMo8+R3gTd0fQqszdoHaOf2oZBdcuYIFHFBCTwF+JNeV30tRLiu+3Pt5P+0tRd922kwfxER3nBKQCpua5mHXFWKC3tkEHqbP8zNqd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VB4rxd2O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nrpS9nsA; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VB4rxd2O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nrpS9nsA"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 4E7781D00228;
	Mon,  9 Mar 2026 23:08:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 09 Mar 2026 23:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773112125; x=1773198525; bh=9pUKki20fD
	JPxRvltkfRJklee2ahA5v+l+Y0WUT23Iw=; b=VB4rxd2OyvZk578b3Bl1nb0mmG
	1pm0EDAEGPwYlCBXqyg4irVsRdbVJCvSRP6GAIXgZ5k5sUBQhPljDx6+fBnXuk1g
	fFUWSj5Et5B5br/vvNYxKcLOhAo7XWye3AkNz+cYYbaPluM4JKV92BJ0tI2DP54A
	Ax0ZBz1VRSgQblS4Jvq1fy+PdoWqCq7lQwdIKXlCSwjUtt/MDb2cfPD7ICxfEQXy
	Di3G7tamEPtGxOK9CzgbdJVhHkDF33Lx7JfTw/qLxl/nkpquKpQlieC5DTOXcq03
	mD+48ZSkgR5LNdx/iJkO2qWeLkN6qAAmCxdNJKpZR+3f768M7Rymk17qdSyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773112125; x=1773198525; bh=9pUKki20fDJPxRvltkfRJklee2ahA5v+l+Y
	0WUT23Iw=; b=nrpS9nsABR8vqRB7bzoqYn0z5t+2XfJwQM6YIhMP3VmGVVZGaAg
	Eg4szjmi5SSslNb41M3oGIat/8wR3D5HABvFyNbSZ+bFHcmVjgqSoCN3Nem4Imnd
	gDefdVcs8n7oKKTqDsl4UVT34MSwCKUBioGwN5mw+HQzsTe+DiOJtg2EwYRIhJP9
	B0FdYh+p5J1vdKmUn8rywCjFLZ8BpWwnrauDwpy+Ah9+lu4sqsFUsecn9e2TFZ/B
	ffdzM+yPhgqWfr9LoW7cvwaotg878/5q4QOSbG43LsCdn/4B4dJNC9WRpRgOIJ/2
	w1WWQDKhOhAAAKfxUnfU7AaHp+ZTKxoHyFg==
X-ME-Sender: <xms:PYuvaTLWxL9dc9RxE9P93EOq-Ncmug2esMdzMRi6Qa_r2TGwax7h2Q>
    <xme:PYuvaeLfhrSUz7ltkK9qqI3RZL4OaHOyKVHubS3T3mkoNwAAxeTa4mxUVXKzmKH3l
    wkmbljNijRertQI3DBVjlZgVEjW7LkVDKJ81ZUp-2-6-LABq49daxE>
X-ME-Received: <xmr:PYuvaQtt1NgTZmlZOzB9uCiuZB5Lj3Z42azqaEp8fkukI4HUnLPEYCi52YV6Xhi8xJKlmxLihh5BKMPemYsKTVja2tuNID9JPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeelleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrnhhsihhmrggrnhhukeeivdejse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:PYuvabRdrhWxIQU89wCPTk9rmN4DBZmhKR1Kzumgzkvts41XCHlvLw>
    <xmx:PYuvaWPTngr6yvzRYQ1DkB9JLLo4VO2QA2AkEqJrx-3lrNTfcMh0CQ>
    <xmx:PYuvaQZBZT9rv8Se7BV0AkgwNlDtmPAf8oTMoahLCuL_Vy_xoWU7Ig>
    <xmx:PYuvaQwn-6P_4wp1p6sJekeu1cRdjUxPdqgZBY3S6XFoe5YhDdHUwg>
    <xmx:PYuvaQMvcxahjOpEhyAEpdDoh7c9kir1Uufw0hwS4I9A0ZYvzritMGRo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 23:08:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Mansi Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Mansi Singh <mansimaanu8627@gmail.com>
Subject: Re: [PATCH 0/2] repo: remove redundant variable shadow in
 stats_table_print_structure
In-Reply-To: <pull.2062.git.1773109018.gitgitgadget@gmail.com> (Mansi Singh
	via GitGitGadget's message of "Tue, 10 Mar 2026 02:16:56 +0000")
References: <pull.2062.git.1773109018.gitgitgadget@gmail.com>
Date: Mon, 09 Mar 2026 20:08:43 -0700
Message-ID: <xmqqcy1cz8hw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Mansi Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The variable i is declared in the outer scope of
> stats_table_print_structure() and then re-declared inside the loop,
> shadowing the outer one unnecessarily. Remove the redundant inner
> declaration to clean up the scope.
>
> Signed-off-by: Mansi Singh mansimaanu8627@gmail.com

The above sounds more like a description for a single patch, not a
cover letter.

Because we strongly encourage one patch doing only one thing and
doing it well, a commit log message for one of the patches in a
two-patch series rarely makes a good description for the whole
series.

But reading it again, which variable 'i' is it talking about?  [2/2]
does address 'entry' that is declared in an inner scope, masking the
variable with the same name declared in an outer scope.

Stepping back a bit, I do not quite see the need for these two
patcches to form a single topic.  They look pretty much totally
independent topics.  Perhaps you're better off treating them as two
independent topics, each with a single patch.

> Mansi (1):
>   t7605: use test_path_is_file instead of test -f
>
> Mansi Singh (1):
>   repo: remove redundant variable shadow in stats_table_print_structure

Are these two patches from two different people?

Last time in https://lore.kernel.org/git/xmqqv7fjw6yx.fsf@gitster.g/
we had three names, and we now have only two, so that can be called
an improvement, but let's whittle them down to just one ;-).

Thanks.
