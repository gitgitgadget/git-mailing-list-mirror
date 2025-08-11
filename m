Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D354A1F948
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 22:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754952171; cv=none; b=JsjSm/1h4bzB2gA1q2WHq+E96fQnn2O25/H8VdawEET2U5R2EI6OZGdrdfl02AeLtU23srSAn4BtdkN6jnTeMLQOa+DWoUW/CnIaqm/gpcI9lsEMO1NlBEuXCzhSYQeYLtANUDdSUB9SOH6ypO5X9rV0Gv0pXjYik7SlueIqsXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754952171; c=relaxed/simple;
	bh=S5w8w7TPvI+SN1Eg1vv7HqAzOkcF9qAkjWHcCH7us9g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=inElL0H5aGsyFGoicaYRJLTqIqkl+Lp6eTlvshDltAw9mThctS/LGnHFDMIOAk9224jV5Vkb8Mz71F87nZTJBBAG9JZg6dnhSAcl/CHrtcpcZmzxViqNgfPAhzWs6yeye1olMpyLXSDtGSEXehPxRWji/KVMK0MT3FITINelfTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=XWyGN44O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MDUFv1Sg; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="XWyGN44O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MDUFv1Sg"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id B8CFC1D0002D;
	Mon, 11 Aug 2025 18:42:47 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Mon, 11 Aug 2025 18:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754952167;
	 x=1755038567; bh=M3hkz0jdU+btvoQCGW/wh7yGXCzWBrKkG0QmnWbZhQU=; b=
	XWyGN44OWCWgs9OXU0PxMVuFWRTu8g2VWbBGtT4fQd7+RisASanPd9vPLmI7LT4o
	IOM0IBE1d+o5lYR1UwMjbPgpS5A+CH7bnPliTplJi5zeCEG+hpeC18aN+jw4Bxhr
	AoSMhBAm8WsFnzFMO8IvqoBcSE9VVKzceJI+RedYiw65NIy+IxDrEMs2XSdnbrhl
	LArB6pi1fvkFgWsksHPtEfX559BU4Ep9GCuh/Q9uh3BM8KCvbh9QAlJNB/Zirkr+
	59GCRZdZc5XGCLB19MmUgd0CSwC6mT4owxlo0VxhnhVcHHvl+Ubrj4ovXv5e/G8p
	1xQSg4cD8RUF/rD/chyPog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754952167; x=
	1755038567; bh=M3hkz0jdU+btvoQCGW/wh7yGXCzWBrKkG0QmnWbZhQU=; b=M
	DUFv1SgVnNu4Fdahwo07qs9Q/KaDWMSOxC45qOqGPT2G8bW/25mkNMeMWvKQAGeR
	Ffh9YFFyVzJDYHboFFk6QBKOSoSmnk6hgLHpNM1nx0Y3ytQYYBJh4PSKxk3ravFW
	ILC+j1N0tHLRpQ7j6o7XC/bl2iHjicS1BzaIRw2PpU823p/uSz1JLU5HbaZ9jzZz
	jm3QoeUMbUr3bxNTXJa7+roxcyGiKCJy9yXOy34X2KtZW6whBU+OOb/gq5wGHkEc
	cvyf7lGTe0918KAZt01tyhHC47bo/r2lCpeGga2yvzqjijEhHKW9vuiuqQACGxhp
	yu38vAWE/62O01MH8lRIQ==
X-ME-Sender: <xms:53GaaGxO2FZhhmM922kW_jP3SpqfolO_8i6jryPLckaNs1tFjT4eIA>
    <xme:53GaaCSIFIyjJQAKGHBKmjvmFOlNKnFB4sAKpg9qaNL56l1X0OfmYZFGf1PQH2a1v
    4LkFRPT36p9m1xn6Kc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeefieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epgfevkeduveeivdevueehhfdvteeggfffudefgedutdekgedtledtvefhtddutddtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirg
    esjhhvnhhsrdgtrgdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhi
    khdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhoug
    duvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:53GaaOhWm2--3mu16wnFN6xvhjfhU_Av_iXYZOMyKI30JANnSoSAzQ>
    <xmx:53GaaC1FzaooTxyUHRgIk3Dh0DrTG-7bHqsVr2Sd6Iq9SWm8rcwcKQ>
    <xmx:53GaaPJBVkNQ7AlGcv3SPymMwD2sZl4nbNauMyKpRTlmonnapPGaqQ>
    <xmx:53GaaKzb60UDCl6CYtQMKK1zotJz4zY0wfKRdn1Fej13N2tKGiTIyA>
    <xmx:53GaaBQKP6dxiiwUp7wg4iv_vr2Tu196cU6jto5P-Cz19478JXEifRDm>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 55CA57840B0; Mon, 11 Aug 2025 18:42:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T08f282b3dd0e28a1
Date: Mon, 11 Aug 2025 18:42:15 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>, "Patrick Steinhardt" <ps@pks.im>,
 "Karthik Nayak" <karthik.188@gmail.com>
Message-Id: <fb35edc9-8c90-4a71-9c75-4c83a8f1718f@app.fastmail.com>
In-Reply-To: <xmqqh5ydzf00.fsf@gitster.g>
References: <pull.1949.v5.git.1754943127.gitgitgadget@gmail.com>
 <pull.1949.v6.git.1754949075.gitgitgadget@gmail.com>
 <9c7f2716bc8dca2a73f7c8a994ccb8ed4a66fd9a.1754949075.git.gitgitgadget@gmail.com>
 <xmqqh5ydzf00.fsf@gitster.g>
Subject: Re: [PATCH v6 5/5] doc: git-rebase: update discussion of internals
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> So, I do not mind #2 described as a separate step.  Conceptually, it
> is between "create a list of all commits in the range and filter out
> what have already been applied" and "create a list of all commits
> that are not in the upstream yet".  We may be able to rephrase "all
> new commits on your current branch" somewhat to make it unnecessary
> to describe #2, though.  If we are willing to stop talking about
> "This is the same set of ...", then the description becomes very
> simple:

To me it feels relevant that `git rebase` is using two separate mechanisms to
compare commits: the sha and (I think?) what `git patch-id` does. As a user
it feels like an important distinction because normally when I look at my git
commits I only use the sha (via something like `git log --graph`) to see what
the new commits on a branch are.

Maybe the second part can be rephrased like this to emphasize that it's using a
different mechanism than the SHA:

> 2. Check whether any of those commits contain the same changes (according to
   `git patch-id`) as a commit already in `<upstream>` and remove them from
   the list.


> The line is getting overly long here and a few lines below.  If your
> editor has the feature, tell it to auto-wrap at around 66-72 column.

Will fix, and I'll add a pre-commit hook to check for that.

> Force-create-branch while checking out is `git checkout -B
> <branch>`, not -C.

Will fix.
