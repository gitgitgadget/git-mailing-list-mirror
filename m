Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20F5202F80
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973371; cv=none; b=YZPcwd/2EIrgb01Y6s1fg0ZnNGUUDpUFSINd5xC3dPhaTl/9h/br/fdfCFnTV3dn/FDSSvDrQ5lgvayRkBuu3L0i3BK5XU9woKke/Fd6ofuaah8HYRF90Mny6St5QIw9Q2n+80DsfnU8+NWUkCNcp/Bg0D/sRsi1ZfN+OwUjk80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973371; c=relaxed/simple;
	bh=T6skMCoBxKoBgdbFVNPM0S9y7110Hdpxt1Fp2TLMTiM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pauHJbF2u2DcZUdBpFujJzvH9hwLluI4MxOltRWAH+BJxV3f6OSi1PNGC1MKkIhaYUt3AkWgygtfOSwUYlxwOfH7kpTLWJaPzwKLXVnzR8DlThqcOsO+uZqMMa/KAjXqNqwVYJsbjaSXFWium0u2YbUSwq2DNF/+3+sua4YgPE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lMfYgXdx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k1MI9GD9; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lMfYgXdx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k1MI9GD9"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9E67011401DA;
	Fri, 14 Mar 2025 13:29:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 14 Mar 2025 13:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741973368; x=1742059768; bh=wsG8woXZCi
	d+qWb41PMAu4Orl7TCtPLhXuZj6c1Q880=; b=lMfYgXdxbeNZlgrr7hfFjSlEMz
	s/q+wUmc9wazesB1LJAkfm1SO3gmZ0fAhYCSj2/9qv/vuqM4KjdNe8KhEm/bd/zB
	F3HIhrYmWtPh/j322ykRDKNMVV0N61dUnPPm4VVnVOptuG7DceI0oqWJzlmuvHIM
	ImAEbXQsMbFCsC6cZ+Li8SAIt9PmTF14bWMS0oVt4anexzhhzb7BJvlQETf1pHzh
	pIE97RRsqMNIjCOqpYlykqZtgh1vYKvwTfqKHtBcp8e9d5XKJhmMj00GuygTOCQ/
	d50jFkwpPyIg6gN4NSS3z+fSrrz5eVQmc905KUMd27hzJ3gQ+oZeWXiHfPMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741973368; x=1742059768; bh=wsG8woXZCid+qWb41PMAu4Orl7TCtPLhXuZ
	j6c1Q880=; b=k1MI9GD9n+2QbmwdH6XXfdV70TpLKXAP3qcpuhqd13uBzgrReCC
	QCXQx6+7l1gKLMj10D3mJGkVz/bTE43kCUjzY1vRS5oy3ZOFPmu29NYv75n3frxL
	05kTcOCrbrA42RbXm8hg1qwJD1K2g0GTPQbHRcTbcfBseEY7mSewfML4niuTxZE5
	VYsZ9VD2qox4wo0Cbech+3E0e7n8fY9bBgYNl6aPJnF4G1fxTXtJY8+cdfpVvKrE
	UiMqkdrf/8mQuB+HJk86obEnCeAv+UdiQBAmDt8CcnxZ93JCyl5ZncEtZvJO6p1+
	4ERZUq//qYGovM8SFF8sMouIKmNsZR+rf8Q==
X-ME-Sender: <xms:eGfUZ-fKfjtW_azC4j0Kot1-8PN5oDM79RJdkJ0A_liReLDzCMSC2g>
    <xme:eGfUZ4MKMuZJrodkSWc1tKv4e3b_N3RW897-tUBdyh0hrIydiTctvZlD7v0XaBrdV
    YEgkMIOXflu4qUYrw>
X-ME-Received: <xmr:eGfUZ_iD5DrsbAnntqzLoDZ79VTHQDhO8p21DIM9gVoY2KqPEi2_Hth2dNWSVBFF-Y05HHqXfkWI3JXNgSe2rzywe_BGWC0FcrWPUKM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedugeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohht
    hhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:eGfUZ79sYF9kdBxbvPAm-0kUUiwub8Cc3VNvUP9Pvx3RnC4ioZI4jg>
    <xmx:eGfUZ6urGVw8mhats5fArA3E-pm3t2PIkK6rUBZVr9dANcSrgE2pow>
    <xmx:eGfUZyFWtFPREBAhavBoctWTRJcC4O0SvIo6kG0mtdSrYZHi42hQmw>
    <xmx:eGfUZ5PjMyB69F1978Ejm091iwMN_Wp_qXOGgIgQ-AIjsiM9Dmvw-A>
    <xmx:eGfUZ8VxLyXVSm0_NjgGYKbP9mi_Xv1oOVE9S2GhQoycnocbDw0Bi0z0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 13:29:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Elijah Newren via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/3] ci: add build checking for side-effects in assert()
 calls
In-Reply-To: <CABPp-BHRSnNE0zj9kRjrVm4-NXt33tYBT_iSgZU-5JU9Y2vp3w@mail.gmail.com>
	(Elijah Newren's message of "Thu, 13 Mar 2025 18:27:50 -0700")
References: <pull.1881.git.1741911652.gitgitgadget@gmail.com>
	<80dcc2ba3aa0ef72abe18f8525d571ea39ac6382.1741911652.git.gitgitgadget@gmail.com>
	<xmqqy0x8l8tu.fsf@gitster.g>
	<Z9OD8ihB-tiCdBmp@tapette.crustytoothpaste.net>
	<xmqqtt7wl85l.fsf@gitster.g>
	<CABPp-BHRSnNE0zj9kRjrVm4-NXt33tYBT_iSgZU-5JU9Y2vp3w@mail.gmail.com>
Date: Fri, 14 Mar 2025 10:29:27 -0700
Message-ID: <xmqqa59nh66g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

>> Licensing, mostly, as clever things we see are not necessarily home
>> grown.  I know the patch came with DCO sign-off, but it does not
>> hurt to double check.
>
> These two lines:
>
>> +extern int not_supposed_to_survive;
>> +#define assert(expr) ((void)(not_supposed_to_survive || (expr)))
>
> , which serve as the core trick, I had used elsewhere before.

It may be arguable that it is too small to be copyrightable and
there is no other way to express the idea behind that check, but
in any case ...

> Anyone got a clever alternative?

... as I cannot unsee your patch, I cannot be the one who comes up
with a clever alternative, if we are worried about licensing with
what you posted X-<.

