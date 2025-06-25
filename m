Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78F2262FF1
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750863840; cv=none; b=bAp6AFV08E24jHfF30jg4tWEwoF41juUTPsdAqXxzeEvqJ9k3LK8/dwt6rXfOwG5uTZgxJ8lwj+FNChdUAvLLKFtHmFa00HZQYG+cDSslYDElTIjOgwNF11KtO5dQoPvxbAeW1LQsl2o3xfamo9QZOSXW31nNaCZVniDK0D8PUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750863840; c=relaxed/simple;
	bh=VzS3WHGAVUYwQfOD0gx61k3cKkUlYoIuhIh05mIExjQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t7w1g9dCA2IA6Pt+EtUfPg3o9qo1DESIdI7Si+t6MWmGOpqjI6AATkkJ2uMlhyhQLIfV+WG8Sd3RHaEVwDIpapKvc1krNcfZzlhwA2TJz8LYi7gycI+k1Io2/ibbpJyEFjq1ERfjcYEPsBcKoSac9Jpkl/FytuTvsrLgYtTz/No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X12ifZwU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TiCB6k4y; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X12ifZwU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TiCB6k4y"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id D1DF7EC01C9;
	Wed, 25 Jun 2025 11:03:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 25 Jun 2025 11:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1750863836; x=1750950236; bh=xizTeJ/+Uy
	u2j4uKN0Rids6xH4bCX76r/7L/26WgO7s=; b=X12ifZwUwQwkmkBAHhrVQ659dg
	s52qKtvAzgu52E8uLkJatpZaJOH7fTO/DbN2jdgKAFp915G3sYxl/qvZcXuvhbyi
	6I/jJwxoMv5vVQHpnAH70mTiZ2Qk+1HfZCs2cmCJgKhutouhxxym51eC4RBOVTnW
	oc9ycaius7pb0RW+UxPAOIHlACTbRPit6tK5lb7xBEqjkMr8fkIIzkVZiphBm50P
	a+tJ4XsahPTTJn4N0fKIieF3Qdzffr94Kc78SbLnIJL/gIXAiRzx9WKN92EwWEjq
	wVjCKbM/hyNDEX87Rs07NR5mLRXQWc/2kNIx0sDT0vLwMz5x2V4h7LvfaWlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1750863836; x=1750950236; bh=xizTeJ/+Uyu2j4uKN0Rids6xH4bCX76r/7L
	/26WgO7s=; b=TiCB6k4yXzzN//aXGR1Ya2EfFvAHggbWeGSTxfMtnkoKg0sXsoG
	ZyYIuUZnAo0ipa9TxA6pj36vvOPeVVQxSmiPoyYFNfgQ2NoyCBRkwUD0UFhPm1Ut
	mED5LU/AtFyq73HWO0a33GllXU5LFToWryJiYuiZHQ4niwxf5WhhxEVWr+wyHLXG
	fa0ihUkgvWEe2eTpata/zf0nadExDxAPZFTWAm6+k0qxk5y1MhhdThwyEOKOeK7C
	LNkoMMW/eYqT8pea2Jj1+A+msX+nS1xE22hsQGZ3ESk6sbhXxHXRAPHkEGwlVgZd
	sAKHSi5NQzIteY0wCOcpfG29JxnMHIZztqQ==
X-ME-Sender: <xms:3A9caCqHkQo07g-cKzBOsz49v4eGrOQOhSRo-8QGWIS0xvDu4OCWDw>
    <xme:3A9caAplFI7ylhy_CsjQ9vGN4RVkx5oKFTY8p3anHgF8wSQ6yLCCWgqtgFD5lL_YO
    ZN5s6AZst7I_p1HXg>
X-ME-Received: <xmr:3A9caHNZDpoSJvjFWtAAuxfoDZcCY6rnj0QwvlrQzHkw9Gtxvy_gaCBDWgtoeoufgkt-iJUqyCVyHTSSrv2Wx5KJ81z-z3H13MDgDwE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvfedtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:3A9caB7UYPF6Vf5G0uW4-aZaW32BgvZQ3MSIt_bzYp-Qlgmx-y8xBg>
    <xmx:3A9caB4JuZAREzctdIvyT6LgJ7lT3o2eKF6tTEj2Craw6D4g3VDtqg>
    <xmx:3A9caBhyiMmZmy7Ulo_dCucbrxpFCB8yxYUJava9AuH-s5mQzOskaQ>
    <xmx:3A9caL61V9aPyW_xS2LeLVRtiFlARr18U_ZJqRz6B_u37nulywKJBQ>
    <xmx:3A9caEXBImzcwUAVEB0FeWO3XIVEZiccG2-ntnl0IgakxfD9I1wjkAe5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 11:03:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2025, #08; Mon, 23)
In-Reply-To: <CAOLa=ZTXQewoVKLk6DfO79Q9R5keDOeEOWOt9Ejp4O_RQ0Jq8Q@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 24 Jun 2025 18:29:25 -0500")
References: <xmqqtt462bye.fsf@gitster.g>
	<CAOLa=ZTXQewoVKLk6DfO79Q9R5keDOeEOWOt9Ejp4O_RQ0Jq8Q@mail.gmail.com>
Date: Wed, 25 Jun 2025 08:03:54 -0700
Message-ID: <xmqqecv7zwv9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * kn/fetch-push-bulk-ref-update (2025-05-19) 4 commits
>>  - receive-pack: use batched reference updates
>>  - send-pack: fix memory leak around duplicate refs
>>  - fetch: use batched reference updates
>>  - refs: add function to translate errors to strings
>>  (this branch is used by kn/fetch-push-bulk-ref-update-fixup.)
>>
>>  "git push" and "git fetch" are taught to update refs in batches to
>>  gain performance.
>>
>>  Tentatively kicked out of 'next' to give its fix-up topic a chance to reboot.
>>  source: <20250519-501-update-git-fetch-1-to-use-partial-transactions-v3-0-6cdfd4f769b9@gmail.com>
>>
>>
>> * kn/fetch-push-bulk-ref-update-fixup (2025-06-20) 3 commits
>>  - receive-pack: handle reference deletions separately
>>  - refs/files: skip updates with errors in batched updates
>>  - Merge branch 'kn/fetch-push-bulk-ref-update' into kn/fetch-push-bulk-ref-update-fixup
>>  (this branch uses kn/fetch-push-bulk-ref-update.)
>>
>>  Additional fixes to the base topic.
>>
>>  Comments?
>>  source: <20250620-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v5-0-f35ee6b59a82@gmail.com>
>>
>
> This was reviewed by Christian and you. The latest version addresses all
> the comments, do we need some more eyes here?

OK, then.  Let's move the commits from the latter on top of the former
and mark the former for 'next'.

Thanks!
