Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB55819F135
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 01:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770513273; cv=none; b=qilpf/qp3PjEGZdAxOKBPBzZYTABMmO9VadYEJpJRlA5MhF9hHqWZw2duZhu93RxV6pFGwJtABzdOKOHjwRfQd6vIo2La0+Lb+tyvGxOWnIVG6/OFNvnwRjIVWpjRt1hvLISezJyTfQrThkpsx93J6nQ9ILklu5yHABPrT5zxII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770513273; c=relaxed/simple;
	bh=qs25PSRdprfwyWg/yWfW1fa6CSxRrUWgFUoMSiiiVFI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XtK7l4uDYBALuByKsUvPFCj3bpz3nLqlsLxnGuDpMudwOawBABGWAuO2q6norIfrrdOZzh+0L5IipGLNDZC8TNZ2uSBYP6hlIvlrf+PyPix+suOWmybUrSzC6+hafodUzjs4jFikCB27pIH0Sw72YiSbHtr8uAGpH2MjX5QjYFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iPtJPfbY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vvzjWEG5; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iPtJPfbY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vvzjWEG5"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 05D6214000A9;
	Sat,  7 Feb 2026 20:14:32 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sat, 07 Feb 2026 20:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770513272; x=1770599672; bh=gZqxtTUtVU
	lH10rWsXAJA15VbBLQM32TKhQQkyOd5Jk=; b=iPtJPfbYesoy87h3arYKTPhswY
	uvcAShdl/EwYSK9KH2IbnkDnnB9cmERYIYIsk4Xrqov6ZBVXvJwsWRBSVefLMCCl
	DhkY4QM6NdZnN4OYCMBvI/djsznOiebiePrerKdWc7CM4lTy/EvgZjwmMPfiptmT
	n+ifVf8wwPoAac8tpBEUh6xLHmTCk0hm8OK0aBZxan1TojDBugif8lKka6oOHFD5
	yiSTY9vkRVBVzlru+oawV1XgdaH9FJafIjEZVZmOe9z71unNF72eQ2xeyxeIwGkB
	3cqMk/tV+kUV8xRUh+60HzKEokseHDxdBHIua73/4ced/W3pIkuwHD3UAVOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770513272; x=1770599672; bh=gZqxtTUtVUlH10rWsXAJA15VbBLQM32TKhQ
	QkyOd5Jk=; b=vvzjWEG5r3SW5qaK+9+2r3pRJdGIF7AA8U8Dn4di7AdgON2PVww
	H7FLE/Beug39RtD0cnl00dnNg1wzUtKKDRR/tzgpqwA+PKb62aYBydNGsvcXZ6qw
	6F+r5v87oKLImbybQ5I2UMicZAnbpG2Ftl+91CTbRowg8nSEjbNwWiGxwyPVy6Vk
	IWSXhUwBu3mm8ILZ9IM/XayeGLljEPyoNVuNQ3p48x3uQx8PdoBK8Rl7s40mB7mA
	Uj9FID+rAsrbKgUNTIC5MwiHe+wvETQdrYGJYWajf16rJDzg1oJAZpUmQ3TWBpzw
	q59+0w0iT0pHsECBqsOZJaToPxNKbk7FwWQ==
X-ME-Sender: <xms:d-OHaZ9WENy2XlBwBTko4usVS60plVrqz7fOqWzl6O93UZ4STLMYcA>
    <xme:d-OHaUmiiDjPw-UrhFhF8DHmGSv_FUOEUjmnpU_vQS6Ii9VXiw8rPH1u14WEk_DTw
    EfAiKXazBjprnkwGNXfpx0QvS-Cx3uTyQj3XBhDVEvHbtGdHGIs>
X-ME-Received: <xmr:d-OHafVBWWD83s9WdM0tj9HEa_nEgOE5uyILamuMALpLV0O7EuJ0cWAFGycyEXuN5ZCYsCjt8Ny6HnBzqHM0sU0DZHklsBq4mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduledvheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhrvgih
    rghnshhhphgrlhhifigrlhgtmhhsmhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddu
    keeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfe
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:d-OHaZFdwACoyY6rVwvEYYp3c1A9xl9tQisHEKwQJNIwxYbmHHcXOQ>
    <xmx:d-OHabfZuVqiQRSZTYm85cudAmWXCVsmlUhy8PhDCC37nDEEhhF9Rg>
    <xmx:d-OHaaJ2bAUg1Fv_U5eyc2n6Xiyn6WJ6_ldlCc2s8ZpLpT1ohBSQPw>
    <xmx:d-OHaQFXVfGqkt-mD1Btc6gQP9cwfx6GZl_y1nMWEfgiED8m6XiA7Q>
    <xmx:eOOHaQX_s7LVZyWHWOzNWe3Nw9J715BpSss4XKPsI4bip7FU01WDHMLW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Feb 2026 20:14:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com,  phillip.wood123@gmail.com
Subject: Re: [PATCH v3 1/3] wt-status: pass struct repository through
 function parameters
In-Reply-To: <20260207100322.1786368-2-shreyanshpaliwalcmsmn@gmail.com>
	(Shreyansh Paliwal's message of "Sat, 7 Feb 2026 15:30:46 +0530")
References: <20260205101524.125452-1-shreyanshpaliwalcmsmn@gmail.com>
	<20260207100322.1786368-1-shreyanshpaliwalcmsmn@gmail.com>
	<20260207100322.1786368-2-shreyanshpaliwalcmsmn@gmail.com>
Date: Sat, 07 Feb 2026 17:14:30 -0800
Message-ID: <xmqqzf5k9guh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

>  branch.c    |  4 ++--
>  worktree.c  |  4 ++--
>  wt-status.c | 48 +++++++++++++++++++++++++-----------------------
>  wt-status.h |  6 ++++--
>  4 files changed, 33 insertions(+), 29 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 243db7d0fc..e3cf273339 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -412,7 +412,7 @@ static void prepare_checked_out_branches(void)
>  			free(old);
>  		}
>  
> -		if (wt_status_check_rebase(wt, &state) &&
> +		if (wt_status_check_rebase(wt->repo, wt, &state) &&

I am not sure if this is an improvement for callers of the API.

Isn't wt_anything() that takes a worktree "wt" supposed to work with
the wt->repo repository?  Or is the API designed to be used to take
any repository object that is _different_ from wt->repo?  I am
assuming it is the former, and if so, the only effect of adding a
repository parameter to a function that already takes struct
worktree is to invite a programming error to pass a repository that
the wt is not designed to work with, isn't it?

> -		if (wt_status_check_bisect(wt, &state) &&
> +		if (wt_status_check_bisect(wt->repo, wt, &state) &&

Ditto.
