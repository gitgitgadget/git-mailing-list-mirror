Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8FB1C32
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 14:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735567646; cv=none; b=asUN8yEGkhUfgz2KH2Yw9aSWVDRBvcz3qae59xC7IHHF24MSbDz08m61wUHZplLSe//efz3AZtKos5Dq2urZnzgGQ6wfP7kxcMW67Aj4n+/XuQsX8rvv20FzDvOK14tNVVFTfhq1Oai8mOL2jbJkTYGEb3mBM18h/tUVDJ5dkKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735567646; c=relaxed/simple;
	bh=4TAYp1pqe7OTR+R5asjiS8eBcgIJcEHDZrU/3AOqiFM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OrhSx9lOACltnLRW6dXyI1Y4NJhoMFanCDgZNBsWArRsyQMV1eADup7uVBX8tk4t39lcGOi+vZhdbDVR4d+wjagThPPocRBdktFu+Sycqsx0P0DvU1sJ/wnZSr1v0ia2FS6VMXuyIYOs+XwXAKOrDeTLPjK1eCxyKuURtPRqEi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=y8QUlYyl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GGO7J3WT; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="y8QUlYyl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GGO7J3WT"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 9B16E13807BC;
	Mon, 30 Dec 2024 09:07:23 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 30 Dec 2024 09:07:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735567643; x=1735654043; bh=7O3WWlQUx+
	/ao1jmwzITA6diOi84DpvUxLWhGF9pr3E=; b=y8QUlYylRxiieS9HpJIX8du2b/
	oIpPQzYo2aalKdRaZkrC9UZHvp94iHf7OsySmwnqAlVOl4hsUDkzrxBtj4sq5QFd
	NUKVn64XZOsYu0txMG5SEOLk8ASPP63D5OPHCpWElwOWsk6CGRTRnPybBEryHFed
	XPcGJqN+nyM4qJTcK4t22RKfZuQPAmvwLEThdXKs6zd3Bn1NmMwbRJs74Z4yrYKV
	4+y7C55yrEjH3+H2KaPdvK3d46h5rrGOo9AlzBayfgg6MVehNvxT19HTe5IltGVK
	w+mLXUEytWlKzLhusrFHAphJ1PnZeZ41aj0omJARtOKh6mKkN8am0v8kzSpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735567643; x=1735654043; bh=7O3WWlQUx+/ao1jmwzITA6diOi84DpvUxLW
	hGF9pr3E=; b=GGO7J3WT4d5MJOr6LioumbE7HpbPb2g3dP50o1++B26yd7160bM
	Ig4nBQEmTXN+/wbwBGyN66UY5+yu0VJ1N+0LFiJt+PzHBQ3jgmW+HuEAATzcEaky
	ET7i179c5RQAchdaiBh4gHfAyuFuMrxLh+ryfLRFfJ4N82w6Dtjz9vpcZx2TcixE
	5I5q17hFUFXIskdkYTbjcddGkSFBudOlPfgOfWtUFfuvYKFLam7DwKLt7/CCr8qb
	v/dxjPmxUD9jr4b0uHWQEQ+jPQvwJfi5ry0XNlyYioaoaLMoXTN2Vz4OkkTsPf1F
	w+BS4vrveYxm9+cDWAAz4HnrjpBnHpM7Wvw==
X-ME-Sender: <xms:G6lyZ7bemuNdS9a3ME3uCQb-NAoAhBIu_pOJmOmGxFS6wy2e9iLonQ>
    <xme:G6lyZ6ZzxnhBgAwt_wH-RLoQPusZXcjOcenmt-W5Ybyqwc_FGSIbBrivz6g1O0DPN
    vlfw84TLvAdLPRCvg>
X-ME-Received: <xmr:G6lyZ9-5zkChMSMKiTAU_8WDQZN5wP5TSLz_Zy5OghmijcKcpVuPTJO7DaFc0hhtWSDLkwkUJK-coPcKi5vW3Ass-m4LaxuCTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddviedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepueehveetgffhkeeftddtgefhueekvdehgeek
    ueejffdttdefueelheeuheduudfgnecuffhomhgrihhnpehthhgvnhdrshhknecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhes
    phhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:G6lyZxrqelPt9VBr5hmYukpKIod4SZiSOLqFZFYrjAWtWMqZx68jAA>
    <xmx:G6lyZ2rN5JH6p_w8tiBAOnSukguHZ4iPorTGK5V1ICzWcN7MvOJLDA>
    <xmx:G6lyZ3ROl3l-Xe1_Kr4167r3E8p4GXWxr640Vs5gpMU7fn8IFG_4iA>
    <xmx:G6lyZ-owdhNrmGdl4Y8UWy_3vWMfHICAu7zrEOawF0lQowpSz3cF4Q>
    <xmx:G6lyZ5WOp-6nQXXlX8Theiqk_J_F8qvtWLvB7DwLCAZ6EVK6ZUsQjL8X>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Dec 2024 09:07:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2024, #10; Sat, 28)
In-Reply-To: <Z3JLdIG4C9D2-1ZT@pks.im> (Patrick Steinhardt's message of "Mon,
	30 Dec 2024 08:27:48 +0100")
References: <xmqq34i730qr.fsf@gitster.g> <Z3JLdIG4C9D2-1ZT@pks.im>
Date: Mon, 30 Dec 2024 06:07:21 -0800
Message-ID: <xmqqa5cd1cyu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Sat, Dec 28, 2024 at 02:23:56PM -0800, Junio C Hamano wrote:
>> * ps/more-sign-compare (2024-12-27) 10 commits
> ...
> There wasn't anything yet that needs addressing, unless I have missed
> something. Peff acked a couple of patches, and the questions from Jialuo
> have been addressed. So no rerolled is planney (yet).

OK.  Let's merge and cook in 'next' then.

>> * sk/maintenance-remote-prune (2024-12-28) 1 commit
>>  - maintenance: add prune-remote-refs task
>> 
>>  A new periodic maintenance task to run "git remote prune" has been
>>  introduced.
>> 
>>  Will merge to 'next'?
>>  source: <pull.1838.v2.git.1735380461980.gitgitgadget@gmail.com>
>
> I've had another look at this series just now.

Thanks for a review.  Let's wait for a review response and go from
there.

>> --------------------------------------------------
>> [Cooking]
>> 
>> * rs/reftable-realloc-errors (2024-12-28) 4 commits
>>  - t-reftable-merged: handle realloc errors
>>  - reftable: handle realloc error in parse_names()
>>  - reftable: fix allocation count on realloc error
>>  - reftable: avoid leaks on realloc error
>> 
>>  The custom allocator code in the reftable library did not handle
>>  failing realloc() very well, which has been addressed.
>> 
>>  Will merge to 'next'?
>>  source: <f4677194-0a3a-4f07-b003-c0295b51c100@web.de>
>
> I'm not a 100% happy with the split for reallocators that this series
> introduces, but don't think that the series is to blame because it
> simply fixes the underlying problem. So this is a good first iteration
> and we can improve the status quo in a follow-up.
>
> So yes, I think this can be merged.

OK.  Again, thanks for a review.
