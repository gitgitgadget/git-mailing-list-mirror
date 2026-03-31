Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354133E92B7
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774972699; cv=none; b=SGkr8HrMPYpGBuoPT4dze51e+QCz4RnIjwl95Ow12JmjrFpy5RoTfgGJ36C3mBV+aR7iPPXActBnRylnmV7vtzz+sdX2QPXPc+5ueNdWKWGh3f/IwLOGiLnACZk3gXD3naRTaCadTwyVlqacH0zuTAeR5G/MbcoXR6xv9+zeo3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774972699; c=relaxed/simple;
	bh=HrBBHep7uSDbzAIUoszD1fGOGR1jZgFKG4o5+nTprSE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lvs7WWjNg4etdU+10q/jJjaU5vKCkG9CmBU0/EomToGcDPi5YtntAulN6bHo6ZGnr6KPs5yvxMvxHKj5vleiSqKPtApVeShDm8wHB9k6Gnm/4AG2oGpaqLL3gonPrUDqO26JWw8uht7k7j3AxyuYUFjcX1sJCU+ddyLK09gZ5Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g0lMi5wz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=suhxdhcR; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g0lMi5wz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="suhxdhcR"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 719B4EC01FB;
	Tue, 31 Mar 2026 11:58:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 31 Mar 2026 11:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774972697; x=1775059097; bh=ivkPrrCfI3
	nJA20hzQzSUWzDrZUx6nr0XTICjAF53ro=; b=g0lMi5wzGz/WVGQsUgwjcMOun5
	rZ4MW8V1s26nn1p+J6Yo0Pj1c0EioaLiVBH+H5+VjukygHidLN+xeS2KZV2su6Um
	oNev37w5BQlwttWQtGElRdr8HTG5lTovBbi81P6ORPfY1QXBKOy8tFup3U9H/qOF
	bULfw7ygaDEaJJB3KXmmbOXy6AAV+BfGi52PLlV/Xe5W5vficy7L6uFuylHDdqTr
	/vN4F0/wwBW+xt/53luscZEduACjzsH2y1t2lNFO9fdsMpcU/WEV+br/bHAN5PzH
	93Hj+fp/MLLKXrNht0/A6TuLUUsHtYKGLHDQQnmhJrkmekHvCvJ4lbDsJoPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774972697; x=1775059097; bh=ivkPrrCfI3nJA20hzQzSUWzDrZUx6nr0XTI
	CjAF53ro=; b=suhxdhcRagmJzcgzJLATvzdEK9L0/JkYdM8mXZwEWQRTyrEYmA5
	N1CkT2VOKWINuzTQxkdkdmX0H5s5hbiFK5R4hemCclSTf35UbXkEBxxgdnYGUUYQ
	pUX1ZeNtEXL/c9Ab4NKIpqodWkukaToKCjo6j3jH0forxJVfwaj5E/ODpp64O7jU
	Zh8YrE5lzmZQF3pV+rv38Dh4OS3UL3JmBm6dpp6E1dbNZpKVzH3wDs3MEpeav3Cz
	q/IOnLBbbfGiRHjjDKUo8go0gTeL2Y+vEcKxohOMpT4rjSpEsvbHQ/1NMfdxl0+Q
	+iYIyDreudlabdaSG9kmDF4YmRVWf/s0+pA==
X-ME-Sender: <xms:Ge_LaSV3ZgISQG6C__4UCmq5lkfGBCZdc0b7UKb_0ikvwvBqhabN1w>
    <xme:Ge_LaVm59mOxayNyaqF_YPDIV6pu-UJXxYLNzshXg5HHkbh13VnnN0nnE_N2ahide
    nh0n0bmXv_ogOHZc5R8rw0aiJDZbQDlNLS5oQgGQtG2iBA1GSFA>
X-ME-Received: <xmr:Ge_LabbuiLSdOJ-98SfRbsLS97kWMFvMba8Ve58uW-NihX_TF67k5vSqsSJOjRd6kFiDOSyekx4gzQQb2Z8ZOoQIKSoAzdyp8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfj
    rghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrh
    hnpeffgeefteffjeekgfelhffgjeehgfdufedvudethfejheevjeejtdehjeeuvefhhfen
    ucffohhmrghinhepghhrrghmmhgrrhhishhtrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjh
    hlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Ge_LaYM1raEQeAA45jg3D9qoAWeLHqmYHqntVUlZ0JPMZHzZZ1LIlA>
    <xmx:Ge_LaYaw2BCGntTQnYw5x3V1wIMK9_8fn4Wc68Cm2aJGhNBF-TvmYA>
    <xmx:Ge_Lae3a-RgSMY0iBJB0nFLo4IxCz1-4iwU8k2iMfTqYpURJykCckw>
    <xmx:Ge_LaWc4ev1cZwZRwO4KUqDXYeBfvdOlspqrm69wj_SxOBkghDNPmQ>
    <xmx:Ge_LaW5Ur-0meqyYrxyKLjpOI9pl0TQS28fUmVSiQT94n9F-R3-k5Aq1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 11:58:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 1/6] odb: split `struct odb_transaction` into separate
 header
In-Reply-To: <acvSQ_qeA79LV-8y@denethor> (Justin Tobler's message of "Tue, 31
	Mar 2026 08:56:06 -0500")
References: <20260331033835.2863514-1-jltobler@gmail.com>
	<20260331033835.2863514-2-jltobler@gmail.com>
	<act8SB3hqHvleT_Z@pks.im> <acvSQ_qeA79LV-8y@denethor>
Date: Tue, 31 Mar 2026 08:58:15 -0700
Message-ID: <xmqqmrzo2dpk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> On 26/03/31 09:48AM, Patrick Steinhardt wrote:
>> On Mon, Mar 30, 2026 at 10:38:30PM -0500, Justin Tobler wrote:
>> > The current ODB transaction interface is collocated with other ODB
>> 
>> s/collocated/colocated/
>
> I wonder if this a regional spelling difference. My spell check doesn't
> seem to like this variant.

Collocate is a verb that is defined as words or items being set side
by side. This word has been around since the early 1500s.  Colocate
is a verb that means to place two or more items closely together,
sometimes in order to use a shared resource.

https://grammarist.com/spelling/collocate-vs-colocate/
