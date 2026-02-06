Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D0C30E0F4
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 19:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770406647; cv=none; b=lybw1eOTWTNFYZgu02qhMJaHZlsZXsG97PJZ/PzTlCkpqwEW9ADmZ3ZOY0mD/I3gp5i2mL4RFXGHWYd6/QRTEEH3nerokLJtT+rzfVI5qs/JKSMUcDfIThojLoV04TuZWr2j9wZm20ujTt6XP65bPLvj4nMYoeki42YWgmV+88E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770406647; c=relaxed/simple;
	bh=qS09LLsojANzgZGuEiEfwmYUS2d1NLkxfswjFfHlNOM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fkZ5VztAGAea4onkoD59dABB0JT2RgLztyDhIzq/imD7hI3chtMssmcNI264o03KduOlJCIZUslmNDeKPjn2PvCSqIrG7jXTUT6n/+C8O/0nkI2ho/8ZvFBYNXTaw2bcQ2BJzSG4m8ciaVZg6tjzGj7d7KUi/TCr1/Z+0LXX7k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Jt0VrOKQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nVxuzWf2; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Jt0VrOKQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nVxuzWf2"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 53AA314000F2;
	Fri,  6 Feb 2026 14:37:26 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 06 Feb 2026 14:37:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770406646; x=1770493046; bh=00SvkfMXqM
	X2HrCG3HAc1g6FcpETAQsgPDom/tO32ug=; b=Jt0VrOKQXCPpR3c5QSrZqr0tDM
	6C1KNW7jyzzeLdfvtcbufp9I1Zu1DcO7wekgLi2eaccEKSC/7O5fnj2PONY9vEyC
	ueWSWT8Ajqd8pVE7TS7H2P/3DL4/jCwsR3bnxP33qHikyjsaEXBqhFOh5XhokRPY
	4TbxBNad5gCLwIhPMcN1+LktoHRoG24PEnIcwf3rFbIGTcC96ggK+TZmMVDLQMU3
	2ex6gjpQE3d918srrhpoL8i+ec4K0MaXZx2/VWDpDj1HU8NFREme+8kHtcfFN9cu
	iWjM1SwG+LwHa7biyYG1QCYjkhj1MGaiak3K8KAJ7Kk7zH0fpkOhlChfQsXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770406646; x=1770493046; bh=00SvkfMXqMX2HrCG3HAc1g6FcpETAQsgPDo
	m/tO32ug=; b=nVxuzWf2+5UgqhzAIK32BYdKU7HjRRJ4vYV1Gp3/OzQvN0Map/M
	wkOviGxKNRYc6QYagisCUZ8i5xFv/VcMzsioBfdq5er7cjKLSRehGhqdEJZDb+Zl
	KBXr6HxitCoymXY4lYJoSv/4+Vrc+cVzRERJRSanLA6rHYZx97ulKeitFlvMJm/Y
	VKSjUVGMYk0k5jHWszOvmPSUtp7ihJdcAzboPGtPZmMgdLOdq+JBBVd3KiSkh0NU
	iScMuQQGSHTCA3Voe3bF1y+PowDXj1QKesaqv7IjOE7DE1RtTQX8MjUGPCbW4Vmt
	LHtk5pRJ9X+K+KQl5i/GTb4KGzXaqUdER0A==
X-ME-Sender: <xms:9kKGaXhzooGjTiG9_rvFW8oeNcvw1348L8Yll4q6r6KKyjYk4x_GYQ>
    <xme:9kKGabfxWloTUq_kFDpzZcmkXDj-MoRIQwN385ywNPHPhOyGoBFG5Ld1fXXf4JRK7
    Xsprs_K_sAyIJWIBT0hN7RyQ7wYUrJ4TJPZ4g9S9J9y0VjBFBi5nw>
X-ME-Received: <xmr:9kKGaUddFen32qNaBbaoFH-y95nUBhpC2fiQpIGvHg8T8TMuZxHlFP2jpAZOA440nR9RtbHqeYZR9je5ekPJdteoRhZEGPmGkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeltddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdeukeetieeuheelffeihedvjeduheetgefghfeiieeggedujefhhfduleej
    vdehnecuffhomhgrihhnpeguohifnhdrphhsnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgs
    pghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9kKGad8EJeiG6gk9y3eN34-ZzpdC8KxCGZQqwn-s8lx2ZclTWG843A>
    <xmx:9kKGaYnoGGTqXzVhpG45hpn8Q4stuOwQnCXHRT2cCDqjjnCjBtGaQg>
    <xmx:9kKGaX-ZYzaakfNsS7DFLBLqAfHUUhSaV3P_kmK50F5Qd-RX18tHAA>
    <xmx:9kKGael-N7WGhOe_b2sJ4_yN5xjmPpOiYjjsmbnyIm4aFqYyBbGyDg>
    <xmx:9kKGaTmHXHMknyAy__Tyhr1IhfEXcxVWRY_IPhi3CEq6al_Jd4wTZwVW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 14:37:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2026, #02)
In-Reply-To: <aYYXClcfoHT0TZcX@pks.im> (Patrick Steinhardt's message of "Fri,
	6 Feb 2026 17:30:02 +0100")
References: <xmqqbji2k6yg.fsf@gitster.g> <aYYXClcfoHT0TZcX@pks.im>
Date: Fri, 06 Feb 2026 11:37:24 -0800
Message-ID: <xmqq5x89ek97.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> * ps/commit-list-functions-renamed (2026-01-15) 3 commits
>>  - commit: rename `free_commit_list()` to conform to coding guidelines
>>  - commit: rename `reverse_commit_list()` to conform to coding guidelines
>>  - commit: rename `copy_commit_list()` to conform to coding guidelines
>> 
>>  Rename three functions around the commit_list data structure.
>> 
>>  Will merge to 'next'?
>>  source: <20260115-pks-commit-list-coding-guidelines-v1-0-c58868dbf412@pks.im>
>
> I guess this one depends on the outcome of the discussion we had about
> renaming stuff. I think it's worth the churn, and don't expect to do
> another reroll. Otherwise I guess the series can be discarded.

After having it in 'seen' for half a month, we haven't seen any new
users to conflict with it, so I am inclined to say we go ahead and
merge it down.

>> * ps/odb-for-each-object (2026-01-26) 16 commits
>>  - odb: drop unused `for_each_{loose,packed}_object()` functions
>>  - reachable: convert to use `odb_for_each_object()`
>>  - builtin/pack-objects: use `packfile_store_for_each_object()`
>>  - odb: introduce mtime fields for object info requests
>>  - treewide: drop uses of `for_each_{loose,packed}_object()`
>>  - treewide: enumerate promisor objects via `odb_for_each_object()`
>>  - builtin/fsck: refactor to use `odb_for_each_object()`
>>  - odb: introduce `odb_for_each_object()`
>>  - packfile: introduce function to iterate through objects
>>  - packfile: extract function to iterate through objects of a store
>>  - object-file: introduce function to iterate through objects
>>  - object-file: extract function to read object info from path
>>  - odb: fix flags parameter to be unsigned
>>  - odb: rename `FOR_EACH_OBJECT_*` flags
>>  - Merge branch 'ps/packfile-store-in-odb-source' into ps/odb-for-each-object
>>  - Merge branch 'ps/read-object-info-improvements' into ps/odb-for-each-object
>> 
>>  Revamp object enumeration API around odb.
>> 
>>  Will merge to 'next'?
>>  cf. <aXk2FjTUMMThs5Kp@nand.local>
>>  source: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>
>
> There's been some discussions around the mtime handling, but I think
> I've addressed the concerns both with documentation in v4 and with the
> plans I've layed out in <aXcrftLpfcG4S5AX@pks.im> and subsequent
> messages.

Let me ping the thread.  Taylor asked a bit more time to discuss
mtime related changes a week ago and I do not recall seeing a
further discussion.
