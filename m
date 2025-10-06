Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526B3221FA0
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759770408; cv=none; b=Ir2sysbGOKg6l2I7yKvhibXGEi3+WmugW4tVeH2PJVfGqOWjEcNMwsmBrFUUQ0fZ7A0FSpkrSqDYe/vYkoBGnT5SJGNi0IP49p3vW3dkQuT2H9PGqQoIsWx+1XdOX4cR+PjMlCMwdLXzNw/IALXnlvgLfFCZYfbGZ6GCoRWCTlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759770408; c=relaxed/simple;
	bh=M6J3+p5/e1QLMScec1rdDlhvSs6wZkc2lzl567M0v8g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AKX4jJmwnmGICHPN+irG6Xex9YgiUWU/fw+r2qG7Fmva3UGF59uWR8PdYARbGF5U1WHPVWnov4fjBQ9tPLZmRt2X17H09/hxRm16n49I/nJo4NcvpYRfOkXjeTbb5mGhwS/kHXlD75/egddju0P8uQ3kgS7cFZHmk343u+CHEEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=I7WonGch; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZwIba+hY; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="I7WonGch";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZwIba+hY"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 598337A0102;
	Mon,  6 Oct 2025 13:06:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 06 Oct 2025 13:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759770405; x=1759856805; bh=pHLWQCHWH3
	QC0KWURImwFcTDd66bDpiLCPu0JEdNigM=; b=I7WonGchvOmam7lUUaU3Pva/XJ
	acPMOjuAxHYIwpE69Fno7kBMrM5vrg3wee7ut6JI+CpCOPA/+rhSCBtvK50o9O72
	djuWqj7Ca0ZYnQV4k76JSQx9O4tFyHj2gK+27VzEVAREVFtXX/ZqyNQJ9OZd/XiQ
	PtsVvcLuu70xZyh7xufQFK0cmk5vXTkE8Z0S3/gzdzVsWCCp21l6AVTfyU0NxoWF
	uN0dgWA4pUHvGTMEV4g3l5avVWwS4jq942M5EpblisOOSWO0Iyb4joNAtUzeNpJi
	Z611F2vZGPlVWvPy1dfyJlL3/XkDoXw1YVigXSY4iAphVj9pCLz56f7j4VkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759770405; x=1759856805; bh=pHLWQCHWH3QC0KWURImwFcTDd66bDpiLCPu
	0JEdNigM=; b=ZwIba+hYtMkFWi1N1//CEUa6hKxYwpI0TvK70dllLZ1/IHPUREM
	5BMvq3MYzhGRPZQC05mM6Rh1qlshaMJ/4nhYXf2bPiaIdF0ZRhrDuTQrSXSGgJo9
	Gm36lAbcuVFd+tPBULqf/3fOneFGmVlzdjlg7o65yMMOQHbyqV63juR9Exq8ViaD
	VT5rreJ1pmGHk9INcGH4/U+Ics9uCBRGm97Bxd5vzsIWfiuvim7g8Yr2VKwvQo3Y
	CEb+XjbLB9cJg6UfWKG5PJSDn2TC8ry09clVBBSxWd+zuO0IssEDJvFnK6hS4eA4
	BRFFDc3R1W8ytpZu4cGCg2GCu4XnUy53nDA==
X-ME-Sender: <xms:JPfjaHWUKM2IJe7TTEWh6DQZ2texMSFy8mILU7-dIE6jhaJZeMN26w>
    <xme:JPfjaLa-td6CkT-GeA31aikxGKXEuIoRGI6KcHU1syYg5BMuj2vfvMoYE7M8pvXK0
    SCLAIGnNbq9Q_68LU5Shf9T2v0bI7FChZwanLiSZP0FBam-8bjtAg>
X-ME-Received: <xmr:JPfjaOzw0ojUs-EVuU4_FLycM8wxN6o_vHOsi_QESR8DyWlP1BRAP_GRyRPUWB2HElFMNJ6wdHDOsXqqS7ynClzef5h_SFpvRrvq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelkedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    eprhgurghmrgiiihhosehgohhoghhlvgdrtghomhdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtoheprggrrhhonhesshgthhhrrggsrdgtohhmpdhrtghpth
    htohepjhhrnhhivgguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhs
    rdhimhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:JPfjaL3ZgrqvG-AErRO7SthXeZGyqtNla9xwNehXis6-_ruEiBySZg>
    <xmx:JPfjaPkZHeBDD8631NQI9c5xQsvdLVXJD__SJmWoFSkHDBpiPVHo7g>
    <xmx:JPfjaK-WRJx5fzGstC-zw8f9rhsHu95Ufd10gfqJoXTvEV7h3FRBjA>
    <xmx:JPfjaFJwgp3gd-bak61gjUrr0EWweIGy9DL8A7drVYYz_lnm0g-NnQ>
    <xmx:JffjaFxBIzCyxiH4BD9ktCIIwxGsfPeUSe_dVR65iKV3B44lom0ojigk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Oct 2025 13:06:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Rodrigo
 Damazio Bovendorp <rdamazio@google.com>,  Jeff King <peff@peff.net>,
  Aaron Schrab <aaron@schrab.com>,  Jonathan Nieder <jrnieder@gmail.com>,
  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon <steadmon@google.com>,
  Ben Knoble <ben.knoble@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 5/5] submodule: error out if gitdir name is too long
In-Reply-To: <20251006112518.3764240-6-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Mon, 6 Oct 2025 14:25:18 +0300")
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
	<20251006112518.3764240-1-adrian.ratiu@collabora.com>
	<20251006112518.3764240-6-adrian.ratiu@collabora.com>
Date: Mon, 06 Oct 2025 10:06:43 -0700
Message-ID: <xmqqy0poot7g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> Encoding submodule names increases their name size, so there is an
> increased risk to hit the max filename length in the gitdir path.
> (the likelihood is still rather small, so it's an acceptable risk)

If it is acceptable, can we ignore it?

Just stepping back a bit, how are we keeping track of the mapping
between submodule names vs locations in .git/modules/?  Don't we
always go through that mapping and would a half-clever code that
says "heh, that is url encoded and I know how to decode it" and
bypass the mapping a bug?

If we keep track of the mapping ourselves, then the names under
.git/modules/ do not have to be "decodable" by themselves.  They can
even be sequence numbers and that would not hit any maximum filename
length before you fill your disk.

No, no I am not suggesting to use sequence numbers; something
remotely readable by humans is better.  But my point is that just
like you have to make sure that the encoded name you give to a new
thing does not collide with existing names (you know with "ls
.git/modules/" what names are taken), you can notice your mkdir()
would not error with name-too-long, truncate and twiddle with suffix
to make it unique and retry, without giving a failure to the end
user.



