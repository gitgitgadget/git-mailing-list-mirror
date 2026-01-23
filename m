Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F12E326940
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 16:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769185372; cv=none; b=QBFeziH0yV71hufAD2Y1iis1AZc3VcvIuVD+IpuOXrGtidWE14yaNu2bczE3K8yuGQJb7RUBg2HWVokSS+DGpDgKyq25qwU0zWpTl48IxqRhXTKK/Q64biQC1BliVqC+zQi6XemqPBR5K+K91kIUlljpzVzdFIqLVB2JJeP84DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769185372; c=relaxed/simple;
	bh=iHvaNVv4vLPM31/d9OVd351k+0zxYrGxoxmma7H37yM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ouI8BaMSOxxzfgY0FSBirHennS7nsfsbLbVOipYWfVtUm+bLfYsrctJZiGSVv8xgRwt1d+zTfZt38Xxys1yc6UhGuVJY/lB3AqQ2EHWnzrZR6gWkkE4dA8cA+IhfYxvIss/GJMlkrm7lZ9NqM+YYwZn+nX7X3XsMe8Ok1trWV+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GCcwsZqv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NWOW1aK9; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GCcwsZqv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NWOW1aK9"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 204191D0008E;
	Fri, 23 Jan 2026 11:22:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 23 Jan 2026 11:22:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769185369; x=1769271769; bh=yqM/g3yeDn
	rv19qzIfrGRQZCqPwnWcY2PlpKswjb4MQ=; b=GCcwsZqvpx6XbfVC6lV22BB8II
	xodT6LCrNFrNIwQvxHwxr2lDv9FfScQzzesrTAzS6h6L78W5gXoRTxe9cixy6+oh
	FDGVRskgpqZShdftSLdQIPr/4pjpW+SjAR+SHrpZShvX0/jJ4LLTzW2TfmroRKL8
	RTbw+WtHrTwjdwOa9r2Ye/jXRKRUESioO1NPCnnv49pDIwXQi+uTrIpx/0lygaF2
	GAMw4H3aaKYNXcoLv7OjNpoic6bIeoYBmeBH0TsKthhnjojPCFzLyu9+E5VUrwo9
	lgvBZnQNuN5h5Nnlt6c7RR3TM/6iLXjIELOqMGQJcn7gnXDmEubQzK63urQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769185369; x=1769271769; bh=yqM/g3yeDnrv19qzIfrGRQZCqPwnWcY2Plp
	Kswjb4MQ=; b=NWOW1aK9S+KUU9iVy4Q4TxUluqy1jJilqI+WEKll0gG6MwmmGfN
	seVRLzbXJWfxbn55aItK9393YpnftL7hEPjSHrIJ6Pu/B1uLKZcsn/vnf6/bXsCf
	RUW+jFNuxtF/ZjDpUo3CDD3Yzng/SDmN4TW+R4XtzZcJmeQLG1Z4aXUWPmWydCEQ
	zAw3BZlSP8j6barSYU4pcyS4uetJTygsOBYH0i3vQzmJXljCCU0agxI5FpioX4pQ
	++qSGmex+ayYpAVd3MZDLb7vNFaq5oPIh31Qyiwx6OSar/z2zy39vh8SThtI8EhN
	u7ixS6xFjZmQcytA5/LKq9lNRxsG5Iy4Lyw==
X-ME-Sender: <xms:WaBzaakHgpLxn6igVPb_GT9xqjrnRTeMFB19snbRDXr96tAKpUUr6g>
    <xme:WaBzaUEd2dARUe7AALtGOSH8g0r7FJJ2IK6YV_MgDqKrGgI94bRKtUSquKNWiEpC2
    1cOrxVdKPzlAxj7X5HAypfR9xJ38HSBbX7RtIYKp_HJp6QkPfrW>
X-ME-Received: <xmr:WaBzaa626T0wNtVHOmjlyqrVmsanXuXhVUyB1XTUdzd7l3kfkdqiHE_MUjLFzYKLVynGNGx5AG7a9QJDydFLyLz6bqX76P_cMqT1Yfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeelheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishdrthhorhgvkhesghhmrghilhdrtghomh
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehj
    lhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:WaBzaUmKujHjo6HUeV7hhWF40Sct49yeQC5xsWOG-13-teJY9LUwWg>
    <xmx:WaBzaXpLq9W_ZKzBRzqpEd_Elq44QmuSeJgMf7z3bJ51CdC2WghGuw>
    <xmx:WaBzabsehJJnhhYnDBACZkj5i7_VtgcyhOhmz33aI-CiqqwDbuXfdA>
    <xmx:WaBzaUFzGwiWq6TRTdEpqYk_mKLIybZFtMz82v55l-cm85oozqV9qQ>
    <xmx:WaBzaVtrc_jjFUDS0jBuNkIU-xxXtcO9of_PpK-_Tdvq42FVGVJi9PaU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jan 2026 11:22:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Chris Torek <chris.torek@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,
  git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 06/14] packfile: introduce function to iterate
 through objects
In-Reply-To: <CAPx1Gvd6BGPeVmN5b7WM_r6OFf7Y6KooJ2O1jT5O6LzNzGuEEw@mail.gmail.com>
	(Chris Torek's message of "Fri, 23 Jan 2026 01:52:00 -0800")
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
	<20260121-pks-odb-for-each-object-v3-6-12c4dfd24227@pks.im>
	<aXK7cSJW2syew89a@nand.local> <aXNCjT6Al-4YLah5@pks.im>
	<CAPx1Gvd6BGPeVmN5b7WM_r6OFf7Y6KooJ2O1jT5O6LzNzGuEEw@mail.gmail.com>
Date: Fri, 23 Jan 2026 08:22:48 -0800
Message-ID: <xmqq343wjo2v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chris Torek <chris.torek@gmail.com> writes:

>> > > function is the equivalent to `odb_source_loose_for_each_object()` in
>> >
>> > s/to/of/ ?
>>
>> Hm, isn't "to" correct in this case? The remainder of the sentence reads
>> weird though.
>
> Different English dialects. The preposition after "different" differs...
>
> (It also matters whether you use the definite article, "the function F1
> is THE equivalent of F2 in case X" vs "function F1 is equivalent to F2
> in case X".)

Heh, "equivalent" is "Y is an equivalent of X" is a noun.  It is
adjective in "A is equivalent to B".  Of course, article is used
only with the former (i.e. noun) form, but article is not the
essential difference, parts of speech is.
