Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5404414
	for <git@vger.kernel.org>; Fri, 26 Dec 2025 04:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766722559; cv=none; b=PgJOJlnUC6NjjGSORvhFzOqsqs4QeKx9fHD/Tc589Q1iRkfndDGMjRvs5/UQda77W0yhWmc4txhjQXKDz/7h7r7Zpmg26V4AH8qKFy8xAp3/KgYH5mX/G9jLUQZ8mze96Luw+fOgMtWpmowNdNzc5+HV8oyQOCnZVDV7+Z72lvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766722559; c=relaxed/simple;
	bh=Nbgp09dMKh2sc95Kub6mfvFDk4ETbWu/p/R1MQgVXek=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pK2QcIhJluFPxWli63SjZKnKaQxtF0h2wvSB/4WfMqDkv8GbHohUTp4XuKpMSdkwu4FE9HM8X78C6PF/Z95qsQz2pIr22MJN65s9k8dxiRtL8IoDltq/wEBUBbwe+MGBN57IXuddbkvfUS3/Pe7H1AEu5wjQDPknYvZJtREbK3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iaZ3hpSz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jSma/pex; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iaZ3hpSz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jSma/pex"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0936B7A00BE;
	Thu, 25 Dec 2025 23:15:56 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 25 Dec 2025 23:15:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766722555; x=1766808955; bh=IEBzxMLQJ0
	2Zr8x52gkluLQfVPhzqSxgSG70dGUdo3k=; b=iaZ3hpSzQYTG8suJ633tCrDiup
	eD3Hd6neVDs72BNRNWuifQzamJRJ3CkoIxzl3+RdQDtdTmQ3KBlQBHpV44EiryAr
	ElAour8r/4kWoj6n5lew/sMQMohLwDwBXm310RA6zD6q2wCkrjPBvQ0LMO7ubbHw
	L5/OD2ZzIWUav+nkLI0PtOba581Ve+ccy/z0OsR9GOVKbi+cRXkAPMoZGmgwwQSt
	wm0W8rvBah7iSRCnQVD7g0lxqzhMp6zM0EIbYiLXKyyPqTP+OvVJdlqwkdZq3SbI
	i2/hUumuQOxdiHuGLHLAAekTotRhyCnUIeCva2ByoshsVAAFJj3G9z+v3OEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766722555; x=1766808955; bh=IEBzxMLQJ02Zr8x52gkluLQfVPhzqSxgSG7
	0dGUdo3k=; b=jSma/pex2pEJhWwnqNLcExEPe+mxE+oTLosM+JP1vOnX4Mwl5NC
	yyy98G3nnZ7cAAfjPVrGbWmVJKcDuTRl3OBYaIbgwDU4UYbM0kNl3XpgO85sGFt+
	zwokwiJkf6o/tEKFI88Lo7iV4pFCM4ll8ZJAeNCH22dE3uP6zKesoupM81fzEWMt
	P0+i3TyMNXUB61PO8/yawr42E/HpPBcvGiapW7PYK2ghm9nvkF6ly6ah+NOIZ8b0
	/4TAH0XSNCLj6SOmIIYhaDfWWjw1vu0xswoRFK36B0yDcMGinYlULKM4lfK7Ehy7
	BAPjJdlMl8wWbZlkPfMr3Tkrox7MzbGDT9Q==
X-ME-Sender: <xms:-wtOaTSwt15Q3UuNB0EZaQ_KoW7UFQLy4byubGtZ2rjwNR_uubaG5A>
    <xme:-wtOabx-o0cVXczDJ5JT8QWab9xxcR6OHgKC1j-BXOOSU7zMIqweVD3bucBOvFnjB
    VXpYB38iRPCgP4nkcEYpdDyW_AmJxbrSKXifEnIjtQdULXHvRyT>
X-ME-Received: <xmr:-wtOad3rs6-JnEnM0QBSNFaguSzOuU6uug5j8h8AIHC9hP_ZIWAk0WR4vFtR4mClNVCvyqoG98NPm61xgkMFoWXmYt5alW45PQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeijeegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjrgihrghthhgvvghrthhhkhhulhhkrghrnhhivddttd
    ehsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:-wtOaR4JYGTC1et9An6wJfjZQmCiYTiR9kvC1OqP069VNTTaFPn3-A>
    <xmx:-wtOaYUL_h3IJUM3HE8ATpMidMWwBuGZ5ggZ0Jah46R6CKOWTMi7xw>
    <xmx:-wtOaYCztka4dyMNVtvqmxJMwIFTBUTElncAl7z7zcu4iJPm58EnGA>
    <xmx:-wtOaf6A-kKtgHI9NEM7ZyNWNB7Dl9dVHhCMBQDGGnysVySUIOkgeg>
    <xmx:-wtOaVWoBEqvsrqiaA-OIqSBy2MIY9zBf7PzmiNphlZqNQLWzBGkSF4r>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Dec 2025 23:15:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org,  sorganov@gmail.com
Subject: Re: [PATCH] branch: Remove unnecessary verbose flag
In-Reply-To: <20251226032804.596058-1-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Fri, 26 Dec 2025 08:58:04 +0530")
References: <xmqq1pkim1p6.fsf@gitster.g>
	<20251226032804.596058-1-jayatheerthkulkarni2005@gmail.com>
X-Gnus-Delayed: Sat, 27 Dec 2025 01:08:01 +0900
Date: Fri, 26 Dec 2025 13:15:54 +0900
Message-ID: <xmqqldiplvyd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> The --show-current option doesn't know how to handle verbose
> logic. In such a case, we want the program to die when both flags
> are used together.
>
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
>  builtin/branch.c  | 2 ++
>  t/t3200-branch.sh | 4 ++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index c577b5d20f..433c213dc0 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -860,6 +860,8 @@ int cmd_branch(int argc,
>  		ret = delete_branches(argc, argv, delete > 1, filter.kind, quiet);
>  		goto out;
>  	} else if (show_current) {
> +		if (filter.verbose)
> +			die(_("options '%s' and '%s' cannot be used together"), "--show-current", "-v");
>  		print_current_branch_name();
>  		ret = 0;
>  		goto out;
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index c58e505c43..5bb49de9c2 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -1716,4 +1716,8 @@ test_expect_success 'errors if given a bad branch name' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'git branch --show-current rejects -v' '
> +	test_must_fail git branch --show-current -v
> +'
> +
>  test_done

Thanks.

This is certainly an improvement over status quo.

Ideally, however, if you say

    git branch -v -q --show-current

shouldn't it also barf?  IOW, checking the end state (i.e.
filter.verbose being zero) is one thing, but to do a good job, we
probably should check how we got to the end state.

Since that would require a far larger change without a tangible
benefit, I'd say the posted patch that checks only the end state is
good enough for now.

Will queue.
