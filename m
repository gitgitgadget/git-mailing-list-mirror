Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F16265609
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744634058; cv=none; b=PZXGciRUiNDdD1Qxk9FGx+O8FWr/Nk4lkXbaHaYFO57JlqiqGUuA+ZM0T0w6QGpA1WIxItW0Us7NajjrXacaMajyzvlltoEkVE88jP3sd/NyDIYwm4/5KaFl1tY6yVunOUyaADX/Hr4nFNG9FXKFK1DtcozvZ9k/VFiiX9v/z3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744634058; c=relaxed/simple;
	bh=II6IdYFyC+tbO4sgF3qmqisqMGIOxKUeXc9w++tioR0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pw78zvs8egO4pAZixCR2xAjsWm5UCkEktl0j0HIbpULroiVhzQWOPJ7QLMi4ys9mvA3QL3UmeoPqNuEfH50RwOcWKcRt+CiascRCZzR0ejNcuOGWmOr2xDWlVDHkhuDLe4YOhDIPxluG4JVNIvyyJw5LxZbPSbbeigc4mgRww08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LYNffV1T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hj1YNqlE; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LYNffV1T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hj1YNqlE"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id C02851140128;
	Mon, 14 Apr 2025 08:34:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 14 Apr 2025 08:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744634053; x=1744720453; bh=gM4gqTDvIf
	q9dhpc8uV1ZhGujvpjyRt2sR+j8Vk2eIg=; b=LYNffV1TpCeM5z36VrgL8B/rot
	/94hj4XPBkO+/5J6pwx7xR+pmvQU91R0qrebm/hp0eMXnb3ynb54fKNrb/p0B+OA
	CXVJ5V+AhPDLoZ/mqq3+Fziv10bxweO3JVwAABobLTFXD3jr/+MSHnbw5FJJYuzb
	OGsc/U5MtKcm0spDz+mvBvJlJ73FaDcW9tII9+fehrwCywefjmZPHOa424WGx0yy
	sFkGcjZFBaUqfI6sVyH7mA+RzHFS9tPzJo+0SkkXp30ZTH6Kg5zDOIDhSs6jfiRO
	kyuhwuOAS1DYi9Bd8N3KsycbtpF1pJ9OuIOIO7c+AOw/6v9lQ1/hbfM/CPIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744634053; x=1744720453; bh=gM4gqTDvIfq9dhpc8uV1ZhGujvpjyRt2sR+
	j8Vk2eIg=; b=Hj1YNqlEtwDWC9zEJe8Iz3EY/yjfLjkW9Y3Z9/YWWZIcXz5c899
	r2gvg/xElLAgfbKBUYs9VCyX/gSGk8aeBBM1+Gef5jdERrfn/koC4IeDJKxHGAiH
	6mfTNHjqK2GnahFn6r9jbOws+INigrYtgqqiaMSUR1CXN6Wexxa6Z1M46J4M9MG5
	Zpe1N2CE3UKOgd1If68bXdfwcDb+BEQP7J50L9/nx0BbyVDq3+kiE4gJAgeJYI9o
	CpSgBXri3hpB3jhDHGqHIpyWYzHASMJkvJERt3sRSZhzt3Ewe+Lnqtby68IvdqDH
	z7h3bedpTA1Cxgu0amez03ov9oK+eU+xfGw==
X-ME-Sender: <xms:xQD9Z8m1A3r5J8W0mQ9RosKAELNS4gMw4CEx_cWLBvIlVnOgqIj3zw>
    <xme:xQD9Z70YKXQsrkPJ6OKrsTfR0jadAhPfCfWxaREezpFpFarYAFgR8DeOgIrWn9Rpc
    FpzM6l3bSbZwmLrbg>
X-ME-Received: <xmr:xQD9Z6quVQ2QI6DkwwyAfuIRdMO5e9izae56W0VgaSsxIGpstHK5dsyvvbmgqGcK_863aLwUZS0G1ndj5l3_x9Rk-yR3j3Cgic8I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddtheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xQD9Z4mGA14Xruud8gvP0EO_QCeVHWWetX2U03R1soy0loGsZ2UY5w>
    <xmx:xQD9Z60i70KJFtrv1Eic3WyEaRWeiX8o6wSkQX2wXv4NrdR5AZfoZg>
    <xmx:xQD9Z_vNW9ehIljz8f_cj8b2TqchzwkU1vZJnmlUnvGVv_IOjUkMwA>
    <xmx:xQD9Z2XHJy1LhVt53bvCq3ggyipcST8xtefcAykkMwSKjfuIEcW2-Q>
    <xmx:xQD9Z4Qo4ysQdKakm8MKfA9xeUEYMt3XOJeRw-JRm1WfZbqOkSOSRCS->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 08:34:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: ds/path-walk-2 (was Re: What's cooking in git.git (Apr 2025,
 #03; Fri, 11))
In-Reply-To: <7c2b338f-f795-4957-aac3-20e6dd5b5f48@gmail.com> (Derrick
	Stolee's message of "Mon, 14 Apr 2025 07:03:10 -0400")
References: <xmqqmscml2zq.fsf@gitster.g>
	<7c2b338f-f795-4957-aac3-20e6dd5b5f48@gmail.com>
Date: Mon, 14 Apr 2025 05:34:11 -0700
Message-ID: <xmqqo6wysz0c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 4/11/2025 6:58 PM, Junio C Hamano wrote:
>
>> * ds/path-walk-2 (2025-03-25) 13 commits
>>  - pack-objects: allow --shallow and --path-walk
>>  - path-walk: add new 'edge_aggressive' option
>>  - pack-objects: thread the path-based compression
>>  - pack-objects: refactor path-walk delta phase
>>  - scalar: enable path-walk during push via config
>>  - pack-objects: enable --path-walk via config
>>  - repack: add --path-walk option
>>  - t5538: add tests to confirm deltas in shallow pushes
>>  - pack-objects: introduce GIT_TEST_PACK_PATH_WALK
>>  - p5313: add performance tests for --path-walk
>>  - pack-objects: update usage to match docs
>>  - pack-objects: add --path-walk option
>>  - pack-objects: extract should_attempt_deltas()
>> 
>>  "git pack-objects" learns to find delta bases from blobs at the
>>  same path, using the --path-walk API.
>> 
>>  Comments?
>>  source: <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
> The current version (v2) has not received any comments yet. v1 had
> some, which I responded to, as well as some exploration of the use
> of --window by Taylor. I haven't heard anything since then.

Right.  I do not recall seeing anybody doing a deep dive, which I
would prefer to see done in the code paths involved.  At least I'd
want to see somebody (could be me) verify that the changes would not
break when the new option is not in effect before merging it.

> I continue to get user reports of folks using this feature in Git
> for Windows or microsoft/git, so I still think this would be a
> valuable improvement for the core project.

Oh, no quiestion about that part.  Otherwise we wouldn't be listing
the topic in this list ;-).  I just want to see support not just by
the end-users who do not know or care how the thing looks internally,
but also by the folks around here who do.

Thanks.
