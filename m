Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859331B3725
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 15:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226855; cv=none; b=mXCTuBIfr/uHNVnvOTqmbnylEZ6E+xkOSD7IKqH2CdpuhIa2etZBGsiCGVm7lj9ZYRFxBvFJ3LW3/z9+CQ2aKl0DQFcp7VJGWjzjdhjm1YfHMO10mdZ7WjF479T287k6trSmeM7ueOmJYHglNNJSCiqYTDexDKqjsCbGKnkQEDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226855; c=relaxed/simple;
	bh=U18PVONKkrva6vp/WZ7I0Mupqm64n3xgONEH5Qubmms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sgqavd/WTZTJTW2e5pu2xwy6TmqQLqpDm/afL+mrk14JmpCb7PuWihIp6b1gDeXDlK/3fHTPcmytK/qNfjQaWI7WOHI/MUF8VdrIIGnm2t1cTfupAzcnXSBazgUOH67gAYQiCnt9BQ1uZuTcolmM3yPQc366i9c78OPyYCqtRas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KX+j3ZTl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eVxEeBxX; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KX+j3ZTl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eVxEeBxX"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 83A2F11401C2;
	Mon, 17 Mar 2025 11:54:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 17 Mar 2025 11:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742226852; x=1742313252; bh=Fk9OOHzrl+
	py6WpFpN94N09UIdW485lyBC65xf/YQkQ=; b=KX+j3ZTlJMZStbapODULM7EUAm
	Ux+K8ZIWE6G8ufq71py4XEX5Ub1S9406NRL5dHzQe0i/NL/6iDQQFmBhpouWuyuO
	pWUvlBszykEpVtTl4yy3Ri3L8MeGEkHuJsnoNUnWzryTfXU+2AYIlTKgtr5hvCwn
	qqJw8qSDbt52ZVz/OeHSBHc/K2Opt495VYm4LAORsP7mLuAR/J0DCfGYLZmM74Y1
	OgKFl5VuNGWaz+Nuwy/1AtC4lE054vQ7Eh+stgxV6pylqc9lUtYPT4wZ5bIarmmG
	pWS5V9M7M53asWpPSjdfIqOPyeDmiK5haVwOZzu0BfzcZP5mgfJp0KanWMzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742226852; x=1742313252; bh=Fk9OOHzrl+py6WpFpN94N09UIdW485lyBC6
	5xf/YQkQ=; b=eVxEeBxXO7wXm4T3cxtfQjGXOrGFSS7c9/AscV03XKgRM+NLmlq
	9P0tUrs4PQ6LDcs+8bhNVnF0GguqcErj4F8s5BzpVkwLFC7echxT07YQ2EoMcB4J
	CPOMLR+Jp6nRI/eLRtQnOco7DkoYI3fA7QEro14jvogGQVulFfG/wPYbbLfbfE38
	WVu7wKeO0Nx2e4KR90M20VmAGrV7vNJu6BSCQZIWJQGxS99XsVJfvYSh6CKXVTG3
	vvZ/NBCux+/rXc1kwzX9h8SrHauRX0t8ByN8et0iy0ADFBYeDhS2Qfhwjlg/4SQG
	vk4PdeCjRaEBcYjtHsC3tWTvAPXFIiv/Pug==
X-ME-Sender: <xms:o0XYZ0dKFaYIKCKA-nKkmHdHoWjAfZcXARd93NvuHj1Im8NnP2TQdw>
    <xme:o0XYZ2OGNisv7wtR9Uuo3qg8Hw5CtKuallSrJdREnBlnBrpGwHo2xW6kyQU6q_EaR
    FlR-D-mPOdO2qunpQ>
X-ME-Received: <xmr:o0XYZ1iCmBdft_oLCXrOeuMtgyUymWGDuuLWh3qQ_nZx5CttefMDUPRq0gKtPJObZQ9JcmbktMJQ7sYfbqgMf26tOPzVA5ei5luZurc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeelledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihse
    hrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehgihhtseguihhnfihoohguihgvrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:o0XYZ5_7Dc-cdFTe4xPAm5zrJjAkVgLM6SqkjFPuwwW4NYgeKTVseQ>
    <xmx:o0XYZwvB3M0mHTP05YbQMxmt9IH0RGTqiXQgYZ14bHnJZfuF8uf3ww>
    <xmx:o0XYZwGweP0j-knmhGX_8PX2umj6BWNMtnd9dnfZ68FjTqzN_S2muA>
    <xmx:o0XYZ_NnDex-MKSz8amMOrmubCYhdb7_BL-9UV8qHk5h37kDpLzAFw>
    <xmx:pEXYZ6XKfcrdNd61L5cZE77rfrb6WrWZrFh1XV8Qywoo3rrLLOvrX59X>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 11:54:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,
  Adam Dinwoodie <git@dinwoodie.org>
Subject: Re: [PATCH 06/12] config.mak.uname: only set NO_REGEX on cygwin for
 v1.7
In-Reply-To: <33561996-3b7f-4d0e-825f-5b2369d7d010@ramsayjones.plus.com>
	(Ramsay Jones's message of "Sun, 16 Mar 2025 22:24:18 +0000")
References: <a4272c4a-7073-4671-a883-50e9413b0384@ramsayjones.plus.com>
	<33561996-3b7f-4d0e-825f-5b2369d7d010@ramsayjones.plus.com>
Date: Mon, 17 Mar 2025 08:54:09 -0700
Message-ID: <xmqqh63rbqla.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>> After some time (may a year or two), the platform library had been
>> updated (with an import from FreeBSD, I believe) and now passed the full
>> test-suite. This would be about the time of the v1.7 -> v2.0 transition
>> in 2015. I had a patch ready to send, but just didn't get around to
>> submitting it to the list.

So is it safe for us to just drop the bit that sets NO_REGEX and
require Cygwin that is less than 10 years old?  As long as people
are willing to actively maintain the compatibility wart for older
systems there is no strong reason to do so, but at some point it
would become diminishing returns even for those who have hardware to
develop, build, and test on, when the reason they keep such an old
system becomes only to maintain it instead of actively using it,
and I am wondering if Cygwin 1.7 has past that point.

> I forgot to mention, that one of the reasons that I didn't get around
> to submitting this patch then, was because of a '# TODO known breakage
> vanished' in test t7815-grep-binary.sh:
> ...
> The platform regex library is happy to match a NUL byte with the '.'
> pattern. (presumably this is also true on FreeBSD?).

In this test, the haystack has "binary\0file\0m..." and the needle
to be sought is ".fi".  The system I have at hand uses glibc 2.40
and it refuses to match NUL with '.', it seems.

> I could not decide on the best way to 'fix' this issue. The options
> seemed to be: do nothing (it's not hurting anyone), disable the test
> on cygwin or simply remove the test.

The part "On Cygwin" somewhat puzzled me; aren't folks on various
BSD variants seeing the same symptom?

Do we want to eventually turn it to test_expect_success?  I think
the "fix" depends on this single question, and I am not sure if we
do.

Is the behaviour that '.' matches NUL on some platform and doesn't
on some others hurting anybody?  I dislike a tool that behaves
differently depending on the platform, but not strongly enough in
this case somehow.

On the same system, GNU grep and sed seem to consider that '.'
matches NUL there, i.e.

    $ grep -a '.fi' a | cat -v -T
    binary^@file^@m[*]c^@*M-CM-&^@M-CM-0
    $ sed -n -e '/.fi/p' a | cat -v -T


> [I think I prefer to simply delete the test, since it doesn't seem to
> be testing anything useful, as far as I can see.]
>
> What do you think?
>
> ATB,
> Ramsay Jones
