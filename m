Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D29CC2FF
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 17:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771347682; cv=none; b=gGVPTg/HCpMvx59XwJglJ3V10UgAGe8Wm7WQbdGP2CFJ39dOr1XQQ0aOVadmqcmWeydwzvFPJCk9GNfeEGr2d2rmUX9WsbMV+tsvCRGzU75iWstN9JbENbjrDB2iuCIPL2+UbZuVnNAKcB0k70eXW6bVB+ZSESBX/gtjE6Wz9/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771347682; c=relaxed/simple;
	bh=l4JGt0s17ZIlnrn+Bi+No4YmVCpLpe4YysPm+0UmuCo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QJdMrcP841T8qwQho5HHH+ngC02RdLi4M81BTfCJd2a9S3y33P0ACDWQXanq/hd0YIJLRHJgUIG6L073m7wVzAG8pLxyOTjdWaRww+w/6cy0ERW61E7RiADEZ+Z/cnY+jB0935jlMs7LzacJ0+OTHLvHAxxrGzA6DanF2guDnzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WPfz326e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cM13nMvE; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WPfz326e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cM13nMvE"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 4FEEAEC05D9;
	Tue, 17 Feb 2026 12:01:20 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 17 Feb 2026 12:01:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771347680; x=1771434080; bh=lGx8UkWu9R
	MXhnZmjIjYFvF2NLORqobPf/tDHiF+JEY=; b=WPfz326eCRZy3VwMkkjfNXzqvx
	V2fKETGYjdEkFE2uMrLcBuRGjGJiXcMKPmjiohLx6FB+hAqEdFvhKYC0aGwW27km
	50fWpo7sAK50UQZxLQg+OnzgaXUKffoDzSRDsh4RSYLMn/5bQJjJs+efgCrsj6fw
	6YDsvpCD4mexfoakWbzP5QB8IPrB7TlQVjPJZ19e5YVXapTW4DFvSvFhuI7Eg/4o
	jPY7DamKP+l0sOPuoBkCmmT1j37CGeyeqQysFcWlJJ9mfNruT6Mqz85pbi0JZk58
	rJG12fdS6zJTXLBB96w1hQikzPNYilYhIgClRiE0EMzuaRs1QdccCVD3psjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771347680; x=1771434080; bh=lGx8UkWu9RMXhnZmjIjYFvF2NLORqobPf/t
	DHiF+JEY=; b=cM13nMvEgm+1mpqg3TPmwGFU6TlEa8a9zeT3+bKnIkhJAUd4Hfo
	mtXiI2SFEO5owFOQwkVct0pxXLj3MTA/eoitSNZx6YPE9ZJupkZFB5ZIa5MbgD9I
	3yFrf+zOnkiBbpv26vTzMiyaow6vf7QYWK15gQs7aIPmPItbnrLuz2VoBE1HqOky
	tdIM5gI6ufGwhGnRJoTsrbELMgZopvIk2SqV/HgNU15njsdauXLRahQkmiyJ85iw
	bVaqDe+V/LipkVYig3wBBhLziM4Yi7ZzYHD7kM3TPi+ouWeKqpVymPikikyEhyoK
	HkFLc9eufNsiLmUn0k7CYAa1jAi1Kb20tRw==
X-ME-Sender: <xms:4J6UaR_Sr-GHdTBbv4wi4EE8xwvz8mro9qdf9yZTk2eugE8zR2_mrQ>
    <xme:4J6UacsRZwg8JjoYZYigSYvZSwCkStq5U1Oay85vlk8ustmZwvBtVlsmrLqvDaWvd
    HkgpjgDgPAWXRaGeT8r26xb2k6kDiQsQhMxO-EK2zCqzojDNrUgIw>
X-ME-Received: <xmr:4J6UaUAD7QzazIyYNCspk7JyvP5Mf8JUyHdj5TzeGAY1IcWlLa4aXI2fQwOAFToKDDwo4TSq2fdkqtm4KsPWN52XhAveKKp94w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopegrfedvtdehudehfeegudeisehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:4J6UaUXw9clOHP57EES3KyXUWtWZwTA9PbenLtg7Hg9Owlmup05umw>
    <xmx:4J6UaSCBcvbLFTDG2IcOZr1P0-5JalVYgiy6OmssnaBxIdzptOwBeQ>
    <xmx:4J6UaX8I2uYGXPzd4y1jxZlC3Cz7XsMP59bVuL3Fevl39T_4fVk8Kw>
    <xmx:4J6UaZHLdq3O4aJ_9YiEo2aOhDhjQPmLVWTiZ0tfo-i79ZKhfK0shg>
    <xmx:4J6UaXi5fGWcRKPs5YO7V2S6xjrw_IO6zVbHoI412qJZKK-Uv3Cfgha2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 12:01:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Tian Yuchen <a3205153416@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v4] setup: allow cwd/.git to be a symlink to a directory
In-Reply-To: <CAOLa=ZTeTWhb0Yc8rPEv8vONTHtSg3bSvW6FBC-AWrZzi12oCA@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 17 Feb 2026 06:26:10 -0500")
References: <5b29218a-8d18-41f0-8a03-eac707151945@gmail.com>
	<20260217084124.150366-1-a3205153416@gmail.com>
	<CAOLa=ZTeTWhb0Yc8rPEv8vONTHtSg3bSvW6FBC-AWrZzi12oCA@mail.gmail.com>
Date: Tue, 17 Feb 2026 09:01:18 -0800
Message-ID: <xmqqv7fvcnj5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>> @@ -994,7 +1000,9 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
>>  cleanup_return:
>>  	if (return_error_code)
>>  		*return_error_code = error_code;
>> -	else if (error_code)
>> +	else if (error_code &&
>> +		error_code != READ_GITFILE_ERR_STAT_ENOENT &&
>> +		error_code != READ_GITFILE_ERR_IS_A_DIR)
>>  		read_gitfile_error_die(error_code, path, dir);
>>
>
> I understand the exclusion here (they are non-fatal flows), but wouldn't
> it more make sense to add these two exclusions within
> `read_gitfile_error_die()` which already has two such exclusions? By
> separating this out, it gets really confusing.

Absolutely.  The point of this change, IIUC, is that these two
existing exclusions were too broad.  stat() can fail for many
reasons, but because we did not differenciate ENOENT (which we *are*
happy to see and do not want to consider an error) from all other
error cases (which we may have been better off if we diagnosed them
as error), we pretended both ENOENT and all other stat() failures
were happy case and "case ERR_STAT_FAILED:" covered both.  To fix
this, the patch splits stat() failures into two, ERR_STAT_ENOENT is
the happy case we should have been returning without dying from
read_gitfile_error_die(), and ERR_STAT_FAILED is the rest that we
should have been dying there but in order to return from there
without dying when we got ENOENT, we were not dying there.  Now we
have a separate ERR_STAT_ENOENT, read_gitfile_error_die() can (and
should) die when we see ERR_STAT_FAILED, and it can (and should)
return to us when we see ERR_STAT_ENOENT as a happy case.  The story
is exactly the same between ERR_NOT_A_FILE (which had been non-error
only because we wanted to treat a directory as OK, but we can make
it an error) and ERR_IS_A DIR (which is new, and is an OK case).

The above exception on the caller's side you quoted is a complete
opposite from that line of reasoning, and that is why it is
confusing.

If there are other callers of read_gitfile_error_die() and different
semantics, such a "now we die on every possible errors" may also be
a valid position to take, *but* then it does not make sense unless
this patch makes read_gitfile_error_die() to die on ERR_STAT_FAILED
and ERR_NOT_A_FILE.
