Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA62D2E3392
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 05:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742794745; cv=none; b=KPD2fpEAmtzd9C2gfzYpjvlr+TTHRDBIh7R7DChL60bizp9LNWdgK9N6+TRntv/O72GVFwcb90q0ZGmddhnKmBslkxb0gp7jXWRwewuG9lPCNcYd70pd14nWUYxkDvVXbd5kAVsdFFNrnbuFQh0t7tRXzuIFbFeLEglCbyKlNYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742794745; c=relaxed/simple;
	bh=eAS9ZigG7V+kiOOVkEKOqwlXxe3cJmUyt+5DFs7TOX0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V/lVLloTqgn6WJ/g2NUxLmH9PdXPeOVSYaUmGr2+ic8KfrbnNrNUznJAJIlO5zHfV+MwPrmFRYNnZ15GAvRcoOB7NIcNiycGK8fXGBqiNM2rwwWFOjRB0swVxg4/ZncqTS0zJ+MYS9c97kk6r5wvkozJRoDJ12fRS4FkoVc7t4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EEbP5GsP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BrrdqqcO; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EEbP5GsP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BrrdqqcO"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id DE4341382CB7;
	Mon, 24 Mar 2025 01:39:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 24 Mar 2025 01:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742794742; x=1742881142; bh=di7eH0KUOK
	WxqAmtXosg2T7uEEVC5fosysTGcdOL5iU=; b=EEbP5GsPM9Ev+tjx2hJl6+9SLu
	C3Mo0yA3N1geJjfqnUWTwKGYcLns11Je6PGbGa7pMR6SdPdWirgWSo0aNKpsSRcT
	wXZDrkbcnTTvjSTBBQI+H+WT5OQlWCXjj+sPVMZLYkc9Y2EKXs0qwPYDXeGXUeBt
	BcPo39oJhLacWATexmC74Ipl6K9qMMP2lCAnJwFSwNno9nkwAdFYftlHkvjk697W
	B2YgNktxeOB61a08BKNWJNius+/dn2Qmuy/ln2yyPaIQMjCSku5aBs3MinbHM0d/
	OiE2FQu5+Ben5+lp8avUV/P9E962tBKdNslhFYNoAyY8z68FMcjYPWmT+0qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742794742; x=1742881142; bh=di7eH0KUOKWxqAmtXosg2T7uEEVC5fosysT
	GcdOL5iU=; b=BrrdqqcO3KWuC7ZJURGrb8P+56fcs02PDGauLAvBoOEamJsaBp4
	n7ZDRqCCKYtlQb4AFdJu8twR2eXROrmbJRT1YRQw+D6940/0SzlGCbUoSPeZSIoJ
	DRv3E6opLVkIz87n87XsEY6jlUUJw6JNGi6VLZSCsZS58Bmwzz0/U0X6ei2B+Ztd
	pE8/vR92J3C584ZUknmxxPxF/0t/LlXJOoxbPvcq4+eS+HkEaBJyfhbqKldrnb1C
	wdTCFAINSuCKY4uxfFZSEYDjErM5CacZe3y0iH6HhU1E+kMyqtFsBKQ0eOSQN+Lh
	2tktuPneKuYzH7foDeOjP7BCrn31xQ+cY5g==
X-ME-Sender: <xms:9u_gZxsHIldBP5N-SZBfHzwgJbXmdnKPy7Una0JHslOfgGi3N66LbQ>
    <xme:9u_gZ6dkuerODwUWc_f2HQVHYaMsK-KNxndgPtlNqeTARPkP7cH-CEHrcE43Q-ikj
    _vEVi_UvtrH8VYrnQ>
X-ME-Received: <xmr:9u_gZ0w9shRl9JRKrKJFgkbKSl_7TPKXdr3Dn9VydXGWq6PbGdrKAZcMiWkAP2oYLbcPWWCPHI3howU5rORUvWtP4UHHNJj8-5dW5jQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheekleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnh
    gvthdprhgtphhtthhopehkvghsqdhkvghsseihrghnuggvgidrrhhupdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9u_gZ4PN6aEX8WTCqg5N9jjbq5CIfSvo9mmmCO83hfNuwvWblIIV7Q>
    <xmx:9u_gZx_3N0q3Zn_kh1vWLiKn-x0khZYHtIHgVotBZJ_u_NtgNPjhgg>
    <xmx:9u_gZ4WuVBUXaynFmoqOXkVq_B_LMWRkb3hGvbzn1w-6MPGzzs8XIA>
    <xmx:9u_gZydeE9VxEnyqNN5Cl7E1IXfUBHIzOAtorMB_L4V-xWtEfWrc1A>
    <xmx:9u_gZ9bqjagL8ioT7Lw8pO0uoeZBR5wNUpOw6eGYRB1mYETIo639KCAX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 01:39:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Eugen Konkov <kes-kes@yandex.ru>,  Git Mailing List <git@vger.kernel.org>
Subject: Re: Why merge conflict block is located at the wrong place?
In-Reply-To: <Z9_Pkb7N1J_J9ECo@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Sun, 23 Mar 2025 09:08:33 +0000")
References: <1145598425.20250322191649@yandex.ru>
	<Z9_Pkb7N1J_J9ECo@tapette.crustytoothpaste.net>
Date: Sun, 23 Mar 2025 22:39:01 -0700
Message-ID: <xmqqsen3oumi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-03-22 at 23:16:49, Eugen Konkov wrote:
>> Hello Git,
>
> Hi,
>
>> Why merge conflict block is located at the wrong place?
>
> I think it's a little hard for us to comment on why this happens without
> a reproducible testcase.  Do you perhaps have a public repository that
> you're working with that you can use to demonstrate this, or a shell
> script that shows the problem?

We do not necessarily need a full repository, though.

It is sufficient to make the contents of the three blob objects
involved in the merge (i.e. the version in the common ancestor, and
the versions in ours and in theirs) available in order to let
anybody reproduce the symptom with "git merge-file", and that would
give us a chance to check the same input with "merge" from the RCS
suite to see if the output in question is really unreasonable or if
the expectation is skewed.


