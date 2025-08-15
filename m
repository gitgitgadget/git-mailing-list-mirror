Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FCD306D4F
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755272504; cv=none; b=fJYNt5gw8mJSuiHv7Km+2Q9bXmudmbSemVhqRtk9o8mhPiM68hNGgd/ztLgTJ2iGfErqRc+8O4auD1Ga/1A1KwXillnG7aGev5/5PzPedv73Ss/Eyxi7xjrZfPFyo8Q5R6l4WxWwj2DfcIBQo1zW/pOxWw/ygd0buwtJtRDybLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755272504; c=relaxed/simple;
	bh=vYFKJZszuzMEf/mjROZJvI60RUWiGM7z7TBXK9U9ljQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lKKui9EJLJCBPU7nm8AJTZPExo6R6YQO4Yj+f4iTr2dM9A57sWXyMyINrlUmM6kR3Vy3lJR1SG2nPmOWLhpGLhiflHCbr2RQHwvtjwBUCv5BCkxDzzKpI6PRUTnWeKRUORgOTsC//bfsZO3YK5XAq1v81T1MZRllKU4U8A/IMeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VldkHBbi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lDYFFKbN; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VldkHBbi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lDYFFKbN"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E26817A015D;
	Fri, 15 Aug 2025 11:41:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 15 Aug 2025 11:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755272501; x=1755358901; bh=hsVowQ9oHg
	g7nXHAJfGFVCwVgkvdIOawL7hEwJeKytI=; b=VldkHBbiSyTUI+iEX6HBQer95A
	Dq88KVWOlEZLvXYMgJZMiYrHuHaH4ushTduZjZPaJrponAnnhc5/c2j7NHR2yMs6
	d2SFs1oXpTWeMgDry8sdTvU9vQFYMzRQxg4LRfL8I2344WXQicVEvJOEL4TN4im3
	sN/y7qxAIVF9OJe/yYjoSTxLACx0PVc69y2rPBtsXo3qpF1jxPhVS7ftWiRNsOP/
	hVZscK9KBtyJps/v3I/kkhqGX46H760szNP18Ez/Z3wcCSynzjMemLqZX75S/SC3
	LrKxk/6yZJSU0tO4LSI4/6BiEStmVsTK+xkwJoQmqYIZnekR6vLhfYMkPIXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755272501; x=1755358901; bh=hsVowQ9oHgg7nXHAJfGFVCwVgkvdIOawL7h
	EwJeKytI=; b=lDYFFKbNQh3sNSl4grPy/WFQHHOJlkuXh2X+PvwZJbZxFnID4Vz
	PdR/GLVw0YHB5KxnQnr5fNHTeKCgX3ZqyPJzXVbL7VsWvYbOYPDU/yZoA2lTdPyH
	8VhuQhH9jkrquwPYTNeAt7QEgZpa9c91pII9Ikvx3MSYqQXHAHcwGpGTTsBnIacR
	zL11AWyb7IC+1VDf/Rn4Wf7IofDB2I/mOhuuOYd4SJ6Glub7UbSsygEu0uQCnD4z
	bHWGv2hCkce7KsVE1j/AiXX2Tpw3fCHu9JkbscRSDz8qzY6TT/FcCpaMQVo0ayKK
	X96b/TxVOqaFYtQjjQezvxe5DOkaqOJjh2A==
X-ME-Sender: <xms:NVWfaA78GVyF4TAFQK3r8u7ejTc3djblDY04YNS2GNvrMURcbFlrgg>
    <xme:NVWfaFLu6kQL4JWdkAyuRMOqQc54CMuC96QAT_VuqJhUnJYexLBaCA-rmjGuTH7Qd
    tDxVc-Ncb2FyV3WUg>
X-ME-Received: <xmr:NVWfaI6ohyJ0gAVd_OYJCG_FddpJ2baipjdCSbxu3hIcZi31SJkiVHEkfAaV-q1nLEdcCR2sghmFC_XX50sgs_7TCzKhIwg44cqGBzs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeegfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrrhhlshhsohhnrdhrihgthhgrrhgusehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:NVWfaAzUe4YERm0xd6u1L5eoYSaI-7idoPQuiz5qnO1jRkDCcbTobw>
    <xmx:NVWfaEaS3XAbX7HAQI8Co3BQ9Invx5imWmJvuDeGhPghCPTS2Jr6ZQ>
    <xmx:NVWfaKQ1HRp17RCRDB9GcXxnXowxLHRbGyfYRqc095AgPoBMMrzTWg>
    <xmx:NVWfaGzv_2peEVPXjM8Wg2tTXKaMpLLrT1q-mN4HXDECXGAz9I5mKA>
    <xmx:NVWfaK2nDx1RQAyOJTuaTs_5Ff0D_zGTX28TF3HFhu3gxSGwn_L-FJWT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 11:41:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Richard Carlsson <carlsson.richard@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git may delete current branch on case insensitive file system
 (Mac)
In-Reply-To: <CANKG3zmtFmFfUDtARuOyAgv8Le+Rotwmdv-sWWnQ2Ca+7d0DRw@mail.gmail.com>
	(Richard Carlsson's message of "Fri, 15 Aug 2025 11:50:17 +0200")
References: <CANKG3zmtFmFfUDtARuOyAgv8Le+Rotwmdv-sWWnQ2Ca+7d0DRw@mail.gmail.com>
Date: Fri, 15 Aug 2025 08:41:40 -0700
Message-ID: <xmqqfrdstwwb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Richard Carlsson <carlsson.richard@gmail.com> writes:

> This was a fun one. I accidentally upcased the first letter of a
> branch beginning with "d" instead of
> upcasing the -d option as I had intended, with a surprising result
> (Mac OS). Easily reproduced:
>
> % git checkout -b dummy
> Switched to a new branch 'dummy'
> % git branch -d dummy
> error: cannot delete branch 'dummy' used by worktree at '/Users/riccar/...'
> % git branch -D dummy
> error: cannot delete branch 'dummy' used by worktree at '/Users/riccar/...'
> % git branch -d Dummy
> Deleted branch Dummy (was c32dfb2).
> % git log
> fatal: your current branch 'dummy' does not have any commits yet
>
> On Linux, you instead get
>
> % git branch -d Dummy
> error: branch 'Dummy' not found

Perhaps you want to opt into the reftable backend before everybody
else does?  Because it does not store each reference (branches, tags
and their friends) as a file on the filesystem, it would sidestep
the above issue case-challenged filesystems has.

