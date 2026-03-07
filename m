Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8663E47B
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 02:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772849143; cv=none; b=Omy3yasH3dZymGfvU45innmBYyPpGoFWYLRdNl2XDO8IwDgkqsum5yP/IX9SEovNwSoyc5l1hfWdhMtQC9mfuk6SnK57qQuG7jfFX1BNYHX1y0KudjumFx1nWDJC/8y6613qLJIALsrjkvb2cHWMMpnE/XWfuVI/st71DONnriM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772849143; c=relaxed/simple;
	bh=eCTpDjCdP6I3t/qAIkO2T9lVr7y8WRFuaea1BKB/8+c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=luA3MgPcsKd4YAXhNreIu0mNYBiV+P0eKEgsQE2N6mexCwt/YKJKbcF00IdIT0ojbg7LXKW6pel36shsAtsDRRA+tiyENZknCa+8v2jxL/GDdWIu4U4NDVh59gDxCuhrqcwHqUcHzRKPGpQbCbB42PjadxvKasXYxZzM5O0YL5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ddAdro/z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m8DnO/2s; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ddAdro/z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m8DnO/2s"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 39DB5140010F;
	Fri,  6 Mar 2026 21:05:41 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 06 Mar 2026 21:05:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772849141; x=1772935541; bh=sEBRmv/9JC
	mvxknOeYS1KAqgDtqrB62xE272tATKGk0=; b=ddAdro/zHTZvfGMUeeoO0yiDFd
	ArGxl43shxqlVRV+IrxDV4d13Pw6ZtJjg1S39tWD+HlCY+Kt/z9wuC4ug8+y0W/6
	OpuhFIXJ+4vDK5+ifFGItzwdMDMKCpyttznLQ6O/2310eel7odLLi0QoiK04ovlS
	ve+ZQ2OJU5QerOC27mSkLWfiMSYNfAyJsyb/xa6YG2KGlVFd2sArOBIM+FOKi6QM
	lT0plLpCceKBLNuC6FLXHjZvA7l1JoIwo2djleW6vrbtRsc1XdtHewfM898QuG5T
	kNqmkTCI3Na1uK9D/2z/ZW4qBr+JwTnqSAlJ1tOvEBs8D8bGGuU+S8f0AKfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772849141; x=1772935541; bh=sEBRmv/9JCmvxknOeYS1KAqgDtqrB62xE27
	2tATKGk0=; b=m8DnO/2sXuLlgmK7kaFvsW6Yg75Jw8IbmVrmWaC2ai02yWbIPQI
	6mGzklyUr1gRR213jHY9UYIRnZfTOJEyRZV0m4un/Qi39R/MXrASwcj3aEtPTXPh
	GKIFtG/3ho3uSf4Hx0BRL3GGY5Ht9DUnG/YaC+mzF28fxzvqV0NwlE0fLec+YlCo
	eAlcTXT9hrkrT0eCJOMkDAEI4AcrRyxEMtDXU09k2ZevGYthaaRizZmcZe91QRhP
	BtWfAebqn54hU1GZIxyj32PKmH6pXFSBOMlvltUMLh3wISgp5CK+UsbenoGryNUp
	Iqz6IkrBF6fI323ecS2cE50hRHF4t6S/1lQ==
X-ME-Sender: <xms:9YeraWebYjiPQcm2IRdXWqH6J082IbnsPD-Ca9zFRNsqM4IeOcrGMw>
    <xme:9YeraSyVQmH7QB-kF3-OhoBTVq5XrpDUGwVk6ZRde6Q3Z50sjWkDbTuX63yLi52u3
    V1nXE2QZ8vfice_wiDmRYvHnlrWW-KVO7y0T1gKZaHTFO4zMSiywQ>
X-ME-Received: <xmr:9YerabLgDG9xqHjiCpn55Tmt9AZRYKt7ak_y73MDxNAix0TWXTno_SVdWp2GZSeQ5AKTgxd_IajY6_fr3DvwHM7ZOJh0sK-Z0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhmohhnthgrlhgsohesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehtrhesth
    hhohhmrghsrhgrshhtrdgthhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9YeraUFNAGjjiq5pKXJYChJoQNZCz0UuUZorZLzNtv39P622Wv7XfQ>
    <xmx:9YeraX969aQBecPjcbIKJ9wiCy-7Ptn7PIPJ0v3gDLb6VQ5s4IHGDA>
    <xmx:9YeraUL4SOm_IvtBXr48MbsM9tef-83XRPan_fcfrbOIvaQTaVoHrQ>
    <xmx:9YeraVv8-8SCrlzuKdoihnfjfc8mW0-7cw-Z-IphHALE833FmlTR-g>
    <xmx:9Yeradg9nMhul7Kb4kn4qiyx9rKb1-iuhzPLJJifjxAD2ylCEGjavTtQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 21:05:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  SZEDER
 =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,  Jeff King <peff@peff.net>,  Thomas Rast
 <tr@thomasrast.ch>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/4] line-log: route -L output through the standard diff
 pipeline
In-Reply-To: <CAC2QwmLnLqMcWc8az6pVzz0oEdY282Nq-Lun5OrHaqHUiVE_9w@mail.gmail.com>
	(Michael Montalbo's message of "Fri, 6 Mar 2026 17:37:45 -0800")
References: <pull.2065.git.1772845338.gitgitgadget@gmail.com>
	<xmqqcy1gv351.fsf@gitster.g>
	<CAC2QwmLnLqMcWc8az6pVzz0oEdY282Nq-Lun5OrHaqHUiVE_9w@mail.gmail.com>
Date: Fri, 06 Mar 2026 18:05:39 -0800
Message-ID: <xmqq8qc4v1fw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Montalbo <mmontalbo@gmail.com> writes:

>> >  * Non-patch diff formats (--raw, --numstat, --stat, etc.) remain
>> >    unimplemented for -L.
>>
>> It would not hurt if these are omitted.
>>
>
> Makes sense. I can omit in a follow-up.

You are already omitting, no?  I took "remain unimplemented" to mean
exactly that.  Mentioning that we are not adding support for them,
like you did in the above sentence that I commented on, is a good
thing to do, I think.
