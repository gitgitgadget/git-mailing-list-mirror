Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBA91F0E5C
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 18:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741025892; cv=none; b=rkOjJWNwFIq1xRDhyRzosuzFyEW9JlyWIJfy/5qY0aiDAlS/HZAW6MNCk4VECFcwJkgWc4zzqRDcFg1t1PxzO0NM8ANAFl4qAeca/fDAztwxiCGOp7O2EDfXbPUrOKsi79JeHfRkpBxBpUfWjhDidzJXDdMxy5SH1SCw9nAN6JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741025892; c=relaxed/simple;
	bh=cYNyMauRo/KXDsFZUoNDHTPXYUJZd/OmBG6aFOXFxWE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mcb7m6qcVNN2oeEtW2peWSav1+TeZNlJzs8NUqWRLYLfptRBWCnIrDQYr32lH3MbbTKwKhA01zr5hfb2IHePDdTZX/GH6X6pzPwwsqR/JJXljw7GGNHV9eMsMCxWpKNlZsxqLEkLjJ6zRkoDm8hHKJWAF5BA1VYGthGCvFlD9cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XOnBKpY5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GzWJhXEU; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XOnBKpY5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GzWJhXEU"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 14ACE254030B;
	Mon,  3 Mar 2025 13:18:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 03 Mar 2025 13:18:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741025888; x=1741112288; bh=daCl22CPCp
	isEouLyz/b71gGroKt90znYrNcKzaiwg0=; b=XOnBKpY5dddOW4MbVsw4XIFwg7
	rPnFCPOgUdi+eo/Otvimb9FFVK6rHK2kiY8pahAqX8FbdjZwKaTAMjY4KKV7V4JM
	XYct5ckWrXgsBq2pqOCVqZnW78yZBwu4T0r8GUx7dWQTmmq7Nd+M8F8C7VC0T2sL
	9ub12mk1IHjdoWw0FwnmkRIRwkGNqr32+M1u/ttSJ6hCKm55CLqkoom6dPVaSfUq
	343WCpeDZ2BBR4HTwGv5YPfT7vyxCv7CEHume/Hy8t1NsbPkpPpq0mF7c9KIBm9t
	PMXsrsqFk+NDKJjD+bxCvLW2QbIwoWNVjf7Dc5GGp7QaET1yVc2lQ0V64klw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741025888; x=1741112288; bh=daCl22CPCpisEouLyz/b71gGroKt90znYrN
	cKzaiwg0=; b=GzWJhXEU8BTEDuP3LBkBwvSXhgqRohvXV121NdknX5Gw3lD46AR
	BrJM/N9BU37DFeJKxYoE9GILA1GUTEYZXgKUPuYA9ClbDDa2mZM613HQbIl7tZun
	fn+s3B6MiIJAesdsLxjjlw5JQmRr3tFqitek4Qrd5XwJwjidKBpNB+kX8kP18IZp
	0j3Y93HFwFnx0aoZfZZnbYzjOVYCBt0icyg/p9VlkPMRr/NrSh2DrTcSst/u9aNX
	ht1ylLQufzcIHqemXc8VBhINVezd2mEHN93b7jocYTqvObHYo1xlFSbh67Ws5pE9
	NBuXJ4zfeTFTSTKw+qRLHt8aSecUlY8pPmg==
X-ME-Sender: <xms:YPLFZ1aKCG9yJXZ08WiAXqHSs54atHqmsJD9B8wpxs3ATeyfnm5pEw>
    <xme:YPLFZ8ZGKlaCo2VuRcA232nwJmLoDgl-QIkXhSHPk4TYsDi4FAdOPlavmi1Kz4vSF
    HgAboCS-NOlI24bUA>
X-ME-Received: <xmr:YPLFZ39efpVwUuJFhsL631yX7PwcGckzuYKgM9Tc_nzM4NtokHC6yTecHHAz1y9MmnxnZR2Vf0QC1FfKAh2KCdZixNSanL6HwiF2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehphhhilh
    hlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:YPLFZzrCq7MA-Z9lQwHVJw8Ta0SZx9MPJebxqgFAroi8xpq6ipxmyQ>
    <xmx:YPLFZwqTXWYg3rYJKn7FX9PL-IuhheO-yKl7Yj7jx8LPqcmbhnro2A>
    <xmx:YPLFZ5QzEWJCLUiWDp3DK1fPKQaqABmrSM3P_3VVtgT8yiELT5iRww>
    <xmx:YPLFZ4p_t4wpZm6Wagn_1I8sWemw9ktYqDKlYBCjCzr19K3brharYA>
    <xmx:YPLFZ1C-9heZSPuNL6FJdcIncZVeGm1EXZB7D217yeapq-NHdJ6fl6Wh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 13:18:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] docs: fix repository-layout when building with breaking
 changes
In-Reply-To: <pull.1871.git.1741018310447.gitgitgadget@gmail.com> (Phillip
	Wood via GitGitGadget's message of "Mon, 03 Mar 2025 16:11:50 +0000")
References: <pull.1871.git.1741018310447.gitgitgadget@gmail.com>
Date: Mon, 03 Mar 2025 10:18:05 -0800
Message-ID: <xmqqbjuivuzm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     I copied the name from the test prerequisite as I didn't want to have
>     different names for condition used in the tests and documentation. I do
>     have some reservations about the naming though as it means we end up
>     having to use ifdef::!without-breaking-changes[] or test_expect_success
>     !WITHOUT_BREAKING_CHANGES to document and test breaking changes which is
>     a double negative.

It was exactly the first thing that came to my mind when I saw the
change to the Makefile in the patch.  Unless our breaking changes
are all removals, which is not likely to be the case in the longer
term, "without-breaking-changes" would be an invitation for
confusing double negatives.

> +ifdef::without-breaking-changes[]
>  branches::
>  	A deprecated way to store shorthands to be used
>  	to specify a URL to 'git fetch', 'git pull' and 'git push'.
> @@ -164,6 +165,7 @@ branches::
>  	"$GIT_COMMON_DIR/branches" will be used instead.
>  +
>  Git will stop reading remotes from this directory in Git 3.0.
> +endif::without-breaking-changes[]
>  
>  hooks::
>  	Hooks are customization scripts used by various Git
> @@ -231,6 +233,7 @@ info/sparse-checkout::
>  	This file stores sparse checkout patterns.
>  	See also: linkgit:git-read-tree[1].
>  
> +ifdef::without-breaking-changes[]
>  remotes::
>  	Stores shorthands for URL and default refnames for use
>  	when interacting with remote repositories via 'git fetch',
> @@ -241,6 +244,7 @@ remotes::
>  	"$GIT_COMMON_DIR/remotes" will be used instead.
>  +
>  Git will stop reading remotes from this directory in Git 3.0.
> +endif::without-breaking-changes[]
>  
>  logs::
>  	Records of changes made to refs are stored in this directory.

The above parts of the documentation getting commented out all look
sensible to exclude in a build that omits these older mechanisms.
But can we do it with !with-breaking-changes instead?
