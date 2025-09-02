Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CE827702B
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 22:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756851929; cv=none; b=SrswulebH3WzOMFrtifDKWDxaHqkU0AyqhIl9QEtCZHfFnQkAUouGTRSIMkjYweoESPcBkxolLQSSDnDvWa8xOiR8+HQc1F3IMHcHCIJu51kO7XkSr1NSxWWd7Zx84BmgvC76gyHQT5CDFNteZPQAn7wNqYM5KSyj4WFSPYMXl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756851929; c=relaxed/simple;
	bh=OLRs9F9A+uw5N8bteiYj08/E1H0rb9Z04XZZSnd5ZAg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aI/Ld5mTvjLpQcZ6GZEyi/Zj8QUBB1kfcGj75igd8Bos99Qh3K2UOJbpzl2JrXfQAzGnBD00vQrD6Eop7gGHgumfiCRoJ7e3AgccLCBJ/YIJpCgiwK5cbWix2L7hVpFn9aJMmvLFQ46uvaML6o4KUGfhnPrqsEBkx9WAFbyc+aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sa+CVvbV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZrnE6s80; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sa+CVvbV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZrnE6s80"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 74C51140015E;
	Tue,  2 Sep 2025 18:25:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Tue, 02 Sep 2025 18:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756851926; x=1756938326; bh=aF8GtZz5cD
	QlxKkVSTeW6mYhkk0zNp9SPN0ntbl4LrI=; b=sa+CVvbVWvcarpHQY40Gt2k0k1
	zfW3TdWXDzbB+w8i8tuHhmWVehv0pZV3QNiNRbjHqkAmroCnhxu6JpShxmatVNea
	9ADzX1SS+gdcaMPLoMLehO4enGO1wHyJpjNgkuP6K+gRjBoJMAW09Fe02TUX1mJA
	Mh5TNPQ86GycnQ2gqvsn1Zta6K8PVQcWD4V20AFLJFrujUYp0Kb51gcdDw/Pzrf2
	K1z+uPnGj6gWo2uOJLekvjQPVNYiwZAFLndbtTscinA4m+yNt4FhkAVK94QkKDPz
	kOIpjVICgN4qSxrYEY7lMEzrtD35lem387/VaqYjhuJrLRs200lI/Vk0RlJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756851926; x=1756938326; bh=aF8GtZz5cDQlxKkVSTeW6mYhkk0zNp9SPN0
	ntbl4LrI=; b=ZrnE6s80lgdff2oxjDPfVDOKvWxSr4w+GsifroOlWMS0LRWzwKu
	DFL77Ic4O7atvP21Bbm3GWyRSZee+VqfNAK2bNT9fzLhp327e1/AlsaG8QaJXC/b
	PramqYdaQEG2iBJ3uf/JaDgP3SPhQo7TJzLKNMxEUuKTwgYKA/iUYr0H8BkyUJrH
	1OewpYzWTOKjnw/RqL0+m6SSpTgl4uEDJBv11URXynzYPYysQIrZx6PY9XJaPIam
	rVX1Njh3M2evpkUuvX7dEgCJPtUk6kvlaBl0gVoBD45hY+GRSgjnb0qZFTXDDLEx
	0cDRMnZamAx5QUk4FZ5UWP5YLwZuoIXJwZQ==
X-ME-Sender: <xms:1m63aOiBIiVDg0RMNqpR4kLKcrb_mmfcCfpq_klSTHQJuxCx-IHClA>
    <xme:1m63aKhSWmWcUg6tUNhyTL4WFjSSi4_bg4r7YpW7-4Ow1lthqLORvs-c43e6KkPwn
    q_Acutl7G-3tkMtLg>
X-ME-Received: <xmr:1m63aMhLObb0oOUMuCyPy8-zj6Gga3jBpLrnyQcPq91s8NHft5-c9Y7K4dfTa3H1B--rDEtUkUEeEWUfiy2l_NeupqHQ8QEkLcEAqWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhl
    thhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:1m63aCKx8JFmA0s5RJ-pnwIIa9BPkvY0y7qYnfVMRTQZTjcx7p_LCA>
    <xmx:1m63aDFR9C1j8rhoUcWBnamB15NduE9I-xOnZUMdBLTw3wuqsvOPAw>
    <xmx:1m63aOTfXb-br5wRLYL3JKly9xqKglumP7sbaGd_wQsu4KI9gCo6rg>
    <xmx:1m63aHdtwOdaDldWYlFln8gd81PqqQlkEpc6JAMArHQZ3lcDlALkrg>
    <xmx:1m63aBjxOKiG2GD8xCiA1e38fgQvpcPe5b9S2MDbDKBTV3zbH3gyroCs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 18:25:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  shejialuo@gmail.com
Subject: Re: [PATCH v2 1/5] fsck: order 'fsck_msg_type' alphabetically
In-Reply-To: <20250902-228-reftable-introduce-consistency-checks-v2-1-4f96b3834779@gmail.com>
	(Karthik Nayak's message of "Tue, 02 Sep 2025 09:05:21 +0200")
References: <20250902-228-reftable-introduce-consistency-checks-v2-0-4f96b3834779@gmail.com>
	<20250902-228-reftable-introduce-consistency-checks-v2-1-4f96b3834779@gmail.com>
Date: Tue, 02 Sep 2025 15:25:24 -0700
Message-ID: <xmqqwm6gh4q3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> The list of 'fsck_msg_type' seem to be alphabetically ordered, but there
> are a few small misses. Fix this by sorting the sub-sections of the
> list to maintain alphabetical ordering. Also fix a clang-format issue
> where the escaped newlines are not aligned.
>
> While here, remove a duplicate instance of 'gitmodulesLarge' in the
> 'fsck-msgids' documentation.

"A few small misses".

> diff --git a/fsck.h b/fsck.h
> index dd7df3d5b3..559ad57807 100644
> --- a/fsck.h
> +++ b/fsck.h
> @@ -20,82 +20,82 @@ enum fsck_msg_type {
> ...
> -#define FOREACH_FSCK_MSG_ID(FUNC) \
> -	/* fatal errors */ \
> -	FUNC(NUL_IN_HEADER, FATAL) \
> -	FUNC(UNTERMINATED_HEADER, FATAL) \
> ...
> +#define FOREACH_FSCK_MSG_ID(FUNC)                                  \
> +	/* fatal errors */                                         \
> +	FUNC(NUL_IN_HEADER, FATAL)                                 \
> +	FUNC(UNTERMINATED_HEADER, FATAL)                           \
> ...

Please undo these "pad by spaces before backslash"; otherwise we
cannot tell which ones are "a few small misses".

Thanks.

