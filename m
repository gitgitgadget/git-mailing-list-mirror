Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B546779CD
	for <git@vger.kernel.org>; Mon, 11 May 2026 03:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778468733; cv=none; b=V0OlmBptUI2AEdxWm4ClFHhWVYiDH7v/EXXALT1JwiX95Ifh/y/FF5NvCO2QC7iqSHstEcEqOI/LLP8WO6/JTOn9H0cQ5qc0TGvqMuY84eXVxd2TNjhIvbr6YOpmhPwVjHnOnaKeIjUdRx6+zSRg63OoJDnltPehCefp3AIYoRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778468733; c=relaxed/simple;
	bh=ksLY/MpG9gtLtbAzdu9UVUOanWz4PeKo2a4sc+KXeU4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FHJCiauyfDBzEdpObv65dwU0T1QHKFEkjxDcREt3RbO+3yOB68aGiVChUKKLlyobmcb0NHvpzdE+fcPk4As+HkIt0q/eNWFZhJ5EiVbvv1xHXUcEKo5FCN4I4686TUmROIJBWidrZm44hbpdCMuIs7G+1HaD+rlmk6Z56/r2kTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tn+dK6mb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PQUGex6B; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tn+dK6mb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PQUGex6B"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 816491D000D5;
	Sun, 10 May 2026 23:05:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sun, 10 May 2026 23:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778468731; x=1778555131; bh=xkZp1HC3Cy
	CzmbccNn6xkmqY7jIYkGLBHNwt0VUNytI=; b=tn+dK6mbzw540RcSiGD94L8Ud4
	vu8Y29EGys7LlDR3YnvEwXGNi+TVc1dSd4ZWvp7rHax6o4qv6Kgi86JEMueHovYm
	wJGm+he5vpNDvKGKSTi/18+n4irjW3V7iJVGLQjiNmMkBRZu6PeWVavMlypzJRka
	45rleUevJEexKRnCoQlBGbvqBtbq2D/Hf+f6LpHjhA0joRB6wekoVBBoyn55VB48
	bHP9IGHM0cno2UpDf8WtdGjobBFrhwEFXzsB2joH137kfU1VvE3lWU3NabFxe3Qa
	eitq4WD/NnqTl6gqgshsIEcHbtFl8ic//U4+aGOG54iP/0Nu5N/wNkAZwWDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778468731; x=1778555131; bh=xkZp1HC3CyCzmbccNn6xkmqY7jIYkGLBHNw
	t0VUNytI=; b=PQUGex6Bo89ZWziHYI/lyTgm/V43Vuw3QXCXoJG62CEFFWwhRBo
	MTh7XQ6wodLtTVRSuh8gmlzHBYhYbSbob/uf6zV7l6BEufWRQNFTfxTKLm0VAhbp
	/Nes07Dg9QvVYgeyjQwY62FhtRYYUqtkbFPxqaZYru+csqqCP63liVnNZvhfyaWy
	8Zo/B12XWJBBgIYocOD4zmzdwdYDSZcckA1isTOOF25ckW/4UvlM9+RhoJUaJSz5
	J1tanb/YJ16dG/ey8IUAQNkeMRKzOmImxfZ6xDE7YNfizHFfDfofBbi2KIA5v814
	e2KiWBd/Xvcvg2bwdrISMvht8RT00uEEqFA==
X-ME-Sender: <xms:e0cBatVtx2FDWKwAvnBOJdIR6VGOu3U_9TrjRVXr6kDzKnNnv7Dd-w>
    <xme:e0cBaj-gXRcmjFdYw9IYIzSTBVc4ccrXz7q2XrAnRjcQZ2qifLJdjFIvRa_xNVuMy
    sSArE-6s5SUAWXJwWb77F8KpYC2UiQx5SN3vt5noGgXN76ZiIk5zrk>
X-ME-Received: <xmr:e0cBalr22ekzsStOhMtG-Qz3nVCubqrkqCXasHzuYkKbxWz8IrfrEvRAa_rjIIkX-MWFYSNLGpJaecoX-8TrUdfcM9FQ90tE1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhgihhtghgr
    ughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmh
    igrdguvgdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:e0cBauJfiPElMAhmtRhPDi3wF2Z5-aycWnlnj_t47PjXklvbRk46SQ>
    <xmx:e0cBagPqd1buT6oyYKXgxtzVFjuCVh5_tNQHCgRkXq7doGIhLN2rBg>
    <xmx:e0cBajqhu-8fgtyqbiRsfcvF01BhYIq5q0c9ZY1XE0xBv-Bd3a3ZZA>
    <xmx:e0cBarKkIw3quARlIDQEtLAGvBYtXx9bwSS4oz8-4nbFQJ-9UtTtfg>
    <xmx:e0cBamHTND1fD3z1pbihHNo4P9Czu_uvdQvsNB4mkCuy5eZezGd5og3r>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 May 2026 23:05:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,  Derrick Stolee via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  christian.couder@gmail.com,  johannes.schindelin@gmx.de,
  johncai86@gmail.com,  karthik.188@gmail.com,
  kristofferhaugsbakk@fastmail.com,  newren@gmail.com,  peff@peff.net,
  ps@pks.im
Subject: Re: [PATCH v2 00/10] pack-objects: integrate --path-walk and some
 --filter options
In-Reply-To: <07b36bd8-376b-4a98-a735-0c0f75452c24@gmail.com> (Derrick
	Stolee's message of "Tue, 5 May 2026 15:44:56 -0400")
References: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
	<pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
	<f5d8d4aa-2453-45ef-bc96-2b94bdf55c7e@gmail.com>
	<afo+mEITFBSLevqV@nand.local>
	<07b36bd8-376b-4a98-a735-0c0f75452c24@gmail.com>
Date: Mon, 11 May 2026 12:05:29 +0900
Message-ID: <xmqq8q9qtzly.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 5/5/2026 3:01 PM, Taylor Blau wrote:
>> On Tue, May 05, 2026 at 12:18:28PM -0400, Derrick Stolee wrote:
>> ...
>> I think this is a consequence of us not sending directly-referenced
>> blobs with `--filter=blob:none` when running the filters through
>> `--path-walk`. Something like:
>> ...
> Thanks for this suggestion. I got pulled away from my investigation, so
> wasn't to this point yet.
>> fixes t5310 for me. I haven't looked into any of the other failures yet
>> since you mentioned that you're looking into them, but let me know if
>> you want to tag-team any of these.
>> 
>> (As a related side-note, I noticed that GIT_TEST_PACK_PATH_WALK=1 is not
>> currently in the TEST-vars CI build.  I'm not sure if there are
>> historical reasons for leaving it out, but if not I think it would be
>> worthwhile to add it.)
> I think the initial idea was that the feature was too niche to add it to
> the CI builds right away. Your series is going to make it a lot more
> important, so adding this to CI builds may be valuable.

Should I expect a new [v3] iteration anytime soon?  Not getting
antsy, but just going through the "What's cooking" report to see if
there are things I should immediately advance.

Thanks.
