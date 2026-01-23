Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B58242048
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769189475; cv=none; b=ZrEqFhmAiBhqW4G47CuQBKKdDgjHMFOzKdYfgMDSotVVzzvlGozXa0DjTA1RR3bPVTVLyzSJ6/n4kBRvbOrsq+1UqdSMBJaqE2GyDgdXW3vWtUgc5jtRW7ITY/d0zrcWdTT7+LbHF0J2hyP3nQXEhfTeUaxP45IaCzit9thWtY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769189475; c=relaxed/simple;
	bh=+y0PYQ51Yu4KT0ob8lj3gs0cjaiYwf4hYUIBTsKptDM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tH0xr7LYAIL1kmzVjV4nT30AQSyHAQWXN1232ZOn1CzF6J07WyIeLCy4kNeIbOS8QtaxaX8dVw7Js4g6Amfitq0kC5ZhwY3ieWX0rtNUiwpFrDXcRNwpkizFL1ZZK3qnM+9/qxXlpCw6QWcPQJLMf4XCA+ewUQXllNmdevIJaXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dq0QVw4N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LDl4SVaX; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dq0QVw4N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LDl4SVaX"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 12D657A0016;
	Fri, 23 Jan 2026 12:31:13 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 23 Jan 2026 12:31:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769189472; x=1769275872; bh=DCkS2Ovvf6
	XSDoHiGWH97tuSZOqpjYjV/JspK8TjRRc=; b=dq0QVw4NkzBrGUyniW9iSo0gvI
	1IehQ9mR8sbdSEiq6mprGSH/YMfur8HeKtWVBQiReWxkPC7MTYdLUNeLqai50/mG
	zN4WnqOLJmkSAR824Ld6OBZal9reheMF9OETymBzd8DeMD21SJppu3UjcJNO1sEi
	00k9BxzrVcB0+uJZAdzXJSlg15rm5QZdiFvw/6mYHLt66GJqxT1sVdFB+JsrDjzd
	lR07LS/jfvQ1z+AzsE0l5lOPbXqb9Zoc3jeFDyRQNBIbuwVdoClPbct4NrL+eCWj
	Npk0AfqVlDmHjjG3hXzSJhjS2DMwKsMRAfbrFwdCdbZ3l1BLC97v6ngMRhag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769189472; x=1769275872; bh=DCkS2Ovvf6XSDoHiGWH97tuSZOqpjYjV/Js
	pK8TjRRc=; b=LDl4SVaXY6Y9cuqw+AN4gIAULF5iG13Z3KVEOk/wgoewZYXncHa
	s3lXSj9mXgPFsQrKJYdxwhMOOlN5kw66H1TXxQSm2EsioltQRxjKxRPmZpH206sp
	4XDgey7Y5JgrQUeOdd7Z4et46JGkFr1/Vf3negg9M60f1aKQHPAJEaGUi2T0osJS
	IzWtGnWXti310IDiNOuUMS+gb802FyONenppTIDQ0h8KrUb//8krazLQbCXijG2S
	7ZSkBubHbFum5r2fXM7sFAC2z0LfefdzT8W/A1RDdFxUSVirY2t16TYH9uNXVAnX
	7UsjetU59EGIs36ep+89lkYB3qttjMonYRQ==
X-ME-Sender: <xms:YLBzaShPlANq3Mjfo2xQPEUgzNS6PvAe9QvZIGiSLUFIx0MH9cD0HA>
    <xme:YLBzaWvllGUXMPxXqIANDHKLJFqq8fO131XGdVWpsIKsHejhFM1Iojo0SNOyuYwzI
    tuKtvBu3n5llxMtGby8KIdUrCar5zQOn6sgtsteC8kep3sUc4QPEg>
X-ME-Received: <xmr:YLBzaT4r65dHGPevOmKGipp-nYXLiu3KIZ7LnXV1a2eC8AY2S2c5p7ell2H74SUUvawjpfMR1Kmd2Xh0MgvjC0o-EZhwhGfgu9S1lDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeelieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmpdhrtghpthhtohepghhushhtvggusegtohguvggsvghrghdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:YLBzaSONEH3sjgJ60h71VEpgJfzjRgurvD5lqC-KIPeWTsxeZ_VgaQ>
    <xmx:YLBzaRtZk_tgMhIHT9XzLoFxXMpOpAUwriYlPlyT4xyO3wEnMLlp_w>
    <xmx:YLBzaVZR351XfifTb4SZe8isXVwY1ipjMMNN_bHMhAOVpxhbLgEjag>
    <xmx:YLBzaTxceXida9u5g8L7kDhfIpO0R9aLOlcKfJDEsjxdc46ItsGzcw>
    <xmx:YLBzaVcztw0xp6lNzS0HzPSELCJRV17UVbcN0PatmQTE4pW3BXZ2lblJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jan 2026 12:31:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Gusted
 <gusted@codeberg.org>
Subject: Re: [PATCH v4 4/4] last-modified: verify revision argument is a
 commit-ish
In-Reply-To: <20260123-toon-last-modified-tree-v4-4-86bf97bad4e2@iotcl.com>
	(Toon Claes's message of "Fri, 23 Jan 2026 15:33:04 +0100")
References: <20260123-toon-last-modified-tree-v4-0-86bf97bad4e2@iotcl.com>
	<20260123-toon-last-modified-tree-v4-4-86bf97bad4e2@iotcl.com>
Date: Fri, 23 Jan 2026 09:31:11 -0800
Message-ID: <xmqq4ioci6cg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> +		if (!repo_peel_to_type(lm->rev.repo, obj->path, 0, obj->item, OBJ_COMMIT)) {
> +			ret = error(_("revision argument '%s' is a %s, not a commit-ish"), obj->name, type_name(obj->item->type));
> +			goto out;
> +		}
> +

I do not use l10n version, but I am not sure how localization should
work with this message.

    _("revision argument '%s' is a %s, not a commit-ish")

There is no way type_name(obj->item->type) would be localized in
this code (after all, it is used in format_object_header() that is
the helper function to prepare the contents of the loose object
file).  Yet, it is tempting to translate "commit-ish" for those
preparing the .po files, which would lead to mixture of C-locale
'tree' and end-user-locale _("commit-ish").

I am wondering if we want to avoid this mixture by forcing the
C-locale for both, i.e.,

    error(_("revision argument '%s' is a %s, not a %s"),
	  obj->name, type_name(obj->item->type), 'commit-ish')

We can leave it as-is and polish the error messages later, of
course, but I am curious what the best practice is.

Thanks.
