Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF13730BF6C
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 17:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770659120; cv=none; b=ucsI+8QhycAP0twsj1/Wbdb4Gury/IyzJrSHpYAam3eStRhOiNCGTGl3mpRogzmVmZPrQpMjgPbtHsrNEplgmMX5WHnVfPatetAwqGG1sizLM2/tJkti3ZLkHQVWzW6RvoPRINexFtiCOZ9RmdRef57shYW2PuN23g2Sgxxwi+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770659120; c=relaxed/simple;
	bh=elJ2GorxcO3HF8Q2++JEU72OUpXPcWxXjJDTHgm1uxY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D+OGZXRviJI+6mT3Vzs3G9aevxUNCA0C+aQzbqGiFByp4hMAtaPdVG5pdHCjbSPS46yWszNTLlrWHDpeeo4BMYcrgiaUrUJqsVK6twGLOOtttHjETXjnFXvQ/vIio5Goi8CywnbYyMoki2hHWB1vKKHZfQzbaef4EKLBM2guvao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YhGS/nD/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pogkWSdm; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YhGS/nD/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pogkWSdm"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 28FC67A00D5;
	Mon,  9 Feb 2026 12:45:20 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 09 Feb 2026 12:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770659120;
	 x=1770745520; bh=vKDoPEb8ZsYoFe5eaPeG69LOYEcdJ3nfiBfnMthvxGo=; b=
	YhGS/nD/EFfLRwAZ6UuVcc5rna60wdI/NLZrJa+4QhF7CQDPp1jXwl6pyhiu5DUU
	OxmLr6JIlfeeYw6rUzxLgW49ZKTHSSHPPsQCliB8DSq0r+3uY95SRmluZl0W6Tak
	/++vf7HoYQ37yTw1ZkaTlnInsrHPfXcHUKAPeHhFHeg5MZPQ+Dd7konO9zg+RZKh
	6hsyJyJc67MU9WwiB2ZYHaQBL7mVKCsSUw+0NKhy+1RF6evasz0bnJ8RmSCf9mK/
	6BcX84kZkWB4KtgulvXaNFKStx+XPZ1IwvG/Ws856c16aPFuIYYUfLGS32qnXxD/
	CGC4Ka097pRdBCT3nuxWtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770659120; x=
	1770745520; bh=vKDoPEb8ZsYoFe5eaPeG69LOYEcdJ3nfiBfnMthvxGo=; b=p
	ogkWSdmGziwKC1VSeRczmVDFYkFqj3FR+0APXYyAEQBl7Lnqh/GXirTCweQzsfw2
	2KlyPeTQvC9xfVx8XNRS6/lppQCyMGI5DM5ySyGWFMfeGw/bz9Facrm4zzIstQxc
	qnJUmzsd2pjNP0RCIHIMX+bm5QLmK88EaAzGHWDaS+uqLxxDJbgaMH5QjOwZk6RP
	fVH6Bgi+KA1dA+3EgYcW2i5xb36kiCvrkw/vsEgWPEzppNLOZKOCEoiJiid9C0a7
	tBTyIHAk5lz4A8onbwd2OYbP9BbLRgw5Guf/PXb3f/t2GQwHTx1hxaWYEH8FOGSH
	OPjFcPRoc0QKsywTlsshQ==
X-ME-Sender: <xms:Lx2KaVPrDJ8V3Ct60aQ8qkhkhSnW3AcMuAVVPNjxjGsc1si_zGkUUA>
    <xme:Lx2Kafa7QvD5_3DdQrLvZT3u632ZxydqNLLZ7OaAjUaBMeBHrbjg0gCSGt1ZIVXhI
    kubRatlYz_IefDyBFGckyYJL0gGCDmpAFCPealhZzv-I3PVqAYmkQ>
X-ME-Received: <xmr:Lx2KaRoUjxC_uFG5K7ULB5nUrG7jJiIf30ZI7HQo90bCkqWMQKSAKpnNSiaFe14RaWcHBylF7DRHYaA4O73i-CYO3ZNCpwAFtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhdrshdr
    rhesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Lx2KabZuvZW0czmV7dY_UsRuVR6GjDzq9QOgLJK5L7nHnxabY726Ug>
    <xmx:Lx2KaRQjSUF5hP2b_ZU8kt0FB_q2LgYjXAD0muhNo6CTIHruYsYOMA>
    <xmx:Lx2Kaa5oqTqr01J71VbF0QBh4Tnro0xgvGfl8TK6w8xI1e3YfJKpew>
    <xmx:Lx2KaezvaAA1dfHy4S66m2LxDXKN2_T2L9vq9bg-pO111o_Uv58OcA>
    <xmx:MB2KafACsP6OVw0bVtpKtIKCkj9gPrM3LwtWZ0ogee0tJFM3xZT7BWzJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 12:45:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] xdiff-interface: stop using the_repository
In-Reply-To: <b05f81aa-6e8a-4e90-ac9e-85fb72784afb@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Mon, 9 Feb 2026 16:21:36 +0100")
References: <f58fa33d-b015-4339-819a-9d91be60cd0c@web.de>
	<xmqqms1i6uc8.fsf@gitster.g>
	<b05f81aa-6e8a-4e90-ac9e-85fb72784afb@web.de>
Date: Mon, 09 Feb 2026 09:45:18 -0800
Message-ID: <xmqqbjhx6cb5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

>>> -	ptr->ptr = odb_read_object(the_repository->objects, oid, &type, &size);
>>> +	ptr->ptr = odb_read_object(odb, oid, &type, &size);
>>>  	if (!ptr->ptr || type != OBJ_BLOB)
>>>  		die("unable to read blob object %s", oid_to_hex(oid));
>>>  	ptr->size = size;
>
> My initial version did that.  Then I realized that read_mmblob() is just
> a thin odb_read_object() wrapper that converts null_oid to
> empty_blob_oid and dies on non-blobs, though, so requiring a full repo
> pointer seemed excessive.  And all callers also use other odb_*
> functions already.

Absolutely.  Passing the narrowest thing the callee needs is the
right approach and that is what is done in the version posted.

Thanks.  I presume that a small and final reroll is expected, if
only to remove the now unnecessary #include, if not splitting it
into three parts?

