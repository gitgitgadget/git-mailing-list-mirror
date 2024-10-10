Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05471CB528
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 20:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728590615; cv=none; b=UbEtX/efdBXoExed31jpcdI5pgJLJawzGhMOFxUckIFd1XQzjvRevIzpXZp263EU4BG0xbNfRpcSDOz0WppBPTXqtUopAKS37FDOZPTy3x1WxR354D0WjrQgoquW2tyMk5J0NJC6/Y47/Xb15WjhWiQJgGGFOAcZfK5z3AxGEw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728590615; c=relaxed/simple;
	bh=QiaR3Vlwis1faFS2uxLaJafnS9hqxCPWNw9DwhB+dRg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cmukAQc/DadrVahE77b7LOv/j+h1k8xPDwZcKa3jmDXdYSlvSF8H7WVW5KHrvXQSLMVkeq3MYO4zPsG+6gHfCbUt9ZQVn6jhlsdJ7+opM1Kj3Xs6VV98ZgA+78cY3Kt5QkrsE5EdabUm98hxuYpk7bk5EU0sWjtgsYRugpCL8GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XrEzpMGr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZrBAvFAm; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XrEzpMGr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZrBAvFAm"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D61741380188;
	Thu, 10 Oct 2024 16:03:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 10 Oct 2024 16:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728590611; x=1728677011; bh=eOzstDetul
	8j1e1u/NmupyaIKCCgopOaLjnOXwQA3yo=; b=XrEzpMGr1MRArfkRB4dgYC5rI/
	4++BosXZjGYBBs/wumhjxBQ7tL0KsPAEKVFZN3q+RZENILEdOQtM32DUXU7HGBra
	EKDLfZpb/XgnWNOyTpvd8vOI1Xvr/KTTPKAW+3byBRJXS4ybXiHtrf7sxHH1u65e
	Qg2b3Lds/xgcfXVS9MepjIj52oTbLed/2c+9gPr5Y3A39vbWUb9OHlAbMlfA890y
	xHuDUKkcoW2CAflzvtm6T1B6cj/F2+468aIi1ZQOSJ/kvoRyO4ejyUqjL53cLqI0
	65XDGBqHvRVl0UiQHti1glS1+29D3W83gbIhtcAv4er/qkztCL/yNKoHOMdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728590611; x=1728677011; bh=eOzstDetul8j1e1u/NmupyaIKCCg
	opOaLjnOXwQA3yo=; b=ZrBAvFAmFgNXnvtGHnrdaZogEQic8tZdFLUHG6f6kIzM
	RoHqAyfD9DJQo0acYbW+L+HmSIHxlqkyBXmVxgRhQ1lh5dGmkqCLoDHF4b2Pgsql
	VmHPk2WHj6QL+9pL4/Md64GK6bU+3FSFzLbPnin485GgfWLM0PmEa9KV35l24L7q
	OwP3a4GBhZIT5mW97ae6kCZ1Ggy1FdSPU/uZ1Ez4DzlymwRf7V1GqvF0zTU2/gOz
	L/+r4+M8pGZagmC2dxZHm2lIV12+se919lGI0otIMZtX2/6/mg+mxIV4P1DxfTeO
	b+ECVgZATD7O+KILJ40IAljy5A62XqGrxxo6ryttUA==
X-ME-Sender: <xms:EzMIZ63bHMVWHyGIS7sxwwf-4i05dQnHmPfQUk79D6AQe-eDxVyEhw>
    <xme:EzMIZ9ESGaztruAMtNM_67nQZ8PuE8qhqSxj5fPOyYZ2RqB16gNruQMDhwN-risGq
    FQ4-WCuvin-Z3N54w>
X-ME-Received: <xmr:EzMIZy4hoVvYVQ10LOLIlAF1ciCDF8UaotDbdEGuv5Imfw_NWYcjiN_VWRiVA70I6wrdVqgoewDaJcgaxOUzfpjp8mzSjtkOQ5_epxc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefiedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptggufihhihhtvgefse
    hpmhdrmhgvpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:EzMIZ73gtYYbd4GW4LrES7OpMrGppyUCMvWSYklsD0NeFCBtd32Ulg>
    <xmx:EzMIZ9FC2hMJVkdh6uljhSy-tLqR-QXISdwhuAhOovLKSPiHGfDy-w>
    <xmx:EzMIZ0_ViOM7rJbbYxSFSkYPpiFaGqgIWgiJE7ERtBL5ZYCjjC_BuA>
    <xmx:EzMIZyleWWpNQ100HPqrbL7M6kJRpqdDcL4nJ7juhvEbVZR2oTIfDw>
    <xmx:EzMIZxgp354BPkk9Po_GQF7kntFwxWQunoaY5iVu-EwiDp8t36954WY7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 16:03:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Caleb White <cdwhite3@pm.me>
Cc: shejialuo <shejialuo@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] worktree: refactor infer_backlink() to use *strbuf
In-Reply-To: <J1frhnJqftB1IUvIGDnJiz6uYTDNl_Bc92NLj1gXJtgRxapI3Uy-fyFHYtv5_p8e7yzF0pegawV6NlHQTn0GHcXP8MZ_1X8CNkIvO3_MP9c=@pm.me>
	(Caleb White's message of "Thu, 10 Oct 2024 17:52:49 +0000")
References: <20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me>
	<20241007-wt_relative_paths-v3-1-622cf18c45eb@pm.me>
	<Zwf4PT-vaLX35ELL@ArchLinux>
	<e1RptKNShhPZHXDhBkQBaCNCmKBKik4nQzRShqtgVfjcH7vBWpuLYV60PSHaJ0diX-oG3XiKHc7IebhIZM4eSkeYdQQZ_QYK2ixxsK-XwrE=@pm.me>
	<ZwgOURNkNhg8BsaU@ArchLinux>
	<J1frhnJqftB1IUvIGDnJiz6uYTDNl_Bc92NLj1gXJtgRxapI3Uy-fyFHYtv5_p8e7yzF0pegawV6NlHQTn0GHcXP8MZ_1X8CNkIvO3_MP9c=@pm.me>
Date: Thu, 10 Oct 2024 13:03:30 -0700
Message-ID: <xmqqcyk7k9nx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Caleb White <cdwhite3@pm.me> writes:

>> If so, why not just return "infer_backlink.len"?
>
> I would say because the purpose of the return is a boolean,
> either the call was successful or it wasn't. The developer
> knowledge that you speak of should be a given---if the
> function returned true then there's obviously a path
> in the strbuf.

That does not say what should be left in the strbuf when the request
failed.  If it is undefined, then using its .len (or .buf) is not
quite right, without relying on too much implementation details of
the called function.

Usually, this project uses 0 to signal a success, while errors are
signalled by returning a negative value (and if there can be
multiple ways to fail, such a design leaves different negative
values as a possibility).

If the result the caller finds useful is always positive value (or
non-negative value), however, it is perfectly fine and often more
convenient if you used the "positive (or non-negative) value gives
the intended result and signals a success, negative (or
non-positive) value signals an error" convention.  The caller can

    if (0 < do_the_thing())
	; /* success */

just fine, instead of the boolean "0 is success, negative values are
various errors",

    if (!do_the_thing())
	; /* success */

when it does not care how/why the thing failed.

