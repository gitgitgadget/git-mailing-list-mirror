Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E585270EAB
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 22:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765233781; cv=none; b=E7x/ERpaLeuV56GtAS88OTsD0o7S50WCPOILXnIsn462x5Y+pmtbKX5OnrvansCsJPZDp6z84VG7orQIjqdHkwCHx025/BUR1xArCEDAFy0DLNHfZ37ebaGvRoxoFBdsEbA+DIUxvduGMM4lkhXYWI+w3NtHdFC1qLVottRvCyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765233781; c=relaxed/simple;
	bh=XZ+gdnXxm9Dj4pUdTf2WdUw6tca3deiWXfPv9zOWCGk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hgvmQ7UWkEdIuoevuTbakmcddZ1r5CwF8JMq4DHX/vULcDoMltoYjeZIgSwR+DZYgtI6U79ULVTGqn1h9EqOoEq3vyl1XY2W6UOK08O4KqeNGNVdy1fwaRP20rPzNp59IYu+P93tKps1v21TFujx8WBoZYPY0IdD6K+uWzGFLLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DZeg5i93; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YvnNM6ps; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DZeg5i93";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YvnNM6ps"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 9E9F1EC0422;
	Mon,  8 Dec 2025 17:42:58 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 08 Dec 2025 17:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765233778; x=1765320178; bh=FuUc9cJA/p
	RJ16vE9AkPpsuxAY6ce9H8URpdIAo5YMI=; b=DZeg5i934DsiTZtk9iZuGVREAl
	8NNj3VqmoMXbFPjHD9RUF1rsI9HQ/C/jUCvE/IQmMpr6yAMQYy8jr7mrL5FQ8+mm
	Cs11wcSfpMQd49/QbPo/KrNnu99ttx+bUKtoigvguGq2n1IfX4qEypTybsXb+oAt
	Wx2YBrjMUCcbFq7P3PNdgn17JqXHkwirzwW7nt+BN0OPTDvid6hfqxfnIOXy8s8B
	3CzK8AV4UzJt/MHBihGhPwmeS8Igu0QevyAUyF893KxCGbLKJ4iYaMcQMZzSTOiU
	flYrr+8QyINCOF0P5JxKtK+PvZiraX4PCwLiIk8WpSIr+rkp2Y+0dREjZeAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765233778; x=1765320178; bh=FuUc9cJA/pRJ16vE9AkPpsuxAY6ce9H8URp
	dIAo5YMI=; b=YvnNM6psW4EjgDNLSlXBwDeFBDTE+uCbu8ypSk8ppFF+KUCHtDR
	LhUT6SJOf6GgwnIsK3csBd0aqccXN7tFOdK9q6BOMua7rMKSIo9RR5d4NHZ37rVV
	i+m0bOmaMLlNeXk+Ema/262O3bJLtA1VKcAbVvTV5Q0b4nVpwebusfelVM0hAax2
	xGNgod7pVS+Vcpi6W4CX8Gx2oLFi8w8BaG26664bICAJsO31nC0vWYBqzDIRs9ls
	b0Q3LdRHTUvRWu4htzlV4AO+7/mIaESzZAoHzZiCfgUemgdhh+FFPm02FY7rGyCX
	id8Yy8udLULZG62oWHoyi2I2JcP5F9pdLkA==
X-ME-Sender: <xms:clQ3aSZ2hQzmVBqrxs8NXPiL8F4_HyhNhYyzXjtydsikQmDcXT4WSQ>
    <xme:clQ3aZGzchOOR4WfzPBgLeB2JThb7EcjbuGFT7wK15vg8xiP6B1evJH2u0spkmEIC
    PVcm3alObR_yOCT6xJrqOz86gu-pzbmrYSanJwpODfoQNcxMxk4>
X-ME-Received: <xmr:clQ3aWwVmuX1BXkUmEw_NtNi_0pfgFQfr2oyiplDczg1bAaDw-IbhUxMxVCRqShWuwFCNT9i4KvCtcrgGoR1BOWovX_M2IQC1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepth
    hoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtoheprghnuggvrhhskhesmhhithdrvgguuhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:clQ3abmWV30PZLgdjY13G1Bn82DB0Ctcsr9sNmHWegr4bh33NDdVjQ>
    <xmx:clQ3afkxt9bK2g_qTSpmgY0fgMxaV9TmWnQTXr-edWxwPWCipxs_MA>
    <xmx:clQ3adwbopExAsCok7SA0CZ8Ip3Isow9orG5kCs0JJhjtkOvl4CZmg>
    <xmx:clQ3aUr75SukiazL8uv_jIR7gBMOsd0WCNxKi2BkvSWUGNdFpXPFmg>
    <xmx:clQ3aZc8U9vY1ya7SljHMXATjRxb19y96l86ZpY_W69QWSao8-WwyzKp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Dec 2025 17:42:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>,  Anders Kaseorg <andersk@mit.edu>
Subject: Re: [PATCH] last-modified: fix bug caused by inproper initialized
 memory
In-Reply-To: <20251208201501.GA216526@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 8 Dec 2025 15:15:01 -0500")
References: <20251128-toon-big-endian-ci-v1-1-80da0f629c1e@iotcl.com>
	<20251128205514.GA605489@coredump.intra.peff.net>
	<87bjk9w5yv.fsf@iotcl.com>
	<20251208201501.GA216526@coredump.intra.peff.net>
Date: Tue, 09 Dec 2025 07:42:56 +0900
Message-ID: <xmqq5xaglhn3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>   git grep 'memset(.*0,.*\* \?sizeof'
>
> that's looking for memsets of "0" that also multiply by sizeof. Looks
> like there are a few:
>
>   add-patch.c:    memset(hunk + 1, 0, (splittable_into - 1) * sizeof(*hunk));
>   builtin/last-modified.c:        memset(lm->scratch->words, 0x0, lm->scratch->word_alloc * sizeof(eword_t));
>   compat/simple-ipc/ipc-win32.c:  memset(ea, 0, NR_EA * sizeof(EXPLICIT_ACCESS));
>   diff-delta.c:   memset(hash, 0, hsize * sizeof(*hash));
>   hashmap.c:      memset(map->table, 0, map->tablesize * sizeof(struct hashmap_entry *));
>   pack-revindex.c:                memset(pos, 0, BUCKETS * sizeof(*pos));
>
> The first one is an oddball, but the other five could use it. So if we
> were to do a patch adding MEMZERO_ARRAY(), it would probably make sense
> to convert those spots. I'd be OK either way.

Thanks for making an excellent suggestion while I was away from the
keyboard ;-)

Between MEMZERO_ARRAY() and CLEAR_ARRAY(), I am on the fence.
