Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C32211A11
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 20:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738787885; cv=none; b=DI2T6ZyTxIyGSkq/XL8PyZM2UNpEHnivG+vrluOFRhL/aReTGKgqgtfuiEw5Lgsq9mbVDRX+PqUE1Wa+RoViYHE2KALXw8Jq6FVnfBmVZm9Xo/qVkKrr6dH2jYZEKcgLxFvTsOdZJ3/PI99/9EAyUw6PnAVTT0KuuYydt31zNr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738787885; c=relaxed/simple;
	bh=vZMQ9Gu6dYAXTLw8Hu+OiR+6ou7rsa9xzzZIxfU5jhQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sJRFy/q3pZQArCY6XbV3C5v+ZR1mR0Ov2jeJSWvcx4tKRlceoZkBWlTMca4IVOjtj5mgSxXt79LcNBywdMRdwr9V85XGtK3nyFkx9TsD3IAJN7kohhuS+5RJ8CxILTxIk0wT4eJ8ugp45yFLoM/0ebxPCZYcdpGFMYMKsERNUfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VPpxsyfA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wDM2pYTh; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VPpxsyfA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wDM2pYTh"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C2F5E11400B9;
	Wed,  5 Feb 2025 15:38:01 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 05 Feb 2025 15:38:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738787881; x=1738874281; bh=1RzPmsaM0M
	iDQi0NgKbb6fanhXq2WgU7Ba9Sgz+oquk=; b=VPpxsyfAMsaO9MJ/yXrATX+VNL
	8sj/JPsbTb2KSh52Nlz8ys7rdJ2b552rcciafIxDoRjFIwyzup8gG08/23CmnBUC
	BNK/zujUU+CWBEOXFyUUU4roc0XG6m5LApmvlkIhkhpXJ9a4hYvJV1fLZkIhXvAh
	K23U6kq5zgtOdM3c2kGziwpsvhzOD2YWKSgqnTi4CW8QyCOCRnDTorQjzgexq7h3
	KhKtS/KOnc2ofs+R7bM+6Go3Hwft4pHowX01Ul1p3GSIHNBWNBnJDpQB2mg5hH0T
	HYC+oP6GVyR9fE5EMJHDlSFAq7/bkQ48fH/O9lcqWPQP2L9tC6cPrzLt37yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738787881; x=1738874281; bh=1RzPmsaM0MiDQi0NgKbb6fanhXq2WgU7Ba9
	Sgz+oquk=; b=wDM2pYThi71e+/VAF5y/Zqcj6vkxOGpmpVI5eCvGZeqpvBxiMgI
	CXuGG68l9fmd73GZ9+QA6y9+Zm9FrPJkKIOqbSdXTLcc5vP7CSLZX7hR3akb0SpC
	JEbVLLErEhnG2c2ms+IlGAeXD3rKg26CDkINGuYowoJ1ay3n9mYRfRfzo/nBj95s
	NpVX8m1fN6O6KPtatStxt8sdNY8DcTMBOWc2yZUA5omrWTHmgdoEGOCXGIo6cCSd
	BmayuU47uPb0YYQxGP4EE/+bHv7fEEN/02EWvJtMmP/sGsv3lfH68MckjfBJz8/a
	DlN+06Z1S5S2Jo3eoKERrNU9pYAYdleMM4Q==
X-ME-Sender: <xms:KcyjZ2i5cylsZRC7ho2zg_ro8nPx8AvuuatKNMXkF2QirWGhOQcvKQ>
    <xme:KcyjZ3B9rwKVDHLGl9Xep8Aa4hLVDBv5W43u04fcXHNptRrooAE1yajASoTDM7p6E
    bcX4sTOGw9gnIDMlw>
X-ME-Received: <xmr:KcyjZ-FgC4pGyoqUrMAtqIZjqJBV0JKlC10Hv9zb-nzGUNoSia3rzRVY9aaRGIqfFqpgQZlMOLLEBFT_IL2IYF5v8PmTvO--Sog4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedvfffggfelfeeuuddttdefleehfefhffek
    geetkeehhfeigfdtudejveehfffgleenucffohhmrghinhepnhhothgvugdrkhhnpdhinh
    guvggvugdrsghfpdhthhgrnhhkshdrphhsnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhs
    rdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjheitheskhgu
    sghgrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:KcyjZ_TRMbIMbEO7AfSztyAvMXl4sAsCcxXvF14gaci1Fv1DHdtMnA>
    <xmx:KcyjZzxhCwMQG65m5rUe3uo0wXguSEp3Sb4uCMJ0J48J1J1RGdHQ8A>
    <xmx:KcyjZ97qarGTIEfCIP0zbAyEaIbEnkEoSPV61kZV4A94gttu9QNtBQ>
    <xmx:KcyjZwwGzxT7KrgwDyk4OUClwuCvZj7HC8vfaAcbo8mnIJjQqNLTWw>
    <xmx:KcyjZ-rgFt1iEd8cgLYS9ahnDftwNJrlw6XlqeiwzG5whTBLJmQj5D0w>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 15:38:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>,  Johannes Sixt
 <j6t@kdbg.org>
Subject: Re: What's cooking in git.git (Feb 2025, #01; Tue, 4)
In-Reply-To: <Z6MNRVrhw3Nxz6Iw@pks.im> (Patrick Steinhardt's message of "Wed,
	5 Feb 2025 08:03:33 +0100")
References: <xmqqldulrvly.fsf@gitster.g> <Z6MNRVrhw3Nxz6Iw@pks.im>
Date: Wed, 05 Feb 2025 12:37:59 -0800
Message-ID: <xmqq7c64nn4o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Feb 04, 2025 at 06:08:57PM -0800, Junio C Hamano wrote:
>> * tc/clone-single-revision (2025-02-04) 7 commits
>
> I'll do another review today.

Thanks

>
>> * ps/reftable-sans-compat-util (2025-02-03) 19 commits
>> ...
> From my POV it's ready, but I'd like to get an Ack from Justin and
> Johannes, as they both had comments on the last round. I've Cc'd them.

Noted.

>> * kn/reflog-migration-fix-followup (2025-01-22) 4 commits
> I think this topic should now be unblocked as all the preceding fixes
> and fixes of fixes have been merged.

Indeed.

>> * bf/fetch-set-head-fix (2025-01-27) 2 commits
> Yup, I think this series is ready.

OK.

>> * ds/backfill (2025-02-03) 7 commits
> I'll do another review today, but think it should be close or ready.

Agreed, and thanks.

>> * ps/send-pack-unhide-error-in-atomic-push (2025-02-03) 8 commits
>>  Will merge to 'next'?
>>  source: <20250203-pks-push-atomic-respect-exit-code-v5-0-d66481e36622@pks.im>
>
> I think so.

OK.

> One topic that I miss in the cover letter is [1]. You probably forgot to
> pick it up :)
>
> [1]: <20250125-b4-pks-reftable-win32-in-use-errors-v1-1-356dbc783b4f@pks.im>

OK, I was wondering if we are going to rethink after seeing some
comments but with blessing by j6t [*], I guess this is fine.

[*]: <37c14379-68e4-4c52-a08d-b78c7797ef26@kdbg.org>

Thanks.
