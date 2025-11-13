Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D302580F3
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 21:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069014; cv=none; b=l6wawO1rvdWNqu59Yso2PDWyU7fYVrQIAHZ+9yUvlHsXRxC6D79dqcbl6Xukk6q3SIo/ncNQpu5AtdpSgmVmrEQsps85dAa2zzRy5l1x2SFWbMpJo6+AfuboJNSJsLVxhVzKiYTiqzYNmy+hQ2x3PvVEotGg3yOUDNY8txG7am8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069014; c=relaxed/simple;
	bh=eu+AqXZ7ws5EOOtJ0Q2U5dIP9JnjCM8b9LplYz3CV54=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I1MuUsf2kQKT+lHRRhfU6iLfbObAd9bsuAetMk6ipQo+bNohgeqIrkZS4WGkfS/OY8WsUdO/ehLpv9H9nLqBishtB/1sohW9GllOs+P4Z2yMtWBUlty2guPrIHW71DXdsA9NrV0/FQfwIt/pzeHOgezo52UHv9CllJ5bj7/FywE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FURamPeA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0MOJUQQ/; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FURamPeA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0MOJUQQ/"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 812F61400135;
	Thu, 13 Nov 2025 16:23:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 13 Nov 2025 16:23:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763069010; x=1763155410; bh=rH7mwRxBJH
	C5SFXIlNtAq+Be+7BpJmULtswIoQLbv2I=; b=FURamPeAJo0djqEJK6exepJGFS
	uUFEygnvdVOn+8N9cbYX0HxinJKgB3SMiqNFP3tMZoUUYO3253RmWArRZZn+n1HJ
	cz96zUYt306cmTguYREZkjg/tQ091hAHM40YbgnzgdYkhE7ez2octVlpzD4UDphv
	p6nTBGlExR7eRFkezV4bETROOLfhbQdwNGaVKtVj8oU89shHaVox/Sn6BXIZhJtv
	WmLGbWfFSrC2ZJBcuaAAcjm50Yh0sK9eFVNhs8/Ec+7vkfu00emu+pqz/nDuY8lZ
	qhnlsngWyR7v+R2EKClGRJpZ8RUvkmBFroQCj7C/pbQlC9HFoOlk4JbIFr5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763069010; x=1763155410; bh=rH7mwRxBJHC5SFXIlNtAq+Be+7BpJmULtsw
	IoQLbv2I=; b=0MOJUQQ/KjbVOtxQ+BjZZ6ITKK6hhXWSBNyyILZkdoKdherOIYA
	GBeCH9m+SytluIe7ft2Q6Jr7m5d8m8a6c/kFSDGvkekzcMg/k0FW+k5k7D/l0B8e
	5UqN/CRr3Z6T4RSRjhqiu0mc2AqdTt8g6uYL0Gf1GvZjjiPOUDSc0O2NBl9dQtkQ
	9xGGpZJ+8USrguxiRdKY60wINd2Of8N0KQ2yg0zSw378LSDMDDgOWfieuC2HuEi8
	RNwuSCG7o7dcq55YmTJHlFHTYVw6y+4wxVxVNdOd0QS4R/xI91gBNaAgqWbkmXeT
	+oVxmOqmc0+sDroa7iCjRq6uoEG5mU3SQbA==
X-ME-Sender: <xms:UkwWaYz7q6riVsqysQ0GXzCOrm0lAZGMI1-O4H82jBPYA198O37EvQ>
    <xme:UkwWaf8ju3O4Ix9d3TBL61pLXmkGlySdQY9HGhb5Ixtmx2DdgOaHibcntHf04lpda
    W9Nl3m4O5Xjpn6cFnnBzQ07lVF5eaHd5bzIG74MWDoc74DyDakOeg>
X-ME-Received: <xmr:UkwWaULI3ALO_fkqGH7TwGEOIsQhGbSDsVzXxxWfkMjVwxnmCa2ojAIeB24zBqOFC0pxHTc_8wDO1Amyrf75vbnIJs12-lJy0LsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdektdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepgeevffdtteekueeigfejheeukeeltdehkeeiuefhjeekgfeuvdelgfelleef
    keeknecuffhomhgrihhnpehfvghttghhrdgtfienucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhn
    sggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrth
    hhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepuggvsghohhhmrghnsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:UkwWadf_sVBIW74Rd_PL76w9nqvnQ6UO2XA8zDpvh0DjDeHkF3rzMw>
    <xmx:UkwWab_nTvog2m0XFbil8grGXR1U_A0crcyrGaSl61Q4e5Bv4XanIQ>
    <xmx:UkwWaSplEk1sL6s0GFDf9ngovhFYMH3BNamOcTVi0d0gSagofkLr_A>
    <xmx:UkwWaYBFeRTTt6MKH3dlAbrKaqPU9nZ14JNoLYGCaj0QoMZz0wk7ug>
    <xmx:UkwWaaUQwTLRl20ShMI9KWvg_719S_qrEJOppfS6WAGHUcgvgCa80S_i>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Nov 2025 16:23:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  ps@pks.im,  David Bohman
 <debohman@gmail.com>
Subject: Re: [PATCH v5 2/2] fetch: fix non-conflicting tags not being committed
In-Reply-To: <20251113-fix-tags-not-fetching-v5-2-371ea7ec638d@gmail.com>
	(Karthik Nayak's message of "Thu, 13 Nov 2025 14:38:37 +0100")
References: <20251113-fix-tags-not-fetching-v5-0-371ea7ec638d@gmail.com>
	<20251113-fix-tags-not-fetching-v5-2-371ea7ec638d@gmail.com>
Date: Thu, 13 Nov 2025 13:23:28 -0800
Message-ID: <xmqq7bvtlj8v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> The cleanup section is reached with `retcode` set in several scenarios:
>
>    - `truncate_fetch_head()`, `open_fetch_head()` and `prune_refs()` set
>      `retcode` before the transaction is created, so no commit is
>      attempted.
>
>    - `fetch_and_consume_refs()` and `backfill_tags()` are the primary
>      cases this fix targets, both setting a positive `retcode` to
>      trigger the committing of the transaction.
>
> This simplifies error handling and ensures future modifications to
> `do_fetch()` don't need special handling for batched updates.

This may be sufficient to clean out the hanging transaction that the
original code forgot to commit, but in scenarios where this change
makes a difference, i.e., where the code does "goto cleanup" before
it calls commit_ref_transaction() in the main flow of the code,
there are things that are not performed that we may still want to
perform.  Namely, we do not

 - call commit_fetch_head()

 - run set_upstream processing

 - honor do_set_head flag that was left for remote that does not
   have followremotehead=never

but don't we want to do some of them at least?

If it turns out that we want to do all of them, I also wonder if the
resulting code would become easier to follow if we lose the call to
commit_ref_transaction() in the main code flow, do the above three
points before committing the ref transaction, and then after the
cleanup label, make a call to commit_ref_transaction() if we have an
open transaction and we are not atomic (regardless of the value of
retcode at that point).  That call may yield another retcode that
the existing error reporting at the end of this function may have to
react to.

>  cleanup:
> +	/*
> +	 * When using batched updates, we want to commit the non-rejected
> +	 * updates and also handle the rejections.
> +	 */
> +	if (retcode && !atomic_fetch && transaction)
> +		commit_ref_transaction(&transaction, false,
> +				       transport->remote->name, &err);
>
>  	if (retcode) {
>  		if (err.len) {
>  			error("%s", err.buf);

IOW, something like this on top of this patch (not even compile tested).

 builtin/fetch.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git c/builtin/fetch.c w/builtin/fetch.c
index b19fa8e966..d3eb65dac6 100644
--- c/builtin/fetch.c
+++ w/builtin/fetch.c
@@ -1888,11 +1888,6 @@ static int do_fetch(struct transport *transport,
 	if (retcode)
 		goto cleanup;
 
-	retcode = commit_ref_transaction(&transaction, atomic_fetch,
-					 transport->remote->name, &err);
-	if (retcode)
-		goto cleanup;
-
 	commit_fetch_head(&fetch_head);
 
 	if (set_upstream) {
@@ -1957,14 +1952,9 @@ static int do_fetch(struct transport *transport,
 	}
 
 cleanup:
-	/*
-	 * When using batched updates, we want to commit the non-rejected
-	 * updates and also handle the rejections.
-	 */
-	if (retcode && !atomic_fetch && transaction)
-		commit_ref_transaction(&transaction, false,
-				       transport->remote->name, &err);
-
+	if (!atomic_fetch && transaction)
+		retcode = commit_ref_transaction(&transaction, false,
+						 transport->remote->name, &err);
 	if (retcode) {
 		if (err.len) {
 			error("%s", err.buf);
