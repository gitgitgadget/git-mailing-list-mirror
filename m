Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD65D17DFFD
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 17:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716108; cv=none; b=sj4eNrdEWmSDnT4MRJO1n7CTr6rh5HrKlvEG5UjjjuvM0izg9NVaXflQsT+OANjCe3zLWVv8DgPmf5F21k6FDu/TgtNcfJ87pL5N7fkdPkCIME+l3Fni+a1z3nEBWdtTkXpzgBS1Hf/7+oVyxEPwD/J4ScSfsyLagU6kFtCLY/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716108; c=relaxed/simple;
	bh=V8Nc08fAI7t+eG7y2LaruDUiMiJN2HLrrPApI4cA1Yk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lHsZwbF9ugP4urm1PtCComFkXEw8zOkoDeLYKFvzVK/yivmfTUskeWioGtKlYgRRTW54lFupLjAMxUfiFu69nf5SuGE+vPiVk4lRFK6wuYFdB+omo2+1jVInceqezE/Ofhkipgxxyq6bVb/7bKkw/aiZ/ta/5h+6BrMCp8zUDW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=M+e69G5w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bfaIPlPe; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="M+e69G5w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bfaIPlPe"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B49321140408;
	Mon, 30 Sep 2024 13:08:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 30 Sep 2024 13:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727716105;
	 x=1727802505; bh=OBTHBCESnhnU+gbsH2Vw8R0YImS3JNBTv+iv2nqYkuA=; b=
	M+e69G5wqcyLJFqiPJGBu70e6V6/rPZ9GkrodPNLbslMtYi5r+1yrx9215WMgL+9
	UybrpNyAQiDcblu9MU2tMNlBhvioQIC/2DUWmpscsWBAGZIIT8oBWi746dO8bK4u
	rfBKeJ/wpRR+tJDwL5GD/670qLYgfKxkLDEcANE99QLjQS5ovLhKVt9naShKvl7o
	622w81qUW6ErTbCs/exj2YWs73H+kLUpuQQZg1kv4TnVfkUsnN4NPsZ+dN29zfm8
	y4jwXIpGpau+g7ExKeb6onUDDR+fcNWj5aSdRTgvVAaU1Tk7gfEYTPcn1rTgJmiI
	K7EOZOcfMl2OQMUfdNdjSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727716105; x=
	1727802505; bh=OBTHBCESnhnU+gbsH2Vw8R0YImS3JNBTv+iv2nqYkuA=; b=b
	faIPlPexLJ9I7B/vUweZI31Pl07LaU11cPpiW2lct85n0VteyFkJjycK0Wj5qB20
	9GxBxwGIxCjJND1iX66sEjxidnU6Wr1+uzAcdG0r3RIgCilvUEBYClEB+kJ2wpFF
	kpityr9a9Qod3wa0Vz2sOhJ1gnd+xIckT6glrvMuUL3tJxgRZHaZuyax45Fr2YR5
	3bJrhhWWSodsGGkjkEnxhMPfK8jr5fEgOQwdRQvG0NYI4SoK5J3Gcv5JTN7U9FqC
	Hhaf6GfoMooMnAJheV2pcPIYP+/38yJIntO++FQOKj0xrJ+iJEj8coDfG3cpKgM2
	5Kt7qX9WvsA6JqGaw3oeg==
X-ME-Sender: <xms:Cdv6Zt8zZZta3hM5AfP7H11GxcMAGMkguQ-xZolgf35MH2Qh9Elrgg>
    <xme:Cdv6ZhuMO5LS5KuySgqA2Cnh2L0K6ZCGafz5jkf5-JP09jDdAA1VL4Q47fuyRrE9L
    8VKEz_-LKDWaE-zHA>
X-ME-Received: <xmr:Cdv6ZrBBf03_oK4xZmRfmGVBoWjjr8CdduI_8SZ3U1syiYAYJhYeoNGif6AKSj4Hh0whPbEJ6vNErTSDM7WvR5gRu4g8t4qVzCQNDO8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepjheith
    eskhgusghgrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Cdv6ZheEVsfCJfdl3SW65eC2hv-937FhXK1gHVcV2PMEldFGSAQDcA>
    <xmx:Cdv6ZiOs-o2ADQRcoh6bUiCD6GuTOoPpiyJND-rvOhVSzc02b8aiFw>
    <xmx:Cdv6ZjlZjTV-uan3NMdY42affoCDO1lSV9n4ByQd__Kv8U59jLzW0A>
    <xmx:Cdv6ZsvEgewxKumCK5tFWP6GAlRe0PyzjkjRFqyOAo3uGNtBLfM8-g>
    <xmx:Cdv6Zp1pgVmrRa2kSleBS5tZWlCdtj9-satIyfwmlCxZhQpZry6N4KTj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 13:08:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>,  "Johannes Sixt"
 <j6t@kdbg.org>,  "Git Mailing List" <git@vger.kernel.org>
Subject: Re: How dangerous is --committer-date-is-author-date these days?
In-Reply-To: <93041214-4774-49eb-b8bd-24648134cded@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Mon, 30 Sep 2024 16:49:32 +0200")
References: <6af09726-e3bf-4903-87ae-9524ad334678@kdbg.org>
	<aa981bb7-dd3b-4e63-9769-0fc2559983e6@gmail.com>
	<6d6b2ff0-b4e4-4442-a3be-9b31742db280@gmail.com>
	<93041214-4774-49eb-b8bd-24648134cded@app.fastmail.com>
Date: Mon, 30 Sep 2024 10:08:23 -0700
Message-ID: <xmqqwmit83y0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> As a Git user, I don’t understand why some people want to fiddle with
> this field in rewrite operations.  It’s very hidden (apparently you have
> to use something like `git log --format=fuller` to reveal it).

FWIW, as a Git user, I don't, either.

It is justifiable for "rebase -i" to be aware of the option, merely
because the underlying "git am" had it.  I think "--ignore-date"
option falls into a similar bucket, but it is of lessor evil between
the two (at least I can see a legitimate reasoning behind use of
that option).

> I can’t speak for power users.  But regular users?  Well I see questions
> about being very deliberate about setting this field on rewrite
> operations on StackOverflow (at least one time).  But I can only guess
> *why* they are particular about it (this part is often not explained).
> And I don’t know if they know the true “spirit” behind the field.

Very nicely said.  There _might_ be a legitimate reason to futz with
the committer date, but I do not think of a good reason why it makes
sense to replace it with the author date.  They are separate fields
because they mean different things---your mention of "true spirit"
is spot-on.

> That option was added to git-am(1).  So not a rewrite operation.  Rather
> a “lie” (as it was documented on that commit).

Yes, I do not offhand see a reason why the option should exist.  I
won't be the person who says "no, it is valuable, do not touch it"
if somebody proposes to drop it (from all places) at a major version
boundary.

Thanks.

