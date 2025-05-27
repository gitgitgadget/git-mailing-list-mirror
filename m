Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE16134CB
	for <git@vger.kernel.org>; Tue, 27 May 2025 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354170; cv=none; b=a/VzAAOpS7L4b2BqV5ATDfbQs5JjHRkljAaVUqWMeabWiS7AEqvnuF+WqCvuNwqVxiVLvt0D5SAEmYWE4ul7WNUTU3KlBf8gUPVfshp1WPNy8z1zRqDJ0SezqG/5vIFftFKS2MmtkWjNk1/xD7k2kzGp2XqcdILyehK5x3XUWyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354170; c=relaxed/simple;
	bh=GtS0uye+ZPniFJ3VvfjVatyZBbPe9Qz0A1zmuCl0cmQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kwkJksm0ojH3Pom+tj4/bihwiKRKRLhOTa4/cHqT+i5W1q0xEca3cwGlp0W9z7DhtxKtncVcWEVcsxZGLA6bZVZJveueRq88BryxJfZKo3qV19/CFKwp313N3msAxeMz04bpTogauQ6lysWyZeBNibXV9TLah+tYox36acF21PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JKuc3NBc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V+7dmVOK; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JKuc3NBc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V+7dmVOK"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 314FC25400F7;
	Tue, 27 May 2025 09:56:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 27 May 2025 09:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748354165; x=1748440565; bh=JLx4erodqT
	jRn7n5qd0zbLtRXkPQfnlFCV4P4O+ngNU=; b=JKuc3NBclF7dIBgOvQg4MX/o4S
	Ggw2XHgocTa4rTYLP1JxeilM7vBHKxiE4U5/ljSqfqSdJ3ybK0wZ9nUuwziQCQqO
	r0vIPP3OnNkKFbPGFGP9JZcqzAu9EjsM3FM9ik+IQIE925TlNc2qPMrIGScsjrli
	1RJ/3RwQfRqqWucguxQpOtr78AGt2jIl69gPT3euCzV6LPRhaS+lY71F2cHhzeC6
	Se2LNdH+oWCxqM2MSFoTrO45jMhaDhokyu7CUzsC+Nln16qB5iiwi8FV1LoejLEe
	cNMy9PguDP92ZlwdAJH/gy72aMrMTXPOKiidCPIURXQEsvL3lucLgqUpWFdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748354165; x=1748440565; bh=JLx4erodqTjRn7n5qd0zbLtRXkPQfnlFCV4
	P4O+ngNU=; b=V+7dmVOKokkDyZEayv99VKlfpg+K2Pzlz2t/J2tsP4mKycfRcWx
	BbVn4dWiaJUR2UCLnXa6NRjRvvFP8hzsOc03OFbuk7fvY5LvOIwLu8DxQnnkCb4L
	NxfHCWKnwUtXVtKKMfPd7DFan1Owj6Amlr1aR0tYYgDLfI21lLmTM6LppRv3GFmY
	/CvJkCebzTNED/R81lK1MBh/9QVavb3odktx80g5ohEda6W5+rRVGJJUA3Ft4grQ
	OfdOIouUu260pWbURvE1VNYlJv1L1LrWRtEXVKC02mBHJ5QofqYT/fC/OLDUwPYj
	CQ86pSnt+OjNvr9pfXnxw0Q5znPmYCzz1Tg==
X-ME-Sender: <xms:dMQ1aNcdD_smfLQQ8rXlze_zE4rvoE_r_7TYjf5ZWaRfCxkUiFrTXg>
    <xme:dMQ1aLP6aLYRIFx_UCD4bgoiRMMBRnOnbNPyTW_XgNWFAwQ4giS9QJK9ictsUeTIJ
    It8Z46d0yXw-RP61A>
X-ME-Received: <xmr:dMQ1aGjoU0qcSe6vfduCoTTY1DlZE5Dx0_HEgihZWjhDAwOET78elOxVNjWrdp1754kBAPBWof-GzfAD5FyUOnxzfaWA8t-HnD-U7mo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdehheculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehmrghrkhestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhgrnhgurhgrphhrrghtrghpfe
    ehudelsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhn
    uggvlhhinhesghhmgidruggvpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:dMQ1aG_QSr3VwQZ-CmBOF-N6wXY8PBpBtE2gkeA-yb43s9kIAHvSwg>
    <xmx:dMQ1aJs9tnT0kjo1z69S_1f2uU6kt-h6LHP--8Cl7Yj7gk--E1GGcg>
    <xmx:dMQ1aFEZvCKIcH_5DuG7x19zWWHQw0HPNbqNbNMkge1jjZEZr8JhFw>
    <xmx:dMQ1aAMfH9BqIVrRJzuDPpZf_xErxefGH8K_EKEjR4fdRKveUfLWhg>
    <xmx:dcQ1aFe0p3-BkitmxoyIqGXJozDnJON9UcZ2rI-EpghxTicOOVohGjMA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 09:56:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mark Mentovai <mark@chromium.org>
Cc: Git Development <git@vger.kernel.org>,  Chandra Pratap
 <chandrapratap3519@gmail.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 0/2] apply: set file mode when --reverse creates a
 deleted file
In-Reply-To: <20250524034046.2619-1-mark@chromium.org> (Mark Mentovai's
	message of "Fri, 23 May 2025 23:40:44 -0400")
References: <20250523172154.93810-1-mark@chromium.org>
	<20250524034046.2619-1-mark@chromium.org>
Date: Tue, 27 May 2025 06:56:03 -0700
Message-ID: <xmqqv7pmrwcs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mark Mentovai <mark@chromium.org> writes:

> Changes from v2:
> * test_file_mode_common correctly fails when requested to verify the
>   presence of a file (by nonzero mode argument) that is actually absent.
> * Test setup establishes tags at appropriate checkpoints with git tag,
>   and tests restore those checkpoints with git reset --hard, making
>   tests less sensitive to execution order and to the success of previous
>   tests.
> * test_file_mode_common accepts full 6-digit file modes instead of
>   4-digit ones, and uses 000000 for absent files (as git diff --raw
>   does) instead of an empty string.
> * File presence is assured with >f as opposed to touch f. Minor style
> * fix at the point of test_file_mode_common's declaration.

Nicely done.  Thanks.

Will queue.
