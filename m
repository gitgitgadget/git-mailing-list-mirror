Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBC224A046
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 22:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757715673; cv=none; b=ssU30t9yn6VuTCmW2RDQZn0/O8GEeqdDslNuhq5NAeih+huEdolDYhsNIBaLOgWKfaiUh/UQZdrhx5BPCWNrfsJGbqpwfA+lNvhB0DBnxOATR1FhsNOlVp7vhETiSFkklKnwBHl46azdUpCskU5eIg5OgwX3YS2X/by1n9axH7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757715673; c=relaxed/simple;
	bh=NCnoTJXg0s4GgLE7sVLSFAxcmGZIaYP+YnFNIhQGZvg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZwhOBfTcGudUtZ/M1f5OOP0ilzRM2qt2Sp/Ac5X6jn8fhLRHuh9xMzg61Rji6VfnBuadLdlSqnRcTCEg0Srbn15n1YFTgxjHk1rxzRAR4MXjSOc3KbM06bB/HgFZYr0hNWNu02KoJHo9GGlelUqIGavjWYpsAuHLIoqDzti9IW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q1m+/Qkn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nYrcTW2+; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q1m+/Qkn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nYrcTW2+"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 0EA09EC021F;
	Fri, 12 Sep 2025 18:21:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 12 Sep 2025 18:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757715670; x=1757802070; bh=T1Bfu61jll
	JcyugXl81QeFRsqtweXBW0ouPRVwj1xr4=; b=Q1m+/Qkn5yIA2KfMTr6632L0YM
	4KcjiHpp3/J+q7cimSCjbh5yIBJ6UsHCa+R4tOUqHOPYDmNq3VjOrsghKzNC8ONt
	hioG9GVO2TT4m2XdA3v0e3cmT9OABLuMIM5Rivr4wkMrLyoi0osrEsUzBZfUMC2t
	QC7RcGDEnUGW0oLZDAGKrOtwYkSg2pCtamJprckuOqD0W8xnQrIY+2U5Qmh08Ymd
	ffjEWbdiwKYE8e+teRhy3xjOtVpxIQRB3l/jLqcrqX8rCzcifENaAPlZ89y3WThr
	TniBpm1sN4b072N6Y/e3F+lUwj7faLDVfDCCexFu1c8w6ICe1LpuZxZ4FSoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757715670; x=1757802070; bh=T1Bfu61jllJcyugXl81QeFRsqtweXBW0ouP
	RVwj1xr4=; b=nYrcTW2+l9uqN3pZoDekvgT7MG/M5oTXRN2W+PnE+TpiqgfhqC+
	GIy5buCKyYk5x0fkZ5Um0B63neYDaKFPL1PL4N9p9VQPGqXa0TFRz1YmPd9b/db3
	OP2MFjLuVOjoptOIWxn7zAHtiSq8lCYUbSeCc3dTuLhQ/qzxBYbX4fhyOid5JSRc
	LgQmo9BYkvDAfGR45Ec3tWuu9KZH9XHHHZpAT6jksEDYuOsorOWAu7jr5Gbb/q4J
	8tEh+mrRD/YMFlkng73pTWWfezLHNp10P84VyUGNM7xAfRRuUGeFo+ZXIEZ5qt8N
	7iXwFXy2LJ8Y2Mh0hjhAM+s3OwNl0N9n2/w==
X-ME-Sender: <xms:1ZzEaOJPrYojX6C1g_pFSzW3JPZaGsUAMzHXVIqeyRyJbRAEGjZoqg>
    <xme:1ZzEaB1IjtUysnfNm5-1jQJGgK5oxgfe38mYdLlgkbBz5BEXbvz4_8OTd0NrmVROJ
    GUrGWUWy_GtD0ox7A>
X-ME-Received: <xmr:1ZzEaLLDj5Oif_ZwhJzaIIS_i_DdGt5T-_1PYl3k3MgG4Wxo8p40eEj3rPLvQyRWXMT0ltzOfi-5Fa3rv1J93i7lMcEq3x7ATb6FJJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeftddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghgrsghrihgvlhdrshgthhgvrhgvrhesghhmrghilh
    drtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgt
    phhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtg
    homhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesmhgrthht
    hhhivghuqdhmohihrdhfrhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    shhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehtmhiise
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:1ZzEaMgWPh5n0ptpzwCiH6ojVnlQLifLKY9rd1Ioj3R--4VFvuymaQ>
    <xmx:1ZzEaLDaSfK7KFTUpwgIgXr8OJk8R108KUl_WG06a57bWX2Pql9rXw>
    <xmx:1ZzEaO6l7FH4lhh-zao1vjCRChe6iX8NUufTh7Si41gxx1isSnK7FA>
    <xmx:1ZzEaAGLsJz03EOmVDodJv8z8e5PZ0Hn8ZuGV04_-1DxsKiepcK1Ng>
    <xmx:1pzEaJ5hWilw9w1jGk-yfCtcLUXIj5h5MPYZOFiIAtwDmcJfH2FYaMUD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Sep 2025 18:21:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Gabriel Scherer <gabriel.scherer@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Matthieu Moy <git@matthieu-moy.fr>,  git@vger.kernel.org,  Elijah Newren
 <newren@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>,  Todd
 Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v3 10/11] contrib: remove "git-new-workdir"
In-Reply-To: <b4628cc8-3aad-4911-bcd1-6880d7707250@gmail.com> (Gabriel
	Scherer's message of "Fri, 12 Sep 2025 20:55:41 +0200")
References: <20250512-pks-contrib-spring-cleanup-v3-10-32e151b0bfb0@pks.im>
	<5580aa89-09f1-426e-8483-c99481c998ab@gmail.com>
	<2b3c951b-0400-4cc5-b790-17ff77154ec2@app.fastmail.com>
	<e6003a2c-bc1b-4cf5-aae7-ef5aa9c82f10@gmail.com>
	<CALnO6CBDcDEXe3a_mpdwTi7ujL-fU5QrDeK704X+5bbkpNgb5w@mail.gmail.com>
	<b4628cc8-3aad-4911-bcd1-6880d7707250@gmail.com>
Date: Fri, 12 Sep 2025 15:21:08 -0700
Message-ID: <xmqqldmjjorv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriel Scherer <gabriel.scherer@gmail.com> writes:

> I have a naive question. 'workdir' is a script that has been around
> for a long while, and apparently causes no maintenance burden
> whatsoever.

Not free of maintenance burden, unfortunately.

The "git worktree" was added with a clear intention that we do not
want to keep the hacky "workdir" script with known limitation and
sharp edges to break your history and replacing it with something
more sensible.  Once it has become in serviceable shape, there is no
reason to spend engineering effort to see if "workdir" is still
working every time the implementation of the repository on the
filesystem changes, assess how much work is involved to keep it
working if a change would break it, and judge if it is worth to
update "workdir" to keep it working or add yet another known
limitation to the list of "this hack does not work with X, Y, ...".

That has happened recently when we added the reftable support.

In short, keeping it is distracting of us, *and* of dubious value
especially becauseit is not as good as its more modern replacement.

> It was removed based on the impression that nobody was
> using it

Again, not really.  The true reason is more like "Nobody *should* be
using it", mixed with "There is a designed replacement these days.
They should learn to use it instead of that old hack".
