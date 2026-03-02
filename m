Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115EA3FD15F
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468799; cv=none; b=HGW1H0kS0XAMXuGkVKVZSFq3Dj6SlDVmTLEa2ManekZqcTHlFHXUCIPSjYiTIxhKcW/yThSXngaid4/gCEwmNQFu+4Q10oXxb6QJmhSlPFJw+fBSqvBcj1jxhjmkDNRSYI4kQOoVq94MQhXIw0FC0DZsD6u6B1+45OdmufPCda4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468799; c=relaxed/simple;
	bh=KASDeSFnpOU7OPgpuUqOXDrYI7kCkJga2qc27wgWYbE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kW8Glt8k5ZYyjFxLOatZEBC01NIFW3UI1gNOTaDEB7jLWdjwRKqk10fEzRJWxw7L+1iDVvswgGCIVn4/OP3Xq1WjfNIeWeZhUj1G8kt4sSA+XUt0ZbmFsT55v8ZEGMNfQv3TVoLYz7Ei//lWGo3M06OQN4WtVYlbYvkuNEVe098=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KlF7tiJp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s7OlhNk4; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KlF7tiJp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s7OlhNk4"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3F0097A01E2;
	Mon,  2 Mar 2026 11:26:37 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 02 Mar 2026 11:26:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772468797; x=1772555197; bh=1i1yh2wHKr
	ZBILtTgoO5ky3QnLvH0vPNr9iqvQWSBsQ=; b=KlF7tiJpHS+jtdpCJTY+ZV5zuY
	IrL4pzT7dfE2x0AW7A2/eEjKWiEtiF4Rx9lt1ZKLOkLaCIseXUOmTRRWULM1kpAp
	q/goEHOSxxmiXvH8sC9unzdcNXorbcXzeiBvl5gaXDAPeyzIowJ8XIWANlz3wkgR
	eZrJ1y0qAqIq9DIN4VXIeuzyV2NPv/yAaXAw4BCfsX+r/m2defzrM751IEtymbyY
	1QzVNqF3xQG2otvvgXzyRv4htETQNRXNuygQSq7IbkhAQsJrpZyVO1QmXDE1HxSN
	x+vmmHhrYQwl9c4ASpPM5veRfJVw0f5YZHGmh7bvmeQ4reucnBDtrETReYAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772468797; x=1772555197; bh=1i1yh2wHKrZBILtTgoO5ky3QnLvH0vPNr9i
	qvQWSBsQ=; b=s7OlhNk4RNDg3W+UU3DtQSsU3MuQk+43h4FMrYl6pRwJbeEJ9GO
	dUS3LpGz7n6939umWejEN5iRkhCRwypl3wewdK2iIIehCMR89ZoiqnFJkRv4orid
	Rx1ZtytatAaSHiRG4+rwBQkiGEdXEEzlnPt0LkPnXAIlEhrU+F2/kIGIB650JeZ3
	S50jLlW2f4MBNL8vRQhR8J6oGmLQrQ/X2AS3/uJUYfSuTt545cIG27H03tD8jNk+
	li4mFQpoRxF6pb7j8Ub8e801wym9XgeM311vUE4MNv5FLcK14ScXA2LM2//IzQ2W
	wsZHBD0Sr9Y4NfbK9bIWCII4gH/SbqAiutg==
X-ME-Sender: <xms:PbqlaT16FWjf4QmppAKT-wgxCcWcPnDcirlXuWy6qtKwWYDAg5y9gQ>
    <xme:PbqlaZGaYpaw8t-YbeS5gPqv6cuuqyjT1AZ27yAXf9-MD4VRfbKUWv0E7zRKDLU3X
    sdeGEmTDBS59SqdxZuEzHG18X5N6FcuNiNWTv7dgbzakDHNCN89nw>
X-ME-Received: <xmr:PbqlaY4jcEinKd8hbwjWX7SSd_Mk-pMnU0yjrJRzzMvwNdssHM1YDFAThQqBuqV1XfbEXqjuNbKB7EfcJJPah8WIbgc4H7-gtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeffieetueejveefheduvdejudffie
    ejgeefhfdtvdekfeejjeehtdegfefgieejtdenucffohhmrghinhepghhithhhuhgsrdgt
    ohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegrfedvtdehudehfeegudeisehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:PbqlaXvFuFuKgZxZ9VAvDFXlEc-R0zRyVjIYA0aB4ix59v1QlXAJeQ>
    <xmx:PbqlaR7NvXN6Bl7tOY4zujNXXOrIn4Ml0_GPOLOBk46Pf5QOVBY4vA>
    <xmx:PbqlaaWXVzhgMyc_q3nGuSc11GE-E7Q4-kRBQDqb3GmLClnYmtgJ-w>
    <xmx:Pbqlab_ikBkhfdj-I4DX4R8d0tl__YjVyz5n5KHqV2Lhj5pn2ORacw>
    <xmx:PbqlaUYHAMujnBoHAZsnOPw5rnQBeCC6PtoC6kkX2YKmjqkCXB8G_e4Z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 11:26:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Tian Yuchen <a3205153416@gmail.com>,  karthik.188@gmail.com
Subject: Re: [PATCH v11] setup: improve error diagnosis for invalid .git files
In-Reply-To: <xmqqpl5rumy0.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	26 Feb 2026 15:03:51 -0800")
References: <20260222102928.377519-1-a3205153416@gmail.com>
	<20260223074410.917523-1-a3205153416@gmail.com>
	<xmqqpl5rumy0.fsf@gitster.g>
Date: Mon, 02 Mar 2026 08:26:35 -0800
Message-ID: <xmqqjyvu42pw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Let's try again.

Can folks equipped with knowledge and environment to debug breakages
that hapepns only on Windows lend a hand to figure out what this
patch gets wrong to help the topic move forward?

Thanks.

Junio C Hamano <gitster@pobox.com> writes:

> Tian Yuchen <a3205153416@gmail.com> writes:
>
>> 'read_gitfile_gently()' treats any non-regular file as
>> 'READ_GITFILE_ERR_NOT_A_FILE' and fails to discern between 'ENOENT'
>> and other stat failures. This flawed error reporting is noted by two
>> 'NEEDSWORK' comments.
>>
>> Address these comments by introducing two new error codes:
>> 'READ_GITFILE_ERR_MISSING'(which groups the "file missing" scenarios
>> together) and 'READ_GITFILE_ERR_IS_A_DIR'.
>>
>> To preserve the original intent of the setup process:
>> 1. Update 'read_gitfile_error_die()' to treat both 'IS_A_DIR' and
>>    'MISSING' as no-ops, while continuing to call 'die()' on true
>>    'NOT_A_FILE' errors to prevent security hazards (like FIFOs).
>> 2. Unconditionally pass '&error_code' to 'read_gitfile_gently()'.
>> 3. Only invoke 'is_git_directory()' when we explicitly receive
>>    'READ_GITFILE_ERR_IS_A_DIR', avoiding redundant filesystem checks.
>> 4. Correctly return 'GIT_DIR_INVALID_GITFILE' on unrecognized errors
>>    when 'die_on_error' is false.
>>
>> Additionally, audit external callers of 'read_gitfile_gently()' in
>> 'submodule.c' and 'worktree.c' to accommodate the refined error codes.
>>
>> Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
>> ---
>>  setup.c                       | 45 ++++++++++++++------
>>  setup.h                       |  2 +
>>  submodule.c                   |  2 +-
>>  t/meson.build                 |  1 +
>>  t/t0009-git-dir-validation.sh | 77 +++++++++++++++++++++++++++++++++++
>>  worktree.c                    |  6 ++-
>>  6 files changed, 118 insertions(+), 15 deletions(-)
>>  create mode 100755 t/t0009-git-dir-validation.sh
>
> Unfortunately this seems to break almost all the tests, not just the
> test the patch adds, on Windows (which I almost know nothing about,
> but I can observe that CI jobs die).
>
> https://github.com/git/git/actions/runs/22464017037 is a CI run that
> merged this patch on top of the commit that corresponds to the tip
> of 'next' as of today.  We can see "win test (N)" jobs dying all
> over.  I cancelled the workflow before seeing everything die,
> though.
>
> https://github.com/git/git/actions/runs/22464479533 is a CI run that
> tests this patch applied directly on v2.53.0 in isolation.
>
> As I said, I do not know Windows well, so this may be a red-herring,
> but in this CI run, we see "GIT_DIR=/dev/null git diff --no-index ..."
> results in "fatal: error reading 'nul'":
>
>   https://github.com/git/git/actions/runs/22464479533/job/65067515458#step:5:95419
>
> which is an expected thing to happen, but we probably used to ignore
> it as a non-error?
>
> For now, I'll kick this topic out of my tree to give other topics a
> bit more test exposure so that we can notice new bugs in them (not
> in this topic) that causes the tests fail.  With this topic in 'seen',
> such bugs in other topics are all masked.
>
>
>
> Thanks.
