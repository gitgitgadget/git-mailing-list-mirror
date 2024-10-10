Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8384E1E3DFC
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728586082; cv=none; b=cAtnOH/cK5vsP64m5Jsx33MvLSkBovi5YekGCH8kQo6khAOk7XOegEjZkk03eNnaSys5ZtmzV10g2/KUTEQxIM/MSYF3LAHfA4rHgZf6eOZehK9cl00N7vAe6uaHTYr3EFg1gz6noDL1lOrX7DE3DggiWIPo7tYiKJVG101+Dfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728586082; c=relaxed/simple;
	bh=bKOSffuGf1oDh9KV9twmSk6UV2oav8Ju1dFtc+yqouE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qFpadUoRzkPGaTWVx/NFRYb9SEVRaXlAJF4EpgwIgEouDiwLLiY37Ebh7pnhfIC+9r9aVA5AUd52yCqB6Za2ci8DV8pYp9TCKDUL0pCkpHYZLaY9enfC4A5LHCCvh8SibOGebxpCdfsSnXd3jRBiXOhp/e5sfbm3/3iaCM2qrIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZaIwgjg7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ShCFCIB5; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZaIwgjg7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ShCFCIB5"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id A250D138036B;
	Thu, 10 Oct 2024 14:47:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Thu, 10 Oct 2024 14:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728586079; x=1728672479; bh=rQBWq94NCC
	gkQCXmHHf14B+VHJHJvwODTMeqNi34cvk=; b=ZaIwgjg7/+i0Qoa0vJBfayZBOh
	7254ZYONKpOMhdCn3CiQbt0fXe6Z68YxXn/b+9YX+A6kjJev1SclDTWCXTqV1xWR
	RhhqCz0LfBqX5V+RoYr7UP3KdnuS0FyE6tV/N1UN/WAmJar5YY8lWUksX+sgvoxj
	nfatqBakLrLs9sxSVGeS5WkPcK7YH6H92+FEy76dk20p4yqhwxWI3dsBd9BgUCmk
	7C4/Im+H0faD2Hs7iF1zK4Ylz8u1Z95WuqYg1PnYvl7P9Gv/lpdDwQbalUATwwPA
	crmIBmqvWusQT11jtS/+qvnTGWxvHiXPCFPIAKTUX3xP3bYt4j1PS42KJvMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728586079; x=1728672479; bh=rQBWq94NCCgkQCXmHHf14B+VHJHJ
	vwODTMeqNi34cvk=; b=ShCFCIB5SUwTs0OOS0ca4RcazGP6o/hP1R8bGl3YZIyL
	uEEinGBKHa7IDdTuvZmAxTs6i30DIA3o5ZAWeiitlpWk5Iqmb25Qwpk69yKd8klb
	VLqo92shW5RHd9aQT0rt+BW1VlrOrOAbxbzpGmuf4fIkPcRRCA508bzhN8y3+1Tm
	xQVKuHOGhhI7OWuTjnZh7z3HtQOLy7zVIqL5BFMgkHQ7J+vQegF6UJD3TpkfIbXC
	8Frg+yurwiPcSayaeAC7dW5tASPmB8Mh+bZ+e9akAK+P+0vDlN6/JQoFy0n6DrEr
	OnknVxJl2sWwJgOu9+DmcVj7LrsYHuVKwU2IqK+zvQ==
X-ME-Sender: <xms:XyEIZ2IgKMiEXFxI3bJ4_4BDdF97WfftgglWo3N3aPo6rekc0E_NeA>
    <xme:XyEIZ-Lxe2T27u5w7RysI7CZKus0bLZyNwOokfvPDJEL_pF83UdyDX2HY-6GKy_lq
    5MvNc2v6-eXA3wlVw>
X-ME-Received: <xmr:XyEIZ2thzxOowLsSIUBkxQabiJWdnerVZAH7eHIf1GEu5KPaYgVQ7lB-JBq5s94SJs4Z9hr2hFKDHKpo49k_09cPWtLZkg7iik3L74I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefiedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:XyEIZ7YIWp6ng-rX8q7pngcjeIQ31-flWVM0WbV4xlw5bfhKQ884fA>
    <xmx:XyEIZ9b9NGh1D6gL23FQBZtRL4CBba3PNG1qMi2xTnaac36IyLFqFw>
    <xmx:XyEIZ3D0zBDFlGGgk2ygX89idHfbqNRWcmg5q4dyeMGaTX8caELUmw>
    <xmx:XyEIZzZFvjRZbQqa97TJXRdzxaRN-LKlZnITAkI2srV_AFp30cXl9w>
    <xmx:XyEIZ8UEQ9kO60DYy8-b36AIixTGvR1CP9aV8XaX5tThT-7zDivNPw3P>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 14:47:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2] bundle-uri: plug leak in unbundle_from_file()
In-Reply-To: <ZwfOsoC35x-wyn7S@pks.im> (Patrick Steinhardt's message of "Thu,
	10 Oct 2024 14:55:14 +0200")
References: <20240826083052.1542228-1-toon@iotcl.com>
	<20241010091249.1895960-1-toon@iotcl.com> <ZwfOsoC35x-wyn7S@pks.im>
Date: Thu, 10 Oct 2024 11:47:57 -0700
Message-ID: <xmqq8quvlrqa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Oct 10, 2024 at 11:12:49AM +0200, Toon Claes wrote:
>> The function `unbundle_from_file()` has two memory leaks:
>> 
>>   - We do not release the `struct bundle_header header` when hitting
>>     errors because we return early without any cleanup.
>> 
>>   - We do not release the `struct strbuf bundle_ref` at all.
>> 
>> Plug these leaks by creating a common exit path where both of these
>> variables are released.
>> 
>> While at it, refactor the code such that the variable assignments do not
>> happen inside the conditional statement itself according to our coding
>> style.
>
> Thanks, this version looks good to me. We now avoid any discussion
> around the changed error code completely, and the commit message seems
> reasonable to me.
>
> Thanks!
>
> Patrick

Thanks, both of you.

Will queue.
