Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AED220F2E
	for <git@vger.kernel.org>; Wed, 28 May 2025 21:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748466969; cv=none; b=bcDQmdInWbRyKr6q986L1By5JjP5lnry2EOYYNZ9NvdIsyhQV85aEQknB+z4Vwb7qbCI51RXqMtaMd3umhQiaJkqb/Omfrk/5bFbdCAL16oOiMxNHtCCYIlFhe8OlbMcds+bfY2rJOd4xK5vAa+LUWZrwTrY8qGvBLoulYgZD68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748466969; c=relaxed/simple;
	bh=eXfAKFFwhE+x7nn3ome/m7RL9j9dYsGKuynQbGsIn4c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RSst45ZKQ2nxBH57XPW9f6ouHyrKMJX84LPKTh/LFf+/Bf2AWtkn8PIdQwv3V9IKVU9rfUljIFeImJJyVU4QkXvQtA0EIdgo6YQilRe5jb/WHxvKQGkDk3QuKVpQP4Mvjo6hmkD3kdgOLne4RXSnZdRmWaLiG1ZtpcLevJrF3h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rHn2lt4g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hIF1LAQZ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rHn2lt4g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hIF1LAQZ"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B87B1254011B;
	Wed, 28 May 2025 17:16:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 28 May 2025 17:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748466965;
	 x=1748553365; bh=SQPoHO9+KStcGCdGt0NWwblrgcrUjSJgJaLbegomrX4=; b=
	rHn2lt4gWr/MOgmnIGKAZrQtuKyEvYhBfcESz9kd6KutHQDYbfA1BHe7ebAt8Ohm
	weJT86K088JCT13ORXduaJFNJTmHKJhDDvLJtofK3I87optplnMzkrPg+ICgMo6y
	eC4U6agy5qc6Hcv+nL8Sukb5bZLpwpqIGP9MqVC1dzIwIrWVDYwD/LpDBJA31Ctg
	wIdJVMzRmzdt7RW7AK6aqbt8lqb5ZEBXQXVqijJd2kbnCeIZks/BKYYSDo8vTrPp
	SDJoObn5LVAAUCdZcgqk2eRnSEmANKqy4gp+tEYLrhOHsuYwybJnjyPMfkqSP61N
	ejojl3z6cjhD7+sOAh7Mbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748466965; x=
	1748553365; bh=SQPoHO9+KStcGCdGt0NWwblrgcrUjSJgJaLbegomrX4=; b=h
	IF1LAQZO0+DY8pU/k7Cb4h5ZGHZLdgeqGfc7DtsaFWY4wYF9j00g6ZiaudvsM9lr
	4ITgKlLfsAXaeJ05VDJn3Cjsq6dgQjebFbsS22ICFJ2sap/VeCpNK1M7snzM4h3k
	d27oZZMIfV+HwScuWaq3df2olEU4Xp05TUHpkndv/ptdvB3I0+c9EYpZMKuatTHm
	gt6RNBjjoF7DXihSXlEUp4O+XvNBXvG7MdKkyHnYC240hS71dqkVyYZJ6Xdwaj4o
	ybHPWMW5lWtUzCtMUS/4h4Uk53GXo/Uh2HWbJVg2G16GAF2G4k2zCgZo1fv9xnlU
	m5CO67gOr2p2c8EsDtZxQ==
X-ME-Sender: <xms:FX03aK4AO62Nl-PV3BkSxg9f4O7VcNv0ZWQJxWH7xwwiN3Xy3QJQZw>
    <xme:FX03aD66GZFga9vIVLhF-kHTsoanLVUfrGIdWASAazD5qhuHljpWtJuqs2yYvk0S2
    I6zOD-MW_xfjnKjQg>
X-ME-Received: <xmr:FX03aJdY0FE1uV1hrsV1wm9E96vzCzmw7fsUpbwREq9Sl7O9cHPAmc3y4nFTVpNiXqcqvWwV26Hf2YWTM3J9H1SQeSv0nxnuXrGkrpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvgeefudculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtgfesthekofdttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouc
    eoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepkefgtdeu
    vdejfffgheeufeeugefhtdejhffgkefhhfetieffteehleehtdfghedtnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphho
    sghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgt
    ohhmpdhrtghpthhtohepnhhosghoiihosehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:FX03aHLOZOcAg9Dbem66q1xN1B7kaCEsNXgd4lOoNkHHNKXdd2jofw>
    <xmx:FX03aOIWwoASn7vrwJD1zxcjr_jFc02OxVh_V2C1DZivCMsZokvAMg>
    <xmx:FX03aIxmcci_XmcFpKdfNlUb0Bk9_XsDUVM-AyI56LWzZHDUanaYDg>
    <xmx:FX03aCIDGJ5zAlnOTJdmohUZHzuHdo7G4ucZGb1Txd1TBAdOyhXj3g>
    <xmx:FX03aBW8YKypX66LvP1eivE1vuaAV3rpTTLEWIv0pWXDWXTheKJo-Wsq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 May 2025 17:16:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Jon Forrest" <nobozo@gmail.com>,  git@vger.kernel.org
Subject: Re: "git commit -a" Doesn't Add New Files. Why?
In-Reply-To: <09518eac-948e-46be-9cd2-64304e78af81@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 27 May 2025 18:43:10 +0200")
References: <1014npb$rbl$1@ciao.gmane.io>
	<09518eac-948e-46be-9cd2-64304e78af81@app.fastmail.com>
Date: Wed, 28 May 2025 14:16:03 -0700
Message-ID: <xmqqzfewqvvw.fsf@gitster.g>
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

> I think it makes sense to only include tracked files.  But (in any case)
> when the option was added[1][2] it meant:
>
>     git-diff-files --name-only | xargs git-update-cache
>     git commit
>
> And this `git diff-files --name-only` prints tracked files which
> are changed.
>
> Given that you apparently had to pipe filenames to a command that
> updates the cache (obsolete for: index[2]) and then do a commit I will
> assume that mistakes were more costly.  What if you piped in all changed
> tracked files and untracked files?  And you forgot to ignore your build
> artifacts?  That’s more things you have to undo.

But .gitignore is your friend these days.

Given that a precursor of modern "gitignore" did not appear until
fee88256 (ls-files: rework exclude patterns., 2005-07-28), and "git
status" started to pay attention only at ba966b95 (Teach
git-status-script about git-ls-files --others, 2005-08-26), it is
understandable that nobody was enthused about grabbing any new files
out of the working tree back then.

And unless you are total newbie, you would know that you create a
new file far far less often than you modify an existing file, so you
would be more careful about avoiding to include new and unwanted
files than forgetting to add new and necessary files.
