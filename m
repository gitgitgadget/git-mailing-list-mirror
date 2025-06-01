Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FABE2DCC01
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748795911; cv=none; b=ruwfbLTAt+1HOuoN7Iq1rCBJzLsHH2AkOMwKcoxct/C8FoviEDsDj2njiImQOBjpPIYAOk1mgaUWcOabKQXrYfJ1eqKUuZgdQSPkjF73DwEJaIIHHfXmRP9VQBE2RJbSsNGanCgGAswAErXw4KbdyWZZEPe2WlG0KJuJmZjaI+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748795911; c=relaxed/simple;
	bh=QG+sQ15IADqRGWXm7MAxJlkjOPj2ywA6FCyNpNa1Ccc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LGx70/tQsEN/ndV4a1wzOiRbmm4UkIJ7MFyNl+GklG2h2vcZ/88tQQbiPnYTs+J8TivpLtPY9FdZhwLueOH1u9RCybMkKYfhM0tbF1pi4KWPcX3wkdHisoAtkQbEcriQ9oo0wIvI41tERCpapzvAwqCZhfdB8CiQQqwD67YUbPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=p1ZWXLZ+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pH9cQCKc; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="p1ZWXLZ+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pH9cQCKc"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A5281140189;
	Sun,  1 Jun 2025 12:38:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sun, 01 Jun 2025 12:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748795907;
	 x=1748882307; bh=nER7rpY1od7+oqNznuPitHt1lfolL5JAE3pxx0htv5I=; b=
	p1ZWXLZ+tMcKVH2y6xRhNVi8n2x4LPt0Ny2vHcjWcY8v3cPIBAahjcO0ZhQly2+H
	dQFiTbJQY7JID6IW6g484q4rskj3amEYQeatPz2L/61HQPYT4qPnxk8TUNw4lTil
	xuBiRwzlo5soehwQFUPuIDj9bR6C/3s/CrvPNtFxMWCXyFNmowLZDOWSPmMF8cIa
	oQ/gqgGeD5dUX9j+CmXPra4qkfe79GFU4T8DRAXfUoLm65I3VCFPsvAx0RYqtZgH
	F4/ZWzGqvLF8qOGx5oHpOiHl5w9qcUWDywCoWwwcE0XZ2Tztn65ipgUbJvZ3e/DX
	Tn5xCo4Odybf/23RSbYy4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748795907; x=
	1748882307; bh=nER7rpY1od7+oqNznuPitHt1lfolL5JAE3pxx0htv5I=; b=p
	H9cQCKc0GdGqIEVJMikYYGa+oVbCdxihu6t+TAS11m8bg3R3+bJd/CkG/jLengUA
	Xu8q2bvtH5LwNw0XZLz6B54kNskNd+4aKOCVS7TqcLGoQ5A2NnjfRWW7fgyWlQW4
	mirwLggvRPZdC5TgOfMRSJ8q9k4GXJizijz3XHKlneHOa4jgX5Lwdj9jYv7qJFLP
	qTwKKlHuCV0zpNHLFBlIIqO0iNxZqirmYfgfBfWwyxEEFyimZvYOvbk4qPQ5BEKt
	/CDb7KocVgGpHODYEG/5VPkzUEQTkbi9w9N8XOo3yZEfeyoo5MRyOz2HYHve2Do0
	HoANBX9C3RC+G/qcG5uOQ==
X-ME-Sender: <xms:AoI8aMhMa6YiFQBHVoqVDcfuS6D0nlUnVLXiTT7TaOpXeOqXaYux8g>
    <xme:AoI8aFB9AcOVqLyUnOaMStPSYc22xzTscJaQpeteN4lS66F_KV-qjdmUCUv2k2FOX
    pBWSgscRT7r3M3RJQ>
X-ME-Received: <xmr:AoI8aEGTWDtWIw67uEJnkcSmO6Z_ng4kp6NtBI9Q6Ce0AvfZQzZRc0qMhnbILAGt568L9F3EMUgjaZaxIOP6udYaqg9OwK04VkAj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefhedvleculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouc
    eoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdet
    gedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphho
    sghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepthgsohgvghhiseifvggsrdguvgdprhgtphhtthhopehmrghrkhestghhrhho
    mhhiuhhmrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghp
    thhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:AoI8aNSE0jstDty1NHqHE4kPWlgy7YlqfA_Cf1VUbrlRtM-QBV1_ZA>
    <xmx:AoI8aJzKrCN-YuvH0GUdaoQEivUM5XRsQHcJK1KDcoF25BzdXNCDLw>
    <xmx:AoI8aL4IUf9F2AKDhOUl1xvDpe2d8Q1cGhIvQpZmAvkuWHal-tPtxA>
    <xmx:AoI8aGz-IMn4ZUZicdSC60fAIO0AUFk7ypFck39jzULCS7b6QUkHfw>
    <xmx:A4I8aHJeyx68JbrjgMP-M2f91Ied2MFayhhNtLgADEbHA8HUEbWqGIsM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Jun 2025 12:38:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: Mark Mentovai <mark@chromium.org>,  Git Development
 <git@vger.kernel.org>,  Eric Sunshine <sunshine@sunshineco.com>,  Derrick
 Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] t: run tests from a normalized working directory
In-Reply-To: <20250531054618.GA30443@tb-raspi4> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Sat, 31 May 2025 07:46:18 +0200")
References: <20250523193722.68344-1-mark@chromium.org>
	<20250528201737.55268-1-mark@chromium.org>
	<20250528230804.GA16856@tb-raspi4> <xmqqfrgmhep3.fsf@gitster.g>
	<20250531054618.GA30443@tb-raspi4>
Date: Sun, 01 Jun 2025 09:38:25 -0700
Message-ID: <xmqqcybnxvr2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Torsten Bögershausen <tboegi@web.de> writes:

> The word canonical has been removed.
> After reading the help for
> 'pwd -P' and 'cd -P'
> "absolute" is replaced by "physical".
> A matter of taste.
> If absolute is more used here in Git, I am fine with any.

It is OK as long as we are locally consistent.  I do think inside
our codebase it seems we use "absolute" more, but the change in
question is about use of "-P" option, which certainly was taken from
"physical", in our test scripts, so I am OK with your description
below to use that word.

If somebody really cared (and I don't), we may want to pick a single
word among physical, absolute, and real, but the only thing is that
we are using them interchangeably, so as long as we make it clear
(e.g. perhaps strbuf_realpath() and the underlying helper functions
that are used by it may have a comment or two that says that we use
these three words interchangeably to our developers), it would be
good enough.

> ==================================================
> t: run 7900 tests from the physical working directory
>
> Some tests make git perform actions that produce observable pathnames,
> and have expectations on those paths. Tests run with $HOME set to a
> $TRASH_DIRECTORY, and with their working directory the same
> $TRASH_DIRECTORY, although these paths are physical identical, they do
> not observe the same pathname normalization rules and thus might not
> be represented by strings that compare equal.
> In particular, no pathname
> normalization is applied to $TRASH_DIRECTORY or $HOME, while tests
> change their working directory with `cd -P` which resolves symbolic links
> returning the physical path.

"physical identical"?  I think the problem is $HOME and $TRASH are
the same but not physically normalized, which means "cd $HOME &&
pwd", "cd $HOME && pwd -P" and "cd -P $HOME && pwd" can give
different results from these two variables.  How about replacing the
latter half of the above with something much simpler, like this?

    ... although HOME and TRASH_DIRECTORY have identical values, the
    physical path to it (i.e. what "cd $HOME && pwd -P" reports) may
    be different.

> t7900's macOS maintenance tests (which are not limited to running on
> macOS) have an expectation on a path that `git maintenance` forms by
> using abspath.c strbuf_realpath() to resolve the physical path
> based on $HOME. When t7900 runs from a working directory that contains
> symbolic links in its pathname, $HOME will also contain symbolic links,
> which `git maintenance` resolves but the test's expectation does not,
> causing a test failure.
>
> Align $TRASH_DIRECTORY and $HOME with the physical path as used for
> the working directory by resetting them to match the working directory
> after it's established by `cd -P`. With all paths in agreement and
> symbolic links resolved, pathname expectations can be set and met based
> on string comparison without regard to external environmental factors
> such as the presence of symbolic links in a path.
