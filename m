Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08D51D516C
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 00:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764031420; cv=none; b=C624m1ddZDfXdTcUNIvYArMY4AU82xcNsjIwF7/rP1JLDvcBy7IMe5BJwCX4+vcaSUQkw7pjHDdQw9eRfSkv4xBt8NWZp+yxb/Y5UtqOl1BZ5vd3DOop5GIYB+xPrFW/0G+sWdD73x1JMrZ3i52w6uZXSoneMpwnt1tJa4UcAJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764031420; c=relaxed/simple;
	bh=d6BKq9jWr0+Z0k50EB20C3s4bcX4LKATH4WrMss6SUY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kjtihTPOCb39Du+QPh2LN7X+u+MeC90KVVtVGMdGB1+OYlvJP5YzmQY35LsTi3aiBGjdu2OMuua0V+Y4A7cf5U2IjCvGzOnknG6Siqa3i5hmiG//2hKqzlcoMsBNuhYWAKxWBXoWB5WTcRXV1UK+A6Stq5BXjEvvbQTvoKBfd74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QROSBZi8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZhGXxRe4; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QROSBZi8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZhGXxRe4"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E622C14002AD;
	Mon, 24 Nov 2025 19:43:35 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 24 Nov 2025 19:43:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1764031415;
	 x=1764117815; bh=FTnH4xMnBdgayLstH75uQ46PFZwZmmf8e5VrtFL3JPU=; b=
	QROSBZi8P6y6DrX9UQVvjir3jAPKb0xZDosXp3Jw4/FBeJSrF4nfu7loH7hLAf3B
	FXea7Ek+GDsTzFoPtuxTCD1YqhImDgki3/23yMmMJveT34vdk8tF1Wnpv4fDSf94
	uY1fLICy/ktH4whiHIecyNqLV8G8a8bi5RoCwzhqR0X8OLdOo9a7V95IS4fKgtk6
	sOyYatBuEnCNzcqQEakswOTKzIVCziTZkigKCwskqHiEpkjS4PcElBTfbgxnYRW5
	0ozjGXfMEV3hI/vGtt2+BwgbU6Nh5eg68E6W2xx9ZuzrYAIMfEg7kLn9nLjXyQUA
	Avob/4wUAhhawnu30IayYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1764031415; x=
	1764117815; bh=FTnH4xMnBdgayLstH75uQ46PFZwZmmf8e5VrtFL3JPU=; b=Z
	hGXxRe4hwqNiyCh+FlPLtatOCIloBexsb2lSKBuqRuDYLIjuUlMYpL9APZ+3cI2F
	Z2cst4BXUZc0yOjsi7tYM/SB+RiTxSe99gepg6EqcgpNLq1SQ/ePAxVSRsC29QOD
	HvnM6QrK9GWNNWDCFVc6saJH3Xkp1TyHHkCV2jk3TOcf/ZITtV2WCLgeL4InU0SD
	Csv4P0oQxU12aFclmLhQ6Msf0pQnTZGocCOIVp0YozEFs2VF8Qt1ke3MgsUFavQ8
	JY1c4TL2BEV3Bn65lPTgGxRr7+0JdKlh9YfNLmUbX6EAHBJHdfgw/oGAXB1zXVI/
	nF/bmVgzcMRj/rE0e30NQ==
X-ME-Sender: <xms:t_skaQyRVIB94MSCZMsbSVBfuVoIxRLUS4Erf-NUdDMZRUzsVGVEug>
    <xme:t_skaWiOMLwmKAObC--WYGRIV4KPPyfiy91wzH3mfBe8YSpGfbt5-1VcrE8sHAC6W
    9ulB-1-knU0nS_E7IY8ZTeOJ9mXQ5zCHLlhyZ-bBzqAM8puXttH>
X-ME-Received: <xmr:t_skaUnuwSO-ySAKBoEP53d1vSi6uBwLshNLWa6aXH696RsUVkmLiu286HWM9PO2uMiKupLAYxfwbs1O0ciFEAlOJvR7GedHffGH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedttdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepshgrmhhopghpohhgrggtnhhikhesthdqvddrnhgvthdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthho
    pehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:t_skaUh5o_3jxktj3JOwdwHYYV2zsWaWam6lAAiQ1tIsEpdY8JxRKQ>
    <xmx:t_skaQ0opmPbNYR7SRXM3gLOGKZ4nanVq2ybIV9liRJWVYFNanPeJg>
    <xmx:t_skaVIbBDoW1Giu8_oM77pCl9Mq07jEPcW6oLwlJZH-5IPUhHnKuw>
    <xmx:t_skaYypvSOffHa93Xhnvw886fKRnKkWvZ5hwkMB9gOvr7YzjvLnhg>
    <xmx:t_skaYHXETa8ULKXFQyIYOmKanMB0qCYl_iJRGJspzwOCF-j58JAkCNK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Nov 2025 19:43:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Samo_Poga=C4=8Dnik_via_GitGitGadget?= <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Samo =?utf-8?Q?Poga=C4=8Dnik?=
 <samo_pogacnik@t-2.net>,
    Patrick Steinhardt <ps@pks.im>,
    Taylor Blau <me@ttaylorr.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] shallow: set borders which are all reachable after
 clone shallow since
In-Reply-To: <pull.2107.v2.git.git.1763926552033.gitgitgadget@gmail.com>
	("Samo =?utf-8?Q?Poga=C4=8Dnik?= via GitGitGadget"'s message of "Sun, 23
 Nov 2025
	19:35:52 +0000")
References: <pull.2107.git.git.1763807914242.gitgitgadget@gmail.com>
	<pull.2107.v2.git.git.1763926552033.gitgitgadget@gmail.com>
Date: Mon, 24 Nov 2025 16:43:33 -0800
Message-ID: <xmqqh5ujuekq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Samo Pogačnik via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: =?UTF-8?q?Samo=20Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>
>
> When shallow cloning based on a date, it happens that not all
> shallow border commits are reachable.
>
> Original implementation of a generic shallow boundary finder
> based on rev-list sets a commit (from the initial list of border
> commit candidates) to be the border commit as soon as it finds one
> of its parentis that wasn't on the list of initial candidates. This
> results in a successful shallow clone, where some of its declared
> border commits may not be reachable and they would not actually exist
> in the cloned repository. Thus the result may contradict existing
> comment in the code, which correctly states that such commmit should
> not be considered border.
>
> One can inspect such case by running the added test scenario:
> - 'clone shallow since all borders reachable'
>
> The modified implementation of a generic shallow boundary finder
> based on rev-list ensures that all shallow border commits are reachable
> also after being grafted. This is achieved by inspecting all parents
> of each initial border commit candidate. The border commit candidate
> is set border only when all its parents wern't on the initial list of
> candidates. Otherwise the border commit candidate is not set as border
> however its parents that weren't on the list of candidates are set as
> borders.

It is a minor point, but there are "boundary" and "border" used more
or less interchangeably in the proposed commit log message, and
would make the readers wonder if there are differences (I do not
think we use the word "border" anywhere in our documentation).  It
is minor as we do not have such mixture in the end-user facing part
of the documentation with this patch.

I'll let those (cc'ed) who may be more familiar with, or, at least
have more code than I have in, the shallow infrastructure to comment
on the way the updated code uses the revision machinery.

Thanks.

> diff --git a/shallow.c b/shallow.c
> index 55b9cd9d3f..2929ac90ee 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -251,21 +251,57 @@ struct commit_list *get_shallow_commits_by_rev_list(struct strvec *argv,
>  	 * commit A is processed first, then commit B, whose parent is
>  	 * A, later. If NOT_SHALLOW on A is cleared at step 1, B
>  	 * itself is considered border at step 2, which is incorrect.
> +	 *
> +	 * We must also consider that B has multiple parents which may
> +	 * not all be marked NOT_SHALLOW (as they weren't traversed into
> +	 * the not_shallow_list from revs in the first place). Because of
> +	 * that an additional step is required to reconsider B as border.
> +	 * A commit from the not_shallow_list is considered border only
> +	 * when ALL its parents weren't on the not_shallow_list.
> +	 * When one or more parents of a commit from the not_shellow_list
> +	 * also come from that list, the commit is not considered border,
> +	 * but its non-listed parents are considered border commits.
> +	 *
> +	 * The general processing goes like this:
> +	 * 1. Above we've painted the whole not_shallow_list of commits
> +	 *    NOT_SHALLOW.
> +	 * 2. For each commit from the not_shallow_list (the code below)
> +	 *    we paint SHALLOW this commit and its parent for all its
> +	 *    parents that had not yet been painted NOT_SHALLOW.
> +	 * 3. Commits with all parents being painted only SHALLOW remain
> +	 *    shallow and are being added to result list.
> +	 * 4. Commits without all parents being painted only SHALLOW are
> +	 *    being excluded as borders, however their parents painted only
> +	 *    SHALLOW are being added to the result borders list.
>  	 */
>  	for (p = not_shallow_list; p; p = p->next) {
>  		struct commit *c = p->item;
>  		struct commit_list *parent;
> +		int must_not_be_shallow = 0;
>  
>  		if (repo_parse_commit(the_repository, c))
>  			die("unable to parse commit %s",
>  			    oid_to_hex(&c->object.oid));
>  
>  		for (parent = c->parents; parent; parent = parent->next)
> -			if (!(parent->item->object.flags & not_shallow_flag)) {
> +			if (parent->item->object.flags & not_shallow_flag) {
> +				must_not_be_shallow = 1;
> +			} else {
>  				c->object.flags |= shallow_flag;
> -				commit_list_insert(c, &result);
> -				break;
> +				parent->item->object.flags |= shallow_flag;
>  			}
> +		if (must_not_be_shallow) {
> +			c->object.flags &= ~shallow_flag;
> +			for (parent = c->parents; parent; parent = parent->next)
> +				if (parent->item->object.flags & shallow_flag) {
> +					parent->item->object.flags |= not_shallow_flag;
> +					commit_list_insert(parent->item, &result);
> +				}
> +		} else {
> +			for (parent = c->parents; parent; parent = parent->next)
> +				parent->item->object.flags &= ~shallow_flag;
> +			commit_list_insert(c, &result);
> +		}
>  	}
>  	free_commit_list(not_shallow_list);
>  
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 2677cd5faa..12209887fb 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -904,6 +904,25 @@ test_expect_success 'shallow since with commit graph and already-seen commit' '
>  	)
>  '
>  
> +test_expect_success 'clone shallow since all borders reachable' '
> +	test_create_repo shallow-since-all-borders-reachable &&
> +	(
> +	rm -rf shallow123 &&
> +	cd shallow-since-all-borders-reachable &&
> +	GIT_COMMITTER_DATE="2025-08-19 12:34:56" git commit --allow-empty -m one &&
> +	GIT_COMMITTER_DATE="2025-08-20 12:34:56" git switch -c branch &&
> +	GIT_COMMITTER_DATE="2025-08-21 12:34:56" git commit --allow-empty -m two &&
> +	GIT_COMMITTER_DATE="2025-08-22 12:34:56" git commit --allow-empty -m three &&
> +	GIT_COMMITTER_DATE="2025-08-23 12:34:56" git switch main &&
> +	GIT_COMMITTER_DATE="2025-08-24 12:34:56" git merge branch --no-ff &&
> +	GIT_COMMITTER_DATE="2025-08-26 12:34:56" git clone --shallow-since "2025-08-21 12:34:56" "file://$(pwd)/." ../shallow123 &&
> +	cd ../shallow123 &&
> +	echo "Shallow borders:" &&
> +	cat .git/shallow &&
> +	$(for commit in $(cat .git/shallow); do git rev-list $commit 1>/dev/null || exit 1; done)
> +	)
> +'
> +
>  test_expect_success 'shallow clone exclude tag two' '
>  	test_create_repo shallow-exclude &&
>  	(
>
> base-commit: debbc87557487aa9a8ed8a35367d17f8b4081c76
