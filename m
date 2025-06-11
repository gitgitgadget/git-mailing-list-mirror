Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A56D2D542C
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 03:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749611560; cv=none; b=c+Um8f/DCtxq/LEaA+vGywTn7bPvxHXFAj0ruH9JPrukF/dEuAJXduNR5vzxrgby2yA/rksqGS8YMfTleHf/cXt/s2mNhInH2TBr7UCAB/DZsGSruSyYBAbb7g84E6g0iGrxQnrDgndNG8ivWrA7QpZ500eoDQ+qXm6ph2kkMP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749611560; c=relaxed/simple;
	bh=68zvXks3ax++GikyKPqZ1ozyi3+TGjOKTLfi6v5Ijwk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JTl/MXM4QpNZKy/P5AgsBqfhRpgLR7RUy0Bb/fK2Qs+NwpxGb2TmT9TBqj/xFm8pAzcEI6B7T8UIiyhyFZ9EAY25k0cF3ja54z4lL2yXu1kYcQh7he3MMLhdHmWnUlxtPWp9xZpV1JptFWqKQHZcZJYN5ll7DgRwZbao3tXxDDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZP+tpCFo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ap1Rgah6; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZP+tpCFo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ap1Rgah6"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 10DB413800EC;
	Tue, 10 Jun 2025 23:12:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 10 Jun 2025 23:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749611555; x=1749697955; bh=wzBDTQpGGU
	sRFOwnAAa6GK9G/kTJiKSlXTFx9T0qec8=; b=ZP+tpCFoN14HkpipcD3APDrf4n
	yNRwMrkJ6CjLmMF06q31ySx73Eiq1YWM6tTcnsL7OR/+HQsTpfJwQ5rpdQvK+otP
	G/t7HQqNJYoabNvGsnzcMnHg2xp+tXx4e+V7ZF+XjMKabNE/vPAJt28TnmYVuLJ4
	4QjkZN7gnMPeYDNioJPVBA4/23Sb7nG5ghO46NS0JncrpTr8L5clLM27843V2kMh
	efSBSJOzmcBnHEbU5uzG2yI56lgOXZ9ZJcr5C0OqPFf5Fd8Nz/rJFSQBB7nidVCA
	HgD0s1yDENRRW7rEo4xl7qPZiIgnLhwI75d2e+kVEFoWBxYpKDEiG0ooJilA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749611555; x=1749697955; bh=wzBDTQpGGUsRFOwnAAa6GK9G/kTJiKSlXTF
	x9T0qec8=; b=Ap1Rgah6gaEJJJ6d2hn7HbPqO8qSGPe47Gqt1FbMGEedcqPDmQ+
	zUgJJ8jigjNVb1a6bHyr24tDAPAP97+eZWNx/qwm0Wyfq3DofOAFBHXSFl9Bdpiz
	v43R+ES1hG4C4VoXl6a717jAj8zgUD+s1lzK8TSMdWzGIU1oEv/Ci3xi9xksqaw3
	b4WbSW9snFJd7XTpzLAgMFqRB4TqUPGzhIXucC9xdDsE9rBxz/PDgluBmnN49n1k
	AXgQXcwzfNCsaSr+YGHgY7mdM0icznlQ1Ra42kXwS9oJyndxHsEVoCoR+UKyu0kF
	1NxJbSyDjdL51uhWizwDD2aLNGNiuJRlU2g==
X-ME-Sender: <xms:IvRIaCTbEasJ9y1-Xp2XzgccpuywyxlA3J1Yz8FlIigbJ38R95OuoA>
    <xme:IvRIaHzComYO2JvSDCweu4vfIMmbRVc6cp_xDhjSbsAsedNnKfVPD85bz91mQ61-C
    nqXgDwYX-h5vkz3yw>
X-ME-Received: <xmr:IvRIaP2OuLdZU6vZHizfMyvpv9AoDSl1ZfoCDAnTihzNMck33p9rHFoQGH2JZdkwimFAbYDUn5Lq4vUMRkFVNoMVBVN9lkF_ydgo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduudeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosg
    hlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:IvRIaOCbK4Y80Fn_f7a3QNECMmtwoL_NZVjA4meAJaBrndKczhdUhw>
    <xmx:IvRIaLhiYH3tWDDM0fHLNiVGzs7-RtLJx20WbRsK7lVHf-PVDSPoSg>
    <xmx:IvRIaKr0QQ1m9liZxk0MYi4eekwikqQzNL0bDusOzVBpaJM7vlHGow>
    <xmx:IvRIaOh5O1LfApZZkMMisnPb0GsJc0nJitsEedItGGhh4Jz5hKgbyw>
    <xmx:I_RIaDehj7oYpBp9LWRq2asSsOoNNeHq-gB_8ZUhVvg8juDVYFGnBJxe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Jun 2025 23:12:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] merge/pull: --compact-summary
In-Reply-To: <CALnO6CCnjP2XnCw1CwyXztkHHMv-U4zrvf8_m2X4-isvPL3ygg@mail.gmail.com>
	(D. Ben Knoble's message of "Tue, 10 Jun 2025 17:16:29 -0400")
References: <xmqq5xh6xlpm.fsf@gitster.g>
	<CALnO6CCnjP2XnCw1CwyXztkHHMv-U4zrvf8_m2X4-isvPL3ygg@mail.gmail.com>
Date: Tue, 10 Jun 2025 20:12:32 -0700
Message-ID: <xmqqzfefj7j3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> Does this suggest that we either want a "diff options" option (or
> config), which would be more general?

If I have bk/new-topic branch, here is how I would merge it.

    $ git merge --compact-summary bk/new-topic

but there is an existing merge.stat that (1) is a mere boolean and
(2) is true by default to force use of "--stat" option.  We could
extend it to "bool or the string 'compact-summary'" and when it is

 - not set, do the "--stat" as before;
 - set to true, do the "--stat" as before;
 - set to 'compact-summary', do the "--compact-summary".

With such a configuration variable, "git merge bk/new-topic" would
be how I would run my merge.
