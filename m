Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8FE221277
	for <git@vger.kernel.org>; Tue, 12 May 2026 00:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778546446; cv=none; b=MJT7brxSUHg6BzGDmn49U84etgoneViVimyHoUQJUebfpUoqCzepPU62YSo2WngWYLLnz3wzyJUBjbOOlT09+C3exby+DEGCR3zsglf1+PJ7eRJvkRrWDui8WaHc0wD8n57uRsPsM/MwwLNlcedVR/lliPnd5qnJAhxN1VCPBmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778546446; c=relaxed/simple;
	bh=pkTPojzIWqBLu/Tfps6gp2RpKpiHgX787Oe635qF+C8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A+S86ymhsjnMt1u3T7KMnS+1Ekx5fI43HUtJhdgzdoEgRu2CUUcGJdOf9hAueeQuHkYzst70hoAnyvqHcCceTcHSzoyQDddb5ejS+vExdTu3AGTH2KzcZEvkDvZdlLJbtfswgHpj8FuGD8855PJIlV3f4hdlvIeh4ja6b8xSMY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f/aOizaK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AcbgHQ2B; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f/aOizaK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AcbgHQ2B"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9AAAC7A011B;
	Mon, 11 May 2026 20:40:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 11 May 2026 20:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778546444; x=1778632844; bh=WUUO/fk8AW
	6CvFPuML2N8gchUpDHC8pC3S5Hw4AH4gM=; b=f/aOizaKPE3kedGSEINxUtL7Hb
	Cbg7M1+P90tdLXxuBdM0i3EFKqMBHmfOI3zmXgu13DupD+zTj3Z52Vb2Tpua2Rjy
	NRMp5sRME8/UnzzhhIM8Ew9iacF8kUWeyCyobb4JGwNr7Ff6j1SzufW3NSym1NhP
	/UTUUoc5JTC888+AjiJK42ZEFwh2+Q+6bAzr8kT9p7gK9XqTZ3tkTF67oOk5UsYw
	Bkp/bbUAA9wIXh0HtBb5/gy5+EyJX5LFnSYisahATQ2niHkFM7oc4xyy7gjZLqLO
	Bi6N+bch6p9sAd38k2+TrqM9cU/yFhnw+wOyydoA1SoQPqIz56j6TDTHfWHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778546444; x=1778632844; bh=WUUO/fk8AW6CvFPuML2N8gchUpDHC8pC3S5
	Hw4AH4gM=; b=AcbgHQ2BubAk0QQhFf4FN9XS3F6/33JZUv9dQD8wMca387pYTfy
	0JAwX/sKNRVh40BO5pMylJNM3XREKXBId3MnvvKGX63W8e4f9aLwIShiu8l3UiBy
	jJUhoGnkXyTX3uJfh2gb8+ZUqd6wO3uN/dmnBX9OnySZVjy3G3O/U9z7sOh2cBq2
	CVYy4LBExdQCKIspaBitj6H1Fw0reiDZWxostgpcSn4WFPrbL+IiuT43OHsv1PwA
	8H643LpGSkloQfG+KFcPB3GZRRtB4bdLZ/CGZeaZf+zc9Fuh/Wl7VTolDIt2L0b5
	Mp2k37Hwdi0THhqcbwHeBh+KQpdftOl0h4g==
X-ME-Sender: <xms:DHcCaocwDGKX3OKYYrnaKUVcgXc-xV4PW1EMHHZRnCY_GlqaLh57NA>
    <xme:DHcCahHaapyTXLZ8ewiS3Y6Bhz4yPtJavtdrP56gMPcOXCa1E9NrN28aYONfhjxvS
    rW_NKgfG-dJH_AI524-K9_5Q4NEXYKBKrdlhrVgdS89k9eNPA6h>
X-ME-Received: <xmr:DHcCah2yKALEKOLgStrcj77bywKVSsxPLaOwaukvgAhWwjQi9x6LYlyQ3CrC0t_7fIe7IrG6P1JvahuuuvHqmQFz_PyQ6riEEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddtfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohepkhhrkhgrsehsphhothhifhihrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DHcCapkOt1k8gANp5luywq2iYH8ldTJ1eLgtzqBID2WFn3ccjkhXrQ>
    <xmx:DHcCah9qMAIFKhc1W--DNQI8wXBCNyR8jGt-t0YMPhG0NYkErTMfXA>
    <xmx:DHcCaupihSiMry4dFrF0ESlwrOnNoFfVDZnY82IV3iXV5eqWtz2jnQ>
    <xmx:DHcCaqmhmonPuCwLOT8KYX4o7uUu3YXQl0Qv1rH6MMxxAxwObtDCDg>
    <xmx:DHcCailrFH7Kq1etjCmuXByvntTSg-Dh-vgbMoxsQ9Eq5bLZhPyQsSn5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 20:40:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Kristofer
 Karlsson <krka@spotify.com>
Subject: Re: [PATCH v4 2/2] commit-reach: early exit paint_down_to_common
 for single merge-base
In-Reply-To: <19f1605067e26c8e393c6c2e341844bcb3dc1b41.1778504352.git.gitgitgadget@gmail.com>
	(Kristofer Karlsson via GitGitGadget's message of "Mon, 11 May 2026
	12:59:12 +0000")
References: <pull.2109.v3.git.1778498532730.gitgitgadget@gmail.com>
	<pull.2109.v4.git.1778504352.gitgitgadget@gmail.com>
	<19f1605067e26c8e393c6c2e341844bcb3dc1b41.1778504352.git.gitgitgadget@gmail.com>
Date: Tue, 12 May 2026 09:40:42 +0900
Message-ID: <xmqqbjelqx2t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Kristofer Karlsson <krka@spotify.com>
>
> Commits not in the commit-graph get GENERATION_NUMBER_INFINITY and
> sort to the top of the priority queue.  After those, commits with
> finite generation numbers are popped in non-increasing order.
> When MERGE_BASE_FIND_ALL is not set the first doubly-painted commit
> with a finite generation is therefore a best merge-base: no commit
> still in the queue can be a descendant of it.  Skip the expensive
> STALE drain in this case.
>
> Add MERGE_BASE_FIND_ALL to the merge_base_flags enum.  Callers that
> need every merge-base (repo_get_merge_bases_many, repo_get_merge_bases,
> repo_in_merge_bases_many, remove_redundant_no_gen) pass the flag to
> preserve existing behavior.  git merge-base (without --all) passes 0,
> triggering the early exit.
>
> On a 2.2M-commit merge-heavy monorepo with commit-graph:
>
>   HEAD vs ~500:   5,229ms -> 24ms
>   HEAD vs ~1000:  4,214ms -> 39ms
>   HEAD vs ~5000:  3,799ms -> 46ms
>   HEAD vs ~10000: 3,827ms -> 61ms
>
> Signed-off-by: Kristofer Karlsson <krka@spotify.com>
> ---
>  builtin/merge-base.c  |  3 ++-
>  commit-reach.c        | 19 +++++++++++++++----
>  commit-reach.h        |  7 ++++++-
>  t/t6600-test-reach.sh | 40 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 63 insertions(+), 6 deletions(-)

Very nicely done and well described.

> diff --git a/builtin/merge-base.c b/builtin/merge-base.c
> index 9b50b4660e..a87011c6cd 100644
> --- a/builtin/merge-base.c
> +++ b/builtin/merge-base.c
> @@ -11,11 +11,12 @@
>  
>  static int show_merge_base(struct commit **rev, size_t rev_nr, int show_all)
>  {
> +	enum merge_base_flags flags = show_all ? MERGE_BASE_FIND_ALL : 0;

Curious that only this variable, among 6 that this two-patch series
introduces for the type, is called "flags" while all others are
called "mb_flags".  No need to change it; the comment is mostly to
show I did read the two patches with reasonable attention to the
detail ;-).

Will queue.  Thanks.
