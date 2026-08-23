Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094612E738F
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787498804; cv=none; b=uaBg+S6Q3BLWuKccpIkth67zhxYb2J+BpLg9xpdJQVSggQGbqXv1ziBnuFdK1YHej7J8pxaUQwrHA8ccdMm2+8JZ3djKNjSQnYSMMk5rL9G4xH/IE+5tmQ0VNrvHhlU/R8NfiZBKRtS47jFMmRTZJ1M9+Ib3u2St+xAMXhhFAA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787498804; c=relaxed/simple;
	bh=uXJiCm/XcT7c/67OYZdFtE50STgH714Rxqz81Fr8OzM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dqF5MUfLHmBnYivH4ET9lbKUHpyeskF2IavgUqj9A/hqE+5MHUvhlZI2vy3YZdXyW1sgK2AlLnOrrLQaND84HNqH/Kv9VOEr0630Q0SrQrUawLD0HBatyu78WXwdJvLsRvXn3OUjY8jjZYFgLzHUrpXBefnISuuODFTKkC/4fQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AouRddN5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jJy2XCXy; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AouRddN5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jJy2XCXy"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 359D81400033;
	Sun, 23 Aug 2026 11:26:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sun, 23 Aug 2026 11:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787498802;
	 x=1787585202; bh=URZuINNU5uDW/55wkLv/qCBO9KBzdX1XG6gy2+wzBtQ=; b=
	AouRddN5OmCp2z1TDgdsfRNspbfa42pxD1GRzx/qlguB95RpvbUyNyz9J7vh5pTr
	tTu5AsgjlRB0HTjTRDv/Q/I3gAO/zbWgSudf0RK4MLHz21ZGb29nXwGH8zU3KOBO
	JB8xgX2+DJcjgICFVlSocrQVTbvkTNvaVwk8Ie+R3jJd7UGf6Tpv2cYhb2z7v0bH
	FnIGXJmADlxc8H2urFwbx0dNhrIEETPcdQnKYV9v5vdCwz41kSAekel9vYAZtLnC
	fYZJ2U98Ovw2AFieQ3Z1kklneSY2rQlhCmRZ0+KSpjimIAxcL+lflmjqP7qwDjbY
	1+g8BJ33B92QMCd0K6683A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787498802; x=
	1787585202; bh=URZuINNU5uDW/55wkLv/qCBO9KBzdX1XG6gy2+wzBtQ=; b=j
	Jy2XCXyYvEKV1s3aHCazlhTapGOI5uTqydlCeceQkk2sYp5rMwND54V9w1ooyHnN
	ZiiM5FB4kPnLwD5yZpvepqTrYq8yeb/rE0FiFKwL4Ea5MhPDW3rKnjH+ktO6MvZv
	QEiLUqq+iV1Ng6mny0w7v06Ux/byAb41BRBOKI93g3DAxet66RMUBoUCcfGA+25V
	WeX297AAdbubKZIKZCv5bMyLngk+HDjAhdcbF113nMcxBCmRpKGGSq8ISLSYC4Br
	FXRY9yTPhiEFN+etiPU9FX/ZQUL2Qsx76y/ErNX7xU5zn7BBJIBBs+T93RDIbE73
	FNQvWHyWhNO4V2PiORi5A==
X-ME-Sender: <xms:MhGLarj7_SFAbU3y_Gsi94Lltaa6UpwVofZisdCfY5znt0bd8R4Krw>
    <xme:MhGLaqSBuUX0P1tCMMJRJ71c3LSBRuI3KglvY_XLhlDIdKyOUPTHexm1F0gygAlZ7
    syWkCkSeW4ds5URs1tpltDZBmsbbP5iaVmXdAE2rSPCNKUGYyaH>
X-ME-Received: <xmr:MhGLatVm6QA3R_HUy0zunJ-3T1tGKNi3PjvWMOv1S1LfphDqK6-RiLRRL1lob77IvXgrYHk-KKyw1dAfdbEW-uyQxyHYLc3Rjw>
X-ME-Proxy-Cause: dmFkZTFbACIwu4H3RusdNoLSN6StitPAtgWVwA7ezLLsEzXONEIVHAQFsCsd6yFdqD2AF4
    XmypHQVOzz8ly47Q/LaJFZSoY5Wxm7A3Mh2Pg0jt9JXvEtuQ5wHyHG/Ji4PVaTvcKHUvip
    PMyp5HQty7sTQDFYnzfEVDK1pDyomTlnEjFgNYsvlDQnT+ipmUh14ErqXBfXybh8jm7Qzc
    ngkQFAfULIUcw1tDHibcfOnjGiX/DCyf8t3Se3QwCETs1yIzUuqTZIdExKh1u6EcHEkLJT
    5TE1oDlKpQdHAfn/ytJjW9gmoFFpx1IafjA8Koapf59qn+8kgjU/qJ/66fjqC2N+8jYXih
    e5N9DPzMp9m7L9KalBzo/E0hicsW7MH/oj8KvKSzVsVORstgu4U3HiyHm6Osvf6XwEvX+Y
    hTeWx616KCnwD0YlO48UOrMkT1mGW39yxNJmPh3QBJgyntjAgdIJzPvDdh5iddGn2ztS8I
    2jv7kJAwUqkcmMMI4swx0EanROBaORTz18z/GQSnb9KZxy71duyqMqol69hL4DiMmotlz3
    122+2lMVvpSaLxDX9Rbi4EwYGFfGXXqxsOTfg122cwS3Jx4cPHRwE+fsq77d5eL9BktNoQ
    33lK23Zz+qeZ2DRNBKiSb7NHIVLNthNQor7C8K7SY5vm+ybxk5f/Z0l3mx5w
X-ME-Proxy: <xmx:MhGLauSUzyabVGNhc38kadwTfmqPX1qtSKmWMn7gGSSHRqc45vLH4w>
    <xmx:MhGLankRDEhmmP5WHJspQ22vsCHMzUD_omuf3vsP2eVrfg68wqi5zw>
    <xmx:MhGLak6Gr-BJ1yEbFtoPzCjTXF9GUtZU12yjH2jXIWPWdcBitH9Llg>
    <xmx:MhGLatieKEXp-rHlthB1Kjka95gKnJOn9hypCwYUuIsXUOirMxYQ8Q>
    <xmx:MhGLavVXnvmXKft0RlVkHZdKHFz1piEmG25TlMuw5heFC3OcrULuhinF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Aug 2026 11:26:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Weijie Yuan <wy@wyuan.org>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Alexey Samsonov via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Alexey
 Samsonov <vonosmas@gmail.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/3] treewide: migrate from legacy utime.h to utimensat
In-Reply-To: <aor07LvsXOy1p7vh@wyuan.org> (Weijie Yuan's message of "Sun, 23
	Aug 2026 21:26:04 +0800")
References: <pull.2209.git.1787322203.gitgitgadget@gmail.com>
	<aonIVn-ZQoMKWCAd@fruit.crustytoothpaste.net>
	<xmqqzeyeujde.fsf@gitster.g> <aor07LvsXOy1p7vh@wyuan.org>
Date: Sun, 23 Aug 2026 08:26:40 -0700
Message-ID: <xmqq5x10vowf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Weijie Yuan <wy@wyuan.org> writes:

> Sorry to interject here, but I seem to remember that dscho already has a
> few commits with an Assisted-by trailer that have made it into master.
> I´m not entirely sure what kind of assistance he received either, but as
> you suggest, it seems better to mention this here sooner rather than
> later.

We know Johannes well enough to trust that his patches were sent
with sufficient due diligence.  So...?
