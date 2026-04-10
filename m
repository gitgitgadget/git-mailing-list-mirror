Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0341B32FA18
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 23:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775862356; cv=none; b=tV1Gj8POypG/HBV1leL3eM8ByqUa+6aizDweIKxpXuylWycHfy245WPSrnRUgSabpP9o1J1eu1wFCjp6vrqR6RtFpxI9/YEQo6hdJbb3YOlTpALJaHk4ZhkRkDKxEoayBNSspjnHAft8Meeu3pZ4Dqs7GwlT2qh0FAPFf89jt2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775862356; c=relaxed/simple;
	bh=m+H4mxBUhReckDtLQ9UXxtcLOGv5Db0YCHcESRdUysM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FteXAYDkQ445In+OePQpkS4jCON4uy8+4qYufC1Vi353M8dq9F2H1DF7TIwXX8E8GCY40AWpCIwZOIOIfAI+3k7cn1J0AvN3Ep8H5JwnISPG+QvAtqtc8WzbddAFKRR5hzVT0TqcaD5OSy2d9AjLG660J2Tmc3Z3H9d6osR4lcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RW1YuZuO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tBPXlkb9; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RW1YuZuO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tBPXlkb9"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id AA89B1D001A0;
	Fri, 10 Apr 2026 19:05:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 10 Apr 2026 19:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775862353; x=1775948753; bh=B2jL5iVLXa
	MYn0oXcKGuSEIS31izMQPz0VbutAIM2Fw=; b=RW1YuZuOpdem/huT4icMcb3IKd
	LpTKsN296eqOoWPH29t9zkfATbQfEmKHnE3DQk4HynX+iUi6F9UDGM1oGVvzxqE4
	JMKBDG21AXmPQwYPqqXJ/sBenZ6abCOX9wor+zZeqJ3fC6xgage9ycgQqmz9X16t
	muG5osSUbhHF3uPxqHGWfgUbNa2huBl9D+rDdvfieNiOHl33rG9AepfBX9c4da+c
	V9fWplAff0vQzYRvYj0S4OE9fxSzcskyDKWD5mL1DpvrED4AvdWpdyds0R97xqHP
	ANeTzJYKc+L8X+RcxmczEASNcmKiUUkAfqelJgzWt6sfVSpVINnT8t8l/7Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775862353; x=1775948753; bh=B2jL5iVLXaMYn0oXcKGuSEIS31izMQPz0Vb
	utAIM2Fw=; b=tBPXlkb9UJahuopidzjiM180pKuPbMjyD6/vTEwsRB33Evbtr7T
	WNh+1XD/D2gutzsEbohFFPsiZQsbZ/aEG/m3+RNxo9NTfdea6UTk0yHyl/dhDsWd
	oTwHcve/4iM75JgSbwHdkf5e8W5W5+AVKHAZXsKKmd+F+ZY2c37uLuGrO5KqdFgj
	ERsZxwWCDp+NwUHIyUgLkVvBZC1dT2lyQXw01yMP4A1eGphMvJV5QYoacKSr/7AZ
	JY5o4vYjIBIMHZVQzjLU89MFEUEBh2+drX5LcCMh9tFh9nBkZJoOA4DqeawvwIkB
	kOqq+2tMcfq2J60bYo7khlwp8AMuy6kl7+g==
X-ME-Sender: <xms:UYLZaQBVfyT6_WwFO9PqnkZzhXyViBnqwGvZafzxBrOB5lHp24C1uQ>
    <xme:UYLZafYFs9PRCZR4onLr7aWuPl2M93gPmF9_RivXg-b14-2-ITlzFuthS9POFbNNp
    5UltSli8ZNBwE81qZZMetjbQ11JDLBNWLyv9u6zWq7gKNcj1LHVrw>
X-ME-Received: <xmr:UYLZaTVD6dqmJD6Q5hqZoIt0GGbLTaXWDzjggXaO_Eo75FUBGtajTNh5X5vAj8c5_N3az9CUvmXa37-20hZmL_0pD9WH8-dJsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeftdejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeffieetueejveefheduvdejudffieejgeefhfdtvdekfeejjeehtdegfefgieej
    tdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhorh
    gvnhiiohdrphgvghhorhgrrhhivddttddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsthho
    lhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhr
    tghpthhtoheptggrthesmhgrlhhonhdruggvvhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:UYLZaWNrDzRtieKT-vgUUk9dIprjvuJSQM__mDaFyMX_kEO6ElxFNA>
    <xmx:UYLZaVZh8e9sl3iggrhTLC_ztvHxmIBuKJyQa70tDX0XHqtRnb3Q0Q>
    <xmx:UYLZad-xiB_D8pLP5pU0drVVb6housmLqnZSiU3fa8r0Muxq6l7MOw>
    <xmx:UYLZaeT8YRD6_iF5o82xekQaGAB-U_Mznr7VagXb1-9qabloAn2BaA>
    <xmx:UYLZaQgiJbvjIn6oCEH3koMPdFzyI3eL4sCPSNDkV84CvKjw3N4deR0l>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 19:05:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Patrick Steinhardt
 <ps@pks.im>,  Derrick Stolee <stolee@gmail.com>,  Elijah Newren
 <newren@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>,  Tian Yuchen
 <cat@malon.dev>
Subject: Re: [GSoC PATCH v4 0/5] preserve promisor files content after repack
In-Reply-To: <cover.1775832056.git.lorenzo.pegorari2002@gmail.com>
	(LorenzoPegorari's message of "Fri, 10 Apr 2026 17:01:26 +0200")
References: <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
	<cover.1775832056.git.lorenzo.pegorari2002@gmail.com>
Date: Fri, 10 Apr 2026 16:05:51 -0700
Message-ID: <xmqqse92mn5c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

LorenzoPegorari <lorenzo.pegorari2002@gmail.com> writes:

> The goal of this patch is to solve the NEEDSWORK comment added by
> 5374a290 (fetch-pack: write fetched refs to .promisor, 14/10/2019). This
> is done by adding a helper function that takes the content of all
> .promisor files in the `repository`, and copies it inside the first
> .promisor file created by the repack.
> ...
> V4 DIFF:
>  * `copy_promisor_content()` now prints timestamps in Unix time format.
>  * `copy_promisor_content()` now doesn't use a list of `strbuf`, but
>    instead uses the more lightweight `string_list`.
>  * improved the tests.
>  * fixed issue (that showed up in the GitHub Actions-based CI) where
>    sometimes the 2 packs created in the second new test inside "t7700"
>    were not both repacked into a single new pack. 

When merged to the tip of 'seen' (with a fixup to use st_mtime where
we need only whole second precision, to avoid using st_mtim on
platforms that do not have it), this seems to break linux-leaks and
linux-reftable-leaks CI jobs (t0410, t5616, and t5710).

This topic standalone, without interaction with other things in
'seen', breaks these three tests.

  https://github.com/git/git/actions/runs/24267948258/job/70866907548

This is one commit directly on top of your topic that reduces CI
jobs down to just two "leaks" job, and removes many test scripts
to leave only these three breaking ones.


I managed to also locally reproduce this failure.  Here is how

    $ cd t && t5710-*.sh -i -v

dies:

Direct leak of 285 byte(s) in 1 object(s) allocated from:
    #0 0x55ce48ca1d4d in malloc (git+0x8cd4d) (BuildId: 1aa6efa30b2fc4772028a3dd31aba3ced49bf128)
    #1 0x55ce48fed3f2 in do_xmalloc wrapper.c:55:8
    #2 0x55ce48fed3b6 in xmalloc wrapper.c:76:9
    #3 0x55ce48eed314 in alloc_packed_git packfile.c:306:25
    #4 0x55ce48eed209 in parse_pack_index packfile.c:326:25
    #5 0x55ce48f65f03 in copy_promisor_content repack-promisor.c:67:14
    ...

