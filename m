Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434D51D5CD4
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 22:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738623184; cv=none; b=oZmKiJI2tW0qgkQTu7ypuxKwFm1d3/CL5QLLMLrHWijwOZp5QZC7QBzbypxPVQSUTsRl3UMxzvaqpkJPzmqXc42C+QLDPoHsF9NkpAyi6YL0ZE/96PC9Efy/hD9FLOGCVdXpLyLvYNylkgmWAjyAUk22Sk87LjJrroECQ9DFIrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738623184; c=relaxed/simple;
	bh=xzNwIkGyv/R9BWUoKb7vANQlDOY4V/LcBhX2pAYNgDs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cZ1S/TL52wlNlzFhUqYAYh08i/HmljKdE5B06SxvgTIkD0Hg6t22z47K2NDxsqGEM+AbtmFgHnZHTY1rJqiZacl5ArVReOlg+MYVef96oiXH3ZSs5qR9RJhfliSv4J+f4C5uaM+ttjUQ1acAP2AO+rroSVbg9q3jYT0vms1OUaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qhnyRvsK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YL+LA8nd; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qhnyRvsK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YL+LA8nd"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 12D2A11400C5;
	Mon,  3 Feb 2025 17:53:02 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 03 Feb 2025 17:53:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738623181; x=1738709581; bh=xzNwIkGyv/
	R9BWUoKb7vANQlDOY4V/LcBhX2pAYNgDs=; b=qhnyRvsK494yv52DoXN8G1b4sA
	4kW61fpBy1xSGpkkCXgqpeLH6gAo/h50XIlNeTIqvZXkqSUNsoe4YazNO7lCGCHO
	5NEXwNspXZnDGKcxG71k94hvkVFT/KUku3amSM6aDIxbx4grNcgvEsZvkCpsUl+D
	8RVf0s1MCk1LCtdl7kHFxYbojWui/KOdFnG1yPjcCQCzmLNyRFENJ8vX0h6pIo6z
	Qv43n48pB4YkGicC52AXg+P4ze5cHmXznZUD0q3r9iwcPM2se7lfyuCGO/PeGul2
	WG7Gi8v4A6jcdGsxoqfpv3mJ+b3wMPw8/Tfpgm2lEtg8socGuTqoeKKJMFuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738623181; x=1738709581; bh=xzNwIkGyv/R9BWUoKb7vANQlDOY4V/LcBhX
	2pAYNgDs=; b=YL+LA8ndxxlXwZDwyf3IU8EKTWaXN5mGA2nHMZQdZz0yTZ41N/h
	rhIZJ9Sp6yBIrrbltZMdd9eXuruwDFauVfHVmH988ihEg/2QuCrV54DIMgmoVSDy
	a1ifSYeejnGlluxe1FdbJ457pVTvG8C4yTPoMHi0vg66sTNoJCPc+DLbHYZRaHqq
	yT1UyVbf66iH1yiabI56jMZrZuxWPQEScLI4BwJg42EArs0+r1SyV0DgtW4Jz5GA
	pOlj5ka6OoAjivqHOih95OsnHJjXcKoLO0gvdjCcefyai90dqmi0aqWtBCIoA0Qn
	WUkFqgZb+guLz20ZuxjzbVm4Bm7TINlSeMg==
X-ME-Sender: <xms:zUihZy26u1qXbRWSQU_fK2siS-v6PEQtBcmGZP-iUDt0VkYyV8nUJA>
    <xme:zUihZ1HPpDoEcdXGTLlSNCWfCDdfviFjX0r_CqGxw4iEscqerys_22-z5NOBkqjfw
    xihQgGlKWvsxnO3xQ>
X-ME-Received: <xmr:zUihZ65je15ewCnt7DC2hC533LpbRC4HyZZnBCbrh8NLK_3c7Tjzkxd0DIw0eswSF6GlVd_UwLyxonCvthOi8F6-MVid92V3ilnT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvvhhiugesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepshgthhgrtghonhesghhmrghilhdrtghomhdprhgtphhtthhopehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopeihvgifohhnsehrvghvihdrvghmrghilhdprhgtphhtthhopehpvghffhesphgvfhhf
    rdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:zUihZz0xYyMYDs_VKJiTvq--GzS5ZSHt2oAjyg-WbTH4tCjKxzqfwg>
    <xmx:zUihZ1GJ-LVEOs-Yt1-1IzlLvM7FojhP8BxGbjIXhVczcMgvmh71zQ>
    <xmx:zUihZ8_ZwxvNSYiL8hzyWed1CLCAt4xdt2mWu6hWFbjdfU2Vh9DStg>
    <xmx:zUihZ6lIhYd_SjvxxryNf7SbFd1l7KCVqaRJlcNStkRND2wTPOmsNg>
    <xmx:zUihZ7aTopYfHD-SAGISsfkgV_Q9hShoxylSZIpSyQ39I6BZxVnCFBvw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 17:53:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: David Aguilar <davvid@gmail.com>
Cc: git@vger.kernel.org,  Scott Chacon <schacon@gmail.com>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Yongmin <yewon@revi.email>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH 1/2] help: show the suggested command when
 help.autocorrect is false
In-Reply-To: <20250201213319.153109-1-davvid@gmail.com> (David Aguilar's
	message of "Sat, 1 Feb 2025 13:33:18 -0800")
References: <pull.1869.v4.git.git.1736760824201.gitgitgadget@gmail.com>
	<20250201213319.153109-1-davvid@gmail.com>
Date: Mon, 03 Feb 2025 14:53:00 -0800
Message-ID: <xmqqpljyzlmb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Aguilar <davvid@gmail.com> writes:

> Make the handling of false boolean values for help.autocorrect
> consistent with the handling of value 0 by showing the suggested
> commands but not running them.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> This is based on the sc/help-autocorrect-one patches from this thread
> and is in response to the open question from "What's coooking in git.git":
>
>> On Fri, 31 Jan 2025 18:51:33 -0800 Junio C Hamano <gitster@pobox.com> wrote:
>> Looking good except for "should 0 and false be 'tell it without doing it'?".
>
> source: <xmqq5xlu4bt6.fsf@gitster.g>
>
> This is what it would look like if the answer were to be, "yes".

I obviously like the updated semantics myself.
Thanks for updating it.

Let's see what others think.

Thanks.
