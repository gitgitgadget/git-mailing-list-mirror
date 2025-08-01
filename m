Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59881246786
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754059412; cv=none; b=oVpvt4UIeLXr8qnvHlMsYXRcTVUrjqPU/IC9a5S6ET/PM8uWAPxnKwpj68mleJt6r8zP85KD5vUCyIzHNqLARCOEKgj+GUVQ6wROwiQ2QukY3I0tSZw+1RhVa5T1mJYo1Swkm+x6t6SV1fGtTQneBFsMCjsMY+7h1mvc3xYtMPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754059412; c=relaxed/simple;
	bh=koUoYHLtRfdMpHoYSTXBm3Ef1uAzlp8fjHQWME2KPWQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RazW1lj3vIH/0QyiQDvn9N3DD71jOHEJ50yb9QGy7MdnClCEeDNxqi12pWYmGvBaLbGvEgyHS+mdS9rNYYg3g8Lck16zTjIHVWA2U3KhD9aiXiVzQKqiOQJuOfkSc4vBj83wCl/89XqfFCblLwyG+/w7J3FDDuD0FPtZueKOmsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SGwGz/xf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RKR2R6lE; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SGwGz/xf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RKR2R6lE"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id E4CFB1D00163;
	Fri,  1 Aug 2025 10:43:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 01 Aug 2025 10:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754059408; x=1754145808; bh=5JLtITG9Tj
	brpBkZ4jSxnLI/w71oTgE+FXIskilVR6g=; b=SGwGz/xfocDWUNSfwGHxgDu5hy
	wa4EKZ0163E3xR9H0FMok33rLdnGrszduGqpe81k/aswj2rbPiblkyHZRgeMMpNH
	L9RxJV3vD0JmqcMyxAmqq0+2Vz1S7gJMCe0Md9Yl8Ki2M4b8enVtMcuzq4oGxT84
	m4JSV7UBjSSqdY8L2dPJAQ0q68XnNvOaDCw3NRfWY/wMyaJkYsRAm593ieLpPnBq
	HlGJQUwJqpDAoeg0GGKrHt4X4sEpB3ZSv9NSwQMq4jMrBA8shUl9tDB138NIDrb1
	0QBlnuObNz9I/HeRZo4tvQjo93Czr6c4ErooGtivauSwvSh/qhOiDxwYp1ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754059408; x=1754145808; bh=5JLtITG9TjbrpBkZ4jSxnLI/w71oTgE+FXI
	skilVR6g=; b=RKR2R6lE+vN1QoM/mGx+d0q0YA9BtFhu4fgqB5lUEv5qJrS44c/
	LKMEwoEzWF6tOtPLtNSSRVrBiRXoVUgu2VJAlaV7rxmTQwVfusFc2phNhquKkLcI
	ln+IKw4VWG79I9BOmrdJEvvCD6SSE3v5vWvK8NwJN3rklcaPw4NMI/6oOmU08WcA
	gpqrdPJZVdqDkLgQKnPxxdfO6I4Cwf+K7GrKuvSH0e8v8dP0LQ3UJFjO69D3Jo3q
	+v7s95HkBm/eEIkDfa21Kny7CYVaJ0ArCK0kKfMJxbYgWcgEw+WDUyXOSZXXoQ8x
	+LacpSi2x/zNxIpm7NvJJDPQzGQGNfEST9w==
X-ME-Sender: <xms:kNKMaKghuISye1ZwliQr5-G_aMR1_CQLoQG7BGUE5T0v-ENOdhG3KA>
    <xme:kNKMaH4ZoS5kDgnwUfOk39--6zzyXKQdWysblPJszGkLyD9W1FDh0wM3qb8DnB5og
    1afx1TBvBUCL3gMeQ>
X-ME-Received: <xmr:kNKMaB3EM2k-UU4w4chozl54EO7ri4UzfuIb4kRp10TiIg63xJeO1e_oK-p3Df3vA0OkJAbrpituEfw7hJltloulyduOVSrnMJyeqsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdefleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehmvggvthhsohhniheftddujeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtth
    hopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepjhho
    hhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:kNKMaCu-eL9VwzimpxDz8jDBAqt_K4S8dwSmkwlCEDKBVyYiwd7IYg>
    <xmx:kNKMaH5Qiay7CTgoXdJ-aKcNXtz0LK2o1zBpqzr0od220xWh0e0ODg>
    <xmx:kNKMaOd19xXHkWet2PUWdS36uDlIRb_KZoWiQQqoU05aiXPaf2zq2Q>
    <xmx:kNKMaEykCilu3dUrEGEAAnUkzmam5nxKeYZa9npFxHG2O6V_6wNhRw>
    <xmx:kNKMaOnpULwaVWB_VUF_f6bPJSjtMhYyDAtYtap9k5QFheRHrQES1p09>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 10:43:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Meet Soni <meetsoni3017@gmail.com>,  git@vger.kernel.org,  ps@pks.im,
  shejialuo@gmail.com,  karthik.188@gmail.com,  sunshine@sunshineco.com,
  John Cai <johncai86@gmail.com>
Subject: Re: [GSoC][RFC PATCH v4 3/5] builtin/refs: add list subcommand
In-Reply-To: <2d2f823d-6e85-44a0-85d2-d45d4dc287fc@gmail.com> (Phillip Wood's
	message of "Fri, 1 Aug 2025 14:27:47 +0100")
References: <20250723064313.29866-1-meetsoni3017@gmail.com>
	<20250731090040.1625303-1-meetsoni3017@gmail.com>
	<20250731090040.1625303-4-meetsoni3017@gmail.com>
	<2d2f823d-6e85-44a0-85d2-d45d4dc287fc@gmail.com>
Date: Fri, 01 Aug 2025 07:43:26 -0700
Message-ID: <xmqqseibm7ap.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> I find the behavior of for-each-ref quite confusing so I wonder if we
> really want to copy it to the new command. For example
>
>     git for-each-ref 'refs/h*'
>
> does not print anything but
>
>     git for-each-ref 'refs/heads/m*'
>
> prints all the branches beginning with m. Another example is
>
>     git for-each-ref 'refs/heads'
>
> prints all the branches but
>
>     git for-each-ref 'refs/heads*'
>
> prints nothing. To me it would be much easier to understand if the
> pattern always required an explicit wildcard (or possible always did a
> prefix match in the absence of a wildcard).

Thanks for raising this point.

One point you are wrong is 'refs/heads/m*'; it does not list all the
branches that begin with "m".  It will not show "refs/heads/mid/night"
even though it may show "refs/heads/morning'.

I do not think we want to require wildcard (in other words,
refs/heads/ and refs/heads that result in the prefix matching
behaviour that is anchored at hierarchy boundary is a good thing,
and we should not require refs/heads/* to get it).

As the "list the refs with various criteria" feature itself is
shared with "refs list", it would make the entire system even more
confusing if their criteria to choose which ones to show are
different.

I _think_ the current selection criteria is basically the prefix
match that is anchored at hierarchy boundary, and a single asterisk
expands only to a single hierarchy element without crossing
hierarchy boundary.  It is very handy that refs/heads/* expands to
the main integration branches (master, next, seen, maint-*) without
showing pw/3.0-commentchar-auto-deprecation branch and others.

What does a double-asterisk currently do in these patterns?  If it
is not doing anything useful, perhaps we should make it match any
letter, without getting constrained by hierarchy boundaries?  IOW,
a "fix" might be to make sure the following happens?

 - "refs/heads/m*" matches all local branches whose name starts with
   'm' like 'morning', but not the ones inside subhierarchies that
   start with 'm' like 'mid/night'.

 - "refs/heads/m**" matches all local branches whose name starts
   with 'm' and in the ones inside subhierarchies that start with
   'm'.

Thanks.

