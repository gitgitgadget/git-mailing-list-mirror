Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E271E2D5C76
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014429; cv=none; b=KQB5/g/+C6ANIBInThQvox/CIN/8jPFNS9asPTcilNsZV2C9EZjPE+Xcick0pB5SLmtc6JoFm/EH+s7T6KioCvZM/9uaLsRz6eZQfw4KNvh6Vk9HDBYhIFvMsvQCeyhkxHzWLcC4i97Fw+AgpM4sFwEzroyYz1MWsmhlfWEUcOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014429; c=relaxed/simple;
	bh=YMIK7QXZ8iLFnDEJ96H6QDlY+2cHhHBuBFYyWVTWNOE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h0wn0hu+TMr2Ir+wqcOdkLQnnANkmO/pFjQlRMZcqfrHiD8e7IuzWqMoRwoSZwNt8uTPb6Su9BicDnlm/cnJgJQ1wu2fjgPXFajobYBrKYaDuLPhpVkiNXuxAGhY4XNiRDhjFWYyH69GRM7gfGgJ7pTyYbFep8wziEbsNQXWigo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hFbd8/V/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=biC8irOl; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hFbd8/V/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="biC8irOl"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1227614000F0;
	Tue, 12 Aug 2025 12:00:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 12 Aug 2025 12:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755014427; x=1755100827; bh=6yjRZeZWwa
	Qcf3CP48zK/LZ5PDnMHtYN1eUpBuH7HBY=; b=hFbd8/V/F7w4/mxsDfCwltVRGI
	jgT9v82ZtNUogEVVte8uaVKmmvTcHNv23sOSRndyUueSieRZzFfS84jHM7GVeG/W
	JStUEXXieERxmGiAf3IVCUiD4Ny7fzROJ8PuIfPYxQQj5X6vFVfd12tIQdtAoPtT
	rs535HUUjd0HgS3jdP1VObREQdjp9OY8fD5eG+f7WmPpgGnLKZAEAPEo5poxrzBq
	1OQ5E48sNobNJ6p6UOKNI3DUq0EURg+bEoAKxNmarFbo1XqTkccoeszKH2rrIsre
	pUc+qWhvNxaXmMt69I1Da4IrFTbtGO0TZdnj+1v9l2KsZ/Gau5P9+gnQHQAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755014427; x=1755100827; bh=6yjRZeZWwaQcf3CP48zK/LZ5PDnMHtYN1eU
	pBuH7HBY=; b=biC8irOllNEDwI1MIfCzs57U+nvY8L+Pl9cW/0GNYjIUwg86Fie
	kINHihvSxKA1GjjZdiVjLjpV5tGIzSsCTSnoR2qbkfeQezIYTj5IVCVHJLIOPCmJ
	As0g7hA0R+Nfl8g/qr+POQcOvXbm0EfVo8+TzdXXcTqietbUd+hANSkZ92yCblfk
	1RgU2UuIv9886+RcYG2f2oaM2CqwSDb4HmIwYJuWcXyIiPqYKU0irmdazb8+Z2qn
	X12KuIk9Pl+Jqm9+WRpa+VZlBLDFQjRstJxsH167zzZfcRNZpMWskNBDmN/T/vgq
	KVXG7vX58aLAedrxNjP+0g+tfCBXZ99SNQQ==
X-ME-Sender: <xms:GmWbaB6VTdPX58et1wWta7oVVSmwuFJCWIOUElEc2Ps64jfnseCiLQ>
    <xme:GmWbaMdN7RKYsNfkiHEY54i5iScbpky2ShvgoMVRK4Na9ORsPAqImxfCaxrpqDM6D
    dr9qPDBgt33BvOLBw>
X-ME-Received: <xmr:GmWbaO5VDhehWGQupm43Hf7-1mn4Lp8l2KtvwrMzI6Y_tTOS-atM0CmM3vYanHjb-3GkGU27t5dNYpXRZPfIpnknRPvU_EmRvtvykwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeehjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguihhthigrtdeksehlihhvvgdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlh
    hssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:GmWbaLs-a5WT2cPGfAAkkspz4hfjOyID55n7p1HwajyL1Bc0Vt97eQ>
    <xmx:GmWbaGgXt0lV3TNU4pNxDJ2kUiVwkVvVogntDO8xkLY_6jrU5QS4cw>
    <xmx:GmWbaOrCthmBibB6v24r1bdPhVh1xf3oflfEbQ_VQ3OsAPQvsplXOA>
    <xmx:GmWbaLs0EFCLnIXRIFfMzDaKElGbremEBCXACoJtb83tbSDvu932nQ>
    <xmx:G2WbaL-ien4nN1J088ZzZtK-3i4W5V_Kkrp6sfh-Xw_oj1OxQ774L2yB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 12:00:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Ben Knoble
 <ben.knoble@gmail.com>,  "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v5 0/2] send-email: integrate with git imap-send
In-Reply-To: <PN3PR01MB9597E8E33868386C997D2563B82BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Tue, 12 Aug 2025 06:44:34 +0000")
References: <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com>
	<PN3PR01MB9597E8E33868386C997D2563B82BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 12 Aug 2025 09:00:25 -0700
Message-ID: <xmqqikisv8bq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

>       ## Commit message ##
>     -    send-email: enable copying emails to IMAP folder without actually sending them
>     +    send-email: add ability to send a copy of sent emails to an IMAP folder
>      

Thanks.
