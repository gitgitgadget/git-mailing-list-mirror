Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E58439FE5
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 05:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723615130; cv=none; b=OwRQc+kKEK4csu/ius54+52oVqvXdLciCbikCrGenwDabg2Hl0op9njCC4GJ87lxJE47cIFGFJDtqKG4BRprtBnTwa3ISz1pLHYbdBz75HmVbpxLWIJ9UPaRI75+b+uxxFStAdRssgR6U1HVsLGSeRTYNraQPg3NT3mfMViIYPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723615130; c=relaxed/simple;
	bh=9K7Qb9YvZmBTV4loR55sdYk6Vz9UfJlwy6z6MarZYhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYv64r3qqhS8PzrBnhdwZhVTJr+B/+IMLT2uz8wHrsQM36ofCUlakLxb/LZmZ4/GpLEkI6rY+l0HVhf2zHJiEmKqQzunjEADR3OpPw49nk/TEvY1mQPHPFGdgMNG4s5GSk/Xdi/QvcgSC8rJtJMpkBAnpmLUSuBJSzIYAIASwsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XGg56iTZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qpWLQWXc; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XGg56iTZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qpWLQWXc"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 34C39138FC6F;
	Wed, 14 Aug 2024 01:58:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 14 Aug 2024 01:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723615127; x=1723701527; bh=dZyuvPzLF7
	W3mfKDgfkzUosmVdytld2lI12ksHqNJgM=; b=XGg56iTZGHiXSaYVarlh5cT8wf
	wOg0XEVx8glKT2EmTF4qADsGnPkZA8FOiyPfc3itsZ5LxvvrGNWEFgBrwEO9HBDW
	xJ5c9E+nIsOBpvGtIdM/kAk5u02FpczrF8ZQXB9Qn+odLLRnH1zQkdY8cSYQMV2c
	jUTVsAbdAYh3mQSpckSXrljtDKhsXvCvRTxUC7Nsxk76grvwfN8Z6cA3y2or6eq0
	7VC990LKKYEMQM9EL2+bqjOm7pTGR+NdE2dBWXOiJ8oUj3NHYjdBLGWDssJLmtkQ
	SOXxniDV7BIBf859QqIUuOyqzgyMXLY7uQ3/4Zt0bL+ANExLctgqVA/XnDsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723615127; x=1723701527; bh=dZyuvPzLF7W3mfKDgfkzUosmVdyt
	ld2lI12ksHqNJgM=; b=qpWLQWXcvsUdEh14YdQh3C2KgfZ1p9+v3vXmrpzA8HOU
	sZR7b4vqfPoBqRRC0VT+hG/r2ruQbaAaO6c5n5imNhwfAT8NCKIqCI4nh8bZQqrb
	L2MeHL7AoMn62qO/YnFy/C0lpreIKex96dn6CT2xJ0pFyiK8D7lADD8Wvba68wtH
	8sqNDCtf2yHvCwFN5WXxSWng0uH7C9rHPJAQoa+JtEAlQpZkqi+7LfEbu9G42ypO
	gInL3KFjnoQwLvv06RWVpUO5GBJrHylsOy5wBeXWjc7jwBokcSx7XwHq4uwFFk+E
	z8Dswq3FkSKCiT1KMTWhDwEHca8D3ljU2GnqjAWJvA==
X-ME-Sender: <xms:lke8ZhXtRNCOT4rZR3dCU_yKao9D9A2fxIEx19i0C26PuXPa_iseqg>
    <xme:lke8Zhnsq6fO7ONQJu2-_Ecs5o2JjGcqpG_iqa-oonSu7dp9VzuA3THM_-XFaUtb1
    ffAvr7N6Nfzxg4SPQ>
X-ME-Received: <xmr:lke8ZtZUvibl_u9rJp8UYG8Er-tyB0cXHzAB7cma1R_GgSnA0qAWD_cZ1i455bwH4rATHe1NhYaL7ZARdi_D4oBg-8qGOoFFmJKALSjeOHoaRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtfedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpefhiefgvdffvddtuefhlefgleehgfefveeuteffudfg
    heetgfevlefhueeuveeuvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplh
    drshdrrhesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehrshgsvggtkhgv
    rhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthhopehsthgvrggumhhonhesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhs
    ohhnrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhk
X-ME-Proxy: <xmx:lke8ZkXPbY1cqW5SjhRSLcXZ--8bKd45yeWiKdwktpJDsFFDuXw9IQ>
    <xmx:lke8ZrkC2QUW2bC_cBBxf0XSMY7ykXp7RdIwQlDMdOtuicYcuHY2jA>
    <xmx:lke8Zhf7SucZ3qQ_rkNfZAB4OF7s9Pj0j2z96iDMV03qdCkfkZSUIw>
    <xmx:lke8ZlEkVbZCejHuvH59vkG1A84fMPO3aHiSWgQiCf8hbelELCh8qg>
    <xmx:l0e8Zt4epDv7hJ8EMa6T2Ss3O6gEIMS1CF9BJOt6Jb-p1lnC-YqJEsSa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 01:58:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4c2f61fc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 05:58:25 +0000 (UTC)
Date: Wed, 14 Aug 2024 07:58:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [RFC PATCH v3 3/7] t/clar: fix whitespace errors
Message-ID: <ZrxHkQxgq9VqF3V1@tanuki>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1723095269.git.ps@pks.im>
 <35682b7686e570a96a8432f6b8af1996ab8d748e.1723095269.git.ps@pks.im>
 <xmqqv8048mx2.fsf@gitster.g>
 <xmqqcymc40kf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcymc40kf.fsf@gitster.g>

On Tue, Aug 13, 2024 at 01:42:08PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> >> Fix whitespace errors in the clar that make git-apply(1) unhappy. This
> >> has been cherry-picked from the upstream pull request at [1].
> >>
> >> [1]: https://github.com/clar-test/clar/pull/97
> >>
> >> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> >> ---
> >>  t/unit-tests/clar/clar/sandbox.h  | 5 ++---
> >>  t/unit-tests/clar/generate.py     | 1 -
> >>  t/unit-tests/clar/test/.gitignore | 1 -
> >>  3 files changed, 2 insertions(+), 5 deletions(-)
> >
> > A funny thing about this step is that the copy I carried for the
> > past few days was an empty patch, because out of habit I use the
> > "--whitespace=fix" option while running "git am".  As that fixes
> > the whitespace breakage this step addresses while applying the
> > previous step, this one becomes empty.
> >
> > I'll requeue these patches with --whitespace=warn instead.
> 
> Oops, it turns out that this is insufficient.  I'll add the
> following as a separate patch immediately after this step.
> 
> Thanks.
> 
>  t/unit-tests/clar/clar/fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git c/t/unit-tests/clar/clar/fs.h w/t/unit-tests/clar/clar/fs.h
> index a6eda5e5dc..3e39890bd3 100644
> --- c/t/unit-tests/clar/clar/fs.h
> +++ w/t/unit-tests/clar/clar/fs.h
> @@ -146,7 +146,7 @@ fs_rm_wait(WCHAR *_wpath)
>  			ERROR_PATH_NOT_FOUND == last_error)
>  			return 0;
>  
> -		Sleep(RM_RETRY_DELAY * retries * retries);	
> +		Sleep(RM_RETRY_DELAY * retries * retries);
>  	}
>  	while (retries++ <= RM_RETRY_COUNT);

Ah, didn't notice that one, thanks. I've also updated the upstream pull
request accordingly.

Patrick
