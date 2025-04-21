Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471B518641
	for <git@vger.kernel.org>; Mon, 21 Apr 2025 07:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745221712; cv=none; b=O7wapWFOWpOgxeXbgZHNwz0dpYq6IGY/wrz5l5IUmH65ZNLA8/FOv17TIvlAEtWmOl3a4P21o42pDh/RBjY2VTzzJIEgxjly3y74YWZ7J8zIRncoGE8zAXjqH52Xkg7cY8qqjkSd470Su6xfNLt2ikf6Ad2k19aIsux6xQV1Ipg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745221712; c=relaxed/simple;
	bh=xtZCdCJ/2iXZbVWo1MvMTOKKCactv6g2ymgzHnZmECQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uuD9n5kccyNPzlzFmcJ2AqrOnLf0hB+hzCwsHt3frHp04XOyu14sIqVtHiIPBCkt1qQdl5tNVNF831Xxn9J6WrD7YatS4+44QQqu/XTczfleuZRmIkirSr2+rqeyCXwNrsPw7aqJyfouApspBXgdDWD4Mis/yg8XrsMvoFLPOvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dit3zF0j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Du8MzEoo; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dit3zF0j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Du8MzEoo"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 37EF411401F8;
	Mon, 21 Apr 2025 03:48:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 21 Apr 2025 03:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745221708; x=1745308108; bh=WAsIKIvjWx
	/iBwqjitD6KNXfFOiJa5Voy8jzsuz1Yf8=; b=dit3zF0jg646H9RohUIjqRBvKq
	1IbzzS6E+p0W+OZUd9OJV8zlHraFVY1D1AiTw8GaPUe37BuSiACcWDzalGRMW+g1
	u5AjKaog1gj270BNnFLQpaDfpdChC/q+0ANNjGoqJUTLKqUiyLHee1LXuNs8yh7z
	scT3RkYi3/q8RcJdPXD7iav2PfKoqvkDxxMCmh05vyHuMiFnMl1do4qCFTEpyiUJ
	mH96wxFU1azFiwh0vyESn8sqaIOGZWCFltPR8suRXVSnyioP4grdiKzIdp9JxJJy
	BI6Ol6a7KKGiBKHYmAbEAT5k5qftGPZDi6mBI2uYuE5jf453ciP3ij8cGeeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745221708; x=1745308108; bh=WAsIKIvjWx/iBwqjitD6KNXfFOiJa5Voy8j
	zsuz1Yf8=; b=Du8MzEoowR6xQAKEh/Mvcb6mqh4hzPhzOuyyUDjCtQTBFJSrzz/
	bqKoJhempmE5FC6zEBOhzzweaeY0T1icT7Ke2EdUhay6+k43meCEPvu0VsL48rVL
	zSZWMyaV/Efn/WFsZvAbPaJKySIjw5du9j/xrGJ8ZViGCe9uOWi46Hvi0RLDdVoi
	MlSCnP3MtAXKuEbVVcIXqyVjpCFAAtMJyiRkQFqY0kAyHxn0AyTFAPrTtGhVO/sY
	8NhVdDVlPlob/k9DGhax+Ty5ulqmYi9u0KAFGWCRyES5LDWM+hbbatRoT7Lxpe+N
	DPTj406rYJUhmREuWQ6Gco4/FAVK50cjUqA==
X-ME-Sender: <xms:S_gFaLuaWjwXaSDo5r_BE2QHHC2ZvUWt9E4pVxZV0HJAqbfWv9eWaQ>
    <xme:S_gFaMf_8S89xIvjmhgNyLTMhno72AQIdecq5HF2tj7a5Ax0yom4ofK1IFr1-yI01
    NHrsoutLCUwan1uGg>
X-ME-Received: <xmr:S_gFaOwJqypE2cymPuprQ7W-uZ7shus9CBjDJquVBgINS9VdLz5inUcdhvS2GlcTn0hNz6UAjAprjPizxTNTY8TQxCZTKTYP14Yf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedtvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepleejjedugfdutddvveduieekleekleet
    geetheekuddvgeegieefjeeuheelteeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    dprhgvphhlrggtvgdrqdhlihhnkhdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogi
    drtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgt
    ohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:S_gFaKOtMOjlWHnGrsbFsl0vHZirDf49ZkZfEJ-CN1XdZx7itGIFRQ>
    <xmx:S_gFaL8kQkHnRITsYoWUcHvSBQNgs8XxrUS-dIHEXZUAXWZhvnx4mg>
    <xmx:S_gFaKXbJzn9TNWWWwGflHA34-8pWNXN4uhMfQTaJDNeknGWlzSRpQ>
    <xmx:S_gFaMdUCCoJ-Fz5RIB__9MkpAI78tGazgILjf4ay7m9XLiQuDzTAA>
    <xmx:TPgFaFgpglWhn9bRosOaMNAzHco0p7yHj_ouaZFDByk2hQH3aD4xk3cR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Apr 2025 03:48:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  toon@iotcl.com,  phillip.wood123@gmail.com,
  ps@pks.im
Subject: Re: [PATCH v4 0/5] meson: add corresponding target for Makefile's
 hdr-check
In-Reply-To: <20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com>
	(Karthik Nayak's message of "Sun, 20 Apr 2025 14:21:32 +0200")
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
	<20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com>
Date: Mon, 21 Apr 2025 00:48:25 -0700
Message-ID: <xmqqh62i6jli.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> This is based on master 9d22ac5122 (The third batch, 2025-04-07) with
> 'es/meson-build-skip-coccinelle' merged in.
>
> ---
> Changes in v4:
> - Rename headers to headers_to_check, since these headers are only used
>   for static analysis.
> - Added a commit to rename third_party_sources -> third_party_excludes
>   and remove a duplicate.
> - Fix a typo 'gcrpyt' -> 'gcrypt'
> - Remove 'generated_headers', since we use 'git ls-files' and that would
>   already ignore files within '.gitignore'.
> - Link to v3: https://lore.kernel.org/r/20250414-505-wire-up-sparse-via-meson-v3-0-edc6e7f26745@gmail.com
>
> Changes in v3:
> - Some renames:
>   - headers_generated -> generated_headers
>   - meson -> Meson
>   - headers-check -> check-headers
>   - headers_check_exclude -> exclude_from_check_headers
> - Rewrite 'headers_check_exclude' to also contain dirs so we can skip
>   listing individual header files.
> - Move 'xdiff/*' to 'third_party_sources' and cleanup
>   'exclude_from_check_headers'.
> - Use 'echo' instead of 'echo -n'.
> - Use `fs.replace_suffix` instead of `str.replace`.
> - Link to v2: https://lore.kernel.org/r/20250410-505-wire-up-sparse-via-meson-v2-0-acb45cc8a2e5@gmail.com

Like the previous round, this round also seems to break linux.meson
job at GitHub Actions CI when merged to 'seen'.  It may be quite
possible that it is caused by some semantic conflicts, and help to
find where the merged result is wrong is very much appreciated.

For now, I've ejected the topic out of 'seen' again.

Failing CI run:

https://github.com/git/git/actions/runs/14563669225/job/40850047961

The same 'seen' without the merge of this topic:

https://github.com/git/git/actions/runs/14564707024/job/40852298435

Note that I expect win+Meson test (3) job to fail/time-out even
without this topic.  I do not know how the numbered test jobs for
win+Meson part of the CI are sharded, but one of them never finishes
in 'next' so this topic is unlikely to be the cause of the breakage.

Addendum.

The topic alone, rebuilt as specified in your cover letter, seems to
be sufficient to make linux-meson job fail, without any interaction
with other topics in 'seen'.

https://github.com/git/git/actions/runs/14566676782/job/40856998621

Note that we have unrelated breakages like pedantic (due to update to
the fedora image) and sparse (due to deprecation of the ubuntu
image) we fixed since the base commit you picked, so failures of
these jobs are not all that interesting in this run.  But the
breakage of linux-meson job is unique to this topic.

Interestingly, either this topic alone or 'seen' with this topic I
haven't seen the "meson setup + compile + test" sequence in my local
testing, so the breakage seems to be isolated to the CI job.
