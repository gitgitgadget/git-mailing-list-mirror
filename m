Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C0B13AD03
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737656694; cv=none; b=IuAwJ3YgP6dWPsw8hruMOdIaWZ3kOjHCjDUHdEw32RzlhnppCmkAZwCiW5V+dzQAyoK3GqLzzpnFvIEvvhRc1aTnRq09eiWZRM26pTOvcLLE7gHglVOpIAzKvnfLaBeAbJUYH2kqDfeHy9B5iJc2iad6/UaTGF5I4b+28/2iWK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737656694; c=relaxed/simple;
	bh=0sQPxUB4+ozONGjXzErCv4du0jRpfqmJAhmX4qOM1o8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jys3iYDFbXJqNE8hV09w1BCGnTFCRPFUdHkeQWtJ1EMuqftcJiKQrPAGv3U0LtCOlE9rNJepkbJeVdXz/BPp7ssjJK3cq1G6Q9+1LaH1pIK73hsn0TUl1qmkSpqnMjTejVLf7UBn8Z+WGJnJ+rM1UoTf12EKftZpZYKjfHKXA3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G8NVAWZP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wkgDoHun; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G8NVAWZP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wkgDoHun"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id F40D2114012B;
	Thu, 23 Jan 2025 13:24:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 23 Jan 2025 13:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737656690; x=1737743090; bh=L8q/FwuT4P
	nucm+xbZ6mTV75sb8psS3eyKWh6pR2JKY=; b=G8NVAWZPMdWLtJXzTPbqqEnjy7
	biV2wYOU1RO/UFYdqJLHJKQRpXHG299gfZhv2KCnTy3SvzwBQZmyWgWYdaJThZD8
	xOIW+pZmnPCpOQ/zbd1O21FVy5Hz6d09Hcr+m2t9gigwXcxAk6MEoLSVSFsX3GuA
	kueZF0P4YCYvZ64quwh5jASC6koo+uiI9Fhydtssy6y8TuvXWf6BKdUKPVgjw3uv
	wBMO9bm8cpFyY59OeuDk5bWz9Fb0VcWte/BydPlrsxbwcvTYHfYv3TIWKYD3KHPG
	WXDh8FJ6DZV3otzCSvT962wqJB6q9Fr5cB/mu5aP7XHJ6AC//ROWq6reK/+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737656690; x=1737743090; bh=L8q/FwuT4Pnucm+xbZ6mTV75sb8psS3eyKW
	h6pR2JKY=; b=wkgDoHunTzv4z+V13STsoK8Xkart+miA5BUpGfcLgsCiE8oHx9X
	gbS2RlZ9+fcTyojUMr4KNS3kAEHRRURgle7ie7FmUnVbE27LYX7wBfuqICFGZtMX
	CNZbhWyxBKA13vRDiwrs55PXpYuNnfo9qOygGLA6oNGdO7LytUScUj06iieUOxkd
	jg9P/NeNwaYuo791p6MmTtSOja/qIPrM3/c8+UFdTgcLjS5NPXLlq4T0H42fber/
	4gV2a2ltxr+Zrtdk0013E1kmwiFSy4jpJi2lTizPKDHpBh/vvrNzBacqvXN48VVE
	wg4e2Y3fZ+CZ46N8Pr+PQJbv48ic3fOwxmg==
X-ME-Sender: <xms:comSZzz55P3phggSDA82X1ppQxq0QMr-LMkuexi-7OR97KDmDrtndA>
    <xme:comSZ7QisOXAfoOt1EBK7fJ4kdkeGQ0QTjgxDf3vi1TLsbVgmXakPtZgCP1O-XsH1
    TA7dnQuILyL0Ckjlw>
X-ME-Received: <xmr:comSZ9XWfBh0ljdWgvCC3N6tIucBWxOQyavQnxDR5bloey8juITAOAzd_c3eSfrq-5q6ny40nMU2O4GlIj8imptA5V0bKzDdEC6S>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgvdefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshgrnhgurg
    hlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepjhhohhgr
    nhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:comSZ9hCap3Fs487HqQ-PidL1pWcdc_peaT3CV4MzTBHV1xNoBjN4w>
    <xmx:comSZ1BKsKmMwUBCMJrzDnntQvDec3TpC-yqaoipswKvPbJQnjJMxQ>
    <xmx:comSZ2IgegVVpqzo0dEDE82t9IhIzhGwn5XzKob7D6vSwSZ_CyFmoQ>
    <xmx:comSZ0BnDVdoWToH3B2iBlUWMslt2N1MkRiU6x-ea2_Zy3WkXPpgPg>
    <xmx:comSZ30ls1uJwETznBZ9TulqNN_WrtieSP12AFDlm0wmUU-z9Na_qrF8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jan 2025 13:24:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  sandals@crustytoothpaste.net,
  Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2] reftable: write correct max_update_index to header
In-Reply-To: <xmqqbjvxs8me.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	23 Jan 2025 10:11:37 -0800")
References: <CAOLa=ZTL9n_DPhNr49XAd6bT838kc09oVx_AH7Pb4o8VK_xQ9w@mail.gmail.com>
	<20250123135613.748916-1-karthik.188@gmail.com>
	<xmqqbjvxs8me.fsf@gitster.g>
Date: Thu, 23 Jan 2025 10:24:49 -0800
Message-ID: <xmqq5xm5s80e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> While this patch was merged to next, Dscho reported that it was flaky
>> on macos pipeline. On further investigation I found this was easily
>> reproducible when the leak sanitizer was turned on and the reftable
>> tests were run. The fix was simply to add the missing 0 initialization.
>
> If it is already _in_ 'next', please turn it into a relative patch
> on top of it, instead of replacing it.

For now, I have tentatively created the following and will queue on
a separate kn/reflog-migration-fix-fix topic (which would be ahead
of kn/reflog-migration-fix topic by this one commit), in the hope
that it can be replaced with a version with proper commit log
message that describes what bugs in the original "fix" are
addressed, how they are caused (e.g., how does it lead to the
breakage to forget clearing of arg->max_index in the first hunk
had?), and what their fixes are.

Thanks.

--- >8 ---
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 20 Dec 2024 13:58:37 +0100
Subject: [PATCH] SQUASH - needs to describe the breakage and fix in v1

---
 refs/reftable-backend.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 68db2baa8f..bb658826fe 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -920,6 +920,7 @@ static int prepare_transaction_update(struct write_transaction_table_arg **out,
 		arg->updates_nr = 0;
 		arg->updates_alloc = 0;
 		arg->updates_expected = 0;
+		arg->max_index = 0;
 	}
 
 	arg->updates_expected++;
@@ -1502,10 +1503,9 @@ static int reftable_be_transaction_finish(struct ref_store *ref_store UNUSED,
 	struct reftable_transaction_data *tx_data = transaction->backend_data;
 	int ret = 0;
 
-	if (tx_data->args)
-		tx_data->args->max_index = transaction->max_index;
-
 	for (size_t i = 0; i < tx_data->args_nr; i++) {
+		tx_data->args[i].max_index = transaction->max_index;
+
 		ret = reftable_addition_add(tx_data->args[i].addition,
 					    write_transaction_table, &tx_data->args[i]);
 		if (ret < 0)
-- 
2.48.1-259-gf9754493bb

