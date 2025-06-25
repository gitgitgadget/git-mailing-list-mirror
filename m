Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D893074AD
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 20:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750884453; cv=none; b=M+e0tkI/sYYQVkAeCnqfRrrLIxrNB/ns0tmCtbGWUS8TR+zA953ZfNyelTKJNVy4Fpt4F7aWvUDd6fEqdiuPSR3va7etakOevrLrwzis7fEiYfrANUjmS86h60J7V6x47CLGSaeRVME4QYemSCWGsrTnGcw84Vr0Zq4Hg4uQgS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750884453; c=relaxed/simple;
	bh=h5xH5sYyYl3/1MR4E8BJLhv52R68cM2ZV1weO8SF4dc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hvexLVZbwLWBeWCYyUkOWtsS4SSI4ehs7iU3JIQLZ39+jxA54nwYg6IYER+dkaQbaVRf3J1mUrEiZiCQ9HgbfsMob0H4PUDQc8LhW6xG4x0Ku0BgMvCD8/JedINLhoGPWwrzTQEFR2PEg2lcCGZilNZyvUjUwyfOsS25tr/an1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GlKKmUvA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dqeDZ2gS; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GlKKmUvA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dqeDZ2gS"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 3B561EC018B;
	Wed, 25 Jun 2025 16:47:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 25 Jun 2025 16:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1750884450; x=1750970850; bh=BhsCpQ4bhj
	potqxtbjxCdTg1lac364nqd9HGmDczxJE=; b=GlKKmUvADC3pfymkqlG/BPhJmy
	pMNzYOTsFVjBUWooAR9LRTBijSdSLh30TI6pbT8DK0o/sR6nVra/ewsrSI9UPnGm
	L/L6uXFOWGaBBzRbEN+Afr1X5AkSjSjkdAhwdfjn8HIrfkWq95AxHzRE7tIHLkt3
	iAdkCH/UcLPlLCUL0W2Zf42pFzS/4pVLikUx2tEPZPa/YoK8/TJ0/UdnAZvpF6f3
	eXT6y/IZrbk5yKxu//UyRREkJtiSfVM3UtwZkxqQoudK4NBYyDdb6hIMfH5FQPF4
	LjVNfbIvwqU4vkTXia3K+WsCUOjBDCZ2/3dsQiuqOYuwQghdf4nZrhW918Yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1750884450; x=1750970850; bh=BhsCpQ4bhjpotqxtbjxCdTg1lac364nqd9H
	GmDczxJE=; b=dqeDZ2gSKO3j9RbUgCDw9QGpkiiPC8L1ZrUlCZvSYZ9wSJ3cMye
	tVuhvq9Ye5SVXScS76ruMkCuwZAroQmKkDeO4PnEN0W3pKi6pWLeBM/Xz12oqrjP
	oGtuzMkUBLcVp1+vp+pT6N2yzQCfiCwQBMOYJP5IDLVYfDK4BMB2pXItqn9PmfHt
	axDzJqss+8j6G3AdO0X9/3tRUzKMKCyfPg39MQNRiRr4Gez3w3c4LfoqTBYZhN8s
	CQ/DbCoxAcJgUJ3IHjjgGeqlQqQ47lVMpF+x2XsAMHaVk1HpULHblahd6Foc1agR
	EAE5RnyPYPTnFc2ykofnJ9Hs2GcLb87Zhdw==
X-ME-Sender: <xms:YmBcaNSQ47Lfw-ggo2Usn0My4bCvOCwlSrmBL0ZxjNiUnUDqMVuN6A>
    <xme:YmBcaGw-aUJ1g50b_I_DR_hpfJbRVSTD1iuQr-2_DJHrbiSgu2ICQn_x3YQwrhoLN
    znLewD07jnYsTOadw>
X-ME-Received: <xmr:YmBcaC301P84xZixjNOGyDXH7EVoa_-8NuvGPiD2a2KVQ7zaJWy0nIhk0rQpa9lQ_YtoiJ8K3oIPax5U4nr_e47AUvI_MYHZfbstC5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvfeejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmihhrthhhrdhhihgtkhhfohhrugesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:YmBcaFDRa6WfQVqoFqxGxPbLdtqc43gPGEsgYu4GiyCKCW98F19xAA>
    <xmx:YmBcaGjD-d7ezgBjwc4YHQgP3qrADxZ5Pb9BV8n2S2PAqcbmVUwfdQ>
    <xmx:YmBcaJo_rioQkUOzZ7CXm6FM00rTKX4apnKmsByiESKyiVNTGWGvTA>
    <xmx:YmBcaBgC61lHUZXkrhUk_Z9MU7vtHh-dN8e26mS3YUPVjaQfNKWxYA>
    <xmx:YmBcaCdp3s42CUnkHVaZZr8OhGSPCV57uksRIi1n9LK99y5luvBHEv-P>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 16:47:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: M Hickford <mirth.hickford@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: How to exclude tagged commits from git log <revision-range>?
In-Reply-To: <CAGJzqskFuQqLHgFk97S9uaBB=iW2Ni=NWokHJzMV5rYGsCOG4g@mail.gmail.com>
	(M. Hickford's message of "Wed, 25 Jun 2025 21:30:00 +0100")
References: <CAGJzqskFuQqLHgFk97S9uaBB=iW2Ni=NWokHJzMV5rYGsCOG4g@mail.gmail.com>
Date: Wed, 25 Jun 2025 13:47:27 -0700
Message-ID: <xmqqikkjtuow.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

M Hickford <mirth.hickford@gmail.com> writes:

> Hi. Is it possible to exclude tagged commits from a revision range?

A so called "revision range" is a set of commits that are defined by
reachability from two sets of commits, one "positive set" and one
"negative set".  A commit is in the "revision range" if and only if
it is reachable from one or more commits in the positive set but it
is not reachable from any commit in the negative set.

> I tried
>
>      git log --exclude=ref/tags/v* v2.3.0..v2.4.0

"--exclude" only affects the selection of "positive set" commits via
globbing operators like "--all".  When you say "git log --all", the
tips of all refs are thrown into the "positive set", but with the
--exclude=<glob>, the refs that match <glob> pattern are not thrown
into the "positive set".  As you have no "--all" or "--glob", it has
no effect.  Your "positive set" consists of the commit tagged as
v2.4.0 and your "negative set" has the commit tagged as v2.3.0.

As "revision range" is a set operation (i.e. compute "the set of
all commits that are reachable from any commits in the negative set",
and "the set of all commits that are reachable from any commits in
the positive set", and subtract the former from the latter), skipping
arbitrary commit in the middle, like this one wants to do:

>      git log --oneline --decorate v2.3.0..v2.4.0 | grep --invert-match "tag: v"

would generally be impossible to do.  If you want to omit, say,
v2.3.5, that is reachable from v2.4.0, and can reach v2.3.0, but
cannot be reached from v2.3.0, "excluding" it by throwing it into
the "negative set" would also omit anything reachable from it.

