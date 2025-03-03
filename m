Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73CD23F28F
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 17:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021438; cv=none; b=Lf1fpvtKwtYCW7IEyhq6hpO3q3yeL0Ysj+Ausaa4zp1lPNjo3r4rufgwyWHfjP0nKiSmwCYSbmySY3K+BxT2Fi5SUysyZbVZdILF+pmmgtqpCkMzbJ2rW6qNkSEymro8J6sPgrlE1XePyUyx7JBxSDAKgMkZlOV25B9k/R5WWRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021438; c=relaxed/simple;
	bh=WIdHBd8WHxJzIvoVTULIOOd9h5hv3lUX2cTpwil9004=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iBNGT26H0XaGqV0Nn+wC+2Ix/KIeaP5O7xuKVsFik7DKNKrbmxfmjocibo/QqlmxRnHh4+x7zwL2dH3tR/+WB6xMSSbf101yby4vtCrFugEzXFpnTJ+YNd3LfSQeQLx0vWZSKkOIRLODrv3g0Eq0ghD0O9ou041Dgc2a9lNrBPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MQtKGNvP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wOO3Wgu6; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MQtKGNvP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wOO3Wgu6"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D18AE254022D;
	Mon,  3 Mar 2025 12:03:55 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 03 Mar 2025 12:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741021435; x=1741107835; bh=zSofFOwTNj
	tQ4OjjMsQEMgZ1ahuQbnF4s2Nxsoi9wbk=; b=MQtKGNvPU7Rh6rBgGZVL5auXoz
	tUkt82nKIzKbg5PBrBnyveB/XoXvLduXM7ey8mDdQT9CQjjuf9aRR4BF3GCRpm6G
	sQzP8/0kFDDdSZ3DiZBfXRQMVmL4eMLG+/V+G2wKbKNM0Mpo8XfbtEue3lUnNzcb
	s2xSOqp7Gng7X1jquk4I8rT3Zn7WSw6thLkNmZP1nDLUbEKDTpQ2qqXhqnraDdac
	vYcMkQAZhOCbreKaTLy5g0imFoZIWwQjNPnV9zHU0ej07g8gqTHgienAuVMdcaRR
	kgDa+f6hSEGkYkMEgioCQIVlZIET9nfGRaqnwRszb6sEMtPsvkHGtmg8LM9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741021435; x=1741107835; bh=zSofFOwTNjtQ4OjjMsQEMgZ1ahuQbnF4s2N
	xsoi9wbk=; b=wOO3Wgu6ah/05gUe5uRRNFzWTnSXP/+IGH9GvxM4HBoCu1hIj+g
	KSsGbrq6SdC0EPnl5hv/CtNhD3sQyF21NQxPu6NRAfWGe49hR/3e/uzNCd944YvB
	GAmKr58a/EzYo4kEW84CPlubQppqjVm1GNKVf9QnfEFd7qxTt2cKb5RVRmgpmy56
	mseQiXbKqE3ooE9LgI2xWoEIir1ja/KQa2vELJz4saqeHJZuRIOJwMTTbU1TfEFI
	/MUIYtA6yuzWAf5lRHpfgREbthEtJ7X06KteoNRhkpPogapwyO74o1um0ghgLh8M
	JR8oGMx1R/0Sk4UGrKJ6Q+ND4Tv6+mwaJSg==
X-ME-Sender: <xms:--DFZx5QnKo3nV-0DElxoTLl236Ad1-CyRdY0qBBFHhwdJMlwjx3aQ>
    <xme:--DFZ-4sJzxPEVpxKUEUHG5syoE6gayrzjuXDf6o-L2weevKJCpqddTeCNduJgVJR
    gdU8lpp7W_CWUROSQ>
X-ME-Received: <xmr:--DFZ4dN1JWGst5eYXwjO94AZHQTkDRP20KtfQz3ufjvSadqOaoNTW94gmuYSUl8freMBnKbzHLxXPg0UDYKa4YN4wJsNgN5gqfx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhirghluh
    hosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:--DFZ6K4Y1iSF3z_5npQJwaQF-iOLK7DnxjYfemrWwbLqxkkimMcnQ>
    <xmx:--DFZ1Lt8idJ-Uvqer89penzTU13hSnGicWmDZjmBYPPtghmk_1R8w>
    <xmx:--DFZzxUJajqG12K8wbXlokcnqH7C4NZ3Kb7DfDoL-dDg5jWna0_xQ>
    <xmx:--DFZxJXgEMeceB4H4fDA68OfGCATTqty4T9CI8FUgrYaO9v2NKhdg>
    <xmx:--DFZzhoIb7CDuDjBcIxCPijlM5eUKoJ0g2fRJ3nw6sBjih3ibg6cZ8F>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 12:03:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,
    Karthik Nayak <karthik.188@gmail.com>,
    Patrick Steinhardt <ps@pks.im>
Subject: Re: What's cooking in git.git (Feb 2025, #09; Fri, 28)
In-Reply-To: <Z8XJnJEHZd1dFE96@ArchLinux> (shejialuo@gmail.com's message of
	"Mon, 3 Mar 2025 23:24:12 +0800")
References: <xmqq7c591sus.fsf@gitster.g> <Z8XJnJEHZd1dFE96@ArchLinux>
Date: Mon, 03 Mar 2025 09:03:53 -0800
Message-ID: <xmqqldtmvyfa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> On Fri, Feb 28, 2025 at 04:45:31PM -0800, Junio C Hamano wrote:
>
>> * sj/ref-consistency-checks-more (2025-02-27) 9 commits
>>  - builtin/fsck: add `git refs verify` child process
>>  - packed-backend: check whether the "packed-refs" is sorted
>>  - packed-backend: add "packed-refs" entry consistency check
>>  - packed-backend: check whether the refname contains NUL characters
>>  - packed-backend: add "packed-refs" header consistency check
>>  - packed-backend: check if header starts with "# pack-refs with: "
>>  - packed-backend: check whether the "packed-refs" is regular file
>>  - builtin/refs: get worktrees without reading head information
>>  - t0602: use subshell to ensure working directory unchanged
>> 
>>  "git fsck" becomes more careful when checking the refs.
>> 
>>  Comments?
>>  source: <Z8CMx7O19PMs9sVY@ArchLinux>
>
> I think I have addressed the comments from you, Patrick and Karthik.
> Could we make the patch into "next"?

Mine was merely a small kibitzing on the logic flow structure, and I
didn't really looked at the larger picture beyond that part of the
code I looked at.  Let's hear from Patrick and Karthik (cc'ed) if
they find the result of the updates satisfactory.

Thanks.
