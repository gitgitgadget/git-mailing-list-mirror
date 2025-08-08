Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5C828689C
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 17:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754673252; cv=none; b=m83GYE76+wMpIowhcyHahwfP0C3mSNLbGYWxhNn5sd+t8IbCsFDrwCjjF/ypF+vpdEEiKiv6iUg/avjzM9WQlMD+Y9A0WIL5D8FPI3+00x1QULFgO2MtXJ9mzLBzs9nFL1sJMPdULm/wnWiVw7WD5Xqj1xdtb8P0wv+k/4bboUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754673252; c=relaxed/simple;
	bh=DQ7+rr/6SfWwS7YG0h6og49t4sRG9uHsWTwGI4pthHI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qVmtZSOC81gaFTE4GYXZCPh9xTQ8YH/zgJ8I1gItXTZMmBLTGF+4IoYOdpIBDwenOesfP8/+YS8E/ycpnqggNkwHJYOoX4zCyO4N9IiKTuvVWkXp1SpUs61UgQjbUUXWmCvnW0JKnfGvFxnhCFaKt8MQ8FOvKy2Jby5XKsgWrM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=PrrLxK1T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YygYvktf; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="PrrLxK1T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YygYvktf"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 64FB91D00152;
	Fri,  8 Aug 2025 13:14:09 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Fri, 08 Aug 2025 13:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754673249;
	 x=1754759649; bh=65mqWdK4Tp/FM2hCnQZwUSdwwlDnNHGtmZa8IP28348=; b=
	PrrLxK1T9EgF+JoDXycnNlXVDI40bp/487Vh13GY3nZY3viBvW+3O5mxhNO9uFXL
	XHMDllxK6E0IjSA4zLTWRMKs8CvBBVvVLFdzyeSik+K2y/MBjcJiBnXRn+LXZ6nM
	mQRunkEhrY0Q5Ov1XoLqHEmbC+yB3zBtWYlz5ir6XmqUxurmOntoS0Ozy9ZJut7f
	G8wwaD+bTBbwtu+G3zhNclzBVdj8pGmyPNiPOtZrSUrMiXjUofOcKU/YDbcOc9kH
	PD8L6X80quhm/y140TWnQyLUO0ydBXC8fSmdQG/Z1Pu/aNyNaiRAWFbFtI7cGExd
	M73JzTTxRIfa1Jdx4EKFbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754673249; x=
	1754759649; bh=65mqWdK4Tp/FM2hCnQZwUSdwwlDnNHGtmZa8IP28348=; b=Y
	ygYvktfrD0sPZg9urgy9G61EuQ80/9+Y2rRBXu8Nwb0RXNvCbNxfeUzLf1esk2f8
	cUZYNamDgk2w+Q3hcnnSyPzYHWyzcd9pEH7IAOcgmmasgCGtq0RPxEWIdHUGxSWi
	zmWWtg2K21IpqT9cUTbINfdX+NSFFpdL9BWilPQoQsRCHmJzGO7MT8e+1iUujper
	5Jqmyo7GQ9yXUWiKT3WCI9eNYpIsnRChFro+994VBkXqLe+EQsNBrMfIdSrjDk6t
	/Nq+BdPJJzuz5/dfj+ifW3rkbBE90Z1kvWPdfOuEM9w4vFC4i31xvrf3K12dbQhx
	6f8qrCxJs3XnrUT55zruQ==
X-ME-Sender: <xms:YTCWaEJqZVmrKNEIJrdPaeBHT_bt_a2BLZVUpAk-ErWq7uZqP3-T2A>
    <xme:YTCWaEKmc6ZHYuA0dVGmqEgA7YqfF-CvpwuLX3OPtyB0HR3jzaYkx8MyV2IvJx0va
    kKLqvLyX1Sp5ac-7nY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdegfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epgfevkeduveeivdevueehhfdvteeggfffudefgedutdekgedtledtvefhtddutddtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirg
    esjhhvnhhsrdgtrgdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:YTCWaPRxoMlbJMOPLUwx6bV-j6kjRIfUZUSb9dMy2snjGa6dDKt1jQ>
    <xmx:YTCWaHo4Aw-CU_8JpNA6De5c7BOxJe-2JMzMAKJvouzkPelhXwW-LA>
    <xmx:YTCWaBwpJjCKY2lCOdnr-Qa-sleTLHr6pTkyeZyMCcCC6mB6eWuFkA>
    <xmx:YTCWaMKy0WTqKbF3eVTTIi9WPHDUJwlkfNhc0ThVp6W4Rox_MJ7F7A>
    <xmx:YTCWaMSo8f5zrpqYFc-XyVpADuOO2Da6D3yPKF6TOgmdV2ruVKWTjbA9>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 03B717840B1; Fri,  8 Aug 2025 13:14:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T8811983d8c40361f
Date: Fri, 08 Aug 2025 13:13:48 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <f9cd981e-276b-4b13-8e98-c7bae17bcf62@app.fastmail.com>
In-Reply-To: <xmqq34a1ixo3.fsf@gitster.g>
References: <pull.1949.git.1754666665.gitgitgadget@gmail.com>
 <ac3a91c04bfa5ab2b0e479c0bfeb2ba275fe1d56.1754666665.git.gitgitgadget@gmail.com>
 <xmqq34a1ixo3.fsf@gitster.g>
Subject: Re: [PATCH 1/5] doc: git-rebase: start with an example
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Aug 8, 2025, at 12:30 PM, Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Julia Evans <julia@jvns.ca>
>>
>> Start with an example that mirrors the example in the `git-merge` man
>> page, to make it easier for folks to understand the difference between a
>> rebase and a merge.
>>
>> Signed-off-by: Julia Evans <julia@jvns.ca>
>> ---
>>  Documentation/git-rebase.adoc | 46 +++++++++++++++--------------------
>>  1 file changed, 20 insertions(+), 26 deletions(-)
>>
>> diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
>> index 956d3048f5a6..fee73623990d 100644
>> --- a/Documentation/git-rebase.adoc
>> +++ b/Documentation/git-rebase.adoc
>> @@ -16,6 +16,26 @@ SYNOPSIS
>>  
>>  DESCRIPTION
>>  -----------
>> +Transplant a series of commits onto a different starting point.
>
> It is an excellent idea to start with what it does, before
> explaining how you would drive it.
>
>> +For example, assume the following history exists and the current branch is `topic`:
>
> The line is a bit overly long, and the style a bit on the
> "description of dry facts" side, which might want to give
> a bit more "motivation" to help readers.

I'm very happy to hear that feedback: I thought it was very dry as well, but I copied that part from elsewhere in the man page because I thought that was git's preferred documentation style. I'll work on making it less dry.

> Note that you lost the mention of `git rebase master topic` syntax
> and the explanation that the form being a shorthand for checkout
> followed by rebase, which I do not think appear anywhere else in the
> document, so my suggested rewrite above resurrects it.

That's actually in PATCH 3/5 of this series: I also thought the explanation that the form being a shorthand for checkout followed by rebase was extremely clear so I moved it to be the primary explanation of what `git rebase <upstream> <branch>` does.
