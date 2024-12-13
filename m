Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DB815573A
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 22:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734129293; cv=none; b=necZtq1JVbYFNVdNjxO3++PWUODkvwzaDgu7djz3Ig1ORfvT2q72QFDBHTvjuUtAzWGWV6xP2DWy/KV12dhmRuGpnClrQlEmpdq9snatwrIlIAUvPRHOqLTx7Xzkfnswgyj9rgk1SwWJGCctb6Ap5R3+Mvr+JFyBZDBYqK56zQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734129293; c=relaxed/simple;
	bh=EISlfC3tDxEeejQXi7b+iU2OsCx0PewTzzcT/mZSL0o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BSGyeQaIcycYodxT+7mu4yUUPnZeOyhWPJDXxoTufhOmj3JFJfTIUekCgWo3T20w5frZyS1BDAyR7N3TwPnYm8QMt7ty2W/MQtf3xBZLO7MqmusIvFBn1b+jaIMX5agxwgNgpBrgqQOD7vEexefGwg/qZPhunfBnfNLjav7fYP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uDdHVOjV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pw4m0QEj; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uDdHVOjV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pw4m0QEj"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id C6848114011C;
	Fri, 13 Dec 2024 17:34:49 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Fri, 13 Dec 2024 17:34:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734129289; x=1734215689; bh=uAfsB117Vi
	3n6DdL3HTZDploRYvlJdXxIxvPcvRrpmY=; b=uDdHVOjVE+4byj4H8AYKW0DcBM
	Y3MbUBKwWYoCHrA0CiiJ3VfdtVoQMgiN6MCbzwFMa3mrR/hIL19s674VvAYWZgjD
	4B528T5CibLz6WDIWGCioh/ku2t0cIz5tIc7/k9wRQ7mYy4WLNIbSphavUftcRVh
	sSaZQhTtUlvVkTgJKXaI1Zza5DJYXC9q5koyA2BGpRWPM+oVUfZqLROvXQwgMAxW
	G6OCXWc509+b6HWs9jxdR/f8rRB3kIA+YzGaPz0Rjx5eevZ3KF9DBYUvEqefUMpd
	ddDxCPG5Ij0c5gdHCPv+PT5t74gWwrL9p9M9fUsJm0mKAhgth5gmkzLVqOdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734129289; x=1734215689; bh=uAfsB117Vi3n6DdL3HTZDploRYvlJdXxIxv
	PcvRrpmY=; b=pw4m0QEjk0ngYspOF64hUWQqL2E8erw5LZtVJI6S1tsnC5m4tjX
	+0aoipJV43kws5m/S4oOYS9ms2gDWW5gUqtrL9zylDI7JiZ6Ec2bu8cKNLW3Q5Fm
	/hHI8kj9t/Bye7eLE5mrl8UWs7klE2IgJIG16oc6J+uCGHR3FZ8tF+yD1Vi1xAlD
	gW4pdQljxLGQgpwhTkHnQyZXMZDid1zQ2Ez5TRCZg0ZyBnO/SACo3gaRXZlBUqLD
	3WPFjxxAdLHIH9JwpXEVSZABeyTaj/GvnR6XWYAqAS7GAr1Ra+RkwosR0BNrCw5l
	/ovUL1b0hV6Nqbt5levkK7GLIOsOrrwawMQ==
X-ME-Sender: <xms:ibZcZ99txA3N4Ibs9Pgfrd9cWhgsoSLAZRdJ1DMq8HERRh2QDiVkqA>
    <xme:ibZcZxs-40rJp9PSiLM7MslbqwQTC1bmuPLby23UeUGQS4I2_jVgbqGHbYYbpTBf-
    H0NDjQrEasSu_QTSQ>
X-ME-Received: <xmr:ibZcZ7AL0q6PK4db9CUvheGynWmxbmNx-nbrry436v3ThrYN29YElMUElzRtJXSskoBma-8Q6D2wqQ12jP1E1XmONLEEkIcz8htZ5YQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeekucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfurfetoffk
    rfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculd
    dquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhho
    mheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomh
    eqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedt
    lefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepjhhlthhosghlvghr
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:ibZcZxeGEtGhASPprJ33s5jF0NVsZ9Jpes7wWBxn2BR09DEo60KpZg>
    <xmx:ibZcZyOG03RPOm8W2_i3tMenTnTXeMKF4SfCkV7Ars2Ug_2VUQobWw>
    <xmx:ibZcZzkrvktVRz8VmkZ39xr5TWCIpNODeci22naJ_khQbesA_yXbog>
    <xmx:ibZcZ8su99O-EuQKsupbZJoQJQ-MEBBoSo8maqfXC7ROZRhG3tYWnQ>
    <xmx:ibZcZ53LHWiZbZK0_LDBpEyl88cyKJv3wjUNfwIYzJvdedbl8iXdEP9->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 17:34:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH 0/3] batch blob diff generation
In-Reply-To: <20241213081211.GA1443203@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 13 Dec 2024 03:12:11 -0500")
References: <20241213042312.2890841-1-jltobler@gmail.com>
	<20241213081211.GA1443203@coredump.intra.peff.net>
Date: Fri, 13 Dec 2024 14:34:47 -0800
Message-ID: <xmqqldwj9pq0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> So ideally we'd have an input format that encapsulates that extra
> context data and provides some mechanism for quoting. And it turns out
> we do: the --raw diff format.

Funny.  The raw diff format indeed was designed as an interchange
format from various "compare two sets of things" front-ends (like
diff-files, diff-cache, and diff-tree) that emits the raw format, to
be read by "diff-helper" (initially called "diff-tree-helper") that
takes the raw format and

 - matches removed and added paths with similar contents to detect
   renames and copies

 - computes the output in various formats including "patch".

So I guess we came a full circle, finally ;-).  Looking in the archive
for messages exchanged between junkio@ and torvalds@ mentioning diff
before 2005-05-30 finds some interesting gems.

https://lore.kernel.org/git/7v1x8zsamn.fsf_-_@assigned-by-dhcp.cox.net/
