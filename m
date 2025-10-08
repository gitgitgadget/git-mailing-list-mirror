Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0141E7C12
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759957170; cv=none; b=jb5c7ucG6yfZRLGzHL3s0QX3I8TFXMTB6hlAPCiKdJ8uNju5nYgOAw84kjCy2mthW3yibHuFTJ4Du96FHgqHZQDxgeq8KajHUAVhWXmGDp3YSaWZsw09hbPKBNJgoJDMN2FIoT/T92vz3mo+1dobUxOFqf65xKjSwA72txljrUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759957170; c=relaxed/simple;
	bh=czKky36sFIYcwgTrn3SDUdlH0hfhQ+9MYzY82fz3BIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hcZgWQfpai3bH57+3C4aYHCOHYkr+vyhtkV12bwpx5g7x6aqv5TLMcVWxUfW/MOH31GRHhCWktgSR6/vkuFmUKMdScSEPPYmisfe9kd7xX8foiT0lUWq006zskkjesHAqxI7le/QHTZ9ONsVHtOlArOQz/2IlRFzBk8LNdzKej4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gPnexJde; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pfv2xzDG; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gPnexJde";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pfv2xzDG"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 3C30B1D003F8;
	Wed,  8 Oct 2025 16:59:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 08 Oct 2025 16:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759957167; x=1760043567; bh=9oUVWfEEEh
	6VnNXPvHRGmH1D7uK8S4ji+XgXvfxdIbA=; b=gPnexJdew9U+P36VEd1nKZQA3y
	Inn4bO96TZYxs3neWv/ZlVC8vE66B7tVzp5nnGMAhN8sozh7fggQHAfiKNgc7+OS
	Qc9tRgKzO0Uf0FbLkd5J5fZRkz+nTthNg3MHwHYSd2VpOCbbKEtkkJCzHMMZnQaY
	Bl05bXCqOzQkNc2w4Hgs8f0HZobpBoWRwproCyu7tqxXati6u1IylG3wkkNKtzBT
	d87F5moyYlsUvAKE7EdjWTtt/jE8O1dcAxLvPuGFhhwnvjKNnebDts7wMgtyQ5zY
	Dd0dv2KKLcIwSxM7/Gaj0qoOEs+GB5OzgL8l+7tsBCqLKD2UthPtvnZWudAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759957167; x=1760043567; bh=9oUVWfEEEh6VnNXPvHRGmH1D7uK8S4ji+Xg
	XvfxdIbA=; b=Pfv2xzDGX+cGZ+Ebm9Qa6+h+uAc7Uw4z9f6U6KDZHET1URp1pVb
	HNyX6EK+YePOgboeZOUOTP2xZSMTCUKpWYS2Hrpt/iRJC1NYc+aW+8NWr/XaOABz
	++XD4imAy5OGlqitrOTyB/wLESAhL22zAI5wVUIvP6i0LbLBOceyk1HTay40571g
	cOGdMKocpvK/xv5tHpdIdWMXDK8cxrlsXNN3zLZm+K9Xibkx/H9f5yBH+XPaDiez
	g/BXDe796UWgRJhjubYoigPVJv1fyTudjjmS9lcREt5Lzzs7Cvo/L4Jmtgv24lAO
	/nf+zqgzDBvZtyi9VXkvBHrfRz4De52q9NQ==
X-ME-Sender: <xms:rtDmaFZ4kBXqXxxL2xGTCO3FFHyWZFKNRy4ZCEW5dZT1JV1X9ncd1A>
    <xme:rtDmaCz_UtA2jzDKirJFxvNIwdMHzjduAjd-XvZo-7DHaZhiaU38orTt_U-KbcRjV
    LlSwqa0Sevxfd9EMfV2ktchN-JsZKPR9Nuy9bE08ZzfCLXoAsMRLg>
X-ME-Received: <xmr:rtDmaENPGCZKVQhWhqJ2tcRdZNPCan-UWsx-mdfVixlOlZ_-G6VgGDzCX1hmiSRrVveH0E0qaUeMTlZqmuInb9so5gT4eypOVOGH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdegfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgefudesgh
    hmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrh
    hishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprh
    gtphhtthhopehrhigsrghkrdgrrdhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgr
    rhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:rtDmaBeRwaBfIYS5YECtzTielYHH0zPlmL_JAV7As-QEtaO_XAdetQ>
    <xmx:rtDmaJR746Zzhm-qpCMwLVujaOrlBSxmEhnwe58e6JwmENSqJN6Mzw>
    <xmx:rtDmaPfh_METypihh6SNmurMwZofTA-Y4kRZjU_PDPTmfLPf5345Qw>
    <xmx:rtDmaCsDUsdieT34p4fu3C4rHEy6ngwCBhASi3Em-gLVtAjUq5WS-A>
    <xmx:r9DmaCVq9W43iM5f59UoV54tprLa_lW81S_s9HzDd_wYQh3uXsqPa0jY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 16:59:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: Elijah Newren <newren@gmail.com>,  git@vger.kernel.org,
  christian.couder@gmail.com,  ps@pks.im,  code@khaugsbakk.name,
  rybak.a.v@gmail.com,  karthik.188@gmail.com,  jltobler@gmail.com,
  toon@iotcl.com,  johncai86@gmail.com,  johannes.schindelin@gmx.de
Subject: Re: [PATCH v2 1/1] replay: make atomic ref updates the default
 behavior
In-Reply-To: <ea7aa170-400c-47fa-b3f0-2623fcbfcaea@gmail.com> (Siddharth
	Asthana's message of "Thu, 9 Oct 2025 01:36:40 +0530")
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
	<20250926230838.35870-1-siddharthasthana31@gmail.com>
	<20250926230838.35870-2-siddharthasthana31@gmail.com>
	<CABPp-BEh7VEM6UQjkK3CxJcv54vEmueTmh9+-SyTKUxgy7Mkcg@mail.gmail.com>
	<0fba2f5e-03cd-439b-90bd-f613fcc4ae23@gmail.com>
	<CABPp-BE9TV58duojhF_+R6bKDF6-L0md6j+1VeRFd8CJWF++LQ@mail.gmail.com>
	<xmqqh5wfu3o6.fsf@gitster.g>
	<ea7aa170-400c-47fa-b3f0-2623fcbfcaea@gmail.com>
Date: Wed, 08 Oct 2025 13:59:24 -0700
Message-ID: <xmqq4is9f6tv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> On 04/10/25 02:02, Junio C Hamano wrote:
>> Elijah Newren <newren@gmail.com> writes:
>>
>>>> For naming, I am thinking either:
>>>>     - replay.updateRefs (boolean: true = update, false = output-commands)
>>>>     - replay.defaultOutput (string: "update" | "commands")
>>>>
>>>> The boolean feels simpler, but the string might be more extensible if we
>>>> add other output modes later. Which pattern feels more consistent with
>>>> existing Git config conventions? Looking at rebase.* they're mostly
>>>> boolean toggles, but am I missing a better example to follow?
>>> replay.updateRefs sounds better to me.  defaultOutput with "update"
>>> doesn't make sense to me.
>> Yup.  Or "replay.defaultAction = (update-ref | show-comamnds)" if we
>> anticipate that we might have a third option someday.  That would of
>> course affect the choice of the command line option.
>
>
> That's interesting. Between:
> - replay.updateRefs (boolean)
> - replay.defaultAction (enum string)
>
> The enum is more extensible, but do we actually anticipate other modes?
> Elijah's --format idea from Kristoffer might be a third mode eventually,
> but that seems far off.

What do you exactly mean "far off"?  If it won't happen in 2 weeks,
but it is likely to come in 2 years, then making sure we have smooth
upgrade paths is still valuable.  Once you start with "do we update
refs?" boolean, how would you later accomodate the third option?

No matter what you do then, the end result would be an awkward "if
you want the command to update the refs, set this Boolean to true,
if you want the command to show what would happen in the output,
set this _OTHER_ configuration option to this string, or you can set
this yet another variable to cause this different action to happen."
