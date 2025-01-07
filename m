Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A6811CAF
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736270516; cv=none; b=KRjOXHexwEvq9jb3tIO9/Q8uL6DPTJaceJI1E3R5KqJLq1/QpFKLK+jwjj2oTLB73ZBGmtPyBODqYTsODLSDBmOjXa6VVD/UEFqZRlDN/QrwNEWOpoGURmk6nzE1ZZzr48fRmujFURCuhrKooafRDox2bm/AQXcdJyLCL5eIEBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736270516; c=relaxed/simple;
	bh=7cL/aIUVEdJY5utT+bjZt3cT2qvJ1WzjR5huWk27fNM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tRgC8eUojASMeXUufxIFq0Vx5wuiuvPKNWhM93rMzc8yReY1vjyQAGWp1U3J1J9H/MhUAmFd7ffUw/V6BAQML4CW5Twz1Fijr6XgfDmEDqtiNLB+Odr0E9quVC45kS43Q65SmarjxdefSYe2PXV/jIRKPrcjQJYzvNvjKVeoxmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=asWWmn0K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KSaE9eQA; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="asWWmn0K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KSaE9eQA"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0B64C2540143;
	Tue,  7 Jan 2025 12:21:53 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 07 Jan 2025 12:21:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736270512; x=1736356912; bh=rnET2h/y4A
	pAWSjwrmfwq508d6Stt8N2GNTZDjkljIU=; b=asWWmn0K7K7IiITTKqiL72W4p9
	65OMC+ZUg7JyVARYwyy2QPofHi1iqzeHvEw1OBqbvB1r2JYUFAxOjpqkzhtCRWtH
	w67pFmtii4HFjHPHWFO+8yrSh1MLmd+gLgyWWLxndrRRp00QXwsPbjoF0RPMfZ3P
	sKVIbCBEavX3jFO+h60X446wYG5yQE7jwOAtGtYWzI3rh5UR/Yd0FF7okZO9kc35
	KGrObu5H66yQWmvs5S/rMtISFvEty/E4SLCTsk5SLzdj4LhobycJPADRaQrMQMVQ
	Y+fOlin5/IR90oaNc44iswjsxTxaET9ELqVwCeMpnY746lwzGZeexJ/n7ZCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736270512; x=1736356912; bh=rnET2h/y4ApAWSjwrmfwq508d6Stt8N2GNT
	ZDjkljIU=; b=KSaE9eQA2+fkJGW67WcrPMSLAWdrJhVBAM8tvKqD+e3F4FlkEoq
	3uT/yS2PbCJnRQbCM1MU6VcUyg0VbZQQuLkad3QOsBJFA8H5lXBSM8Wm5WsnBrAj
	jnK/+Pc4QRv6e0C2Z3sfGnoZBvBYyLyrlaQmx8EbDv4zBV/4x/X0FYku33TdVVkU
	JX3czS2UVgL91n0f5rNLS4Xyy7OenA152m4mkA+OPKvQF4kFK0+dKSOqyxMMCWIx
	vqKhgZhGP1TwdN46dp/p8FsdM/8cMzxAC5aGuG1ipQMUE1RTD48cEiQlRmtiGIpi
	Fv9pyS8AlRqL74Juh/jyAOF3kfkg+EHpSyQ==
X-ME-Sender: <xms:sGJ9ZwztPDxsdJaD8K0oK9_qY0VXNqWOKsEhllp3GhOMD_Kup1o51A>
    <xme:sGJ9Z0TS75lvyxZIGzuYqW7K8KRnzqnmiX3K7A0Tw-vm0-QLe8LfRBcyw_9StXJBm
    IICse3yT6EBJfemZA>
X-ME-Received: <xmr:sGJ9ZyX3Fcj5tm0HZ3-tISLK13LJ5EDc-lsCUj6mn9rAc4TlgOptT1I9wgkZ94XBpmD9Tx4NPinIm4ABuvwS6EFXusE8wYQSiUbM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:sGJ9Z-jkZB5lMOx8uQQpfYayZgPHx9hGUnbuTErWS69cfd5mL-HKbw>
    <xmx:sGJ9ZyCrwQjWW6mV_Ok7VI_1sxado6l4mCBeYCuWvHZPVHFqwON4gQ>
    <xmx:sGJ9Z_I4m7w0KRM3vndH_fadpqoo9222FqoF65AxPA84EHWIfTwDLw>
    <xmx:sGJ9Z5A89pATodbnsBtnzj1U9rPGINBLClq45kqpqFyZevefSC74BA>
    <xmx:sGJ9Z9MKAyevuKaeHmcV0LRBZ1b5WO9aWOKj1bTvwEkv8fpOlpKMoF1H>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 12:21:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] fsck: reject misconfigured fsck.skipList
In-Reply-To: <20250107162914.3756968-2-jltobler@gmail.com> (Justin Tobler's
	message of "Tue, 7 Jan 2025 10:29:15 -0600")
References: <20250107162914.3756968-2-jltobler@gmail.com>
Date: Tue, 07 Jan 2025 09:21:50 -0800
Message-ID: <xmqqttaatu8h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> In Git, fsck operations can ignore known broken objects via the
> `fsck.skipList` configuration. This option expects a path to a file with
> the list of object names. When the configuration is specified without a
> path, an error message is printed, but the command continues as if the
> configuration was not set. Configuring `fsck.skipList` without a value
> is a misconfiguration so config parsing should be more strict and reject
> it.
>
> Update `git_fsck_config()` to no longer ignore misconfiguration of
> `fsck.skipList`. The same behavior is also present for
> `fetch.fsck.skipList` and `receive.fsck.skipList` so the configuration
> parsers for these are updated to ensure the related operations remain
> consistent.

If the value is missing, i.e.,

	[fsck]
		skipList

it is a very clear misconfiguration.  "We expect a path, but you
gave me a valueless true".  Once a specified value gets to
oidset_parse_file(), we would die when a specified path cannot be
opened, so it is not like we want to deliberately tolerate
misconfiguration (we also die if the value is given as "~t/sl" and
user "t" does not exist on the system).

Makes sense.
